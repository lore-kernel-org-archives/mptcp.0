Content-Type: multipart/mixed; boundary="===============9147333255280654390=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 07/11] mptcp: subflow: add
 mptcp_subflow_init_cookie_req helper
Date: Wed, 15 Jul 2020 15:13:21 +0200
Message-ID: <5d38b181ba69dcf6805c31889583bab68fd8ea87.camel@redhat.com>
In-Reply-To: 20200714193200.GG73500@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 5014

--===============9147333255280654390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-07-14 at 12:32 -0700, Christoph Paasch wrote:
> On 07/14/20 - 20:25, Florian Westphal wrote:
> > Will be used to initialize the mptcp request socket when a
> > MP_CAPABLE request was handled in syncookie mode, i.e. when a
> > TCP ACK containing a MP_CAPABLE option is a valid syncookie value.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  include/linux/tcp.h |  1 +
> >  include/net/mptcp.h | 10 +++++++++
> >  net/mptcp/subflow.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 64 insertions(+)
> > =

> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index 3bdec31ce8f4..1f706157b551 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -118,6 +118,7 @@ struct tcp_request_sock {
> >  	struct inet_request_sock 	req;
> >  	const struct tcp_request_sock_ops *af_specific;
> >  	u64				snt_synack; /* first SYNACK sent time */
> > +	u8				syncookie:1;
> =

> As this field will only be used in init_req, would it make sense to rather
> pass want_cookie from tcp_conn_request as an argument to the callback?

Otherwise, why don't a 'bool' instead? =


I think it would be nice nothing in the commmit message that this new
field fill a pre-existing one byte hole.
> =

> =

> Christoph
> =

> >  	bool				tfo_listener;
> >  	bool				is_mptcp;
> >  #if IS_ENABLED(CONFIG_MPTCP)
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 985344512f31..653acfe58d04 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -131,6 +131,9 @@ static inline bool mptcp_skb_can_collapse(const str=
uct sk_buff *to,
> >  }
> >  =

> >  void mptcp_seq_show(struct seq_file *seq);
> > +int mptcp_subflow_init_cookie_req(struct request_sock *req,
> > +				  const struct sock *sk_listener,
> > +				  struct sk_buff *skb);
> >  #else
> >  =

> >  static inline void mptcp_init(void)
> > @@ -204,6 +207,13 @@ static inline bool mptcp_skb_can_collapse(const st=
ruct sk_buff *to,
> >  =

> >  static inline void mptcp_space(const struct sock *ssk, int *s, int *fs=
) { }
> >  static inline void mptcp_seq_show(struct seq_file *seq) { }
> > +
> > +static inline int mptcp_subflow_init_cookie_req(struct request_sock *r=
eq,
> > +						const struct sock *sk_listener,
> > +						struct sk_buff *skb)
> > +{
> > +	return 0; /* TCP fallback */
> > +}
> >  #endif /* CONFIG_MPTCP */
> >  =

> >  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index cc9eaec14037..943fa650f1e9 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -154,6 +154,20 @@ static void subflow_init_req(struct request_sock *=
req,
> >  			get_random_bytes(&subflow_req->local_key, sizeof(subflow_req->local=
_key));
> >  		} while (subflow_req->local_key =3D=3D 0);
> >  =

> > +		if (unlikely(tcp_rsk(req)->syncookie)) {
> > +			mptcp_crypto_key_sha(subflow_req->local_key,
> > +					     &subflow_req->token,
> > +					     &subflow_req->idsn);
> > +			if (mptcp_token_get_sock(subflow_req->token)) {

Don't we need to sock_put() the returned sock here?
Perhpas we can use a new, different helper that just check for
existance, without touching the sock refcount? Looks like the sock
reference is not used below.

Thanks!

Paolo

--===============9147333255280654390==--
