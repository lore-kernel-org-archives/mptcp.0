Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DEE2C9F
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 00:47:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="253592369"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="253592369"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 17:47:39 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="635468241"
Received: from gacramer-mobl2.amr.corp.intel.com ([10.209.53.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 17:47:39 -0700
Date: Tue, 26 Oct 2021 17:47:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next] mptcp: enforce HoL-blocking estimation
In-Reply-To: <d33c1a2c642adc3682107b4bfd1c7ddde9437806.camel@redhat.com>
Message-ID: <414d1018-32fb-e080-683f-8e5ed461c1a@linux.intel.com>
References: <22cda018a37459d99683e572e35ac61bbc43fcae.1634900440.git.pabeni@redhat.com>   <6e3468c2-8e61-a05b-8cd1-4656e9217fcc@linux.intel.com>  <049cc3893767d00b4511aafb8acb191dea7aaca8.camel@redhat.com>  <88871581-6815-174-a75c-22618eb7c475@linux.intel.com>
 <d33c1a2c642adc3682107b4bfd1c7ddde9437806.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 26 Oct 2021, Paolo Abeni wrote:

> On Mon, 2021-10-25 at 10:17 -0700, Mat Martineau wrote:
>> On Mon, 25 Oct 2021, Paolo Abeni wrote:
>>
>>> On Fri, 2021-10-22 at 18:19 -0700, Mat Martineau wrote:
>>>> On Fri, 22 Oct 2021, Paolo Abeni wrote:
>>>>
>>>>> The MPTCP packet scheduler has sub-optimal behavior with asymmetric
>>>>> subflows: if the faster subflow-level cwin is closed, the packet
>>>>> scheduler can enqueue "too much" data on a slower subflow.
>>>>>
>>>>> When all the data on the faster subflow is acked, if the mptcp-level
>>>>> cwin is closed, and link utilization becomes suboptimal.
>>>>>
>>>>> The solution is implementing blest-like[1] HoL-blocking estimation,
>>>>> transmitting only on the subflow with the shorter estimated time to
>>>>> flush the queued memory. If such subflows cwin is closed, we wait
>>>>> even if other subflows are available.
>>>>>
>>>>> This is quite simpler than the original blest implementation, as we
>>>>> leverage the pacing rate provided by the TCP socket. To get a more
>>>>> accurate estimation for the subflow linger-time, we maintain a
>>>>> per-subflow weighted average of such info.
>>>>>
>>>>> Additionally drop magic numbers usage in favor of newly defined
>>>>> macros.
>>>>>
>>>>> [1] http://dl.ifip.org/db/conf/networking/networking2016/1570234725.pdf
>>>>>
>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>> ---
>>>>> notes:
>>>>> - this apparently solves for good issue/137, with > 200 iterations with
>>>>> no failures
>>>>> - still to be investigated the impact on high-speed links, if any
>>>>> ---
>>>>> net/mptcp/protocol.c | 58 ++++++++++++++++++++++++++++++--------------
>>>>> net/mptcp/protocol.h |  1 +
>>>>> 2 files changed, 41 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>>> index 7803b0dbb1be..cc9d32cb7bc7 100644
>>>>> --- a/net/mptcp/protocol.c
>>>>> +++ b/net/mptcp/protocol.c
>>>>> @@ -1395,20 +1395,24 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>>>>> 	return __mptcp_subflow_active(subflow);
>>>>> }
>>>>>
>>>>> +#define SSK_MODE_ACTIVE	0
>>>>> +#define SSK_MODE_BACKUP	1
>>>>> +#define SSK_MODE_MAX	2
>>>>> +
>>>>> /* implement the mptcp packet scheduler;
>>>>>  * returns the subflow that will transmit the next DSS
>>>>>  * additionally updates the rtx timeout
>>>>>  */
>>>>> static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>>>>> {
>>>>> -	struct subflow_send_info send_info[2];
>>>>> +	struct subflow_send_info send_info[SSK_MODE_MAX];
>>>>> 	struct mptcp_subflow_context *subflow;
>>>>> 	struct sock *sk = (struct sock *)msk;
>>>>> +	u32 pace, burst, wmem;
>>>>> 	int i, nr_active = 0;
>>>>> 	struct sock *ssk;
>>>>> 	long tout = 0;
>>>>> 	u64 ratio;
>>>>> -	u32 pace;
>>>>>
>>>>> 	sock_owned_by_me(sk);
>>>>>
>>>>> @@ -1427,10 +1431,11 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>>>>> 	}
>>>>>
>>>>> 	/* pick the subflow with the lower wmem/wspace ratio */
>>>>> -	for (i = 0; i < 2; ++i) {
>>>>> +	for (i = 0; i < SSK_MODE_MAX; ++i) {
>>>>> 		send_info[i].ssk = NULL;
>>>>> 		send_info[i].ratio = -1;
>>>>> 	}
>>>>> +
>>>>> 	mptcp_for_each_subflow(msk, subflow) {
>>>>> 		trace_mptcp_subflow_get_send(subflow);
>>>>> 		ssk =  mptcp_subflow_tcp_sock(subflow);
>>>>> @@ -1439,12 +1444,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>>>>>
>>>>> 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
>>>>> 		nr_active += !subflow->backup;
>>>>> -		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
>>>>> -			continue;
>>>>> -
>>>>> -		pace = READ_ONCE(ssk->sk_pacing_rate);
>>>>> -		if (!pace)
>>>>> -			continue;
>>>>> +		pace = subflow->avg_pacing_rate;
>>>>> +		if (unlikely(!pace)) {
>>>>> +			/* init pacing rate from socket */
>>>>> +			pace = subflow->avg_pacing_rate = READ_ONCE(ssk->sk_pacing_rate);
>>>>
>>>> Checkpatch complains about the double assignment. I did do a double-take
>>>> to confirm that it didn't look like a '==' typo, and slightly lean toward
>>>> keeping it checkpatch-clean.
>>>
>>> Yep, I'll fix the above in v2.
>>>
>>>>> +			if (!pace)
>>>>> +				continue;
>>>>> +		}
>>>>>
>>>>> 		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
>>>>> 				pace);
>>>>> @@ -1457,16 +1463,32 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>>>>>
>>>>> 	/* pick the best backup if no other subflow is active */
>>>>> 	if (!nr_active)
>>>>> -		send_info[0].ssk = send_info[1].ssk;
>>>>> -
>>>>> -	if (send_info[0].ssk) {
>>>>> -		msk->last_snd = send_info[0].ssk;
>>>>> -		msk->snd_burst = min_t(int, MPTCP_SEND_BURST_SIZE,
>>>>> -				       tcp_sk(msk->last_snd)->snd_wnd);
>>>>> -		return msk->last_snd;
>>>>> -	}
>>>>> +		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
>>>>> +
>>>>> +	/* According to the blest algorithm, to avoid HoL blocking for the
>>>>> +	 * faster flow, we need to:
>>>>> +	 * - estimate the faster flow linger time
>>>>> +	 * - use the above to estimate the amount of byte transferred
>>>>> +	 *   by the faster flow
>>>>> +	 * - check that the amount of queued data is greter than the above,
>>>>> +	 *   otherwise do not use the picked, slower, subflow
>>>>> +	 * We select the subflow with the shorter estimated time to flush
>>>>> +	 * the queued mem, which basically ensure the above. We just need
>>>>> +	 * to check that subflow has a non empty cwin.
>>>>> +	 */
>>>>> +	ssk = send_info[SSK_MODE_ACTIVE].ssk;
>>>>> +	if (!ssk || !sk_stream_memory_free(ssk) || !tcp_sk(ssk)->snd_wnd)
>>>>> +		return NULL;
>>>>>
>>>>> -	return NULL;
>>>>> +	burst = min_t(int, MPTCP_SEND_BURST_SIZE, tcp_sk(ssk)->snd_wnd);
>>>>> +	wmem = READ_ONCE(ssk->sk_wmem_queued);
>>>>> +	subflow = mptcp_subflow_ctx(ssk);
>>>>> +	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
>>>>> +					   READ_ONCE(ssk->sk_pacing_rate) * burst,
>>>>> +					   burst + wmem);
>>>>
>>>> I see how this gives a smoothed-out version of the pacing rate, using
>>>> avg_pacing_rate for the bytes already sent on this subflow (wmem) and
>>>> ssk->sk_pacing_rate for the bytes that will probably be sent now.
>>>>
>>>> Is this a *better* estimation of the flow speed than the plain
>>>> ssk->sk_pacing_rate?
>>>
>>> It looks like it is. I get a consistent (higher) failure rate using
>>> plain sk_pacing_rate instead. 'sk_pacing_rate' is an 'instant' value
>>> applied to the current pkt, can change in a relevant way in a little
>>> amount of time.
>>>
>>
>> Ok, sk_pacing_rate is even noisier than I realized. My main concern here
>> is that whatever filtering we do on that noisy signal handles a variety of
>> conditions well. This includes cases like a failing wireless signal, where
>> the current and future throughput might be far lower than the average
>> pacing rate would indicate - and in that case the filtering algorithm
>> needs to respond appropriately.
>>
>> My first job was in test & measurement, where a lot of thought goes in to
>> taking noisy A/D converter data and turning it in to a "good" measurement
>> value. When using a weighted average like this, it's common to throw away
>> the average if the new value is a significant change (like "X%" higher or
>> lower).
>
> I think I do understand.
>
> Please note that here there are some difference WRT sampling more or
> less noisy values: the stack enforces that the current sampled value is
> applied to current packet and we record the pacing for each xmitted
> chunk of data.
>
> Using the current pacing_rate to estimate the time to flush the ssk
> xmit queue is subject to relevant errors, as it applies the "wrong"
> pace to previous samples.
>
> The computed time could differ in a significant way from the real one
> only if the TCP stack will produce multiple GSO segments for a single
> burst, using very different pacing rate for the 'next ones'.
>
> Since the max burst size is below the max gso size, AFAICS the above
> could happen only with GSO disabled, when performances are expected to
> be bad. Additionally, throwing away the average on sudden pacing value
> changes will not protect from the above scenario: a delta will be
> caused by _future_ sudden change of the pacing rate.
>
> Not sure if the above is somewhat clear ;)
>

Yeah, I get what you're saying. Appreciate the explanation since you know 
the underlying pacing implementation better than I do.

I'm still working on gathering some raw data to better understand what 
sk_pacing_rate, the values used to calculate sk_pacing_rate, and the 
weighted average look like over time. I want to have more confidence that 
the scheduling changes work well in a variety of conditions.

Would you say the slow start / ca ratios in tcp_update_pacing_rate() are 
interfering with subflow selection at all? It looks like the various 
tcp_sock members that are used to generate sk_pacing_rate could be useful, 
but they require holding the subflow socket lock to read them :(

>
> p.s. just to move the thing forward I'll send a v2 with the
> uncontroversial changes applied...

Ok, thanks for sending.

--
Mat Martineau
Intel
