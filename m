Content-Type: multipart/mixed; boundary="===============2080387977859568818=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 07/12] mptcp: Remove cnt_subflows
Date: Wed, 02 May 2018 10:52:50 +0200
Message-ID: <96d87499-a602-bc0a-65d3-1752d3b052ac@tessares.net>
In-Reply-To: 20180501002453.GA19260@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 598

--===============2080387977859568818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 01/05/2018 02:24, Christoph Paasch wrote:
> On 09/04/18 - 18:04:42, Matthieu Baerts wrote:
>>
>>
>> On 09/04/2018 06:14, Christoph Paasch wrote:
>>> Hello,
>>>
>>> On 04/04/18 - 17:57:05, Matthieu Baerts wrote:
>>>> Hi Christoph,
>>>>
>>>> On 26/03/2018 09:32, Christoph Paasch wrote:
>>>>> Our goal is to make subflow establishment lockless. cnt_subflows would
>>>>> need to either become an atomic variable, or we can remove it.
>>>>
>>>> Just out of curiosity, is it a big cost to have it atomic?
>>>
>>> looking again at this patch and your comments, it's probably better to =
simply
>>> make it atomic.
>>> I was a bit over-enthousiastic for removing code :-)
>>>
>>> Sounds good?
>>
>> I think it still makes sense to avoid duplicated info.
>>
>> Here we can easily get the number subflows with a for-loop in a list. Ex=
cept
>> that in a later patch, it will be in a hlist I think. I don't know what's
>> the cost of doing this check to count the number of sublows. If the cost=
 is
>> very low, why not removing cnt_subflows and call a function when we need=
 the
>> info?
> =

> Hmmm... Well, honestly I'm not sure about what is the best design here :)
> =

> Let's do the following. I export a function to count the number of subflo=
ws
> and then when it's needed we call that one. Also, without any changes to
> /proc/

Great, fine for me! :-)

Matt


> Christoph
> =

> =

>>
>> Matt
>>
>>
>>>
>>>
>>> Christoph
>>>
>>>
>>>> That looks like a good idea to remove, it avoid duplicating data we ca=
n get
>>>> differently.
>>>>
>>>>> Well, let's remove it! In the general case it is not needed at all. S=
ome
>>>>> exotic schedulers need cnt_subflows, but we don't care if we add
>>>>> complexity in these schedulers.
>>>>
>>>> On the other hand, that's not a big complexity to get this number, tha=
t's
>>>> why we don't care adding this tiny bit more complexity :-)
>>>>
>>>>> One place where it was used is in the /proc/net/mptcp_net/mptcp outpu=
t.
>>>>> We don't guarantee backwards compatibility, so we can just change the
>>>>> output. I will submit a follow-up patch for net-tools.
>>>>
>>>> I agree that we don't guarantee backwards compatibility but this info =
is
>>>> quite useful when debugging. Especially when someone discovering MPTCP=
 wants
>>>> to check if there is more than one subflow.
>>>>
>>>> By chance, could we not count the number of subflows here without lock=
ing on
>>>> each subflow? (Just with mptcp_for_each_sk(mpcb, sk_unused) i++;)
>>>>
>>>>  From my point of view, data from /proc/net/mptcp_net/mptcp doesn't ne=
ed to
>>>> be accurate: if a new subflow has just been added/removed, that's fine=
 if we
