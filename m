Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1446453
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647984408; x=1679520408;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DJpk5xo0zRWJNHp8rE7exrAthXcgvBBVKT7pCTsXGEA=;
  b=LJHgrroHQhTXCFAZq6OSJQI7n5kLxfGulr/Ns7A0ZrVeGY5qGfjPKjhm
   HusRUlbbbnCI4iwFgjkMx6gFqLlFUPqFOBGYb3DQb+stpIjuTakFHVEvs
   dnAv78KWwvC3C9koZZqbcuuWNaIUboTKotAAq3VTPSYxzG0IRP+d3jfxt
   u+AHAlMt/vxqFmXlSBe8KQYDR5enx+PHXfZGVJtD3Oi8yfySFIjjBKO6l
   wpGgxqbPlvXvNJyBPAcMV2ikzUWloxk+RgYtAHAOv9d0xkHuVeXmqPczR
   eLK5tFC/nyPVKsGBn4EPYQhKfoTaODswtQlqWO9KALvgZEvhEOWXgdsKd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="344382918"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="344382918"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:26:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="785551603"
Received: from priyankk-mobl1.amr.corp.intel.com ([10.212.193.244])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:26:48 -0700
Date: Tue, 22 Mar 2022 14:26:47 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 2/8] mptcp: register default scheduler
In-Reply-To: <d6e5cce088abd4c956edc8f47d21a723a5a77b70.1647942374.git.geliang.tang@suse.com>
Message-ID: <5c8442d8-f74-1f85-43e3-ad9558c39d@linux.intel.com>
References: <cover.1647942374.git.geliang.tang@suse.com> <d6e5cce088abd4c956edc8f47d21a723a5a77b70.1647942374.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 22 Mar 2022, Geliang Tang wrote:

> This patch defined the default packet scheduler mptcp_sched_default,
> registered it in mptcp_sched_init().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c |  3 ++-
> net/mptcp/protocol.h |  2 ++
> net/mptcp/sched.c    | 11 +++++++++++
> 3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fbb14dfe62b3..11e19ac9d5af 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1424,7 +1424,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>  * returns the subflow that will transmit the next DSS
>  * additionally updates the rtx timeout
>  */
> -static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> +struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> {
> 	struct subflow_send_info send_info[SSK_MODE_MAX];
> 	struct mptcp_subflow_context *subflow;
> @@ -3743,6 +3743,7 @@ void __init mptcp_proto_init(void)
>
> 	mptcp_subflow_init();
> 	mptcp_pm_init();
> +	mptcp_sched_init();
> 	mptcp_token_init();
>
> 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) != 0)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 500dc7b3fde8..c186d199cf5b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -608,6 +608,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> struct mptcp_sched_ops *mptcp_sched_find(const char *name);
> int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
> void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
> +struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> +void mptcp_sched_init(void);
>
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 53a1bdaae2f1..331e6517622a 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -53,3 +53,14 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
>
> 	synchronize_rcu();
> }
> +
> +static struct mptcp_sched_ops mptcp_sched_default = {
> +	.get_subflow    = mptcp_subflow_get_send,
> +	.name           = "default",
> +	.owner          = THIS_MODULE,
> +};
> +
> +void mptcp_sched_init(void)
> +{
> +	mptcp_register_scheduler(&mptcp_sched_default);
> +}

We don't want the default scheduler to get unregistered (right?), so this 
patch should enforce that in mptcp_unregister_scheduler().

--
Mat Martineau
Intel
