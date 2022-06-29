Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CED7B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 22:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656542860; x=1688078860;
  h=date:from:to:subject:in-reply-to:message-id:references:
   mime-version;
  bh=3YsZq4UJD+aMK74RrVGfCEpmNGd+6HheF1T2CuxmM60=;
  b=YGjdpcT5lSEQU/i85OVCcK3B20Wl4rdd03sYqfFZLxddlBK6/2Mvj09c
   LbMLA+7ntqWHvoIugc69LhF8BVKpSfTEvmFXyW4h/agNQu2Z/FtxhrX7c
   NsVs3kS2GCipdHg7XEBkCLciv3aVw54WM6zQO+UBuDLCPuqLtMsVwJYoT
   oEnBq53sBY3R2akBxZO6eAv+4MF+lcnNVJqczY5+NHi3xJu6nLrzOZJ7T
   C5HC/KOnVc5+FufzlTiuqkL9tBeyoQE5qpXRNgFZAh3svvEDEu7Tyt0cj
   XJczzUaRGX9CBneHXmhUgTBsTfGplAooUKXPb34tH3wIENg28kpbys3dH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="368497769"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="368497769"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:47:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="541038700"
Received: from bschenc3-mobl.amr.corp.intel.com ([10.209.57.164])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:47:39 -0700
Date: Wed, 29 Jun 2022 15:47:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev, pabeni@redhat.com
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: Avoid acquiring PM lock for
 subflow priority changes
In-Reply-To: <20220629223550.655928-2-mathew.j.martineau@linux.intel.com>
Message-ID: <4b8981b-f6e7-b41d-3832-1c60c0582b23@linux.intel.com>
References: <20220629223550.655928-1-mathew.j.martineau@linux.intel.com> <20220629223550.655928-2-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 29 Jun 2022, Mat Martineau wrote:

> The in-kernel path manager code for changing subflow flags acquired both
> the msk socket lock and the PM lock when possibly changing the "backup"
> and "fullmesh" flags. mptcp_pm_nl_mp_prio_send_ack() does not access
> anything protected by the PM lock, and it must release and reacquire
> the PM lock.
>
> By pushing the PM lock to where it is needed in mptcp_pm_nl_fullmesh(),
> the lock is only acquired when the fullmesh flag is changed and the
> backup flag code no longer has to release and reacquire the PM lock. The
> change in locking context requires the MIB update to be modified - move
> that to a better location instead.
>
> This change also makes it possible to call
> mptcp_pm_nl_mp_prio_send_ack() for the userspace PM commands without
> manipulating the in-kernel PM lock.
>
> v2: Move MIB call to handle change in atomic context.
>
> Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
> net/mptcp/options.c    | 2 ++
> net/mptcp/pm_netlink.c | 7 ++-----
> 2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index aead331866a0..d5e58d2ce153 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1584,6 +1584,8 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 		*ptr++ = mptcp_option(MPTCPOPT_MP_PRIO,
> 				      TCPOLEN_MPTCP_PRIO,
> 				      opts->backup, TCPOPT_NOP);
> +
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);

Forgot to check in the build fix for this line before generating the 
.patch files... v3 coming right up.

- Mat

> 	}
>
> mp_capable_done:
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index e099f2a12504..936d72359c46 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -739,12 +739,9 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 		subflow->backup = bkup;
> 		subflow->send_mp_prio = 1;
> 		subflow->request_bkup = bkup;
> -		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
>
> -		spin_unlock_bh(&msk->pm.lock);
> 		pr_debug("send ack for mp_prio");
> 		mptcp_subflow_send_ack(ssk);
> -		spin_lock_bh(&msk->pm.lock);
>
> 		return 0;
> 	}
> @@ -1816,8 +1813,10 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
>
> 	list.ids[list.nr++] = addr->id;
>
> +	spin_lock_bh(&msk->pm.lock);
> 	mptcp_pm_nl_rm_subflow_received(msk, &list);
> 	mptcp_pm_create_subflow_or_signal_addr(msk);
> +	spin_unlock_bh(&msk->pm.lock);
> }
>
> static int mptcp_nl_set_flags(struct net *net,
> @@ -1835,12 +1834,10 @@ static int mptcp_nl_set_flags(struct net *net,
> 			goto next;
>
> 		lock_sock(sk);
> -		spin_lock_bh(&msk->pm.lock);
> 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
> 			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
> 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
> 			mptcp_pm_nl_fullmesh(msk, addr);
> -		spin_unlock_bh(&msk->pm.lock);
> 		release_sock(sk);
>
> next:
> -- 
> 2.36.1
>
>

--
Mat Martineau
Intel
