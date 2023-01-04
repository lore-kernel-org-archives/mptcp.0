Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81107BA29
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672859059; x=1704395059;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BoCVbJUyRerEYdqDjy1UfkeWBm6IPHXidK0a2juFGTI=;
  b=GuDft9ii5ByhPk6/MDU53/zi/THumfUOYbtt0GBNK9/GTpnriOhCR3Ke
   uGnbOk6oOfe7h39hHRObFOd2CZG9K4btMQUm8paZAeI+oKKDYMK1hRZMu
   wOFY0pgL8YiNZuw+G9Ros/ziI8doBiGN4AUf9hT1E3RUCqWKt1HXE2UFN
   SwqPF169svq2pow8VatoE0F43/lsSE6imEL178yb/hQOuN48VKpM//zh/
   Kuz0qOWq1VHxek62ydDeQ8HALrRJcIyqf8KfWIDy2VeJ6kat4PxFuazOi
   6en+2IaYzlTwEdyX4Ee5tpxjVioL8UZXgbHWKnJZH+qlz3YFuGIQ7ICuD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349239922"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="349239922"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 11:04:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="687626618"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="687626618"
Received: from lakkired-mobl1.amr.corp.intel.com ([10.212.143.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 11:04:17 -0800
Date: Wed, 4 Jan 2023 11:04:17 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-iproute2-net v2] mptcp: add new listener events
In-Reply-To: <20230104150909.1238738-1-matthieu.baerts@tessares.net>
Message-ID: <ca69ff67-a04d-4e1b-4044-dcd642b6e1da@linux.intel.com>
References: <20230104150909.1238738-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 4 Jan 2023, Matthieu Baerts wrote:

> These new events have been added in kernel commit f8c9dfbd875b ("mptcp:
> add pm listener events") by Geliang Tang.
>
> Two new MPTCP Netlink event types for PM listening socket creation and
> closure have been recently added. They will be available in the future
> v6.2 kernel.
>
> They have been added because MPTCP for Linux, when not using the
> in-kernel PM, depends on the userspace PM to create extra listening
> sockets -- called "PM listeners" -- before announcing addresses and
> ports. With the existing MPTCP Netlink events, a userspace PM can create
> PM listeners at startup time, or in response to an incoming connection.
> Creating sockets in response to connections is not optimal: ADD_ADDRs
> can't be sent until the sockets are created and listen()ed, and if all
> connections are closed then it may not be clear to the userspace PM
> daemon that PM listener sockets should be cleaned up. Hence these new
> events: PM listening sockets can be managed based on application
> activity.
>
> Note that the maximum event string size has to be increased by 2 to be
> able to display LISTENER_CREATED without trunking it.

s/trunking/truncated/

Other than that, looks good!

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> Also, as pointed by Mat, this event doesn't have any "token" attribute
> so this attribute is now printed only if it is available.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/313
> Cc: Geliang Tang <geliang.tang@suse.com>
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    v1 -> v2:
>      - print LISTENER_* instead of LISTEN_* and increase the limit to 16
>        chars (Mat)
>      - check if the TOKEN attribute is available before printing it (Mat)
>      - edit the commit message to reflect the modifications from v2
>
> ip/ipmptcp.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index ce62ab9a..beba7a41 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -454,6 +454,8 @@ static const char * const event_to_str[] = {
> 	[MPTCP_EVENT_SUB_ESTABLISHED] = "SF_ESTABLISHED",
> 	[MPTCP_EVENT_SUB_CLOSED] = "SF_CLOSED",
> 	[MPTCP_EVENT_SUB_PRIORITY] = "SF_PRIO",
> +	[MPTCP_EVENT_LISTENER_CREATED] = "LISTENER_CREATED",
> +	[MPTCP_EVENT_LISTENER_CLOSED] = "LISTENER_CLOSED",
> };
>
> static void print_addr(const char *key, int af, struct rtattr *value)
> @@ -492,11 +494,12 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
> 		goto out;
> 	}
>
> -	printf("[%14s]", event_to_str[ghdr->cmd]);
> +	printf("[%16s]", event_to_str[ghdr->cmd]);
>
> 	parse_rtattr(tb, MPTCP_ATTR_MAX, (void *) ghdr + GENL_HDRLEN, len);
>
> -	printf(" token=%08x", rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
> +	if (tb[MPTCP_ATTR_TOKEN])
> +		printf(" token=%08x", rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
>
> 	if (tb[MPTCP_ATTR_REM_ID])
> 		printf(" remid=%u", rta_getattr_u8(tb[MPTCP_ATTR_REM_ID]));
>
> base-commit: d0e02f35af33b8957cc9f52af07b0b81d557ad3b
> -- 
> 2.37.2
>
>

--
Mat Martineau
Intel
