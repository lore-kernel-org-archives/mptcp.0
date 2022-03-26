Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DFC7E
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 00:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254183; x=1679790183;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CxWwsPvFOMsFYhiTjJs7HExanKrZFR+lUhWk9on4ZHQ=;
  b=Dzi9viyM6IL3crMKLjLjA9tirbzhlXrSEDd9C2YlD6dbRaWAPwWYNSG4
   5KMvhex1lFHSblW707Qd/nvfIcMzVk3SuDPfNDQgWJSvaNdXixZWfGdkY
   sIkbhBwYO3G/ddq2RGMr1P49IrQzvR6kRtIGv+4LG6qiVsXqyO7qV808n
   6SNwpJ2LLE9YEWB5BMdI8TKI3sIe597oz8gcX+DU+CdPGltVsuzThhmC5
   U8kwyD401S5vzzuGlToRBTyS36acji9Z9boSPF5UJUZ6hQm9rAU2HK6wV
   9/gReWA/omvJLXlUGJws7sw1iYRALeJ8yMq+ENxz+ZeBl3fyF6bcknik5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="319446425"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="319446425"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:23:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="545278890"
Received: from ivbeskor-mobl1.amr.corp.intel.com ([10.209.23.71])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:23:03 -0700
Date: Fri, 25 Mar 2022 17:23:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 7/8] selftests: bpf: add bpf_first
 scheduler
In-Reply-To: <35c97d89297abe349b746582f5db9319c171a787.1648223504.git.geliang.tang@suse.com>
Message-ID: <4ce8289-594-6e5f-8a8f-4e1fe0584a7@linux.intel.com>
References: <cover.1648223504.git.geliang.tang@suse.com> <35c97d89297abe349b746582f5db9319c171a787.1648223504.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 26 Mar 2022, Geliang Tang wrote:

> This patch implemented the simplest MPTCP scheduler, named bpf_first,
> which always picks the first subflow to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/bpf_tcp_helpers.h | 12 ++++++++
> tools/testing/selftests/bpf/progs/bpf_first.c | 30 +++++++++++++++++++
> 2 files changed, 42 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index f92357597e63..5bb21b24231f 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -197,6 +197,18 @@ struct tcp_congestion_ops {
> 	void *owner;
> };
>
> +#define MPTCP_SCHED_NAME_MAX 16
> +
> +struct mptcp_sched_ops {
> +	char name[MPTCP_SCHED_NAME_MAX];
> +
> +	void (*init)(struct mptcp_sock *msk);
> +	void (*release)(struct mptcp_sock *msk);
> +
> +	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
> +	void *owner;
> +};
> +
> #define min(a, b) ((a) < (b) ? (a) : (b))
> #define max(a, b) ((a) > (b) ? (a) : (b))
> #define min_not_zero(x, y) ({			\
> diff --git a/tools/testing/selftests/bpf/progs/bpf_first.c b/tools/testing/selftests/bpf/progs/bpf_first.c
> new file mode 100644
> index 000000000000..3ae5c1eab5f5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_first.c

I suggest naming this mptcp_bpf_first.c instead, to clarify that it's 
specific to MPTCP.

- Mat

> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2022, SUSE. */
> +
> +#include <linux/bpf.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("struct_ops/mptcp_sched_first_init")
> +void BPF_PROG(mptcp_sched_first_init, struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops/mptcp_sched_first_release")
> +void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
> +{
> +}
> +
> +struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk)
> +{
> +	return msk->first;
> +}
> +
> +SEC(".struct_ops")
> +struct mptcp_sched_ops first = {
> +	.init		= (void *)mptcp_sched_first_init,
> +	.release	= (void *)mptcp_sched_first_release,
> +	.get_subflow	= (void *)bpf_first_get_subflow,
> +	.name		= "bpf_first",
> +};
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
