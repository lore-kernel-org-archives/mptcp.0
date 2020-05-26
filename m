Content-Type: multipart/mixed; boundary="===============5017100523090544980=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/4] mptcp: refactor token container.
Date: Tue, 26 May 2020 09:28:38 -0700
Message-ID: <alpine.OSX.2.22.394.2005260909260.8041@emfomenk-mobl.amr.corp.intel.com>
In-Reply-To: e43c8de25dbea8738f12f0d2a7cfbc1992282bd8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4504

--===============5017100523090544980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2020, Paolo Abeni wrote:

> On Fri, 2020-05-22 at 17:34 -0700, Mat Martineau wrote:
>> On Fri, 22 May 2020, Paolo Abeni wrote:
>>> -static RADIX_TREE(token_tree, GFP_ATOMIC);
>>> -static RADIX_TREE(token_req_tree, GFP_ATOMIC);
>>> -static DEFINE_SPINLOCK(token_tree_lock);
>>> -static int token_used __read_mostly;
>>> +#define TOKEN_MAX_RETRIES	4
>>> +#define TOKEN_MAX_CHAIN_LEN	4
>>> +
>>> +struct token_bucket {
>>> +	spinlock_t		lock;
>>> +	int			chain_len;
>>> +	struct hlist_nulls_head	req_chain;
>>> +	struct hlist_nulls_head	msk_chain;
>>> +};
>>
>> I remember a discussion a while ago about how we didn't really need two
>> radix trees for req & msk, since there's only one "token space".
>> Similarly, seems like we only need one linked list per bucket if we can
>> define a common structure to use in both sock types, like:
>>
>> struct mptcp_token_node {
>>  	struct hlist_nulls_node node;
>>  	u32 value;
>>  	bool is_req;
>> };
>>
>> It would use a little more space per mptcp_sock/req_sock and would requi=
re
>> extra code in the lookup to return the appropriate container pointer (req
>> or mptcp_sock), but would shrink the hash table or give us more buckets =
in
>> the same memory, which seems like a win.
>
> In v2 I had to drop the above idea because it would not fit with the
> current solution for the list corruption issue.
>

Yes, the list corruption issue is more important than the above =

optimization!

> Anyhow I have an addional doubt, how can the above fit the list
> traversal helper ? Don't we need to allocate 'mptcp_token_node'
> separatelly and keep a back ptr to the main socket/req???
>
> Otherwise 'mptcp_token_node' should have the same offset inside 'struct
> mptcp_sock' and inside 'struct mptcp_subflow_request_sock' to fit
> hlist_nulls_entry(), right?
>

The idea was to wrap up the information the list traversal helper needed =

in mptcp_token_node. Then use is_req to determine which structure type =

(mptcp_sock or mptcp_subflow_request_sock) to use with container_of().

--
Mat Martineau
Intel
--===============5017100523090544980==--
