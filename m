Content-Type: multipart/mixed; boundary="===============2557286973398233852=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: wmem accounting and nonblocking io
 support
Date: Tue, 19 Nov 2019 14:52:51 -0800
Message-ID: <alpine.OSX.2.21.1911191451510.15309@gpmelz-mobl1.amr.corp.intel.com>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2603

--===============2557286973398233852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 18 Nov 2019, Florian Westphal wrote:

> This is the second iteration of the mptcp poll rework.
>
> Most patches have no changes, the ones with changes have these
> highlighted in the changelog (6/9/10).
>
> This addresses comments from Paolo.  I've also axed the 'empty send'
> part as per comments from Paolo and Mat.
>
> There were doubts as to the repeated invocations of mptcp_send_frag()
> (RFC patch 13/14, "sendmsg: don't restart mptcp_sendmsg_frag"), I have
> dropped it from this iteration -- mptcp_sendmsg_frag needs rework which
> isn't related to this patch series.

The series looks good to me, with one minor comment on patch 1.


Mat



>
> Old covert letter:
>
> The first patch extends the test suite with a mmap-based mode to
> check large, blocking writes.  This uncovered a minor problem with the
> earlier v2 wmem accounting patch series -- we would happily take a lot
> more data than sndbuf allowed, as we only limited based on what the subfl=
ow
> could accept.  So with a 4k sndbuf we could easily accept 256kb or even m=
ore.
>
> This patch doesn't change anything in the test suite behaviour however,
> you need to use "-b 4096" and/or "-m mmap" to enable this mode.
>
> Second patch changes test suite to move to nonblocking io, this breaks mp=
tcp
> because mptcp_poll can signal EPOLLIN when it shouldn't, so userspace gets
> -EAGAIN even though poll told it otherwise.
>
> Patches 3/4/5/6 are an update vs. last wmem accounting series.
> Remaining patches fix the nonblocking io behaviour.
>
> mptcp_poll is made to be stand-alone, i.e. it no longer calls
> __tcp_poll on the subflow sockets and only considers mptcp_sk state.
>
> After this series the selftest works again and mptcp sk rtx queue is
> limited by msk wmem.
>
> The patches can't easily be rebased/merged so I propose that I would
> squash this myself and send a pull request when done.
>
> The following changes since commit c925affd3fa9dd18e6c326cff510bd30087f0a=
c8:
>
>  subflow: wake parent mptcp socket on subflow state change (2019-11-18 02=
:44:11 +0000)
>
> are available in the Git repository at:
>
>  git://git.breakpoint.cc/fw/mptcp-next.git tcp_poll_removal_08
>
> for you to fetch changes up to 2bbcfcd464c6ff1626800cc2e7c02085e02f35e8:
>
>  sendmsg: truncate source buffer if mptcp sndbuf size was set from usersp=
ace (2019-11-18 17:45:44 +0100)
>
> ----------------------------------------------------------------
> Florian Westphal (13):
>      selftest: add mmap-write support
>      selftests: make sockets non-blocking for default poll mode
>      mptcp: add wmem_queued accounting
>      mptcp: allow partial cleaning of rtx head dfrag
>      mptcp: add and use mptcp RTX flag
>      sendmsg: block until mptcp sk is writeable
>      subflow: sk_data_ready: make wakeup on tcp sock conditional
>      mptcp: add and use mptcp_subflow_get_retrans
>      mptcp: sendmsg: transmit on backup if other subflows have been closed
>      recv: make DATA_READY reflect ssk in-sequence state
>      sendmsg: clear SEND_SPACE if write caused wmem to grow too large
>      mptcp_poll: don't consider subflow socket state anymore
>      sendmsg: truncate source buffer if mptcp sndbuf size was set from us=
erspace
>
> net/mptcp/options.c                                |   2 +-
> net/mptcp/protocol.c                               | 249 ++++++++++++++++=
---
> net/mptcp/protocol.h                               |   4 +-
> net/mptcp/subflow.c                                |  12 +-
> tools/testing/selftests/net/mptcp/mptcp_connect.c  | 268 ++++++++++++++++=
++++-
> tools/testing/selftests/net/mptcp/mptcp_connect.sh |  36 ++-
> 6 files changed, 518 insertions(+), 53 deletions(-)
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============2557286973398233852==--
