/**
 * Autogenerated by Thrift
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 */
#include "ping_types.h"

namespace com { namespace renren { namespace ad { namespace ping {

const char* StatEntry::ascii_fingerprint = "586B4437A9C08F6ED05229F35390ABDA";
const uint8_t StatEntry::binary_fingerprint[16] = {0x58,0x6B,0x44,0x37,0xA9,0xC0,0x8F,0x6E,0xD0,0x52,0x29,0xF3,0x53,0x90,0xAB,0xDA};

uint32_t StatEntry::read(::apache::thrift::protocol::TProtocol* iprot) {

  uint32_t xfer = 0;
  std::string fname;
  ::apache::thrift::protocol::TType ftype;
  int16_t fid;

  xfer += iprot->readStructBegin(fname);

  using ::apache::thrift::protocol::TProtocolException;


  while (true)
  {
    xfer += iprot->readFieldBegin(fname, ftype, fid);
    if (ftype == ::apache::thrift::protocol::T_STOP) {
      break;
    }
    switch (fid)
    {
      case 1:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->serviceName);
          this->__isset.serviceName = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 2:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->node);
          this->__isset.node = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 3:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->tag);
          this->__isset.tag = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 4:
        if (ftype == ::apache::thrift::protocol::T_I64) {
          xfer += iprot->readI64(this->cnt);
          this->__isset.cnt = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 5:
        if (ftype == ::apache::thrift::protocol::T_I64) {
          xfer += iprot->readI64(this->sum);
          this->__isset.sum = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 6:
        if (ftype == ::apache::thrift::protocol::T_I64) {
          xfer += iprot->readI64(this->max);
          this->__isset.max = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 7:
        if (ftype == ::apache::thrift::protocol::T_I64) {
          xfer += iprot->readI64(this->min);
          this->__isset.min = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 8:
        if (ftype == ::apache::thrift::protocol::T_I64) {
          xfer += iprot->readI64(this->dayCnt);
          this->__isset.dayCnt = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 9:
        if (ftype == ::apache::thrift::protocol::T_I64) {
          xfer += iprot->readI64(this->daySum);
          this->__isset.daySum = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 10:
        if (ftype == ::apache::thrift::protocol::T_I64) {
          xfer += iprot->readI64(this->dayMax);
          this->__isset.dayMax = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 11:
        if (ftype == ::apache::thrift::protocol::T_I64) {
          xfer += iprot->readI64(this->dayMin);
          this->__isset.dayMin = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 12:
        if (ftype == ::apache::thrift::protocol::T_I64) {
          xfer += iprot->readI64(this->performance99);
          this->__isset.performance99 = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      default:
        xfer += iprot->skip(ftype);
        break;
    }
    xfer += iprot->readFieldEnd();
  }

  xfer += iprot->readStructEnd();

  return xfer;
}

uint32_t StatEntry::write(::apache::thrift::protocol::TProtocol* oprot) const {
  uint32_t xfer = 0;
  xfer += oprot->writeStructBegin("StatEntry");
  xfer += oprot->writeFieldBegin("serviceName", ::apache::thrift::protocol::T_STRING, 1);
  xfer += oprot->writeString(this->serviceName);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("node", ::apache::thrift::protocol::T_STRING, 2);
  xfer += oprot->writeString(this->node);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("tag", ::apache::thrift::protocol::T_STRING, 3);
  xfer += oprot->writeString(this->tag);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("cnt", ::apache::thrift::protocol::T_I64, 4);
  xfer += oprot->writeI64(this->cnt);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("sum", ::apache::thrift::protocol::T_I64, 5);
  xfer += oprot->writeI64(this->sum);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("max", ::apache::thrift::protocol::T_I64, 6);
  xfer += oprot->writeI64(this->max);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("min", ::apache::thrift::protocol::T_I64, 7);
  xfer += oprot->writeI64(this->min);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("dayCnt", ::apache::thrift::protocol::T_I64, 8);
  xfer += oprot->writeI64(this->dayCnt);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("daySum", ::apache::thrift::protocol::T_I64, 9);
  xfer += oprot->writeI64(this->daySum);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("dayMax", ::apache::thrift::protocol::T_I64, 10);
  xfer += oprot->writeI64(this->dayMax);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("dayMin", ::apache::thrift::protocol::T_I64, 11);
  xfer += oprot->writeI64(this->dayMin);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldBegin("performance99", ::apache::thrift::protocol::T_I64, 12);
  xfer += oprot->writeI64(this->performance99);
  xfer += oprot->writeFieldEnd();
  xfer += oprot->writeFieldStop();
  xfer += oprot->writeStructEnd();
  return xfer;
}

}}}} // namespace
