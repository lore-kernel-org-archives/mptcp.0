Content-Type: multipart/mixed; boundary="===============7134940237905076657=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 08/10] mptcp: deal with
 MPTCP_PM_ADDR_ATTR_PORT in PM netlink
Date: Wed, 04 Nov 2020 15:22:14 +0800
Message-ID: <CA+WQbwvhnyUhr7DNB4rgMmi5Q1SJc7u8cbvyfzMeV3cenW7e8g@mail.gmail.com>
In-Reply-To: cac59bd5-e67b-351f-e043-2dfb281560ec@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6537

--===============7134940237905076657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B411=
=E6=9C=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:29=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi Geliang,
>
> On 31/10/2020 16:31, Geliang Tang wrote:
> > This patch added the MPTCP_PM_ADDR_ATTR_PORT filling and parsing in PM
> > netlink.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> >   net/mptcp/pm_netlink.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index ab0e68426c9e..069447424ddb 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -725,6 +725,9 @@ static int mptcp_pm_parse_addr(struct nlattr *attr,
> struct genl_info *info,
> >       if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
> >               entry->addr.flags =3D
> nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
> >
> > +     if (tb[MPTCP_PM_ADDR_ATTR_PORT])
> > +             entry->addr.port =3D
> htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
> > +
> >       return 0;
> >   }
> >
> > @@ -911,6 +914,8 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
> >
> >       if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_FAMILY, addr->family))
> >               goto nla_put_failure;
> > +     if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_PORT, ntohs(addr->port)))
>
> It looks strange to me to store something in "network" order. Do we not
> store everything in "host" order, no?
>
>
I think we can't. Since the 'skc_dport' in struct sock_common and the
'sin_port' in struct sockaddr_in are all defined as big-endian order. It's
simply to keep the 'port' in struct mptcp_addr_info as a big-endian order
too.

If we define mptcp_addr_info's port as a little-endian order, we can avoid
this ntohs conversion in mptcp_nl_fill_addr, but we need add more other
order conversions in other places, like:

  in mptcp_info2sockaddr:

    in_addr->sin_port =3D htons(info->port);

  in remote_address:

    addr->port =3D ntohs(skc->skc_dport);

-Geliang



> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>

