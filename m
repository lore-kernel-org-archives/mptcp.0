Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3623164D8
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781696; cv=none; b=D/QmRvMle+tX5l2CueXTUFsBKP5hCMalYSWD6eRvTkPlYF6jNcQ6Hr/JnGAa1ZZpiCoqaqoLlSiEnNtq8AxP30fSkBWIOTSsOzQPI6OKJb02EDpRVlLVWX56EcvAPu2y65AWFfebfeJjd45JAG0mkd/PygY3XM5OLVNuzgBxuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781696; c=relaxed/simple;
	bh=vC2TgZ8L3IVHycijYu1YXU6ROmEygd1m4gCDspmaQ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCL1MK8d4Q+9YTI+/FVsb9dYsjvsPEzstWCVJW4qm0d3/O7n9F5nopnGO4g9WyQyDRNl9W4J6lQd3utooIz0XdUntuCRQrocRDDvftLGNPkvqxICO91Bubj1caIR79Z0QX2D75YfhxewDHWw5RksHnQ41tGSytLepzi+lK4v7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSqXXPYY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSqXXPYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D541F000E9;
	Tue, 26 May 2026 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779781695;
	bh=BzGLutJc0KZyuUHKiwBQvWJvX4CYAkjwK6SgX3Zp678=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PSqXXPYY765WwGwKDfCLCr0am3opPH65uP7Nd+p+f4b86w7vX/W7Ec4OAhYk3OM5t
	 wjoV2VRxf35XIih9tiw68oAqQG+TWkJNI35pP71Gyt5z4WXMIRQ0FSwON1P/zupIEi
	 Pr58Ws4tY2oVBDvuhvm6GsJ/fb5NA8VRR3GXRYb+YNuGuol8+Wg4UmD7qJqJQCpL1j
	 GP41PhSv1qDlWzLM+Idqyo7VjFkmlIiC/KFtoUTWOb+oCiUltTJVOcSH5tK45wlCqG
	 zO0SnlnSYdYxn0DrpehKjKP0KZlcAbIkWZ1OcPBrjWfkYwrC4dyfabZjnAf+CcxcN2
	 1QhmhaOoMinWQ==
Message-ID: <f3383a69-82e1-4210-ab15-369616c58716@kernel.org>
Date: Tue, 26 May 2026 17:48:11 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 mptcp-next 3/9] mptcp: close TOCTOU race while
 computing rcv_wnd
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev
Cc: gang.yan@linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <a8ae9961db6c482c439b6cc7e16514d908af61f2.1779485511.git.pabeni@redhat.com>
 <ed237923f5af60e22739deb2d2bc924f62c1ace9.camel@kernel.org>
 <7523db9a-b95e-46a9-926f-cbd9be464b27@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7523db9a-b95e-46a9-926f-cbd9be464b27@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Geliang,

Thank you for this fix!