>>>> missed that, we just don't want crashes and locking too much :)
>>>>
>>>>> Another place is mptcp_verif_dss_csum(). There the access was actually
>>>>> wrong. Simply because cnt_subflows > 1, it doesn't mean we have a
>>>>> working subflow. So, we fix that. I don't think this issue is big eno=
ugh
>>>>> to backport it.
>>>>
>>>> Can we not use 'cnt_established > 1' in the backports?
>>>>
>>>>> Finally mptcp_sched.c was also using cnt_subflows but merely for
>>>>> speeding up things to avoid going through the whole scheduler code wh=
en
>>>>> there is only one subflow. So, we can remove it and trade performance
>>>>> for a better design.
>>>>
>>>> For this one, can we not check if there is more than one subflow to ke=
ep the
>>>> fastpath? Anyway we will still have to iterate on each subflow just af=
ter I
>>>> guess.
>>>>
>>>> But in general, it is good to simplify the design!
>>>>
>>>>> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
>>>>> ---
>>>>>    include/net/mptcp.h          |  1 -
>>>>>    net/mptcp/mptcp_binder.c     | 17 +++++++++++++++--
>>>>>    net/mptcp/mptcp_ctrl.c       | 16 ++++++----------
>>>>>    net/mptcp/mptcp_input.c      | 11 ++++++++++-
>>>>>    net/mptcp/mptcp_ndiffports.c | 17 +++++++++++++++--
>>>>>    net/mptcp/mptcp_output.c     |  2 +-
>>>>>    net/mptcp/mptcp_sched.c      | 11 -----------
>>>>>    7 files changed, 47 insertions(+), 28 deletions(-)
>>>>>
>>>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>>>> index 647183460200..523abc8ce01d 100644
>>>>> --- a/include/net/mptcp.h
>>>>> +++ b/include/net/mptcp.h
>>>>> @@ -280,7 +280,6 @@ struct mptcp_cb {
>>>>>    		rcv_hiseq_index:1; /* Index in rcv_high_order of rcv_nxt */
>>>>>    	/* socket count in this connection */
>>>>> -	u8 cnt_subflows;
>>>>>    	u8 cnt_established;
>>>>>    #define MPTCP_SCHED_DATA_SIZE 8
>>>>> diff --git a/net/mptcp/mptcp_binder.c b/net/mptcp/mptcp_binder.c
>>>>> index 58a342dc1620..d6ef9c5b6ce5 100644
>>>>> --- a/net/mptcp/mptcp_binder.c
>>>>> +++ b/net/mptcp/mptcp_binder.c
>>>>> @@ -287,6 +287,18 @@ static int mptcp_parse_gateway_ipv4(char *gatewa=
ys)
>>>>>    	return -1;
>>>>>    }
>>>>> +static int mptcp_binder_subflow_count(const struct mptcp_cb *mpcb)
>>>>> +{
>>>>> +	struct sock *sk;
>>>>> +	int i =3D 0;
>>>>> +
>>>>> +	mptcp_for_each_sk(mpcb, sk) {
>>>>> +		i++;
>>>>> +	}
>>>>> +
>>>>> +	return i;
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * Create all new subflows, by doing calls to mptcp_initX_subsocke=
ts
>>>>>     *
>>>>> @@ -301,7 +313,7 @@ static void create_subflow_worker(struct work_str=
uct *work)
>>>>>    						     subflow_work);
>>>>>    	struct mptcp_cb *mpcb =3D pm_priv->mpcb;
>>>>>    	struct sock *meta_sk =3D mpcb->meta_sk;
>>>>> -	int iter =3D 0;
>>>>> +	int iter =3D 0, subflow_cnt;
>>>>>    next_subflow:
>>>>>    	if (iter) {
>>>>> @@ -322,8 +334,9 @@ static void create_subflow_worker(struct work_str=
uct *work)
>>>>>    	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
>>>>>    		goto exit;
>>>>> +	subflow_cnt =3D mptcp_binder_subflow_count(mpcb);
>>>>>    	if (mptcp_binder_ndiffports > iter &&
>>>>> -	    mptcp_binder_ndiffports > mpcb->cnt_subflows) {
>>>>> +	    mptcp_binder_ndiffports > subflow_cnt) {
>>>>>    		struct mptcp_loc4 loc;
>>>>>    		struct mptcp_rem4 rem;
>>>>> diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
>>>>> index 321a8578e9c3..b1109ee9770f 100644
>>>>> --- a/net/mptcp/mptcp_ctrl.c
>>>>> +++ b/net/mptcp/mptcp_ctrl.c
>>>>> @@ -1379,7 +1379,6 @@ int mptcp_add_sock(struct sock *meta_sk, struct=
 sock *sk, u8 loc_id, u8 rem_id,
>>>>>    	mpcb->connection_list =3D tp;
>>>>>    	tp->mptcp->attached =3D 1;
>>>>> -	mpcb->cnt_subflows++;
>>>>>    	atomic_add(atomic_read(&((struct sock *)tp)->sk_rmem_alloc),
>>>>>    		   &meta_sk->sk_rmem_alloc);
>>>>> @@ -1399,23 +1398,21 @@ int mptcp_add_sock(struct sock *meta_sk, stru=
ct sock *sk, u8 loc_id, u8 rem_id,
>>>>>    	sk->sk_destruct =3D mptcp_sock_destruct;
>>>>>    	if (sk->sk_family =3D=3D AF_INET)
>>>>> -		mptcp_debug("%s: token %#x pi %d, src_addr:%pI4:%d dst_addr:%pI4:%=
d, cnt_subflows now %d\n",
>>>>> +		mptcp_debug("%s: token %#x pi %d, src_addr:%pI4:%d dst_addr:%pI4:%=
d\n",
>>>>>    			    __func__ , mpcb->mptcp_loc_token,
>>>>>    			    tp->mptcp->path_index,
>>>>>    			    &((struct inet_sock *)tp)->inet_saddr,
>>>>>    			    ntohs(((struct inet_sock *)tp)->inet_sport),
>>>>>    			    &((struct inet_sock *)tp)->inet_daddr,
>>>>> -			    ntohs(((struct inet_sock *)tp)->inet_dport),
>>>>> -			    mpcb->cnt_subflows);
>>>>> +			    ntohs(((struct inet_sock *)tp)->inet_dport));
>>>>>    #if IS_ENABLED(CONFIG_IPV6)
>>>>>    	else
>>>>> -		mptcp_debug("%s: token %#x pi %d, src_addr:%pI6:%d dst_addr:%pI6:%=
d, cnt_subflows now %d\n",
>>>>> +		mptcp_debug("%s: token %#x pi %d, src_addr:%pI6:%d dst_addr:%pI6:%=
d\n",
>>>>>    			    __func__ , mpcb->mptcp_loc_token,
>>>>>    			    tp->mptcp->path_index, &inet6_sk(sk)->saddr,
>>>>>    			    ntohs(((struct inet_sock *)tp)->inet_sport),
>>>>>    			    &sk->sk_v6_daddr,
>>>>> -			    ntohs(((struct inet_sock *)tp)->inet_dport),
>>>>> -			    mpcb->cnt_subflows);
>>>>> +			    ntohs(((struct inet_sock *)tp)->inet_dport));
>>>>>    #endif
>>>>>    	return 0;
>>>>> @@ -1452,7 +1449,6 @@ void mptcp_del_sock(struct sock *sk)
>>>>>    			}
>>>>>    		}
>>>>>    	}
>>>>> -	mpcb->cnt_subflows--;
>>>>>    	if (tp->mptcp->establish_increased)
>>>>>    		mpcb->cnt_established--;
>>>>> @@ -2816,8 +2812,8 @@ static int mptcp_pm_seq_show(struct seq_file *s=
eq, void *v)
>>>>>    					   ntohs(isk->inet_dport));
>>>>>    #endif
>>>>>    			}
>>>>> -			seq_printf(seq, " %02X %02X %08X:%08X %lu",
>>>>> -				   meta_sk->sk_state, mpcb->cnt_subflows,
>>>>> +			seq_printf(seq, " %02X %08X:%08X %lu",
>>>>> +				   meta_sk->sk_state,
>>>>
>>>> You missed the update of the "header" at the line 2796 ;-)
>>>> (to remove the 'ns' from there)
>>>>
>>>>>    				   meta_tp->write_seq - meta_tp->snd_una,
>>>>>    				   max_t(int, meta_tp->rcv_nxt -
>>>>>    					 meta_tp->copied_seq, 0),
>>>>> diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
>>>>> index ba9e3fe62824..126c961ec55a 100644
>>>>> --- a/net/mptcp/mptcp_input.c
>>>>> +++ b/net/mptcp/mptcp_input.c
>>>>> @@ -347,6 +347,8 @@ static int mptcp_verif_dss_csum(struct sock *sk)
>>>>>    	/* Now, checksum must be 0 */
>>>>>    	if (unlikely(csum_fold(csum_tcp))) {
>>>>> +		struct sock *sk_it =3D NULL;
>>>>> +
>>>>>    		pr_err("%s csum is wrong: %#x tcp-seq %u dss_csum_added %d overf=
lowed %d iterations %d\n",
>>>>>    		       __func__, csum_fold(csum_tcp), TCP_SKB_CB(last)->seq,
>>>>>    		       dss_csum_added, overflowed, iter);
>>>>> @@ -359,7 +361,14 @@ static int mptcp_verif_dss_csum(struct sock *sk)
>>>>>    		 */
>>>>>    		tp->mpcb->csum_cutoff_seq =3D tp->mptcp->map_data_seq;
>>>>> -		if (tp->mpcb->cnt_subflows > 1) {
>>>>> +		/* Search for another subflow that is fully established */
>>>>> +		mptcp_for_each_sk(tp->mpcb, sk_it) {
>>>>> +			if (sk_it !=3D sk &&
>>>>> +			    tcp_sk(sk_it)->mptcp->fully_established)
>>>>> +				break;
>>>>> +		}
>>>>> +
>>>>> +		if (sk_it) {
>>>>>    			mptcp_send_reset(sk);
>>>>>    			ans =3D -1;
>>>>>    		} else {
>>>>> diff --git a/net/mptcp/mptcp_ndiffports.c b/net/mptcp/mptcp_ndiffport=
s.c
>>>>> index 10147d5e3cca..fe73ade7ba24 100644
>>>>> --- a/net/mptcp/mptcp_ndiffports.c
>>>>> +++ b/net/mptcp/mptcp_ndiffports.c
>>>>> @@ -18,6 +18,18 @@ static int num_subflows __read_mostly =3D 2;
>>>>>    module_param(num_subflows, int, 0644);
>>>>>    MODULE_PARM_DESC(num_subflows, "choose the number of subflows per =
MPTCP connection");
>>>>> +static int mptcp_ndiffports_subflow_count(const struct mptcp_cb *mpc=
b)
>>>>> +{
>>>>> +	struct sock *sk;
>>>>> +	int i =3D 0;
>>>>> +
>>>>> +	mptcp_for_each_sk(mpcb, sk) {
>>>>> +		i++;
>>>>> +	}
>>>>> +
>>>>> +	return i;
>>>>> +}
>>>>
>>>> Can we not add this function with a generic name in mptcp.h? (and use =
it
>>>> here, in binder, maybe for /proc/net/mptcp_net/mptcp, etc.)
>>>>
>>>> Cheers,
>>>> Matt
>>>>
>>>>> +
>>>>>    /**
>>>>>     * Create all new subflows, by doing calls to mptcp_initX_subsocke=
ts
>>>>>     *
>>>>> @@ -32,7 +44,7 @@ static void create_subflow_worker(struct work_struc=
t *work)
>>>>>    						     subflow_work);
>>>>>    	struct mptcp_cb *mpcb =3D pm_priv->mpcb;
>>>>>    	struct sock *meta_sk =3D mpcb->meta_sk;
>>>>> -	int iter =3D 0;
>>>>> +	int iter =3D 0, subflow_cnt;
>>>>>    next_subflow:
>>>>>    	if (iter) {
>>>>> @@ -53,7 +65,8 @@ static void create_subflow_worker(struct work_struc=
t *work)
>>>>>    	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
>>>>>    		goto exit;
>>>>> -	if (num_subflows > iter && num_subflows > mpcb->cnt_subflows) {
>>>>> +	subflow_cnt =3D mptcp_ndiffports_subflow_count(mpcb);
>>>>> +	if (num_subflows > iter && num_subflows > subflow_cnt) {
>>>>>    		if (meta_sk->sk_family =3D=3D AF_INET ||
>>>>>    		    mptcp_v6_is_v4_mapped(meta_sk)) {
>>>>>    			struct mptcp_loc4 loc;
>>>>> diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
>>>>> index fc950a98ce31..cc1a4f7d39e9 100644
>>>>> --- a/net/mptcp/mptcp_output.c
>>>>> +++ b/net/mptcp/mptcp_output.c
>>>>> @@ -1353,7 +1353,7 @@ void mptcp_send_active_reset(struct sock *meta_=
sk, gfp_t priority)
>>>>>    	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
>>>>>    	struct sock *sk;
>>>>> -	if (!mpcb->cnt_subflows)
>>>>> +	if (!mpcb->connection_list)
>>>>>    		return;
>>>>>    	WARN_ON(meta_tp->send_mp_fclose);
>>>>> diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
>>>>> index 2b10a6683c5e..c831515fd7f0 100644
>>>>> --- a/net/mptcp/mptcp_sched.c
>>>>> +++ b/net/mptcp/mptcp_sched.c
>>>>> @@ -219,14 +219,6 @@ struct sock *get_available_subflow(struct sock *=
meta_sk, struct sk_buff *skb,
>>>>>    	struct sock *sk;
>>>>>    	bool force;
>>>>> -	/* if there is only one subflow, bypass the scheduling function */
>>>>> -	if (mpcb->cnt_subflows =3D=3D 1) {
>>>>> -		sk =3D (struct sock *)mpcb->connection_list;
>>>>> -		if (!mptcp_is_available(sk, skb, zero_wnd_test))
>>>>> -			sk =3D NULL;
>>>>> -		return sk;
>>>>> -	}
>>>>> -
>>>>>    	/* Answer data_fin on same subflow!!! */
>>>>>    	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
>>>>>    	    skb && mptcp_is_data_fin(skb)) {
>>>>> @@ -268,9 +260,6 @@ static struct sk_buff *mptcp_rcv_buf_optimization=
(struct sock *sk, int penal)
>>>>>    	struct sk_buff *skb_head;
>>>>>    	struct defsched_priv *dsp =3D defsched_get_priv(tp);
>>>>> -	if (tp->mpcb->cnt_subflows =3D=3D 1)
>>>>> -		return NULL;
>>>>> -
>>>>>    	meta_sk =3D mptcp_meta_sk(sk);
>>>>>    	skb_head =3D tcp_rtx_queue_head(meta_sk);
>>>>>
>>>> -- =

>>>> Matthieu Baerts | R&D Engineer
>>>> matthieu.baerts(a)tessares.net
>>>> Tessares SA | Hybrid Access Solutions
>>>> www.tessares.net
>>>> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
>>>>
>>>> -- =

>>>>
>>>>
>>>> DISCLAIMER.
>>>> This email and any files transmitted with it are confidential and inte=
nded
>>>> solely for the use of the individual or entity to whom they are addres=
sed.
>>>> If you have received this email in error please notify the system mana=
ger.
>>>> This message contains confidential information and is intended only fo=
r the
>>>> individual named. If you are not the named addressee you should not
>>>> disseminate, distribute or copy this e-mail. Please notify the sender
>>>> immediately by e-mail if you have received this e-mail by mistake and =
delete
>>>> this e-mail from your system. If you are not the intended recipient yo=
u are
>>>> notified that disclosing, copying, distributing or taking any action in
>>>> reliance on the contents of this information is strictly prohibited.
>>
>> -- =

>> Matthieu Baerts | R&D Engineer
>> matthieu.baerts(a)tessares.net
>> Tessares SA | Hybrid Access Solutions
>> www.tessares.net
>> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
>>
>> -- =

>>
>>
>> DISCLAIMER.
>> This email and any files transmitted with it are confidential and intend=
ed
>> solely for the use of the individual or entity to whom they are addresse=
d.
>> If you have received this email in error please notify the system manage=
r.
>> This message contains confidential information and is intended only for =
the
>> individual named. If you are not the named addressee you should not
>> disseminate, distribute or copy this e-mail. Please notify the sender
>> immediately by e-mail if you have received this e-mail by mistake and de=
lete
>> this e-mail from your system. If you are not the intended recipient you =
are
>> notified that disclosing, copying, distributing or taking any action in
>> reliance on the contents of this information is strictly prohibited.

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============2080387977859568818==--
