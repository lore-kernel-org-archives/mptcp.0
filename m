Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687F1531D7
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227988; cv=none; b=SHUbuTYs3KddITLpPT2qQ4ro5b3SLv1FkR40ts2KKoxy5iEV5QU2nyNUQ0PZzHW63DjmcO+lSe71dk/b/9v0Q78B3D6GXRAcwQpGYR9iJW1EABiLok2QwE5pU7w7QNEMMXom6lUSIAxFwEKhuWHAZpOXiEpzPRArRLGuNr7juZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227988; c=relaxed/simple;
	bh=fasClbyamLL9+kFRp5Fb5l+Hd2EvDu2L/FnfxQAudl4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mpVlNn97MXM+MmHcYalViCF/Y5b+YLMT38Dl8Im0h8h9WBX43JMi+YFXxUdrJk7VGs1Ctmf+KR1ANOMazH39lAV4Ci6bmgM6benCdcYw9Ybn408qpSGlgtLR6Ibz3SvyJZejD7tL9jbTt8ZrRJrT1f0Q3sume3uQQGDNCaMweBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp4fp+RJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp4fp+RJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95E4C32782;
	Wed, 21 Aug 2024 08:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724227987;
	bh=fasClbyamLL9+kFRp5Fb5l+Hd2EvDu2L/FnfxQAudl4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=lp4fp+RJFOJRnmwZLgla5AZzsbQzrHyNTDfGmN9b7ybApgdyanlXPzUm83bX3M9je
	 +D+aNHlvqQZF3u6du4XzGkBtWTQXqS31wnoEX7p5S5pqWpdELe8RWX791dK+eOe44P
	 SnU1S/VgiCLdYDX2WwGsdhO0m+2m/75TnbnTnBdAulZlHwJbw/p5gPJGHPDV96ZFlE
	 Qny9aXDY6uWeEvMF84VmGEk7yXYxGrrK1XVMLfYBCfEH9LdiGiBdIGJXaURMQZynKt
	 pQTPHmiT8iRiuOpnrdrjr2LckONwP1i0ZnOdCV84saAsfiXC3LGSY6ifR1wCU7GRMr
	 EIG4HxNpoTG9g==
Message-ID: <4c0af275f10d952f052dfdc8d247822a5f6ba1b7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: pm_nl_ctl: remove
 re-definition
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 21 Aug 2024 16:13:01 +0800
In-Reply-To: <20240819-mptcp-pm-events-v1-1-c31d472471be@kernel.org>
References: <20240819-mptcp-pm-events-v1-1-c31d472471be@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Good catch!

On Mon, 2024-08-19 at 15:15 +0200, Matthieu Baerts (NGI0) wrote:
> 'MPTCP_PM_NAME' is defined in 'linux/mptcp.h', no need to re-define
> it.

nit: It's defined in "linux/mptcp_pm.h".

> 
> 'MPTCP_PM_EVENTS' is not defined in 'linux/mptcp.h', but
> 'MPTCP_PM_EV_GRP_NAME' is, with the same value. We can then use the
> latter, and drop the other one.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Except for the nit in commit log, LGTM.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Regards,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> index 7ad5a59adff2..994a556f46c1 100644
> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> @@ -19,12 +19,6 @@
>  
>  #include "linux/mptcp.h"
>  
> -#ifndef MPTCP_PM_NAME
> -#define MPTCP_PM_NAME		"mptcp_pm"
> -#endif
> -#ifndef MPTCP_PM_EVENTS
> -#define MPTCP_PM_EVENTS		"mptcp_pm_events"
> -#endif
>  #ifndef IPPROTO_MPTCP
>  #define IPPROTO_MPTCP 262
>  #endif
> @@ -116,7 +110,7 @@ static int capture_events(int fd, int
> event_group)
>  
>  	if (setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
>  		       &event_group, sizeof(event_group)) < 0)
> -		error(1, errno, "could not join the "
> MPTCP_PM_EVENTS " mcast group");
> +		error(1, errno, "could not join the "
> MPTCP_PM_EV_GRP_NAME " mcast group");
>  
>  	do {
>  		FD_ZERO(&rfds);
> @@ -288,7 +282,7 @@ static int genl_parse_getfamily(struct nlmsghdr
> *nlh, int *pm_family,
>  					if (grp->rta_type ==
> CTRL_ATTR_MCAST_GRP_ID)
>  						*events_mcast_grp =
> *(__u32 *)RTA_DATA(grp);
>  					else if (grp->rta_type ==
> CTRL_ATTR_MCAST_GRP_NAME &&
> -						
> !strcmp(RTA_DATA(grp), MPTCP_PM_EVENTS))
> +						
> !strcmp(RTA_DATA(grp), MPTCP_PM_EV_GRP_NAME))
>  						got_events_grp = 1;
>  
>  					grp = RTA_NEXT(grp,
> grp_len);
> 
> ---
> base-commit: a3cc6d5a9b3f3ccf7a368b21fb739163771cdfc7
> change-id: 20240819-mptcp-pm-events-f9abf8c594cb
> 
> Best regards,

