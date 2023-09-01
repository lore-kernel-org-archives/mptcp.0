Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5EAD53
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 23:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3C9C433C8;
	Fri,  1 Sep 2023 23:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693610609;
	bh=UbpriOWeuTzr0q2H3myB85PGjtbKVlclFynqKdFr4Kk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lgg3vchUqbCEXxE1Y+e4O9tsX0wusB5O8x9ntL6fS80ssmcCHsKLccCzP8xYFl1g/
	 kKkI6YFAvR9vN8RqD9SNvkIFdCPdQyXLAT12ugHRgKTN/B5Bx2rnJRHvsxkftpD+LI
	 hk0sZKdeSbhDvizYpchFi7vjVZ9N9X0NS+FKppzSK7qubhbKCvNX3ohJ7bFkmSW0iE
	 VzKIkCM6JYwF03h4zgEI3QyckeC5Aaol2lWMr5dqHVUG3sjrHJsUxdef6kL22WePLx
	 S8HBqWj8KfHTYUcfkeIe4Q4Zob/zvCp1TL/z18ZOQgs7ajT6nUikNeO9ngwEOd2AvG
	 HVkLclgVPbwuQ==
Date: Fri, 1 Sep 2023 16:23:28 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 4/5] selftests/bpf: Add bpf_stale
 scheduler
In-Reply-To: <51abe0fba5f509bbabf7f400831c6a2a1a0413d1.1692344463.git.geliang.tang@suse.com>
Message-ID: <f79be156-e97f-abee-39c5-525515964c3e@kernel.org>
References: <cover.1692344463.git.geliang.tang@suse.com> <51abe0fba5f509bbabf7f400831c6a2a1a0413d1.1692344463.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 18 Aug 2023, Geliang Tang wrote:

> This patch implements the setting a subflow as stale/unstale in BPF MPTCP
> scheduler, named bpf_stale. The staled subflow id will be added into a
> map in sk_storage.
>
> Two helper mptcp_subflow_set_stale() and mptcp_subflow_clear_stale() are
> added.
>
> In this test, subflow 1 is set as stale in bpf_stale_data_init(). Each
> subflow is checked whether it's a stale one in bpf_stale_get_subflow() to
> select a unstale subflow to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
> .../selftests/bpf/progs/mptcp_bpf_stale.c     | 152 ++++++++++++++++++
> 2 files changed, 153 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index b687f91f2da8..33246629fa36 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -239,6 +239,7 @@ struct mptcp_subflow_context {
> 	unsigned long avg_pacing_rate;
> 	__u32	backup : 1;
> 	__u8	stale_count;
> +	__u32	subflow_id;
> 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> } __attribute__((preserve_access_index));
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
> new file mode 100644
> index 000000000000..08c857f79221
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023, SUSE. */
> +
> +#include <linux/bpf.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct mptcp_stale_storage {
> +	__u8 nr;
> +	__u32 ids[MPTCP_SUBFLOWS_MAX];
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct mptcp_stale_storage);
> +} mptcp_stale_map SEC(".maps");
> +
> +static void mptcp_subflow_set_stale(struct mptcp_stale_storage *storage,
> +				    __u32 subflow_id)
> +{
> +	if (!subflow_id)
> +		return;
> +
> +	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (storage->ids[i] == subflow_id)
> +			return;
> +	}
> +
> +	if (storage->nr < MPTCP_SUBFLOWS_MAX - 1)
> +		storage->ids[storage->nr++] = subflow_id;
> +}
> +
> +static void mptcp_subflow_clear_stale(struct mptcp_stale_storage *storage,
> +				      __u32 subflow_id)
> +{
> +	if (!subflow_id)
> +		return;
> +
> +	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (storage->ids[i] == subflow_id) {
> +			for (int j = i; j < MPTCP_SUBFLOWS_MAX - 1; j++) {
> +				if (!storage->ids[j + 1])
> +					break;
> +				storage->ids[j] = storage->ids[j + 1];
> +				storage->ids[j + 1] = 0;
> +			}
> +			storage->nr--;
> +			return;
> +		}
> +	}
> +}
> +
> +static bool mptcp_subflow_is_stale(struct mptcp_stale_storage *storage,
> +				   __u32 subflow_id)
> +{
> +	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (storage->ids[i] == subflow_id)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool mptcp_subflow_is_active(struct mptcp_sched_data *data,
> +				    __u32 subflow_id)
> +{
> +	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		struct mptcp_subflow_context *subflow;
> +
> +		subflow = mptcp_subflow_ctx_by_pos(data, i);
> +		if (!subflow)
> +			break;
> +		if (subflow->subflow_id == subflow_id)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +SEC("struct_ops/mptcp_sched_stale_init")
> +void BPF_PROG(mptcp_sched_stale_init, struct mptcp_sock *msk)
> +{
> +	struct mptcp_stale_storage *storage;
> +
> +	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0,
> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!storage)
> +		return;
> +
> +	storage->nr = 0;
> +}
> +
> +SEC("struct_ops/mptcp_sched_stale_release")
> +void BPF_PROG(mptcp_sched_stale_release, struct mptcp_sock *msk)
> +{
> +	bpf_sk_storage_delete(&mptcp_stale_map, msk);
> +}
> +
> +int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
> +		   struct mptcp_sched_data *data)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_stale_storage *storage;
> +	int nr = -1;
> +
> +	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0,
> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!storage)
> +		return -1;
> +
> +	mptcp_sched_data_set_contexts(msk, data);

Should this call be moved to sched.c, right before the calls to 
msk->sched->get_subflow() in the mptcp_sched_get functions?

It looks like every BPF scheduler example has to call this, so it would be 
more efficient to set up the data before calling the BPF functions.

> +
> +	/* Handle invalid subflow ids for subflows that have been closed */
> +	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (!mptcp_subflow_is_active(data, storage->ids[i]))
> +			mptcp_subflow_clear_stale(storage, storage->ids[i]);
> +	}
> +
> +	subflow = mptcp_subflow_ctx_by_pos(data, 1);
> +	if (subflow)
> +		mptcp_subflow_set_stale(storage, subflow->subflow_id);

Since this is always marking the subflow in position 1 as stale...

> +
> +	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		struct mptcp_subflow_context *subflow;
> +
> +		subflow = mptcp_subflow_ctx_by_pos(data, i);
> +		if (!subflow)
> +			break;
> +
> +		if (mptcp_subflow_is_stale(storage, subflow->subflow_id))

...and then looking up that subflow again, this scheduler is not doing 
anything with actual stale subflows. The other BPF schedulers are already 
exercising everything in the BPF infrastructure that is done here (with 
sk_storage, etc.).

If there's a way to check for real stuck/stale subflows, then I think it 
would be good to have a sample scheduler that does that. But for now, I 
don't think this code adds test coverage or helps demonstrate the BPF 
scheduler.



> +			continue;
> +
> +		nr = i;
> +	}
> +
> +	if (nr != -1) {
> +		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +SEC(".struct_ops")
> +struct mptcp_sched_ops stale = {
> +	.init		= (void *)mptcp_sched_stale_init,
> +	.release	= (void *)mptcp_sched_stale_release,
> +	.get_subflow	= (void *)bpf_stale_get_subflow,
> +	.name		= "bpf_stale",
> +};
> -- 
> 2.35.3
>
>
>
