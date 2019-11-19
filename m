Content-Type: multipart/mixed; boundary="===============7993915508806783639=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: wmem accounting and nonblocking io
 support
Date: Tue, 19 Nov 2019 12:38:51 +0100
Message-ID: <cb7cf2fc9f377b667e8267ecf47b3806b92b27d5.camel@redhat.com>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2601

--===============7993915508806783639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-18 at 22:45 +0100, Florian Westphal wrote:
> This is the second iteration of the mptcp poll rework.
> =

> Most patches have no changes, the ones with changes have these
> highlighted in the changelog (6/9/10).
> =

> This addresses comments from Paolo.  I've also axed the 'empty send'
> part as per comments from Paolo and Mat.
> =

> There were doubts as to the repeated invocations of mptcp_send_frag()
> (RFC patch 13/14, "sendmsg: don't restart mptcp_sendmsg_frag"), I have
> dropped it from this iteration -- mptcp_sendmsg_frag needs rework which
> isn't related to this patch series.
> =

> Old covert letter:
> =

> The first patch extends the test suite with a mmap-based mode to
> check large, blocking writes.  This uncovered a minor problem with the
> earlier v2 wmem accounting patch series -- we would happily take a lot
> more data than sndbuf allowed, as we only limited based on what the subfl=
ow
> could accept.  So with a 4k sndbuf we could easily accept 256kb or even m=
ore.
> =

> This patch doesn't change anything in the test suite behaviour however,
> you need to use "-b 4096" and/or "-m mmap" to enable this mode.
> =

> Second patch changes test suite to move to nonblocking io, this breaks mp=
tcp
> because mptcp_poll can signal EPOLLIN when it shouldn't, so userspace gets
> -EAGAIN even though poll told it otherwise.
> =

> Patches 3/4/5/6 are an update vs. last wmem accounting series.
> Remaining patches fix the nonblocking io behaviour.
> =

> mptcp_poll is made to be stand-alone, i.e. it no longer calls
> __tcp_poll on the subflow sockets and only considers mptcp_sk state.
> =

> After this series the selftest works again and mptcp sk rtx queue is
> limited by msk wmem.
> =

> The patches can't easily be rebased/merged so I propose that I would
> squash this myself and send a pull request when done.
> =

> The following changes since commit c925affd3fa9dd18e6c326cff510bd30087f0a=
c8:
> =

>   subflow: wake parent mptcp socket on subflow state change (2019-11-18 0=
2:44:11 +0000)
> =

> are available in the Git repository at:
> =

>   git://git.breakpoint.cc/fw/mptcp-next.git tcp_poll_removal_08
> =

> for you to fetch changes up to 2bbcfcd464c6ff1626800cc2e7c02085e02f35e8:
> =

>   sendmsg: truncate source buffer if mptcp sndbuf size was set from users=
pace (2019-11-18 17:45:44 +0100)

The series LGTM, thanks Florian!

/P

--===============7993915508806783639==--
