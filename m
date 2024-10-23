Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E006139B
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641819; cv=none; b=FdiZ50lF0vTZq8SqPMMHhoKPaqcxtdzK5S3v14E5SpxkmbIp/yFjQL2IJs4L2K2sEu4sjFYC1bwdjY6AlE38CuH4jLjAdir+f7xcqPqgTxSegLfAOyLnGG5qlvSZBoa0ebwAE+kJNVDrLIBUIkdd4Sfz0W7U3vIUE22Udby5Se0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641819; c=relaxed/simple;
	bh=5wIeRUcQ/mFvieIslP3hT97BXAw2kkT77hRtan+Lu6M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S1Lcz+s6IkQsOiBXZcDVP60v71xpiVDfZPqhgVL/WXwFHv4t3q2b8RxsCrmExkUl7l+QsjFr0yqSGE3t7J+9un9VaAQxD13Mqp4p3bwfg+ChkpvuOqzrvVYZUdtHbx5oB+UXB5Uc854FvbH0eAQ6xNahMggZRI+UFP+MyhwXOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxdz/9VJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxdz/9VJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94AFC4CEC3;
	Wed, 23 Oct 2024 00:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729641818;
	bh=5wIeRUcQ/mFvieIslP3hT97BXAw2kkT77hRtan+Lu6M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qxdz/9VJx3HdQGeu71XLdonYWSBYPrhpG7fCOPGZ/VlRE4oV9xoKkqpPreBNhj+qN
	 0xxJyPKsuI4sn+FzzltP/91HlgmA4Pgku7uiN0h6sD8Fj1J1cNKG47YQNDIJgCif23
	 HqMNkWPZkLtmD7fgLXNfJVy3jFfE9L1XZPjuUiT1ry7EYekWko66kcs8TkLmRG0k/c
	 hapxLnmzO2l6SL/BezKc6XcehBYEklQW1uR2mjGwSnkJwMwfiFVJNhmhjn6nTpmYSC
	 jZbxil1ozuE/lu7oUpCu2G88L3Dqhxd6gVSaLEx8sEM9GANlEqQZizrz1AmZHz4tj+
	 XG0sPo7pCk2YA==
Date: Tue, 22 Oct 2024 17:03:37 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 4/5] Squash to "selftests/bpf: Add bpf_burst
 scheduler & test"
In-Reply-To: <a9d3b8bc14bd6e93cee030a80db39f3229e1216e.1729583414.git.tanggeliang@kylinos.cn>
Message-ID: <2bc8e804-3fca-086b-5050-b178eda1066a@kernel.org>
References: <cover.1729583414.git.tanggeliang@kylinos.cn> <a9d3b8bc14bd6e93cee030a80db39f3229e1216e.1729583414.git.tanggeliang@kylinos.cn>
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
> .../selftests/bpf/progs/mptcp_bpf_burst.c     | 79 ++++++++++---------
> 1 file changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> index eb21119aa8f7..e7df5f048aa4 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> @@ -11,6 +11,10 @@ char _license[] SEC("license") = "GPL";
>
> #define min(a, b) ((a) < (b) ? (a) : (b))
>
> +#define SSK_MODE_ACTIVE	0
> +#define SSK_MODE_BACKUP	1
> +#define SSK_MODE_MAX	2
> +

Hi Geliang -

