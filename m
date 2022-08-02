Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538A7F
	for <mptcp@lists.linux.dev>; Tue,  2 Aug 2022 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659479817; x=1691015817;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XCsTPnpTKoW+duZszx3zQSg+OHhT0zbLo009U3mVwMs=;
  b=niq+aLAX/oS5tSZRzLrhy6pimrYr1jZB7kjirABqVxe7wDAe3fkHIJY9
   5qz+rbNFYjQdSr9pd0Huf/QGE99T76V1VBNEvPgM8eYxZkoaAm1VFcbLU
   OBvFyBvxXSJRHvVE9u49BBp66PpUKBqhuu8MVdFXyDacROQsp/PvRhkGJ
   t/ttc6du5q5qyukCcr4NYB4R7VpaYa3DF1/NAf/vRMJKpXADD7RRMn/28
   ELPx7bhG82san5XvcXCANJtgI9BkMuEUUW3FVzJLw/RXUImqOhrbenI2/
   rFhjYb3aU9utTUKxNEKcoEqBEuYEdtENclwuK/LR6DtsEJVJb99e9uXQb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269303865"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="269303865"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:36:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="599448815"
Received: from dnrajurk-mobl.amr.corp.intel.com ([10.209.121.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:36:56 -0700
Date: Tue, 2 Aug 2022 15:36:55 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
cc: Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Andrii Nakryiko <andrii@kernel.org>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org, 
    Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
    John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
    Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCHv2 bpf-next] mptcp: Add struct mptcp_sock definition when
 CONFIG_MPTCP is disabled
In-Reply-To: <20220802163324.1873044-1-jolsa@kernel.org>
Message-ID: <341f1b39-24e1-3c80-41e0-a4ebac91297@linux.intel.com>
References: <20220802163324.1873044-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 2 Aug 2022, Jiri Olsa wrote:

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
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks Jiri, v2 looks good to merge in bpf-next:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> include/net/mptcp.h | 4 ++++
> 1 file changed, 4 insertions(+)
>
> v2 changes:
>  - moved the new empty struct declaration next to the inline
>    bpf_mptcp_sock_from_subflow function [Mat]
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index ac9cf7271d46..412479ebf5ad 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -291,4 +291,8 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
> static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk) { return NULL; }
> #endif
>
> +#if !IS_ENABLED(CONFIG_MPTCP)
> +struct mptcp_sock { };
> +#endif
> +
> #endif /* __NET_MPTCP_H */
> -- 
> 2.37.1
>
>

--
Mat Martineau
Intel
