Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF12C83
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633603560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAv8BfW311ZxU0fXBBd9nEDifif3PcE0s6UmDVFyQ0Y=;
	b=irDi1BEVFDiRlq/LwIEvOx5svQzxJ2hBvSJTi4/4kEFGqTqRQaQLupZJ+yiC0X7V+vO29D
	3pS6K7eY+v52BqKGqRt14nwhMEHr5YbqUVrYjxT4BcBMLRLGNifV07x1BF4xUUwQbBd/6c
	0p/3+fzONJeOmzrgvoQM+8d/OrmOZRs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-PE7MIgswMi-rOmb_XuUz3A-1; Thu, 07 Oct 2021 06:45:57 -0400
X-MC-Unique: PE7MIgswMi-rOmb_XuUz3A-1
Received: by mail-wr1-f72.google.com with SMTP id k16-20020a5d6290000000b00160753b430fso4366992wru.11
        for <mptcp@lists.linux.dev>; Thu, 07 Oct 2021 03:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sAv8BfW311ZxU0fXBBd9nEDifif3PcE0s6UmDVFyQ0Y=;
        b=5i7BzIvBtOkenSuV5YZl1AbuZcMpn1VP97dr0wh4Yx1+tKI1LHVHtfoHGN92sT3NSL
         lK6Hm7fbyStMAenDtZ5+gcm8MbwoTErvV/LSMd8aSQM/9gXgyJK+bQwyOKRlxpyfHvTr
         gxb9XD2YbvmGjjC75/DpR0Chbs3WWUeSxO9uYQFIUp9iRS+XvqcLqWy78oeF6SskJ9rB
         3g4euMPmlUPVq/RGf9s5zTlvtR/ICz+uTYVagTYR+vm644Ari7yW5D7gWzl4jJoHfmcv
         vUJlWwMQzatAAwxxzPDATjJ8B3J3jRJPE8gFxCCy3wF0DwYlgLGuIA/BiNQN4v7fkO+Y
         j0mQ==
X-Gm-Message-State: AOAM530VgRdOvzf1+LjrnZJWVkLeZ81kpGt9FzjuLwtYPK7NrbqLs+Yh
	8twgq3Ysnk59z1TEuB697khkRyY2eDZiEqDsc9nxGox0zTXWCijX7yLuiwrvDL+Gb+5FgVBl6Bx
	Hnnjy7kKsvoNL86I=
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr4485541wrv.171.1633603555613;
        Thu, 07 Oct 2021 03:45:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKqGmUWd4dBNkS2n7hPbnz0kNNUn+5evPwZsdSPCCnO8VcFH8mHaY8WDmVfmuWpRXZtREFYA==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr4485520wrv.171.1633603555401;
        Thu, 07 Oct 2021 03:45:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-183.dyn.eolo.it. [146.241.225.183])
        by smtp.gmail.com with ESMTPSA id c204sm8616789wme.11.2021.10.07.03.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:45:55 -0700 (PDT)
Message-ID: <fb91c04cc9c83f80c555fb5be9e0bef6c556f37b.camel@redhat.com>
Subject: Re: [RFC PATCH 1/4] mptcp: pm_netlink: Add MPTCP_PM_CMD_ANNOUNCE
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev, 
	mathew.j.martineau@linux.intel.com
Date: Thu, 07 Oct 2021 12:45:54 +0200
In-Reply-To: <20211007043656.261552-2-kishen.maloor@intel.com>
References: <20211007043656.261552-1-kishen.maloor@intel.com>
	 <20211007043656.261552-2-kishen.maloor@intel.com>
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
> ADD_ADDR advertisements over the chosen MPTCP connection from a
> userspace path manager.
> 
> The command requires the following parameters:
> {token, {loc_id, family, saddr4 | saddr6 [, sport]} }.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  include/uapi/linux/mptcp.h |  2 ++
>  net/mptcp/pm_netlink.c     | 45 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index c8cc46f80a16..e22e891016e3 100644
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
> index 2a3589b67768..1b41bbc70529 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1028,6 +1028,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
>  					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
>  	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
> +	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
>  };
>  
>  void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
> @@ -1735,6 +1736,45 @@ static int mptcp_nl_addr_backup(struct net *net,
>  	return ret;
>  }
>  
> +static int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR],
> +		*token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> +	struct mptcp_sock *msk;
> +	struct mptcp_pm_addr_entry _addr;

The above should be change to respect the reverse xmas tree order, and
it's better to split the 2 assignement in separate definition:

	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
	struct nlattr *token = /...

> +	u32 _token;
> +	int err;
> +
> +	if (!addr || !token) {
> +		GENL_SET_ERR_MSG(info, "missing announce info");
> +		return -EINVAL;
> +	}
> +
> +	err = mptcp_pm_parse_addr(addr, info, true, &_addr);
> +	if (err < 0)
> +		return err;
> +
> +	_token = nla_get_u32(token);

I'm wondering if a new helper 'mptcp_pm_parse_addr_ex', additionally
parsing the code would help.

Cheers,

Paolo