> struct bpf_subflow_send_info {
> 	__u8 subflow_id;

If you store a subflow pointer here instead of an index, there's no need 
to add the mptcp_lookup_subflow_id() helper function, an extra 
iteration over conn_list is eliminated, and the code is more like 
mptcp_subflow_get_send().

- Mat

> 	__u64 linger_time;
> @@ -23,10 +27,6 @@ extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
> extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
> extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
>
> -#define SSK_MODE_ACTIVE	0
> -#define SSK_MODE_BACKUP	1
> -#define SSK_MODE_MAX	2
> -
> static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
> {
> 	return dividend / divisor;
> @@ -57,6 +57,19 @@ static __always_inline bool sk_stream_memory_free(const struct sock *sk)
> 	return __sk_stream_memory_free(sk, 0);
> }
>
> +static struct mptcp_subflow_context *
> +mptcp_lookup_subflow_by_id(struct mptcp_sock *msk, unsigned int id)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	bpf_for_each(mptcp_subflow, subflow, msk) {
> +		if (subflow->subflow_id == id)
> +			return subflow;
> +	}
> +
> +	return NULL;
> +}
> +
> SEC("struct_ops")
> void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
> {
> @@ -67,8 +80,7 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
> {
> }
>
> -static int bpf_burst_get_send(struct mptcp_sock *msk,
> -			      struct mptcp_sched_data *data)
> +static int bpf_burst_get_send(struct mptcp_sock *msk)
> {
> 	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
> 	struct mptcp_subflow_context *subflow;
> @@ -84,16 +96,10 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
> 		send_info[i].linger_time = -1;
> 	}
>
> -	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> -		bool backup;
> +	bpf_for_each(mptcp_subflow, subflow, msk) {
> +		bool backup = subflow->backup || subflow->request_bkup;
>
> -		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
> -		if (!subflow)
> -			break;
> -
> -		backup = subflow->backup || subflow->request_bkup;
> -
> -		ssk = mptcp_subflow_tcp_sock(subflow);
> +		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
> 		if (!mptcp_subflow_active(subflow))
> 			continue;
>
> @@ -109,7 +115,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
>
> 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
> 		if (linger_time < send_info[backup].linger_time) {
> -			send_info[backup].subflow_id = i;
> +			send_info[backup].subflow_id = subflow->subflow_id;
> 			send_info[backup].linger_time = linger_time;
> 		}
> 	}
> @@ -119,10 +125,10 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
> 	if (!nr_active)
> 		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
>
> -	subflow = bpf_mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
> +	subflow = mptcp_lookup_subflow_by_id(msk, send_info[SSK_MODE_ACTIVE].subflow_id);
> 	if (!subflow)
> 		return -1;
> -	ssk = mptcp_subflow_tcp_sock(subflow);
> +	ssk = bpf_mptcp_subflow_tcp_sock(subflow);
> 	if (!ssk || !sk_stream_memory_free(ssk))
> 		return -1;
>
> @@ -141,23 +147,18 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
> 	return 0;
> }
>
> -static int bpf_burst_get_retrans(struct mptcp_sock *msk,
> -				 struct mptcp_sched_data *data)
> +static int bpf_burst_get_retrans(struct mptcp_sock *msk)
> {
> -	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
> +	struct sock *backup = NULL, *pick = NULL;
> 	struct mptcp_subflow_context *subflow;
> 	int min_stale_count = INT_MAX;
> -	struct sock *ssk;
>
> -	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> -		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
> -		if (!subflow)
> -			break;
> +	bpf_for_each(mptcp_subflow, subflow, msk) {
> +		struct sock *ssk = bpf_mptcp_subflow_tcp_sock(subflow);
>
> 		if (!mptcp_subflow_active(subflow))
> 			continue;
>
> -		ssk = mptcp_subflow_tcp_sock(subflow);
> 		/* still data outstanding at TCP level? skip this */
> 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
> 			mptcp_pm_subflow_chk_stale(msk, ssk);
> @@ -166,23 +167,23 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
> 		}
>
> 		if (subflow->backup || subflow->request_bkup) {
> -			if (backup == MPTCP_SUBFLOWS_MAX)
> -				backup = i;
> +			if (!backup)
> +				backup = ssk;
> 			continue;
> 		}
>
> -		if (pick == MPTCP_SUBFLOWS_MAX)
> -			pick = i;
> +		if (!pick)
> +			pick = ssk;
> 	}
>
> -	if (pick < MPTCP_SUBFLOWS_MAX) {
> -		subflow_id = pick;
> +	if (pick)
> 		goto out;
> -	}
> -	subflow_id = min_stale_count > 1 ? backup : MPTCP_SUBFLOWS_MAX;
> +	pick = min_stale_count > 1 ? backup : NULL;
>
> out:
> -	subflow = bpf_mptcp_subflow_ctx_by_pos(data, subflow_id);
> +	if (!pick)
> +		return -1;
> +	subflow = bpf_mptcp_subflow_ctx(pick);
> 	if (!subflow)
> 		return -1;
> 	mptcp_subflow_set_scheduled(subflow, true);
> @@ -194,11 +195,11 @@ int BPF_PROG(bpf_burst_get_subflow, struct mptcp_sock *msk,
> 	     struct mptcp_sched_data *data)
> {
> 	if (data->reinject)
> -		return bpf_burst_get_retrans(msk, data);
> -	return bpf_burst_get_send(msk, data);
> +		return bpf_burst_get_retrans(msk);
> +	return bpf_burst_get_send(msk);
> }
>
> -SEC(".struct_ops")
> +SEC(".struct_ops.link")
> struct mptcp_sched_ops burst = {
> 	.init		= (void *)mptcp_sched_burst_init,
> 	.release	= (void *)mptcp_sched_burst_release,
> -- 
> 2.45.2
>
>
>
