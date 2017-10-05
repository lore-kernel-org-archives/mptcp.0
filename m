Content-Type: multipart/mixed; boundary="===============2811881348278633521=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 11/18] tcp_extra_option: Pass sock to prepare_req
Date: Thu, 05 Oct 2017 00:46:14 -0700
Message-ID: <20171005074614.GR4897@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1710041709340.28273@syyang-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 119

--===============2811881348278633521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04/10/17 - 17:33:24, Mat Martineau wrote:
> =

> On Tue, 3 Oct 2017, Christoph Paasch wrote:
> =

> > Will be needed for TCP_MD5.
> =

> Patches 7-10 look good to me. Some overlap with v2 of patch 6 that I post=
ed
> earlier today, so there will be some conflicts to sort out.

Ok, if 7-10 are fine, I will squash them into your patch so that we have a
single one for the extra options.

> =

> =

> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > ---
> > include/net/tcp.h     | 6 ++++--
> > net/ipv4/tcp.c        | 5 +++--
> > net/ipv4/tcp_output.c | 3 ++-
> > 3 files changed, 9 insertions(+), 5 deletions(-)
> > =

> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index a66671127936..bc3b8f655a43 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2123,7 +2123,8 @@ struct tcp_extra_option_ops {
> > 	unsigned int (*prepare_req)(struct sk_buff *skb, u8 flags,
> > 				    unsigned int remaining,
> > 				    struct tcp_out_options *opts,
> > -				    struct request_sock *req);
> > +				    struct request_sock *req,
> > +				    const struct sock *sk);
> > 	void (*write)(__be32 *ptr, struct sk_buff *skb,
> > 		      struct tcp_out_options *opts, struct sock *sk);
> > 	int (*add_header_len)(const struct sock *listener,
> > @@ -2144,7 +2145,8 @@ unsigned int tcp_extra_options_prepare(struct sk_=
buff *skb, u8 flags,
> > unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 flag=
s,
> > 					   unsigned int remaining,
> > 					   struct tcp_out_options *opts,
> > -					   struct request_sock *req);
> > +					   struct request_sock *req,
> > +					   const struct sock *sk);
> =

> v2 of the option registration patch will cause a problem here, since I
> consolidated the prepare callbacks.
> =

> Is it better to keep these callbacks separate to allow for different
> parameters? It might be possible to have one "get_length" callback instead
> of prepare/prepare_req/add_header_len, if we can determine a simple set of
> rules for the callback implementor to follow. This only makes sense if it
> looks like the callbacks are very similar to each other in practice - a
> quick look at the MD5 code makes me think that's the case.

prepare and prepare_req are fine to merge IMO.

add_header_len has quite different semantics in my opinion in that it gets
called during connect() and tcp_create_openreq_child(). And is rather stati=
c.
For example, for MPTCP prepare and add_header_len would be quite different.


Christoph

> =

> =

> Mat
> =

> =

> > void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
> > 			     struct tcp_out_options *opts, struct sock *sk);
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 3310e252b325..e6aea011b65d 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -3433,7 +3433,8 @@ unsigned int tcp_extra_options_prepare(struct sk_=
buff *skb, u8 flags,
> > unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 flag=
s,
> > 					   unsigned int remaining,
> > 					   struct tcp_out_options *opts,
> > -					   struct request_sock *req)
> > +					   struct request_sock *req,
> > +					   const struct sock *sk)
> > {
> > 	struct tcp_extra_option_ops *entry;
> > 	unsigned int used =3D 0;
> > @@ -3444,7 +3445,7 @@ unsigned int tcp_extra_options_prepare_req(struct=
 sk_buff *skb, u8 flags,
> > 			continue;
> > =

> > 		used +=3D entry->prepare_req(skb, flags, remaining - used, opts,
> > -					   req);
> > +					   req, sk);
> > 	}
> > 	rcu_read_unlock();
> > =

> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 522103a43941..1eb00e93c895 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -664,7 +664,8 @@ static unsigned int tcp_synack_options(const struct=
 sock *sk,
> > 							   TCPHDR_SYN |
> > 							   TCPHDR_ACK,
> > 							   remaining, opts,
> > -							   req);
> > +							   req,
> > +							   sk);
> > =

> > 	return MAX_TCP_OPTION_SPACE - remaining;
> > }
> > -- =

> > 2.14.1
> > =

> > =

> =

> --
> Mat Martineau
> Intel OTC

--===============2811881348278633521==--
