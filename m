Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E31105
	for <mptcp@lists.linux.dev>; Tue, 19 Jul 2022 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658249772; x=1689785772;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fme5LROzlV8l/fNFEXKRx2eWQvLe0mfWfzSOKn+4C0I=;
  b=ceclwl5k5Q26Pp0OcjJwNNL3H8RTl9OY+3ZGzmbKYOOpCBaHIqxp+J9e
   F/njgdmKM3rBensFzjhLW7ypgiqQrvhgW+WS4N4YJ1R/o4wHiXDFVnp3u
   JINtr3sYwYT9lyzLEUvwGVLMzxfddGAmMJS/8Sg4q5a5wrLvrXw2gxEOt
   /Wxcg4AagE9hlRW3f6tB+Z06sqF5kCmJ4tpzk0SsQw0xf4Dx3fErKMrMq
   WkHPQlQHFDvnMvV7H9JaN8NhTTBPI7FC+LXsBz5Xa4D151sJ9OCHjHKH7
   ihv09XOUOfGlwwtZorTj0N2PXG2Z146XHh/E+AKjPfl6IdlvJFW4qNidc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="273375807"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="273375807"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 09:56:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="625270322"
Received: from nhanhan-mobl.amr.corp.intel.com ([10.209.102.198])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 09:56:12 -0700
Date: Tue, 19 Jul 2022 09:56:12 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jason Wang <wangborong@cdjrlc.com>
cc: matthieu.baerts@tessares.net, davem@davemloft.net, edumazet@google.com, 
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
    mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: Fix comment typo
In-Reply-To: <20220716044226.43587-1-wangborong@cdjrlc.com>
Message-ID: <1414d684-8881-5b2a-4824-e3c4488e862@linux.intel.com>
References: <20220716044226.43587-1-wangborong@cdjrlc.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Sat, 16 Jul 2022, Jason Wang wrote:

> The double `the' is duplicated in the comment, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
> net/mptcp/token.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index f52ee7b26aed..68b822691e36 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -288,7 +288,7 @@ EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
>  * token container starting from the specified position, or NULL.
>  *
>  * On successful iteration, the iterator is move to the next position and the

Two more changes are needed in the line above:

move -> moved
the -> then

Thanks for the contribution.

> - * the acquires a reference to the returned socket.
> + * acquires a reference to the returned socket.
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
