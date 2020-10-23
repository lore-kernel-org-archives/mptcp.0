Content-Type: multipart/mixed; boundary="===============8054495903675472738=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v3] mptcp: track window announced to
 peer
Date: Fri, 23 Oct 2020 19:00:34 +0200
Message-ID: <9f1dde979aa49b9ccfd30c5cc93544c8d4a668ef.camel@redhat.com>
In-Reply-To: 20201023115934.GJ16895@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6423

--===============8054495903675472738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-23 at 13:59 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Thu, 2020-10-22 at 17:43 -0700, Mat Martineau wrote:
> > > On Thu, 22 Oct 2020, Florian Westphal wrote:
> > > @@ -1348,7 +1349,6 @@ static int __tcp_transmit_skb(struct sock *sk, =
struct sk_buff *skb,
> > > > 		}
> > > > 	}
> > > > =

> > > > -	tcp_options_write((__be32 *)(th + 1), tp, &opts);
> > > > 	skb_shinfo(skb)->gso_type =3D sk->sk_gso_type;
> > > > 	if (likely(!(tcb->tcp_flags & TCPHDR_SYN))) {
> > > > 		th->window      =3D htons(tcp_select_window(sk));
> > > =

> > > These lines of code between the old tcp_options_write() location and =
the =

> > > new location were last touched by Eric, doing some cache miss =

> > > optimizations. It doesn't seem like populating the TCP options just a=
fter =

> > > th->window instead of just before should behave similarly with the da=
ta =

> > > cache - are you concerned about this at all?
> > =

> > Thank you for the carefully review!
> > =

> > commit 51466a7545b73b7ad7bcfb33410d2823ccfaa501
> > Author: Eric Dumazet <edumazet(a)google.com>
> > Date:   Thu Jun 11 09:15:16 2015 -0700
> > =

> >     tcp: fill shinfo->gso_type at last moment
> > =

> > moves 'skb_shinfo(skb)->gso_type' initialization just after the option
> > write. Looking at the commit message, what actually makes a difference
> > in such commit is moving the mentioned assigment after the last xmit
> > check to avoid touching extra cache lines if not needed - and we
> > preserve that fact.
> > =

> > I think the above is sane performace-wise, but I guess Eric could still
> > teach me better ;)
> =

> If neither additional hooking nor change in tcp stack is possible only ch=
oice

I'm sorry, I was likely misleading. I mean: the patch looks fine and
safe to me. Perhpas we can try send that upstream as RFC to explicitly
ask for feedback ?!?

Thanks!

Paolo

--===============8054495903675472738==--
