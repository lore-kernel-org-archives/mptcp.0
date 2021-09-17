Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298243FC3
	for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 00:30:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202189765"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="202189765"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 17:30:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="516950886"
Received: from mdiqbalh-mobl1.amr.corp.intel.com ([10.209.111.216])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 17:30:55 -0700
Date: Thu, 16 Sep 2021 17:30:55 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: always provide MPTCP skb ext for tx
 skb
In-Reply-To: <0bcf04149918792f287bf56fb5a38e4a19be4fe0.1631808364.git.pabeni@redhat.com>
Message-ID: <6ff9c2f7-a583-d2c7-5c7d-34799c2119@linux.intel.com>
References: <0bcf04149918792f287bf56fb5a38e4a19be4fe0.1631808364.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 16 Sep 2021, Paolo Abeni wrote:

> The mptcp code will uses whatever skb is present into
> ssk->sk_tx_skb_cache. If the skb tx cache is enabled, the
> recycle operation will clean the MPTCP extension from the
> cached skb, and the MPTCP would hit a later WARN.
>
> Fix the issue always invoking the mptcp skb allocation
> helper, which will safely check the cached skb for the extension
> presence.
>
> Fixes: 1094c6fe7280 ("mptcp: fix possible divide by zero")

Should add this tag too:

Reported-by: syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2602f1386160..f0673541a764 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1325,7 +1325,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 	}
>
> alloc_skb:
> -	if (!must_collapse && !ssk->sk_tx_skb_cache &&
> +	if (!must_collapse &&
> 	    !mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held))
> 		return 0;

must_collapse is only true if the tail skb extension has already been 
checked, so skipping the mptcp_alloc_tx_skb() will be ok in that case.

Looks good:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
