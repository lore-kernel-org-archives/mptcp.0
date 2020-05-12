Content-Type: multipart/mixed; boundary="===============7398503785212598325=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/7] mptcp: break and restart in case
 mptcp sndbuf is full
Date: Tue, 12 May 2020 12:44:00 +0200
Message-ID: <20200512104400.GA11395@breakpoint.cc>
In-Reply-To: 0ff4205b5f3aa251fa738e8f751c10e7593af519.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4373

--===============7398503785212598325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2020-05-11 at 13:55 +0200, Florian Westphal wrote:
> > Its not enough to wait for TCP-level acks (free tcp send space).
> > We also hold on to any transmitted data for mptcp-level retransmits,
> > so we can't continue sending more data when there is no more mptcp send
> > buffer space available.
> > =

> > Therefore add needed check in mptcp_sendmsg, flush tcp data and
> > wait until mptcp snd space becomes available.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  net/mptcp/protocol.c | 37 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index e1f23016ed3f..d14e2aa30a14 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -653,6 +653,15 @@ static int mptcp_sendmsg_frag(struct sock *sk, str=
uct sock *ssk,
> >  	return ret;
> >  }
> >  =

> > +static void mptcp_nospace(struct mptcp_sock *msk, struct socket *sock)
> > +{
> > +	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
> > +	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
> > +
> > +	/* enables sk->write_space() callbacks */
> > +	set_bit(SOCK_NOSPACE, &sock->flags);
> > +}
> =

> (sharing on the ML a topic already discussed privatelly) I think we can
> use this helper also in ssk_check_wmem().

Thanks for pointing this out, I've split this into a new patch to reduce
size of this one.

--===============7398503785212598325==--
