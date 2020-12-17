Content-Type: multipart/mixed; boundary="===============2032452613584136523=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: convert IPv4
 address to IPv4-mapped
Date: Fri, 18 Dec 2020 00:06:51 +0100
Message-ID: <d3cbdcc0-4471-7a4d-1b1e-d69be80d231c@tessares.net>
In-Reply-To: f4a83eea-4bb0-87db-c05f-225b2a1f52fe@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7208

--===============2032452613584136523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 17/12/2020 01:23, Mat Martineau wrote:
> On Wed, 16 Dec 2020, Geliang Tang wrote:
> =

>> Currently, PM doesn't create subflow with IPv4-mapped IPv6 socket. This
>> patch converts the IPv4 address to IPv4-mapped IPv6 address to fix it.
>>
>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>> ---
>> net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
>> 1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index cc4ca013a06b..987e83cdee11 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -145,6 +158,8 @@ select_local_address(const struct pm_nl_pernet =

>> *pernet,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(entry->addr.flags & MPT=
CP_PM_ADDR_FLAG_SUBFLOW))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_pm_addr_convert_v4mapp=
ed(msk, &entry->addr);
>> +
> =

> This is modifying the contents of pernet->local_addr_list, not a copy of =

> the entry, when the msk has a v4mapped address. I'm not sure that's the =

> way to fix this, and might leave some corner cases unaddressed.
> =

> Did you look at modifying addresses_equal() so it can detect equivalent =

> IPv4 and v4mapped addresses?

Maybe something like that the patch I joined?

I didn't try much but maybe more what we want?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

--===============2032452613584136523==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-support-v4mappedv6.patch"

