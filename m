Content-Type: multipart/mixed; boundary="===============2550244341906863024=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 10/20] mptcp: Make subflow-list an RCU-list
Date: Wed, 19 Sep 2018 21:57:38 -0700
Message-ID: <alpine.OSX.2.21.1809192048580.45267@egliskay-mobl.amr.corp.intel.com>
In-Reply-To: 20180919170900.GS3125@MacBook-Pro-19.local
X-Status: 
X-Keywords:                  
X-UID: 754

--===============2550244341906863024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Sep 2018, Christoph Paasch wrote:

> On 18/09/18 - 11:22:22, Mat Martineau wrote:
>> On Tue, 18 Sep 2018, Christoph Paasch wrote:
>>
>>> On 17/09/18 - 17:08:33, Mat Martineau wrote:
>>>> On Fri, 14 Sep 2018, Christoph Paasch wrote:
>>>>
>>>>> mptcp_add_sock() will now be called without holding the meta-level lo=
ck.
>>>>> However, mptcp_add_sock() wants to add the subflow to the meta-level
>>>>> list, thus we need to protect this by a lock. We use the mpcb_list_lo=
ck
>>>>> for that.
>>>>>
>>>>> Now that we are locking during add/del, and want to allow lockless
>>>>> traversal of the list, this implies that we need to make it an RCU-li=
st.
>>>>>
>>>>> So, this patch transitions to the RCU hlist. The list-traversal macros
>>>>> (hlist_for_each_entry_rcu) require me to now pass the mptcp_tcp_sock =
to
>>>>> mptcp_for_each_*. So, I had to change all the places in the code where
>>>>> we call one of the list-traversal macros to adapt to this.
>>>>>
>>>>> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
>>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>>>>> (cherry picked from commit 7a662b690069642c138da16ff9396e6826fd0a95)
>>>>> ---
>>>>> include/net/mptcp.h        | 67 +++++++++++++++++-----------------
>>>>> net/ipv4/af_inet.c         |  9 ++---
>>>>> net/ipv4/ip_sockglue.c     |  7 ++--
>>>>> net/ipv4/tcp.c             | 31 +++++++++-------
>>>>> net/mptcp/mptcp_ctrl.c     | 89 ++++++++++++++++++++++++++++---------=
---------
>>>>> net/mptcp/mptcp_fullmesh.c | 28 ++++++++++-----
>>>>> net/mptcp/mptcp_input.c    | 44 +++++++++++++++--------
>>>>> net/mptcp/mptcp_output.c   | 38 +++++++++++++-------
>>>>> net/mptcp/mptcp_sched.c    | 21 +++++++----
>>>>> 9 files changed, 207 insertions(+), 127 deletions(-)
>>>>>
>>>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>>>> index c96da5e30d51..bf902a884212 100644
>>>>> --- a/include/net/mptcp.h
>>>>> +++ b/include/net/mptcp.h
>>>>> @@ -156,7 +156,7 @@ struct mptcp_options_received {
>>>>> };
>>>>>
>>>>> struct mptcp_tcp_sock {
>>>>> -	struct tcp_sock	*next;		/* Next subflow socket */
>>>>> +	struct hlist_node node;
>>>>> 	struct hlist_node cb_list;
>>>>> 	struct mptcp_options_received rx_opt;
>>>>>
>>>>> @@ -254,7 +254,7 @@ struct mptcp_sched_ops {
>>>>>
>>>>> struct mptcp_cb {
>>>>> 	/* list of sockets in this multipath connection */
>>>>> -	struct tcp_sock *connection_list;
>>>>> +	struct hlist_head conn_list;
>>>>> 	/* list of sockets that need a call to release_cb */
>>>>> 	struct hlist_head callback_list;
>>>>>
>>>>> @@ -309,7 +309,7 @@ struct mptcp_cb {
>>>>> 	/***** Start of fields, used for subflow establishment */
>>>>> 	struct sock *meta_sk;
>>>>>
>>>>> -	/* Master socket, also part of the connection_list, this
>>>>> +	/* Master socket, also part of the conn_list, this
>>>>> 	 * socket is the one that the application sees.
>>>>> 	 */
>>>>> 	struct sock *master_sk;
>>>>> @@ -661,21 +661,17 @@ extern struct workqueue_struct *mptcp_wq;
>>>>> 			pr_err(fmt, ##args);					\
>>>>> 	} while (0)
>>>>>
>>>>> -/* Iterates over all subflows */
>>>>> -#define mptcp_for_each_tp(mpcb, tp)					\
>>>>> -	for ((tp) =3D (mpcb)->connection_list; (tp); (tp) =3D (tp)->mptcp->=
next)
>>>>> +static inline struct sock *mptcp_to_sock(const struct mptcp_tcp_sock=
 *mptcp)
>>>>> +{
>>>>> +	return (struct sock *)mptcp->tp;
>>>>> +}
>>>>>
>>>>> -#define mptcp_for_each_sk(mpcb, sk)					\
>>>>> -	for ((sk) =3D (struct sock *)(mpcb)->connection_list;		\
>>>>> -	     sk;							\
>>>>> -	     sk =3D (struct sock *)tcp_sk(sk)->mptcp->next)
>>>>> +#define mptcp_for_each_sub(__mpcb, __mptcp)					\
>>>>> +	hlist_for_each_entry_rcu(__mptcp, &((__mpcb)->conn_list), node)
>>>>
>>>> When I asked about rcu synchronization with an earlier version of this=
 patch
>>>> set, you mentioned that it didn't look like an issue because the lifet=
ime of
>>>> the subflow sockets was still managed under a lock - the main reason t=
o use
>>>> rcu here is to allow adding to the list while the MPTCP-level lock is =
held.
>>>
>>> And mostly, to be able to iterate over the list whithout the need to ho=
ld
>>> any lock. That way, we can do lockless subflow establishment.
>>
>> There needs to be *some* lock to iterate over an RCU list, right? Even if
>> it's just the non-blocking rcu_read_lock?
>
> In the lockless subflow establishment case, we are already in an
> rcu_read_lock'd region.
>
> You can check __inet_lookup_established(), which also iterates over an
> RCU-list without explicitly taking the read-lock.
> Because, in ip_local_deliver_finish, in order to get access to the
> protocol-handler (tcp_v4_rcv()), we need to do the rcu_read_lock(). And
> thus, we are always inside tcp_v4_rcv() while holding the rcu_read_lock().
>
>
> In all the other cases (where we are not coming from tcp_v4_rcv(), but
> either from a timer or from user-space), we are holding the meta-socket l=
ock (either
> the spin-lock or the other lock_sock()).
>
> It's the same behavior as for normal TCP sockets, where we are not doing =
an explicit
> rcu_read_lock() to dereference tp->md5sig_info (as can be seen through the
> rcu_dereference_check).

Ok, that lines up with what I understood from the code.

>
>> You had mentioned in a previous response that traversal of the list alwa=
ys
>> happened with the MPTCP-level lock held
>> (https://lists.01.org/pipermail/mptcp/2018-June/000665.html) - which I b=
ring
>> up not as a "gotcha" but hopefully to either jog some memories or help us
>> collectively understand the locking model in this patch. Without
>> rcu_read_lock, I was depending on that MPTCP-level lock to prevent delet=
ion
>> during iteration.
>
> Yes, it has been a long time and my memory might have been a bit outdated=
 on
> this patch-set. :)
>
> Next time, let's try to dive into this level of detail during the submiss=
ion
> on mptcp-dev.

Yes, makes sense to have the discussion early on for changes that will end =

up on both branches.

>
>
> But yeah, as I describe above, we are always holding a lock, either the
> rcu_read_lock, the meta's spin-lock or mark the meta-socket as
> "owned-by-user" through lock_sock().
>
>>> I think that's a very typical use of RCU-lists :)
>>
>> Idiomatic RCU code I've seen (note: that's far from all RCU code :) ) and
>> documentation (like
>> https://www.kernel.org/doc/Documentation/RCU/checklist.txt item #2
>> rule-of-thumb) involve using rcu_read_lock/rcu_read_unlock while iterati=
ng
>> and then deferring some operations until the end of the grace period. Wh=
en
>> you get to the "Unless..." sentence at the end of checklist #2 I think we
>> may be covered by the MPTCP-level lock, but it's uncommon enough usage t=
hat
>> I think it's helpful to explain.
>
> The "Unless..." part seems to me to be common in the networking subsystem=
 as
> we have this concept of sockets being in an RCU-protected hash-table while
> also having a lock and being reference-counted.

Thanks for the explanations in this thread - I'll try to get more context =

from the other RCU usage in the networking stack. At this point in the =

process it works to merge the series and confirm the locking behavior from =

there. If anything comes up we'll fix it.

Regards,
Mat


>
>>>> That seems to also imply that rcu_read_lock/rcu_read_unlock are not re=
quired
>>>> when using these list iteration macros. This is an unconventional use =
of rcu
>>>> list entries, so it would be helpful to explain the expected use of the
>>>> conn_list. I think the main things are the lack of rcu_read_lock during
>>>> iteration, and which locks to hold during iterate, add, and delete. Ma=
ybe
>>>> the macro could check the state of the lock when built for debug?
>>>
>>> Currently, we don't have a "build-for-debug"-macro. But, definitely
>>> something we could add in the future.
>>>
>>>>
>>>>>
>>>>> -#define mptcp_for_each_sk_safe(__mpcb, __sk, __temp)			\
>>>>> -	for (__sk =3D (struct sock *)(__mpcb)->connection_list,		\
>>>>> -	     __temp =3D __sk ? (struct sock *)tcp_sk(__sk)->mptcp->next : N=
ULL; \
>>>>> -	     __sk;							\
>>>>> -	     __sk =3D __temp,						\
>>>>> -	     __temp =3D __sk ? (struct sock *)tcp_sk(__sk)->mptcp->next : N=
ULL)
>>>>> +/* Must be called with the appropriate lock held */
>>>>
>>>> If MPTCP-level socket lock is the appropriate lock, can that be specif=
ied
>>>> here?
>>>
>>> The comment is kinda useless IMO. Seems to me to be rather a copy-paste
>>> issue as I was developing this part here.
>>>
>>>>> +#define mptcp_for_each_sub_safe(__mpcb, __mptcp, __tmp)				\
>>>>> +	hlist_for_each_entry_safe(__mptcp, __tmp, &((__mpcb)->conn_list), n=
ode)
>>>>
>>>> The comment just before mptcp_for_each_sub_safe seems to imply that the
>>>> difference between the two macros is that one needs a lock and one doe=
sn't,
>>>> but isn't the second (_safe) macro intended for use when subflows are =
being
>>>> removed from the list while iterating? Could you add a comment to clar=
ify?
>>>
>>> Yes, with the "appropriate lock" comment and _safe in itself this is ki=
nda
>>> confusing. I will clarify that, saying that the _safe macro is there to
>>> allow removal while iterating and entirely remove the "appropriate lock"
>>> comment.
>>>
>>> I am going to do this through a separate patch to mptcp_trunk that I wi=
ll
>>> forward-port to mptcp-net-next later on.
>>
>> Sure, no problem using a later patch to clarify the comments.
>
> Sounds good!
>
>
> Thanks,
> Christoph
>
>>
>>
>> Mat
>>
>>>
>>>
>>> Christoph
>>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>> Mat
>>>>
>>>>
>>>>>
>>>>> /* Iterates over all bit set to 1 in a bitset */
>>>>> #define mptcp_for_each_bit_set(b, i)					\
>>>>> @@ -923,12 +919,14 @@ struct request_sock *rev_mptcp_rsk(const struct=
 mptcp_request_sock *req)
>>>>>
>>>>> static inline bool mptcp_can_sendpage(struct sock *sk)
>>>>> {
>>>>> -	struct sock *sk_it;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>>
>>>>> 	if (tcp_sk(sk)->mpcb->dss_csum)
>>>>> 		return false;
>>>>>
>>>>> -	mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it) {
>>>>> +	mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
>>>>> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 		if (!(sk_it->sk_route_caps & NETIF_F_SG))
>>>>> 			return false;
>>>>> 	}
>>>>> @@ -962,9 +960,12 @@ static inline void mptcp_send_reset(struct sock =
*sk)
>>>>> static inline void mptcp_sub_force_close_all(struct mptcp_cb *mpcb,
>>>>> 					     struct sock *except)
>>>>> {
>>>>> -	struct sock *sk_it, *tmp;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> +	struct hlist_node *tmp;
>>>>> +
>>>>> +	mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
>>>>> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>>
>>>>> -	mptcp_for_each_sk_safe(mpcb, sk_it, tmp) {
>>>>> 		if (sk_it !=3D except)
>>>>> 			mptcp_send_reset(sk_it);
>>>>> 	}
>>>>> @@ -1150,12 +1151,14 @@ static inline int mptcp_sk_can_send_ack(const=
 struct sock *sk)
>>>>>
>>>>> static inline bool mptcp_can_sg(const struct sock *meta_sk)
>>>>> {
>>>>> -	struct sock *sk;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>>
>>>>> 	if (tcp_sk(meta_sk)->mpcb->dss_csum)
>>>>> 		return false;
>>>>>
>>>>> -	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
>>>>> +	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
>>>>> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 		if (!mptcp_sk_can_send(sk))
>>>>> 			continue;
>>>>> 		if (!(sk->sk_route_caps & NETIF_F_SG))
>>>>> @@ -1166,9 +1169,9 @@ static inline bool mptcp_can_sg(const struct so=
ck *meta_sk)
>>>>>
>>>>> static inline void mptcp_set_rto(struct sock *sk)
>>>>> {
>>>>> -	struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> -	struct sock *sk_it;
>>>>> 	struct inet_connection_sock *micsk =3D inet_csk(mptcp_meta_sk(sk));
>>>>> +	struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	__u32 max_rto =3D 0;
>>>>>
>>>>> 	/* We are in recovery-phase on the MPTCP-level. Do not update the
>>>>> @@ -1177,7 +1180,9 @@ static inline void mptcp_set_rto(struct sock *s=
k)
>>>>> 	if (micsk->icsk_retransmits)
>>>>> 		return;
>>>>>
>>>>> -	mptcp_for_each_sk(tp->mpcb, sk_it) {
>>>>> +	mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 		if ((mptcp_sk_can_send(sk_it) || sk->sk_state =3D=3D TCP_SYN_RECV) =
&&
>>>>> 		    inet_csk(sk_it)->icsk_rto > max_rto)
>>>>> 			max_rto =3D inet_csk(sk_it)->icsk_rto;
>>>>> @@ -1266,10 +1271,10 @@ static inline bool mptcp_can_new_subflow(cons=
t struct sock *meta_sk)
>>>>>
>>>>> static inline int mptcp_subflow_count(const struct mptcp_cb *mpcb)
>>>>> {
>>>>> -	struct sock *sk;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	int i =3D 0;
>>>>>
>>>>> -	mptcp_for_each_sk(mpcb, sk)
>>>>> +	mptcp_for_each_sub(mpcb, mptcp)
>>>>> 		i++;
>>>>>
>>>>> 	return i;
>>>>> @@ -1287,12 +1292,8 @@ bool mptcp_prune_ofo_queue(struct sock *sk);
>>>>> 	do {				\
>>>>> 	} while (0)
>>>>>
>>>>> -/* Without MPTCP, we just do one iteration
>>>>> - * over the only socket available. This assumes that
>>>>> - * the sk/tp arg is the socket in that case.
>>>>> - */
>>>>> -#define mptcp_for_each_sk(mpcb, sk)
>>>>> -#define mptcp_for_each_sk_safe(__mpcb, __sk, __temp)
>>>>> +#define mptcp_for_each_sub(__mpcb, __mptcp)					\
>>>>> +	if (0)
>>>>>
>>>>> #define MPTCP_INC_STATS(net, field)	\
>>>>> 	do {				\
>>>>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>>>>> index 39750cf184db..16ecdd58cef7 100644
>>>>> --- a/net/ipv4/af_inet.c
>>>>> +++ b/net/ipv4/af_inet.c
>>>>> @@ -744,13 +744,14 @@ int inet_accept(struct socket *sock, struct soc=
ket *newsock, int flags,
>>>>> 	sock_rps_record_flow(sk2);
>>>>>
>>>>> 	if (sk2->sk_protocol =3D=3D IPPROTO_TCP && mptcp(tcp_sk(sk2))) {
>>>>> -		struct sock *sk_it =3D sk2;
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>>
>>>>> -		mptcp_for_each_sk(tcp_sk(sk2)->mpcb, sk_it)
>>>>> -			sock_rps_record_flow(sk_it);
>>>>> +		mptcp_for_each_sub(tcp_sk(sk2)->mpcb, mptcp) {
>>>>> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
>>>>> +		}
>>>>>
>>>>> 		if (tcp_sk(sk2)->mpcb->master_sk) {
>>>>> -			sk_it =3D tcp_sk(sk2)->mpcb->master_sk;
>>>>> +			struct sock *sk_it =3D tcp_sk(sk2)->mpcb->master_sk;
>>>>>
>>>>> 			write_lock_bh(&sk_it->sk_callback_lock);
>>>>> 			sk_it->sk_wq =3D newsock->wq;
>>>>> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
>>>>> index 88643e261d6e..60eff9052720 100644
>>>>> --- a/net/ipv4/ip_sockglue.c
>>>>> +++ b/net/ipv4/ip_sockglue.c
>>>>> @@ -756,8 +756,11 @@ static int do_ip_setsockopt(struct sock *sk, int=
 level,
>>>>> 			sk_dst_reset(sk);
>>>>> 			/* Update TOS on mptcp subflow */
>>>>> 			if (is_meta_sk(sk)) {
>>>>> -				struct sock *sk_it;
>>>>> -				mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it) {
>>>>> +				struct mptcp_tcp_sock *mptcp;
>>>>> +
>>>>> +				mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
>>>>> +					struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 					if (inet_sk(sk_it)->tos !=3D inet_sk(sk)->tos) {
>>>>> 						inet_sk(sk_it)->tos =3D inet_sk(sk)->tos;
>>>>> 						sk_it->sk_priority =3D sk->sk_priority;
>>>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>>>> index 59ac6ef82258..a5818c50fa31 100644
>>>>> --- a/net/ipv4/tcp.c
>>>>> +++ b/net/ipv4/tcp.c
>>>>> @@ -823,9 +823,11 @@ ssize_t tcp_splice_read(struct socket *sock, lof=
f_t *ppos,
>>>>>
>>>>> #ifdef CONFIG_MPTCP
>>>>> 	if (mptcp(tcp_sk(sk))) {
>>>>> -		struct sock *sk_it;
>>>>> -		mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it)
>>>>> -			sock_rps_record_flow(sk_it);
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> +
>>>>> +		mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
>>>>> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
>>>>> +		}
>>>>> 	}
>>>>> #endif
>>>>>
>>>>> @@ -993,7 +995,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct =
page *page, int offset,
>>>>> 	}
>>>>>
>>>>> 	if (mptcp(tp)) {
>>>>> -		struct sock *sk_it =3D sk;
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>>
>>>>> 		/* We must check this with socket-lock hold because we iterate
>>>>> 		 * over the subflows.
>>>>> @@ -1008,8 +1010,9 @@ ssize_t do_tcp_sendpages(struct sock *sk, struc=
t page *page, int offset,
>>>>> 			return ret;
>>>>> 		}
>>>>>
>>>>> -		mptcp_for_each_sk(tp->mpcb, sk_it)
>>>>> -			sock_rps_record_flow(sk_it);
>>>>> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
>>>>> +		}
>>>>> 	}
>>>>>
>>>>> 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>>>>> @@ -1288,9 +1291,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct=
 msghdr *msg, size_t size)
>>>>> 	}
>>>>>
>>>>> 	if (mptcp(tp)) {
>>>>> -		struct sock *sk_it =3D sk;
>>>>> -		mptcp_for_each_sk(tp->mpcb, sk_it)
>>>>> -			sock_rps_record_flow(sk_it);
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> +
>>>>> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
>>>>> +		}
>>>>> 	}
>>>>>
>>>>> 	if (unlikely(tp->repair)) {
>>>>> @@ -2006,9 +2011,11 @@ int tcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len, int nonblock,
>>>>>
>>>>> #ifdef CONFIG_MPTCP
>>>>> 	if (mptcp(tp)) {
>>>>> -		struct sock *sk_it;
>>>>> -		mptcp_for_each_sk(tp->mpcb, sk_it)
>>>>> -			sock_rps_record_flow(sk_it);
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> +
>>>>> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
>>>>> +		}
>>>>> 	}
>>>>> #endif
>>>>>
>>>>> diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
>>>>> index ce098de43145..3de08e11dc17 100644
>>>>> --- a/net/mptcp/mptcp_ctrl.c
>>>>> +++ b/net/mptcp/mptcp_ctrl.c
>>>>> @@ -561,10 +561,12 @@ void mptcp_hash_remove_bh(struct tcp_sock *meta=
_tp)
>>>>> struct sock *mptcp_select_ack_sock(const struct sock *meta_sk)
>>>>> {
>>>>> 	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>>>>> -	struct sock *sk, *rttsk =3D NULL, *lastsk =3D NULL;
>>>>> +	struct sock *rttsk =3D NULL, *lastsk =3D NULL;
>>>>> 	u32 min_time =3D 0, last_active =3D 0;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>>
>>>>> -	mptcp_for_each_sk(meta_tp->mpcb, sk) {
>>>>> +	mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
>>>>> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 		struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> 		u32 elapsed;
>>>>>
>>>>> @@ -697,7 +699,8 @@ void mptcp_sock_destruct(struct sock *sk)
>>>>> void mptcp_destroy_sock(struct sock *sk)
>>>>> {
>>>>> 	if (is_meta_sk(sk)) {
>>>>> -		struct sock *sk_it, *tmpsk;
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> +		struct hlist_node *tmp;
>>>>>
>>>>> 		__skb_queue_purge(&tcp_sk(sk)->mpcb->reinject_queue);
>>>>>
>>>>> @@ -707,7 +710,9 @@ void mptcp_destroy_sock(struct sock *sk)
>>>>> 		 * not have been closed properly (as we are waiting for the
>>>>> 		 * DATA_ACK of the DATA_FIN).
>>>>> 		 */
>>>>> -		mptcp_for_each_sk_safe(tcp_sk(sk)->mpcb, sk_it, tmpsk) {
>>>>> +		mptcp_for_each_sub_safe(tcp_sk(sk)->mpcb, mptcp, tmp) {
>>>>> +			struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 			/* Already did call tcp_close - waiting for graceful
>>>>> 			 * closure, or if we are retransmitting fast-close on
>>>>> 			 * the subflow. The reset (or timeout) will kill the
>>>>> @@ -1303,6 +1308,7 @@ static int mptcp_alloc_mpcb(struct sock *meta_s=
k, __u64 remote_key,
>>>>> 	INIT_LIST_HEAD(&mpcb->tw_list);
>>>>>
>>>>> 	INIT_HLIST_HEAD(&mpcb->callback_list);
>>>>> +	INIT_HLIST_HEAD(&mpcb->conn_list);
>>>>> 	spin_lock_init(&mpcb->mpcb_list_lock);
>>>>>
>>>>> 	mptcp_mpcb_inherit_sockopts(meta_sk, master_sk);
>>>>> @@ -1392,8 +1398,12 @@ int mptcp_add_sock(struct sock *meta_sk, struc=
t sock *sk, u8 loc_id, u8 rem_id,
>>>>> 	sock_hold(meta_sk);
>>>>> 	refcount_inc(&mpcb->mpcb_refcnt);
>>>>>
>>>>> -	tp->mptcp->next =3D mpcb->connection_list;
>>>>> -	mpcb->connection_list =3D tp;
>>>>> +	local_bh_disable();
>>>>> +	spin_lock(&mpcb->mpcb_list_lock);
>>>>> +	hlist_add_head_rcu(&tp->mptcp->node, &mpcb->conn_list);
>>>>> +	spin_unlock(&mpcb->mpcb_list_lock);
>>>>> +	local_bh_enable();
>>>>> +
>>>>> 	tp->mptcp->attached =3D 1;
>>>>>
>>>>> 	atomic_add(atomic_read(&((struct sock *)tp)->sk_rmem_alloc),
>>>>> @@ -1437,14 +1447,13 @@ int mptcp_add_sock(struct sock *meta_sk, stru=
ct sock *sk, u8 loc_id, u8 rem_id,
>>>>>
>>>>> void mptcp_del_sock(struct sock *sk)
>>>>> {
>>>>> -	struct tcp_sock *tp =3D tcp_sk(sk), *tp_prev;
>>>>> +	struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> 	struct mptcp_cb *mpcb;
>>>>>
>>>>> 	if (!tp->mptcp || !tp->mptcp->attached)
>>>>> 		return;
>>>>>
>>>>> 	mpcb =3D tp->mpcb;
>>>>> -	tp_prev =3D mpcb->connection_list;
>>>>>
>>>>> 	if (mpcb->pm_ops->delete_subflow)
>>>>> 		mpcb->pm_ops->delete_subflow(sk);
>>>>> @@ -1453,17 +1462,10 @@ void mptcp_del_sock(struct sock *sk)
>>>>> 		    __func__, mpcb->mptcp_loc_token, tp->mptcp->path_index,
>>>>> 		    sk->sk_state, is_meta_sk(sk));
>>>>>
>>>>> -	if (tp_prev =3D=3D tp) {
>>>>> -		mpcb->connection_list =3D tp->mptcp->next;
>>>>> -	} else {
>>>>> -		for (; tp_prev && tp_prev->mptcp->next; tp_prev =3D tp_prev->mptcp=
->next) {
>>>>> -			if (tp_prev->mptcp->next =3D=3D tp) {
>>>>> -				tp_prev->mptcp->next =3D tp->mptcp->next;
>>>>> -				break;
>>>>> -			}
>>>>> -		}
>>>>> -	}
>>>>> -	tp->mptcp->next =3D NULL;
>>>>> +	spin_lock(&mpcb->mpcb_list_lock);
>>>>> +	hlist_del_init_rcu(&tp->mptcp->node);
>>>>> +	spin_unlock(&mpcb->mpcb_list_lock);
>>>>> +
>>>>> 	tp->mptcp->attached =3D 0;
>>>>> 	mpcb->path_index_bits &=3D ~(1 << tp->mptcp->path_index);
>>>>>
>>>>> @@ -1510,8 +1512,8 @@ void mptcp_update_metasocket(const struct sock =
*meta_sk)
>>>>> void mptcp_cleanup_rbuf(struct sock *meta_sk, int copied)
>>>>> {
>>>>> 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>>>>> -	struct sock *sk;
>>>>> 	bool recheck_rcv_window =3D false;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	__u32 rcv_window_now =3D 0;
>>>>>
>>>>> 	if (copied > 0 && !(meta_sk->sk_shutdown & RCV_SHUTDOWN)) {
>>>>> @@ -1522,7 +1524,8 @@ void mptcp_cleanup_rbuf(struct sock *meta_sk, i=
nt copied)
>>>>> 			recheck_rcv_window =3D true;
>>>>> 	}
>>>>>
>>>>> -	mptcp_for_each_sk(meta_tp->mpcb, sk) {
>>>>> +	mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
>>>>> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 		struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> 		const struct inet_connection_sock *icsk =3D inet_csk(sk);
>>>>>
>>>>> @@ -1709,10 +1712,13 @@ EXPORT_SYMBOL(mptcp_sub_force_close);
>>>>>  */
>>>>> void mptcp_update_sndbuf(const struct tcp_sock *tp)
>>>>> {
>>>>> -	struct sock *meta_sk =3D tp->meta_sk, *sk;
>>>>> +	struct sock *meta_sk =3D tp->meta_sk;
>>>>> 	int new_sndbuf =3D 0, old_sndbuf =3D meta_sk->sk_sndbuf;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> +
>>>>> +	mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>>
>>>>> -	mptcp_for_each_sk(tp->mpcb, sk) {
>>>>> 		if (!mptcp_sk_can_send(sk))
>>>>> 			continue;
>>>>>
>>>>> @@ -1741,8 +1747,8 @@ void mptcp_update_sndbuf(const struct tcp_sock =
*tp)
>>>>> void mptcp_close(struct sock *meta_sk, long timeout)
>>>>> {
>>>>> 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>>>>> -	struct sock *sk_it, *tmpsk;
>>>>> 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	struct sk_buff *skb;
>>>>> 	int data_was_unread =3D 0;
>>>>> 	int state;
>>>>> @@ -1775,7 +1781,12 @@ void mptcp_close(struct sock *meta_sk, long ti=
meout)
>>>>>
>>>>> 	/* If socket has been already reset (e.g. in tcp_reset()) - kill it.=
 */
>>>>> 	if (meta_sk->sk_state =3D=3D TCP_CLOSE) {
>>>>> -		mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> +		struct hlist_node *tmp;
>>>>> +
>>>>> +		mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
>>>>> +			struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 			if (tcp_sk(sk_it)->send_mp_fclose)
>>>>> 				continue;
>>>>> 			mptcp_sub_close(sk_it, 0);
>>>>> @@ -1796,10 +1807,14 @@ void mptcp_close(struct sock *meta_sk, long t=
imeout)
>>>>> 	} else if (tcp_close_state(meta_sk)) {
>>>>> 		mptcp_send_fin(meta_sk);
>>>>> 	} else if (meta_tp->snd_una =3D=3D meta_tp->write_seq) {
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> +		struct hlist_node *tmp;
>>>>> +
>>>>> 		/* The DATA_FIN has been sent and acknowledged
>>>>> 		 * (e.g., by sk_shutdown). Close all the other subflows
>>>>> 		 */
>>>>> -		mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
>>>>> +		mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
>>>>> +			struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> 			unsigned long delay =3D 0;
>>>>> 			/* If we are the passive closer, don't trigger
>>>>> 			 * subflow-fin until the subflow has been finned
>>>>> @@ -1823,7 +1838,9 @@ void mptcp_close(struct sock *meta_sk, long tim=
eout)
>>>>> 	/* socket will be freed after mptcp_close - we have to prevent
>>>>> 	 * access from the subflows.
>>>>> 	 */
>>>>> -	mptcp_for_each_sk(mpcb, sk_it) {
>>>>> +	mptcp_for_each_sub(mpcb, mptcp) {
>>>>> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 		/* Similar to sock_orphan, but we don't set it DEAD, because
>>>>> 		 * the callbacks are still set and must be called.
>>>>> 		 */
>>>>> @@ -1908,8 +1925,9 @@ void mptcp_close(struct sock *meta_sk, long tim=
eout)
>>>>>
>>>>> void mptcp_disconnect(struct sock *sk)
>>>>> {
>>>>> -	struct sock *subsk, *tmpsk;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> +	struct hlist_node *tmp;
>>>>>
>>>>> 	__skb_queue_purge(&tp->mpcb->reinject_queue);
>>>>>
>>>>> @@ -1917,7 +1935,9 @@ void mptcp_disconnect(struct sock *sk)
>>>>> 		mptcp_hash_remove_bh(tp);
>>>>>
>>>>> 	local_bh_disable();
>>>>> -	mptcp_for_each_sk_safe(tp->mpcb, subsk, tmpsk) {
>>>>> +	mptcp_for_each_sub_safe(tp->mpcb, mptcp, tmp) {
>>>>> +		struct sock *subsk =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 		/* The socket will get removed from the subsocket-list
>>>>> 		 * and made non-mptcp by setting mpc to 0.
>>>>> 		 *
>>>>> @@ -2606,7 +2626,6 @@ static void mptcp_get_sub_info(struct sock *sk,=
 struct mptcp_sub_info *info)
>>>>> int mptcp_get_info(const struct sock *meta_sk, char __user *optval, i=
nt optlen)
>>>>> {
>>>>> 	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>>>>> -	struct sock *sk;
>>>>>
>>>>> 	struct mptcp_meta_info meta_info;
>>>>> 	struct mptcp_info m_info;
>>>>> @@ -2652,16 +2671,17 @@ int mptcp_get_info(const struct sock *meta_sk=
, char __user *optval, int optlen)
>>>>>
>>>>> 	if (m_info.subflows) {
>>>>> 		unsigned int len, sub_len =3D 0;
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> 		char __user *ptr;
>>>>>
>>>>> 		ptr =3D (char __user *)m_info.subflows;
>>>>> 		len =3D m_info.sub_len;
>>>>>
>>>>> -		mptcp_for_each_sk(meta_tp->mpcb, sk) {
>>>>> +		mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
>>>>> 			struct tcp_info t_info;
>>>>> 			unsigned int tmp_len;
>>>>>
>>>>> -			tcp_get_info(sk, &t_info);
>>>>> +			tcp_get_info(mptcp_to_sock(mptcp), &t_info);
>>>>>
>>>>> 			tmp_len =3D min_t(unsigned int, len, info_len);
>>>>> 			len -=3D tmp_len;
>>>>> @@ -2681,6 +2701,7 @@ int mptcp_get_info(const struct sock *meta_sk, =
char __user *optval, int optlen)
>>>>>
>>>>> 	if (m_info.subflow_info) {
>>>>> 		unsigned int len, sub_info_len, total_sub_info_len =3D 0;
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> 		char __user *ptr;
>>>>>
>>>>> 		ptr =3D (char __user *)m_info.subflow_info;
>>>>> @@ -2690,11 +2711,11 @@ int mptcp_get_info(const struct sock *meta_sk=
, char __user *optval, int optlen)
>>>>> 				     sizeof(struct mptcp_sub_info));
>>>>> 		m_info.sub_info_len =3D sub_info_len;
>>>>>
>>>>> -		mptcp_for_each_sk(meta_tp->mpcb, sk) {
>>>>> +		mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
>>>>> 			struct mptcp_sub_info m_sub_info;
>>>>> 			unsigned int tmp_len;
>>>>>
>>>>> -			mptcp_get_sub_info(sk, &m_sub_info);
>>>>> +			mptcp_get_sub_info(mptcp_to_sock(mptcp), &m_sub_info);
>>>>>
>>>>> 			tmp_len =3D min_t(unsigned int, len, sub_info_len);
>>>>> 			len -=3D tmp_len;
>>>>> diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
>>>>> index 6f10844d55a5..636642287541 100644
>>>>> --- a/net/mptcp/mptcp_fullmesh.c
>>>>> +++ b/net/mptcp/mptcp_fullmesh.c
>>>>> @@ -903,8 +903,9 @@ static void mptcp_address_worker(struct work_stru=
ct *work)
>>>>> 			}
>>>>>
>>>>> 			if (event->code =3D=3D MPTCP_EVENT_DEL) {
>>>>> -				struct sock *sk, *tmpsk;
>>>>> +				struct mptcp_tcp_sock *mptcp;
>>>>> 				struct mptcp_loc_addr *mptcp_local;
>>>>> +				struct hlist_node *tmp;
>>>>> 				bool found =3D false;
>>>>>
>>>>> 				mptcp_local =3D rcu_dereference_bh(fm_ns->local);
>>>>> @@ -914,7 +915,9 @@ static void mptcp_address_worker(struct work_stru=
ct *work)
>>>>> 					update_addr_bitfields(meta_sk, mptcp_local);
>>>>>
>>>>> 				/* Look for the socket and remove him */
>>>>> -				mptcp_for_each_sk_safe(mpcb, sk, tmpsk) {
>>>>> +				mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
>>>>> +					struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 					if ((event->family =3D=3D AF_INET6 &&
>>>>> 					     (sk->sk_family =3D=3D AF_INET ||
>>>>> 					      mptcp_v6_is_v4_mapped(sk))) ||
>>>>> @@ -964,9 +967,10 @@ static void mptcp_address_worker(struct work_str=
uct *work)
>>>>> 			}
>>>>>
>>>>> 			if (event->code =3D=3D MPTCP_EVENT_MOD) {
>>>>> -				struct sock *sk;
>>>>> +				struct mptcp_tcp_sock *mptcp;
>>>>>
>>>>> -				mptcp_for_each_sk(mpcb, sk) {
>>>>> +				mptcp_for_each_sub(mpcb, mptcp) {
>>>>> +					struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 					struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> 					if (event->family =3D=3D AF_INET &&
>>>>> 					    (sk->sk_family =3D=3D AF_INET ||
>>>>> @@ -1455,8 +1459,9 @@ static void full_mesh_release_sock(struct sock =
*meta_sk)
>>>>> 	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
>>>>> 	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
>>>>> 	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(meta_sk));
>>>>> -	struct sock *sk, *tmpsk;
>>>>> 	bool meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> +	struct hlist_node *tmp;
>>>>> 	int i;
>>>>>
>>>>> 	rcu_read_lock_bh();
>>>>> @@ -1470,7 +1475,8 @@ static void full_mesh_release_sock(struct sock =
*meta_sk)
>>>>> 		struct in_addr ifa =3D mptcp_local->locaddr4[i].addr;
>>>>> 		bool found =3D false;
>>>>>
>>>>> -		mptcp_for_each_sk(mpcb, sk) {
>>>>> +		mptcp_for_each_sub(mpcb, mptcp) {
>>>>> +			struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 			struct tcp_sock *tp =3D tcp_sk(sk);
>>>>>
>>>>> 			if (sk->sk_family =3D=3D AF_INET6 &&
>>>>> @@ -1491,6 +1497,8 @@ static void full_mesh_release_sock(struct sock =
*meta_sk)
>>>>> 		}
>>>>>
>>>>> 		if (!found) {
>>>>> +			struct sock *sk;
>>>>> +
>>>>> 			fmp->add_addr++;
>>>>> 			mpcb->addr_signal =3D 1;
>>>>>
>>>>> @@ -1511,7 +1519,8 @@ static void full_mesh_release_sock(struct sock =
*meta_sk)
>>>>> 		struct in6_addr ifa =3D mptcp_local->locaddr6[i].addr;
>>>>> 		bool found =3D false;
>>>>>
>>>>> -		mptcp_for_each_sk(mpcb, sk) {
>>>>> +		mptcp_for_each_sub(mpcb, mptcp) {
>>>>> +			struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 			struct tcp_sock *tp =3D tcp_sk(sk);
>>>>>
>>>>> 			if (sk->sk_family =3D=3D AF_INET ||
>>>>> @@ -1532,6 +1541,8 @@ static void full_mesh_release_sock(struct sock =
*meta_sk)
>>>>> 		}
>>>>>
>>>>> 		if (!found) {
>>>>> +			struct sock *sk;
>>>>> +
>>>>> 			fmp->add_addr++;
>>>>> 			mpcb->addr_signal =3D 1;
>>>>>
>>>>> @@ -1546,7 +1557,8 @@ static void full_mesh_release_sock(struct sock =
*meta_sk)
>>>>> #endif
>>>>>
>>>>> 	/* Now, detect address-removals */
>>>>> -	mptcp_for_each_sk_safe(mpcb, sk, tmpsk) {
>>>>> +	mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
>>>>> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 		bool shall_remove =3D true;
>>>>>
>>>>> 		if (sk->sk_family =3D=3D AF_INET || mptcp_v6_is_v4_mapped(sk)) {
>>>>> diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
>>>>> index 645e5e1e93c7..2a34b3e0e349 100644
>>>>> --- a/net/mptcp/mptcp_input.c
>>>>> +++ b/net/mptcp/mptcp_input.c
>>>>> @@ -126,12 +126,14 @@ static void mptcp_clean_rtx_queue(struct sock *=
meta_sk, u32 prior_snd_una)
>>>>> 		tcp_rtx_queue_unlink(skb, meta_sk);
>>>>>
>>>>> 		if (mptcp_is_data_fin(skb)) {
>>>>> -			struct sock *sk_it, *sk_tmp;
>>>>> +			struct mptcp_tcp_sock *mptcp;
>>>>> +			struct hlist_node *tmp;
>>>>>
>>>>> 			/* DATA_FIN has been acknowledged - now we can close
>>>>> 			 * the subflows
>>>>> 			 */
>>>>> -			mptcp_for_each_sk_safe(mpcb, sk_it, sk_tmp) {
>>>>> +			mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
>>>>> +				struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> 				unsigned long delay =3D 0;
>>>>>
>>>>> 				/* If we are the passive closer, don't trigger
>>>>> @@ -347,6 +349,7 @@ static int mptcp_verif_dss_csum(struct sock *sk)
>>>>>
>>>>> 	/* Now, checksum must be 0 */
>>>>> 	if (unlikely(csum_fold(csum_tcp))) {
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> 		struct sock *sk_it =3D NULL;
>>>>>
>>>>> 		pr_err("%s csum is wrong: %#x tcp-seq %u dss_csum_added %d overflow=
ed %d iterations %d\n",
>>>>> @@ -362,7 +365,9 @@ static int mptcp_verif_dss_csum(struct sock *sk)
>>>>> 		tp->mpcb->csum_cutoff_seq =3D tp->mptcp->map_data_seq;
>>>>>
>>>>> 		/* Search for another subflow that is fully established */
>>>>> -		mptcp_for_each_sk(tp->mpcb, sk_it) {
>>>>> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> +			sk_it =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 			if (sk_it !=3D sk &&
>>>>> 			    tcp_sk(sk_it)->mptcp->fully_established)
>>>>> 				break;
>>>>> @@ -1308,12 +1313,15 @@ int mptcp_do_join_short(struct sk_buff *skb,
>>>>>  */
>>>>> void mptcp_fin(struct sock *meta_sk)
>>>>> {
>>>>> -	struct sock *sk =3D NULL, *sk_it;
>>>>> +	struct sock *sk =3D NULL;
>>>>> 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>>>>> 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	unsigned char state;
>>>>>
>>>>> -	mptcp_for_each_sk(mpcb, sk_it) {
>>>>> +	mptcp_for_each_sub(mpcb, mptcp) {
>>>>> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 		if (tcp_sk(sk_it)->mptcp->path_index =3D=3D mpcb->dfin_path_index) {
>>>>> 			sk =3D sk_it;
>>>>> 			break;
>>>>> @@ -1585,9 +1593,12 @@ void mptcp_clean_rtx_infinite(const struct sk_=
buff *skb, struct sock *sk)
>>>>>
>>>>> static void mptcp_send_reset_rem_id(const struct mptcp_cb *mpcb, u8 r=
em_id)
>>>>> {
>>>>> -	struct sock *sk_it, *tmpsk;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> +	struct hlist_node *tmp;
>>>>> +
>>>>> +	mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
>>>>> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>>
>>>>> -	mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
>>>>> 		if (tcp_sk(sk_it)->mptcp->rem_id =3D=3D rem_id) {
>>>>> 			mptcp_reinject_data(sk_it, 0);
>>>>> 			mptcp_send_reset(sk_it);
>>>>> @@ -1892,13 +1903,15 @@ void tcp_parse_mptcp_options(const struct sk_=
buff *skb,
>>>>> bool mptcp_check_rtt(const struct tcp_sock *tp, int time)
>>>>> {
>>>>> 	struct mptcp_cb *mpcb =3D tp->mpcb;
>>>>> -	struct sock *sk;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	u32 rtt_max =3D 0;
>>>>>
>>>>> 	/* In MPTCP, we take the max delay across all flows,
>>>>> 	 * in order to take into account meta-reordering buffers.
>>>>> 	 */
>>>>> -	mptcp_for_each_sk(mpcb, sk) {
>>>>> +	mptcp_for_each_sub(mpcb, mptcp) {
>>>>> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 		if (!mptcp_sk_can_recv(sk))
>>>>> 			continue;
>>>>>
>>>>> @@ -2173,9 +2186,9 @@ bool mptcp_handle_options(struct sock *sk, cons=
t struct tcphdr *th,
>>>>> 		if (mopt->saw_low_prio =3D=3D 1) {
>>>>> 			tp->mptcp->rcv_low_prio =3D mopt->low_prio;
>>>>> 		} else {
>>>>> -			struct sock *sk_it;
>>>>> -			mptcp_for_each_sk(tp->mpcb, sk_it) {
>>>>> -				struct mptcp_tcp_sock *mptcp =3D tcp_sk(sk_it)->mptcp;
>>>>> +			struct mptcp_tcp_sock *mptcp;
>>>>> +
>>>>> +			mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> 				if (mptcp->rem_id =3D=3D mopt->prio_addr_id)
>>>>> 					mptcp->rcv_low_prio =3D mopt->low_prio;
>>>>> 			}
>>>>> @@ -2359,7 +2372,7 @@ bool mptcp_should_expand_sndbuf(const struct so=
ck *sk)
>>>>> {
>>>>> 	const struct sock *meta_sk =3D mptcp_meta_sk(sk);
>>>>> 	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>>>>> -	const struct sock *sk_it;
>>>>> +	const struct mptcp_tcp_sock *mptcp;
>>>>>
>>>>> 	/* We circumvent this check in tcp_check_space, because we want to
>>>>> 	 * always call sk_write_space. So, we reproduce the check here.
>>>>> @@ -2385,8 +2398,9 @@ bool mptcp_should_expand_sndbuf(const struct so=
ck *sk)
>>>>> 	/* For MPTCP we look for a subsocket that could send data.
>>>>> 	 * If we found one, then we update the send-buffer.
>>>>> 	 */
>>>>> -	mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
>>>>> -		struct tcp_sock *tp_it =3D tcp_sk(sk_it);
>>>>> +	mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
>>>>> +		const struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> +		const struct tcp_sock *tp_it =3D tcp_sk(sk_it);
>>>>>
>>>>> 		if (!mptcp_sk_can_send(sk_it))
>>>>> 			continue;
>>>>> diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
>>>>> index 81f5674f50c9..c4e204f5ad72 100644
>>>>> --- a/net/mptcp/mptcp_output.c
>>>>> +++ b/net/mptcp/mptcp_output.c
>>>>> @@ -647,7 +647,6 @@ int mptcp_write_wakeup(struct sock *meta_sk, int =
mib)
>>>>> {
>>>>> 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>>>>> 	struct sk_buff *skb;
>>>>> -	struct sock *sk_it;
>>>>> 	int ans =3D 0;
>>>>>
>>>>> 	if (meta_sk->sk_state =3D=3D TCP_CLOSE)
>>>>> @@ -704,17 +703,22 @@ int mptcp_write_wakeup(struct sock *meta_sk, in=
t mib)
>>>>>
>>>>> 		return 0;
>>>>> 	} else {
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> +
>>>>> window_probe:
>>>>> 		if (between(meta_tp->snd_up, meta_tp->snd_una + 1,
>>>>> 			    meta_tp->snd_una + 0xFFFF)) {
>>>>> -			mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
>>>>> +			mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
>>>>> +				struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 				if (mptcp_sk_can_send_ack(sk_it))
>>>>> 					tcp_xmit_probe_skb(sk_it, 1, mib);
>>>>> 			}
>>>>> 		}
>>>>>
>>>>> 		/* At least one of the tcp_xmit_probe_skb's has to succeed */
>>>>> -		mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
>>>>> +		mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
>>>>> +			struct sock *sk_it =3D mptcp_to_sock(mptcp);
>>>>> 			int ret;
>>>>>
>>>>> 			if (!mptcp_sk_can_send_ack(sk_it))
>>>>> @@ -732,6 +736,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsig=
ned int mss_now, int nonagle,
>>>>> 		     int push_one, gfp_t gfp)
>>>>> {
>>>>> 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *subtp;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	struct sock *subsk =3D NULL;
>>>>> 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
>>>>> 	struct sk_buff *skb;
>>>>> @@ -856,7 +861,8 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsig=
ned int mss_now, int nonagle,
>>>>> 			break;
>>>>> 	}
>>>>>
>>>>> -	mptcp_for_each_sk(mpcb, subsk) {
>>>>> +	mptcp_for_each_sub(mpcb, mptcp) {
>>>>> +		subsk =3D mptcp_to_sock(mptcp);
>>>>> 		subtp =3D tcp_sk(subsk);
>>>>>
>>>>> 		if (!(path_mask & mptcp_pi_to_flag(subtp->mptcp->path_index)))
>>>>> @@ -1353,7 +1359,7 @@ void mptcp_send_active_reset(struct sock *meta_=
sk, gfp_t priority)
>>>>> 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
>>>>> 	struct sock *sk;
>>>>>
>>>>> -	if (!mpcb->connection_list)
>>>>> +	if (hlist_empty(&mpcb->conn_list))
>>>>> 		return;
>>>>>
>>>>> 	WARN_ON(meta_tp->send_mp_fclose);
>>>>> @@ -1728,10 +1734,11 @@ void mptcp_select_initial_window(const struct=
 sock *sk, int __space, __u32 mss,
>>>>> static inline u64 mptcp_calc_rate(const struct sock *meta_sk, unsigne=
d int mss,
>>>>> 				  unsigned int (*mss_cb)(struct sock *sk))
>>>>> {
>>>>> -	struct sock *sk;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	u64 rate =3D 0;
>>>>>
>>>>> -	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
>>>>> +	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
>>>>> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 		struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> 		int this_mss;
>>>>> 		u64 this_rate;
>>>>> @@ -1783,11 +1790,12 @@ static inline u64 mptcp_calc_rate(const struc=
t sock *meta_sk, unsigned int mss,
>>>>> static unsigned int __mptcp_current_mss(const struct sock *meta_sk,
>>>>> 					unsigned int (*mss_cb)(struct sock *sk))
>>>>> {
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	unsigned int mss =3D 0;
>>>>> 	u64 rate =3D 0;
>>>>> -	struct sock *sk;
>>>>>
>>>>> -	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
>>>>> +	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
>>>>> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 		int this_mss;
>>>>> 		u64 this_rate;
>>>>>
>>>>> @@ -1852,14 +1860,16 @@ int mptcp_select_size(const struct sock *meta=
_sk, bool first_skb, bool zc)
>>>>>
>>>>> int mptcp_check_snd_buf(const struct tcp_sock *tp)
>>>>> {
>>>>> -	const struct sock *sk;
>>>>> +	const struct mptcp_tcp_sock *mptcp;
>>>>> 	u32 rtt_max =3D tp->srtt_us;
>>>>> 	u64 bw_est;
>>>>>
>>>>> 	if (!tp->srtt_us)
>>>>> 		return tp->reordering + 1;
>>>>>
>>>>> -	mptcp_for_each_sk(tp->mpcb, sk) {
>>>>> +	mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> +		const struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 		if (!mptcp_sk_can_send(sk))
>>>>> 			continue;
>>>>>
>>>>> @@ -1877,11 +1887,13 @@ int mptcp_check_snd_buf(const struct tcp_sock=
 *tp)
>>>>> unsigned int mptcp_xmit_size_goal(const struct sock *meta_sk, u32 mss=
_now,
>>>>> 				  int large_allowed)
>>>>> {
>>>>> -	struct sock *sk;
>>>>> 	u32 xmit_size_goal =3D 0;
>>>>>
>>>>> 	if (large_allowed && !tcp_sk(meta_sk)->mpcb->dss_csum) {
>>>>> -		mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> +
>>>>> +		mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
>>>>> +			struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 			int this_size_goal;
>>>>>
>>>>> 			if (!mptcp_sk_can_send(sk))
>>>>> diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
>>>>> index a2543c60bd31..b440df7aae71 100644
>>>>> --- a/net/mptcp/mptcp_sched.c
>>>>> +++ b/net/mptcp/mptcp_sched.c
>>>>> @@ -135,9 +135,10 @@ static struct sock
>>>>> 	u32 min_srtt =3D 0xffffffff;
>>>>> 	bool found_unused =3D false;
>>>>> 	bool found_unused_una =3D false;
>>>>> -	struct sock *sk;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>>
>>>>> -	mptcp_for_each_sk(mpcb, sk) {
>>>>> +	mptcp_for_each_sub(mpcb, mptcp) {
>>>>> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>>>>> 		struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> 		bool unused =3D false;
>>>>>
>>>>> @@ -219,7 +220,11 @@ static struct sock *get_available_subflow(struct=
 sock *meta_sk,
>>>>> 	/* Answer data_fin on same subflow!!! */
>>>>> 	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
>>>>> 	    skb && mptcp_is_data_fin(skb)) {
>>>>> -		mptcp_for_each_sk(mpcb, sk) {
>>>>> +		struct mptcp_tcp_sock *mptcp;
>>>>> +
>>>>> +		mptcp_for_each_sub(mpcb, mptcp) {
>>>>> +			sk =3D mptcp_to_sock(mptcp);
>>>>> +
>>>>> 			if (tcp_sk(sk)->mptcp->path_index =3D=3D mpcb->dfin_path_index &&
>>>>> 			    mptcp_is_available(sk, skb, zero_wnd_test))
>>>>> 				return sk;
>>>>> @@ -252,7 +257,7 @@ static struct sk_buff *mptcp_rcv_buf_optimization=
(struct sock *sk, int penal)
>>>>> {
>>>>> 	struct sock *meta_sk;
>>>>> 	const struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> -	struct tcp_sock *tp_it;
>>>>> +	struct mptcp_tcp_sock *mptcp;
>>>>> 	struct sk_buff *skb_head;
>>>>> 	struct defsched_priv *dsp =3D defsched_get_priv(tp);
>>>>>
>>>>> @@ -275,7 +280,9 @@ static struct sk_buff *mptcp_rcv_buf_optimization=
(struct sock *sk, int penal)
>>>>> 		goto retrans;
>>>>>
>>>>> 	/* Half the cwnd of the slow flow */
>>>>> -	mptcp_for_each_tp(tp->mpcb, tp_it) {
>>>>> +	mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> +		struct tcp_sock *tp_it =3D mptcp->tp;
>>>>> +
>>>>> 		if (tp_it !=3D tp &&
>>>>> 		    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptcp=
->path_index)) {
>>>>> 			if (tp->srtt_us < tp_it->srtt_us && inet_csk((struct sock *)tp_it)=
->icsk_ca_state =3D=3D TCP_CA_Open) {
>>>>> @@ -298,7 +305,9 @@ static struct sk_buff *mptcp_rcv_buf_optimization=
(struct sock *sk, int penal)
>>>>> 	/* Segment not yet injected into this path? Take it!!! */
>>>>> 	if (!(TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp->mptcp->=
path_index))) {
>>>>> 		bool do_retrans =3D false;
>>>>> -		mptcp_for_each_tp(tp->mpcb, tp_it) {
>>>>> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
>>>>> +			struct tcp_sock *tp_it =3D mptcp->tp;
>>>>> +
>>>>> 			if (tp_it !=3D tp &&
>>>>> 			    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptc=
p->path_index)) {
>>>>> 				if (tp_it->snd_cwnd <=3D 4) {
>>>>> --
>>>>> 2.16.2
>>>>>
>>>>>
>>>>
>>>> --
>>>> Mat Martineau
>>>> Intel OTC
>>>
>>
>> --
>> Mat Martineau
>> Intel OTC
>

--
Mat Martineau
Intel OTC

--===============2550244341906863024==--
