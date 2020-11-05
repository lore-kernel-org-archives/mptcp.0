Content-Type: multipart/mixed; boundary="===============0741481294023836605=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 0/7] mptcp: Miscellaneous MPTCP fixes
Date: Wed, 04 Nov 2020 17:50:53 -0800
Message-ID: <20201104175053.008ee35a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 20201103190509.27416-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6542

--===============0741481294023836605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue,  3 Nov 2020 11:05:02 -0800 Mat Martineau wrote:
> This is a collection of small fixup and minor enhancement patches that
> have accumulated in the MPTCP tree while net-next was closed. These are
> prerequisites for larger changes we have queued up.
> =

> Patch 1 refines receive buffer autotuning.
> =

> Patches 2 and 4 are some minor locking and refactoring changes.
> =

> Patch 3 improves GRO and RX coalescing with MPTCP skbs.
> =

> Patches 5-7 add a sysctl for tuning ADD_ADDR retransmission timeout,
> corresponding test code, and documentation.
> =

> =

> v2: Add sysctl documentation and fix signoff tags.

Applied, thanks!
--===============0741481294023836605==--
