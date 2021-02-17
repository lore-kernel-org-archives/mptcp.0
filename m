Content-Type: multipart/mixed; boundary="===============2814389710623264107=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix DATA_FIN processing for
 orphaned sockets.
Date: Wed, 17 Feb 2021 14:57:53 +0100
Message-ID: <b800fb80daeca232b7a5d83298e7c0aa2f7f15ca.camel@redhat.com>
In-Reply-To: f59d8596-3ca-78d4-8a9f-8e50d3d08357@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7821

--===============2814389710623264107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-02-16 at 18:05 -0800, Mat Martineau wrote:
> On Mon, 15 Feb 2021, Paolo Abeni wrote:
> =

> > Currently we move orphaned msk socket directly from FIN_WAIT2
> > state to close, with the rationale that incoming additional
> > data could be just dropped by the TCP stack/TW sockets.
> > =

> > Anyhow we miss sending MPTCP-level ack on incoming DATA_FIN,
> > and that may hang the peers.
> > =

> > Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > I hope nobody is keeping track of nr of follow-ups x commit,
> > because the referenced one could score a world record :(((
> > ---
> > net/mptcp/protocol.c | 9 ++++-----
> > 1 file changed, 4 insertions(+), 5 deletions(-)
> > =

> =

> Thanks for catching this. Fix looks ready for the export branch, and -net =

> (if tests are good). Also a candidate for 5.11-stable?

I guess so, since the fixed commit in is since 5.11-rc1. I usually let
the fix be propagated according to the fixes tag.

Cheers,

Paolo

--===============2814389710623264107==--
