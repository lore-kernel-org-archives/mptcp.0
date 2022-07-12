Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69A4681
	for <mptcp@lists.linux.dev>; Tue, 12 Jul 2022 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657646710; x=1689182710;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GwAzDXOH6cVXN0b7QKrnYJSm0gHYatWv/kV5HTV09uI=;
  b=dT6RtjK4j0vN9Q5iCzAh7lBgGGIcipgEmzHjxVdytTZjqdoNZk25XbPp
   jPjf6tqcXv+WqDP4qgzaUodkBbOInbNX3y7dM/xXFRAc2Q81Pwr1GRzfK
   NEQans9w2LxtdCucSgcqeoV24TyFwtDtZCnmVWAWmub1cDdjIhObxTvkt
   5sNFrOE3WUtpx7AsxHSf0ZPXnNUQOiqsrWKdgdnQfUYcZRVMGK14RKuD2
   mUVo7PhmOqf8O8G6Zllf+avb1oZdNODRkOY5Y0mTGb6vEUOCZSS17TNUd
   9AN4cogOY81cIJe4BtwGzEDi4yEbmFtIgJ5qChg30djsey8O8Unbi5Ol2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="348971263"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="348971263"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 10:25:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="592706906"
Received: from eklong-mobl.amr.corp.intel.com ([10.209.68.103])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 10:25:10 -0700
Date: Tue, 12 Jul 2022 10:25:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: add mptcp_for_each_subflow_safe
 helper
In-Reply-To: <20220712160236.3668376-1-matthieu.baerts@tessares.net>
Message-ID: <2898be1f-e7c0-3c-c732-8f2ea01c28ea@linux.intel.com>
References: <20220712160236.3668376-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 12 Jul 2022, Matthieu Baerts wrote:

> Similar to mptcp_for_each_subflow(): this is clearer now that the _safe
> version is used in multiple places.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Looks good to me, thanks Matthieu

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm_netlink.c | 2 +-
> net/mptcp/protocol.c   | 6 +++---
> net/mptcp/protocol.h   | 2 ++
> 3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 291b5da42fdb..62471aaedb6d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -796,7 +796,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 		u8 rm_id = rm_list->ids[i];
> 		bool removed = false;
>
> -		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> +		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
> 			u8 id = subflow->local_id;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c92f91cb2c8d..48fdef304309 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2338,7 +2338,7 @@ static void __mptcp_close_subflow(struct mptcp_sock *msk)
>
> 	might_sleep();
>
> -	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>
> 		if (inet_sk_state_load(ssk) != TCP_CLOSE)
> @@ -2381,7 +2381,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
>
> 	mptcp_token_destroy(msk);
>
> -	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
> 		bool slow;
>
> @@ -2886,7 +2886,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
>
> 	inet_sk_state_store(sk, TCP_CLOSE);
>
> -	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>
> 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b9333e7f380a..13b76f86f749 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -315,6 +315,8 @@ struct mptcp_sock {
>
> #define mptcp_for_each_subflow(__msk, __subflow)			\
> 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
> +#define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
> +	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
>
> static inline void msk_owned_by_me(const struct mptcp_sock *msk)
> {
> -- 
> 2.36.1
>
>
>

--
Mat Martineau
Intel
