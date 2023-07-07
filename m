Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC3168BC
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 17:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2808FC433C8;
	Fri,  7 Jul 2023 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688752173;
	bh=oq2AFnusiG23Ni7oBKrit1qfH9mdGPz9u8Rg3JWriR0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=H4yk3cT5sAyfq8LpjuvrfPItLYpzHVeC780LqsBjdo85LZr8zrjEgIWyVawsLRtrn
	 i4yOtx2XfH93EZ+Ofrz3kM5NYkCeDYleKofCsOMLKRy+ZFj3GqiSR6vfWBsybpMxh8
	 aoVBm+OF3Cccd29HwG95Z27pfYrU7dYaS84gJ0oYzvh0/lJhjZ8UM/Xnv7O9bShbaR
	 0z0KfBHLCXvmlFQSSj1TAfcsWxGBeqdbyibejwBz1dmmT8lEQveifImXVeNoi5Auqd
	 yGpv8uccw1A3l3PWbOiWUU9md+2PZXOYtcYTEBWDALkqSNui0BRMIsD4GLfkLsqCp1
	 epOD8/dCWin2A==
Date: Fri, 7 Jul 2023 10:49:32 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 06/10] selftests/bpf: Add bpf_stale
 scheduler
In-Reply-To: <e6aff4b48202fb575062d13a5a6efe6c1da5bfc3.1687829823.git.geliang.tang@suse.com>
Message-ID: <152c104c-1383-aa8b-6cf1-ea912c7becf8@kernel.org>
References: <cover.1687829823.git.geliang.tang@suse.com> <e6aff4b48202fb575062d13a5a6efe6c1da5bfc3.1687829823.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 27 Jun 2023, Geliang Tang wrote:

> This patch implements the setting of stale flag in BPF MPTCP scheduler,
> named bpf_stale. The stale flag will be set in bpf_stale_data_init() and
> will be checked in bpf_stale_get_subflow().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
> .../selftests/bpf/progs/mptcp_bpf_stale.c     | 65 +++++++++++++++++++
> 2 files changed, 67 insertions(+), 1 deletion(-)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index 945dd46c98c0..c749940c9103 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -234,7 +234,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
> #define MPTCP_SUBFLOWS_MAX	8
>
> struct mptcp_subflow_context {
> -	__u32	backup : 1;
> +	__u32	backup : 1,
> +		stale : 1;
> 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> } __attribute__((preserve_access_index));
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
> new file mode 100644
> index 000000000000..8ef0c71a6b37
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023, SUSE. */
> +
> +#include <linux/bpf.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +static void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
> +				    int stale)
> +{
> +	subflow->stale = stale;
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
> +
> +	mptcp_sched_data_set_contexts(msk, data);
> +	subflow = mptcp_subflow_ctx_by_pos(data, 1);
> +	if (subflow)
> +		mptcp_subflow_set_stale(subflow, 1);
> +}
> +
> +int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
> +		   const struct mptcp_sched_data *data)
> +{
> +	int nr = 0;
> +
> +	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
> +		struct mptcp_subflow_context *subflow;
> +
> +		subflow = mptcp_subflow_ctx_by_pos(data, i);
> +		if (!subflow)
> +			break;
> +
> +		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, stale))
> +			break;

With these two breaks, nr could remain 0 in an error case and maybe cause 
the test to incorrectly pass. Maybe better to initialiaze nr to -1 and 
check for that error case before calling mptcp_subflow_set_scheduled 
below?

- Mat

> +
> +		nr = i;
> +	}
> +
> +	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
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
