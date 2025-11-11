Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD534D38B
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845694; cv=none; b=uVEVFC/RIchANymy8AeDBvikTRPhmzBXBgSxwfGjBwqWL/0NKURnZvXdbv8o1RrhfuOcXTB0fLGdRd2OT0/E79h+9FBRRaSk8Pbr9o5dTKbOZ/Bghh9siEeS2Qc4o+LTNZfqndY9lt3craC6eRm/HacqKPhtjbKl+R4kC2N0LgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845694; c=relaxed/simple;
	bh=Wq5DvLmZ1EjxqtYe3A4HCkgOgclZyrR6phYNUtBiH6s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTNcKut6i5an+JcVvuUendcS1jQpHnW5yeKb0wwzxmR1iNy3D+YtSt/pLKrs5CuGSdMGsX0yS2owsw8bI8mSHhI4tFVkA7wMZQN/k5WNbUIUfOWoNLdOtRzsKN+0lfGzTVKB/DZHDhvmTRFBxCfF+U6OclKgipf61ygMjtGq5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huOFLdQy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huOFLdQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AB8C16AAE;
	Tue, 11 Nov 2025 07:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845693;
	bh=Wq5DvLmZ1EjxqtYe3A4HCkgOgclZyrR6phYNUtBiH6s=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=huOFLdQys5tdQuspn2T3kGIzYu4QfRvUoG30wb/CQvh991FuNk75QGwOTN+odljYC
	 HEm+eXfqHBrMPBfOIRKGw7i32aPphW83fMnd9iQKoWQ/5zEBjPwZOm+EL6PT5C+FvO
	 B/UHp/7dyHjeSCrQI3cHp4RBEzTAA9Rzf3sa2h9Mj88LO7SJcoTfzqs0yrfpyNGGtY
	 eRuzNVUPHqgU4o7zHT46Rgm2mq3lfbuxeYb5QDv9QCuNLzlX89YMns9237q8x8Kvna
	 gT6vD6RDht2amWEODa1tBnzEDQmXO6qKzZfjKRud55cgIGGCfWYRBz6jvfRDYqLBBh
	 QvSKxZq+q/vaw==
Message-ID: <2f6f0b1e22690e962d4fff02838d23d4b8a65f07.camel@kernel.org>
Subject: Re: [PATCH v2 mptcp-next] Squash-to: "mptcp: leverage the backlog
 for RX packet processing"
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 11 Nov 2025 15:21:29 +0800
In-Reply-To: <ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com>
References: 
	<ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for this fix.

On Sun, 2025-11-09 at 14:53 +0100, Paolo Abeni wrote:
> If a subflow receives data before gaining the memcg while the msk
> socket lock is held at accept time, or the PM locks the msk socket
> while still unaccepted and subflows push data to it at the same time,
> the mptcp_graph_subflows() can complete with a non empty backlog.
> 
> The msk will try to borrow such memory, but (some) of the skbs there
> where not memcg charged. When the msk finally will return such
> accounted
> memory, we should hit the same splat of #597.
> [even if so far I was unable to replicate this scenario]
> 
> This patch tries to address such potential issue by:
> - preventing the subflow from queuing data into the backlog after
>   gaining the memcg. This ensure that at the end of the look all the
>   skbs in the backlog (if any) are _not_ memory accounted.
> - mem charge the backlog to msk
> - 'restart' the subflow and spool any data waiting there.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 46
> ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5e9325c7ea9c..d6b08e1de358 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4082,10 +4082,12 @@ static void mptcp_graph_subflows(struct sock
> *sk)
>  {
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sock *ssk;
> +	int old_amt, amt;
> +	bool slow;
>  
>  	mptcp_for_each_subflow(msk, subflow) {
> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -		bool slow;
> +		ssk = mptcp_subflow_tcp_sock(subflow);
>  
>  		slow = lock_sock_fast(ssk);
>  
> @@ -4095,8 +4097,48 @@ static void mptcp_graph_subflows(struct sock
> *sk)
>  		if (!ssk->sk_socket)
>  			mptcp_sock_graft(ssk, sk->sk_socket);
>  
> +		if (!mem_cgroup_from_sk(sk))
> +			goto unlock;

I think it's better to use "continue" here, just like in v1, so that
other subflows also have a chance to call mptcp_sock_graft(), but we
need to call unlock_sock_fast() before "continue".

Besides, wouldn't it be more appropriate to squash these lines into
"mptcp: fix memcg accounting for passive sockets"?

> +
>  		__mptcp_inherit_cgrp_data(sk, ssk);
>  		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
> +
> +		/* Prevent subflows from queueing data into the
> backlog
> +		 * as soon as cg is set; note that we can't race
> +		 * with __mptcp_close_ssk setting this bit for a
> really
> +		 * closing socket, because we hold the msk socket
> lock here.
> +		 */
> +		subflow->closing = 1;
> +
> +unlock:
> +		unlock_sock_fast(ssk, slow);
> +	}
> +
> +	if (!mem_cgroup_from_sk(sk))
> +		return;
> +
> +	/* Charge the bl memory, note that __sk_charge accounted for
> +	 * fwd memory and rmem only
> +	 */
> +	mptcp_data_lock(sk);
> +	old_amt = sk_mem_pages(sk->sk_forward_alloc +
> +			       atomic_read(&sk->sk_rmem_alloc));
> +	amt = sk_mem_pages(msk->backlog_len + sk->sk_forward_alloc +
> +		     atomic_read(&sk->sk_rmem_alloc));

The code here is not aligned properly.

> +	amt -= old_amt;
> +	if (amt)
> +		mem_cgroup_sk_charge(sk, amt, GFP_ATOMIC |
> __GFP_NOFAIL);

I'm not sure if we need to call kmem_cache_charge() here, just like in
__sk_charge().

WDYT?

Thanks,
-Geliang

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
>  		unlock_sock_fast(ssk, slow);
>  	}
>  }

