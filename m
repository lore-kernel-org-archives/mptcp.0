Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8B7F
	for <mptcp@lists.linux.dev>; Mon, 17 Oct 2022 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666045138; x=1697581138;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yKvznASV/EC5dJsakPJiF9uGg5shB76pjl6QnnOI1Qg=;
  b=Y33PeIUCSCLZiCxd+Mpa7ka7C+5qyHZpPCOCilE3kPqYPm8XpMWnnIj8
   aD9PXWHLnSHN0xeSglJ2WPfTn8baplZx/HxezWTx2EXdNI9HSYteNsRwa
   /k2Ke2rmO2i/DlHr5oHQX59tayzRFO5OpaEY53DbeT+I5oqh2K0+P11iE
   jbAlj/dGsilIml5SUmrmS9aZ7JuqB9t1hd7UfAhM+4VwhaZZ2B4KIuv0Z
   +1obp7xQfRMTHlrw/fJv+a7cMXFCJuoUPj++mAjRoDefvz55vOpGkhtIv
   iVZweb84nDs8M8U5Nc8kcGEz3YeYBIyZniIQkxC4uM0QeUQa59ZpYKnza
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="305918009"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="305918009"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 15:18:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="579534428"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="579534428"
Received: from ggallowa-mobl.amr.corp.intel.com ([10.255.230.247])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 15:18:55 -0700
Date: Mon, 17 Oct 2022 15:18:55 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Shaomin Deng <dengshaomin@cdjrlc.com>
cc: terrelln@fb.com, Matthieu Baerts <matthieu.baerts@tessares.net>, 
    David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH] lib: zstd: Fix double word in comments
In-Reply-To: <20221017143340.11622-1-dengshaomin@cdjrlc.com>
Message-ID: <8c4c00b0-6f8a-6cd4-dedd-2f574ff3f2bf@linux.intel.com>
References: <20221017143340.11622-1-dengshaomin@cdjrlc.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 17 Oct 2022, Shaomin Deng wrote:

> Drop the repeated word "when" in comments.
>
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
> lib/zstd/decompress/zstd_decompress.c | 2 +-
> net/mptcp/token.c                     | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/zstd/decompress/zstd_decompress.c b/lib/zstd/decompress/zstd_decompress.c
> index b4d81d84479a..6928e85f9d19 100644
> --- a/lib/zstd/decompress/zstd_decompress.c
> +++ b/lib/zstd/decompress/zstd_decompress.c
> @@ -996,7 +996,7 @@ size_t ZSTD_decompress(void* dst, size_t dstCapacity, const void* src, size_t sr
> size_t ZSTD_nextSrcSizeToDecompress(ZSTD_DCtx* dctx) { return dctx->expected; }
>
> /*
> - * Similar to ZSTD_nextSrcSizeToDecompress(), but when when a block input can be streamed,
> + * Similar to ZSTD_nextSrcSizeToDecompress(), but when a block input can be streamed,
>  * we allow taking a partial block as the input. Currently only raw uncompressed blocks can
>  * be streamed.
>  *
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index f52ee7b26aed..68b822691e36 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -288,7 +288,7 @@ EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
>  * token container starting from the specified position, or NULL.
>  *
>  * On successful iteration, the iterator is move to the next position and the
> - * the acquires a reference to the returned socket.
> + * acquires a reference to the returned socket.

Hi Shaomin -

Please separate the net/mptcp/token.c change into a separate patch, and 
when resubmitting use the mptcp@lists.linux.dev mailing list so your 
contribution and any discussion are in the mailing list archives. Thank 
you!

>  */
> struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
> 					 long *s_num)
> -- 
> 2.35.1
>
>

--
Mat Martineau
Intel
