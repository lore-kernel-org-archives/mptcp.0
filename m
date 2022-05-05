Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BB363
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 00:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651710334; x=1683246334;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=73T/MVbm8MdtGSkmyvtsSzBANH9owUS3zAsCbXbkMTM=;
  b=Fm1P0GIU2ZrEYcgkuvU9VoWAr8BPDIWBjqZWnddImjhf4kpr4lEUsdXw
   nLgewXyiENGV5yTV3WL/gFhY++FR1uh462iQYm06908AoFCXzN2UUloi1
   XCH/xNqxnpN/nXoJKdFNrxZS40J95E5S9WK0tCXsGhAyqi4xYchNnr/Zv
   3VQaSaMr/xuARH8mBjhPd7oZAE4S4/gAWjqhZjqT76MjPOhSOshJre1BU
   eCWhLwBfi1jc7BKo5mG9Gm/z1S6iYDkhBjlNX179IaAb3M9Wh/Iy9E0VB
   jEJlzdzgsvvBCHmATyZbykEP8ASJUEp3IaqxzBDfxISS2JQDhDShrc8+f
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354377375"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="354377375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 17:25:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="708704145"
Received: from jsbradle-mobl1.amr.corp.intel.com ([10.212.185.245])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 17:25:28 -0700
Date: Wed, 4 May 2022 17:25:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 2/3] selftests: bpf: add bpf_rr
 scheduler
In-Reply-To: <763b63514d2829f434e89521fe9a61cf38e0bf38.1651543362.git.geliang.tang@suse.com>
Message-ID: <8e2f5b5-51b9-d79d-c412-8a99e48a7e0@linux.intel.com>
References: <cover.1651543362.git.geliang.tang@suse.com> <763b63514d2829f434e89521fe9a61cf38e0bf38.1651543362.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 3 May 2022, Geliang Tang wrote:

> This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
> which always picks the next available subflow to send data. If no such
> next subflow available, picks the first one.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/bpf/bpf_mptcp_helpers.h |  6 +++
> .../selftests/bpf/progs/mptcp_bpf_rr.c        | 48 +++++++++++++++++++
> 2 files changed, 54 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> index 7ecd0b14666a..2d5109f459b4 100644
> --- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> @@ -29,10 +29,16 @@ struct mptcp_sched_ops {
> struct mptcp_sock {
> 	struct inet_connection_sock	sk;
>
> +	struct sock	*last_snd;
> 	__u32		token;
> 	struct sock	*first;
> 	struct mptcp_sched_ops *sched;
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
> index 000000000000..ab0bb2a38891
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> @@ -0,0 +1,48 @@
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
> +void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops/mptcp_sched_rr_release")
> +void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
> +{
> +}
> +
> +void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
> +		    bool reinject, struct mptcp_sched_data *data)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *ssk = msk->first;

Hi Geliang -

I suggest initializing this from data->contexts[0] to make it more obvious 
what is happening in the single-subflow case (or if last_ssk isn't found).

Now that we pass in contexts[] every time, is access to msk->first still 
needed?

> +
> +	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +		subflow = data->contexts[i];
> +		if (!subflow)
> +			break;
> +
> +		if (subflow->tcp_sock != msk->last_snd) {
> +			ssk = subflow->tcp_sock;
> +			break;

This will only alternate between the first two subflows in the list.

last_ssk could be any one of the values in contexts[], and round-robin 
should cycle through all the subflows (including wrapping around).

- Mat

> +		}
> +	}
> +
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
