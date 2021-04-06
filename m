Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571E6D0E
	for <mptcp@lists.linux.dev>; Tue,  6 Apr 2021 23:44:22 +0000 (UTC)
IronPort-SDR: NY0qzRQvYPoxmdxRssx+oWQmhTPx+eq+C61+T9DP/TqhEJp8A6u8ut9S9h7XodNjvOn6kMDMXR
 TlWiApidbHHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="192718969"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="192718969"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 16:44:21 -0700
IronPort-SDR: 5ayUVYY6y/1CdCsrpz79HagKekjaVEMiALv3NB5ra7uGLqX5oHEVz4NJAK29JA/24sCSOJRaAT
 AxzUTXfHbF3Q==
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="421442255"
Received: from mirmoha-mobl2.amr.corp.intel.com ([10.254.113.59])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 16:44:21 -0700
Date: Tue, 6 Apr 2021 16:44:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 1/2] mptcp: add mptcp_for_each_msk
 helper
In-Reply-To: <ba5b4db66f47311d65703f5ea25430a5957106a9.1617703144.git.geliangtang@gmail.com>
Message-ID: <32cc5ed6-d0a9-756d-454-6ee7ecf8f2d1@linux.intel.com>
References: <cover.1617703144.git.geliangtang@gmail.com> <ba5b4db66f47311d65703f5ea25430a5957106a9.1617703144.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Tue, 6 Apr 2021, Geliang Tang wrote:

> This patch added a new macro helper mptcp_for_each_msk to traverse each
> existing msk socket in the net namespace.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/pm_netlink.c | 39 +++++++++++++++++----------------------
> 1 file changed, 17 insertions(+), 22 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 6ba040897738..b9044defd89b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -58,6 +58,10 @@ struct pm_nl_pernet {
> #define MPTCP_PM_ADDR_MAX	8
> #define ADD_ADDR_RETRANS_MAX	3
>
> +#define mptcp_for_each_msk(__net, __msk)				\
> +	long __slot = 0, __num = 0;					\
> +	while ((__msk = mptcp_token_iter_next(__net, &(__slot), &(__num))) != NULL)

Hi Geliang,

I don't think it's good to move the variable declarations inside the macro 
like this. It looks like the compiler or sparse might have complained when 
the macro was used after a non-declaration line of code, since some other 
code (like list.ids[] initialization) was moved around. The macro 
shouldn't depend on careful placement in a code block this way - in my 
view, it's better to live with the existing syntax.


Mat


> +
> static bool addresses_equal(const struct mptcp_addr_info *a,
> 			    struct mptcp_addr_info *b, bool use_port)
> {
> @@ -985,9 +989,8 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
> static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
> {
> 	struct mptcp_sock *msk;
> -	long s_slot = 0, s_num = 0;
>
> -	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
> +	mptcp_for_each_msk(net, msk) {
> 		struct sock *sk = (struct sock *)msk;
>
> 		if (!READ_ONCE(msk->fully_established))
> @@ -1096,14 +1099,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
> 						   struct mptcp_addr_info *addr)
> {
> 	struct mptcp_sock *msk;
> -	long s_slot = 0, s_num = 0;
> -	struct mptcp_rm_list list = { .nr = 0 };
> -
> -	pr_debug("remove_id=%d", addr->id);
>
> -	list.ids[list.nr++] = addr->id;
> -
> -	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
> +	mptcp_for_each_msk(net, msk) {
> +		struct mptcp_rm_list list = { .nr = 0 };
> 		struct sock *sk = (struct sock *)msk;
> 		bool remove_subflow;
>
> @@ -1112,6 +1110,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
> 			goto next;
> 		}
>
> +		list.ids[list.nr++] = addr->id;
> +
> 		lock_sock(sk);
> 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
> 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
> @@ -1162,13 +1162,10 @@ static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry *entry)
> static int mptcp_nl_remove_id_zero_address(struct net *net,
> 					   struct mptcp_addr_info *addr)
> {
> -	struct mptcp_rm_list list = { .nr = 0 };
> -	long s_slot = 0, s_num = 0;
> 	struct mptcp_sock *msk;
>
> -	list.ids[list.nr++] = 0;
> -
> -	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
> +	mptcp_for_each_msk(net, msk) {
> +		struct mptcp_rm_list list = { .nr = 0 };
> 		struct sock *sk = (struct sock *)msk;
> 		struct mptcp_addr_info msk_local;
>
> @@ -1179,6 +1176,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
> 		if (!addresses_equal(&msk_local, addr, addr->port))
> 			goto next;
>
> +		list.ids[list.nr++] = 0;
> +
> 		lock_sock(sk);
> 		spin_lock_bh(&msk->pm.lock);
> 		mptcp_pm_remove_addr(msk, &list);
> @@ -1271,13 +1270,9 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
> static void mptcp_nl_remove_addrs_list(struct net *net,
> 				       struct list_head *rm_list)
> {
> -	long s_slot = 0, s_num = 0;
> 	struct mptcp_sock *msk;
>
> -	if (list_empty(rm_list))
> -		return;
> -
> -	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
> +	mptcp_for_each_msk(net, msk) {
> 		struct sock *sk = (struct sock *)msk;
>
> 		lock_sock(sk);
> @@ -1320,7 +1315,8 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
> 	pernet->next_id = 1;
> 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
> 	spin_unlock_bh(&pernet->lock);
> -	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
> +	if (!list_empty(&free_list))
> +		mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
> 	__flush_addrs(&free_list);
> 	return 0;
> }
> @@ -1535,11 +1531,10 @@ static int mptcp_nl_addr_backup(struct net *net,
> 				struct mptcp_addr_info *addr,
> 				u8 bkup)
> {
> -	long s_slot = 0, s_num = 0;
> 	struct mptcp_sock *msk;
> 	int ret = -EINVAL;
>
> -	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
> +	mptcp_for_each_msk(net, msk) {
> 		struct sock *sk = (struct sock *)msk;
>
> 		if (list_empty(&msk->conn_list))
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
