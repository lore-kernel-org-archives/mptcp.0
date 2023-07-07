Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602A107B5
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 18:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38D7C433C7;
	Fri,  7 Jul 2023 18:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688753345;
	bh=1BNMBcfDFZiZ4O9eAOgKo81Vrzt3+1QToS71c4QW1CM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gG+sYF85375tw5a0OhxORIYQbzQNUzb8CxQWucsFLB/iXrvQH+ZkaJb8yvXtSvLfL
	 g+jT9qtuupxJGfIN3K7igAwUrgdT0VUwJECAse0Dsy0jAU9ptfAJD50hq8SfImyk74
	 t+Bph+vE6cntzRZ9iBoYz7jJ24i4uLVZcILut+zTNNP2XIM1a+qWMLndaBjUKc6/pq
	 x7/0YHMfNd+dPLJV6nLrP9Q+/sG3cT9S0BenZi7JDtlQjgUNrtSaoj6622Wn9PBoVQ
	 oUlpslFee++eL3FVyDTo6E0kiaaoz5udrBdjwF5AjS9Rnkde/vwWaKx0OviQoienTR
	 9UP1lycoTUyTQ==
Date: Fri, 7 Jul 2023 11:09:05 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 09/10] selftests/bpf: Add bpf_burst
 scheduler
In-Reply-To: <a65e19eb002b474b070cc31ca471b4e1c6ef8533.1687829823.git.geliang.tang@suse.com>
Message-ID: <7bacaa8f-6271-868e-dbf1-4f88acd7983c@kernel.org>
References: <cover.1687829823.git.geliang.tang@suse.com> <a65e19eb002b474b070cc31ca471b4e1c6ef8533.1687829823.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 27 Jun 2023, Geliang Tang wrote:

