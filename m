Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C307F
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 01:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672795585; x=1704331585;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ybXc1BMJDhQKEjeYQFNH5Uj5pxigszoPvUm7fv51jgg=;
  b=fYF63h5gqOGU/GCsHWvk6Zcccubph4Opgfit1wwgGFsDktyU+I+RxlgR
   sl94s/8QxQ7Pm2XIpCb6P3IfA/Wwc4JrEdSvYnQGdu09AhaO2YWAKZ/bz
   J67Anbi0hYMWqevta58nNV+7dh1NhCfDiVRHjqdKeYgVnPYf+b6hFlPGo
   n27G4Y3GzB3ezpGWB8Y/TwSVJXvMQBXxGO9fFwgyFxsc3w7OMtrWZGkK4
   t3d1SHXEsjj1fbo7Ozbr9kmnHwFflewvb/pWT4+nVilLbhc1Q/71obmup
   K3N6xoJJ+/XtZ2q8n/GRZ6i5RdqYKwmI2HpCiclpMWymW/mL+mrs/T3TW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="321871524"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="321871524"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 17:26:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="779039680"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="779039680"
Received: from ticela-or-138.amr.corp.intel.com ([10.212.169.215])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 17:26:24 -0800
Date: Tue, 3 Jan 2023 17:26:23 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-iproute2] mptcp: add new listener events
In-Reply-To: <20221226093558.599103-1-matthieu.baerts@tessares.net>
Message-ID: <93761b86-6851-c1e1-1ddd-86942f71128b@linux.intel.com>
References: <20221226093558.599103-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 26 Dec 2022, Matthieu Baerts wrote:

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
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/313
> Cc: Geliang Tang <geliang.tang@suse.com>
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    No objection for the names?
>
>    We are currently limiting the name to 14 chars. If we want to have
>    "LISTENER_xxx" instead of "LISTEN_xxx", we need to increase this
>    limit. I'm fine with the current names or with +ER.

I have a slight preference to go with the LISTENER_* names and increase 
the fixed event length to 16.

Also had to add "if (tb[MPTCP_ATTR_TOKEN])" before the token printf() in 
mptcp_monitor_msg() (line 502) to avoid a segfault, since the listener 
events don't have token attributes.

The patch only applied to iproute2, not iproute2-next. Not sure which git 
tree they expect to reply to.

- Mat

>
> ip/ipmptcp.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index ce62ab9a..2338ba53 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -454,6 +454,8 @@ static const char * const event_to_str[] = {
> 	[MPTCP_EVENT_SUB_ESTABLISHED] = "SF_ESTABLISHED",
> 	[MPTCP_EVENT_SUB_CLOSED] = "SF_CLOSED",
> 	[MPTCP_EVENT_SUB_PRIORITY] = "SF_PRIO",
> +	[MPTCP_EVENT_LISTENER_CREATED] = "LISTEN_CREATED",
> +	[MPTCP_EVENT_LISTENER_CLOSED] = "LISTEN_CLOSED",
> };
>
> static void print_addr(const char *key, int af, struct rtattr *value)
>
> base-commit: 1e994cf69cfd55fefd000565914fd85e3ec150af
> --
> 2.37.2
>
>

--
Mat Martineau
Intel
