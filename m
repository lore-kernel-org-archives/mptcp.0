Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659639;
	b=OHxo37x35GPEvFSeKLeaHu+YSpsPIbxDQY/m4su7QCyNM/8ww/kgyI0pDCRRWo8VkF8A
	 zyBgNtrJYy1xOZ0QPAmomjenvJEY93IjCwqvk1iKecDeG29eQ6IcHZ0MCTliB2e80RBX+
	 n8EnhvukO6MZNz7Bnf64ftpO3UXSANHzAYuzmpWpzdfRhTYzggfjeBKaNPPmTNniPZtza
	 uh+6huZgRPznU5ChW/LHCG/5KDK9qjZ5mO3XShBzCjVgxZ0Od7ewcnfGgqr/RYp2lYGZY
	 g5+tEe+GetRdphjhnvz78sfk/QmiMexAk0aJKVEQNN+011enF+wbs9kW6u8GRoUpNYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659639;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=Eitw7+tT/8Xx2ZcLrp1palsM4P7O9hL6DPWrheUJIQU=;
	b=FI4y7hLw+8OQQzny82bX1m8nxzwYKsHR88va9k/rCM61/RDUFM4Y3cniLmAyTgf7jArL
	 RVISepV01fLFKj/LKaq/1mh6oTk2cY+p0STlEX9HdhmgLuM8dNTobSkxW6Qj9Bn9eCdzh
	 GI6Z8aQBiPRHlwebGY+ldjb+UPOgT+Sc1bW8bd/w+C16cMSVqxAQmG4T109nWslGPI0/O
	 Yg7zMv3e73xWqG9MUlmhDIHi8xD+EUFvhC/lp9HzH220ECjM7XVijhaRUGMLVwjusn/86
	 dToWnS+zQHXqozTt1qCC2WPsnW808odvnOBy5Zq2V0XMOECfS1dxFJpbtbCotesuPqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPHEpob3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E01606A32E
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPHEpob3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD96D1F000D1;
	Thu, 26 Nov 2026 02:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795659639;
	bh=Eitw7+tT/8Xx2ZcLrp1palsM4P7O9hL6DPWrheUJIQU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=PPHEpob3Fh3iyFsBRE3xU0V11/t6Z/aZXgTOpa9YL4A3zUo67s+PqNfblTjB2iFyh
	 J20v5ZMFiHYwn7BBtPOb69fvTuD+vKwuGvAs7xWb7mk+H1U7QX0Mv4tOoZAZiSkZ1J
	 kZ85TbmfmPeZhO0Tqhrd2wnn8AKpawRkHzW1UkBQCMxWXe6Y3EuhfhIneqJk+hzhrc
	 tYXqCq8LlOiVOkEbgSyjxFVDLXjKHnZBqAOgUj5oV4dcrI8x0s5ZE6i1g85u+Cz6j5
	 8NrqpAsoV8zum9VvdQdEOMOBS7j8CE5SSTny7PHgDf+0p8zHvoSXrE5yBgbYlLNRk7
	 EGUZ5TCMSvxVA==
Date: Wed, 25 Nov 2026 18:20:37 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH mptcp-net v3 33/50] mptcp: don't charge a shared page
 twice at accept()
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-33-416c0920c73f@kernel.org>
Message-ID: <6e1bc879-784e-5115-fa6c-0365182929a1@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org> <20261124-mptcp-cmason-fixes-v3-33-416c0920c73f@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 24 Nov 2026, Matthieu Baerts (NGI0) wrote:

> From: Chris Mason <mason@kernel.org>
>
> accept() of an MPTCP connection that has already received data can leak
> one page of memory cgroup charge, and the leaked charges can get the
> server OOM killed.
>
> At accept(), __inet_accept() charges the MPTCP socket (msk) for the
> memory that it holds, rounded up to whole pages, and
> mptcp_graft_subflows() does the same for each subflow. A page is
> uncharged only once, when the socket that holds it releases it, so
> rounding up each socket on its own is only correct while each page
> belongs to one socket. But for each skb that the msk takes over from a
> subflow, it borrows skb->truesize bytes from the pages that the subflow
> reserved, so the two can share a page:
>
>    reserved by the subflow      4096 bytes  1 page
>      now held by the msk         896 bytes  charged for 1 page
>      still held by the subflow  3200 bytes  charged for 1 page
>
> The fix used here is to keep a running sum of what the msk and its
> subflows hold, and to let the new mptcp_charge_subflow() charge each
> subflow only for the pages that it adds to the rounded-up sum.
>
> This issue has been found with the help of an LLM, and reproduced in a
> VM, with the reproducer shared with the original version of this patch:
> an MPTCP server in a memory cgroup, the first byte of the client
> arriving before accept(). Without this patch, 4096 bytes stayed charged
> to the memory cgroup for each connection, after its end:
>
>  SNAP label=after-1000 rounds=1000 sockets_left_in_srv=0 [...] c_sock=4096000 [...]
>  SNAP label=after-5000 rounds=5000 sockets_left_in_srv=0 [...] c_sock=20480000 [...]
>
> With a memory limit, the original version of this patch reported that
> the server was killed by the OOM killer after about 14,400 connections.
>
> Fixes: 9db5b3cec4ec ("mptcp: borrow forward memory from subflow")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ Shorter comment. Commit message: how the issue was found, and its
>  symptoms. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Note (Clashiko on v2): the backlog can still be charged twice here: this
> is fixed by the next patch.
> ---
> net/mptcp/protocol.c | 21 ++++++++++++++++++++-
> 1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f8cb585da0b3..504fe4a9954f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4664,10 +4664,26 @@ static int mptcp_listen(struct socket *sock, int backlog)
> 	return err;
> }
>
> +/* The msk and its subflows share pages: charge their rounded-up sum */

I suggest adding a note that this is similar to __sk_charge() (to make it 
easier keep the two functions consistent if either has future changes). 
But otherwise the patch looks good.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> +static int mptcp_charge_subflow(struct sock *sk, struct sock *ssk, int mem)
> +{
> +	int new_mem = mem + ssk->sk_forward_alloc +
> +		      atomic_read(&ssk->sk_rmem_alloc);
> +	int amt = sk_mem_pages(new_mem) - sk_mem_pages(mem);
> +	gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
> +
> +	mem_cgroup_sk_inherit(sk, ssk);
> +	if (amt > 0)
> +		mem_cgroup_sk_charge(ssk, amt, gfp);
> +	kmem_cache_charge(ssk, gfp);
> +	return new_mem;
> +}
> +
> static void mptcp_graft_subflows(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	int mem;
>
> 	if (mem_cgroup_sockets_enabled) {
> 		LIST_HEAD(join_list);
> @@ -4685,6 +4701,9 @@ static void mptcp_graft_subflows(struct sock *sk)
> 		__mptcp_flush_join_list(sk, &join_list);
> 	}
>
> +	/* What __inet_accept() just charged for the msk, before rounding up. */
> +	mem = sk->sk_forward_alloc + atomic_read(&sk->sk_rmem_alloc);
> +
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>
> @@ -4700,7 +4719,7 @@ static void mptcp_graft_subflows(struct sock *sk)
> 			goto unlock;
>
> 		__mptcp_inherit_cgrp_data(sk, ssk);
> -		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
> +		mem = mptcp_charge_subflow(sk, ssk, mem);
>
> unlock:
> 		release_sock(ssk);
>
> -- 
> 2.55.0
>
>
>
