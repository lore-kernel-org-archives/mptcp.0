Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFAF1F4199
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555520; cv=none; b=XkpEaKRKSkKJXG+ABZfmi8oATAF3UtsFk9YnrI12X3cXSuxRiJfVFd1H2H56sMK08OowH2GKLIdaAxX6oz1CpPeuxq33ve3A+EGcO3fo+acvxUiVX25UmCCtqFYtbeedUyLqtCsCymPlSXgqRrS7DjMAw1AqeABXf0NhQyvDTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555520; c=relaxed/simple;
	bh=xEZhLzkJBXkP6rsKEEBnbg5JH4mvAmAv0JmyN0t4XIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIwYKhk4h6u8eYXGmr0rcddXULay8YbMuj1lvwEd77oZz2SuCf9JXpU85l4c7cSiMIPdfRD4PSsF5VZgDyEw2gqW1zhAnsyJ3kv2NimGNQ8WMTI5LdtOxeb83TwHbzfeSHUTHS/IhWP9MrH2GUcf9VLnYyKj866g5n38R8Negyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuYe6pp5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuYe6pp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68452C4CEE3;
	Fri, 21 Mar 2025 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742555520;
	bh=xEZhLzkJBXkP6rsKEEBnbg5JH4mvAmAv0JmyN0t4XIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GuYe6pp5texD81rwmyZ3b3fyDcX9aaWY3lCKPv3RLJfCELeFAN3YyM+/L3xsoykdn
	 2I9aI6s+m4sjsVze5Om7PZAskf4wPCSpQDcmOAUgoOA0Ovjuk5CuIoSJxd8U8Q9Ik0
	 JRMpl/VpyRlRRa/U36Hd4F5sYQZ9BY1TKwk9eHVBCbAFgvVropm1KzO13ha1BbyUxy
	 UodfoIUCFCZY+VjfaHa+Xj49KNqBMLgNRXY6e0deOultwOBJ5fQFlhh0PqBUgCbtj8
	 TqUOQkRgJDjmj7e9/afz0Ip+49Y8ZqDsCYS5WNkYqqS4UHOJ/xt6hcRK0Rh6KKdBVq
	 ZQem4405A/+Iw==
Message-ID: <6a3f0bec-ae6a-4499-8ef6-00b5b798ac17@kernel.org>
Date: Fri, 21 Mar 2025 12:11:57 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 2/4] bpf: Export mptcp path manager kfuncs
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742521587.git.tanggeliang@kylinos.cn>
 <0c324baa241000f32a1b97017da8e96a383767ad.1742521587.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0c324baa241000f32a1b97017da8e96a383767ad.1742521587.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/03/2025 02:49, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch exports mptcp path manager helpers into BPF, adds these
> kfunc names into mptcp common kfunc_set.
> 
> bpf_kmemdup_entry() and bpf_kfree_entry() are wrappers of kmemdup() and
> kfree(), using to alloc and free an mptcp address entry.

That feels really wrong: a BPF program cannot crash or cause problems
(deadlock, memleaks, etc.), it should then not be able to reserve memory
except in a map or something that can be automatically freed when the
bpf program is removed.

> bpf_set_bit() and bpf_bitmap_fill() are wrappers of __set_bit() and
> bitmap_fill(), using for mptcp address ID bitmap.

Is it really needed? Are there not already some  it not store stuff in a
BPF map?

> bpf_spin_lock_bh() and bpf_spin_unlock_bh() are wrappers of spin_lock_bh()
> and spin_unlock_bh(), using to lock and unlock the mptcp pm lock.

Same here, a BPF should not be able to lock something and never unlock
it. I think there are some stuff in BPF to get a lock automatically.
(Polymorphisme?)

(...)

> @@ -564,6 +596,22 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_kmemdup_entry)
> +BTF_ID_FLAGS(func, bpf_kfree_entry)
> +BTF_ID_FLAGS(func, bpf_set_bit)
> +BTF_ID_FLAGS(func, bpf_bitmap_fill)
> +BTF_ID_FLAGS(func, bpf_spin_lock_bh)
> +BTF_ID_FLAGS(func, bpf_spin_unlock_bh)

This should not be needed, a BPF program should not need them. Not sure
about the bitmap, but for the rest, something else should be used
(maps?) or automatically done (locks).

> +BTF_ID_FLAGS(func, mptcp_pm_nl_lookup_addr)
> +BTF_ID_FLAGS(func, mptcp_pm_nl_append_new_local_addr_msk)

That's specific to the in-kernel PM, that feels wrong. Addresses should
be stored in BPF maps or similar instead I guess.

> +BTF_ID_FLAGS(func, mptcp_pm_get_add_addr_signal_max)
> +BTF_ID_FLAGS(func, mptcp_pm_get_add_addr_accept_max)
> +BTF_ID_FLAGS(func, mptcp_pm_get_subflows_max)
> +BTF_ID_FLAGS(func, mptcp_pm_get_local_addr_max)

That feels wrong, it should not be needed, that's specific to the
in-kernel PM as well and set via netlink.

> +BTF_ID_FLAGS(func, mptcp_pm_add_addr_recv)

Should not be needed, see my comments in part 6.

> +BTF_ID_FLAGS(func, mptcp_pm_is_init_remote_addr)

Should it not be handled by the core (pm.c) or specific to in-kernel? (I
didn't check)

> +BTF_ID_FLAGS(func, mptcp_pm_create_subflow_or_signal_addr)

Specific to the in-kernel PM, that feels wrong.

> +BTF_ID_FLAGS(func, mptcp_pm_rm_addr_recv)

Maybe not needed, see my comments in part 6.

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

