Content-Type: multipart/mixed; boundary="===============8523964829737988036=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/6] mptcp: add ack work queue
Date: Mon, 11 Nov 2019 10:19:41 +0100
Message-ID: <ab80d76332d747c1b44ae39bc46503826b7b5b27.camel@redhat.com>
In-Reply-To: 20191108220953.30904-6-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2456

--===============8523964829737988036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-11-08 at 23:09 +0100, Florian Westphal wrote:
> This is needed in the (unlikely) case that userspace is blocked in
> mptcp_sendmsg because wmem is exhausted.
> =

> In that case, only the rtx work queue will clean the rtx backlog, but it
> could take several milliseconds until it runs next, so add a dedicated
> work queue that will run as soon as possible.
> =

> We can avoid scheduling the work if the mptcp socket is writeable, next
> send/recv call will also clean acked dfrags.
> =

> An alternative approach is to add a new mptcp flag and re-use the
> existing retrans worker, let me know if this is the preferred solution.

It looks like core TCP uses both approach for timers (overloading a
timer with multiple duties, and using multiple timers for different
activities).

Since mptcp_ack_work() matches closely the initial bits of
mptcp_retransmit(), In this specific scenario I think reusing the
existing worker (plus flag) would be better.

Cheers,

Paolo

--===============8523964829737988036==--
