Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103177F
	for <mptcp@lists.linux.dev>; Tue,  2 Aug 2022 22:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659478895; x=1691014895;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RRl8Wr0Hdlu6OVTnv0N+8fa2YKugeYr1fvxmaKZlk3U=;
  b=XVtFRbeKMXOMzPeOoHb0WRaKOQxK8eXotVgH79Z7ziaMfqCli6OH8QXR
   6oFpYDEUWpyMF2OPJE0olGLtSqgVna6WIBfdPbRQ/Uz0BkjI04SQAwZgB
   u6tKc/VhJo3ZKzSwoqoDWonHL50idFBdGa7fEyh/J0H+r+sHUIP8ZKZhG
   PrkqXhCB0J6r7ZMs0r1zh2t0NsL4rW961zPk9yV0TTZZYH4gLmq+N31r8
   JxbhWk77vBpSYEECgt3aLSBOigSormBPaEVGuqJ5RCKs9ql7i7mt0g7wG
   QIp5XOe0lrN6JPqcWxkl4ScS+crFXBj9hJvkF861XLYJFALoGxfyrx+WA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269301805"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="269301805"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:21:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="553086889"
Received: from dnrajurk-mobl.amr.corp.intel.com ([10.209.121.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:21:34 -0700
Date: Tue, 2 Aug 2022 15:21:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Xie Shaowen <studentxswpy@163.com>
cc: matthieu.baerts@tessares.net, davem@davemloft.net, edumazet@google.com, 
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
    mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
    Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH net-next] mptcp: Fix spelling mistakes and cleanup code
In-Reply-To: <20220730090617.3101386-1-studentxswpy@163.com>
Message-ID: <8dbc125-5396-fe56-99a1-c94b27c8938e@linux.intel.com>
References: <20220730090617.3101386-1-studentxswpy@163.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 30 Jul 2022, studentxswpy@163.com wrote:

> From: Xie Shaowen <studentxswpy@163.com>
>
> fix follow spelling misktakes:
> 	regarless ==> regardless
> 	interaces ==> interfaces
>
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: Xie Shaowen <studentxswpy@163.com>

Hello Xie Shaowen -

These spelling errors were already fixed in commit d640516a65d8, merged 
2022-06-28. Please make sure to work from an up-to-date branch!


Thanks for your patch,

Mat



> ---
> net/mptcp/pm_netlink.c | 2 +-
> net/mptcp/subflow.c    | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 7c7395b58944..5bdb559d5242 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1134,7 +1134,7 @@ void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ss
> 			}
> 			unlock_sock_fast(ssk, slow);
>
> -			/* always try to push the pending data regarless of re-injections:
> +			/* always try to push the pending data regardless of re-injections:
> 			 * we can possibly use backup subflows now, and subflow selection
> 			 * is cheap under the msk socket lock
> 			 */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index af28f3b60389..901c763dcdbb 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1634,7 +1634,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
> 	/* the newly created socket really belongs to the owning MPTCP master
> 	 * socket, even if for additional subflows the allocation is performed
> 	 * by a kernel workqueue. Adjust inode references, so that the
> -	 * procfs/diag interaces really show this one belonging to the correct
> +	 * procfs/diag interfaces really show this one belonging to the correct
> 	 * user.
> 	 */
> 	SOCK_INODE(sf)->i_ino = SOCK_INODE(sk->sk_socket)->i_ino;
> -- 
> 2.25.1
>
>

--
Mat Martineau
Intel
