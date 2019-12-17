Content-Type: multipart/mixed; boundary="===============3341048934637187250=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 09/11] tcp: Check for filled TCP
 option space before SACK
Date: Tue, 17 Dec 2019 19:06:43 +0100
Message-ID: <c3afdd5d-05eb-d03a-306f-01371b0967a9@tessares.net>
In-Reply-To: 20191217002455.24849-10-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3116

--===============3341048934637187250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

-netdev

On 17/12/2019 01:24, Mat Martineau wrote:
> Update the SACK check to work with zero option space available, a case
> that's possible with MPTCP but not MD5+TS. Maintained only one
> conditional branch for insufficient SACK space.

FYI, I just updated the commit message including Mat and Paolo' =

suggestions (from here and IRC).

- 0e5b90d11876: tg:msg: include Mat's new message + changelog

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3341048934637187250==--
