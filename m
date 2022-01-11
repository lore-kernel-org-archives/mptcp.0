Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D723173
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641893572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UW0G59Vv1rrMBAjDevMl635z8tVVMdBIkiTLbjEq5aA=;
	b=GsxQZiJTo90sVh1a9kqzkXjPzoGVspZi19TO0ZSXlV0qaEF5inMrsFjFMY/sMayh0W9klb
	nR9lKyJfXX5VnnZsrIHphR29a0iJKTneq79AwMiqM5xWDddk3WgaTS577JJCOYLtdc4Ozn
	3SzoVSaeb7lR0FjRlAAkdR18uL5YR8E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-KwOce_9UM7GgT3ZiAG3rEg-1; Tue, 11 Jan 2022 04:32:49 -0500
X-MC-Unique: KwOce_9UM7GgT3ZiAG3rEg-1
Received: by mail-wr1-f70.google.com with SMTP id n4-20020adf8b04000000b001a49cff5283so4689761wra.14
        for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 01:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UW0G59Vv1rrMBAjDevMl635z8tVVMdBIkiTLbjEq5aA=;
        b=piVxYiNwAtEM1phgiA3egPHdKRqoOTMDaVFfysSjGmkpY3q33aTl/6o1jP4yNdKAXN
         1UlqokejdiCJhNlmjcaN8Sa2LB2awAXpMFztAMcWwkjqXCj44i/+0zQc6jum/Ek+RYIS
         LgqTR7fZuZPpmtXFF5XVYltErIL56EAVvIV5wOQl8IK3Ys20eMGsQwViIkzxy2XFBvOB
         7lDQXsqtSrd9gNXzaOCBMDG5SPTiCfQKRjtVgXYcbTC2L1t3famendPJu8eiuin0trbl
         Re2ZrTwMU4wimGV7TfuhmD7UcWHjSJzHDnaKtEw08vAXRyVaPKdS6JFde4G8enTjUwQU
         TmaQ==
X-Gm-Message-State: AOAM530UbeL6buhgdddjfHgd+wGwarCSFS4V9Vxeuw0gzUPcypqAdYhz
	CyojuTRp/JYsGiVmQ8syTRqRToHk5uYbJerkqtTKEKhT9obvd8p8uZmU17WdsNvDx8LlnPgVviS
	fHTD1huJhmdiRpLQ=
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr1646852wmg.119.1641893567962;
        Tue, 11 Jan 2022 01:32:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwld+Z0gnZJDnaTlEnKFjmf2FmwaDmBrvK+mzTBPkcoy0bYgTkB/4490bBgwQJpOIi4ktnsNw==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr1646841wmg.119.1641893567700;
        Tue, 11 Jan 2022 01:32:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id a13sm8617940wrt.87.2022.01.11.01.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 01:32:47 -0800 (PST)
Message-ID: <d573c2c51b69aefc22daead01d6ba773d1b55c5c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 1/3] mptcp: set fullmesh flag in pm_netlink
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Tue, 11 Jan 2022 10:32:46 +0100
In-Reply-To: <503652e15fb983e53f4b20a95eb24dbde773e12e.1641868545.git.geliang.tang@suse.com>
References: <cover.1641868545.git.geliang.tang@suse.com>
	 <503652e15fb983e53f4b20a95eb24dbde773e12e.1641868545.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Tue, 2022-01-11 at 10:42 +0800, Geliang Tang wrote:
> This patch added the fullmesh flag setting support in pm_netlink.
> 
> If the fullmesh flag of the address is changed, remove all the related
> subflows, update the fullmesh flag and create subflows again.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/uapi/linux/mptcp.h |  1 +
>  net/mptcp/pm_netlink.c     | 27 ++++++++++++++++++++-------
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index f106a3941cdf..16758e124e51 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -81,6 +81,7 @@ enum {
>  #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
>  #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
>  #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
> +#define MPTCP_PM_ADDR_FLAG_NOFULLMESH			(1 << 4)
>  
>  enum {
>  	MPTCP_PM_CMD_UNSPEC,
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 47ad00d01cf2..1cdaa774cafc 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1743,13 +1743,17 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
>  	struct net *net = sock_net(skb->sk);
>  	u8 bkup = 0, lookup_by_id = 0;
> +	u8 fullmesh = 0;
>  	int ret;
>  
>  	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> +	if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH ||
> +	    addr.flags & MPTCP_PM_ADDR_FLAG_NOFULLMESH)
> +		fullmesh = 1;
> +	else if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
>  		bkup = 1;

if I read correctly this is somewhat halfway the two ideas discussed
yday and additionally allows to change either the backup or the
fullmesh flag, but not both simultanusly. I think we we can support
changing both flags with a single command and I think it's better to
stuck with one schema. Just:

	if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
		fullmesh = 1;


>  	if (addr.addr.family == AF_UNSPEC) {
>  		lookup_by_id = 1;
> @@ -1760,12 +1764,21 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	list_for_each_entry(entry, &pernet->local_addr_list, list) {

Here there is a pre-existing problem, I think. 'local_addr_list' is
protected by pernet->lock or RCU, but this chunk of code does not hold
any of them. The fix will conflict with this series.

>  		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) ||
>  		    (lookup_by_id && entry->addr.id == addr.addr.id)) {
> -			mptcp_nl_addr_backup(net, &entry->addr, bkup);
> -
> -			if (bkup)
> -				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> -			else
> -				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
			
I think here it would be better to expand the mptcp_nl_addr_backup()
helper to cope with fullmesh, too (so we traverse the msk socket hash
only once);

static void mptcp_nl_addr_flags(struct net *net,
                                struct mptcp_addr_info *addr,
                                u8 bkup, u8 fullmesh)
{
        long s_slot = 0, s_num = 0;
        struct mptcp_sock *msk;

        while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
                struct sock *sk = (struct sock *)msk;

                if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
                        goto next;

                lock_sock(sk);
                spin_lock_bh(&msk->pm.lock);
                mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);

		/* this should create/delete subflows as needed.
		  if 'addr' is MPTCP_PM_ADDR_FLAG_SIGNAL is a no-op 
*/
		mptcp_pm_nl_fullmesh(msk, addr, fullmesh);
                spin_unlock_bh(&msk->pm.lock);
                release_sock(sk);

next:
                sock_put(sk);
                cond_resched();
        }
}



> +			if (fullmesh) {
> +				mptcp_nl_remove_subflow_and_signal_addr(net, &entry->addr);
> +				if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
> +					entry->flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
> +				else
> +					entry->flags &= ~MPTCP_PM_ADDR_FLAG_FULLMESH;
> +				mptcp_nl_add_subflow_or_signal_addr(net);
> +			} else {
> +				mptcp_nl_addr_backup(net, &entry->addr, bkup);
> +
> +				if (bkup)
> +					entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> +				else
> +					entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +			}
>  		}
>  	}
>  

