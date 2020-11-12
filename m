Content-Type: multipart/mixed; boundary="===============3743015012623107819=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH MPTCP 3/5] mptcp: add mptcp reset option support
Date: Thu, 12 Nov 2020 10:45:06 +0100
Message-ID: <20201112094506.GJ23619@breakpoint.cc>
In-Reply-To: e068a2a6-a55c-9948-b323-6413c2cf95f@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6667

--===============3743015012623107819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > #ifdef CONFIG_TCP_MD5SIG
> > -		__be32 opt[(TCPOLEN_MD5SIG_ALIGNED >> 2)];
> > +			   + (TCPOLEN_MD5SIG_ALIGNED >> 2)
> > #endif
> > +			];
> > 	} rep;
> > 	struct ip_reply_arg arg;
> > #ifdef CONFIG_TCP_MD5SIG
> > @@ -770,6 +772,23 @@ static void tcp_v4_send_reset(const struct sock *s=
k, struct sk_buff *skb)
> > 				     ip_hdr(skb)->daddr, &rep.th);
> > 	}
> > #endif
> > +	/* Can't co-exist with TCPMD5, hence check rep.opt[0] */
> =

> If they can't coexist, do we need space for both? (And, yes, I know I'm
> asking this after saying the single 32-bit value was not a big deal above)

Mhhh, that comment and ..

> > +	if (sk && sk_fullsock(sk) && sk_is_mptcp(sk) && rep.opt[0] =3D=3D 0) {

the rep.opt[0] test can be removed.  I do not see how we can have
sk_is_mptcp() evaluate to true while md5sig is enabled at same time.

Wrt. space -- right, we do not need both, so maybe add

#ifdef CONFIG_TCP_MD5SIG
# define TCP_RST_OPTLEN_WORDS (TCPOLEN_MD5SIG_ALIGNED >> 2)
#else
# define TCP_RST_OPTLEN_WORDS (TCPOLEN_MPTCP_RST >> 2)
#endif

and use that instead for opt[] size.

> > +static noinline void mptcp_established_options_rst(struct sock *sk, st=
ruct sk_buff *skb,
> =

> I'm assuming this is 'noinline' to keep mptcp_established_options() code
> size slightly smaller in the cache?

Yes, the idea was that this code path rarely deals with tcp reset
packets so that there is no need for inlining.

> I'm ok with that, of course, but curious
> if you think (or have data) that further code size reduction on that fast
> path would be worthwhile.

No, I do not have data for that (and I would not mind removing the
noinline).

As for making more size reductions, I do not think it makes sense to look i=
nto
such micro optimizations at this time.
--===============3743015012623107819==--
