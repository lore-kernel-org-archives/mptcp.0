Content-Type: multipart/mixed; boundary="===============3336269920752203452=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: use-after-free Write in __lock_sock
Date: Tue, 04 Feb 2020 00:59:08 +0100
Message-ID: <20200203235908.GB15904@breakpoint.cc>
In-Reply-To: 20200203205239.GF63861@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3576

--===============3336269920752203452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch <cpaasch(a)apple.com> wrote:
> On 03/02/20 - 11:49:34, Paolo Abeni wrote:
> > Oh crap! AFAICS the problem is:
> > =

> > __mptcp_tcp_fallback() frees the msk and graft socket to the subflow
> > sk.
> > =

> > A racing socket ops can grab the 'old' socket->sk and try to access the
> > freed struct sock.
> > =

> > What makes the problem very nasty is that callers access socket->sk in
> > a lockless way, so I don't see how we can avoid the freed sock access. =

> > =

> > Additional equally bad issue: a racing socket ops can also access the
> > NULL socket->sk in between sock_orphan() and sock_graph() !!!

... and we can have calls into mptcp functions with sock->sk already
being a tcp socket (we graft, then update sock->ops).

> > One (=3D=3Dthe only) sulution I can think of is both ugly and dumb:
> > postpone msk free at subflow ctx deallocation time (addining a ptr
> > field inside the ULP context) and ensure check for TCP fallback are in
> > place in every MPTCP op, under the msk socket lock.
> > =

> > Me looks for more coffee :(
> =

> What if mptcp_sock would have a struct tcp_sock at the beginning and we
> simply "convert" the mptcp_sock to the subflow tcp_sock ? (basically, copy
> the content from tcp_sock of the subflow to the tcp_sock of the mptcp_soc=
k).
>
> And then just let things continue. No need to change the sk-pointer,...
> That should work, no?

Probably not because we will have pointers to the ssk socket (e.g. the
icsk list for getting the tcp_sk from the quadruple...), so its not
going to be as simple as "msk->tcp =3D *tcp_ssk;"

AFAICS we need to revert to a state we had very early on:
proxy tcp fallback case everywhere: msk is left alone and
sendmsg/recvmsg and so on invoke the tcp versions on the (only) ssk.

The only case where the existing functions are fine is when the file
descriptor in question is not yet exposed to userland.

Unfortunately for some reason the c reproducer doesn't make my vm barf,
(stopped it after 3hours on net.git), so I'm reluctant to work on a fix.

So, in case you get a similar/different repro I'd be grateful if you
could forward that one to the ML as well.
--===============3336269920752203452==--
