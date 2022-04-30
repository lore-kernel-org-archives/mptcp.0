Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F64681
	for <mptcp@lists.linux.dev>; Sat, 30 Apr 2022 00:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651278493; x=1682814493;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KweQ0AYmYRQgyhYl6zfc8vormSESCkGHPr7Yu4/5LSg=;
  b=gAHjOXiz5RryPHHIMIJon0nAEgKR9WTapCwrmbNKVjbZvf94ERbGk8/O
   HbFPwQrkbwgPXtpKQrOwKUnJNUdy6KjBU0SrJSYk9FdikK1t0bi3E4BNc
   vvvqMnX2VzDgXi1R8V74ajqwekG5AAYCxI1lRVKHIrq/ucstyikIBCywn
   DiTivaf63rXFBPOSv7yyQEL8AlYazP2F51/k4DSP6tBSVfpYJ3u3IQK4O
   BxB4txrWB91hl5nzTpuhTpwn3xz+7pOkMW4rUF5V700SsqpV6HjRjokQF
   bibanBErhPyQlJxfXHQnb2eesjeT+7D/VfgEBHiwwVBztGks5kLOl4eeb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246722807"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="246722807"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:28:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="685725588"
Received: from mdbellow-mobl.amr.corp.intel.com ([10.209.122.4])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:28:12 -0700
Date: Fri, 29 Apr 2022 17:28:12 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 2/3] selftests: bpf: add bpf_rr scheduler
In-Reply-To: <1d2ecaada853df447dcfa6c8fabcf7bec5576278.1651243739.git.geliang.tang@suse.com>
Message-ID: <2fb06c54-39ca-68a6-70a2-ca6b41d4e9fb@linux.intel.com>
References: <cover.1651243739.git.geliang.tang@suse.com> <1d2ecaada853df447dcfa6c8fabcf7bec5576278.1651243739.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 29 Apr 2022, Geliang Tang wrote:

> This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
> which always picks the next available subflow to send data. If no such
> next subflow available, picks the first one.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/bpf/bpf_mptcp_helpers.h |  5 ++
> .../selftests/bpf/progs/mptcp_bpf_rr.c        | 49 +++++++++++++++++++
> 2 files changed, 54 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> index 1fe3d0a97429..8ce5b1603962 100644
> --- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> @@ -37,4 +37,9 @@ struct mptcp_sock {
> 	char		ca_name[TCP_CA_NAME_MAX];
> } __attribute__((preserve_access_index));
>
> +struct mptcp_subflow_context {
> +	__u32	token;
> +	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> +} __attribute__((preserve_access_index));
> +
> #endif
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> new file mode 100644
> index 000000000000..2f31de4cfc84
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022, SUSE. */
> +
> +#include <linux/bpf.h>
> +#include <linux/stddef.h>
> +#include <linux/tcp.h>
> +#include "bpf_mptcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("struct_ops/mptcp_sched_rr_init")
> +void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops/mptcp_sched_rr_release")
> +void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
> +{
> +}
> +
> +void BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
> +		    bool reinject, struct mptcp_sched_data *data)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *ssk = msk->first;
> +
> +	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (i >= data->subflows)
> +			break;

Is the extra 'if' statement required by the BPF verifier? If this is not 
allowed:

for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++)

is this?

for (int i = 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++)

> +
> +		subflow = data->array[i];
> +		if (subflow->tcp_sock != msk->last_snd) {
> +			ssk = subflow->tcp_sock;
> +			break;
> +		}
> +	}
> +
> +	msk->last_snd = ssk;
> +	data->sock = ssk;
> +	data->call_again = 0;
> +}
> +
> +SEC(".struct_ops")
> +struct mptcp_sched_ops rr = {
> +	.init		= (void *)mptcp_sched_rr_init,
> +	.release	= (void *)mptcp_sched_rr_release,
> +	.get_subflow	= (void *)bpf_rr_get_subflow,
> +	.name		= "bpf_rr",
> +};
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
