Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA02CAA
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639766391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7g0G8sSbZSfmKccZHmSqSRZs72qXD4R26UXM4apitao=;
	b=P93mxb3nnNi5W/5leQ7mWCkWApz7yWFkfwvPyLo0db6s7pqy9UMgJI9Kx9QEBHlgPBR36g
	YHDOlpwa4tNtF3QukwgmX7WbV0Trf3PACA7RYxP5UVkF3KW/WjjvK80uoy/aJv4/QDxb7+
	Xb9kG8AcD0hu5oclRdh4q0YG1hnI5uQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-FbubZxS-N6KDRh_NNgVjZA-1; Fri, 17 Dec 2021 13:39:49 -0500
X-MC-Unique: FbubZxS-N6KDRh_NNgVjZA-1
Received: by mail-qt1-f200.google.com with SMTP id s6-20020a05622a018600b002b2d93b9c73so3334068qtw.9
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 10:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7g0G8sSbZSfmKccZHmSqSRZs72qXD4R26UXM4apitao=;
        b=GCsLtCtf5KfW8JYzXcg+r27XICEdNMJ5pxsrSzlDkrPc+L0Y0VGey0j93tr4/5bibP
         /6RBS2CJfI8pnLdvlKzOb77nqwmiSth6GgucK1sbUX3wrI9O24jTWoxBOIkh5kXG1Mdb
         4wi44YYF9xZlfvhDHmtfYrSyqVHJ7gVgdmRbmV12fNUrc1SO1oLFKpLYTImLlFfQ8/aQ
         BRzYeBSW9uDMUHTwiK4kWeBLBEYpapRl5pvOQMZmanpDDGNMo/mxJKqiaBbukqzCgGE+
         z6Tk1BDdmlP4GLyxTrnkH7tlp7JTSe18fH9rBiwR2dpWzBWkgyfqm3LoOkWEf0GxPy0V
         2buw==
X-Gm-Message-State: AOAM532PFZWknW/VsC/oDsCIzkaTFQIONMe8vFGBNxPQ6kAozWDfxzkS
	OP+jPDkESDNIEH3en0Om5wAqBVrNE2Da0yVkgEAgqHT1aGyxkTOl4OCbJgRXTnRFKmIbzuGTZl6
	T1a7J2cYgOykXxeI=
X-Received: by 2002:ac8:7d08:: with SMTP id g8mr3697622qtb.142.1639766388712;
        Fri, 17 Dec 2021 10:39:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRn4S8RzycwWqGf1aIOju4dXfvprV/aATJXeX0Ue6S3b0Z7g4FJxtZd8nWhySFLs2yKti6hA==
X-Received: by 2002:ac8:7d08:: with SMTP id g8mr3697603qtb.142.1639766388479;
        Fri, 17 Dec 2021 10:39:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-225-60.dyn.eolo.it. [146.241.225.60])
        by smtp.gmail.com with ESMTPSA id 22sm7685676qtw.12.2021.12.17.10.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:39:48 -0800 (PST)
Message-ID: <1402a418d5101b5aa4fc6b11239c5f4d81ac90b0.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 13/21] mptcp: netlink: Add
 MPTCP_PM_CMD_ANNOUNCE
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 17 Dec 2021 19:39:45 +0100
In-Reply-To: <20211216222314.1244708-14-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
	 <20211216222314.1244708-14-kishen.maloor@intel.com>
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

On Thu, 2021-12-16 at 17:23 -0500, Kishen Maloor wrote:
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
> index 067a74ad7c5c..2e9ca5730b10 100644
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

I really think should be up to the user-space path PM to create this
listener.

Cheers,

Paolo

