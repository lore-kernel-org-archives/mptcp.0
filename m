Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB136A
	for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647860488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2hVxIVBWJZ6ZRABeVBJL/oL+WxNuctiTm8lMFB4wvo=;
	b=YHLV+B7erW74r3QOoVUeLz15Fpu89IOhVYj5d5MLsK5zN2Lr7HJ82sLKT+9b11zsNb1P0i
	VMbe9AL7ja7d6efe4r8UPjlop2ztIN/1u7UZ05kjDJuL2QIc9DgBtvtXmJqPyC3fGGsZO5
	xgV49teB1SQjfv/LhC4ahEWQozBGToc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-AxJuzyBGM5mmIHu5kzl2Rw-1; Mon, 21 Mar 2022 07:01:26 -0400
X-MC-Unique: AxJuzyBGM5mmIHu5kzl2Rw-1
Received: by mail-qt1-f198.google.com with SMTP id g22-20020ac870d6000000b002e20a1508ecso2370118qtp.19
        for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 04:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Y2hVxIVBWJZ6ZRABeVBJL/oL+WxNuctiTm8lMFB4wvo=;
        b=tvTN34/PMlDxFkgYmdfbGJStKjJ6gt5lSwTl2tExyi/YVkh3Z5EOfget/+nZhAQOSH
         KFuju/QPHFnKsJaSFXYq3ZFc9gcqWypnbL/OkyrS7MJ2rNNFLPX+KrAy75Xt1sQLP6Ej
         vJ9N0mfVhYf27vVTGRXlTx7cBhm92Et5YqvsA7YGTxmdvmjUHf5ciL8svB/2o3wnq4Rt
         MrVxs6T30LfZyQWwr/ZbsCPUXI+tFNWCJMJWWRRspqahWepmTeuN1aPzME7AihieB2M6
         jpa38JlAEnGAktWOYHRUClmMu1ECbLJB7xpZGmDALo6LaWDoaqZZXIsR17XviKQowOGk
         A7Og==
X-Gm-Message-State: AOAM533ounLcDO5EcTCRZQwV/xIP9SUX3lYWGGh9GPX6E56C7qqWGGfR
	QSRWzBQy6m2xi7UzlhOJxjrIgd9Fa/9hheJTgNWCWQniIunCTcu8gOuqxVLCHs7jSYYjNUUHkVP
	SQr6+PcThhxHZ3XQ=
X-Received: by 2002:a05:6214:d89:b0:440:c955:deb2 with SMTP id e9-20020a0562140d8900b00440c955deb2mr15848274qve.4.1647860485796;
        Mon, 21 Mar 2022 04:01:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwegmWCjcohOpTp9oW7U2o/9moA15CiMnP6ciYXBakfiN4MLyKfkjP4durwjWNbAAGDnQGPYA==
X-Received: by 2002:a05:6214:d89:b0:440:c955:deb2 with SMTP id e9-20020a0562140d8900b00440c955deb2mr15848248qve.4.1647860485513;
        Mon, 21 Mar 2022 04:01:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id o206-20020a37a5d7000000b0067d42fd49c3sm7637536qke.4.2022.03.21.04.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:01:25 -0700 (PDT)
Message-ID: <09a455b9675f00a9071a583d8595d8fcc3118d2a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 05/14] mptcp: netlink: Add
 MPTCP_PM_CMD_ANNOUNCE
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Mon, 21 Mar 2022 12:01:22 +0100
In-Reply-To: <20220316231636.645625-6-kishen.maloor@intel.com>
References: <20220316231636.645625-1-kishen.maloor@intel.com>
	 <20220316231636.645625-6-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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

On Wed, 2022-03-16 at 19:16 -0400, Kishen Maloor wrote:
> This change adds a MPTCP netlink interface for issuing
> ADD_ADDR advertisements over the chosen MPTCP connection from a
> userspace path manager.
> 
> The command requires the following parameters:
> { token, { loc_id, family, daddr4 | daddr6 [, dport] } [, if_idx],
> flags[signal] }.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  include/uapi/linux/mptcp.h |  2 ++
>  net/mptcp/pm_netlink.c     | 64 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index e41ea01a94bb..ac66c1263f02 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -55,6 +55,7 @@ enum {
>  	MPTCP_PM_ATTR_ADDR,				/* nested address */
>  	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
>  	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
> +	MPTCP_PM_ATTR_TOKEN,				/* u32 */
>  
>  	__MPTCP_PM_ATTR_MAX
>  };
> @@ -93,6 +94,7 @@ enum {
>  	MPTCP_PM_CMD_SET_LIMITS,
>  	MPTCP_PM_CMD_GET_LIMITS,
>  	MPTCP_PM_CMD_SET_FLAGS,
> +	MPTCP_PM_CMD_ANNOUNCE,
>  
>  	__MPTCP_PM_CMD_AFTER_LAST
>  };
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index aa1a9ae6b530..2b1d8b3b7891 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1178,6 +1178,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
>  					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
>  	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
> +	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
>  };
>  
>  void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
> @@ -1930,6 +1931,64 @@ static int mptcp_nl_set_flags(struct net *net,
>  	return ret;
>  }
>  
> +static int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> +	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct mptcp_pm_addr_entry addr_val;
> +	struct mptcp_sock *msk;
> +	u32 token_val;
> +	int err;
> +
> +	if (!addr || !token) {
> +		GENL_SET_ERR_MSG(info, "missing required inputs");
> +		return -EINVAL;
> +	}
> +
> +	token_val = nla_get_u32(token);
> +
> +	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
> +	if (!msk) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +		return -EINVAL;
> +	}
> +
> +	if (!mptcp_pm_is_userspace(msk)) {
> +		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> +		return -EINVAL;
> +	}
> +
> +	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
> +	if (err < 0) {
> +		GENL_SET_ERR_MSG(info, "error parsing local address");
> +		return err;
> +	}
> +
> +	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> +		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
> +		return -EINVAL;
> +	}
> +
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
> +	if (err < 0) {
> +		GENL_SET_ERR_MSG(info, "did not match address and id");
> +		return err;
> +	}
> +
> +	lock_sock((struct sock *)msk);
> +	spin_lock_bh(&msk->pm.lock);
> +
> +	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
> +		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
> +		mptcp_pm_nl_addr_send_ack(msk);
> +	}
> +
> +	spin_unlock_bh(&msk->pm.lock);
> +	release_sock((struct sock *)msk);
> +
> +	return 0;
> +}

If you are going to create a new pm_userspace.c compilation unit, I
think the above function could land there - yep, on the flip side it
will not be static anymore, still I think it would make easier the long
-term maintenance.

Similar comments for mptcp_nl_cmd_remove(), mptcp_nl_cmd_sf_create(),
mptcp_nl_find_ssk(), mptcp_nl_cmd_sf_destroy() in the following
patches.

/P

