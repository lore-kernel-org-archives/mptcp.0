Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240693730C6
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881278; cv=none; b=mB/KdTWxXzrvzkDv1HCLJDXffWxlOK0smr3PJAOzW50ZLvdfRkrtgHghWlT5Bw76BfDnBmszFHopXbKODQyCsmbxRXQxleKuxXEPogmE1kSZzh6h/NMD6UP+i4qtS70w9kNu0zfFicSOxbzps0dS1AJo8+0ly/pFeTmfhx/dpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881278; c=relaxed/simple;
	bh=abCZ/XLB3l6pzgVHFU83kc7KysTtS2brjEOH09VTO1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SMJPyH6so+VK2FLxkihrB2gEDAyFyYfP4Qdz61yTDXEKoMiUYwrnnLo7C96HsFEIcXqB5PcW1e/DEmTFh8xRypoT5sK2iXgMnzs4M/50sUwLb4z5PY4dzEoIE3IHZPQanvIjfDMjuyBsc18TtxZYtungyi/v5iEM1tC08veffOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1+cucAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1+cucAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DD9C16AAE;
	Tue, 11 Nov 2025 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762881277;
	bh=abCZ/XLB3l6pzgVHFU83kc7KysTtS2brjEOH09VTO1c=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=L1+cucAqww9uUtdPYxDQUt//ThgCecgTDXB8bU3+p1oYmrSBzC/Jis3O2qDyjFLB2
	 PsCmZxOoOarcMzh0LlpjF+8pd+qNg4hn+S520DOOkGMBr+Ra1yIMmpnMXbNQGC116F
	 vr4EewaGzowuntZj4UXBMcuS18uky8yitMhCUktG5oDP3Vga3FHG/0AFQZw72/CVQt
	 i+Hp9csAw7U4hqBr8Q2BsSMuCcdWI49PeLyuoXz2mTRj/UV/z01eFCVj5P/5NVO2Rl
	 4h0NNx7u8898LuWwHDtNS2nV+4hvG6zttReXUrIg57e9gRip75coTVRNftx5u/PVkl
	 CsgLSw+LF2gzw==
Message-ID: <8e2ae2b2-13b4-4615-be82-eb3710ec566f@kernel.org>
Date: Tue, 11 Nov 2025 18:14:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 mptcp-next] Squash-to: "mptcp: leverage the backlog for
 RX packet processing"
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
References: <ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com>
 <2f6f0b1e22690e962d4fff02838d23d4b8a65f07.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2f6f0b1e22690e962d4fff02838d23d4b8a65f07.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 11/11/2025 08:21, Geliang Tang wrote:
> Hi Paolo,
> 
> Thanks for this fix.
> 
> On Sun, 2025-11-09 at 14:53 +0100, Paolo Abeni wrote:
>> If a subflow receives data before gaining the memcg while the msk
>> socket lock is held at accept time, or the PM locks the msk socket
>> while still unaccepted and subflows push data to it at the same time,
>> the mptcp_graph_subflows() can complete with a non empty backlog.
>>
>> The msk will try to borrow such memory, but (some) of the skbs there
>> where not memcg charged. When the msk finally will return such
>> accounted
>> memory, we should hit the same splat of #597.
>> [even if so far I was unable to replicate this scenario]
>>
>> This patch tries to address such potential issue by:
>> - preventing the subflow from queuing data into the backlog after
>>   gaining the memcg. This ensure that at the end of the look all the
>>   skbs in the backlog (if any) are _not_ memory accounted.
>> - mem charge the backlog to msk
>> - 'restart' the subflow and spool any data waiting there.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 46
>> ++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 5e9325c7ea9c..d6b08e1de358 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -4082,10 +4082,12 @@ static void mptcp_graph_subflows(struct sock
>> *sk)
>>  {
>>  	struct mptcp_subflow_context *subflow;
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	struct sock *ssk;
>> +	int old_amt, amt;
>> +	bool slow;
>>  
>>  	mptcp_for_each_subflow(msk, subflow) {
>> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> -		bool slow;
>> +		ssk = mptcp_subflow_tcp_sock(subflow);
>>  
>>  		slow = lock_sock_fast(ssk);
>>  
>> @@ -4095,8 +4097,48 @@ static void mptcp_graph_subflows(struct sock
>> *sk)
>>  		if (!ssk->sk_socket)
>>  			mptcp_sock_graft(ssk, sk->sk_socket);
>>  
>> +		if (!mem_cgroup_from_sk(sk))
>> +			goto unlock;
> 
> I think it's better to use "continue" here, just like in v1, so that
> other subflows also have a chance to call mptcp_sock_graft(), but we
> need to call unlock_sock_fast() before "continue".

Mmh, that's what this code is doing: unlock and continue, no?

> Besides, wouldn't it be more appropriate to squash these lines into
> "mptcp: fix memcg accounting for passive sockets"?

From what I understood, that's not strickly needed: such check are done
in the helpers below: here it is just to avoid doing the same check yet
another time for 'subflow->closing = 1'.

> 
>> +
>>  		__mptcp_inherit_cgrp_data(sk, ssk);
>>  		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
>> +
>> +		/* Prevent subflows from queueing data into the
>> backlog
>> +		 * as soon as cg is set; note that we can't race
>> +		 * with __mptcp_close_ssk setting this bit for a
>> really
>> +		 * closing socket, because we hold the msk socket
>> lock here.
>> +		 */
>> +		subflow->closing = 1;
>> +
>> +unlock:
>> +		unlock_sock_fast(ssk, slow);
>> +	}
>> +
>> +	if (!mem_cgroup_from_sk(sk))
>> +		return;
>> +
>> +	/* Charge the bl memory, note that __sk_charge accounted for
>> +	 * fwd memory and rmem only
>> +	 */
>> +	mptcp_data_lock(sk);
>> +	old_amt = sk_mem_pages(sk->sk_forward_alloc +
>> +			       atomic_read(&sk->sk_rmem_alloc));
>> +	amt = sk_mem_pages(msk->backlog_len + sk->sk_forward_alloc +
>> +		     atomic_read(&sk->sk_rmem_alloc));
> 
> The code here is not aligned properly.
> 
>> +	amt -= old_amt;
>> +	if (amt)
>> +		mem_cgroup_sk_charge(sk, amt, GFP_ATOMIC |
>> __GFP_NOFAIL);
> 
> I'm not sure if we need to call kmem_cache_charge() here, just like in
> __sk_charge().
> 
> WDYT?
> 
> Thanks,
> -Geliang
> 
>> +	mptcp_data_unlock(sk);
>> +
>> +	/* Finally let the subflow restart queuing data. */
>> +	mptcp_for_each_subflow(msk, subflow) {
>> +		ssk = mptcp_subflow_tcp_sock(subflow);
>> +
>> +		slow = lock_sock_fast(ssk);
>> +		subflow->closing = 0;
>> +
>> +		if (mptcp_subflow_data_available(ssk))
>> +			mptcp_data_ready(sk, ssk);
>>  		unlock_sock_fast(ssk, slow);
>>  	}
>>  }
> 
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

