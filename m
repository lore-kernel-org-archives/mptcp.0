Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84F126C05
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641121; cv=none; b=Xvoy4O/NakRSTrG39bWfayNdXYH5BVlsy13ahB1t473t3PlzKqpXCCRtD9xqpjWkExDtg7FyCM4ZQHDFy91zek5y4xV7pibNrz5FN2KsuorwLTVhZvFQlVt6QSvaDjBVv/pSE0pJG9OfG4gOODUKU5eX6sSUwpGFPS8IFEg2SjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641121; c=relaxed/simple;
	bh=gX2Se1jHJlIEdkFVt+w1ixKIOTk90g8Zv0FanK97qkY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ES8wfwfzDOvdhYD1nRHPzSp3ZQipCQhUNqrj30stEJL5nOYcQ2SZBuTp5aa40bYPpBZSpGZzrFD5MjdehF1MVfpbXXzGM0CYg6/v0qTGp57vqANvQ3wtzeGPoMro7hqPSmEbrkjb6DFTWS11o4Y+xcTl0IopwxL+67G1x+cejKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6tYSv5x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6tYSv5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3752FC4CEC3;
	Tue, 22 Oct 2024 23:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729641121;
	bh=gX2Se1jHJlIEdkFVt+w1ixKIOTk90g8Zv0FanK97qkY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=u6tYSv5xW45vgiVbapMetUAj61EONZM217IRzYkDUyLW9RNXIeQfPaoVYINjma+F8
	 1V8fBvLjfbAYZLWrXSSigygF9btJQjf6QF/0tCY0cnCn02bqk4kkx8bcQ0PthBZ++Z
	 z5amPBxyWmSVbVfjb3YUTBRRQSbVNzxtXVj87X8uk8n0VshuTHq65ks5VOg1ibFZMZ
	 iPeDW/eFHMJ65MO8yZiL58gtCNALG7jkaanwx8Lbd4mxilYJJhdAcMYjrIGWKswzqD
	 IHz/IXlGVEvo6A6QLykJ7QF6QgReDEqwI2nayVu32O+EQgcTFYl/aApNJDh+QuqxNX
	 9akg3JeLJEPBw==
Date: Tue, 22 Oct 2024 16:52:00 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 2/5] Squash to "selftests/bpf: Add bpf_rr
 scheduler & test"
In-Reply-To: <cc23cd700d88642bf4396739181286262e208d8b.1729583414.git.tanggeliang@kylinos.cn>
Message-ID: <1dfa37e3-f26d-d55c-2ee1-9cd877e1042b@kernel.org>
References: <cover.1729583414.git.tanggeliang@kylinos.cn> <cc23cd700d88642bf4396739181286262e208d8b.1729583414.git.tanggeliang@kylinos.cn>
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
> .../selftests/bpf/progs/mptcp_bpf_rr.c        | 26 ++++++++-----------
> 1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> index 638ea6aa63b7..e02b8cfb262b 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> @@ -34,10 +34,9 @@ SEC("struct_ops")
> int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
> 	     struct mptcp_sched_data *data)
> {
> -	struct mptcp_subflow_context *subflow;
> +	struct mptcp_subflow_context *subflow, *next;
> 	struct mptcp_rr_storage *ptr;
> 	struct sock *last_snd = NULL;
> -	int nr = 0;
>
> 	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
> 				 BPF_LOCAL_STORAGE_GET_F_CREATE);

Hi Geliang -

Thanks for the series. The bpf_iter code simplifies these scheduler 
patches significantly!

> @@ -45,31 +44,28 @@ int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
> 		return -1;
>
> 	last_snd = ptr->last_snd;
> +	next = bpf_mptcp_subflow_ctx(msk->first);
>
> -	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> -		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
> -		if (!last_snd || !subflow)
> +	bpf_for_each(mptcp_subflow, subflow, msk) {
> +		if (!last_snd)

last_snd is never changed inside the loop, it's more efficient to check it 
before bpf_for_each().

- Mat

> 			break;
>
> -		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
> -			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
> -			    !bpf_mptcp_subflow_ctx_by_pos(data, i + 1))
> +		if (bpf_mptcp_subflow_tcp_sock(subflow) == last_snd) {
> +			subflow = bpf_iter_mptcp_subflow_next(&___it);
> +			if (!subflow)
> 				break;
>
> -			nr = i + 1;
> +			next = subflow;
> 			break;
> 		}
> 	}
>
> -	subflow = bpf_mptcp_subflow_ctx_by_pos(data, nr);
> -	if (!subflow)
> -		return -1;
> -	mptcp_subflow_set_scheduled(subflow, true);
> -	ptr->last_snd = mptcp_subflow_tcp_sock(subflow);
> +	mptcp_subflow_set_scheduled(next, true);
> +	ptr->last_snd = bpf_mptcp_subflow_tcp_sock(next);
> 	return 0;
> }
>
> -SEC(".struct_ops")
> +SEC(".struct_ops.link")
> struct mptcp_sched_ops rr = {
> 	.init		= (void *)mptcp_sched_rr_init,
> 	.release	= (void *)mptcp_sched_rr_release,
> -- 
> 2.45.2
>
>
>
