Content-Type: multipart/mixed; boundary="===============5300023215252886529=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/4] mptcp: refactor token container.
Date: Mon, 25 May 2020 10:10:09 +0200
Message-ID: <a451889bfdd8543d456ea9c6dc7ea3dc9043fb68.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2005221656220.75205@rnpatelx-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4472

--===============5300023215252886529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2020-05-22 at 17:34 -0700, Mat Martineau wrote:
> > +struct token_bucket {
> > +	spinlock_t		lock;
> > +	int			chain_len;
> > +	struct hlist_nulls_head	req_chain;
> > +	struct hlist_nulls_head	msk_chain;
> > +};
> =

> I remember a discussion a while ago about how we didn't really need two =

> radix trees for req & msk, since there's only one "token space". =

> Similarly, seems like we only need one linked list per bucket if we can =

> define a common structure to use in both sock types, like:
> =

> struct mptcp_token_node {
>  	struct hlist_nulls_node node;
>  	u32 value;
>  	bool is_req;
> };
> =

> It would use a little more space per mptcp_sock/req_sock and would requir=
e =

> extra code in the lookup to return the appropriate container pointer (req =

> or mptcp_sock), but would shrink the hash table or give us more buckets i=
n =

> the same memory, which seems like a win.

LGTM, I'll try that.

[...]
> > struct mptcp_sock *mptcp_token_get_sock(u32 token)
> > {
> > -	struct sock *conn;
> > -
> > -	spin_lock_bh(&token_tree_lock);
> > -	conn =3D radix_tree_lookup(&token_tree, token);
> > -	if (conn) {
> > -		/* token still reserved? */
> > -		if (conn =3D=3D (struct sock *)&token_used)
> > -			conn =3D NULL;
> > -		else
> > -			sock_hold(conn);
> > +	struct hlist_nulls_node *pos;
> > +	struct token_bucket *bucket;
> > +	struct mptcp_sock *msk;
> > +
> > +	rcu_read_lock();
> > +	bucket =3D token_bucket(token);
> > +
> > +again:
> > +	hlist_nulls_for_each_entry_rcu(msk, pos, &bucket->msk_chain,
> > +				       token_node) {
> > +		if (READ_ONCE(msk->token) !=3D token)
> > +			continue;
> > +		if (!refcount_inc_not_zero(&((struct sock *)msk)->sk_refcnt))
> > +			goto not_found;
> > +		if (READ_ONCE(msk->token) !=3D token)
> > +			goto again;
> =

> Checking msk->token twice here, but it doesn't look like it ever gets =

> changed after it's set?

AFAICT, this is the common list_nulls usage pattern. The problem is
that a msk can be freed and re-allocated concurrently by another CPU.
Since this lookup is lockless, the token value can possibly change
'under-the-wood' till we get a reference to the token - and forbit msk
de-allocation.

Cheers,

Paolo

--===============5300023215252886529==--
