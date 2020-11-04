Content-Type: multipart/mixed; boundary="===============2261206476688931436=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 02/10] mptcp: unify ADD_ADDR
 and ADD_ADDR6 suboptions writing
Date: Wed, 04 Nov 2020 15:04:55 +0800
Message-ID: <CA+WQbwuy-q4nJH_QuGUJa_H0BsKuxYZwXMxK8s+ZuhcyUauYPg@mail.gmail.com>
In-Reply-To: 7c5ecd37-5bcb-d232-3450-716542390544@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6536

--===============2261206476688931436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B411=
=E6=9C=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:23=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi Geliang,
>
> On 31/10/2020 16:24, Geliang Tang wrote:
> > The length of ADD_ADDR6 is 12 octets longer than ADD_ADDR. That's the
> > only difference between them.
> >
> > This patch dropped the duplicate code between ADD_ADDR and ADD_ADDR6
> > suboptions writing, and unify them into one.
>
> It is nice to avoid similar code but here, I think you are changing the
> behaviour if CONFIG_MPTCP_IPV6 is disabled. If I am not mistaken, we are
> going to reserve space but not write anything in it except the hmac.
>
> For the moment, it is fine because we will not call mptcp_write_options
> with OPTION_MPTCP_ADD_ADDR6 but I don't know if we can safely take that
> into consideration for a "public" function called from TCP.
>
>
Maybe "safer" by using a helper taking different arguments for v4 and
> v6? In this case we could have something like:
>
>
>         if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
>                 mptcp_write_add_addr_option(ptr, opts,
>                                            TCPOLEN_MPTCP_ADD_ADDR_BASE);
>         }
>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>         if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
>                 mptcp_write_add_addr_option(ptr, opts,
>                                           TCPOLEN_MPTCP_ADD_ADDR6_BASE);
>         }
> #endif
>
> Or we add a comment mentioning we should not have OPTION_MPTCP_ADD_ADDR6
> if IPV6 is disabled?
>
>
Thanks for your review. Should it be better to put all
OPTION_MPTCP_ADD_ADDR6
into the IS_ENABLED(CONFIG_MPTCP_IPV6) condition? Something like:

        if ((OPTION_MPTCP_ADD_ADDR
#if IS_ENABLED(CONFIG_MPTCP_IPV6)
           | OPTION_MPTCP_ADD_ADDR6
#endif
            ) & opts->suboptions) {
                u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
                u8 echo =3D MPTCP_ADDR_ECHO;

#if IS_ENABLED(CONFIG_MPTCP_IPV6)
                if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions)
                        len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
#endif

                if (opts->ahmac) {
                        len +=3D sizeof(opts->ahmac);
                        echo =3D 0;
                }

                *ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
                                      len, echo, opts->addr_id);
                if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
                        memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
                        ptr +=3D 1;
                }
#if IS_ENABLED(CONFIG_MPTCP_IPV6)
                else if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
                        memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
                        ptr +=3D 4;
                }
#endif
                if (opts->ahmac) {
                        put_unaligned_be64(opts->ahmac, ptr);
                        ptr +=3D 2;
                }
        }

Is this code acceptable?

-Geliang

Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>

