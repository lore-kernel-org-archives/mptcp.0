Content-Type: multipart/mixed; boundary="===============7954984443997794270=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/3] sendmsg: fix pending issues.
Date: Wed, 04 Dec 2019 10:55:08 -0800
Message-ID: <alpine.OSX.2.21.1912041054450.44605@pminglan-mobl.amr.corp.intel.com>
In-Reply-To: cover.1575468474.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2783

--===============7954984443997794270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 4 Dec 2019, Paolo Abeni wrote:

> This includes the change suggested by Mat. Bumped revision 3 to avoid
> confusion with intermediated 2/3 v2.

Thanks, Paolo. v3 looks good to me.


Mat


>
> The patch 1 should be inserted just after "tcp: clean ext on tx recycle"
>
> The patches 2 and 3 have explicit individual squash-to tags, but will cas=
ue
> a lot of conflicts, the uneasy ones to solve are on patch
> "mptcp: rework mptcp_sendmsg_frag to accept optional dfrag"
>
> A tree rebased with the above patches applied is available at:
>
> https://github.com/pabeni/mptcp/tree/mptcp_net-next-FIN_v1_recvmsg_2
>
> The original cover letter was as follow
> ---
>
> This series addresses the known pending issue in mptcp_sendmsg,
> specifically:
>
> * the crash repored by matt (patch 3/3)
> * the possible data corruption on ext allocation failure - the "TODO"" in
>  sendmsg_frag (patches 1,2/3)
>
> uunfortunately none of the above is actually tested, since I can't
> reproduce the issues - still the problems look real.
>
> This is not squashed yet, as it will conflict with most patches, I'm just
> trying to collect feedback.
>
> Open points:
>
> The patch 2/3 introduces a per socket cache of a single skb_ext. As per
> recent upstream changes related to TCP rx/tx skb cache, that is debatable,
> could have subtle performance and memory usage implications.
> We could avoid such cache allways allocating the extension for each
> sendmsg_frag() call, and than free it if unused. Both options looks
> sub-optiomal to me do you have any preference? - I do have some for the
> selected impl ;)
>
> The new API exposed by patch 1/3 is open to misusage. e.g. the caller cou=
ld
> allocate a skb_ext, set arbitrary ext->offset[id] values and than call
> __skb_ext_add(). That will lead to memory leak or GPF. I did no try to
> address the issue, the '__' prefix should guide the users to extra care.
> Can we do any better?
>
> (this is a pre-existing topic) the sk_stream_wait_memory() calls in
> sk_stream_wait_memory(), waits on the subflow. Should we wait on the mptcp
> socket instead? Otherwise should we release the mptcp socket lock, before=
 such
> call?
>
> Paolo Abeni (1):
>  skb: add helpers to allocate ext independently from sk_buff
>  mptcp: avoid data stream corruption on allocation failure.
>  mptcp: properly detect skb collapsing
>
> include/linux/skbuff.h |    3 ++
> net/core/skbuff.c      |   35 ++++++++++++++++++++++++++++++--
> net/mptcp/protocol.c   |   53 +++++++++++++++++++++++++++++++------------=
------
> net/mptcp/protocol.h   |    1
> 4 files changed, 71 insertions(+), 21 deletions(-)
>
> -- =

> 2.21.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============7954984443997794270==--
