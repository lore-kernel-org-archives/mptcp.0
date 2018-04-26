Content-Type: multipart/mixed; boundary="===============1930488965176494636=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 16th of April 2018
Date: Thu, 26 Apr 2018 12:04:31 -0700
Message-ID: <28091722-69f0-d2a7-9c95-e85bb8532a11@oracle.com>
In-Reply-To: 658d8d1f-9b74-9754-26b5-32e06bd3b958@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 556

--===============1930488965176494636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/26/2018 10:27 AM, Matthieu Baerts wrote:
>
> Approach to indirect call optimization by Eric Dumazet:
> =C2=A0=C2=A0=C2=A0 that's one example, it is a bit specific to MD5 but th=
e idea is =

> there. That's what we had in mind (but the solution is not generic)
Can someone point me to it.
>
>
>
> Discussion of Oracle's patches:
> =C2=A0=C2=A0=C2=A0 - Rao is asking what to do next with these patches
> =C2=A0=C2=A0=C2=A0 - (Matthieu: I got disconnected, I maybe missed someth=
ing =

> important, feel free to comment)
> =C2=A0=C2=A0=C2=A0 - One main concerning point raised during the call is =
that we will =

> still have a big intrusiveness with a lot of "if(mptcp)" in the code
What is a lot ? Our patch has 14 instances...

rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv4(upstream)$sed -n '{/if =

*(mptcp/p}' tcp_*.c
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mptcp(tp))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mptcp(tp)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mptcp(tp))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp(tp))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp(tp))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp(tp))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mptcp(tp)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptc=
p_init_tw_sock(sk, tcptw)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp(tcp_sk(child)))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_fin(skb))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_fin(skb))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptc=
p(tcp_sk(sk)))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mptcp(tcp_sk(sk)))
rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv4(upstream)$cd ../ipv6
rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv6(upstream)$!grep
rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv6(upstream)$grep "if =

(mptcp" *.c
tcp_ipv6.c:=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp(tp))
tcp_ipv6.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp(tp))

And all of this code is under #ifdef MPTCP --- Does MD5 have any such code ?
Here is a better comparison of intrusiveness.

rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv4(upstream)$grep MD5 =

tcp_*.c | wc -l
73
rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv4(upstream)$grep MPTCP =

tcp_*.c | wc -l
39

Once again note, any MPTCP specific code is under #ifdef MPTCP. Our =

patch allows tcp to be built with MPTCP and does not require any mptcp =

file including header files.

> =C2=A0=C2=A0=C2=A0 - Rao would prefer not to rewrite the current MPTCP im=
plementation =

> as much as proposed here during the meetings. Propose this first =

> implementation based on a previous mptcp_trunk version.

The trunk version is irrelevant as we are not going to keep up with what =

mptcp-dev does. Having said that, I believe any changes to MPTCP code =

should just work.

Even though I do not think sentiments towards our patch will change. I =

wanted to point out the facts as the comments were made without truly =

evaluating the changes.

Shoaib



--===============1930488965176494636==--