RnJvbSAzNmY1ZTFmOWJhZGU1MzI5ZTgyYTg1ZmI2MzMwZGI1N2ExNjVjMDRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXR0aGlldSBCYWVydHMgPG1hdHRoaWV1LmJhZXJ0c0B0ZXNz
YXJlcy5uZXQ+CkRhdGU6IEZyaSwgMTggRGVjIDIwMjAgMDA6MDM6MTIgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBtcHRjcDogc3VwcG9ydCB2NG1hcHBlZHY2CgpTaWduZWQtb2ZmLWJ5OiBNYXR0aGll
dSBCYWVydHMgPG1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ+Ci0tLQogbmV0L21wdGNwL3Bt
X25ldGxpbmsuYyB8IDIyICsrKysrKysrKysrKystLS0tLS0tLS0KIG5ldC9tcHRjcC9zdWJmbG93
LmMgICAgfCAxNyArKysrKysrKysrKy0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRp
b25zKCspLCAxNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvbXB0Y3AvcG1fbmV0bGlu
ay5jIGIvbmV0L21wdGNwL3BtX25ldGxpbmsuYwppbmRleCA5YjFmNjI5OGJiZGIuLjZjODlhOWUw
MDk5YiAxMDA2NDQKLS0tIGEvbmV0L21wdGNwL3BtX25ldGxpbmsuYworKysgYi9uZXQvbXB0Y3Av
cG1fbmV0bGluay5jCkBAIC02MCwxNSArNjAsMjAgQEAgc3RhdGljIGJvb2wgYWRkcmVzc2VzX2Vx
dWFsKGNvbnN0IHN0cnVjdCBtcHRjcF9hZGRyX2luZm8gKmEsCiB7CiAJYm9vbCBhZGRyX2VxdWFs
cyA9IGZhbHNlOwogCi0JaWYgKGEtPmZhbWlseSAhPSBiLT5mYW1pbHkpCi0JCXJldHVybiBmYWxz
ZTsKLQotCWlmIChhLT5mYW1pbHkgPT0gQUZfSU5FVCkKLQkJYWRkcl9lcXVhbHMgPSBhLT5hZGRy
LnNfYWRkciA9PSBiLT5hZGRyLnNfYWRkcjsKKwlpZiAoYS0+ZmFtaWx5ID09IGItPmZhbWlseSkg
eworCQlpZiAoYS0+ZmFtaWx5ID09IEFGX0lORVQpCisJCQlhZGRyX2VxdWFscyA9IGEtPmFkZHIu
c19hZGRyID09IGItPmFkZHIuc19hZGRyOwogI2lmIElTX0VOQUJMRUQoQ09ORklHX01QVENQX0lQ
VjYpCi0JZWxzZQotCQlhZGRyX2VxdWFscyA9ICFpcHY2X2FkZHJfY21wKCZhLT5hZGRyNiwgJmIt
PmFkZHI2KTsKKwkJZWxzZQorCQkJYWRkcl9lcXVhbHMgPSAhaXB2Nl9hZGRyX2NtcCgmYS0+YWRk
cjYsICZiLT5hZGRyNik7CisJfSBlbHNlIGlmIChhLT5mYW1pbHkgPT0gQUZfSU5FVDYpIHsKKwkJ
aWYgKGItPmZhbWlseSA9PSBBRl9JTkVUICYmIGlwdjZfYWRkcl92NG1hcHBlZCgmYS0+YWRkcjYp
KQorCQkJYWRkcl9lcXVhbHMgPSBhLT5hZGRyNi5zNl9hZGRyMzJbM10gPT0gYi0+YWRkci5zX2Fk
ZHI7CisJfSBlbHNlIGlmIChiLT5mYW1pbHkgPT0gQUZfSU5FVDYpIHsKKwkJaWYgKGEtPmZhbWls
eSA9PSBBRl9JTkVUICYmIGlwdjZfYWRkcl92NG1hcHBlZCgmYi0+YWRkcjYpKQorCQkJYWRkcl9l
cXVhbHMgPSBhLT5hZGRyLnNfYWRkciA9PSBiLT5hZGRyNi5zNl9hZGRyMzJbM107CiAjZW5kaWYK
Kwl9CiAKIAlpZiAoIWFkZHJfZXF1YWxzKQogCQlyZXR1cm4gZmFsc2U7CkBAIC0xNDcsOCArMTUy
LDcgQEAgc2VsZWN0X2xvY2FsX2FkZHJlc3MoY29uc3Qgc3RydWN0IHBtX25sX3Blcm5ldCAqcGVy
bmV0LAogCQkvKiBhdm9pZCBhbnkgYWRkcmVzcyBhbHJlYWR5IGluIHVzZSBieSBzdWJmbG93cyBh
bmQKIAkJICogcGVuZGluZyBqb2luCiAJCSAqLwotCQlpZiAoZW50cnktPmFkZHIuZmFtaWx5ID09
ICgoc3RydWN0IHNvY2sgKiltc2spLT5za19mYW1pbHkgJiYKLQkJICAgICFsb29rdXBfc3ViZmxv
d19ieV9zYWRkcigmbXNrLT5jb25uX2xpc3QsICZlbnRyeS0+YWRkcikpIHsKKwkJaWYgKCFsb29r
dXBfc3ViZmxvd19ieV9zYWRkcigmbXNrLT5jb25uX2xpc3QsICZlbnRyeS0+YWRkcikpIHsKIAkJ
CXJldCA9IGVudHJ5OwogCQkJYnJlYWs7CiAJCX0KZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9zdWJm
bG93LmMgYi9uZXQvbXB0Y3Avc3ViZmxvdy5jCmluZGV4IDI3OGNiZTNlNTM5ZS4uMTFjYzBlZjNh
ZTNjIDEwMDY0NAotLS0gYS9uZXQvbXB0Y3Avc3ViZmxvdy5jCisrKyBiL25ldC9tcHRjcC9zdWJm
bG93LmMKQEAgLTEwNzQsMTAgKzEwNzQsMTEgQEAgdm9pZCBtcHRjcHY2X2hhbmRsZV9tYXBwZWQo
c3RydWN0IHNvY2sgKnNrLCBib29sIG1hcHBlZCkKICNlbmRpZgogCiBzdGF0aWMgdm9pZCBtcHRj
cF9pbmZvMnNvY2thZGRyKGNvbnN0IHN0cnVjdCBtcHRjcF9hZGRyX2luZm8gKmluZm8sCi0JCQkJ
c3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKmFkZHIpCisJCQkJc3RydWN0IHNvY2thZGRyX3N0b3Jh
Z2UgKmFkZHIsCisJCQkJdW5zaWduZWQgc2hvcnQgZmFtaWx5KQogewogCW1lbXNldChhZGRyLCAw
LCBzaXplb2YoKmFkZHIpKTsKLQlhZGRyLT5zc19mYW1pbHkgPSBpbmZvLT5mYW1pbHk7CisJYWRk
ci0+c3NfZmFtaWx5ID0gZmFtaWx5OwogCWlmIChhZGRyLT5zc19mYW1pbHkgPT0gQUZfSU5FVCkg
ewogCQlzdHJ1Y3Qgc29ja2FkZHJfaW4gKmluX2FkZHIgPSAoc3RydWN0IHNvY2thZGRyX2luICop
YWRkcjsKIApAQCAtMTA4OCw3ICsxMDg5LDExIEBAIHN0YXRpYyB2b2lkIG1wdGNwX2luZm8yc29j
a2FkZHIoY29uc3Qgc3RydWN0IG1wdGNwX2FkZHJfaW5mbyAqaW5mbywKIAllbHNlIGlmIChhZGRy
LT5zc19mYW1pbHkgPT0gQUZfSU5FVDYpIHsKIAkJc3RydWN0IHNvY2thZGRyX2luNiAqaW42X2Fk
ZHIgPSAoc3RydWN0IHNvY2thZGRyX2luNiAqKWFkZHI7CiAKLQkJaW42X2FkZHItPnNpbjZfYWRk
ciA9IGluZm8tPmFkZHI2OworCQlpZiAoaW5mby0+ZmFtaWx5ID09IEFGX0lORVQpCisJCQlpcHY2
X2FkZHJfc2V0X3Y0bWFwcGVkKGluZm8tPmFkZHIuc19hZGRyLAorCQkJCQkgICAgICAgJmluNl9h
ZGRyLT5zaW42X2FkZHIpOworCQllbHNlCisJCQlpbjZfYWRkci0+c2luNl9hZGRyID0gaW5mby0+
YWRkcjY7CiAJCWluNl9hZGRyLT5zaW42X3BvcnQgPSBpbmZvLT5wb3J0OwogCX0KICNlbmRpZgpA
QCAtMTEzMiwxMSArMTEzNywxMSBAQCBpbnQgX19tcHRjcF9zdWJmbG93X2Nvbm5lY3Qoc3RydWN0
IHNvY2sgKnNrLCBjb25zdCBzdHJ1Y3QgbXB0Y3BfYWRkcl9pbmZvICpsb2MsCiAJc3ViZmxvdy0+
cmVtb3RlX2tleSA9IG1zay0+cmVtb3RlX2tleTsKIAlzdWJmbG93LT5sb2NhbF9rZXkgPSBtc2st
PmxvY2FsX2tleTsKIAlzdWJmbG93LT50b2tlbiA9IG1zay0+dG9rZW47Ci0JbXB0Y3BfaW5mbzJz
b2NrYWRkcihsb2MsICZhZGRyKTsKKwltcHRjcF9pbmZvMnNvY2thZGRyKGxvYywgJmFkZHIsIHNz
ay0+c2tfZmFtaWx5KTsKIAogCWFkZHJsZW4gPSBzaXplb2Yoc3RydWN0IHNvY2thZGRyX2luKTsK
ICNpZiBJU19FTkFCTEVEKENPTkZJR19NUFRDUF9JUFY2KQotCWlmIChsb2MtPmZhbWlseSA9PSBB
Rl9JTkVUNikKKwlpZiAoYWRkci5zc19mYW1pbHkgPT0gQUZfSU5FVDYpCiAJCWFkZHJsZW4gPSBz
aXplb2Yoc3RydWN0IHNvY2thZGRyX2luNik7CiAjZW5kaWYKIAlzc2stPnNrX2JvdW5kX2Rldl9p
ZiA9IGxvYy0+aWZpbmRleDsKQEAgLTExNTIsNyArMTE1Nyw3IEBAIGludCBfX21wdGNwX3N1YmZs
b3dfY29ubmVjdChzdHJ1Y3Qgc29jayAqc2ssIGNvbnN0IHN0cnVjdCBtcHRjcF9hZGRyX2luZm8g
KmxvYywKIAlzdWJmbG93LT5yZW1vdGVfaWQgPSByZW1vdGVfaWQ7CiAJc3ViZmxvdy0+cmVxdWVz
dF9qb2luID0gMTsKIAlzdWJmbG93LT5yZXF1ZXN0X2JrdXAgPSAhIShsb2MtPmZsYWdzICYgTVBU
Q1BfUE1fQUREUl9GTEFHX0JBQ0tVUCk7Ci0JbXB0Y3BfaW5mbzJzb2NrYWRkcihyZW1vdGUsICZh
ZGRyKTsKKwltcHRjcF9pbmZvMnNvY2thZGRyKHJlbW90ZSwgJmFkZHIsIHNzay0+c2tfZmFtaWx5
KTsKIAogCW1wdGNwX2FkZF9wZW5kaW5nX3N1YmZsb3cobXNrLCBzdWJmbG93KTsKIAllcnIgPSBr
ZXJuZWxfY29ubmVjdChzZiwgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyLCBhZGRybGVuLCBPX05P
TkJMT0NLKTsKLS0gCjIuMjkuMgoK

--===============2032452613584136523==--
