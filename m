Content-Type: multipart/mixed; boundary="===============4491798648333536624=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/3] sendmsg: fix pending issues.
Date: Fri, 06 Dec 2019 16:10:16 +0100
Message-ID: <3d31899cde0a4789e60a2fcd3c5a31a195985d57.camel@redhat.com>
In-Reply-To: acd3c7fb-58c7-0f5a-168d-1a9dbc8b9e3e@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2820

--===============4491798648333536624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-06 at 15:36 +0100, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> =

> On 04/12/2019 19:55, Mat Martineau wrote:
> > On Wed, 4 Dec 2019, Paolo Abeni wrote:
> > =

> > > This includes the change suggested by Mat. Bumped revision 3 to avoid
> > > confusion with intermediated 2/3 v2.
> > =

> > Thanks, Paolo. v3 looks good to me.
> =

> Thank you for the patches and the review!
> =

> - patch 1/3 has been added just before: "mptcp: Add MPTCP socket stubs"
> - no conflicts
> - 14eb86607211: "squashed" patch 2/3 in "mptcp: Write MPTCP DSS headers =

> to outgoing data packets"
> - 6e357ac6f397: mptcp: fix alignement in protocol.h (tab/space)
> - 59a474684481: conflict in =

> t/mptcp-recvmsg-can-drain-data-from-multiple-subflows
> - dd7d2904f7c4: conflict in =

> t/mptcp-allow-collapsing-consecutive-sendpages-on-the-same-substream
> - d41ac2e4911d: "squashed" patch 3/3 in "mptcp: allow collapsing =

> consecutive sendpages on the same substream"
> - 67b1e688acac: conflict in =

> t/mptcp-queue-data-for-mptcp-level-retransmission (note: compared to the =

> ref branch, I had to remove 'collapse' variable, not used ; and =

> "can_collapse" was declared twice)
> - 47890b23de5d: conflict in =

> t/mptcp-implement-memory-accounting-for-mptcp-rtx-queue
> - 46d9c6a121dc: conflict in =

> t/mptcp-rework-mptcp_sendmsg_frag-to-accept-optional-dfrag
> - 1cc43731a90d..d6c1939a16c5: result

Conflicts resolution LGTM,  thanks!

46d9c6a121dc was a tricky one :(

Cheers,

Paolo

--===============4491798648333536624==--
