Content-Type: multipart/mixed; boundary="===============3741252054089072754=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 08/12] mptcp: Remove cnt_established
Date: Wed, 02 May 2018 10:54:09 +0200
Message-ID: <691f6b4c-4455-14d6-abcc-210008377282@tessares.net>
In-Reply-To: 20180501002102.GZ19260@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 599

--===============3741252054089072754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 01/05/2018 02:21, Christoph Paasch wrote:
> On 09/04/18 - 18:04:31, Matthieu Baerts wrote:
>> Hi Christoph,
>>
>> On 26/03/2018 09:32, Christoph Paasch wrote:
>>> We want to remove the number of up-calls into the meta-socket.
>>> cnt_established is one of those where we are modifying a field in the
>>> mpcb.
>>>
>>> We can remove it fairly safely. It's only use is in some MPTCP-specific
>>> congestion controls to short-circuit some parts of it.
>>
>> Not a big optimisation I guess, no?
>> Anyway if MPTCP is not used, MPTCP-specific CC will still fallback to the
>> TCP ones if I remember well.
> =

> Yes, that's what they do.

Good point!

>>
>>> One particular use was in mptcp_should_expand_sndbuf(). There, we use it
>>> to see whether to expand the sndbuf when there are only backup subflows
>>> available.
>>>
>>> One problem with this old code is that the decision whether or not to s=
end on
>>> a backup subflow is steered by the modular scheduler. We cannot assume =
in
>>> core-MPTCP code that backup subflows are never being sent on.
>>
>> Should we not ask the scheduler if this subflow can be used?
> =

> We could ask, but IMO it's kind of an over-optimization at that point.

Fine for me! Can still be done later if needed.

>>
>>> By no more taking backup subflows into account, we greatly simplify
>>> mptcp_should_expand_sndbuf at the cost of potentially increasing the
>>> window even if there is no subflow ready to send because it's a backup
>>> subflow.
>>
>> I am sorry, I didn't check when the callback should_expand_sndbuf is used
>> yet. Is it only to pro-actively expend the sndbuf? Or is it asked always
>> when it seems we need to increase the window? (If yes we should maybe ask
>> the scheduler, no?)
> =

> Yes, it is called every time when we think sndbuf expansion is necessary
> (coming from tcp_check_space -> tcp_new_space -> ...).

Thank you for your comment!

OK then I guess, regarding your comment about backup subflows that could
be used, the sending window would not increase "quickly" enough: it
would only depend on how the non-backup subflows are behaving. Not
really a big issue as well.

Then if we look at the default scheduler where backup subflows are not
used, we would potentially increase the sending window too quickly, not
really a problem and it simplifies the code. Is it correct?

Cheers,
Matt

> Christoph
> =

