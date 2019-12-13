Content-Type: multipart/mixed; boundary="===============0058471351979115527=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] .topmsg: tcp: clean ext on tx recycle
Date: Fri, 13 Dec 2019 17:38:03 +0100
Message-ID: <4e788142-3dff-ac91-a634-35e2e3df3fac@tessares.net>
In-Reply-To: 20191213005822.29791-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2965

--===============0058471351979115527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 13/12/2019 01:58, Mat Martineau wrote:
> Reworded since the tree contains very little MPTCP code at this point
> in the series.

Thank you for all the patches. I just applied all but I didn't modify =

the Signed-Off as I already did that. If I am not wrong, as a sender, =

your signed-off should be the last one, no?

- c7cb9c040948: "squahsed" patch 1/7 in "tcp: clean ext on tx recycle"
- 6719fc6e867d: "squashed" patch 2/7 in "mptcp: Handle MPTCP TCP options"
- d6a69af948b7: "squashed" patch 3/7 in "mptcp: Associate MPTCP context =

with TCP socket"
- 9e4d893cb81f: "squashed" patch 4/7 in "mptcp: Write MPTCP DSS headers =

to outgoing data packets"
- ae428c460335: "squashed" patch 5/7 in "mptcp: recvmsg() can drain data =

from multiple subflows"
- 0d182fc96c0b: "squashed" patch 6/7 in "mptcp: parse and emit =

MP_CAPABLE option according to v1 spec"
- 8d7da78ad705: "squashed" patch 7/7 in "mptcp: process MP_CAPABLE data =

option"

Cheers,
Matthieu
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0058471351979115527==--
