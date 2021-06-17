Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085172
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 00:12:11 +0000 (UTC)
IronPort-SDR: ivacUMvEChKSC9pM+9L6+2uFG7zeO71i23fmOQgj+JDLbOQTsZqY7OftWv4fJLDJBjf7k8HsD6
 M1T1ikpSi8eQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="185968758"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="185968758"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:12:10 -0700
IronPort-SDR: Pr3ittu3cVFkEOBEDd72qalZh+FI3sGin3g0j7ooIiCR/h3vVM3ix/OOU/EP8mgicWpPBFORwt
 K46ZiKvM9kOQ==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="450819605"
Received: from ndalili-mobl.amr.corp.intel.com ([10.209.105.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:12:07 -0700
Date: Wed, 16 Jun 2021 17:12:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next] mptcp: refine mptcp_cleanup_rbuf
In-Reply-To: <7995482e34d40e6b4b427dd965781498c252d688.camel@redhat.com>
Message-ID: <3ccd9f9-31a8-e7-127b-5c3de1288c11@linux.intel.com>
References: <10bbc75802301770d24a9d74b7800f491e7b67f9.1623420606.git.pabeni@redhat.com>  <e9bfd7b4-4a9-5a6-1f7b-e25db9d19a@linux.intel.com> <7995482e34d40e6b4b427dd965781498c252d688.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Jun 2021, Paolo Abeni wrote:

> On Tue, 2021-06-15 at 14:26 -0700, Mat Martineau wrote:
>> On Fri, 11 Jun 2021, Paolo Abeni wrote:
>>
>>> The current cleanup rbuf tries a bit too hard to avoid acquiring
>>> the subflow socket lock. We may end-up delaying the needed ack,
>>> or skip acking a blocked subflow.
>>>
>>> Address the above extending the conditions used to trigger the cleanup
>>> to reflect more closely what TCP does and invoking tcp_cleanup_rbuf()
>>> on all the active subflows.
>>>
>>> Note that we can't replicate the exact tests implemented in
>>> tcp_cleanup_rbuf(), as MPTCP lacks some of the required info - e.g.
>>> ping-pong mode.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v1 -> v2:
>>> - access ssk icsk/tp state instead of msk (Mat)
>>> ---
>>> net/mptcp/protocol.c | 49 +++++++++++++++++++-------------------------
>>> net/mptcp/protocol.h |  1 -
>>> 2 files changed, 21 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 0a220862f62d..1dc3a0cb653d 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -455,36 +455,36 @@ static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
>>> 	return ret;
>>> }
>>>
>>> +static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
>>> +{
>>> +	const struct inet_connection_sock *icsk = inet_csk(ssk);
>>> +	bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
>>> +	const struct tcp_sock *tp = tcp_sk(ssk);
>>> +
>>> +	return (ack_pending & ICSK_ACK_SCHED) &&
>>> +		((READ_ONCE(tp->rcv_nxt) - READ_ONCE(tp->rcv_wup) >
>>> +		  READ_ONCE(icsk->icsk_ack.rcv_mss)) ||
>>> +		 (rx_empty && ack_pending &
>>> +			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
>>> +}
>>> +
>>> static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
>>> {
>>> -	struct sock *ack_hint = READ_ONCE(msk->ack_hint);
>>> 	int old_space = READ_ONCE(msk->old_wspace);
>>> 	struct mptcp_subflow_context *subflow;
>>> 	struct sock *sk = (struct sock *)msk;
>>> -	bool cleanup;
>>> +	int space =  __mptcp_space(sk);
>>> +	bool cleanup, rx_empty;
>>>
>>> -	/* this is a simple superset of what tcp_cleanup_rbuf() implements
>>> -	 * so that we don't have to acquire the ssk socket lock most of the time
>>> -	 * to do actually nothing
>>> -	 */
>>> -	cleanup = __mptcp_space(sk) - old_space >= max(0, old_space);
>>> -	if (!cleanup)
>>> -		return;
>>> +	cleanup = (space > 0) && (space >= (old_space << 1));
>>> +	rx_empty = !atomic_read(&sk->sk_rmem_alloc);
>>>
>>> -	/* if the hinted ssk is still active, try to use it */
>>> -	if (likely(ack_hint)) {
>>> -		mptcp_for_each_subflow(msk, subflow) {
>>> -			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>> +	mptcp_for_each_subflow(msk, subflow) {
>>> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>>
>>> -			if (ack_hint == ssk && mptcp_subflow_cleanup_rbuf(ssk))
>>> -				return;
>>> -		}
>>> +		if (cleanup || mptcp_subflow_could_cleanup(ssk, rx_empty))
>>> +			mptcp_subflow_cleanup_rbuf(ssk);
>>
>> The return value of mptcp_subflow_cleanup_rbuf() is ignored now, so that
>> function can be changed to remove the 'ret' variable and return void.
>
> ok
>
>>> 	}
>>> -
>>> -	/* otherwise pick the first active subflow */
>>> -	mptcp_for_each_subflow(msk, subflow)
>>> -		if (mptcp_subflow_cleanup_rbuf(mptcp_subflow_tcp_sock(subflow)))
>>> -			return;
>>> }
>>>
>>> static bool mptcp_check_data_fin(struct sock *sk)
>>> @@ -629,7 +629,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>>> 			break;
>>> 		}
>>> 	} while (more_data_avail);
>>> -	WRITE_ONCE(msk->ack_hint, ssk);
>>>
>>> 	*bytes += moved;
>>> 	return done;
>>> @@ -1910,7 +1909,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
>>> 		__mptcp_update_rmem(sk);
>>> 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
>>> 		mptcp_data_unlock(sk);
>>> -		tcp_cleanup_rbuf(ssk, moved);
>>>
>>> 		if (unlikely(ssk->sk_err))
>>> 			__mptcp_error_report(sk);
>>> @@ -1926,7 +1924,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
>>> 		ret |= __mptcp_ofo_queue(msk);
>>> 		__mptcp_splice_receive_queue(sk);
>>> 		mptcp_data_unlock(sk);
>>> -		mptcp_cleanup_rbuf(msk);
>>
>> Removing this call and the tcp_cleanup_rbuf() in the hunk above does mean
>> there are fewer opportunites to cleanup/ack, but it looks like those were
>> "extra" calls most of the time. With the location of the one call to
>> mptcp_cleanup_rbuf() in mptcp_recvmsg() it shouldn't make much difference
>> unless __mptcp_recvmsg_mskq() returns an error. Would it make sense to
>> move the call to mptcp_cleanup_rbuf() to immediately follow
>> __mptcp_recvmsg_mskq(), before checking for errors?
>
> AFAICS, tcp_cleanup_rbuf() can take action only after that the user-
> space removed some data out of the receive queue.
>
> I added the above *tcp_cleanup_rbuf() - IIRC - because back then I
> misunderstood moving data out of the subflow receive queue would be
> relevant. It's not, as each subflow tcp_cleanup_rbuf() will look inside
> the msk receive usage to take action.
>

Thanks for explaining.

> If __mptcp_recvmsg_mskq() returns an error, it moved no data out of the
> msk receive queue, so should not need any additional
> mptcp_cleanup_rbuf() call.

Oh, right... if any data was copied __mptcp_recvmsg_mskq() returns the 
bytes copied, not the error value. I agree that an additional 
mptcp_cleanup_rbuf() call isn't needed.

--
Mat Martineau
Intel
