Content-Type: multipart/mixed; boundary="===============9207193159581230777=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/2] mptcp: Fix for 32-bit DATA_FIN
Date: Tue, 29 Sep 2020 18:17:33 -0700
Message-ID: <20200929.181733.1663200201931665007.davem@davemloft.net>
In-Reply-To: 20200929220820.278003-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6105

--===============9207193159581230777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Date: Tue, 29 Sep 2020 15:08:18 -0700

> The main fix is contained in patch 2, and that commit message explains
> the issue with not properly converting truncated DATA_FIN sequence
> numbers sent by the peer.
> =

> With patch 2 adding an unlocked read of msk->ack_seq, patch 1 cleans up
> access to that data with READ_ONCE/WRITE_ONCE.
> =

> This does introduce two merge conflicts with net-next, but both have
> straightforward resolution. Patch 1 modifies a line that got removed in
> net-next so the modification can be dropped when merging. Patch 2 will
> require a trivial conflict resolution for a modified function
> declaration.

Series applied, thank you.
--===============9207193159581230777==--
