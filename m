Content-Type: multipart/mixed; boundary="===============2045687341529508663=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/4] mptcp: refactor token container.
Date: Fri, 22 May 2020 18:10:21 -0700
Message-ID: <alpine.OSX.2.22.394.2005221800500.75205@rnpatelx-mobl1.amr.corp.intel.com>
In-Reply-To: 88cb0c469bbb09d0e935af1091b5a2c45375db45.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4463

--===============2045687341529508663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2020, Paolo Abeni wrote:

> On Fri, 2020-05-22 at 09:06 -0700, Christoph Paasch wrote:
>> Hello,
>>
>> On 22/05/20 - 12:10:11, Paolo Abeni wrote:
>>> Replace the radix tree with an hash table allocated
>>> at boot time. The radix tree has some short coming:
>>> a single lock is contented by all the mptcp operation,
>>> the lookup currently use such lock, and traversing
>>> all the items would require lock, too.
>>>
>>> With hash table instead we trade a little memory to
>>> address all the above - a per bucket lock is used.
>>>
>>> Additionally refactor the token creation to code to:
>>>
>>> - limit the number of consecutive attempts to a fixed
>>> maximum. Hitting an hash bucket with long chain is
>>> considered a failed attempt
>>>
>>> - accept() no longer can fail to to token management.
>>>
>>> - if token creation fails at connect() time, we do
>>> fallback to TCP (before the connection was closed)
>>>
>>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>>> ---
>>>  net/mptcp/protocol.c |  16 +--
>>>  net/mptcp/protocol.h |   5 +-
>>>  net/mptcp/subflow.c  |  10 +-
>>>  net/mptcp/token.c    | 246 ++++++++++++++++++++++++++++++-------------
>>>  4 files changed, 184 insertions(+), 93 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 16ca39ae314a..09152cb80e05 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1424,19 +1424,7 @@ struct sock *mptcp_sk_clone(const struct sock *s=
k,
>>>  	msk->token =3D subflow_req->token;
>>>  	msk->subflow =3D NULL;
>>>
>>> -	if (unlikely(mptcp_token_new_accept(subflow_req->token, nsk))) {
>>> -		nsk->sk_state =3D TCP_CLOSE;
>>> -		bh_unlock_sock(nsk);
>>> -
>>> -		/* we can't call into mptcp_close() here - possible BH context
>>> -		 * free the sock directly.
>>> -		 * sk_clone_lock() sets nsk refcnt to two, hence call sk_free()
>>> -		 * too.
>>> -		 */
>>> -		sk_common_release(nsk);
>>> -		sk_free(nsk);
>>> -		return NULL;
>>> -	}
>>> +	mptcp_token_accept(subflow_req, msk);
>>>
>>>  	msk->write_seq =3D subflow_req->idsn + 1;
>>>  	atomic64_set(&msk->snd_una, msk->write_seq);
>>> @@ -1654,7 +1642,6 @@ void mptcp_finish_connect(struct sock *ssk)
>>>  	 */
>>>  	WRITE_ONCE(msk->remote_key, subflow->remote_key);
>>>  	WRITE_ONCE(msk->local_key, subflow->local_key);
>>> -	WRITE_ONCE(msk->token, subflow->token);
>>>  	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
>>>  	WRITE_ONCE(msk->ack_seq, ack_seq);
>>>  	WRITE_ONCE(msk->can_ack, 1);
>>> @@ -1738,6 +1725,7 @@ static struct proto mptcp_prot =3D {
>>>  	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
>>>  	.sysctl_mem	=3D sysctl_tcp_mem,
>>>  	.obj_size	=3D sizeof(struct mptcp_sock),
>>> +	.slab_flags	=3D SLAB_TYPESAFE_BY_RCU,
>>
>> I wonder if you now need to be careful when allocating and zero'ing the =
socket,
>> same way it is happening in sock_copy ?
>>
>> In out-of-tree I had to take care of that by bringing back the clear_sk
>> callback in struct proto which will then be called in sk_prot_alloc:
>>
>> https://github.com/multipath-tcp/mptcp/blob/b86461666ede4e6da195431dcf26=
cd454bc547fe/net/mptcp/mptcp_ctrl.c#L2867
>>
>> https://github.com/multipath-tcp/mptcp/blob/f04a56b142b1cb209338392d5631=
02837db4e2d4/net/core/sock.c#L1486
>
> Indeed! I felt like I was missing some relevant point!
>
> re-adding the clear_sk callback for mptcp's sake does not look 110%
> nice. There are a few alternatives, which sounds equally suboptimal too
> me:
>
> 1) use plain RCU (with kfree_rcu() and all the relevant memory
> overhead) for the whole msk sockets (~1600 bytes for IPv4). We already
> to that for the subflow contexts (~200 bytes). This is simple, but the
> memory overhead could be relevant ?!?
>
> 	1.a) additionally srink the mptcp_sock structure, e.g. I'm wild
> guessing we can use 'struct sock' as the base type and add mptcp custom
> fields there ?!?
>
> 2) use ULP for msk, too. Move the token there (and possibly all mptcp-
> specific data), and use plain RCU to handle the context. As a downside
> we will need 2 allocations per accept() (the msk socket and the msk ulp
> context)
>
> Any other better option?!?
>

I lean toward option 1 so we don't have to change around ULP to not expose =

MPTCP stuff (we rely on a kernel sock check to keep the subflow ULP from =

being exposed to userspace). I'd also like to keep ULP available for =

possible TLS support someday.

--
Mat Martineau
Intel
--===============2045687341529508663==--
