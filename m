Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2179FF
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 17:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26365C433C7;
	Wed,  2 Aug 2023 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690996107;
	bh=xPcSw4Xui3tbDJE6SoSCF6bOLItWV4pdz7CWlrTXUWA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VdXRa/Fo4r3TPmbLe9KeMVY3RxyHw5SqC9vgEhiSpE5vj4rokXMyxDsh72hQJHc0j
	 WOxhlpRCMu6aJlK+Bauh0zV5YA/Upz5UJ77P0YEEKJ4PIkv4AouZsch6Q58tS0aXdl
	 hPkydGh93lnDTizKSE46ZqtbQrqFav7t0lroSScnL8XiM292guZNDzCl2HxOBizUaO
	 gUsbIIRd/JH7mxefInTFECjBk4lvEmmp+52vo+1NnH/LVAUhQPy2McZs4hke8Q3JIx
	 u9yViFo+sEZZnUzJ5v/qhe7PrC3cbszwaJYPCo+QHu7tY/3xAd30q1UHDhEBnKQlSj
	 AcZzN8AyNn6uQ==
Date: Wed, 2 Aug 2023 10:08:26 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/3] selftests/bpf: Add bpf_stale scheduler
In-Reply-To: <61900b09a590bdfce5f744e3ee87283e087553c0.1690952908.git.geliang.tang@suse.com>
Message-ID: <d59c5431-69bc-d68e-6ad8-6a55f6d6f15e@kernel.org>
References: <cover.1690952908.git.geliang.tang@suse.com> <61900b09a590bdfce5f744e3ee87283e087553c0.1690952908.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 2 Aug 2023, Geliang Tang wrote:

> This patch implements the setting a subflow as stale/unstale in BPF MPTCP
> scheduler, named bpf_stale. The staled subflow will be added into a stale
> map in sk_storage. Two helper mptcp_subflow_set_stale() and
> mptcp_subflow_unstale() are added. The subflow will be set as stale in
> bpf_stale_data_init() and will be checked in bpf_stale_get_subflow().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../selftests/bpf/progs/mptcp_bpf_stale.c     | 155 ++++++++++++++++++
> 1 file changed, 155 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
> new file mode 100644
> index 000000000000..44010ca83af3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
> @@ -0,0 +1,155 @@
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
> +	struct mptcp_subflow_context *stale[MPTCP_SUBFLOWS_MAX];

Hi Geliang -

How about storing an array of u32 subflow_id values instead? That way 
there's no chance we have old/invalid pointers stored when subflows are 
removed.

I realize we're only comparing against these subflow pointers and not 
dereferencing them, but scheduler developers will be looking at these test 
programs as examples and the subflow_id would be a better fit as example 
code.

Thanks,
Mat

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
> +				    struct mptcp_subflow_context *subflow)
> +{
> +	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (storage->stale[i] == subflow)
> +			return;
> +	}
> +
> +	if (storage->nr < MPTCP_SUBFLOWS_MAX - 1)
> +		storage->stale[storage->nr++] = subflow;
> +}
> +
> +static void mptcp_subflow_unstale(struct mptcp_stale_storage *storage,
> +				  struct mptcp_subflow_context *subflow)
> +{
> +	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (storage->stale[i] == subflow) {
> +			for (int j = i; j < MPTCP_SUBFLOWS_MAX - 1; j++) {
> +				if (!storage->stale[j + 1])
> +					break;
> +				storage->stale[j] = storage->stale[j + 1];
> +				storage->stale[j + 1] = NULL;
> +			}
> +			storage->nr--;
> +			return;
> +		}
> +	}
> +}
> +
> +static bool mptcp_subflow_is_stale(struct mptcp_stale_storage *storage,
> +				   struct mptcp_subflow_context *subflow)
> +{
> +	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (storage->stale[i] == subflow)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool mptcp_subflow_is_active(struct mptcp_sched_data *data,
> +				    struct mptcp_subflow_context *stale)
> +{
> +	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		struct mptcp_subflow_context *subflow;
> +
> +		subflow = mptcp_subflow_ctx_by_pos(data, i);
> +		if (!subflow)
> +			break;
> +		if (subflow == stale)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +SEC("struct_ops/mptcp_sched_stale_init")
> +void BPF_PROG(mptcp_sched_stale_init, struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops/mptcp_sched_stale_release")
> +void BPF_PROG(mptcp_sched_stale_release, struct mptcp_sock *msk)
> +{
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
> +		if (!mptcp_subflow_is_active(data, storage->stale[i]))
> +			mptcp_subflow_unstale(storage, storage->stale[i]);
> +	}
> +
> +	subflow = mptcp_subflow_ctx_by_pos(data, 0);
> +	if (subflow) {
> +		mptcp_subflow_set_stale(storage, subflow);
> +		mptcp_subflow_unstale(storage, subflow);
> +	}
> +
> +	subflow = mptcp_subflow_ctx_by_pos(data, 1);
> +	if (subflow) {
> +		mptcp_subflow_set_stale(storage, subflow);
> +		mptcp_subflow_unstale(storage, subflow);
> +		mptcp_subflow_set_stale(storage, subflow);
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
> +		if (mptcp_subflow_is_stale(storage, subflow))
> +			continue;
> +
> +		nr = i;
> +	}
> +
> +	if (nr != -1)
> +		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
> +	return 0;
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