--===============7134940237905076657==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgTWF0dCw8YnI+PC9kaXY+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+TWF0
dGhpZXUgQmFlcnRzICZsdDs8YSBocmVmPSJtYWlsdG86bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVz
Lm5ldCI+bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldDwvYT4mZ3Q7IOS6jjIwMjDlubQxMeac
iDTml6XlkajkuIkg5LiK5Y2IMToyOeWGmemBk++8mjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxl
ZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgR2VsaWFu
Zyw8YnI+Cjxicj4KT24gMzEvMTAvMjAyMCAxNjozMSwgR2VsaWFuZyBUYW5nIHdyb3RlOjxicj4K
Jmd0OyBUaGlzIHBhdGNoIGFkZGVkIHRoZSBNUFRDUF9QTV9BRERSX0FUVFJfUE9SVCBmaWxsaW5n
IGFuZCBwYXJzaW5nIGluIFBNPGJyPgomZ3Q7IG5ldGxpbmsuPGJyPgomZ3Q7IDxicj4KJmd0OyBT
aWduZWQtb2ZmLWJ5OiBHZWxpYW5nIFRhbmcgJmx0OzxhIGhyZWY9Im1haWx0bzpnZWxpYW5ndGFu
Z0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5nZWxpYW5ndGFuZ0BnbWFpbC5jb208L2E+Jmd0
Ozxicj4KJmd0OyAtLS08YnI+CiZndDvCoCDCoG5ldC9tcHRjcC9wbV9uZXRsaW5rLmMgfCA1ICsr
KysrPGJyPgomZ3Q7wqAgwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspPGJyPgomZ3Q7
IDxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvbmV0L21wdGNwL3BtX25ldGxpbmsuYyBiL25ldC9tcHRj
cC9wbV9uZXRsaW5rLmM8YnI+CiZndDsgaW5kZXggYWIwZTY4NDI2YzllLi4wNjk0NDc0MjRkZGIg
MTAwNjQ0PGJyPgomZ3Q7IC0tLSBhL25ldC9tcHRjcC9wbV9uZXRsaW5rLmM8YnI+CiZndDsgKysr
IGIvbmV0L21wdGNwL3BtX25ldGxpbmsuYzxicj4KJmd0OyBAQCAtNzI1LDYgKzcyNSw5IEBAIHN0
YXRpYyBpbnQgbXB0Y3BfcG1fcGFyc2VfYWRkcihzdHJ1Y3QgbmxhdHRyICphdHRyLCBzdHJ1Y3Qg
Z2VubF9pbmZvICppbmZvLDxicj4KJmd0O8KgIMKgIMKgIMKgaWYgKHRiW01QVENQX1BNX0FERFJf
QVRUUl9GTEFHU10pPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbnRyeS0mZ3Q7YWRk
ci5mbGFncyA9IG5sYV9nZXRfdTMyKHRiW01QVENQX1BNX0FERFJfQVRUUl9GTEFHU10pOzxicj4K
Jmd0O8KgIMKgPGJyPgomZ3Q7ICvCoCDCoCDCoGlmICh0YltNUFRDUF9QTV9BRERSX0FUVFJfUE9S
VF0pPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGVudHJ5LSZndDthZGRyLnBvcnQgPSBo
dG9ucyhubGFfZ2V0X3UxNih0YltNUFRDUF9QTV9BRERSX0FUVFJfUE9SVF0pKTs8YnI+CiZndDsg
Kzxicj4KJmd0O8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPgomZ3Q7wqAgwqB9PGJyPgomZ3Q7wqAg
wqA8YnI+CiZndDsgQEAgLTkxMSw2ICs5MTQsOCBAQCBzdGF0aWMgaW50IG1wdGNwX25sX2ZpbGxf
YWRkcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLDxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqAgwqAg
wqBpZiAobmxhX3B1dF91MTYoc2tiLCBNUFRDUF9QTV9BRERSX0FUVFJfRkFNSUxZLCBhZGRyLSZn
dDtmYW1pbHkpKTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBubGFfcHV0X2Zh
aWx1cmU7PGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChubGFfcHV0X3UxNihza2IsIE1QVENQX1BNX0FE
RFJfQVRUUl9QT1JULCBudG9ocyhhZGRyLSZndDtwb3J0KSkpPGJyPgo8YnI+Ckl0IGxvb2tzIHN0
cmFuZ2UgdG8gbWUgdG8gc3RvcmUgc29tZXRoaW5nIGluICZxdW90O25ldHdvcmsmcXVvdDsgb3Jk
ZXIuIERvIHdlIG5vdCA8YnI+CnN0b3JlIGV2ZXJ5dGhpbmcgaW4gJnF1b3Q7aG9zdCZxdW90OyBv
cmRlciwgbm8/PGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSB0aGlu
ayB3ZSBjYW4mIzM5O3QuIFNpbmNlIHRoZSAmIzM5O3NrY19kcG9ydCYjMzk7IGluIHN0cnVjdCBz
b2NrX2NvbW1vbiBhbmQgdGhlPGJyPiYjMzk7c2luX3BvcnQmIzM5OyBpbiBzdHJ1Y3Qgc29ja2Fk
ZHJfaW4gYXJlIGFsbCBkZWZpbmVkIGFzIGJpZy1lbmRpYW4gb3JkZXIuIEl0JiMzOTtzPGJyPnNp
bXBseSB0byBrZWVwIHRoZSAmIzM5O3BvcnQmIzM5OyBpbiBzdHJ1Y3QgbXB0Y3BfYWRkcl9pbmZv
IGFzIGEgYmlnLWVuZGlhbiBvcmRlcjxicj50b28uPGJyPjxicj5JZiB3ZSBkZWZpbmUgbXB0Y3Bf
YWRkcl9pbmZvJiMzOTtzIHBvcnQgYXMgYSBsaXR0bGUtZW5kaWFuIG9yZGVyLCB3ZSBjYW4gYXZv
aWQ8YnI+dGhpcyBudG9ocyBjb252ZXJzaW9uIGluIG1wdGNwX25sX2ZpbGxfYWRkciwgYnV0IHdl
IG5lZWQgYWRkIG1vcmUgb3RoZXIgPGJyPm9yZGVyIGNvbnZlcnNpb25zIGluIG90aGVyIHBsYWNl
cywgbGlrZTo8YnI+PGJyPsKgIGluIG1wdGNwX2luZm8yc29ja2FkZHI6PGJyPjxicj7CoCDCoCBp
bl9hZGRyLSZndDtzaW5fcG9ydCA9IGh0b25zKGluZm8tJmd0O3BvcnQpOzxicj48YnI+wqAgaW4g
cmVtb3RlX2FkZHJlc3M6PGJyPjxicj7CoCDCoCBhZGRyLSZndDtwb3J0ID0gbnRvaHMoc2tjLSZn
dDtza2NfZHBvcnQpOzxicj48YnI+LUdlbGlhbmc8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij4KQ2hlZXJzLDxicj4KTWF0dDxicj4KLS0gPGJyPgpUZXNzYXJlcyB8
IEJlbGdpdW0gfCBIeWJyaWQgQWNjZXNzIFNvbHV0aW9uczxicj4KPGEgaHJlZj0iaHR0cDovL3d3
dy50ZXNzYXJlcy5uZXQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNz
YXJlcy5uZXQ8L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============7134940237905076657==--
