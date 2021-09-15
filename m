Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1263FC5
	for <mptcp@lists.linux.dev>; Wed, 15 Sep 2021 00:37:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="222226097"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="222226097"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 17:37:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="472211914"
Received: from rpopuri-mobl1.amr.corp.intel.com ([10.209.80.242])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 17:37:17 -0700
Date: Tue, 14 Sep 2021 17:37:16 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 1/8] mptcp: add mptcp_is_data_contiguous
 helper
In-Reply-To: <bd5b486dab66893019096ebc468a7fb873919d1a.camel@redhat.com>
Message-ID: <69c4ec57-94ed-4631-317a-617f994bc77@linux.intel.com>
References: <cover.1631610729.git.geliangtang@gmail.com>  <3610b34039bb8e73cd2eecdbc43d5a0cfbc5d2da.1631610729.git.geliangtang@gmail.com> <bd5b486dab66893019096ebc468a7fb873919d1a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hi Geliang -

This patch changes more than the helper function, I suggest a subject like 
"mptcp: Track and update contiguous data status"

On Tue, 14 Sep 2021, Paolo Abeni wrote:

> On Tue, 2021-09-14 at 17:19 +0800, Geliang Tang wrote:
>> This patch added a new member last_retrans_seq in the msk to track the
>> last retransmitting sequence number.
>>
>> Add a new helper named mptcp_is_data_contiguous() to check whether the
>> data is contiguous on a subflow.
>>
>> When a bad checksum is detected and a single contiguous subflow is in
>> use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.
>>
>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>> ---
>>  net/mptcp/protocol.c |  3 +++
>>  net/mptcp/protocol.h |  6 ++++++
>>  net/mptcp/subflow.c  | 12 ++++++------
>>  3 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index ff574d62073f..71a5427609a9 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2464,6 +2464,7 @@ static void __mptcp_retrans(struct sock *sk)
>>  		dfrag->already_sent = max(dfrag->already_sent, info.sent);
>>  		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
>>  			 info.size_goal);
>> +		msk->last_retrans_seq = dfrag->data_seq;

If this last_retrans_seq technique is going to work with multiple 
retransmissions, I think the last_retrans_seq assignment would need to 
look like:

retrans_seq = dfrag->data_seq + info.set;
if (after64(retrans_seq, msk->last_retrans_seq))
 	msk->last_retrans_seq = retrans_seq;

This keeps track of the end of the retransmitted data.


As I think about what could happen with multiple retransmissions, I'm not 
sure it's enough to only track only a MPTCP-level sequence number to 
determine a subflow stream is contiguous. See below.


>>  	}
>>
>>  	release_sock(ssk);
>> @@ -2889,6 +2890,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>>  	msk->snd_una = msk->write_seq;
>>  	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
>>  	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
>> +	msk->last_retrans_seq = subflow_req->idsn - 1;
>>
>>  	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
>>  		msk->can_ack = true;
>> @@ -3145,6 +3147,7 @@ void mptcp_finish_connect(struct sock *ssk)
>>  	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
>>  	WRITE_ONCE(msk->can_ack, 1);
>>  	WRITE_ONCE(msk->snd_una, msk->write_seq);
>> +	WRITE_ONCE(msk->last_retrans_seq, subflow->idsn - 1);
>>
>>  	mptcp_pm_new_connection(msk, ssk, 0);
>>
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index d516fb6578cc..eb3473d128d4 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -227,6 +227,7 @@ struct mptcp_sock {
>>  	u64		ack_seq;
>>  	u64		rcv_wnd_sent;
>>  	u64		rcv_data_fin_seq;
>> +	u64		last_retrans_seq;
>>  	int		wmem_reserved;
>>  	struct sock	*last_snd;
>>  	int		snd_burst;
>> @@ -625,6 +626,11 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
>>  	return false;
>>  }
>>
>> +static inline bool mptcp_is_data_contiguous(struct mptcp_sock *msk)
>> +{
>> +	return before64(msk->last_retrans_seq, msk->snd_una);
>> +}

Paolo, do you think this holds true even when there are multiple 
retransmissions in flight?

Consider:

1. We have a connection with two active subflows, A & B

2. Data is sent on both subflows (say, with round robin scheduling)

3. Some data is sent on subflow A, but the subflow goes stale 
and that data does not get to the peer.

4. MPTCP-level timeout happens, data is retransmitted on subflow B.

5. Subflow A is closed, MPTCP connection is now single-subflow

6. Subflow B data is delayed (TCP retransmissions, maybe?), and MPTCP 
retransmits again with identical MPTCP-level sequence numbers.

7. Finally, an MPTCP DATA_ACK arrives on subflow B based on our first 
retransmission. snd_una has caught up to last_retrans_seq at the MPTCP 
level.

8. Then we get a checksum error and need to send MP_FAIL.


At this point, there is still retransmitted data in flight. If we send a 
TCP ACK with a DSS_ACK + MP_FAIL that could be processed by the peer 
before the in-flight retransmitted data, and out-of-sequence data could 
get in to the MPTCP-level stream.

While this is not going to happen frequently, it doesn't seem impossible 
(do correct me if I'm wrong!).


The earlier "track number of retransmissions in mptcp_data_frag" would 
catch this, but there are other alternatives. What about tracking the 
32-bit TCP sequence number for the end of the last retransmission, using a 
field in each subflow context? While it is a few extra bytes of memory per 
subflow instead of per-MPTCP-connection, it's no more execution time to 
keep it updated.


WDYT?


>> +
>>  void __init mptcp_proto_init(void);
>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>  int __init mptcp_proto_v6_init(void);
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 1de7ce883c37..b07803ed3053 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>  fallback:
>>  	/* RFC 8684 section 3.7. */
>>  	if (subflow->send_mp_fail) {
>> -		if (mptcp_has_another_subflow(ssk)) {
>> +		if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(msk)) {
>> +			ssk->sk_err = EBADMSG;
>> +			tcp_set_state(ssk, TCP_CLOSE);
>> +			subflow->reset_transient = 0;
>> +			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
>> +			tcp_send_active_reset(ssk, GFP_ATOMIC);
>>  			while ((skb = skb_peek(&ssk->sk_receive_queue)))
>>  				sk_eat_skb(ssk, skb);
>>  		}
>> -		ssk->sk_err = EBADMSG;
>> -		tcp_set_state(ssk, TCP_CLOSE);
>> -		subflow->reset_transient = 0;
>> -		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
>> -		tcp_send_active_reset(ssk, GFP_ATOMIC);
>>  		WRITE_ONCE(subflow->data_avail, 0);
>>  		return true;
>>  	}
>
> As noted by Mat, to avoid wrap-around on 'last_retrans_seq', we also
> need to updated it in mptcp_clean_una, something alike:
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index bb8a2a231479..cc3534052227 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1102,8 +1102,13 @@ static void
> __mptcp_clean_una(struct sock *sk)
>                msk->recovery = false;
>
> out:
> -	if (cleaned && tcp_under_memory_pressure(sk))
> -		__mptcp_mem_reclaim_partial(sk);
> +	if (cleaned) {
> +		if (mptcp_is_data_contiguous(msk))
> +                       msk->last_retrans_seq = msk->snd_una - 1;
> +
> +		if (tcp_under_memory_pressure(sk))
> +			__mptcp_mem_reclaim_partial(sk);
> +	}
>
>        if (snd_una == READ_ONCE(msk-> snd_nxt) && !msk->recovery) {
>
> /P

Paolo's diff got line-wrapped strangely on the mailing list, I tried to 
fix it up above.

--
Mat Martineau
Intel
