Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA81DE3CE
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554798; cv=none; b=Gz3QmaF5FaSOJ1sNAezvpvkWDKMXqO0sfPu+ggV/Q62G9to8a00je0L8i8Aw+fbzdrRk7A1BE+LVLul60QiFy2984i3C88YYlQvUK2VdG4as4WHfLUD63z+O3OpT89Z9U9lwlGcHCEDCatqOOLKLwlmalHfAwpe5PyQHQ1RBatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554798; c=relaxed/simple;
	bh=g57BIylUub2Dg4OcaaybLLS/3PupL9BzM5Vslj4r8Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0gWAtKGLDe8/6w599mfCC0sxofHT5Vwdbu2Qzwcmo+xmXJcIxMGnfuL+HJl6Zzv2gexGIC1OREycuNN+NfzQVmOyAZ0v6rG2wGup31UEq0KE6yhjdTXCTvoCKY56SDqN81dw0Z2ypAJSZJheQV/xuHKlvbX2HZkmU8G+2otDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiRy1tEs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiRy1tEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97564C4CEE3;
	Fri, 21 Mar 2025 10:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742554797;
	bh=g57BIylUub2Dg4OcaaybLLS/3PupL9BzM5Vslj4r8Fw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IiRy1tEsuror0eneEzPuN4LNh6Ycty+P2isnmkaeCh/Pw0sXtWtOWxBy5FVtC+f/V
	 J9wl2of3wNr4CkjrWeCpDs38Fbvbi/ocARPqQUP+h34a5QAkyqLbe4yR7zt/nN+ObF
	 ruA1wEiHkRuDFuZHAKG7NOGNBBPuO7NxFSABJ5P+D4NyJnN1lxQWSDjs4YztP+FAbg
	 hgsOSx3YF8jjaFjKfwsCTnTd6GHw165kpdRZ3oA3PfV+/a0nLi20RyccbIR3XHXLeI
	 of+R55GnE+hGQd2M2sUs8uYRJLNVbNZ570xW9AxfqaOubZ6mCj7RkCfpCtHGtt7PZH
	 G7drZJ8GjrzQw==
Message-ID: <9ca98152-9105-4e6c-be16-5fff8be88b90@kernel.org>
Date: Fri, 21 Mar 2025 11:59:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 1/4] bpf: Add mptcp path manager struct_ops
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742521587.git.tanggeliang@kylinos.cn>
 <aa77f73b6b6227cf88fd4aae77c5604593bf79d8.1742521587.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <aa77f73b6b6227cf88fd4aae77c5604593bf79d8.1742521587.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/03/2025 02:49, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch implements a new struct bpf_struct_ops for MPTCP BPF path
> manager: bpf_mptcp_pm_ops. Register and unregister the bpf path manager
> in .reg and .unreg.
> 
> Add write access for some fields of struct mptcp_sock and struct
> mptcp_pm_addr_entry in .btf_struct_access.
> 
> This MPTCP BPF path manager implementation is similar to BPF TCP CC. And
> net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

(...)

> +static int bpf_mptcp_pm_btf_struct_access(struct bpf_verifier_log *log,
> +					  const struct bpf_reg_state *reg,
> +					  int off, int size)

I don't know how it works exactly, but with BPF, can we not force a
program to automatically take a lock (pm->lock) when trying to modify
any of the fields below?

Also, is there really a need for a BPF PM to modify any of these fields
directly?

Are most of them handled either by pm.c before calling a callback or are
specific to the in-kernel PM?

(...)

> +static struct mptcp_pm_ops __bpf_mptcp_pm_ops = {
> +	.get_local_id		= __bpf_mptcp_pm_get_local_id,
> +	.get_priority		= __bpf_mptcp_pm_get_priority,
> +	.established		= __bpf_mptcp_pm_established,
> +	.subflow_established	= __bpf_mptcp_pm_subflow_established,
> +	.allow_new_subflow      = __bpf_mptcp_pm_allow_new_subflow,
> +	.accept_new_subflow     = __bpf_mptcp_pm_accept_new_subflow,

There is a mix of spaces and tabs here above. Only use tabs?

> +	.add_addr_echo		= __bpf_mptcp_pm_add_addr_echo,
> +	.add_addr_received	= __bpf_mptcp_pm_add_addr_received,
> +	.rm_addr_received	= __bpf_mptcp_pm_rm_addr_received,
> +	.init			= __bpf_mptcp_pm_init,
> +	.release		= __bpf_mptcp_pm_release,
> +};

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

