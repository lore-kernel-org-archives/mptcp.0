Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168A246BDE
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234742; cv=none; b=WKMZD3HaMDnO2qPtJtPovY/EidFLpxBKPNj2lO2W/EDozlvLPRgcNWFlqYrJyTBDF9yiHBqECjr59z/ojLRjMjW/FEXOsRjx/DQULKLFMLIsOoGdnwGiyQwRzUjS1dt5y/p0n7KH2vRhxL80rBRUGHwFftvJY1RSeg4Etr3vOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234742; c=relaxed/simple;
	bh=oHIK9b3ZEPl2lvLKKsRkoeYK/U3y2hjpW9NuIZhjqpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mkp5U/R5MMOrr8QYwfiIfmWGo84bTXhbQ+jn6kgyb5avrbcZsCLM4nldF6+VujTFh655O40q7/6hiGLAUfEgv8sCJXFdKMuZbpJcBI4bARGYuc/0RhST8r2TewqYaOOxOkmlbbSRQTIZsuAUlwtQi4YC1yLfsq5NkUe7SwJ8e6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD9Vwl6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD9Vwl6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74EBC16AAE;
	Thu, 23 Oct 2025 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761234742;
	bh=oHIK9b3ZEPl2lvLKKsRkoeYK/U3y2hjpW9NuIZhjqpU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kD9Vwl6CyuvvG3zXBHxwFiu5GRX5yVQqbTGCKo4XQ4Ms9VEgfg1l4CDxgruSRoeAt
	 aAJF6s2T++jgB8Fr1i+RLvnewUJ30WTIY0AmP0vmZp2lC02WfkxtYqJOEjwVlc6gc+
	 GB+nKj2uxSDMhBJNSBj6jHty8Ik5lQelldgdpPNngRVBKYaLw5njgvsVtS68UhuM3y
	 g7Z8NkBRnmag9tNP6C4sSBripV77idlBOQY9Qhq58pT1pEDSryogVtmyVmD9LGntOP
	 PJPfb4I3RA+FCiz/ZqLZ4MQ/6KSIdtiQ+UYMCvWQZZ0Bsf6nrGGTOEKsoOGfATrI4w
	 pAQF8YYnAA3Iw==
Message-ID: <34f90baa-72ff-4c00-917a-a0d65ff0e608@kernel.org>
Date: Thu, 23 Oct 2025 17:52:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mptcp-next 11/11] mptcp: leverage the backlog for RX
 packet processing
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1761142784.git.pabeni@redhat.com>
 <2201f259d2176bca0ad37500a352658f7ef5a1f0.1761142784.git.pabeni@redhat.com>
 <3feb8c2a-2098-4626-8bf2-edd66f679463@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3feb8c2a-2098-4626-8bf2-edd66f679463@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 23/10/2025 17:11, Paolo Abeni wrote:
> 
> 
> On 10/22/25 4:31 PM, Paolo Abeni wrote:
>> When the msk socket is owned or the msk receive buffer is full,
>> move the incoming skbs in a msk level backlog list. This avoid
>> traversing the joined subflows and acquiring the subflow level
>> socket lock at reception time, improving the RX performances.
>>
>> When processing the backlog, use the fwd alloc memory borrowed from
>> the incoming subflow. skbs exceeding the msk receive space are
>> not dropped; instead they are kept into the backlog until the receive
>> buffer is freed. Dropping packets already acked at the TCP level is
>> explicitly discouraged by the RFC and would corrupt the data stream
>> for fallback sockets.
>>
>> Move the conditional reschedule in release_cb() to take action only
>> after the first loop iteration, to avoid rescheduling just before
>> releasing the lock.
>>
>> Special care is needed to avoid adding skbs to the backlog of a closed
>> msk and to avoid leaving dangling references into the backlog
>> at subflow closing time.

(...)

>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 5a1d8f9e0fb0ec..0aae17ab77edb2 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c

(...)

>> -static bool __mptcp_move_skbs(struct sock *sk)
>> +static bool mptcp_can_spool_backlog(struct sock *sk, u32 moved,
>> +				    struct list_head *skbs)
>>  {
>> -	struct mptcp_subflow_context *subflow;
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>> -	bool ret = false;
>>  
>> -	if (list_empty(&msk->conn_list))
>> +	if (list_empty(&msk->backlog_list))
>>  		return false;
>>  
>> -	subflow = list_first_entry(&msk->conn_list,
>> -				   struct mptcp_subflow_context, node);
>> -	for (;;) {
>> -		struct sock *ssk;
>> -		bool slowpath;
>> +	/* Borrowed mem could be zero only in the unlikely event that the bl
>> +	 * is full
>> +	 */
>> +	if (likely(msk->borrowed_mem)) {
>> +		sk_forward_alloc_add(sk, msk->borrowed_mem);
>> +		msk->borrowed_mem = 0;
>> +		sk->sk_reserved_mem = msk->backlog_len;
> 
> With the above I intended to prevent the fwd memory handling from
> releasing backlog_len bytes. Re-reading the relevant code, it does not
> allow that (experimentation confirmed), see:
> 
> https://elixir.bootlin.com/linux/v6.18-rc2/source/include/net/sock.h#L1593
> 
> and:
> 
> https://elixir.bootlin.com/linux/v6.18-rc2/source/include/net/sock.h#L1580
> 
> This will need some more care. Also patch 2 will require some
> significant rework.

Thank you for looking at this complex part, and for having spot that!

> @Mat, @Matttbe: could you please consider merging patches 1,3-9?
> 
> I think they should be pretty uncontroversial, would make the series
> more manegeable for future iterations (and would alleviate my
> frustration to make this thing work correctly).

It makes sense, fine by me. I will wait for Mat's review before applying
them (patch 1 is for 'net' I suppose).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

