Content-Type: multipart/mixed; boundary="===============5812688202549960184=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 08/11] tcp: Export TCP functions and ops struct
Date: Fri, 13 Dec 2019 22:50:14 +0100
Message-ID: <660ec793-5d1a-11f1-1c3d-527e3f4abfb3@tessares.net>
In-Reply-To: 37d47362bcab874a9bf91d6612a81dd970db20bb.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3022

--===============5812688202549960184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 13/12/2019 22:31, Peter Krystad wrote:
> tcp_request_sock_ipvX_ops and ipvX_specific will be referenced
> during TCP subflow creation.

Good catch, just fixed!

-75ea5a0225f1] tg:msg: do not restrict to IPv4

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5812688202549960184==--
