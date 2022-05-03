Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A06160
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 00:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651537054; x=1683073054;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YTjtV3qe+ozLfoP4VFyrnW6eH5ysyXecbPLdTsMBltk=;
  b=bTuVo/NUhSnLrpX+br5uNLnh0J9o8jvHjHXnldl3WheFSEP7T9VPYYR2
   HoVXoLXGj5I7+Mq9avBpOIAzAOOfRHKpukAoYqXu5SBR7p+Ko9I7iZYww
   +jvUHKVBcEHgOgAAVSJLNUPowcHKQfcCqy/TvPoaLwu9L0x8pl16K59cK
   W1quA5B887Zr11rQ7CCEH83P8SVwCoxbVjRrlA5K5euwbuHgu3rJ0daed
   vrPYZWvEjHOhwwZM4Yi2PwJuihxkEPg2X3LjDNfD54jN7sxQ8ahBRFDdf
   4RsyjePLZ2twa/2ehF7WrzkfGwIvsDjMsfdCvyLbl+LEZKtvUVR21nMIZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353803298"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="353803298"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 17:17:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="536113909"
Received: from raltenor-mobl.amr.corp.intel.com ([10.212.200.195])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 17:17:33 -0700
Date: Mon, 2 May 2022 17:17:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v10 1/3] mptcp: add subflows array in sched
 data
In-Reply-To: <d944e0f6c9549f004d68083dd5ad2879b77126a0.1651413062.git.geliang.tang@suse.com>
Message-ID: <cc1c9fae-0d1-52b0-8520-737b9fab6de0@linux.intel.com>
References: <cover.1651413062.git.geliang.tang@suse.com> <d944e0f6c9549f004d68083dd5ad2879b77126a0.1651413062.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sun, 1 May 2022, Geliang Tang wrote:

> This patch adds a subflow pointers array in struct mptcp_sched_data. Set
> the array before invoking get_subflow(), then get it in get_subflow() in
> the BPF contexts.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h                             | 3 +++
> net/mptcp/sched.c                               | 7 +++++++
> tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 3 +++
> 3 files changed, 13 insertions(+)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index bea7608d72d3..1a48e31f3ac7 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -96,10 +96,13 @@ struct mptcp_out_options {
> };
>
> #define MPTCP_SCHED_NAME_MAX	16
> +#define MPTCP_SUBFLOWS_MAX	8
>
> struct mptcp_sched_data {
> 	struct sock	*sock;
> 	bool		call_again;
> +	u8		subflows;
> +	struct mptcp_subflow_context *array[MPTCP_SUBFLOWS_MAX];

I suggest a more descriptive name here: 'contexts' instead of 'array'?

> };
>
> struct mptcp_sched_ops {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 7a5654132ed3..1efbcfe80fe7 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -93,9 +93,16 @@ void mptcp_release_sched(struct mptcp_sock *msk)
> static int mptcp_sched_data_init(struct mptcp_sock *msk,
> 				 struct mptcp_sched_data *data)
> {
> +	struct mptcp_subflow_context *subflow;
> +	int i = 0;
> +
> 	data->sock = NULL;
> 	data->call_again = 0;
>
> +	mptcp_for_each_subflow(msk, subflow)
> +		data->array[i++] = subflow;

Two things here:

The unused array elements should be set to NULL.

There should be strict checking of the MPTCP_SUBFLOWS_MAX array size 
limit, and if the length of conn_list is larger then pr_warn_once() about 
that unexpected condition.

- Mat

> +	data->subflows = i;
> +
> 	return 0;
> }
>
> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> index e863954de701..1f991ff2e325 100644
> --- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> @@ -7,10 +7,13 @@
> #include "bpf_tcp_helpers.h"
>
> #define MPTCP_SCHED_NAME_MAX	16
> +#define MPTCP_SUBFLOWS_MAX	8
>
> struct mptcp_sched_data {
> 	struct sock	*sock;
> 	bool		call_again;
> +	__u8		subflows;
> +	struct mptcp_subflow_context *array[MPTCP_SUBFLOWS_MAX];
> };
>
> struct mptcp_sched_ops {
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
