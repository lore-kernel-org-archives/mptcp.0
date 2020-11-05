Content-Type: multipart/mixed; boundary="===============8561128210452649048=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 10/10] selftests: mptcp: add
 testcases for ADD_ADDR with port
Date: Thu, 05 Nov 2020 15:16:34 +0800
Message-ID: <CA+WQbwuQB17A10UkQA3okn1MBfVVyjBEb7-R0atxo6RayPiLLg@mail.gmail.com>
In-Reply-To: 0306a5e1-62f9-3281-8f56-8a95dcddc786@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6543

--===============8561128210452649048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for your review.

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B411=
=E6=9C=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:41=E5=86=99=E9=81=
=93=EF=BC=9A

> On 31/10/2020 16:31, Geliang Tang wrote:
> > This patch added a new argument with_port for run_tests and
> > do_transfer, and added the testcases for ADD_ADDR with port.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> >   .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++++++++-
> >   1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 0eae628d1ffd..826d662a9bf8 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -253,6 +254,11 @@ do_transfer()
> >               -s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
> >       spid=3D$!
> >
> > +     if [ "$with_port" -gt 0 ];then
> > +             ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l
> -p $with_port \
> > +                     -s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
>
> Sorry, I am not sure to understand: why do you establish a new
> connection if the port is set? Just to make sure we can also initiate a
> new connection directly to this port (I am not sure we want this)?
>

Here I establish a new connection to listen for the new port. To make sure
the peer can connect with it using the new port. If the new port isn't be
listened, the peer's connection will fail.


>
> > +     fi
> > +
> >       sleep 1
> >
> >       if [ "$test_link_fail" -eq 0 ];then
>
> (...)
>
> > @@ -717,6 +724,23 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
> >   chk_add_nr 1 1
> >   chk_rm_nr 1 1
> >
> > +# subflow with port
> > +reset
> > +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow port 10100
> > +run_tests $ns1 $ns2 10.0.1.1
> > +chk_join_nr "single subflow with port" 1 1 1
>
> Should we also check that the second subflow was established on the
> correct port?
>

> > +
> > +# signal address with port
> > +reset
> > +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> > +run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast 10100
> > +chk_join_nr "signal address with port" 1 1 1
> > +chk_add_nr 1 1
>
> Should we also check we announce the address with a port?
>
> (note that we could also have a MIB counter we increase when we
> establish a port on a different port than the original one)
>
>
I'll add the MIB counter in the next version.

-Geliang


> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>

