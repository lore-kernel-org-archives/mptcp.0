Content-Type: multipart/mixed; boundary="===============6283308295591129402=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 04/10] mptcp: use adding up
 size when get ADD_ADDR length
Date: Wed, 04 Nov 2020 15:46:51 +0800
Message-ID: <CA+WQbwtTo4WF_U7TA0rr3QLZxiWL3Xg+JwSaBHpB=3SESNJ3jA@mail.gmail.com>
In-Reply-To: 4b450240-03e5-624a-04fa-dcf42dd6afb6@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6538

--===============6283308295591129402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B411=
=E6=9C=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:23=E5=86=99=E9=81=
=93=EF=BC=9A

> On 31/10/2020 16:24, Geliang Tang wrote:
> > This patch uses adding up size to get the ADD_ADDR suboption length
> rather
> > than returning the ADD_ADDR size constants.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> >   net/mptcp/protocol.h | 12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index f303c46bcc29..ad3fdec98fdc 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -546,10 +546,14 @@ static inline bool
> mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
> >
> >   static inline unsigned int mptcp_add_addr_len(int family, bool echo)
> >   {
> > -     if (family =3D=3D AF_INET)
> > -             return echo ? TCPOLEN_MPTCP_ADD_ADDR_BASE
> > -                         : TCPOLEN_MPTCP_ADD_ADDR;
> > -     return echo ? TCPOLEN_MPTCP_ADD_ADDR6_BASE :
> TCPOLEN_MPTCP_ADD_ADDR6;
> > +     u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> > +
> > +     if (family =3D=3D AF_INET6)
> > +             len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> > +     if (!echo)
> > +             len +=3D 8; // Truncated HMAC
>
> I don't think these comments with "//" are accepted. Instead, should we
> not declare a new constant, e.g. TCPOLEN_MPTCP_ADD_ADDR_HMAC?
>
>
Thanks, I'll fix this in the next version.

-Geliang


> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>

--===============6283308295591129402==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgTWF0dCw8YnI+PC9kaXY+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+TWF0
dGhpZXUgQmFlcnRzICZsdDs8YSBocmVmPSJtYWlsdG86bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVz
Lm5ldCI+bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldDwvYT4mZ3Q7IOS6jjIwMjDlubQxMeac
iDTml6XlkajkuIkg5LiK5Y2IMToyM+WGmemBk++8mjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxl
ZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+T24gMzEvMTAv
MjAyMCAxNjoyNCwgR2VsaWFuZyBUYW5nIHdyb3RlOjxicj4KJmd0OyBUaGlzIHBhdGNoIHVzZXMg
YWRkaW5nIHVwIHNpemUgdG8gZ2V0IHRoZSBBRERfQUREUiBzdWJvcHRpb24gbGVuZ3RoIHJhdGhl
cjxicj4KJmd0OyB0aGFuIHJldHVybmluZyB0aGUgQUREX0FERFIgc2l6ZSBjb25zdGFudHMuPGJy
PgomZ3Q7IDxicj4KJmd0OyBTaWduZWQtb2ZmLWJ5OiBHZWxpYW5nIFRhbmcgJmx0OzxhIGhyZWY9
Im1haWx0bzpnZWxpYW5ndGFuZ0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5nZWxpYW5ndGFu
Z0BnbWFpbC5jb208L2E+Jmd0Ozxicj4KJmd0OyAtLS08YnI+CiZndDvCoCDCoG5ldC9tcHRjcC9w
cm90b2NvbC5oIHwgMTIgKysrKysrKystLS0tPGJyPgomZ3Q7wqAgwqAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKTxicj4KJmd0OyA8YnI+CiZndDsgZGlmZiAt
LWdpdCBhL25ldC9tcHRjcC9wcm90b2NvbC5oIGIvbmV0L21wdGNwL3Byb3RvY29sLmg8YnI+CiZn
dDsgaW5kZXggZjMwM2M0NmJjYzI5Li5hZDNmZGVjOThmZGMgMTAwNjQ0PGJyPgomZ3Q7IC0tLSBh
L25ldC9tcHRjcC9wcm90b2NvbC5oPGJyPgomZ3Q7ICsrKyBiL25ldC9tcHRjcC9wcm90b2NvbC5o
PGJyPgomZ3Q7IEBAIC01NDYsMTAgKzU0NiwxNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgbXB0Y3Bf
cG1fc2hvdWxkX3JtX3NpZ25hbChzdHJ1Y3QgbXB0Y3Bfc29jayAqbXNrKTxicj4KJmd0O8KgIMKg
PGJyPgomZ3Q7wqAgwqBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBtcHRjcF9hZGRfYWRkcl9s
ZW4oaW50IGZhbWlseSwgYm9vbCBlY2hvKTxicj4KJmd0O8KgIMKgezxicj4KJmd0OyAtwqAgwqAg
wqBpZiAoZmFtaWx5ID09IEFGX0lORVQpPGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dHVybiBlY2hvID8gVENQT0xFTl9NUFRDUF9BRERfQUREUl9CQVNFPGJyPgomZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDogVENQT0xFTl9NUFRDUF9BRERfQUREUjs8
YnI+CiZndDsgLcKgIMKgIMKgcmV0dXJuIGVjaG8gPyBUQ1BPTEVOX01QVENQX0FERF9BRERSNl9C
QVNFIDogVENQT0xFTl9NUFRDUF9BRERfQUREUjY7PGJyPgomZ3Q7ICvCoCDCoCDCoHU4IGxlbiA9
IFRDUE9MRU5fTVBUQ1BfQUREX0FERFJfQkFTRTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAg
wqBpZiAoZmFtaWx5ID09IEFGX0lORVQ2KTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBs
ZW4gPSBUQ1BPTEVOX01QVENQX0FERF9BRERSNl9CQVNFOzxicj4KJmd0OyArwqAgwqAgwqBpZiAo
IWVjaG8pPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGxlbiArPSA4OyAvLyBUcnVuY2F0
ZWQgSE1BQzxicj4KPGJyPgpJIGRvbiYjMzk7dCB0aGluayB0aGVzZSBjb21tZW50cyB3aXRoICZx
dW90Oy8vJnF1b3Q7IGFyZSBhY2NlcHRlZC4gSW5zdGVhZCwgc2hvdWxkIHdlIDxicj4Kbm90IGRl
Y2xhcmUgYSBuZXcgY29uc3RhbnQsIGUuZy4gVENQT0xFTl9NUFRDUF9BRERfQUREUl9ITUFDPzxi
cj4KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcywgSSYjMzk7bGwg
Zml4IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pi1H
ZWxpYW5nPGJyPjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+CkNoZWVycyw8YnI+Ck1hdHQ8YnI+
Ci0tIDxicj4KVGVzc2FyZXMgfCBCZWxnaXVtIHwgSHlicmlkIEFjY2VzcyBTb2x1dGlvbnM8YnI+
CjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdl
dD0iX2JsYW5rIj53d3cudGVzc2FyZXMubmV0PC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjwv
ZGl2Pgo=

--===============6283308295591129402==--