>> But we can maybe see that as an optimisation and replace the code by a
>> comment, no?
>>
>> Best regards,
>> Matt
>>
>>> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
>>> ---
>>>   include/net/mptcp.h       |  4 ----
>>>   net/mptcp/mctcp_desync.c  |  4 ++--
>>>   net/mptcp/mptcp_balia.c   | 13 ++-----------
>>>   net/mptcp/mptcp_coupled.c | 41 +++++++++++++++-----------------------=
---
>>>   net/mptcp/mptcp_ctrl.c    |  8 --------
>>>   net/mptcp/mptcp_input.c   | 20 ++------------------
>>>   net/mptcp/mptcp_olia.c    |  8 +++++---
>>>   7 files changed, 26 insertions(+), 72 deletions(-)
>>>
>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>> index 523abc8ce01d..758f2038e7cf 100644
>>> --- a/include/net/mptcp.h
>>> +++ b/include/net/mptcp.h
>>> @@ -166,7 +166,6 @@ struct mptcp_tcp_sock {
>>>   	u16	map_data_len;
>>>   	u16	slave_sk:1,
>>>   		fully_established:1,
>>> -		establish_increased:1,
>>>   		second_packet:1,
>>>   		attached:1,
>>>   		send_mp_fail:1,
>>> @@ -279,9 +278,6 @@ struct mptcp_cb {
>>>   		snd_hiseq_index:1, /* Index in snd_high_order of snd_nxt */
>>>   		rcv_hiseq_index:1; /* Index in rcv_high_order of rcv_nxt */
>>> -	/* socket count in this connection */
>>> -	u8 cnt_established;
>>> -
>>>   #define MPTCP_SCHED_DATA_SIZE 8
>>>   	u8 mptcp_sched[MPTCP_SCHED_DATA_SIZE] __aligned(8);
>>>   	struct mptcp_sched_ops *sched_ops;
>>> diff --git a/net/mptcp/mctcp_desync.c b/net/mptcp/mctcp_desync.c
>>> index 9c5d6c196da5..cfc26fcc3161 100644
>>> --- a/net/mptcp/mctcp_desync.c
>>> +++ b/net/mptcp/mctcp_desync.c
>>> @@ -59,7 +59,7 @@ static void mctcp_desync_cong_avoid(struct sock *sk, =
u32 ack, u32 acked)
>>>   {
>>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>> -	if (!mptcp(tp) || (1 =3D=3D tp->mpcb->cnt_established)) {
>>> +	if (!mptcp(tp)) {
>>>   		tcp_reno_cong_avoid(sk, ack, acked);
>>>   		return;
>>>   	} else if (!tcp_is_cwnd_limited(sk)) {
>>> @@ -121,7 +121,7 @@ static u32 mctcp_desync_ssthresh(struct sock *sk)
>>>   {
>>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>> -	if (!mptcp(tp) || (1 =3D=3D tp->mpcb->cnt_established)) {
>>> +	if (!mptcp(tp)) {
>>>   		return max(tp->snd_cwnd >> 1U, 2U);
>>>   	} else {
>>>   		struct mctcp_desync *ca =3D inet_csk_ca(mptcp_meta_sk(sk));
>>> diff --git a/net/mptcp/mptcp_balia.c b/net/mptcp/mptcp_balia.c
>>> index 8b1fe11b08d5..ac5c5e550539 100644
>>> --- a/net/mptcp/mptcp_balia.c
>>> +++ b/net/mptcp/mptcp_balia.c
>>> @@ -86,10 +86,6 @@ static void mptcp_balia_recalc_ai(const struct sock =
*sk)
>>>   	if (!mpcb)
>>>   		return;
>>> -	/* Only one subflow left - fall back to normal reno-behavior */
>>> -	if (mpcb->cnt_established <=3D 1)
>>> -		goto exit;
>>> -
>>>   	/* Find max_rate first */
>>>   	mptcp_for_each_sk(mpcb, sub_sk) {
>>>   		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
>>> @@ -186,7 +182,6 @@ static void mptcp_balia_set_state(struct sock *sk, =
u8 ca_state)
>>>   static void mptcp_balia_cong_avoid(struct sock *sk, u32 ack, u32 acke=
d)
>>>   {
>>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>> -	const struct mptcp_cb *mpcb =3D tp->mpcb;
>>>   	int snd_cwnd;
>>>   	if (!mptcp(tp)) {
>>> @@ -209,10 +204,7 @@ static void mptcp_balia_cong_avoid(struct sock *sk=
, u32 ack, u32 acked)
>>>   		mptcp_set_forced(sk, 0);
>>>   	}
>>> -	if (mpcb->cnt_established > 1)
>>> -		snd_cwnd =3D (int) mptcp_get_ai(sk);
>>> -	else
>>> -		snd_cwnd =3D tp->snd_cwnd;
>>> +	snd_cwnd =3D (int) mptcp_get_ai(sk);
>>>   	if (tp->snd_cwnd_cnt >=3D snd_cwnd) {
>>>   		if (tp->snd_cwnd < tp->snd_cwnd_clamp) {
>>> @@ -229,9 +221,8 @@ static void mptcp_balia_cong_avoid(struct sock *sk,=
 u32 ack, u32 acked)
>>>   static u32 mptcp_balia_ssthresh(struct sock *sk)
>>>   {
>>>   	const struct tcp_sock *tp =3D tcp_sk(sk);
>>> -	const struct mptcp_cb *mpcb =3D tp->mpcb;
>>> -	if (unlikely(!mptcp(tp) || mpcb->cnt_established <=3D 1))
>>> +	if (unlikely(!mptcp(tp)))
>>>   		return tcp_reno_ssthresh(sk);
>>>   	else
>>>   		return max((u32)(tp->snd_cwnd - mptcp_get_md(sk)), 1U);
>>> diff --git a/net/mptcp/mptcp_coupled.c b/net/mptcp/mptcp_coupled.c
>>> index f9d856334ca9..a6569f5e20ab 100644
>>> --- a/net/mptcp/mptcp_coupled.c
>>> +++ b/net/mptcp/mptcp_coupled.c
>>> @@ -87,12 +87,6 @@ static void mptcp_ccc_recalc_alpha(const struct sock=
 *sk)
>>>   	if (!mpcb)
>>>   		return;
>>> -	/* Only one subflow left - fall back to normal reno-behavior
>>> -	 * (set alpha to 1)
>>> -	 */
>>> -	if (mpcb->cnt_established <=3D 1)
>>> -		goto exit;
>>> -
>>>   	/* Do regular alpha-calculation for multiple subflows */
>>>   	/* Find the max numerator of the alpha-calculation */
>>> @@ -137,8 +131,7 @@ static void mptcp_ccc_recalc_alpha(const struct soc=
k *sk)
>>>   	}
>>>   	sum_denominator *=3D sum_denominator;
>>>   	if (unlikely(!sum_denominator)) {
>>> -		pr_err("%s: sum_denominator =3D=3D 0, cnt_established:%d\n",
>>> -		       __func__, mpcb->cnt_established);
>>> +		pr_err("%s: sum_denominator =3D=3D 0\n", __func__);
>>>   		mptcp_for_each_sk(mpcb, sub_sk) {
>>>   			struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
>>>   			pr_err("%s: pi:%d, state:%d\n, rtt:%u, cwnd: %u",
>>> @@ -183,8 +176,8 @@ static void mptcp_ccc_set_state(struct sock *sk, u8=
 ca_state)
>>>   static void mptcp_ccc_cong_avoid(struct sock *sk, u32 ack, u32 acked)
>>>   {
>>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>> -	const struct mptcp_cb *mpcb =3D tp->mpcb;
>>>   	int snd_cwnd;
>>> +	u64 alpha;
>>>   	if (!mptcp(tp)) {
>>>   		tcp_reno_cong_avoid(sk, ack, acked);
>>> @@ -206,27 +199,23 @@ static void mptcp_ccc_cong_avoid(struct sock *sk,=
 u32 ack, u32 acked)
>>>   		mptcp_set_forced(mptcp_meta_sk(sk), 0);
>>>   	}
>>> -	if (mpcb->cnt_established > 1) {
>>> -		u64 alpha =3D mptcp_get_alpha(mptcp_meta_sk(sk));
>>> +	alpha =3D mptcp_get_alpha(mptcp_meta_sk(sk));
>>> -		/* This may happen, if at the initialization, the mpcb
>>> -		 * was not yet attached to the sock, and thus
>>> -		 * initializing alpha failed.
>>> -		 */
>>> -		if (unlikely(!alpha))
>>> -			alpha =3D 1;
>>> +	/* This may happen, if at the initialization, the mpcb
>>> +	 * was not yet attached to the sock, and thus
>>> +	 * initializing alpha failed.
>>> +	 */
>>> +	if (unlikely(!alpha))
>>> +		alpha =3D 1;
>>> -		snd_cwnd =3D (int) div_u64 ((u64) mptcp_ccc_scale(1, alpha_scale),
>>> -						alpha);
>>> +	snd_cwnd =3D (int) div_u64 ((u64) mptcp_ccc_scale(1, alpha_scale),
>>> +					alpha);
>>> -		/* snd_cwnd_cnt >=3D max (scale * tot_cwnd / alpha, cwnd)
>>> -		 * Thus, we select here the max value.
>>> -		 */
>>> -		if (snd_cwnd < tp->snd_cwnd)
>>> -			snd_cwnd =3D tp->snd_cwnd;
>>> -	} else {
>>> +	/* snd_cwnd_cnt >=3D max (scale * tot_cwnd / alpha, cwnd)
>>> +	 * Thus, we select here the max value.
>>> +	 */
>>> +	if (snd_cwnd < tp->snd_cwnd)
>>>   		snd_cwnd =3D tp->snd_cwnd;
>>> -	}
>>>   	if (tp->snd_cwnd_cnt >=3D snd_cwnd) {
>>>   		if (tp->snd_cwnd < tp->snd_cwnd_clamp) {
>>> diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
>>> index b1109ee9770f..da072fe21ec6 100644
>>> --- a/net/mptcp/mptcp_ctrl.c
>>> +++ b/net/mptcp/mptcp_ctrl.c
>>> @@ -737,11 +737,6 @@ static void mptcp_set_state(struct sock *sk)
>>>   		tcp_sk(meta_sk)->lsndtime =3D tcp_jiffies32;
>>>   	}
>>> -	if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
>>> -		tcp_sk(sk)->mptcp->establish_increased =3D 1;
>>> -		tcp_sk(sk)->mpcb->cnt_established++;
>>> -	}
>>> -
>>>   	if (sk->sk_state =3D=3D TCP_CLOSE) {
>>>   		if (!sock_flag(sk, SOCK_DEAD))
>>>   			mptcp_sub_close(sk, 0);
>>> @@ -1449,9 +1444,6 @@ void mptcp_del_sock(struct sock *sk)
>>>   			}
>>>   		}
>>>   	}
>>> -	if (tp->mptcp->establish_increased)
>>> -		mpcb->cnt_established--;
>>> -
>>>   	tp->mptcp->next =3D NULL;
>>>   	tp->mptcp->attached =3D 0;
>>>   	mpcb->path_index_bits &=3D ~(1 << tp->mptcp->path_index);
>>> diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
>>> index 126c961ec55a..211605347f70 100644
>>> --- a/net/mptcp/mptcp_input.c
>>> +++ b/net/mptcp/mptcp_input.c
>>> @@ -2357,11 +2357,9 @@ int mptcp_rcv_synsent_state_process(struct sock =
*sk, struct sock **skptr,
>>>   /* Similar to tcp_should_expand_sndbuf */
>>>   bool mptcp_should_expand_sndbuf(const struct sock *sk)
>>>   {
>>> -	const struct sock *sk_it;
>>>   	const struct sock *meta_sk =3D mptcp_meta_sk(sk);
>>>   	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>>> -	int cnt_backups =3D 0;
>>> -	int backup_available =3D 0;
>>> +	const struct sock *sk_it;
>>>   	/* We circumvent this check in tcp_check_space, because we want to
>>>   	 * always call sk_write_space. So, we reproduce the check here.
>>> @@ -2393,24 +2391,10 @@ bool mptcp_should_expand_sndbuf(const struct so=
ck *sk)
>>>   		if (!mptcp_sk_can_send(sk_it))
>>>   			continue;
>>> -		/* Backup-flows have to be counted - if there is no other
>>> -		 * subflow we take the backup-flow into account.
>>> -		 */
>>> -		if (tp_it->mptcp->rcv_low_prio || tp_it->mptcp->low_prio)
>>> -			cnt_backups++;
>>> -
>>> -		if (tcp_packets_in_flight(tp_it) < tp_it->snd_cwnd) {
>>> -			if (tp_it->mptcp->rcv_low_prio || tp_it->mptcp->low_prio) {
>>> -				backup_available =3D 1;
>>> -				continue;
>>> -			}
>>> +		if (tcp_packets_in_flight(tp_it) < tp_it->snd_cwnd)
>>>   			return true;
>>> -		}
>>>   	}
>>> -	/* Backup-flow is available for sending - update send-buffer */
>>> -	if (meta_tp->mpcb->cnt_established =3D=3D cnt_backups && backup_avail=
able)
>>> -		return true;
>>>   	return false;
>>>   }
>>> diff --git a/net/mptcp/mptcp_olia.c b/net/mptcp/mptcp_olia.c
>>> index c17c306849a3..9f61e1eff65a 100644
>>> --- a/net/mptcp/mptcp_olia.c
>>> +++ b/net/mptcp/mptcp_olia.c
>>> @@ -105,7 +105,7 @@ static void mptcp_get_epsilon(const struct mptcp_cb=
 *mpcb)
>>>   	struct tcp_sock *tp;
>>>   	struct sock *sk;
>>>   	u64 tmp_int, tmp_rtt, best_int =3D 0, best_rtt =3D 1;
>>> -	u32 max_cwnd, tmp_cwnd;
>>> +	u32 max_cwnd, tmp_cwnd, established_cnt =3D 0;
>>>   	u8 M =3D 0, B_not_M =3D 0;
>>>   	/* TODO - integrate this in the following loop - we just want to ite=
rate once */
>>> @@ -120,6 +120,8 @@ static void mptcp_get_epsilon(const struct mptcp_cb=
 *mpcb)
>>>   		if (!mptcp_olia_sk_can_send(sk))
>>>   			continue;
>>> +		established_cnt++;
>>> +
>>>   		tmp_rtt =3D (u64)tp->srtt_us * tp->srtt_us;
>>>   		/* TODO - check here and rename variables */
>>>   		tmp_int =3D max(ca->mptcp_loss3 - ca->mptcp_loss2,
>>> @@ -173,10 +175,10 @@ static void mptcp_get_epsilon(const struct mptcp_=
cb *mpcb)
>>>   			if (tmp_cwnd < max_cwnd &&
>>>   			    (u64)tmp_int * best_rtt =3D=3D (u64)best_int * tmp_rtt) {
>>>   				ca->epsilon_num =3D 1;
>>> -				ca->epsilon_den =3D mpcb->cnt_established * B_not_M;
>>> +				ca->epsilon_den =3D established_cnt * B_not_M;
>>>   			} else if (tmp_cwnd =3D=3D max_cwnd) {
>>>   				ca->epsilon_num =3D -1;
>>> -				ca->epsilon_den =3D mpcb->cnt_established  * M;
>>> +				ca->epsilon_den =3D established_cnt * M;
>>>   			} else {
>>>   				ca->epsilon_num =3D 0;
>>>   				ca->epsilon_den =3D 1;
>>>
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

--===============3741252054089072754==--
