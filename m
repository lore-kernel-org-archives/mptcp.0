Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E56ADC
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 15:22:56 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so119310965e9.1
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682436174; x=1685028174;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8hAVsCisSp0ORrqn5XMfm6Z4m3XF6BLgOLvJcFa9xY=;
        b=804n/O8B0rqgt4RoRs6w6vScpvY6ylNKeJbMOtFHjxaVlJNnWyrwZRbplt0vf+PRyx
         q3gHbyLYeLfyAOolOjtRuksiL8YjzEvr5sKfkR4d3yvJCDCPvUkm+8qDdvMSLwPUr8ov
         l+//72iqgZ/ilTQ6izIU/Lex1AC7ccEKybRdC4aHW/5qrBdg7v5OHe5gny9BNX97sGe6
         j1ThItoQKMcaHo8LUSQ6BU0H/tHHEMrHktblDnc+O7A9rhYZFtVEIkbjwHlUNMYOmmAQ
         LeMycAaA67sM9Ic6+coVAGgN9BIJbQFp382qKzQO2M92vuKMJjL/1OjmBPOvRML60Rl+
         m5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682436174; x=1685028174;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8hAVsCisSp0ORrqn5XMfm6Z4m3XF6BLgOLvJcFa9xY=;
        b=N/x4oHJHtz6RUEEm3W6T3KvStVn/k5mThMFtaQHpJm7ki59UC8LN7OT6xeqJCIihjU
         IjPrN0sJiHRiseonGH7p2jPhNYfhTilmVx18YqN2tj/x1wFea2J1VE9N1wrzaR42zom5
         CYZaHmw3ZRUW7erf7626buYlmjLdS0n+Rs8EenJHgkYnMCmkkATyDmHaSsTBfcidEoBZ
         HAtml49RuCLpzZO39DvZtqEYYjpUI27GaAIYgDZdCW8mb6b64WmiJ48NcLfZy5GDPvvm
         GmyW/paUQqhxn9NmpQ9t7Yz1oaz9d4Xigghx7tyzh1kUROz51Mmzgsadb7Isjzn1R4/H
         AnFw==
X-Gm-Message-State: AAQBX9fPofDMTzs0WBHgqXaXJkVqpw3rbsnORUfBGi6gKl0hotQG/7YK
	XCw28qsBGPdPngag+hh051LP8JnVlZZcn9PIXU00eg==
X-Google-Smtp-Source: AKy350Zd0ROxjHWqab+TyrhXvb5Qn38FAXTE6cCYj1cfPQPWmc63f/QdCs7dlQ+ASl8hU6pkrgW74w==
X-Received: by 2002:a5d:6a11:0:b0:2f6:661:c03c with SMTP id m17-20020a5d6a11000000b002f60661c03cmr13072880wru.28.1682436174344;
        Tue, 25 Apr 2023 08:22:54 -0700 (PDT)
Received: from [10.124.6.89] ([195.181.172.155])
        by smtp.gmail.com with ESMTPSA id e8-20020adfdbc8000000b003047d5b8817sm4249168wrj.80.2023.04.25.08.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:22:54 -0700 (PDT)
Message-ID: <ae9f9424-2b22-8ba3-a7e0-197ad15d69c7@tessares.net>
Date: Tue, 25 Apr 2023 17:22:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v9 1/6] mptcp: only send RM_ADDR in
 nl_cmd_remove
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682409247.git.geliang.tang@suse.com>
 <51353fdd885e07dd2335320d605ea7c70195ba7b.1682409247.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <51353fdd885e07dd2335320d605ea7c70195ba7b.1682409247.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/04/2023 09:55, Geliang Tang wrote:
> The specifications from [1] about the "REMOVE" command say:
> 
>     Announce that an address has been lost to the peer
> 
> It was then only supposed to send a RM_ADDR and not trying to delete
> associated subflows.
> 
> A new helper mptcp_pm_remove_addrs() is then introduced to do just
> that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
> subflows.
> 
> To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
> command, see mptcp_nl_cmd_sf_destroy().
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h
> [1]

This "[1] should go at the end of the previous line.

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_netlink.c   | 16 ++++++++++++++++
>  net/mptcp/pm_userspace.c |  2 +-
>  net/mptcp/protocol.h     |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index e8336b8bd30e..d85649bc27e2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1555,6 +1555,22 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
>  	return ret;
>  }
>  
> +void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
> +{
> +	struct mptcp_rm_list alist = { .nr = 0 };
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	list_for_each_entry(entry, rm_list, list) {
> +		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
> +		    alist.nr < MPTCP_RM_IDS_MAX) {
> +			alist.ids[alist.nr++] = entry->addr.id;
> +			spin_lock_bh(&msk->pm.lock);
> +			mptcp_pm_remove_addr(msk, &alist);

Sorry, I didn't notice the issue before: this should be executed after
the for-loop. Without this modification and if you have multiple
addresses to remove, you will send multiple RM_ADDR re-using the same
list with a new item added each time.

> +			spin_unlock_bh(&msk->pm.lock);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
