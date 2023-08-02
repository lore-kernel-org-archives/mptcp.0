Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21808DF42
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 17:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8709DC433C8;
	Wed,  2 Aug 2023 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690996258;
	bh=Ti7/OyOXMHlJ8IKvF3asK4T9EZx3rS7g6PZhc/rlBY4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jFDMvQG9xd0gp/eXt5MiqPFJhaIKQtZBorm2vWWGAAzbSwfqussu/lCFf4IYfwc4t
	 7sYKt9y2ViIYoL3zaBjgfLmKenMmrQiMDkQLIhbd4gt2hL+9t2zbW99yCSHXFDTR+M
	 afo3OrZx0oCr3vXkzeqsH/figEdML8R8vs/ObHvMcs38OathTnShoxYQKoQT5ZSQPb
	 oMitFS6f+DQA5krtdVXxnrjBjhhnKzEjMIDOKKelTEk/Ar/YXJbZZWwubbC/17akTR
	 4EMc05pjfo8PtL2LTS21uKrju/2nShWGQ9P9NKTUrpGPr690K0OvK2z1dUHW9O3M+D
	 g2rpCcAG6+GqA==
Date: Wed, 2 Aug 2023 10:10:58 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, sferlinr@redhat.com
Subject: Re: [PATCH mptcp-next] bpf: Add accesses to bpf_skc_to_tcp_sock
In-Reply-To: <322ae693257df0c5fcd8f9254e062f394fbeab88.1690963606.git.geliang.tang@suse.com>
Message-ID: <05d019f6-2ed0-448f-36a5-bad108412687@kernel.org>
References: <322ae693257df0c5fcd8f9254e062f394fbeab88.1690963606.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 2 Aug 2023, Geliang Tang wrote:

> Squash to "bpf: Add bpf_mptcp_sched_ops" II
>
> As is reported in #417 by sferlin, we can't access tcp_sock fields in
> BPF schedulers.
>
> I gave two suggestions in the comments of #417 to solve it:
>
> 1. Move the helpers which needs to access tcp_sock fields like
> tcp_packets_in_flight() into the kernel space, call the helpers in BPF
> context.
> 2. Add more helpers in the kernel space to access more tcp_sock fields,
> call the helpers in BPF context.
>
> Although these can solve this issue to some extent, but they aren't the
> best solutions.
>
> A better one is using bpf_skc_to_tcp_sock() to get the tcp_sock instead
> of using tcp_sk():
>
>    tp = bpf_skc_to_tcp_sock(sk);
>
> Then we can access every fields of tp and keep sferlin's patch as is.
>
> But this needs to add accesses to call bpf_skc_to_tcp_sock() in BPF
> schedulers.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/417
> Cc: sferlinr@redhat.com
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/bpf.c | 4 ++++
> 1 file changed, 4 insertions(+)

Looks good to squash, thank you Geliang.

- Mat

>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 5c82cc35bfe0..f17a947635bf 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -30,6 +30,10 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
> 		return &bpf_sk_storage_get_proto;
> 	case BPF_FUNC_sk_storage_delete:
> 		return &bpf_sk_storage_delete_proto;
> +	case BPF_FUNC_skc_to_tcp6_sock:
> +		return &bpf_skc_to_tcp6_sock_proto;
> +	case BPF_FUNC_skc_to_tcp_sock:
> +		return &bpf_skc_to_tcp_sock_proto;
> 	default:
> 		return bpf_base_func_proto(func_id);
> 	}
> -- 
> 2.35.3
>
>
>
