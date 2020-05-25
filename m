Content-Type: multipart/mixed; boundary="===============3791077903043942563=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/4] mptcp: refactor token container.
Date: Mon, 25 May 2020 19:41:11 +0200
Message-ID: <e43c8de25dbea8738f12f0d2a7cfbc1992282bd8.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2005221656220.75205@rnpatelx-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4499

--===============3791077903043942563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-05-22 at 17:34 -0700, Mat Martineau wrote:
> On Fri, 22 May 2020, Paolo Abeni wrote:
> > -static RADIX_TREE(token_tree, GFP_ATOMIC);
> > -static RADIX_TREE(token_req_tree, GFP_ATOMIC);
> > -static DEFINE_SPINLOCK(token_tree_lock);
> > -static int token_used __read_mostly;
> > +#define TOKEN_MAX_RETRIES	4
> > +#define TOKEN_MAX_CHAIN_LEN	4
> > +
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

In v2 I had to drop the above idea because it would not fit with the
current solution for the list corruption issue.

Anyhow I have an addional doubt, how can the above fit the list
traversal helper ? Don't we need to allocate 'mptcp_token_node'
separatelly and keep a back ptr to the main socket/req???

Otherwise 'mptcp_token_node' should have the same offset inside 'struct
mptcp_sock' and inside 'struct mptcp_subflow_request_sock' to fit
hlist_nulls_entry(), right? =


Thanks,

Paolo

--===============3791077903043942563==--
