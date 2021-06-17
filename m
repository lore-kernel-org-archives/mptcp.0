Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E1173
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 21:06:09 +0000 (UTC)
IronPort-SDR: VR01/tJzQxkJ8cR2xTgzJx88glnpLQaMHKKriVdTcOcEnKlXnYftmvCrokOBjfIqatMkMI7PqJ
 kf5jRM0slQPA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="204621497"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="204621497"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 14:06:08 -0700
IronPort-SDR: MluV9neQm91QPr7Mbbth89Lj8NOQFrUQyOS0/iisSVgKAxOAjMEdyuaIMAKLVzbjnSpZdsJ19g
 zIvajIbxx/Cg==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="637954726"
Received: from aparija-mobl1.amr.corp.intel.com ([10.212.253.186])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 14:06:08 -0700
Date: Thu, 17 Jun 2021 14:06:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, matthieu.baerts@tessares.net, 
    geliangtang@gmail.com
Subject: Re: [PATCH v3 1/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
 addr_signal each other
In-Reply-To: <1623921276-97178-2-git-send-email-liyonglong@chinatelecom.cn>
Message-ID: <c1863869-aef9-58ff-3cea-b3f38682a7f3@linux.intel.com>
References: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn> <1623921276-97178-2-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 17 Jun 2021, Yonglong Li wrote:

> ADD_ADDR share pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
> done we should not clean ADD_ADDR/RM_ADDR's addr_signal.
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
> net/mptcp/pm.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d00fa6..611bb2c7 100644
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

Thanks for your reply for my comments in the v2 of this patch. I did 
misunderstand that the clearing of MPTCP_ADD_ADDR_ECHO here was 
intentional.

Still, I'd prefer to have it written

~(BIT(MPTCP_ADD_ADDR_SIGNAL | BIT(MPTCP_ADD_ADDR_ECHO))

so it more obviously lists the bits to be cleared. Also can't assume that 
other bits in msk->pm.addr_signal will remain unused forever.

-Mat

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
