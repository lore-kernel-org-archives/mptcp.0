Content-Type: multipart/mixed; boundary="===============4834875093662284726=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 16th of April 2018
Date: Thu, 26 Apr 2018 11:31:14 -0700
Message-ID: <30106729-92a9-4d10-f2ea-d21ab265eff8@oracle.com>
In-Reply-To: 658d8d1f-9b74-9754-26b5-32e06bd3b958@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 555

--===============4834875093662284726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/26/2018 10:27 AM, Matthieu Baerts wrote:
> Hello,
>
> We just had our 7th meeting with Mat, Peter, Ossama (Intel OTC), =

> Christoph (Apple), Rao (Oracle) and myself (Tessares).
>
> Thanks again for this new meeting!
>
>
>
> Here are the minutes of the meeting:
>
>
>
> Progress from last week:
> =C2=A0=C2=A0=C2=A0 - the wiki is ready and need to be kept updated
> =C2=A0=C2=A0=C2=A0 - there is an update in the mptcp_net-next branch (syn=
c with =

> net-next)
> =C2=A0=C2=A0=C2=A0 - discussions about NetDev tutorial presentations have=
 started.
>
>
>
> Netdev:
> =C2=A0=C2=A0=C2=A0 From what has been shared on the ML:
> =C2=A0=C2=A0=C2=A0 - https://lists.01.org/pipermail/mptcp/2018-April/0005=
40.html
>
> =C2=A0=C2=A0=C2=A0 We cannot only count on discussions: we need a backup =
plan if =

> nobody is expressing something.
> =C2=A0=C2=A0=C2=A0 Show different approaches:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - current implementation where any app can=
 benefit from MPTCP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - only on demand + API
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (and respecting impact on the TCP code)
> =C2=A0=C2=A0=C2=A0 We could get more attention by talking about APIs.
> =C2=A0=C2=A0=C2=A0 Who will be there:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Christoph for sure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Maybe Mat, Peter and Matthieu,=
 waiting for more details from =

> their manager(s)
> =C2=A0=C2=A0=C2=A0 Matthieu: write a proposal for the netdev conf on the =
ML.
> =C2=A0=C2=A0=C2=A0 Important: Discussions will continue there. We need to=
 send =

> something on Monday!
>
>
>
> Wiki:
> =C2=A0=C2=A0=C2=A0 The base is there, we need to maintain it.
> =C2=A0=C2=A0=C2=A0 It is indexed by Google and others, that's good!
>
>
>
> Approach to indirect call optimization by Eric Dumazet:
> =C2=A0=C2=A0=C2=A0 that's one example, it is a bit specific to MD5 but th=
e idea is =

> there. That's what we had in mind (but the solution is not generic)
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
> =C2=A0=C2=A0=C2=A0 - Rao would prefer not to rewrite the current MPTCP im=
plementation =

> as much as proposed here during the meetings. Propose this first =

> implementation based on a previous mptcp_trunk version.
> =C2=A0=C2=A0=C2=A0 - By Christoph: this kind of code should be avoided fo=
r =

> maintainability reasons:
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct inet_connection_sock *icsk =3D from_timer(icsk, t, =

> icsk_delack_timer);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct sock *sk =3D &icsk->icsk_inet.sk;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +#ifndef CONFIG_MPTCP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 struct soc=
k *meta_sk =3D sk;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +#else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 struct soc=
k *meta_sk =3D mptcp(tcp_sk(sk)) ? =

> mptcp_meta_sk(sk) : sk;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +#endif
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0 bh_l=
ock_sock(sk);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 bh_lock_so=
ck(meta_sk);
>
> =C2=A0=C2=A0=C2=A0 - Discussions will continue next week.
>
>
I would like to point out that the statement made was that the code is =

littered with what is shown above. The patch that Oracle submitted has =

not such code in the fast path plus unlike the mptcp-dev implementation =

we have significantly reduced it.=C2=A0 Please take a look at the patch. I =

also do not see any maintenance issues with the code, the only issue is =

that it is an eye sore but not when used minimally and we have plans to =

clean it up.

rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv4(upstream)$grep =

bh_lock_sock tcp*.c | grep meta_sk | wc -l
5
rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv4(upstream)$cd ../ipv6
rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv6(upstream)$!grep
rshoaib(a)caduceus5:/home/mptcp/upstream/net/ipv6(upstream)$grep =

bh_lock_sock tcp*.c | grep meta_sk | wc -l
1

Shoaib.



--===============4834875093662284726==--
