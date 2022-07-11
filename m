Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB92F33
	for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 21:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657574478; x=1689110478;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jrR4sgIVwu8asDoM1btJi7FV1UTp9Jqz+B7cQdtvtlA=;
  b=k8arTbX14/kSR2oQ2mJhV1ncAqS4b0XeYik9VSHcz8yvOcdJvUsXw/VN
   mkP6eBoO1I13JjPdHNP31Gzu7i1WuHlUvN6JZab4+8BINlGW1RtRjhpOu
   wkJigtr5WuYOMwlAJJnK2l4wK8z1IiCvq/DlZ9vUlIKXH7v2BikECFNxs
   SEJOzM6CQErRgBw4NVSFAHBHr+0tlWRparo0dbSPCqEIredQyadlA7q8+
   GoNH2nL1n25HLpo2kdh84FvwqUm/KLJhHw2w6PIeA0O16/Qn0NUybJotT
   s/dTN+bt6hg0Jl2zmnSKbkHFviD7HFdyWCPGnvDQo5VQ49zYoNiMls6pS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285514908"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="285514908"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:21:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="592400481"
Received: from huiyaoch-mobl.amr.corp.intel.com ([10.209.36.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:21:17 -0700
Date: Mon, 11 Jul 2022 14:21:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
cc: Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Andrii Nakryiko <andrii@kernel.org>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>, netdev@vger.kernel.org, 
    bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
    Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
    John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
    Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH bpf-next] mptcp: Add struct mptcp_sock definition when
 CONFIG_MPTCP is disabled
In-Reply-To: <20220711130731.3231188-1-jolsa@kernel.org>
Message-ID: <6d3b3bf-2e29-d695-87d7-c23497acc81@linux.intel.com>
References: <20220711130731.3231188-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 11 Jul 2022, Jiri Olsa wrote:

> The btf_sock_ids array needs struct mptcp_sock BTF ID for
> the bpf_skc_to_mptcp_sock helper.
>
> When CONFIG_MPTCP is disabled, the 'struct mptcp_sock' is not
> defined and resolve_btfids will complain with:
>
>  BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol mptcp_sock
>
> Adding empty difinition for struct mptcp_sock when CONFIG_MPTCP
> is disabled.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> include/net/mptcp.h | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index ac9cf7271d46..25741a52c666 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -59,6 +59,10 @@ struct mptcp_addr_info {
> 	};
> };
>
> +#if !IS_ENABLED(CONFIG_MPTCP)
> +struct mptcp_sock { };
> +#endif

The only use of struct mptcp_sock I see with !CONFIG_MPTCP is from this 
stub at the end of mptcp.h:

static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk) { return NULL; }

It's normally defined in net/mptcp/protocol.h for the MPTCP subsystem 
code.

The conditional could be added on the line before the stub to make it 
clear that the empty struct is associated with that inline stub.

> +
> struct mptcp_out_options {
> #if IS_ENABLED(CONFIG_MPTCP)
> 	u16 suboptions;
> -- 
> 2.35.3
>
>

--
Mat Martineau
Intel
