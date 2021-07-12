Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436272
	for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 22:10:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="197246374"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="197246374"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:10:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="502474365"
Received: from archidas-mobl1.amr.corp.intel.com ([10.212.129.5])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:10:35 -0700
Date: Mon, 12 Jul 2021 15:10:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: make MPTCP_ADD_ADDR_SIGNAL
 and MPTCP_ADD_ADDR_ECHO separate"
In-Reply-To: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
Message-ID: <bb55d96e-dc98-baf3-697e-c872b88fed69@linux.intel.com>
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 11 Jul 2021, Geliang Tang wrote:

> A small cleanup.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/pm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 30deb76fa5d0..1eeecd68f159 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -18,7 +18,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> {
> 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
>
> -	pr_debug("msk=%p, local_id=%d, echo:%d", msk, addr->id, echo);
> +	pr_debug("msk=%p, local_id=%d, echo=%d", msk, addr->id, echo);
>
> 	lockdep_assert_held(&msk->pm.lock);
>
> -- 
> 2.31.1

Thanks for catching this detail!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
