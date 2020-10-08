Content-Type: multipart/mixed; boundary="===============1470243365688212486=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 1/2] mptcp: fix fallback for MP_JOIN subflows
Date: Thu, 08 Oct 2020 13:59:46 -0700
Message-ID: <alpine.OSX.2.23.453.2010081346350.49214@ozore-mobl2.amr.corp.intel.com>
In-Reply-To: 4e8a4502e830a28c2f11d4f1e279e24afc21fabb.1602189151.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6257

--===============1470243365688212486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 8 Oct 2020, Paolo Abeni wrote:

> Additional/MP_JOIN subflows that do not pass some initial handshake
> tests currently causes fallback to TCP. That is an RFC violation:
> we should instead reset the subflow and leave the the msk untouched.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/91
> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c  | 32 +++++++++++++++++++++++++-------
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  | 10 ++++++++--
> 3 files changed, 34 insertions(+), 9 deletions(-)

This doesn't apply cleanly to -net (trivial conflict in protocol.h), but =

here's the tag to help get this merged soon:

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============1470243365688212486==--
