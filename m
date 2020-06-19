Content-Type: multipart/mixed; boundary="===============6500491927683980363=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 4/4] mptcp: __mptcp_tcp_fallback() returns a
 struct sock
Date: Fri, 19 Jun 2020 11:51:28 +0200
Message-ID: <3d5fc65eae2bf64dd82e2f6b5d3f494c0b3eaa0c.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2006181700390.19717@adhawale-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4746

--===============6500491927683980363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-18 at 17:33 -0700, Mat Martineau wrote:
> On Thu, 18 Jun 2020, Paolo Abeni wrote:
> =

> > Currently __mptcp_tcp_fallback() always return NULL
> > on passive sockets. Callers don't need anymore a
> > struct socket, so let __mptcp_tcp_fallback return
> > the first subflow sock and cope correctly even
> > with passive sockets.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > net/mptcp/protocol.c | 22 ++++++++++------------
> > 1 file changed, 10 insertions(+), 12 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 75a96d8665e9..fb1f78ef3213 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -76,14 +76,14 @@ static bool mptcp_is_tcpsk(struct sock *sk)
> > 	return false;
> > }
> > =

> > -static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
> > +static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
> > {
> > 	sock_owned_by_me((const struct sock *)msk);
> > =

> > 	if (likely(!__mptcp_check_fallback(msk)))
> > 		return NULL;
> > =

> > -	return msk->subflow;
> > +	return msk->first;
> > }
> > =

> > static int __mptcp_socket_create(struct mptcp_sock *msk)
> > @@ -1605,7 +1605,7 @@ static int mptcp_setsockopt(struct sock *sk, int =
level, int optname,
> > 			    char __user *optval, unsigned int optlen)
> > {
> > 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> > -	struct socket *ssock;
> > +	struct sock *ssk;
> > =

> > 	pr_debug("msk=3D%p", msk);
> > =

> > @@ -1616,11 +1616,10 @@ static int mptcp_setsockopt(struct sock *sk, in=
t level, int optname,
> > 	 * to the one remaining subflow.
> > 	 */
> > 	lock_sock(sk);
> > -	ssock =3D __mptcp_tcp_fallback(msk);
> > +	ssk =3D __mptcp_tcp_fallback(msk);
> > 	release_sock(sk);
> > -	if (ssock)
> > -		return tcp_setsockopt(ssock->sk, level, optname, optval,
> > -				      optlen);
> > +	if (ssk)
> > +		return tcp_setsockopt(ssk, level, optname, optval, optlen);
> =

> Are there any TCP socket options on a passive socket that will cause =

> problems for MPTCP connections?
> =

> We've talked about keeping socket options limited on active MPTCP subflow=
s =

> and allowing all socket options after fallback, but I don't remember if w=
e =

> discussed socket options on the passive subflow socket.

I think we haven't discussed this item explicitly. Passive socket can
already fallback after the completion of the 3whs due to OoO 3rd ack
packet. With infinite mapping support they could fallback even later.
When that happens we have a fallen-back socket and
{set,get}sockopt() not working, and that looks incosistent to me. =


Still not a big deal, I guess we can skip this change if there is no
agreement.

Apropos: I just noticed that we can likely drop the lock/unlock pair
in {set,get}sockopt(). After: "net: mptcp: improve fallback to TCP" we
don't need them anymore, as checking the fallback status is an atomic
op and not reversible.

WDYT?

Thanks!

Paolo


--===============6500491927683980363==--
