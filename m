Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0D72
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 23:30:17 +0000 (UTC)
IronPort-SDR: 0LAQ2tRD6BAu6bVraAfk4j9kadSGTqxNaCievGxD+Sonq6MCpkNc5Kf0SSZFz3li1/+IDOvp2s
 8vgW4i5PtffA==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="186651365"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="186651365"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 16:30:16 -0700
IronPort-SDR: NqzWtpNyXIxRU4iYP6+ie1WABM2ir0eOJFHJcDixzrwEtahHpYAP/aXmR2n/0qa7BRfsxcdKEi
 Fhc7F6AQFRlA==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="452561823"
Received: from ndalili-mobl.amr.corp.intel.com ([10.209.105.124])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 16:30:16 -0700
Date: Wed, 16 Jun 2021 16:30:15 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, matthieu.baerts@tessares.net, 
    geliangtang@gmail.com
Subject: Re: [PATCH v2 1/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
 addr_signal each other
In-Reply-To: <1623720670-73539-2-git-send-email-liyonglong@chinatelecom.cn>
Message-ID: <fdfdf3c-f3bb-4e83-d49-84e97f667954@linux.intel.com>
References: <1623720670-73539-1-git-send-email-liyonglong@chinatelecom.cn> <1623720670-73539-2-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 15 Jun 2021, Yonglong Li wrote:

> ADD_ADDR share pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
> done we should not clean ADD_ADDR/RM_ADDR's addr_signal.
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
> net/mptcp/pm.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d00fa6..74886a3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -252,6 +252,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> 			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
> {
> +	u8 add_addr;
> 	int ret = false;
>
> 	spin_lock_bh(&msk->pm.lock);
> @@ -267,7 +268,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> 		goto out_unlock;
>
> 	*saddr = msk->pm.local;
> -	WRITE_ONCE(msk->pm.addr_signal, 0);
> +	add_addr = msk->pm.addr_signal & BIT(MPTCP_RM_ADDR_SIGNAL);

Hello Yonglong, thank you for your revised patch series.

It would be better to use ~BIT(MPTCP_ADD_ADDR_SIGNAL), similar to the 
change in mptcp_pm_rm_addr_signal() below.

> +	WRITE_ONCE(msk->pm.addr_signal, add_addr);
> 	ret = true;
>
> out_unlock:
> @@ -278,6 +280,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> 			     struct mptcp_rm_list *rm_list)
> {
> +	u8 rm_addr;
> 	int ret = false, len;
>
> 	spin_lock_bh(&msk->pm.lock);
> @@ -286,16 +289,17 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> 	if (!mptcp_pm_should_rm_signal(msk))
> 		goto out_unlock;
>
> +	rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
> 	len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
> 	if (len < 0) {
> -		WRITE_ONCE(msk->pm.addr_signal, 0);
> +		WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> 		goto out_unlock;
> 	}
> 	if (remaining < len)
> 		goto out_unlock;
>
> 	*rm_list = msk->pm.rm_list_tx;
> -	WRITE_ONCE(msk->pm.addr_signal, 0);
> +	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> 	ret = true;
>
> out_unlock:
> -- 
> 1.8.3.1
>
>

--
Mat Martineau
Intel
