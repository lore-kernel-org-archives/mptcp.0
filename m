Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A43483
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:21:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="210890114"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="210890114"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:21:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="417447361"
Received: from sghoshal-mobl.amr.corp.intel.com ([10.212.197.34])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:21:18 -0700
Date: Wed, 28 Jul 2021 17:21:18 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: local addresses
 fullmesh"
In-Reply-To: <6ace2404be8fddc3b5a0f3287ed6895ee7b23700.1627463661.git.geliangtang@xiaomi.com>
Message-ID: <6c82cb2-9d0-e0ea-e28b-e8ccfaf3d913@linux.intel.com>
References: <f5e079bf977b0c9e05e26f6b90d8cde4bb9a6c9f.1627463618.git.geliangtang@xiaomi.com> <6ace2404be8fddc3b5a0f3287ed6895ee7b23700.1627463661.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Jul 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> Fix the checkpatch.pl warning:
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> #28: FILE: net/mptcp/pm_netlink.c:542:
> +/*
> + * Fill all the local addresses into the three arrays,
>
> And some more cleanups.
>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>

This one looks good to squash too.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/pm_netlink.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 1b6c4adc5a8a..0b9fa7e6f743 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -538,8 +538,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
> 	mptcp_pm_create_subflow_or_signal_addr(msk);
> }
>
> -/*
> - * Fill all the local addresses into the three arrays,
> +/* Fill all the local addresses into the three arrays,
>  * addr[], flags[] and ifindex[],
>  * and return the arrays size.
>  */
> @@ -583,7 +582,9 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
> 	}
> 	rcu_read_unlock();
>
> -	/* if the array is empty, fill in the local address */
> +	/* If the arrays are empty, fill in the single
> +	 * 'IPADDRANY' local address
> +	 */
> 	if (!i) {
> 		memset(&local, 0, sizeof(local));
> 		local.family = msk->pm.remote.family;
> @@ -631,6 +632,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> 	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
> 	    msk->pm.subflows >= subflows_max)
> 		WRITE_ONCE(msk->pm.accept_addr, false);
> +
> 	spin_unlock_bh(&msk->pm.lock);
> 	for (i = 0; i < nr; i++)
> 		__mptcp_subflow_connect(sk, &addr[i], &remote, flags[i], ifindex[i]);
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
