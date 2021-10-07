Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C442C83
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633605799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dC5lLqvMvAje7b2b8zhfLTH+Ajtj2HZMfWWACfxmZg=;
	b=ibrY/bvYhvfVcHVJRhYTjxoEm0fz4bM9/OPwVMft6whuicGpu8CvKAAJMmH9+cOXZpvKQu
	60sOGn+eOT3QBh0KIU47OskjldNUULDmyLS8LYUk4x/Kp2WVpaHS8h28LlkbO5moOtYiES
	RU+K46fv9GY1+9Eux9XTMqg+cQKZx8E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-qCEhJ8IoNFqVR-265D8uBQ-1; Thu, 07 Oct 2021 07:23:12 -0400
X-MC-Unique: qCEhJ8IoNFqVR-265D8uBQ-1
Received: by mail-wr1-f72.google.com with SMTP id p12-20020adfc38c000000b00160d6a7e293so1933517wrf.18
        for <mptcp@lists.linux.dev>; Thu, 07 Oct 2021 04:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2dC5lLqvMvAje7b2b8zhfLTH+Ajtj2HZMfWWACfxmZg=;
        b=zdOHaRucBdoJ5i8BgFfUTdI+BpwgbgoMKkKHVRj6cTr2/JIYsmNgSkCMMJTpzEmclu
         9rvYjXdHQL+ouZbswW9i4HpMuMlz13xEhnHzDLZQNBqUnzkW+UVCdXl8RWLKwxGh+Ip+
         qvh4CAI3hkmXUxme6p0fA/73Ja0PZS5TCNEDv0Z+cqBQn07eGVXtdTC4EnBekmSXHUgr
         /aemPZ5u3Yk54Q5C8wrE+UktEKE9sMZA3/0TBpikUmcdQrOMTDkCwjwRVFk0doRdvzZK
         N1ZoQ40JfbgomeGCSL+Z1vO+AJHelDNuzaXyQ9kRRz901J6CEmdDtxGQg6F9yqTqPovu
         1EVQ==
X-Gm-Message-State: AOAM532nheBlXFnJzY3YSZfl0NOpTHirgf9UzIQNQjsB05naYjCmCvAN
	S26ZsJyJGWURvNb2eVS7ZZod8ZC9aaRVWZ0MCTqoo+e5Aea7lxn7Lsy9Xcn4xSBlGm0RMX3XHvg
	5uJBcg+exrAbRlNU=
X-Received: by 2002:adf:d1c4:: with SMTP id b4mr4697877wrd.233.1633605791046;
        Thu, 07 Oct 2021 04:23:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNHVmdvcvfTER05bt/Q22y8PL9erc1Oz9nDOkFHc7o/sT3rYKcHf5nLWgwDTlavx1es0dBkQ==
X-Received: by 2002:adf:d1c4:: with SMTP id b4mr4697857wrd.233.1633605790821;
        Thu, 07 Oct 2021 04:23:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-183.dyn.eolo.it. [146.241.225.183])
        by smtp.gmail.com with ESMTPSA id j11sm5881109wrp.27.2021.10.07.04.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 04:23:10 -0700 (PDT)
Message-ID: <8bc73822b43996aecce401be5255b02f33e1f7a3.camel@redhat.com>
Subject: Re: [RFC PATCH 3/4] mptcp: pm_netlink: Add MPTCP_PM_CMD_REMOVE
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev, 
	mathew.j.martineau@linux.intel.com
Date: Thu, 07 Oct 2021 13:23:09 +0200
In-Reply-To: <20211007043656.261552-4-kishen.maloor@intel.com>
References: <20211007043656.261552-1-kishen.maloor@intel.com>
	 <20211007043656.261552-4-kishen.maloor@intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Thu, 2021-10-07 at 00:36 -0400, Kishen Maloor wrote:
> This change adds a MPTCP netlink interface command for issuing
> REMOVE_ADDR signals for a specific address over the chosen MPTCP
> connection from a userspace path manager.
> 
> The command requires the following parameters: {token, loc_id}.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  include/uapi/linux/mptcp.h |  2 ++
>  net/mptcp/pm_netlink.c     | 43 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index e22e891016e3..0ce8abce6d54 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -56,6 +56,7 @@ enum {
>  	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
>  	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
>  	MPTCP_PM_ATTR_TOKEN,				/* u32 */
> +	MPTCP_PM_ATTR_LOC_ID,				/* u8 */
>  
>  	__MPTCP_PM_ATTR_MAX
>  };
> @@ -94,6 +95,7 @@ enum {
>  	MPTCP_PM_CMD_GET_LIMITS,
>  	MPTCP_PM_CMD_SET_FLAGS,
>  	MPTCP_PM_CMD_ANNOUNCE,
> +	MPTCP_PM_CMD_REMOVE,
>  
>  	__MPTCP_PM_CMD_AFTER_LAST
>  };
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 1b41bbc70529..bf92ef605043 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1029,6 +1029,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
>  	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
>  	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
> +	[MPTCP_PM_ATTR_LOC_ID]		= { .type	= NLA_U8,	},
>  };
>  
>  void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
> @@ -1736,6 +1737,43 @@ static int mptcp_nl_addr_backup(struct net *net,
>  	return ret;
>  }
>  
> +static int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID],
> +		*token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> +	struct mptcp_sock *msk;
> +	struct mptcp_rm_list rm_list = { .nr = 0 };
> +	u32 _token;
> +	u8 _id;

Same comment as patch 1/4 about xmas tree order ;)

/P

