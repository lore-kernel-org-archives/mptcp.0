Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4C336C587
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878085; cv=none; b=OUx35Cm2l6N5F3ve2WCwvrjG+zwxf2YqvnAFGvNMLDY+Qw+hD1EseMHGqrJWC94eAtxusGD/T+ExhfO9Rz3PZ/DyYrlxCKemD6zp++uYhjRGQfeTPQ+Xs+45XDrxSoSkMDH0sDN/LrmEGO3TBS+cEywVmFR6zzYPdkdG6LKA3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878085; c=relaxed/simple;
	bh=u26maQ0nwiVW/Xk5u9yHntcgSsE6XMdO2olI060Cgso=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ixRQXK9eP4qsChEnVqKGJONhBo7RN2tqPQd9+JMjiqvmqey7bj89nShqKE4WXxuK/9okbFf4Yewf3/sjXsP0GjAmYDOTScIdwwk7HT5MCkRODr1fRFgGo6WYiIBS6/SmpKkfT13wrJclkTYg9itULlHi55TBcosUy38KzB0DCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOE9waaS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOE9waaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ECEC4CEF5;
	Tue, 11 Nov 2025 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762878084;
	bh=u26maQ0nwiVW/Xk5u9yHntcgSsE6XMdO2olI060Cgso=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GOE9waaSogD4b/ZAscbZo/LkAqLi+5Sdls1C2XA6K/EAEMS0j0fVR7MyiSoC9LLSD
	 iEWL3A1PzEf5IZhkZFLoXe4mHXAEP2x6VPbOYxTb1sVscmfp6z52MvPR83qVuxp3/A
	 NtjpfmmTAlzMhWJSB1/95BGVZYnGtvyr4HcQbKcvQEdVGPYwP/HsgZVCXOe6ogd/FU
	 2p841dL6ktCZYce334ZIBRs86sFq9qqvUl4R8dpNWZEXgevSq965Urr+VXJhqzs6fP
	 gehJR4jmvUzvWUP8No8TAUvXzyW0+kZvjimk37i7x9s+dD4t0jwWxJz3me3I54zBs1
	 I+Hrt9rb/i4vg==
Message-ID: <704b4358-30b2-4065-abbb-752f4f9a3c79@kernel.org>
Date: Tue, 11 Nov 2025 17:21:22 +0100
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
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/11/2025 14:53, Paolo Abeni wrote:
> If a subflow receives data before gaining the memcg while the msk
> socket lock is held at accept time, or the PM locks the msk socket
> while still unaccepted and subflows push data to it at the same time,
> the mptcp_graph_subflows() can complete with a non empty backlog.
> 
> The msk will try to borrow such memory, but (some) of the skbs there
> where not memcg charged. When the msk finally will return such accounted
> memory, we should hit the same splat of #597.
> [even if so far I was unable to replicate this scenario]
> 
> This patch tries to address such potential issue by:
> - preventing the subflow from queuing data into the backlog after
>   gaining the memcg. This ensure that at the end of the look all the
>   skbs in the backlog (if any) are _not_ memory accounted.
> - mem charge the backlog to msk
> - 'restart' the subflow and spool any data waiting there.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 46 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5e9325c7ea9c..d6b08e1de358 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4082,10 +4082,12 @@ static void mptcp_graph_subflows(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sock *ssk;
> +	int old_amt, amt;
> +	bool slow;
>  
>  	mptcp_for_each_subflow(msk, subflow) {
> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -		bool slow;
> +		ssk = mptcp_subflow_tcp_sock(subflow);
>  
>  		slow = lock_sock_fast(ssk);
>  
> @@ -4095,8 +4097,48 @@ static void mptcp_graph_subflows(struct sock *sk)
>  		if (!ssk->sk_socket)
>  			mptcp_sock_graft(ssk, sk->sk_socket);
>  
> +		if (!mem_cgroup_from_sk(sk))

Should we not call mem_cgroup_sk_enabled() instead? It does this:

  return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);

That's what is done in net/core/sock.c and net/ipv4/tcp_output.c. Not in
__inet_accept(), because mem_cgroup_sockets_enabled() is checked before.
Maybe we should do the same here?

(Note that it is not clear to me if mem_cgroup can be enabled later on,
and if yes, what should be done with existing connections.)

> +			goto unlock;
> +
>  		__mptcp_inherit_cgrp_data(sk, ssk);
>  		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
> +
> +		/* Prevent subflows from queueing data into the backlog
> +		 * as soon as cg is set; note that we can't race
> +		 * with __mptcp_close_ssk setting this bit for a really
> +		 * closing socket, because we hold the msk socket lock here.
> +		 */
> +		subflow->closing = 1;
> +
> +unlock:
> +		unlock_sock_fast(ssk, slow);
> +	}
> +
> +	if (!mem_cgroup_from_sk(sk))

Same here?

> +		return;
> +
> +	/* Charge the bl memory, note that __sk_charge accounted for
> +	 * fwd memory and rmem only
> +	 */
> +	mptcp_data_lock(sk);
> +	old_amt = sk_mem_pages(sk->sk_forward_alloc +
> +			       atomic_read(&sk->sk_rmem_alloc));
> +	amt = sk_mem_pages(msk->backlog_len + sk->sk_forward_alloc +
> +		     atomic_read(&sk->sk_rmem_alloc));

(Same as Geliang for the alignment here, and eventually calling
kmem_cache_charge() like in __inet_accept())

> +	amt -= old_amt;
> +	if (amt)
> +		mem_cgroup_sk_charge(sk, amt, GFP_ATOMIC | __GFP_NOFAIL);

Just to be sure: no need to check if there was an error? It is not done
in __inet_accept() either, so I guess no?

> +	mptcp_data_unlock(sk);
> +
> +	/* Finally let the subflow restart queuing data. */
> +	mptcp_for_each_subflow(msk, subflow) {
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		slow = lock_sock_fast(ssk);
> +		subflow->closing = 0;
> +
> +		if (mptcp_subflow_data_available(ssk))
> +			mptcp_data_ready(sk, ssk);
>  		unlock_sock_fast(ssk, slow);
>  	}
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

