Content-Type: multipart/mixed; boundary="===============2458147647376735559=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: use-after-free Write in __lock_sock
Date: Tue, 04 Feb 2020 10:12:00 +0100
Message-ID: <5b235b4f2636c7621be6a8526e8b6f5cfb7852de.camel@redhat.com>
In-Reply-To: 20200203235908.GB15904@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3580

--===============2458147647376735559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-04 at 00:59 +0100, Florian Westphal wrote:
> Christoph Paasch <cpaasch(a)apple.com> wrote:
> > On 03/02/20 - 11:49:34, Paolo Abeni wrote:
> > > Oh crap! AFAICS the problem is:
> > > =

> > > __mptcp_tcp_fallback() frees the msk and graft socket to the subflow
> > > sk.
> > > =

> > > A racing socket ops can grab the 'old' socket->sk and try to access t=
he
> > > freed struct sock.
> > > =

> > > What makes the problem very nasty is that callers access socket->sk in
> > > a lockless way, so I don't see how we can avoid the freed sock access=
. =

> > > =

> > > Additional equally bad issue: a racing socket ops can also access the
> > > NULL socket->sk in between sock_orphan() and sock_graph() !!!
> =

> ... and we can have calls into mptcp functions with sock->sk already
> being a tcp socket (we graft, then update sock->ops).
> =

> > > One (=3D=3Dthe only) sulution I can think of is both ugly and dumb:
> > > postpone msk free at subflow ctx deallocation time (addining a ptr
> > > field inside the ULP context) and ensure check for TCP fallback are in
> > > place in every MPTCP op, under the msk socket lock.
> > > =

> > > Me looks for more coffee :(
> > =

> > What if mptcp_sock would have a struct tcp_sock at the beginning and we
> > simply "convert" the mptcp_sock to the subflow tcp_sock ? (basically, c=
opy
> > the content from tcp_sock of the subflow to the tcp_sock of the mptcp_s=
ock).
> > =

> > And then just let things continue. No need to change the sk-pointer,...
> > That should work, no?
> =

> Probably not because we will have pointers to the ssk socket (e.g. the
> icsk list for getting the tcp_sk from the quadruple...), so its not
> going to be as simple as "msk->tcp =3D *tcp_ssk;"
> =

> AFAICS we need to revert to a state we had very early on:
> proxy tcp fallback case everywhere: msk is left alone and
> sendmsg/recvmsg and so on invoke the tcp versions on the (only) ssk.

That is unfortunated, I liked the fact that a fallback socket got the
same performances of a plain TCP socket (could encourage MPTCP adoption
- not sure that is good thing, anyway ;)

On the plus side, __mptcp_tcp_fallback() should be already hooked in
every place where we need special/single subflow handling. Should be
just a matter of simplify __mptcp_tcp_fallback() to just return the
subflow sk.

I guess/hope we can still call mptcp_subflow_tcp_fallback() - so that
at least we get no overhead in the BH processing for the fall-back sk.

Cheers,

Paolo

--===============2458147647376735559==--
