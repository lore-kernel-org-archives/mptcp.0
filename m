Content-Type: multipart/mixed; boundary="===============7252074718319519744=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 00/12] Exchange MPTCP DATA_FIN/DATA_ACK
 before TCP FIN
Date: Tue, 28 Jul 2020 17:02:55 -0700
Message-ID: <20200728.170255.1791271197978687017.davem@davemloft.net>
In-Reply-To: 20200728221210.92841-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5358

--===============7252074718319519744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Date: Tue, 28 Jul 2020 15:11:58 -0700

> This series allows the MPTCP-level connection to be closed with the
> peers exchanging DATA_FIN and DATA_ACK according to the state machine in
> appendix D of RFC 8684. The process is very similar to the TCP
> disconnect state machine. =

> =

> The prior code sends DATA_FIN only when TCP FIN packets are sent, and
> does not allow for the MPTCP-level connection to be half-closed.
> =

> Patch 8 ("mptcp: Use full MPTCP-level disconnect state machine") is the
> core of the series. Earlier patches in the series have some small fixes
> and helpers in preparation, and the final four small patches do some
> cleanup.

Series applied, thanks.
--===============7252074718319519744==--
