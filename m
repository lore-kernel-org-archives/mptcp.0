Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC31AB53A
	for <mptcp@lists.linux.dev>; Mon, 14 Oct 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922018; cv=none; b=WvnhLzbhmGuewdGfU0BJdDnmAq9PkwX0o8dUypF7Rlcgj+FsX/ujYxBpqLzwxSn8nPjiZdnSTWXqO/scaTEFNRPHL8k63ofGuowIUtaOjKvawRTXqjUwkiFlDME2B9L7RacmMVxwrZUuyHZJyIhufX73tLqW5gpTHLaN+uQn5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922018; c=relaxed/simple;
	bh=/AzncVDmfY05+4NwiXNMHDrfqyjPp0P53YeQoCwNtOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPD7hUagOOmPjLki57AkqsAIbelIgYec+wQXPfABiCRWKxjQ6nkO/CKRQ919NO7b6RfbY1+b1Ya3zCtUktgl9kVRO076bGaePEvEkUYlfk3HQCde8CQmo8JjTFIP/Vy+/En0OScmWEZC68kX7JhsIS2iEAyXZwzF/vy8Od8XjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7X0u8zc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7X0u8zc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46939C4CEC3;
	Mon, 14 Oct 2024 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728922018;
	bh=/AzncVDmfY05+4NwiXNMHDrfqyjPp0P53YeQoCwNtOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W7X0u8zcedLG9Yv41iS950MO8MoQELiCsV2ab1gjnFdziGym0l52WcWBt5rpIsXbV
	 6EnDQGj8GiDp3ZQyXa4/KKworWtGkjLYsuHEWqfdGbo9fQKbQ0GYl6KPt69x0vKXIH
	 VVz590UtiQHp+quQ1MqlAA60606m2tDF31SE9j9RcwIomkLtlzjZ9Dy9S3j1mWba1J
	 t1PATaDozLABBoA6S9Zv4XKAJTly3jfKZj9sQK67IxYDj+UyoUpsudLqFfhvKc15Pl
	 sr4zVkmuSU1vfPdtcY+PcJD7UWVMSLhJNsucd111mpuZFrkP+T/Y87ajQADFV6o9dP
	 z/clWzMFY0W3w==
Message-ID: <22b299af-150b-450c-b2c8-6710cf321c2d@kernel.org>
Date: Mon, 14 Oct 2024 18:06:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v9 4/7] selftests/bpf: Add mptcp_subflow
 bpf_iter test prog
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
 <dffa6284797ec2e3e8c8a1f6891f012bd1efdc20.1728466623.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <dffa6284797ec2e3e8c8a1f6891f012bd1efdc20.1728466623.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/10/2024 11:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a ftrace hook for mptcp_sched_get_send() to test the newly
> added mptcp_subflow bpf_iter. This test simulates a typical mptcp packet
> scheduler, which selects a subflow from multiple subflows of an mptcp
> socket to send data.
> 
> Export mptcp_subflow helpers bpf_iter_mptcp_subflow_new/_next/_destroy,
> bpf_mptcp_sock_acquire/_release and other helpers into bpf_experimental.h.
> 
> Use _acquire() to acquire the msk, then use bpf_for_each(mptcp_subflow) to
> walk the subflow list of this msk. Invoke kfuncs mptcp_subflow_active() and
> bpf_mptcp_subflow_tcp_sock() in the loop to pick a subsocket. Finally use
> bpf_mptcp_subflow_ctx() to get the subflow context of this subsocket and
> use mptcp_subflow_set_scheduled() to set it as being scheduled.

Do you think we could have a test not depending on scheduler helpers?
Without this dependence, we could already upstream this series, and get
feedback without having to wait for the new scheduler API.

If you remove the use of mptcp_subflow_active() and
mptcp_subflow_set_scheduled(), that's enough, no?

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  |  7 ++++
>  tools/testing/selftests/bpf/progs/mptcp_bpf.h |  9 ++++
>  .../bpf/progs/mptcp_bpf_iters_subflow.c       | 42 +++++++++++++++++++
>  3 files changed, 58 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index b0668f29f7b3..d43690b17468 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -575,6 +575,13 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
>  extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
>  extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
>  
> +struct bpf_iter_mptcp_subflow;
> +extern int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
> +				      struct mptcp_sock *msk) __weak __ksym;
> +extern struct mptcp_subflow_context *
> +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
> +extern void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
> +
>  extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>  extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
>  extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> index c3800f986ae1..e18796361394 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -43,9 +43,18 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
>  }
>  
>  /* ksym */
> +extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
>  extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
>  					bool scheduled) __ksym;
>  
> +extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
> +extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
> +
> +extern struct mptcp_subflow_context *
> +bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
> +extern struct sock *
> +bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
> +
>  extern struct mptcp_subflow_context *
>  bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
>  
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
> new file mode 100644
> index 000000000000..4268e4604c5a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024, Kylin Software */
> +
> +/* vmlinux.h, bpf_helpers.h and other 'define' */
> +#include "bpf_tracing_net.h"
> +#include "mptcp_bpf.h"
> +
> +char _license[] SEC("license") = "GPL";
> +int subflows;
> +int pid;
> +
> +SEC("fentry/mptcp_sched_get_send")

If I understand correctly, this hook will be called twice on the client
connection for this test because the client is sending two times one
byte, right?

> +int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *ssk = NULL;
> +
> +	if (bpf_get_current_pid_tgid() >> 32 != pid)
> +		return 0;
> +
> +	msk = bpf_mptcp_sock_acquire(msk);
> +	if (!msk)
> +		return 0;
> +	bpf_for_each(mptcp_subflow, subflow, msk) {
> +		if (subflow->token != msk->token)
> +			break;

Out of curiosity, why is this needed? Is it needed for the verifier? Or
just an extra check?
Can you add a comment here explaining why this is there please?

> +
> +		if (!mptcp_subflow_active(subflow))
> +			continue;
> +
> +		ssk = bpf_mptcp_subflow_tcp_sock(subflow);

Do you get 'ssk' just to use bpf_mptcp_subflow_tcp_sock() and
bpf_mptcp_subflow_ctx()?

> +	}
> +	bpf_mptcp_sock_release(msk);
> +
> +	if (!ssk)
> +		return 0;
> +	subflow = bpf_mptcp_subflow_ctx(ssk);
> +	mptcp_subflow_set_scheduled(subflow, true);
> +	subflows = subflow->subflow_id;

Here, it looks like you only check if the last subflow is in the list.

Would it not be better to count the number of subflows in the list? Or
if you want to read something from 'subflow', you could add all subflow_id?

  subflows = 0;

  (...)

  bpf_for_each(mptcp_subflow, subflow, msk)
      subflows += subflow->subflow_id;

By doing that, we will catch if one is missing, and the order is not
important.

If still want to use bpf_mptcp_subflow_tcp_sock() and
bpf_mptcp_subflow_ctx(), maybe you can save other fields from the last
subflow: the token to compare it with the one in the msk? Or the port
number or the address?

> +
> +	return 0;
> +}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

