/**
 * 测试目的：测试UserNameAdapter的功能
 * 测试环境：在服务端UserBaseReader/UserBaseWriter服务各启动一份
 * 通过标准：Get/DB的数据一致；Create/Get/DB的数据一致；Set/Get/DB的数据一致
 * 
 * @author 梁小锋(xiaofeng.liang@renren-inc.com)
 *
 */
package com.xiaonei.xce.test.userbase;

import com.xiaonei.xce.username.UserNameAdapter;

import java.util.Arrays;
import java.util.Collection;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import junit.framework.Assert;

import com.xiaonei.xce.XceAdapter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@RunWith(Parameterized.class)
public class UserNameTestCase {
	private static int testCount = 0;
	private final static String DB_NAME = "user_names";
	private final static String TABLE_NAME = "user_names";
	private final MUserNameInfo _info;
	private MUserNameFactory _factory;
	private UserNameAdapter<MUserNameInfo> _adapter;

	public UserNameTestCase(int id, String name, String nickname) {
		_factory = new MUserNameFactory();
		_adapter = new UserNameAdapter<MUserNameInfo>(_factory);
		_info = _factory.create();
		
		_info.setId(id);
		_info.setName(name);
		_info.setNickname(nickname);
	}

	/**
	 * 获取一份新的数据
	 * 
	 * @param step 改变数据的增量，没实在意义，只为了得到不同的数据
	 */
	protected MUserNameInfo genInfoCopy(int intStep, String strStep) {
		MUserNameInfo result = _factory.create();

		result.setId(_info.getId());
		result.setName(_info.getName() + strStep);
		result.setNickname(_info.getNickname() + strStep);

		return result;
	}

	@Parameters
	public static Collection<Object[]> setParameters() {
		return Arrays.asList(new Object[][] {
				{ 800004444, "name", "nickname" },		
			});
	}

	@Before
	public void setUpBefore() throws Exception {
		System.out.println(++testCount + " : setUpBefore() ");
		System.out.println("================================");

	}

	@After
	public void tearDownAfter() throws Exception {
		
	}
	
	/**
	 * 本条测试同时测试get和create方法
	 * get和create方法是测试缓存是否正确的依赖条件
	 * 由于没有reload方法，所以用create方法来控制
	 */
	@Test
	public void testBase() {
		MUserNameInfo info = genInfoCopy(0, "");
		cleanDBByUserId(info.getId());	
		try {
			_adapter.createUserName(info.getId(), info);
		} catch (Ice.UnknownException e) {
			//测试环境没有UserLogic服务，会抛异常
			System.out.println(e.toString());
		}

		Assert.assertTrue(isCacheCorrect(info));
	}
	
	@Test
	public void testSetUserName() {
		MUserNameInfo info = genInfoCopy(0, "");
		cleanDBByUserId(info.getId());	
		try {
			_adapter.createUserName(info.getId(), info);
		} catch (Ice.UnknownException e) {
			System.out.println(e.toString());
		}
		
		MUserNameInfo infoSet = genInfoCopy(1, "-set");
		try {
			_adapter.setUserName(infoSet.getId(), infoSet);
		} catch (Ice.UnknownException e) {
			System.out.println(e.toString());
		}
		Assert.assertTrue(isDBCorrect(infoSet));
		Assert.assertTrue(isCacheCorrect(infoSet));
	}
	
	/**
	 * 以info作为标准，判断DB数据是否正确
	 * 
	 * @param info
	 * @return
	 */
	protected boolean isDBCorrect(MUserNameInfo info) {
		System.out.println("\ninfo:");
		System.out.println("--------------------------------");
		System.out.println(info);
		
		MUserNameInfo infoOfDB = readDBByUserId(info.getId());
		
		System.out.println("\ninfoOfDB:");
		System.out.println("--------------------------------");
		System.out.println(infoOfDB);
		
		return isEqual(infoOfDB, info);
	}

	/**
	 * 以info作为标准，判断Cache数据是否正确
	 * 
	 * @param info
	 * @return
	 */
	protected boolean isCacheCorrect(MUserNameInfo info) {
		System.out.println("\ninfo:");
		System.out.println("--------------------------------");
		System.out.println(info);
		
		MUserNameInfo infoOfCache = null;		
		try {
			infoOfCache = _adapter.getUserName(info.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("\ninfoOfCache:");
		System.out.println("--------------------------------");
		System.out.println(infoOfCache);
		
		return isEqual(infoOfCache, info);
	}

	protected void cleanDBByUserId(int userId) {
		String sql = "delete from " + TABLE_NAME + " where id=" + userId;
		writeDB(sql);
	}

	protected MUserNameInfo readDBByUserId(int userId) {
		String sql = "select * from " + TABLE_NAME + " where id=" + userId;
		return readDB(sql);
	}

	protected MUserNameInfo getInfo(ResultSet rs) {
		MUserNameInfo result = _factory.create();
		try {
			while (rs.next()) {
				result.setId(rs.getInt("id"));
				result.setName(rs.getString("name"));
				result.setNickname(rs.getString("nickname"));
				
				break; // 正常只有一个结果，如果有多个，只取其中的第一个
			}
		} catch (SQLException e) {
			e.printStackTrace();
			Assert.assertFalse(true);
		}
		return result;
	}

	protected MUserNameInfo readDB(String sql) {
		MUserNameInfo result = _factory.create();
		try {
			Connection c = XceAdapter.getInstance().getReadConnection(DB_NAME);
			try {
				Statement s = c.createStatement();
				try {
					ResultSet rs = s.executeQuery(sql);
					result = getInfo(rs);
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
					Assert.assertFalse(true);
				} finally {
					s.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
				Assert.assertFalse(true);
			} finally {
				c.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			Assert.assertFalse(true);
		}
		return result;
	}
	
	protected void writeDB(String sql) {
		System.out.println(sql);
		try {
			Connection c = XceAdapter.getInstance().getWriteConnection(DB_NAME);
			try {
				Statement s = c.createStatement();
				try {
					s.execute(sql);
				} catch (Exception e) {
					e.printStackTrace();
					Assert.assertFalse(true);
				} finally {
					s.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
				Assert.assertFalse(true);
			} finally {
				c.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			Assert.assertFalse(true);
		}
	}
	
	protected boolean isEqual(MUserNameInfo info1, MUserNameInfo info2) {
		return info1.toString().equals(info2.toString());
	}
}