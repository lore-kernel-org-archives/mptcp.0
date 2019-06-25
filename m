Content-Type: multipart/mixed; boundary="===============7386922507957997028=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] squash-to: Define IPPROTO_MPTCP
Date: Tue, 25 Jun 2019 12:23:03 -0700
Message-ID: <alpine.OSX.2.21.1906251053370.16780@jlatourx-mobl.amr.corp.intel.com>
In-Reply-To: CALjxPyp8Db7Ff8HS=2Oq4AqxkMakK9=WB-MT3N14jy_OkB8VTQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 1448

--===============7386922507957997028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 25 Jun 2019, Viet-Hoang Tran wrote:

> Maybe I am concerned about the wrong thing but when looking at sockopt le=
vels defined in=C2=A0include/linux/socket.h,there is an
> entry of the same value 262 assigned to X25:
> =

> /* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
> #define SOL_IP 0
> /* #define SOL_ICMP 1 No-no-no! Due to Linux :-) we cannot use SOL_ICMP=
=3D1 */
> #define SOL_TCP 6
> #define SOL_UDP 17
> ...
> #define SOL_X25 262
> ...
> =

> =

> I don't know if it has any issue or implication though.

Hello Hoang -

Thanks for noticing this. We'll probably define SOL_MPTCP at some point, =

so there's also the question of matching values for SOL_MPTCP and =

IPPROTO_MPTCP.

Other than changing sock->sk_protocol to 16 bits (which I posted on =

Friday), it seems like the main effect of choosing a larger integer for =

IPPROTO_MPTCP is increasing IPPROTO_MAX. That, in turn, increases a =

handful of array sizes:

  - inet_diag_table
  - xfrm4_state_afinfo (two arrays for type maps)
  - xfrm6_state_afinfo (two arrays for type maps)

Maybe that's not a big deal, they're already fairly sparse arrays that =

trade space for speed.

At least it's easy to change for now!


Mat


> On Wed, Jun 12, 2019 at 7:16 PM Mat Martineau <mathew.j.martineau(a)linux=
.intel.com> wrote:
>       Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>       ---
>       =C2=A0include/uapi/linux/in.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--
>       =C2=A0tools/include/uapi/linux/in.h | 2 ++
>       =C2=A02 files changed, 4 insertions(+), 2 deletions(-)
>
>       diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>       index 649d8cd41b80..44df6dc1ff1d 100644
>       --- a/include/uapi/linux/in.h
>       +++ b/include/uapi/linux/in.h
>       @@ -64,8 +64,6 @@ enum {
>       =C2=A0#define IPPROTO_BEETPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IPPRO=
TO_BEETPH
>       =C2=A0 =C2=A0IPPROTO_ENCAP =3D 98,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Encapsulation Header=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*/
>       =C2=A0#define IPPROTO_ENCAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPPRO=
TO_ENCAP
>       -=C2=A0 IPPROTO_MPTCP =3D 99,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
Multipath TCP connection=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>       -#define IPPROTO_MPTCP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPPROTO_MP=
TCP
>       =C2=A0 =C2=A0IPPROTO_PIM =3D 103,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Protocol Independent Multicast=C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>       =C2=A0#define IPPROTO_PIM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
IPPROTO_PIM
>       =C2=A0 =C2=A0IPPROTO_COMP =3D 108,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Compression Header Protocol=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>       @@ -78,6 +76,8 @@ enum {
>       =C2=A0#define IPPROTO_MPLS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
IPPROTO_MPLS
>       =C2=A0 =C2=A0IPPROTO_RAW =3D 255,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Raw IP packets=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>       =C2=A0#define IPPROTO_RAW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
IPPROTO_RAW
>       +=C2=A0 IPPROTO_MPTCP =3D 262,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
Multipath TCP connection=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>       +#define IPPROTO_MPTCP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPPROTO_MP=
TCP
>       =C2=A0 =C2=A0IPPROTO_MAX
>       =C2=A0};
>       =C2=A0#endif
>       diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/lin=
ux/in.h
>       index e7ad9d350a28..44df6dc1ff1d 100644
>       --- a/tools/include/uapi/linux/in.h
>       +++ b/tools/include/uapi/linux/in.h
>       @@ -76,6 +76,8 @@ enum {
>       =C2=A0#define IPPROTO_MPLS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
IPPROTO_MPLS
>       =C2=A0 =C2=A0IPPROTO_RAW =3D 255,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Raw IP packets=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>       =C2=A0#define IPPROTO_RAW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
IPPROTO_RAW
>       +=C2=A0 IPPROTO_MPTCP =3D 262,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
Multipath TCP connection=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>       +#define IPPROTO_MPTCP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPPROTO_MP=
TCP
>       =C2=A0 =C2=A0IPPROTO_MAX
>       =C2=A0};
>       =C2=A0#endif
>       --
>       2.22.0
>
>       _______________________________________________
>       mptcp mailing list
>       mptcp(a)lists.01.org
>       https://lists.01.org/mailman/listinfo/mptcp
> =

> =

>

--
Mat Martineau
Intel

--===============7386922507957997028==--
