Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3372
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 23:35:06 +0000 (UTC)
IronPort-SDR: diXLGEG1S2oYAq8twKn/g9cKhOhEeFN0IjHCIUNuXTe41I8OfeHsdG/XYRM/FWIZAQ8qiydWsL
 OtpkTFHzUJjw==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="270123521"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="270123521"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 16:35:05 -0700
IronPort-SDR: BLSmB3eXARBhf5a5wUQB3y1Hhs4mhKw6xxCJ58nAbZcw0VxphMASBIxeJou9/GLjFXPUctYqeU
 +grBx3pH848w==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="554996945"
Received: from ndalili-mobl.amr.corp.intel.com ([10.209.105.124])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 16:35:05 -0700
Date: Wed, 16 Jun 2021 16:35:04 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, matthieu.baerts@tessares.net, 
    geliangtang@gmail.com
Subject: Re: [PATCH v2 2/4] mptcp: make MPTCP_ADD_ADDR_SIGNAL and
 MPTCP_ADD_ADDR_ECHO separate
In-Reply-To: <1623720670-73539-3-git-send-email-liyonglong@chinatelecom.cn>
Message-ID: <61667a71-ef65-ebb-d75f-22f00df3d70@linux.intel.com>
References: <1623720670-73539-1-git-send-email-liyonglong@chinatelecom.cn> <1623720670-73539-3-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 15 Jun 2021, Yonglong Li wrote:

> MPTCP_ADD_ADDR_SIGNAL only for action of sending ADD_ADDR
> MPTCP_ADD_ADDR_ECHO only for action of sending echo ADD_ADDR
> add a mptcp_addr_info in struct mptcp_out_options for echo ADD_ADDR
>
> to prepare for the next patch.
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
> include/net/mptcp.h    |  1 +
> net/mptcp/pm.c         | 13 ++++++++-----
> net/mptcp/pm_netlink.c |  4 ++--
> net/mptcp/protocol.h   |  6 ++++++
> 4 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d61bbbf..637e90b 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -62,6 +62,7 @@ struct mptcp_out_options {
> 	u64 rcvr_key;
> 	u64 ahmac;
> 	struct mptcp_addr_info addr;
> +	struct mptcp_addr_info remote;
> 	struct mptcp_rm_list rm_list;
> 	u8 join_id;
> 	u8 backup;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 74886a3..9966ed1 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -18,7 +18,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> {
> 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
>
> -	pr_debug("msk=%p, local_id=%d", msk, addr->id);
> +	pr_debug("msk=%p, local_id=%d, echo:%d", msk, addr->id, echo);
>
> 	lockdep_assert_held(&msk->pm.lock);
>
> @@ -27,10 +27,13 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> 		return -EINVAL;
> 	}
>
> -	msk->pm.local = *addr;
> -	add_addr |= BIT(MPTCP_ADD_ADDR_SIGNAL);
> -	if (echo)
> +	if (echo) {
> +		msk->pm.remote = *addr;
> 		add_addr |= BIT(MPTCP_ADD_ADDR_ECHO);
> +	} else {
> +		msk->pm.local = *addr;
> +		add_addr |= BIT(MPTCP_ADD_ADDR_SIGNAL);
> +	}
> 	if (addr->family == AF_INET6)
> 		add_addr |= BIT(MPTCP_ADD_ADDR_IPV6);
> 	if (addr->port)
> @@ -214,7 +217,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
>
> void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
> {
> -	if (!mptcp_pm_should_add_signal(msk))
> +	if (!mptcp_pm_should_add_signal_echo(msk))
> 		return;
>
> 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index c53e500..ae700bd 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -317,14 +317,14 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
> 	if (!entry->addr.id)
> 		return;
>
> -	if (mptcp_pm_should_add_signal(msk)) {
> +	if (mptcp_pm_should_add_addr(msk)) {
> 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
> 		goto out;
> 	}
>
> 	spin_lock_bh(&msk->pm.lock);
>
> -	if (!mptcp_pm_should_add_signal(msk)) {
> +	if (!mptcp_pm_should_add_addr(msk)) {
> 		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
> 		mptcp_pm_announce_addr(msk, &entry->addr, false);
> 		mptcp_pm_add_addr_send_ack(msk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6c2322e..d14d03e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -708,6 +708,12 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
>
> static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
> {
> +	return READ_ONCE(msk->pm.addr_signal) &
> +		(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
> +}
> +
> +static inline bool mptcp_pm_should_add_addr(struct mptcp_sock *msk)

To fit with the naming of the other functions here, I suggest naming this 
function mptcp_pm_should_add_signal_addr() instead.

> +{
> 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
> }
>
> -- 
> 1.8.3.1
>
>

--
Mat Martineau
Intel
