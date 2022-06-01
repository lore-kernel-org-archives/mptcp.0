Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263A7E
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 01:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654045894; x=1685581894;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+5tfJLT9cDw/p/OvzwqY6EdgjQHvghucjE8x3QHL+ro=;
  b=f5R5WpePj+aD4AqOrM5JXg8vOlSCRvjeLsNOolKeVJuN+iMY8dun9xB+
   h38ORXo7TRe1lpJdh6ls7+dtnm4nT3cgF55zMfd9pvnS9OyJWBCx1m8/q
   RU+khriIZ8yTzlIpnUuB5RCg0LdM3Rqf+pB2auIUxuOwSsxR0itRtHYS4
   OfZTDNLHimpuvZDEUAc9v6xV4IVGyNSv6JahBCIXRYVjoy3Hf24BPMW64
   Ig+QW6QBeYhmsSyrP5TXZHt64bBRW3T+Kc4q7zrK59Whixuqpp+/lPplB
   PSiWGmkLJpecOMy7vP8KRP50YIKHhC5LZR7/nX2jpi2BcLDof+X1AUHc2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="263070507"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="263070507"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 18:11:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="720556364"
Received: from sbeaupre-mobl1.amr.corp.intel.com ([10.209.105.200])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 18:11:32 -0700
Date: Tue, 31 May 2022 18:11:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 07/10] selftests/bpf: add bpf_bkup
 scheduler
In-Reply-To: <fb54b554c1897f5205d1e146d0a7d1d25f7a8a4a.1653987929.git.geliang.tang@suse.com>
Message-ID: <a6b9795-7b6-2cb9-f82e-e643bbb79e51@linux.intel.com>
References: <cover.1653987929.git.geliang.tang@suse.com> <fb54b554c1897f5205d1e146d0a7d1d25f7a8a4a.1653987929.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 31 May 2022, Geliang Tang wrote:

> This patch implements the backup flag test scheduler, named bpf_bkup,
> which picks the first non-backup subflow to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  2 +
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++++++++++++
> 2 files changed, 45 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index 870deb5cf5ed..6fa496a65bef 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -234,6 +234,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
> #define MPTCP_SUBFLOWS_MAX	8
>
> struct mptcp_subflow_context {
> +	__u32	padding : 12,
> +		backup : 1;

Is the padding required? It looks like the BTF code might know how to 
handle bitfield members.

- Mat

> 	bool	scheduled;
> } __attribute__((preserve_access_index));
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
> new file mode 100644
> index 000000000000..ad2b2b4de8a5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022, SUSE. */
> +
> +#include <linux/bpf.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("struct_ops/mptcp_sched_bkup_init")
> +void BPF_PROG(mptcp_sched_bkup_init, const struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops/mptcp_sched_bkup_release")
> +void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
> +{
> +}
> +
> +void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
> +		    struct mptcp_sched_data *data)
> +{
> +	int nr = 0;
> +
> +	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (!data->contexts[i])
> +			break;
> +
> +		if (!data->contexts[i]->backup) {
> +			nr = i;
> +			break;
> +		}
> +	}
> +
> +	data->contexts[nr]->scheduled = 1;
> +}
> +
> +SEC(".struct_ops")
> +struct mptcp_sched_ops bkup = {
> +	.init		= (void *)mptcp_sched_bkup_init,
> +	.release	= (void *)mptcp_sched_bkup_release,
> +	.get_subflow	= (void *)bpf_bkup_get_subflow,
> +	.name		= "bpf_bkup",
> +};
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
