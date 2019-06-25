Content-Type: multipart/mixed; boundary="===============4210223962688220070=="
MIME-Version: 1.0
From: Viet-Hoang Tran <tranviethoang.vn at gmail.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] squash-to: Define IPPROTO_MPTCP
Date: Tue, 25 Jun 2019 17:05:08 +0200
Message-ID: <CALjxPyp8Db7Ff8HS=2Oq4AqxkMakK9=WB-MT3N14jy_OkB8VTQ@mail.gmail.com>
In-Reply-To: 20190612171643.21861-2-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1447

--===============4210223962688220070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Maybe I am concerned about the wrong thing but when looking at sockopt
levels defined in include/linux/socket.h,
there is an entry of the same value 262 assigned to X25:

/* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
#define SOL_IP 0
/* #define SOL_ICMP 1 No-no-no! Due to Linux :-) we cannot use SOL_ICMP=3D1=
 */
#define SOL_TCP 6
#define SOL_UDP 17
...
#define SOL_X25 262
...


I don't know if it has any issue or implication though.

Hoang


On Wed, Jun 12, 2019 at 7:16 PM Mat Martineau <
mathew.j.martineau(a)linux.intel.com> wrote:

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  include/uapi/linux/in.h       | 4 ++--
>  tools/include/uapi/linux/in.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> index 649d8cd41b80..44df6dc1ff1d 100644
> --- a/include/uapi/linux/in.h
> +++ b/include/uapi/linux/in.h
> @@ -64,8 +64,6 @@ enum {
>  #define IPPROTO_BEETPH         IPPROTO_BEETPH
>    IPPROTO_ENCAP =3D 98,          /* Encapsulation Header                =
 */
>  #define IPPROTO_ENCAP          IPPROTO_ENCAP
> -  IPPROTO_MPTCP =3D 99,          /* Multipath TCP connection            =
 */
> -#define IPPROTO_MPTCP          IPPROTO_MPTCP
>    IPPROTO_PIM =3D 103,           /* Protocol Independent Multicast      =
 */
>  #define IPPROTO_PIM            IPPROTO_PIM
>    IPPROTO_COMP =3D 108,          /* Compression Header Protocol         =
 */
> @@ -78,6 +76,8 @@ enum {
>  #define IPPROTO_MPLS           IPPROTO_MPLS
>    IPPROTO_RAW =3D 255,           /* Raw IP packets                      =
 */
>  #define IPPROTO_RAW            IPPROTO_RAW
> +  IPPROTO_MPTCP =3D 262,         /* Multipath TCP connection            =
 */
> +#define IPPROTO_MPTCP          IPPROTO_MPTCP
>    IPPROTO_MAX
>  };
>  #endif
> diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
> index e7ad9d350a28..44df6dc1ff1d 100644
> --- a/tools/include/uapi/linux/in.h
> +++ b/tools/include/uapi/linux/in.h
> @@ -76,6 +76,8 @@ enum {
>  #define IPPROTO_MPLS           IPPROTO_MPLS
>    IPPROTO_RAW =3D 255,           /* Raw IP packets                      =
 */
>  #define IPPROTO_RAW            IPPROTO_RAW
> +  IPPROTO_MPTCP =3D 262,         /* Multipath TCP connection            =
 */
> +#define IPPROTO_MPTCP          IPPROTO_MPTCP
>    IPPROTO_MAX
>  };
>  #endif
> --
> 2.22.0
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--===============4210223962688220070==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+TWF5YmUgSSBhbSBjb25jZXJuZWQgYWJvdXQgdGhlIHdyb25nIHRoaW5n
IGJ1dCB3aGVuIGxvb2tpbmcgYXQgc29ja29wdCBsZXZlbHMgZGVmaW5lZCBpbsKgaW5jbHVkZS9s
aW51eC9zb2NrZXQuaCw8ZGl2PnRoZXJlIGlzIGFuIGVudHJ5IG9mIHRoZSBzYW1lIHZhbHVlIDI2
MiBhc3NpZ25lZCB0byBYMjU6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4vKiBTZXRzb2Nrb3B0
aW9ucygyKSBsZXZlbC4gVGhhbmtzIHRvIEJTRCB0aGVzZSBtdXN0IG1hdGNoIElQUFJPVE9feHh4
ICovPGJyPiNkZWZpbmUgU09MX0lQCQkwPGJyPi8qICNkZWZpbmUgU09MX0lDTVAJMQlOby1uby1u
byEgRHVlIHRvIExpbnV4IDotKSB3ZSBjYW5ub3QgdXNlIFNPTF9JQ01QPTEgKi88YnI+I2RlZmlu
ZSBTT0xfVENQCQk2PGJyPiNkZWZpbmUgU09MX1VEUAkJMTc8YnI+Li4uPGJyPiNkZWZpbmUJU09M
X1gyNQkJMjYyPGJyPjwvZGl2PjxkaXY+Li4uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5JIGRvbiYjMzk7dCBrbm93IGlmIGl0IGhhcyBhbnkgaXNzdWUgb3IgaW1wbGlj
YXRpb24gdGhvdWdoLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SG9hbmc8YnI+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0i
bHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gV2VkLCBKdW4gMTIsIDIwMTkgYXQgNzoxNiBQTSBN
YXQgTWFydGluZWF1ICZsdDs8YSBocmVmPSJtYWlsdG86bWF0aGV3LmoubWFydGluZWF1QGxpbnV4
LmludGVsLmNvbSI+bWF0aGV3LmoubWFydGluZWF1QGxpbnV4LmludGVsLmNvbTwvYT4mZ3Q7IHdy
b3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIw
NCk7cGFkZGluZy1sZWZ0OjFleCI+U2lnbmVkLW9mZi1ieTogTWF0IE1hcnRpbmVhdSAmbHQ7PGEg
aHJlZj0ibWFpbHRvOm1hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20iIHRhcmdldD0i
X2JsYW5rIj5tYXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tPC9hPiZndDs8YnI+Ci0t
LTxicj4KwqBpbmNsdWRlL3VhcGkvbGludXgvaW4uaMKgIMKgIMKgIMKgfCA0ICsrLS08YnI+CsKg
dG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2luLmggfCAyICsrPGJyPgrCoDIgZmlsZXMgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKTxicj4KPGJyPgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L2luLmggYi9pbmNsdWRlL3VhcGkvbGludXgvaW4uaDxicj4KaW5k
ZXggNjQ5ZDhjZDQxYjgwLi40NGRmNmRjMWZmMWQgMTAwNjQ0PGJyPgotLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvaW4uaDxicj4KKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2luLmg8YnI+CkBAIC02
NCw4ICs2NCw2IEBAIGVudW0gezxicj4KwqAjZGVmaW5lIElQUFJPVE9fQkVFVFBIwqAgwqAgwqAg
wqAgwqBJUFBST1RPX0JFRVRQSDxicj4KwqAgwqBJUFBST1RPX0VOQ0FQID0gOTgswqAgwqAgwqAg
wqAgwqAgLyogRW5jYXBzdWxhdGlvbiBIZWFkZXLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCov
PGJyPgrCoCNkZWZpbmUgSVBQUk9UT19FTkNBUMKgIMKgIMKgIMKgIMKgIElQUFJPVE9fRU5DQVA8
YnI+Ci3CoCBJUFBST1RPX01QVENQID0gOTkswqAgwqAgwqAgwqAgwqAgLyogTXVsdGlwYXRoIFRD
UCBjb25uZWN0aW9uwqAgwqAgwqAgwqAgwqAgwqAgwqAqLzxicj4KLSNkZWZpbmUgSVBQUk9UT19N
UFRDUMKgIMKgIMKgIMKgIMKgIElQUFJPVE9fTVBUQ1A8YnI+CsKgIMKgSVBQUk9UT19QSU0gPSAx
MDMswqAgwqAgwqAgwqAgwqAgwqAvKiBQcm90b2NvbCBJbmRlcGVuZGVudCBNdWx0aWNhc3TCoCDC
oCDCoCDCoCovPGJyPgrCoCNkZWZpbmUgSVBQUk9UT19QSU3CoCDCoCDCoCDCoCDCoCDCoCBJUFBS
T1RPX1BJTTxicj4KwqAgwqBJUFBST1RPX0NPTVAgPSAxMDgswqAgwqAgwqAgwqAgwqAgLyogQ29t
cHJlc3Npb24gSGVhZGVyIFByb3RvY29swqAgwqAgwqAgwqAgwqAgKi88YnI+CkBAIC03OCw2ICs3
Niw4IEBAIGVudW0gezxicj4KwqAjZGVmaW5lIElQUFJPVE9fTVBMU8KgIMKgIMKgIMKgIMKgIMKg
SVBQUk9UT19NUExTPGJyPgrCoCDCoElQUFJPVE9fUkFXID0gMjU1LMKgIMKgIMKgIMKgIMKgIMKg
LyogUmF3IElQIHBhY2tldHPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCovPGJy
PgrCoCNkZWZpbmUgSVBQUk9UT19SQVfCoCDCoCDCoCDCoCDCoCDCoCBJUFBST1RPX1JBVzxicj4K
K8KgIElQUFJPVE9fTVBUQ1AgPSAyNjIswqAgwqAgwqAgwqAgwqAvKiBNdWx0aXBhdGggVENQIGNv
bm5lY3Rpb27CoCDCoCDCoCDCoCDCoCDCoCDCoCovPGJyPgorI2RlZmluZSBJUFBST1RPX01QVENQ
wqAgwqAgwqAgwqAgwqAgSVBQUk9UT19NUFRDUDxicj4KwqAgwqBJUFBST1RPX01BWDxicj4KwqB9
Ozxicj4KwqAjZW5kaWY8YnI+CmRpZmYgLS1naXQgYS90b29scy9pbmNsdWRlL3VhcGkvbGludXgv
aW4uaCBiL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9pbi5oPGJyPgppbmRleCBlN2FkOWQzNTBh
MjguLjQ0ZGY2ZGMxZmYxZCAxMDA2NDQ8YnI+Ci0tLSBhL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51
eC9pbi5oPGJyPgorKysgYi90b29scy9pbmNsdWRlL3VhcGkvbGludXgvaW4uaDxicj4KQEAgLTc2
LDYgKzc2LDggQEAgZW51bSB7PGJyPgrCoCNkZWZpbmUgSVBQUk9UT19NUExTwqAgwqAgwqAgwqAg
wqAgwqBJUFBST1RPX01QTFM8YnI+CsKgIMKgSVBQUk9UT19SQVcgPSAyNTUswqAgwqAgwqAgwqAg
wqAgwqAvKiBSYXcgSVAgcGFja2V0c8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Ki88YnI+CsKgI2RlZmluZSBJUFBST1RPX1JBV8KgIMKgIMKgIMKgIMKgIMKgIElQUFJPVE9fUkFX
PGJyPgorwqAgSVBQUk9UT19NUFRDUCA9IDI2MizCoCDCoCDCoCDCoCDCoC8qIE11bHRpcGF0aCBU
Q1AgY29ubmVjdGlvbsKgIMKgIMKgIMKgIMKgIMKgIMKgKi88YnI+CisjZGVmaW5lIElQUFJPVE9f
TVBUQ1DCoCDCoCDCoCDCoCDCoCBJUFBST1RPX01QVENQPGJyPgrCoCDCoElQUFJPVE9fTUFYPGJy
PgrCoH07PGJyPgrCoCNlbmRpZjxicj4KLS0gPGJyPgoyLjIyLjA8YnI+Cjxicj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm1wdGNwIG1haWxpbmcg
bGlzdDxicj4KPGEgaHJlZj0ibWFpbHRvOm1wdGNwQGxpc3RzLjAxLm9yZyIgdGFyZ2V0PSJfYmxh
bmsiPm1wdGNwQGxpc3RzLjAxLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMuMDEu
b3JnL21haWxtYW4vbGlzdGluZm8vbXB0Y3AiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxh
bmsiPmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbXB0Y3A8L2E+PGJyPgo8
L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============4210223962688220070==--
