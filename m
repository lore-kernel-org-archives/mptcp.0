Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6CAD56
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 22:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667600941; x=1699136941;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JGJv8myX9X0V5r/MdnZ3mGvqiGQTH9kJuDC5by4iM6E=;
  b=CSBITTEpJmmlotQqDS4OcvapMp4FkABdznCaY144MV9BAevNI8goZL5s
   4IpbMfLEJQZpTbb8o0DFQKeToyjCVYHyrcmdNELwWTls1EM9l8MKO8LGS
   uM2jz2foaL3yj2T3ryEFC1EcNY80zVMyn4C+53Capp3mL0zcW4qDEaTal
   RTv7WSl15CAy9v1RkAPzmY/9QYfr77V18w1vztR+XZlA4mB7baxeXuJF+
   SHcxwWx08TcnBbYsBS5gpxm35u9O+6+FGdn8DUxRSDYk9ISYxlAqqBtOW
   VIPzvuAmRG9/MCoy6IaNhZSicUiF0t/ItlOJZJLt5DneEWjdc1ny3BeKy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="310088499"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="310088499"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:29:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="777868806"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="777868806"
Received: from mvedaei-mobl2.amr.corp.intel.com ([10.212.176.106])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:29:00 -0700
Date: Fri, 4 Nov 2022 15:29:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] mptcp: more detailed error reporting on
 endpoint creation
In-Reply-To: <d51ab9e9d73cfa3e7b8e6c8864e022d5fdad434d.1667586266.git.pabeni@redhat.com>
Message-ID: <ab125cde-5c12-b241-804d-f948708503a6@linux.intel.com>
References: <13fc62c6a047dbd043be5131567c0f3a6c46267e.1667586266.git.pabeni@redhat.com> <d51ab9e9d73cfa3e7b8e6c8864e022d5fdad434d.1667586266.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 4 Nov 2022, Paolo Abeni wrote:

> Endpoint creation can fail for a number of reasons; in case of failure
> append the error number to the extended ack message, using a newly
> introduced generic helper.
>
> Additionally let mptcp_pm_nl_append_new_local_addr() report different
> error reasons.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Looks good to me. When I submit to netdev I'll note the genetlink.h change 
as being outside MPTCP.


Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> include/net/genetlink.h |  3 +++
> net/mptcp/pm_netlink.c  | 24 +++++++++++++-----------
> 2 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/genetlink.h b/include/net/genetlink.h
> index 9f97f73615b6..356e4c119322 100644
> --- a/include/net/genetlink.h
> +++ b/include/net/genetlink.h
> @@ -119,6 +119,9 @@ static inline void genl_info_net_set(struct genl_info *info, struct net *net)
>
> #define GENL_SET_ERR_MSG(info, msg) NL_SET_ERR_MSG((info)->extack, msg)
>
> +#define GENL_SET_ERR_MSG_FMT(info, msg, args...) \
> +	NL_SET_ERR_MSG_FMT((info)->extack, msg, ##args)
> +
> /* Report that a root attribute is missing */
> #define GENL_REQ_ATTR_CHECK(info, attr) ({				\
> 	struct genl_info *__info = (info);				\
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index fdf2ee29f762..d66fbd558263 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -912,10 +912,14 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> 	 */
> 	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
> 		pernet->next_id = 1;
> -	if (pernet->addrs >= MPTCP_PM_ADDR_MAX)
> +	if (pernet->addrs >= MPTCP_PM_ADDR_MAX) {
> +		ret = -ERANGE;
> 		goto out;
> -	if (test_bit(entry->addr.id, pernet->id_bitmap))
> +	}
> +	if (test_bit(entry->addr.id, pernet->id_bitmap)) {
> +		ret = -EBUSY;
> 		goto out;
> +	}
>
> 	/* do not insert duplicate address, differentiate on port only
> 	 * singled addresses
> @@ -929,8 +933,10 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> 			 * endpoint is an implicit one and the user-space
> 			 * did not provide an endpoint id
> 			 */
> -			if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT))
> +			if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT)) {
> +				ret = -EEXIST;
> 				goto out;
> +			}
> 			if (entry->addr.id)
> 				goto out;
>
> @@ -1016,16 +1022,12 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 		addrlen = sizeof(struct sockaddr_in6);
> #endif
> 	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
> -	if (err) {
> -		pr_warn("kernel_bind error, err=%d", err);
> +	if (err)
> 		return err;
> -	}
>
> 	err = kernel_listen(ssock, backlog);
> -	if (err) {
> -		pr_warn("kernel_listen error, err=%d", err);
> +	if (err)
> 		return err;
> -	}
>
> 	return 0;
> }
> @@ -1329,13 +1331,13 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
> 	if (entry->addr.port) {
> 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
> 		if (ret) {
> -			GENL_SET_ERR_MSG(info, "create listen socket error");
> +			GENL_SET_ERR_MSG_FMT(info, "create listen socket error: %d", ret);
> 			goto out_free;
> 		}
> 	}
> 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> 	if (ret < 0) {
> -		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
> +		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
> 		goto out_free;
> 	}
>
> -- 
> 2.38.1
>
>
>

--
Mat Martineau
Intel
