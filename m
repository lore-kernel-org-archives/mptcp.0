Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D497B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 00:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656461519; x=1687997519;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ya9z4xBkQRajA/uxM39zhDSCS4+msTzV3FdREKh0U/4=;
  b=UXz6c8zTmlI/nVrGiboHecyQwXtyT1m+zqEWlmLD5klABQK9uMywjejJ
   pNK0WLGFIvCxxm0CUAkSmrzVQKWyRikuPeye7rexYtH4an63zcEeMIZLd
   LSbKFyGa8yJPVX0OtcP7regycwba2Nq05SRzAmJF7jk+hng62AmMgvToO
   Bpy2bbadiZ/tDQ7DdS6lboQrdqDE3XZZ1frgO7P5y17sL4eWevvoqvBZX
   mNlwIv/Wh4yKfS3xreV54O5MTIXflQ3Hiv441n1i6Qf2MSyjn7tRuypN2
   yMODHOqmPUhlkmqy5TnyEcKIRafhTOEBOXgfX93ryk0ZxEhuikHLkJd9a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282614573"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="282614573"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:11:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="680265349"
Received: from hmok-mobl1.amr.corp.intel.com ([10.209.98.71])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:11:58 -0700
Date: Tue, 28 Jun 2022 17:11:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RFC 3/4] mptcp: allow the in kernel PM to set MPC subflow
 priority
In-Reply-To: <8a80c3bf12e43985e00b4fb04beccd38d69e505b.1656088406.git.pabeni@redhat.com>
Message-ID: <31cf8780-ea9f-fdf7-dffa-b77c831747@linux.intel.com>
References: <cover.1656088406.git.pabeni@redhat.com> <8a80c3bf12e43985e00b4fb04beccd38d69e505b.1656088406.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 24 Jun 2022, Paolo Abeni wrote:

> Any local endpoints configured on the address matching the
> MPC subflow are currently ignored.
>
> Specifically, setting a backup flag on them has no effect
> on the first subflow, as the MPC handshake can't carry such
> info.
>
> This change refactors the MPC endpoint id accounting to
> additionally fetch the priority info from the relevant endpoint
> and eventually trigger the MP_PRIO handshake as needed.
>
> As a result, the MPC subflow now switches to backup priority
> after that the MPTCP socket is fully established, according
> to the local endpoint configuration.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 37 +++++++++++++++----------------------
> 1 file changed, 15 insertions(+), 22 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 91f6ed2a076a..a6eb501e5031 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -505,30 +505,14 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
> 	struct mptcp_pm_addr_entry *entry;
>
> 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
> +		if ((!lookup_by_id &&
> +		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||

It seems like we could have multiple entries in the local_addr_list with 
the same address, but with different entries having port==0 or nonzero 
ports. If mptcp_nl_cmd_set_flags() is called with a nonzero port, but this 
lookup function encounters the port==0 entry first, this will match an 
unexpected entry in local_addr_list.

Is there some other constraint preventing this?

> 		    (lookup_by_id && entry->addr.id == info->id))
> 			return entry;
> 	}
> 	return NULL;
> }
>
> -static int
> -lookup_id_by_addr(const struct pm_nl_pernet *pernet, const struct mptcp_addr_info *addr)
> -{
> -	const struct mptcp_pm_addr_entry *entry;
> -	int ret = -1;
> -
> -	rcu_read_lock();
> -	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if (mptcp_addresses_equal(&entry->addr, addr, entry->addr.port)) {
> -			ret = entry->addr.id;
> -			break;
> -		}
> -	}
> -	rcu_read_unlock();
> -	return ret;
> -}
> -
> static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> {
> 	struct sock *sk = (struct sock *)msk;
> @@ -546,13 +530,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>
> 	/* do lazy endpoint usage accounting for the MPC subflows */
> 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
> +		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
> +		struct mptcp_pm_addr_entry *entry;
> 		struct mptcp_addr_info mpc_addr;
> -		int mpc_id;
> +		bool backup = false;
>
> 		local_address((struct sock_common *)msk->first, &mpc_addr);
> -		mpc_id = lookup_id_by_addr(pernet, &mpc_addr);
> -		if (mpc_id >= 0)
> -			__clear_bit(mpc_id, msk->pm.id_avail_bitmap);
> +		rcu_read_lock();
> +		entry = __lookup_addr(pernet, &mpc_addr, false);
> +		if (entry) {
> +			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
> +			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +		}
> +		rcu_read_unlock();
> +
> +		if (backup)
> +			mptcp_pm_send_ack(msk, subflow, true, backup);

This looks ok to me. I think I follow your example in #285 for how to 
create endpoints that would allow the priority to be changed later, but I 
think the selftests might make that clearer.

Thanks!

>
> 		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
> 	}
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
