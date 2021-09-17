Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397893FC3
	for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 01:11:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202855861"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="202855861"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 18:11:14 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="472968066"
Received: from mdiqbalh-mobl1.amr.corp.intel.com ([10.209.111.216])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 18:11:14 -0700
Date: Thu, 16 Sep 2021 18:11:14 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: allow changing the 'backup' bit when
 no sockets are open
In-Reply-To: <db472a753375c011d3dc7b810262935473e481aa.1631821658.git.dcaratti@redhat.com>
Message-ID: <1413a0f3-e0bf-2e2a-12e2-7e71b7ea3024@linux.intel.com>
References: <db472a753375c011d3dc7b810262935473e481aa.1631821658.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Thu, 16 Sep 2021, Davide Caratti wrote:

> current Linux refuses to change the 'backup' bit of MPTCP endpoints, i.e.
> using MPTCP_PM_CMD_SET_FLAGS, unless it finds (at least) one subflow that
> matches the endpoint address. There is no reason for that, so we can make
> mptcp_nl_addr_backup() return without error even when 0 MPTCP sockets are
> open and no MP_PRIO message is sent out.
>
> Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index c4f9a5ce3815..8a7048c5b9b4 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1678,7 +1678,7 @@ static int mptcp_nl_addr_backup(struct net *net,
> {
> 	long s_slot = 0, s_num = 0;
> 	struct mptcp_sock *msk;
> -	int ret = -EINVAL;
> +	int ret = 0;

Hi Davide & Geliang -

The ret value in mptcp_nl_addr_backup() can still get set to -EINVAL if 
mptcp_pm_nl_mp_prio_send_ack() returns that error and it happens to be the 
last token. So the error is not consistently propagated, and it doesn't 
seem like it's useful to propagate the -EINVAL to mptcp_nl_cmd_set_flags() 
anyway.

How about making mptcp_nl_cmd_set_flags() ignore the value returned by 
mptcp_nl_addr_backup()?

--
Mat Martineau
Intel
