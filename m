Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC612C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644447682; x=1675983682;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gfIsuUzVfg7Xo8Jz2hc3qnzTt63v+rw73D8GPZD03bc=;
  b=ngZEkEyTrV/mtq2kGtJemB6FIk19wLslKLje+rKXyakNSuTcTwYXUqzM
   3knUBhdzaePaDA3OJ7Ev/iPqDsWTeYHXys37nzl3pyTYJ0bbRTJ3M/lhD
   /lLjdN+tMHOUJBvMSwkzhXp+ZTTxkVrK3pIh7Vcyf2Pvg4q3KO/CUwi49
   Ass6kCw4cRaGHipORcCDxsI/PI7ZqssGTeBQGU4LoeTevjEREiPeMePG8
   mRwtabbdRd7IGGiqzQHbWS7VvhZ7buL0unTb7FDC85hF3L6cBZNPx0HtC
   Hoe2/cYJYmdtoqwWBkv7qKRJzRV63D+hy//EefrxPiC0EC2scJ/i9+19x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="335775486"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="335775486"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:01:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701448409"
Received: from halucas-mobl3.amr.corp.intel.com ([10.212.241.159])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:01:21 -0800
Date: Wed, 9 Feb 2022 15:01:21 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: constify a bunch of of helpers
In-Reply-To: <8d4babebbd177de911a30c256b0b68742b09f607.1644400229.git.pabeni@redhat.com>
Message-ID: <8d96fcdf-9260-ac69-6f1e-6a1ec80b434@linux.intel.com>
References: <8d4babebbd177de911a30c256b0b68742b09f607.1644400229.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Feb 2022, Paolo Abeni wrote:

> A few pm-related helpers don't touch arguments which lacking
> the const modifier, let's constify them.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thanks for these improvements:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm.c         |  4 ++--
> net/mptcp/pm_netlink.c | 38 +++++++++++++++++++-------------------
> net/mptcp/protocol.h   | 18 +++++++++---------
> 3 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index c28dd5c21cbe..f5a8796470ff 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -221,7 +221,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> }
>
> void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
> -			      struct mptcp_addr_info *addr)
> +			      const struct mptcp_addr_info *addr)
> {
> 	struct mptcp_pm_data *pm = &msk->pm;
>
> @@ -285,7 +285,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>
> /* path manager helpers */
>
> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> 			      unsigned int opt_size, unsigned int remaining,
> 			      struct mptcp_addr_info *addr, bool *echo,
> 			      bool *port, bool *drop_other_suboptions)
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 98b485406afa..46346f009485 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -120,7 +120,7 @@ static void remote_address(const struct sock_common *skc,
> }
>
> static bool lookup_subflow_by_saddr(const struct list_head *list,
> -				    struct mptcp_addr_info *saddr)
> +				    const struct mptcp_addr_info *saddr)
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_addr_info cur;
> @@ -138,7 +138,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
> }
>
> static bool lookup_subflow_by_daddr(const struct list_head *list,
> -				    struct mptcp_addr_info *daddr)
> +				    const struct mptcp_addr_info *daddr)
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_addr_info cur;
> @@ -157,10 +157,10 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
>
> static struct mptcp_pm_addr_entry *
> select_local_address(const struct pm_nl_pernet *pernet,
> -		     struct mptcp_sock *msk)
> +		     const struct mptcp_sock *msk)
> {
> +	const struct sock *sk = (const struct sock *)msk;
> 	struct mptcp_pm_addr_entry *entry, *ret = NULL;
> -	struct sock *sk = (struct sock *)msk;
>
> 	msk_owned_by_me(msk);
>
> @@ -190,7 +190,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
> }
>
> static struct mptcp_pm_addr_entry *
> -select_signal_address(struct pm_nl_pernet *pernet, struct mptcp_sock *msk)
> +select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
> {
> 	struct mptcp_pm_addr_entry *entry, *ret = NULL;
>
> @@ -214,16 +214,16 @@ select_signal_address(struct pm_nl_pernet *pernet, struct mptcp_sock *msk)
> 	return ret;
> }
>
> -unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk)
> +unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
> {
> -	struct pm_nl_pernet *pernet;
> +	const struct pm_nl_pernet *pernet;
>
> -	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> +	pernet = net_generic(sock_net((const struct sock *)msk), pm_nl_pernet_id);
> 	return READ_ONCE(pernet->add_addr_signal_max);
> }
> EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
>
> -unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk)
> +unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
> {
> 	struct pm_nl_pernet *pernet;
>
> @@ -232,7 +232,7 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk)
> }
> EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
>
> -unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk)
> +unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
> {
> 	struct pm_nl_pernet *pernet;
>
> @@ -241,7 +241,7 @@ unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk)
> }
> EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
>
> -unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
> +unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
> {
> 	struct pm_nl_pernet *pernet;
>
> @@ -264,8 +264,8 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
> }
>
> struct mptcp_pm_add_entry *
> -mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> -				struct mptcp_addr_info *addr)
> +mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
> +				const struct mptcp_addr_info *addr)
> {
> 	struct mptcp_pm_add_entry *entry;
>
> @@ -346,7 +346,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>
> struct mptcp_pm_add_entry *
> mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> -		       struct mptcp_addr_info *addr, bool check_id)
> +		       const struct mptcp_addr_info *addr, bool check_id)
> {
> 	struct mptcp_pm_add_entry *entry;
> 	struct sock *sk = (struct sock *)msk;
> @@ -364,7 +364,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> }
>
> static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> -				     struct mptcp_pm_addr_entry *entry)
> +				     const struct mptcp_pm_addr_entry *entry)
> {
> 	struct mptcp_pm_add_entry *add_entry = NULL;
> 	struct sock *sk = (struct sock *)msk;
> @@ -410,8 +410,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
> 	}
> }
>
> -static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr,
> -				  struct mptcp_addr_info *addr)
> +static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned int nr,
> +				  const struct mptcp_addr_info *addr)
> {
> 	int i;
>
> @@ -493,9 +493,9 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
> }
>
> static int
> -lookup_id_by_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *addr)
> +lookup_id_by_addr(const struct pm_nl_pernet *pernet, const struct mptcp_addr_info *addr)
> {
> -	struct mptcp_pm_addr_entry *entry;
> +	const struct mptcp_pm_addr_entry *entry;
> 	int ret = -1;
>
> 	rcu_read_lock();
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f37f087caab3..beb5ee38656a 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -754,7 +754,7 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
> void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> 				const struct mptcp_addr_info *addr);
> void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
> -			      struct mptcp_addr_info *addr);
> +			      const struct mptcp_addr_info *addr);
> void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
> void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
> void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
> @@ -765,10 +765,10 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
> struct mptcp_pm_add_entry *
> mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> -		       struct mptcp_addr_info *addr, bool check_id);
> +		       const struct mptcp_addr_info *addr, bool check_id);
> struct mptcp_pm_add_entry *
> -mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> -				struct mptcp_addr_info *addr);
> +mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
> +				const struct mptcp_addr_info *addr);
> int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
> 					 u8 *flags, int *ifindex);
>
> @@ -832,7 +832,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
> 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
> }
>
> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> 			      unsigned int opt_size, unsigned int remaining,
> 			      struct mptcp_addr_info *addr, bool *echo,
> 			      bool *port, bool *drop_other_suboptions);
> @@ -845,10 +845,10 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk);
> void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
> 				     const struct mptcp_rm_list *rm_list);
> int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> -unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
> -unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
> -unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
> -unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
> +unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
> +unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
> +unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
> +unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
>
> void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
> void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
