Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B7380
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642203; cv=none; b=FGhRBPwIEWBwuqG7hhiXzYfwTFjZ00BejZ0EkKEPR98YxoaCfBCu2A5MJ0IAMFYzYiqgFxvWg4ppTECU7OfKWcr9b+9xEAyWEpOwDp8ft9XznOeoJwkBTmsODJPzyUjyDIrN08QlWEo+s195JXVXKrznOEf064DeTu8hmUzGmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642203; c=relaxed/simple;
	bh=PJkClbZDaiSYpHPbqPxaSibEpuiHJHDShjuUwY0QwqA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lBOKZzQPYSxPn2AS6eQFTO7SeghZFJFO7B4Ohvq3/mSipYBRny4rRuoEN4TESzttvCTil+ZaFPefKsLSK+XoQeenZ0s8i2E0BGtX7N7rMjmqRIgY2AKZdvOTG/aAgOY4XpNgYVICertd/TFUWVgThrsff5TThexeCAUm//So+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK67Nn/p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK67Nn/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BDCC4CEC3;
	Wed, 23 Oct 2024 00:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729642202;
	bh=PJkClbZDaiSYpHPbqPxaSibEpuiHJHDShjuUwY0QwqA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YK67Nn/p6jYcmm5YioexmHmZb6DH/r9HpMnmI9D5h6ozci11lWXumbeN6pgsslMRC
	 OKYaKyYONav36q0rLAs+XvMr9my7GFRuBs3aKEYGZAiSd6bhEHzr2rQa2fL/P8dvuh
	 fzChO2Dp15vXHz9bNFzJFFnVA6kPZUNzECETO5hfMRDWxAANo+OLvoX5tNnMsV5Sr8
	 SghuuevnWJxukQ6bJ2/BLYizZWaV9KiPj3qOm7NBNm8wck6mJ6sh/6vBJ+C1iuH7e7
	 sijTMaQUqMTPhGTEN6O2Ae17j60wUDn+DbTuONg1qq1i5V2C1W15328h0ZOBpVJZ7D
	 mc5Oa6l+5CyyQ==
Date: Tue, 22 Oct 2024 17:10:02 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 5/5] Squash to "selftests/bpf: Add bpf_first
 scheduler & test"
In-Reply-To: <47d89319cf58196896a25ae6b3199b27ad73fe97.1729583414.git.tanggeliang@kylinos.cn>
Message-ID: <66d3e0b9-cafe-30c2-4d2a-09f29c3f1b52@kernel.org>
References: <cover.1729583414.git.tanggeliang@kylinos.cn> <47d89319cf58196896a25ae6b3199b27ad73fe97.1729583414.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 22 Oct 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Use the newly added bpf_for_each() helper to walk the conn_list.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> tools/testing/selftests/bpf/progs/mptcp_bpf.h       |  3 ---
> tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 ++++++++--
> 2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> index 376979a9c4f0..52bc8ac03508 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -60,7 +60,4 @@ extern bool bpf_ipv6_addr_v4mapped(const struct mptcp_addr_info *a) __ksym;
> extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> 					bool scheduled) __ksym;
>

Hi Geliang -

> -extern struct mptcp_subflow_context *
> -bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
> -

After this is removed, there are no remaining users of 
bpf_mptcp_subflow_ctx_by_pos(). I suggest removing that function.

> #endif
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> index d57399b407a7..f2f9e66455b6 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> @@ -20,11 +20,17 @@ SEC("struct_ops")
> int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
> 	     struct mptcp_sched_data *data)
> {
> -	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
> +	struct mptcp_subflow_context *subflow;
> +
> +	bpf_for_each(mptcp_subflow, subflow, msk) {
> +		mptcp_subflow_set_scheduled(subflow, true);
> +		break;
> +	}
> +

The iterator makes this more complicated. Use 
bpf_mptcp_subflow_ctx(msk->first) like bpf_rr_get_subflow()?

- Mat

> 	return 0;
> }
>
> -SEC(".struct_ops")
> +SEC(".struct_ops.link")
> struct mptcp_sched_ops first = {
> 	.init		= (void *)mptcp_sched_first_init,
> 	.release	= (void *)mptcp_sched_first_release,
> -- 
> 2.45.2
>
>
>
