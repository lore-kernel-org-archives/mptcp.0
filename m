Content-Type: multipart/mixed; boundary="===============4141179321945461501=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 24th of October 2019
Date: Fri, 25 Oct 2019 17:20:12 +0200
Message-ID: <a5596c73-8153-cc96-ed4e-c997201b2b20@tessares.net>
In-Reply-To: 39e52f1c-32fb-f869-f335-eb4db000860f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2320

--===============4141179321945461501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 25/10/2019 09:53, Matthieu Baerts wrote:
>  =C2=A0=C2=A0=C2=A0 - MPTCP v1 support =E2=86=92 part 2:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Paolo started to look at th=
e RFC to support Christoph
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Christoph will be the submi=
tter of the patch
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - *Matth*: publish a branch w=
ith mptcp.org + MPTCPv1

I didn't have a lot of time to look at it but you can find mptcp.org =

kernel with Christoph patches (and a small fix) to support MPTCPv1 on my =

Github account:

     https://github.com/matttbe/mptcp_net-next/tree/mptcp_v0.95_mptcp_v1
     https://github.com/matttbe/mptcp_net-next/tree/mptcp_trunk_mptcp_v1

I would recommend to use the branch based on mptcp_v0.95 (last upstream =

LTS, v4.19.55).

Before testing, don't forget to set:

     sysctl net.mptcp.mptcp_version=3D1
     sysctl net.mptcp.mptcp_enabled=3D1


So far, I *think* the establishment of the connection is OK (SYN, =

SYN+ACK, ACK) but not after: it seems the first data packet has bad =

options. I would need to look more to understand why.

Note that as briefly mentioned yesterday I will not be able to work on =

that next week. I hope being able to continue working on that later on.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4141179321945461501==--