--===============8561128210452649048==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBNYXR0LDwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzIGZvciB5b3VyIHJldmlldy48YnI+PC9kaXY+PC9kaXY+PGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+
TWF0dGhpZXUgQmFlcnRzICZsdDs8YSBocmVmPSJtYWlsdG86bWF0dGhpZXUuYmFlcnRzQHRlc3Nh
cmVzLm5ldCI+bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldDwvYT4mZ3Q7IOS6jjIwMjDlubQx
MeaciDTml6XlkajkuIkg5LiK5Y2IMTo0MeWGmemBk++8mjxicj48L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+T24gMzEv
MTAvMjAyMCAxNjozMSwgR2VsaWFuZyBUYW5nIHdyb3RlOjxicj4KJmd0OyBUaGlzIHBhdGNoIGFk
ZGVkIGEgbmV3IGFyZ3VtZW50IHdpdGhfcG9ydCBmb3IgcnVuX3Rlc3RzIGFuZDxicj4KJmd0OyBk
b190cmFuc2ZlciwgYW5kIGFkZGVkIHRoZSB0ZXN0Y2FzZXMgZm9yIEFERF9BRERSIHdpdGggcG9y
dC48YnI+CiZndDsgPGJyPgomZ3Q7IFNpZ25lZC1vZmYtYnk6IEdlbGlhbmcgVGFuZyAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmdlbGlhbmd0YW5nQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmdlbGlh
bmd0YW5nQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPgomZ3Q7IC0tLTxicj4KJmd0O8KgIMKgLi4uL3Rl
c3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9qb2luLnNoIHwgMjYgKysrKysrKysrKysr
KysrKysrLTxicj4KJmd0O8KgIMKgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSk8YnI+CiZndDsgPGJyPgomZ3Q7IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3Bfam9pbi5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL25ldC9tcHRjcC9tcHRjcF9qb2luLnNoPGJyPgomZ3Q7IGluZGV4IDBlYWU2MjhkMWZmZC4u
ODI2ZDY2MmE5YmY4IDEwMDc1NTxicj4KJmd0OyAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9uZXQvbXB0Y3AvbXB0Y3Bfam9pbi5zaDxicj4KJmd0OyArKysgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3Bfam9pbi5zaDxicj4KJmd0OyBAQCAtMjUzLDYgKzI1NCwx
MSBAQCBkb190cmFuc2ZlcigpPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtcyAke3Ny
dl9wcm90b30gJHtsb2NhbF9hZGRyfSAmbHQ7ICZxdW90OyRzaW4mcXVvdDsgJmd0OyAmcXVvdDsk
c291dCZxdW90OyAmYW1wOzxicj4KJmd0O8KgIMKgIMKgIMKgc3BpZD0kITxicj4KJmd0O8KgIMKg
PGJyPgomZ3Q7ICvCoCDCoCDCoGlmIFsgJnF1b3Q7JHdpdGhfcG9ydCZxdW90OyAtZ3QgMCBdO3Ro
ZW48YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaXAgbmV0bnMgZXhlYyAke2xpc3RlbmVy
X25zfSAkbXB0Y3BfY29ubmVjdCAtdCAkdGltZW91dCAtbCAtcCAkd2l0aF9wb3J0IFw8YnI+CiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLXMgJHtzcnZfcHJvdG99ICR7bG9j
YWxfYWRkcn0gJmx0OyAmcXVvdDskc2luJnF1b3Q7ICZndDsgJnF1b3Q7JHNvdXQmcXVvdDsgJmFt
cDs8YnI+Cjxicj4KU29ycnksIEkgYW0gbm90IHN1cmUgdG8gdW5kZXJzdGFuZDogd2h5IGRvIHlv
dSBlc3RhYmxpc2ggYSBuZXcgPGJyPgpjb25uZWN0aW9uIGlmIHRoZSBwb3J0IGlzIHNldD8gSnVz
dCB0byBtYWtlIHN1cmUgd2UgY2FuIGFsc28gaW5pdGlhdGUgYSA8YnI+Cm5ldyBjb25uZWN0aW9u
IGRpcmVjdGx5IHRvIHRoaXMgcG9ydCAoSSBhbSBub3Qgc3VyZSB3ZSB3YW50IHRoaXMpPzxicj48
L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+SGVyZSBJIGVzdGFibGlzaCBhIG5ldyBjb25uZWN0
aW9uIHRvIGxpc3RlbiBmb3IgdGhlIG5ldyBwb3J0LiBUbyBtYWtlIHN1cmU8YnI+dGhlIHBlZXIg
Y2FuIGNvbm5lY3Qgd2l0aCBpdCB1c2luZyB0aGUgbmV3IHBvcnQuIElmIHRoZSBuZXcgcG9ydCBp
c24mIzM5O3QgYmU8YnI+bGlzdGVuZWQsIHRoZSBwZWVyJiMzOTtzIGNvbm5lY3Rpb24gd2lsbCBm
YWlsLjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0
LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KJmd0OyArwqAgwqAgwqBmaTxicj4KJmd0OyAr
PGJyPgomZ3Q7wqAgwqAgwqAgwqBzbGVlcCAxPGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoCDC
oCDCoGlmIFsgJnF1b3Q7JHRlc3RfbGlua19mYWlsJnF1b3Q7IC1lcSAwIF07dGhlbjxicj4KPGJy
PgooLi4uKTxicj4KPGJyPgomZ3Q7IEBAIC03MTcsNiArNzI0LDIzIEBAIGNoa19qb2luX25yICZx
dW90O3JlbW92ZSBzdWJmbG93IGFuZCBzaWduYWwgSVB2NiZxdW90OyAyIDIgMjxicj4KJmd0O8Kg
IMKgY2hrX2FkZF9uciAxIDE8YnI+CiZndDvCoCDCoGNoa19ybV9uciAxIDE8YnI+CiZndDvCoCDC
oDxicj4KJmd0OyArIyBzdWJmbG93IHdpdGggcG9ydDxicj4KJmd0OyArcmVzZXQ8YnI+CiZndDsg
K2lwIG5ldG5zIGV4ZWMgJG5zMSAuL3BtX25sX2N0bCBsaW1pdHMgMCAxPGJyPgomZ3Q7ICtpcCBu
ZXRucyBleGVjICRuczIgLi9wbV9ubF9jdGwgbGltaXRzIDAgMTxicj4KJmd0OyAraXAgbmV0bnMg
ZXhlYyAkbnMyIC4vcG1fbmxfY3RsIGFkZCAxMC4wLjMuMiBmbGFncyBzdWJmbG93IHBvcnQgMTAx
MDA8YnI+CiZndDsgK3J1bl90ZXN0cyAkbnMxICRuczIgMTAuMC4xLjE8YnI+CiZndDsgK2Noa19q
b2luX25yICZxdW90O3NpbmdsZSBzdWJmbG93IHdpdGggcG9ydCZxdW90OyAxIDEgMTxicj4KPGJy
PgpTaG91bGQgd2UgYWxzbyBjaGVjayB0aGF0IHRoZSBzZWNvbmQgc3ViZmxvdyB3YXMgZXN0YWJs
aXNoZWQgb24gdGhlIDxicj4KY29ycmVjdCBwb3J0PyA8YnI+PC9ibG9ja3F1b3RlPjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4K
PGJyPgomZ3Q7ICs8YnI+CiZndDsgKyMgc2lnbmFsIGFkZHJlc3Mgd2l0aCBwb3J0PGJyPgomZ3Q7
ICtyZXNldDxicj4KJmd0OyAraXAgbmV0bnMgZXhlYyAkbnMxIC4vcG1fbmxfY3RsIGxpbWl0cyAw
IDE8YnI+CiZndDsgK2lwIG5ldG5zIGV4ZWMgJG5zMiAuL3BtX25sX2N0bCBsaW1pdHMgMSAxPGJy
PgomZ3Q7ICtpcCBuZXRucyBleGVjICRuczEgLi9wbV9ubF9jdGwgYWRkIDEwLjAuMi4xIGZsYWdz
IHNpZ25hbCBwb3J0IDEwMTAwPGJyPgomZ3Q7ICtydW5fdGVzdHMgJG5zMSAkbnMyIDEwLjAuMS4x
IDAgMCAwIGZhc3QgMTAxMDA8YnI+CiZndDsgK2Noa19qb2luX25yICZxdW90O3NpZ25hbCBhZGRy
ZXNzIHdpdGggcG9ydCZxdW90OyAxIDEgMTxicj4KJmd0OyArY2hrX2FkZF9uciAxIDE8YnI+Cjxi
cj4KU2hvdWxkIHdlIGFsc28gY2hlY2sgd2UgYW5ub3VuY2UgdGhlIGFkZHJlc3Mgd2l0aCBhIHBv
cnQ/PGJyPgo8YnI+Cihub3RlIHRoYXQgd2UgY291bGQgYWxzbyBoYXZlIGEgTUlCIGNvdW50ZXIg
d2UgaW5jcmVhc2Ugd2hlbiB3ZSA8YnI+CmVzdGFibGlzaCBhIHBvcnQgb24gYSBkaWZmZXJlbnQg
cG9ydCB0aGFuIHRoZSBvcmlnaW5hbCBvbmUpPGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJy
PjwvZGl2PjxkaXY+SSYjMzk7bGwgYWRkIHRoZSBNSUIgY291bnRlciBpbiB0aGUgbmV4dCB2ZXJz
aW9uLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+LUdlbGlhbmc8YnI+PC9kaXY+PGRpdj7CoDwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4
IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij4KQ2hlZXJzLDxicj4KTWF0dDxicj4KLS0gPGJyPgpUZXNzYXJlcyB8IEJlbGdp
dW0gfCBIeWJyaWQgQWNjZXNzIFNvbHV0aW9uczxicj4KPGEgaHJlZj0iaHR0cDovL3d3dy50ZXNz
YXJlcy5uZXQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJlcy5u
ZXQ8L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============8561128210452649048==--