On 26/05/2026 16:34, Paolo Abeni wrote:
> On 5/26/26 8:10 AM, Geliang Tang wrote:
>> On Fri, 2026-05-22 at 23:43 +0200, Paolo Abeni wrote:
>>> The MPTCP output path access locklessly the MPTCP-level ack_seq
>>> in multiple times, using possibly different values for the data_ack
>>> in the DSS option and to compute the announced rcv wnd for the same
>>> packet.
>>>
>>> Refactor the cote to avoid inconsistencies which may confuse the
>>> peer. Also ensure that the MPTCP level rcv wnd is updated only when
>>> the egress packet actually contains a DSS ack.
>>>
>>> Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  net/mptcp/options.c | 36 ++++++++++++++++++------------------
>>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 4cc583fdc7a9..4d72f286a485 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -570,7 +570,6 @@ static bool mptcp_established_options_dss(struct
>>> sock *sk, struct sk_buff *skb,
>>>  	struct mptcp_ext *mpext;
>>>  	unsigned int ack_size;
>>>  	bool ret = false;
>>> -	u64 ack_seq;
>>>  
>>>  	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
>>>  	mpext = skb ? mptcp_get_ext(skb) : NULL;
>>> @@ -601,14 +600,11 @@ static bool
>>> mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>>  		return ret;
>>>  	}
>>>  
>>> -	ack_seq = READ_ONCE(msk->ack_seq);
>>>  	if (READ_ONCE(msk->use_64bit_ack)) {
>>>  		ack_size = TCPOLEN_MPTCP_DSS_ACK64;
>>> -		opts->ext_copy.data_ack = ack_seq;
>>>  		opts->ext_copy.ack64 = 1;
>>>  	} else {
>>>  		ack_size = TCPOLEN_MPTCP_DSS_ACK32;
>>> -		opts->ext_copy.data_ack32 = (uint32_t)ack_seq;
>>>  		opts->ext_copy.ack64 = 0;
>>>  	}
>>>  	opts->ext_copy.use_ack = 1;
>>> @@ -1298,19 +1294,14 @@ bool mptcp_incoming_options(struct sock *sk,
>>> struct sk_buff *skb)
>>>  	return true;
>>>  }
>>>  
>>> -static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
>>> +static u64 mptcp_set_rwin(struct mptcp_sock *msk, struct tcp_sock
>>> *tp,
>>> +			  struct tcphdr *th, u64 ack_seq)
>>>  {
>>>  	const struct sock *ssk = (const struct sock *)tp;
>>> -	struct mptcp_subflow_context *subflow;
>>> -	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
>>> -	struct mptcp_sock *msk;
>>> +	u64 rcv_wnd_old, rcv_wnd_new;
>>>  	u32 new_win;
>>>  	u64 win;
>>>  
>>> -	subflow = mptcp_subflow_ctx(ssk);
>>> -	msk = mptcp_sk(subflow->conn);
>>> -
>>> -	ack_seq = READ_ONCE(msk->ack_seq);
>>>  	rcv_wnd_new = ack_seq + tp->rcv_wnd;
>>>  
>>>  	rcv_wnd_old = atomic64_read(&msk->rcv_wnd_sent);
>>> @@ -1363,7 +1354,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp,
>>> struct tcphdr *th)
>>>  
>>>  update_wspace:
>>>  	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
>>> -	subflow->rcv_wnd_sent = rcv_wnd_new;
>>> +	return rcv_wnd_new;
>>>  }
>>>  
>>>  static void mptcp_track_rwin(struct tcp_sock *tp)
>>> @@ -1475,13 +1466,25 @@ void mptcp_write_options(struct tcphdr *th,
>>> __be32 *ptr, struct tcp_sock *tp,
>>>  		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
>>>  
>>>  		if (mpext->use_ack) {
>>> +			struct mptcp_sock *msk;
>>> +			u64 ack_seq;
>>> +
>>> +			/* DSS option is set only by
>>> mptcp_established_option,
>>> +			 * the caller is __tcp_transmit_skb() and
>>> ssk is always
>>> +			 * not NULL.
>>> +			 */
>>> +			subflow = mptcp_subflow_ctx(ssk);
>>> +			msk = mptcp_sk(subflow->conn);
>>> +			ack_seq = READ_ONCE(msk->ack_seq);
>>>  			if (mpext->ack64) {
>>> -				put_unaligned_be64(mpext->data_ack,
>>> ptr);
>>> +				put_unaligned_be64(ack_seq, ptr);
>>>  				ptr += 2;
>>>  			} else {
>>> -				put_unaligned_be32(mpext-
>>>> data_ack32, ptr);
>>
>> This patch makes data_ack and data_ack32 in struct mptcp_ext no longer
>> used. Can they be removed from struct mptcp_ext, and update
>> mptcp_dump_mpext() in include/trace/events/mptcp.h accordingly?
> 
> Thanks for your review.
> 
> It looks like mptcp_dump_mpext() always dumped data_ack, but such value
> was always 0-set when that function was called? if so dropping the
> fields and adjusting the helper could be a separate/later patch?

If they have never been used elsewhere before -- which seems to be the
case -- that should be fine to do that in a separate patch. In other
cases, that's probably safer to do that in the same patch, to help to
catch other usages when backporting such patches.

In other words, no need to change anything here, and a follow-up patch
would be nice :)

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

