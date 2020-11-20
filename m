Content-Type: multipart/mixed; boundary="===============7952885583907996231=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 00/10] mptcp: More miscellaneous MPTCP
 fixes
Date: Fri, 20 Nov 2020 15:35:25 -0800
Message-ID: <20201120153525.093a38bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 20201119194603.103158-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6886

--===============7952885583907996231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Nov 2020 11:45:53 -0800 Mat Martineau wrote:
> Here's another batch of fixup and enhancement patches that we have
> collected in the MPTCP tree.
> =

> Patch 1 removes an unnecessary flag and related code.
> =

> Patch 2 fixes a bug encountered when closing fallback sockets.
> =

> Patches 3 and 4 choose a better transmit subflow, with a self test.
> =

> Patch 5 adjusts tracking of unaccepted subflows
> =

> Patches 6-8 improve handling of long ADD_ADDR options, with a test.
> =

> Patch 9 more reliably tracks the MPTCP-level window shared with peers.
> =

> Patch 10 sends MPTCP-level acknowledgements more aggressively, so the
> peer can send more data without extra delay.

Applied, thanks!
--===============7952885583907996231==--
