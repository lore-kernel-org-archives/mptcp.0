Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60BB2C82
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 20:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642797896; x=1674333896;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3pkJrpiYFusXoDTrhJ/CUiPlq5DIDo4wnLNlUR3WS/Y=;
  b=WgYH3Rk3wlaskeJTyMudQ007OmBt7FBo3Lz+nSlLp1Hcx/IUUBjVDoEg
   xqhh68CJv4I35G1F5zWkpbpetsUL2PtUI3aSkghsYbK+g/pRrtITzyL0b
   7ld06EhjtbREK5tBoFOxTdc8CmmloKpKZMl7ZV9L0fefZCdnePhf84j9j
   rWfzSIBHGDSJkXpwe4sRx6it98RVugY2dALVWm1kNsE56xUSxPMed9wf0
   B5/JD8JiXCCeJVfdy52dkghcXzN0h8w74dvlAegzmaAgx72zf+y6u/Zq3
   M/ut7Jnka7MkmwHj2JKC8BGeTc5BZR08moklIQLqk+BIBy4nPbhXth/Lf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="270166543"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="270166543"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 12:44:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="579725848"
Received: from hma4-mobl2.amr.corp.intel.com ([10.212.239.251])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 12:44:56 -0800
Date: Fri, 21 Jan 2022 12:44:55 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
    netdev@vger.kernel.org, mptcp@lists.linux.dev, 
    linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mptcp: Use struct_group() to avoid cross-field
 memset()
In-Reply-To: <20220121073935.1154263-1-keescook@chromium.org>
Message-ID: <73486c93-8ebb-2391-dc50-a2b2cb38743@linux.intel.com>
References: <20220121073935.1154263-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 20 Jan 2022, Kees Cook wrote:

> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
>
> Use struct_group() to capture the fields to be reset, so that memset()
> can be appropriately bounds-checked by the compiler.
>
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: mptcp@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> net/mptcp/protocol.h | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>

Thanks Kees, looks good to me. I checked around for other MPTCP structs 
that would need similar attention and didn't see any.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0e6b42c76ea0..85317ce38e3f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -408,7 +408,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> struct mptcp_subflow_context {
> 	struct	list_head node;/* conn_list of subflows */
>
> -	char	reset_start[0];
> +	struct_group(reset,
>
> 	unsigned long avg_pacing_rate; /* protected by msk socket lock */
> 	u64	local_key;
> @@ -458,7 +458,7 @@ struct mptcp_subflow_context {
>
> 	long	delegated_status;
>
> -	char	reset_end[0];
> +	);
>
> 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
>
> @@ -494,7 +494,7 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> static inline void
> mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
> {
> -	memset(subflow->reset_start, 0, subflow->reset_end - subflow->reset_start);
> +	memset(&subflow->reset, 0, sizeof(subflow->reset));
> 	subflow->request_mptcp = 1;
> }
>
> -- 
> 2.30.2
>
>

--
Mat Martineau
Intel
