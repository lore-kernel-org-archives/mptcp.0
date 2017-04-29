Content-Type: multipart/mixed; boundary="===============6538820012889952152=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: Register handlers for extra TCP options
Date: Fri, 28 Apr 2017 19:36:48 -0700
Message-ID: <35c062a5-90a7-20b5-db00-f06d01ee76d8@oracle.com>
In-Reply-To: 20170427215151.GH82766@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 19

--===============6538820012889952152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/27/2017 02:51 PM, Christoph Paasch wrote:
> lock_sock() and bh_lock_sock(). The former, used when coming from
> user-context. All it does it setting sk->sk_lock.owned to 1, so that
> sock_owned_by_user() returns 1. This prevents other user-context threads
> from accessing the socket.
>
> bh_lock_sock() is the spin-lock, that one must take when coming from
> interrupt-context. When it takes a spinlock, it usually checks
> sock_owned_by_user() to see if another user-space process is currently us=
ing
> the socket as well. If that's the case, it pushes the packet on the
> backlog-queue (see tcp_v4_rcv), instead of going through the stack.
>
> When the user-context has finished its work, it calls release_sock(), whi=
ch
> processes the work that has been queued by interrupt-context "threads" on
> the backlog-queue.
>
>
> That's a very quick, rough and high-level explanation:)
>
>
> Christoph
Thanks a lot Christoph.

Rao

--===============6538820012889952152==--
