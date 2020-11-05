Content-Type: multipart/mixed; boundary="===============4146971563264833120=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 10/10] selftests: mptcp: add
 testcases for ADD_ADDR with port
Date: Thu, 05 Nov 2020 14:39:18 +0100
Message-ID: <5f14bc98-aa5a-3664-e044-c73f2d8f0955@tessares.net>
In-Reply-To: CA+WQbwuQB17A10UkQA3okn1MBfVVyjBEb7-R0atxo6RayPiLLg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6564

--===============4146971563264833120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

Thank you for the replies!

On 05/11/2020 08:16, Geliang Tang wrote:
> Hi Matt,
> =

> Thanks for your review.
> =

> Matthieu Baerts <matthieu.baerts(a)tessares.net =

> <mailto:matthieu.baerts(a)tessares.net>> =E4=BA=8E2020=E5=B9=B411=E6=9C=
=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:41=E5=86=99=E9=81=93=EF=
=BC=9A
> =

>     On 31/10/2020 16:31, Geliang Tang wrote:
>      > This patch added a new argument with_port for run_tests and
>      > do_transfer, and added the testcases for ADD_ADDR with port.
>      >
>      > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com
>     <mailto:geliangtang(a)gmail.com>>
>      > ---
>      >=C2=A0 =C2=A0.../testing/selftests/net/mptcp/mptcp_join.sh | 26
>     ++++++++++++++++++-
>      >=C2=A0 =C2=A01 file changed, 25 insertions(+), 1 deletion(-)
>      >
>      > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>     b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>      > index 0eae628d1ffd..826d662a9bf8 100755
>      > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>      > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>      > @@ -253,6 +254,11 @@ do_transfer()
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-s ${srv_pro=
to} ${local_addr} < "$sin" > "$sout" &
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0spid=3D$!
>      >
>      > +=C2=A0 =C2=A0 =C2=A0if [ "$with_port" -gt 0 ];then
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip netns exec ${l=
istener_ns} $mptcp_connect -t
>     $timeout -l -p $with_port \
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0-s ${srv_proto} ${local_addr} < "$sin" >
>     "$sout" &
> =

>     Sorry, I am not sure to understand: why do you establish a new
>     connection if the port is set? Just to make sure we can also initiate=
 a
>     new connection directly to this port (I am not sure we want this)?
> =

> =

> Here I establish a new connection to listen for the new port. To make sure
> the peer can connect with it using the new port. If the new port isn't be
> listened, the peer's connection will fail.

I see, thank you, I missed the "-l" with mptcp_connect, you are indeed =

in the listener ns, my bad!
Did we not want to have the kernel (e.g. via instructions given to the =

PM) creating another listening socket?

I don't know if we can ask to execute 2 binaries doing two listen's on =

different ports, maybe not good in term of security? Maybe safer if the =

same app is doing multiple bind's?
>     Should we also check we announce the address with a port?
> =

>     (note that we could also have a MIB counter we increase when we
>     establish a port on a different port than the original one)
> =

> =

> I'll add the MIB counter in the next version.

Thanks!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4146971563264833120==--
