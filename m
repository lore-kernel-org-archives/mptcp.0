Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDE3481
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:20:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="276557035"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="276557035"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:20:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="417447165"
Received: from sghoshal-mobl.amr.corp.intel.com ([10.212.197.34])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:20:53 -0700
Date: Wed, 28 Jul 2021 17:20:53 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: remote addresses
 fullmesh"
In-Reply-To: <f5e079bf977b0c9e05e26f6b90d8cde4bb9a6c9f.1627463618.git.geliangtang@xiaomi.com>
Message-ID: <fee96eb-d19-1611-79b-34c580ad93c4@linux.intel.com>
References: <f5e079bf977b0c9e05e26f6b90d8cde4bb9a6c9f.1627463618.git.geliangtang@xiaomi.com>
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
> #63: FILE: net/mptcp/pm_netlink.c:427:
> +/*
> + * Fill all the remote addresses into the array addrs[],
>
> And some more cleanups.
>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>

Thanks Geliang.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/pm_netlink.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ecf43d45711a..8eeae401c83f 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -423,8 +423,7 @@ static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr
> 	return false;
> }
>
> -/*
> - * Fill all the remote addresses into the array addrs[],
> +/* Fill all the remote addresses into the array addrs[],
>  * and return the array size.
>  */
> static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullmesh,
> @@ -440,7 +439,9 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
> 	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
> 	subflows_max = mptcp_pm_get_subflows_max(msk);
>
> -	/* non-fullmesh, fill in the remote address */
> +	/* Non-fullmesh endpoint, fill in the single entry
> +	 * corresponding to the primary MPC subflow remote address
> +	 */
> 	if (!fullmesh) {
> 		remote_address((struct sock_common *)sk, &remote);
> 		msk->pm.subflows++;
> @@ -505,14 +506,13 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> 	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
> 		local = select_local_address(pernet, msk);
> 		if (local) {
> +			bool fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
> 			struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
> 			int i, nr;
>
> 			msk->pm.local_addr_used++;
> 			check_work_pending(msk);
> -			nr = fill_remote_addresses_vec(msk,
> -						       local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH,
> -						       addrs);
> +			nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
> 			spin_unlock_bh(&msk->pm.lock);
> 			for (i = 0; i < nr; i++) {
> 				__mptcp_subflow_connect(sk, &local->addr, &addrs[i],
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