> This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
> which is the default scheduler in protocol.c. bpf_burst_get_send() uses
> the same logic as mptcp_subflow_get_send() and bpf_burst_get_retrans
> uses the same logic as mptcp_subflow_get_retrans().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |   4 +
> .../selftests/bpf/progs/mptcp_bpf_burst.c     | 205 ++++++++++++++++++
> 2 files changed, 209 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index c749940c9103..c1d7963c3bc8 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -36,6 +36,7 @@ enum sk_pacing {
> struct sock {
> 	struct sock_common	__sk_common;
> #define sk_state		__sk_common.skc_state
> +	int			sk_wmem_queued;
> 	unsigned long		sk_pacing_rate;
> 	__u32			sk_pacing_status; /* see enum sk_pacing */
> } __attribute__((preserve_access_index));
> @@ -234,8 +235,10 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
> #define MPTCP_SUBFLOWS_MAX	8
>
> struct mptcp_subflow_context {
> +	unsigned long avg_pacing_rate;
> 	__u32	backup : 1,
> 		stale : 1;
> +	__u8	stale_count;
> 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> } __attribute__((preserve_access_index));
>
> @@ -260,6 +263,7 @@ struct mptcp_sched_ops {
> struct mptcp_sock {
> 	struct inet_connection_sock	sk;
>
> +	__u64		snd_nxt;
> 	__u32		token;
> 	struct sock	*first;
> 	char		ca_name[TCP_CA_NAME_MAX];
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> new file mode 100644
> index 000000000000..1886e2f7aca4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023, SUSE. */
> +
> +#include <linux/bpf.h>
> +#include <limits.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct mptcp_burst_storage {
> +	int snd_burst;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct mptcp_burst_storage);
> +} mptcp_burst_map SEC(".maps");
> +
> +#define MPTCP_SEND_BURST_SIZE	65428
> +
> +struct subflow_send_info {
> +	__u8 subflow_id;
> +	__u64 linger_time;
> +};
> +
> +static inline __u64 div_u64_rem(__u64 dividend, __u32 divisor, __u32 *remainder)
> +{
> +	*remainder = dividend % divisor;
> +	return dividend / divisor;
> +}
> +
> +static inline __u64 div_u64(__u64 dividend, __u32 divisor)
> +{
> +	__u32 remainder;
> +
> +	return div_u64_rem(dividend, divisor, &remainder);
> +}

Since this is compiling to BPF rather than native code with 
architecture-specific optimizations, I think it's better to remove 
div_u64_rem() and keep div_u64() simple:

static inline __u64 div_u64(__u64 dividend, __u32 divisor)
{
      return dividend / divisor;
}

- Mat

> +
> +extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
> +extern void mptcp_set_timeout(struct sock *sk) __ksym;
> +extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
> +extern bool bpf_sk_stream_memory_free(const struct sock *sk) __ksym;
> +extern bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk) __ksym;
> +extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
> +
> +#define SSK_MODE_ACTIVE	0
> +#define SSK_MODE_BACKUP	1
> +#define SSK_MODE_MAX	2
> +
> +SEC("struct_ops/mptcp_sched_burst_init")
> +void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops/mptcp_sched_burst_release")
> +void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
> +{
> +	bpf_sk_storage_delete(&mptcp_burst_map, msk);
> +}
> +
> +void BPF_STRUCT_OPS(bpf_burst_data_init, struct mptcp_sock *msk,
> +		    struct mptcp_sched_data *data)
> +{
> +	mptcp_sched_data_set_contexts(msk, data);
> +}
> +
> +static int bpf_burst_get_send(struct mptcp_sock *msk,
> +			      const struct mptcp_sched_data *data)
> +{
> +	struct subflow_send_info send_info[SSK_MODE_MAX];
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	struct mptcp_burst_storage *ptr;
> +	__u32 pace, burst, wmem;
> +	__u64 linger_time;
> +	struct sock *ssk;
> +	int i;
> +
> +	/* pick the subflow with the lower wmem/wspace ratio */
> +	for (i = 0; i < SSK_MODE_MAX; ++i) {
> +		send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
> +		send_info[i].linger_time = -1;
> +	}
> +
> +	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		subflow = mptcp_subflow_ctx_by_pos(data, i);
> +		if (!subflow)
> +			break;
> +
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +		if (!mptcp_subflow_active(subflow))
> +			continue;
> +
> +		pace = subflow->avg_pacing_rate;
> +		if (!pace) {
> +			/* init pacing rate from socket */
> +			subflow->avg_pacing_rate = ssk->sk_pacing_rate;
> +			pace = subflow->avg_pacing_rate;
> +			if (!pace)
> +				continue;
> +		}
> +
> +		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
> +		if (linger_time < send_info[subflow->backup].linger_time) {
> +			send_info[subflow->backup].subflow_id = i;
> +			send_info[subflow->backup].linger_time = linger_time;
> +		}
> +	}
> +	mptcp_set_timeout(sk);
> +
> +	/* pick the best backup if no other subflow is active */
> +	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
> +		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
> +
> +	subflow = mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
> +	if (!subflow)
> +		return -1;
> +	ssk = mptcp_subflow_tcp_sock(subflow);
> +	if (!ssk || !bpf_sk_stream_memory_free(ssk))
> +		return -1;
> +
> +	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
> +	wmem = ssk->sk_wmem_queued;
> +	if (!burst)
> +		goto out;
> +
> +	subflow->avg_pacing_rate = div_u64((__u64)subflow->avg_pacing_rate * wmem +
> +					   ssk->sk_pacing_rate * burst,
> +					   burst + wmem);
> +	ptr = bpf_sk_storage_get(&mptcp_burst_map, msk, 0,
> +				 BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (ptr)
> +		ptr->snd_burst = burst;
> +
> +out:
> +	mptcp_subflow_set_scheduled(subflow, true);
> +	return 0;
> +}
> +
> +static int bpf_burst_get_retrans(struct mptcp_sock *msk,
> +				 const struct mptcp_sched_data *data)
> +{
> +	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
> +	struct mptcp_subflow_context *subflow;
> +	int min_stale_count = INT_MAX;
> +	struct sock *ssk;
> +
> +	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		subflow = mptcp_subflow_ctx_by_pos(data, i);
> +		if (!subflow)
> +			break;
> +
> +		if (!mptcp_subflow_active(subflow))
> +			continue;
> +
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +		/* still data outstanding at TCP level? skip this */
> +		if (!bpf_tcp_rtx_and_write_queues_empty(ssk)) {
> +			mptcp_pm_subflow_chk_stale(msk, ssk);
> +			min_stale_count = min(min_stale_count, subflow->stale_count);
> +			continue;
> +		}
> +
> +		if (subflow->backup) {
> +			if (backup == MPTCP_SUBFLOWS_MAX)
> +				backup = i;
> +			continue;
> +		}
> +
> +		if (pick == MPTCP_SUBFLOWS_MAX)
> +			pick = i;
> +	}
> +
> +	if (pick < MPTCP_SUBFLOWS_MAX) {
> +		subflow_id = pick;
> +		goto out;
> +	}
> +	subflow_id = min_stale_count > 1 ? backup : MPTCP_SUBFLOWS_MAX;
> +
> +out:
> +	subflow = mptcp_subflow_ctx_by_pos(data, subflow_id);
> +	if (!subflow)
> +		return -1;
> +	mptcp_subflow_set_scheduled(subflow, true);
> +	return 0;
> +}
> +
> +int BPF_STRUCT_OPS(bpf_burst_get_subflow, struct mptcp_sock *msk,
> +		   const struct mptcp_sched_data *data)
> +{
> +	if (data->reinject)
> +		return bpf_burst_get_retrans(msk, data);
> +	return bpf_burst_get_send(msk, data);
> +}
> +
> +SEC(".struct_ops")
> +struct mptcp_sched_ops burst = {
> +	.init		= (void *)mptcp_sched_burst_init,
> +	.release	= (void *)mptcp_sched_burst_release,
> +	.data_init	= (void *)bpf_burst_data_init,
> +	.get_subflow	= (void *)bpf_burst_get_subflow,
> +	.name		= "bpf_burst",
> +};
> -- 
> 2.35.3
>
>
>
