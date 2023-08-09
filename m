Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C08182
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 00:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2B6C433C7;
	Wed,  9 Aug 2023 00:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691542620;
	bh=PUZhMOOnjq9qZIfRRmf3hAeXA0V17tpAIxIOKBAs8/A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YggDjnPkx+vt0oxyd7kAw8+7cIw9iRn06bsIPc4lR/u0XMZp5jnG4sz/HU+BWglmK
	 uMGVVB8PEetE9D68Sf4286wOtfDGGPM0MtM0AM3llSlCOm+FmlHlokxhSp5YnC7hax
	 2uKlYIZ/5NrBfVZDtfCVBN8Ng08v4s5RFSfNmPsyOE5kxPocODSLyELnCNYsm7iTha
	 LlIShLacNZMZEE8+sT2Zbomi7aehOQl9BU04GXL67sWCIzPzqyyhuGp6rvMXdyznvJ
	 k/uPdaUxV6m9EGY30NCcJoe99YF6GyVuSnMvDsqAXW0wQgC8pfJAqEvYo6VfWInSjp
	 etWJg7AH/cX1g==
Date: Tue, 8 Aug 2023 17:56:59 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/2] selftests/bpf: Add bpf_stale
 scheduler
In-Reply-To: <342e6005353b786a63b821787cb1edefee4ac530.1691045340.git.geliang.tang@suse.com>
Message-ID: <c8629518-6e96-b921-bb53-b3f8e082d058@kernel.org>
References: <cover.1691045340.git.geliang.tang@suse.com> <342e6005353b786a63b821787cb1edefee4ac530.1691045340.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 3 Aug 2023, Geliang Tang wrote:

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
> .../selftests/bpf/progs/mptcp_bpf_stale.c     | 161 ++++++++++++++++++
> 2 files changed, 162 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index 776c54948a4a..0a7c9fca6a07 100644
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
> index 000000000000..995c7448c394
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
> @@ -0,0 +1,161 @@
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

It looks like the sk_storage should be initialized here so it can be set 
up once, not every time the scheduler is called.

> +}
> +
> +SEC("struct_ops/mptcp_sched_stale_release")
> +void BPF_PROG(mptcp_sched_stale_release, struct mptcp_sock *msk)
> +{

Should this release the sk_storage?

> +}
> +
> +void BPF_STRUCT_OPS(bpf_stale_data_init, struct mptcp_sock *msk,
> +		    struct mptcp_sched_data *data)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_stale_storage *storage;
> +
> +	mptcp_sched_data_set_contexts(msk, data);
> +
> +	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0,
> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!storage)
> +		return;
> +
> +	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (!mptcp_subflow_is_active(data, storage->ids[i]))
> +			mptcp_subflow_clear_stale(storage, storage->ids[i]);
> +	}

Why is this loop here? Is it to handle invalid subflow ids for subflows 
that have been closed?


> +
> +	subflow = mptcp_subflow_ctx_by_pos(data, 0);
> +	if (subflow) {
> +		mptcp_subflow_set_stale(storage, subflow->subflow_id);
> +		mptcp_subflow_clear_stale(storage, subflow->subflow_id);

Why set and then clear?

> +	}
> +
> +	subflow = mptcp_subflow_ctx_by_pos(data, 1);
> +	if (subflow) {
> +		mptcp_subflow_set_stale(storage, subflow->subflow_id);
> +		mptcp_subflow_clear_stale(storage, subflow->subflow_id);
> +		mptcp_subflow_set_stale(storage, subflow->subflow_id);

Same question for set/clear/set

> +	}
> +}
> +
> +int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
> +		   const struct mptcp_sched_data *data)
> +{
> +	struct mptcp_stale_storage *storage;
> +	int nr = -1;
> +
> +	storage = bpf_sk_storage_get(&mptcp_stale_map, msk, 0,
> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!storage)
> +		return -1;
> +
> +	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		struct mptcp_subflow_context *subflow;
> +
> +		subflow = mptcp_subflow_ctx_by_pos(data, i);
> +		if (!subflow)
> +			break;
> +
> +		if (mptcp_subflow_is_stale(storage, subflow->subflow_id))
> +			continue;
> +
> +		nr = i;
> +	}
> +
> +	if (nr != -1)
> +		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
> +	return 0;

I missed this detail on a previous review: if no subflow is scheduled, it 
should return '1' to indicate an error.

> +}
> +
> +SEC(".struct_ops")
> +struct mptcp_sched_ops stale = {
> +	.init		= (void *)mptcp_sched_stale_init,
> +	.release	= (void *)mptcp_sched_stale_release,
> +	.data_init	= (void *)bpf_stale_data_init,
> +	.get_subflow	= (void *)bpf_stale_get_subflow,
> +	.name		= "bpf_stale",
> +};
> -- 
> 2.35.3
>
>
>