--===============2261206476688931436==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBNYXR0LDxicj48L2Rpdj48L2Rp
dj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFp
bF9hdHRyIj5NYXR0aGlldSBCYWVydHMgJmx0OzxhIGhyZWY9Im1haWx0bzptYXR0aGlldS5iYWVy
dHNAdGVzc2FyZXMubmV0IiB0YXJnZXQ9Il9ibGFuayI+bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVz
Lm5ldDwvYT4mZ3Q7IOS6jjIwMjDlubQxMeaciDTml6XlkajkuIkg5LiK5Y2IMToyM+WGmemBk++8
mjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7
cGFkZGluZy1sZWZ0OjFleCI+SGkgR2VsaWFuZyw8YnI+Cjxicj4KT24gMzEvMTAvMjAyMCAxNjoy
NCwgR2VsaWFuZyBUYW5nIHdyb3RlOjxicj4KJmd0OyBUaGUgbGVuZ3RoIG9mIEFERF9BRERSNiBp
cyAxMiBvY3RldHMgbG9uZ2VyIHRoYW4gQUREX0FERFIuIFRoYXQmIzM5O3MgdGhlPGJyPgomZ3Q7
IG9ubHkgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZW0uPGJyPgomZ3Q7IDxicj4KJmd0OyBUaGlzIHBh
dGNoIGRyb3BwZWQgdGhlIGR1cGxpY2F0ZSBjb2RlIGJldHdlZW4gQUREX0FERFIgYW5kIEFERF9B
RERSNjxicj4KJmd0OyBzdWJvcHRpb25zIHdyaXRpbmcsIGFuZCB1bmlmeSB0aGVtIGludG8gb25l
Ljxicj4KPGJyPgpJdCBpcyBuaWNlIHRvIGF2b2lkIHNpbWlsYXIgY29kZSBidXQgaGVyZSwgSSB0
aGluayB5b3UgYXJlIGNoYW5naW5nIHRoZSA8YnI+CmJlaGF2aW91ciBpZiBDT05GSUdfTVBUQ1Bf
SVBWNiBpcyBkaXNhYmxlZC4gSWYgSSBhbSBub3QgbWlzdGFrZW4sIHdlIGFyZSA8YnI+CmdvaW5n
IHRvIHJlc2VydmUgc3BhY2UgYnV0IG5vdCB3cml0ZSBhbnl0aGluZyBpbiBpdCBleGNlcHQgdGhl
IGhtYWMuPGJyPgo8YnI+CkZvciB0aGUgbW9tZW50LCBpdCBpcyBmaW5lIGJlY2F1c2Ugd2Ugd2ls
bCBub3QgY2FsbCBtcHRjcF93cml0ZV9vcHRpb25zIDxicj4Kd2l0aCBPUFRJT05fTVBUQ1BfQURE
X0FERFI2IGJ1dCBJIGRvbiYjMzk7dCBrbm93IGlmIHdlIGNhbiBzYWZlbHkgdGFrZSB0aGF0IDxi
cj4KaW50byBjb25zaWRlcmF0aW9uIGZvciBhICZxdW90O3B1YmxpYyZxdW90OyBmdW5jdGlvbiBj
YWxsZWQgZnJvbSBUQ1AuPGJyPsKgCjxicj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpNYXliZSAmcXVv
dDtzYWZlciZxdW90OyBieSB1c2luZyBhIGhlbHBlciB0YWtpbmcgZGlmZmVyZW50IGFyZ3VtZW50
cyBmb3IgdjQgYW5kIDxicj4KdjY/IEluIHRoaXMgY2FzZSB3ZSBjb3VsZCBoYXZlIHNvbWV0aGlu
ZyBsaWtlOjxicj4KPGJyPgo8YnI+CsKgIMKgIMKgIMKgIGlmIChPUFRJT05fTVBUQ1BfQUREX0FE
RFIgJmFtcDsgb3B0cy0mZ3Q7c3Vib3B0aW9ucykgezxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgbXB0Y3Bfd3JpdGVfYWRkX2FkZHJfb3B0aW9uKHB0ciwgb3B0cyw8YnI+CsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVENQ
T0xFTl9NUFRDUF9BRERfQUREUl9CQVNFKTs8YnI+CsKgIMKgIMKgIMKgIH08YnI+Cjxicj4KI2lm
IElTX0VOQUJMRUQoQ09ORklHX01QVENQX0lQVjYpPGJyPgrCoCDCoCDCoCDCoCBpZiAoT1BUSU9O
X01QVENQX0FERF9BRERSNiAmYW1wOyBvcHRzLSZndDtzdWJvcHRpb25zKSB7PGJyPgrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBtcHRjcF93cml0ZV9hZGRfYWRkcl9vcHRpb24ocHRyLCBvcHRzLDxi
cj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgVENQT0xFTl9NUFRDUF9BRERfQUREUjZfQkFTRSk7PGJyPgrCoCDCoCDCoCDCoCB9
PGJyPgojZW5kaWY8YnI+Cjxicj4KT3Igd2UgYWRkIGEgY29tbWVudCBtZW50aW9uaW5nIHdlIHNo
b3VsZCBub3QgaGF2ZSBPUFRJT05fTVBUQ1BfQUREX0FERFI2IDxicj4KaWYgSVBWNiBpcyBkaXNh
YmxlZD88YnI+Cjxicj48L2Jsb2NrcXVvdGU+PGRpdj7CoDwvZGl2PjxkaXY+VGhhbmtzIGZvciB5
b3VyIHJldmlldy4gU2hvdWxkIGl0IGJlIGJldHRlciB0byBwdXQgYWxsIE9QVElPTl9NUFRDUF9B
RERfQUREUjY8L2Rpdj48ZGl2PmludG8gdGhlIElTX0VOQUJMRUQoQ09ORklHX01QVENQX0lQVjYp
IGNvbmRpdGlvbj8gU29tZXRoaW5nIGxpa2U6PGJyPjwvZGl2PjxkaXY+wqAgPGJyPjwvZGl2Pjxk
aXY+PGRpdj7CoCDCoCDCoCDCoCBpZiAoKE9QVElPTl9NUFRDUF9BRERfQUREUjwvZGl2PiNpZiBJ
U19FTkFCTEVEKENPTkZJR19NUFRDUF9JUFY2KTxicj7CoCDCoCDCoCDCoCDCoCDCoHwgT1BUSU9O
X01QVENQX0FERF9BRERSNjxicj4jZW5kaWY8YnI+wqAgwqAgwqAgwqAgwqAgwqAgKSAmYW1wOyBv
cHRzLSZndDtzdWJvcHRpb25zKSB7PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHU4IGxlbiA9
IFRDUE9MRU5fTVBUQ1BfQUREX0FERFJfQkFTRTs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
dTggZWNobyA9IE1QVENQX0FERFJfRUNITzs8YnI+PGJyPiNpZiBJU19FTkFCTEVEKENPTkZJR19N
UFRDUF9JUFY2KTxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoT1BUSU9OX01QVENQX0FE
RF9BRERSNiAmYW1wOyBvcHRzLSZndDtzdWJvcHRpb25zKTxicj7CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBsZW4gPSBUQ1BPTEVOX01QVENQX0FERF9BRERSNl9CQVNFOzxicj4j
ZW5kaWY8YnI+PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChvcHRzLSZndDthaG1hYykg
ezxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsZW4gKz0gc2l6ZW9mKG9w
dHMtJmd0O2FobWFjKTs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZWNo
byA9IDA7IDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj7CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAqcHRyKysgPSBtcHRjcF9vcHRpb24oTVBUQ1BPUFRfQUREX0FERFIsPGJyPsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxl
biwgZWNobywgb3B0cy0mZ3Q7YWRkcl9pZCk7PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlm
IChPUFRJT05fTVBUQ1BfQUREX0FERFIgJmFtcDsgb3B0cy0mZ3Q7c3Vib3B0aW9ucykgezxicj7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtZW1jcHkoKHU4ICopcHRyLCAodTgg
KikmYW1wO29wdHMtJmd0O2FkZHIuc19hZGRyLCA0KTs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcHRyICs9IDE7PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+
I2lmIElTX0VOQUJMRUQoQ09ORklHX01QVENQX0lQVjYpPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGVsc2UgaWYgKE9QVElPTl9NUFRDUF9BRERfQUREUjYgJmFtcDsgb3B0cy0mZ3Q7c3Vib3B0
aW9ucykgezxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtZW1jcHkoKHU4
ICopcHRyLCBvcHRzLSZndDthZGRyNi5zNl9hZGRyLCAxNik7IDxicj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBwdHIgKz0gNDs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fTxicj4jZW5kaWY8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKG9wdHMtJmd0O2FobWFj
KSB7PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHB1dF91bmFsaWduZWRf
YmU2NChvcHRzLSZndDthaG1hYywgcHRyKTs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcHRyICs9IDI7PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+wqAgwqAg
wqAgwqAgfTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXMgdGhpcyBjb2RlIGFjY2VwdGFibGU/
PGJyPjwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2Pi1HZWxpYW5nPGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4
IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij4KQ2hlZXJzLDxicj4KTWF0dDxicj4KLS0gPGJyPgpUZXNzYXJlcyB8IEJlbGdp
dW0gfCBIeWJyaWQgQWNjZXNzIFNvbHV0aW9uczxicj4KPGEgaHJlZj0iaHR0cDovL3d3dy50ZXNz
YXJlcy5uZXQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJlcy5u
ZXQ8L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============2261206476688931436==--
