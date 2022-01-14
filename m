Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68872C9C
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642179895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kfs+ZOqNbKoOFQadxuEwTOp8TD8slPryXAVzD3nxV5M=;
	b=K9bJVh+hnKwaTkVqWUH3enoHQfwT8TxWBV7ZKDsH/p7KKON0CoU+3O3rjCAm7lKX2EcJIL
	qp7SPPYEUwVgiocqfewJV+dBLUInC2y/CM67ckfyPJAOBMxdkwlPr6jho6xfJeBXxQgLbI
	TXbEo3H+6rjGyvYe5wsj7JjqJCHZaa0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-q0tYsW9SPz2CW1iDx9Ekgw-1; Fri, 14 Jan 2022 12:04:54 -0500
X-MC-Unique: q0tYsW9SPz2CW1iDx9Ekgw-1
Received: by mail-qv1-f70.google.com with SMTP id f7-20020a056214076700b0041161d5b77bso8958932qvz.22
        for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 09:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Kfs+ZOqNbKoOFQadxuEwTOp8TD8slPryXAVzD3nxV5M=;
        b=pOc2oOb+sFY4WyJQFAOGAUdvp6WKctIzzbovhT/1T3EcNDB0kxSGbnVqKBFicoFpK9
         RiJ2OvMuyQ7q6VOJxFj2Eegj2kS7BlbBL6PkHpRPRJsiG0tFdItneOWGMt7PuJT5dSQ9
         IRNe6vWkBNR3QSDgeaTCH7TpicOfgxKuEFypZ89fZelcO2ODumnv0DxI9EutSUYtWv1T
         zEELA546D3R55/9CKYO7rr3ovJ3BS7cLAP9M9tsxkKjaPpPFcfAU8KGBHibCGPjRjZDZ
         XvCAtpca4VRYfulugPtkqOFmuQI52LTvCCMtl8ddJEjFB/xZAwcCSNnvumqT/hxJtGNS
         7MqA==
X-Gm-Message-State: AOAM533lZysZGAZ8HKxvHu/zDu7lKZuYrOmqGVPbCfLSYNIVBH+5XvbB
	SLjXyad87GGSc0AFptUZSuPIpHl5feY229scaycQlndKf78X7C9zmZQNei6JpexhHBAq9cBHwVq
	6LJfomu44toLP3VI=
X-Received: by 2002:ad4:5ded:: with SMTP id jn13mr8842112qvb.112.1642179894105;
        Fri, 14 Jan 2022 09:04:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4xN8JeNJvpXxWCoNQtP0HSk0nz05TCd2noIYkiwgvGmyuECG/5Iq3SMOYJl6kgq2l8sc1yw==
X-Received: by 2002:ad4:5ded:: with SMTP id jn13mr8841988qvb.112.1642179892806;
        Fri, 14 Jan 2022 09:04:52 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id w63sm3701004qkd.88.2022.01.14.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 09:04:52 -0800 (PST)
Message-ID: <e3e0f5dda757b01930c36ead9c453e99eb4bccac.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 13/21] mptcp: netlink: Add
 MPTCP_PM_CMD_ANNOUNCE
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 14 Jan 2022 18:04:49 +0100
In-Reply-To: <20220112221523.1829397-14-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
	 <20220112221523.1829397-14-kishen.maloor@intel.com>
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

On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
> This change adds a MPTCP netlink interface for issuing
> ADD_ADDR advertisements over the chosen MPTCP connection from a
> userspace path manager.
> 
> The command requires the following parameters:
> { token, { loc_id, family, daddr4 | daddr6 [, dport] } [, if_idx],
> flags/signal }.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  include/uapi/linux/mptcp.h |   2 +
>  net/mptcp/pm_netlink.c     | 111 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index f106a3941cdf..40380be396c8 100644
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
> @@ -92,6 +93,7 @@ enum {
>  	MPTCP_PM_CMD_SET_LIMITS,
>  	MPTCP_PM_CMD_GET_LIMITS,
>  	MPTCP_PM_CMD_SET_FLAGS,
> +	MPTCP_PM_CMD_ANNOUNCE,
>  
>  	__MPTCP_PM_CMD_AFTER_LAST
>  };
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 07536abab3e5..18228b2dfa2d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1268,6 +1268,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
>  					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
>  	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
> +	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
>  };
>  
>  void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
> @@ -2028,6 +2029,111 @@ static int mptcp_nl_addr_backup(struct net *net,
>  	return ret;
>  }
>  
> +static int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> +	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> +	struct mptcp_pm_addr_entry addr_val;
> +	struct mptcp_local_lsk *lsk_ref;
> +	bool reuse_port = false;
> +	struct mptcp_sock *msk;
> +	struct socket *lsk;
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
> +	if (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_USERSPACE) {
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
> +	if (!addr_val.addr.port) {
> +		addr_val.addr.port =
> +			((struct inet_sock *)inet_sk
> +			 ((struct sock *)msk))->inet_sport;
> +
> +		reuse_port = true;
> +	}
> +
> +	lsk_ref = lsk_list_find(pernet, &addr_val.addr);
> +
> +	if (!lsk_ref) {
> +		err = mptcp_pm_nl_create_listen_socket(skb->sk, &addr_val, &lsk);
> +		if ((err && !reuse_port) || (err && (err != -EADDRINUSE) && reuse_port)) {
> +			GENL_SET_ERR_MSG(info, "error creating listen socket");
> +			return err;
> +		}
> +
> +		if (lsk) {
> +			lsk_ref = lsk_list_add(pernet, &addr_val.addr, lsk);
> +			if (!lsk_ref) {
> +				GENL_SET_ERR_MSG(info, "can't allocate lsk ref");
> +				sock_release(lsk);
> +				return -ENOMEM;
> +			}
> +		}
> +	}

It looks like that the above chunk of code is sort of recurring. it's
likely worthy to factor it in some helper alike
"lsk_list_find_or_create()"

Cheers,

Paolo

