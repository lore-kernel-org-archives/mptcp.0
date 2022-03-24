Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44923BE
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 22:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648160054; x=1679696054;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oFTPwL7mZnsHidMEdSp6DxgCJreyh37+hrQ+NVgnohs=;
  b=GA69kr53E4QeGR18Ewo4rlX3WkCp6nPXC/JnwGhkllwUdmfVJLBX1IMk
   VTQWjTqrLUHhfzVQXl5zVbCnUgHOSBe5W7xbGQV7O9LNsTSC2mbytylgu
   2cjKB9YavxJeR3M23BtedRYphpHHiexwDYfAqP6ES3vnGaPZ+360PoK6B
   mkT7B5+2uMKY69+DpS3Ob16Zoe2Mp1k/qE56f1uPWO9yaNjmLFixn49JQ
   6UMGKY+I8FupIsws7pAUAqDJgfwcwUqLc44vaKID+t4THkxawUGGPIz1x
   aZCPxPfH+ErUnXzKdJMTQ9ANIqJevVwRZmKyksrv9IrSYVQkqLFKhkvWP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="238444158"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="238444158"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 15:14:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="519968414"
Received: from lyang24-mobl.amr.corp.intel.com ([10.255.230.22])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 15:14:12 -0700
Date: Thu, 24 Mar 2022 15:14:12 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v5 1/8] mptcp: add struct
 mptcp_sched_ops
In-Reply-To: <4df8257d4783911e933bdf3a3ddcfbac1c9db4f1.1648130637.git.geliang.tang@suse.com>
Message-ID: <3c9de8-eba6-881d-b869-d2339e76e8@linux.intel.com>
References: <cover.1648130637.git.geliang.tang@suse.com> <4df8257d4783911e933bdf3a3ddcfbac1c9db4f1.1648130637.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 24 Mar 2022, Geliang Tang wrote:

> This patch added struct mptcp_sched_ops. And define the scheduler
> register, unregister and find functions.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h  |  13 +++++
> net/mptcp/Makefile   |   2 +-
> net/mptcp/protocol.c |   1 +
> net/mptcp/protocol.h |   7 +++
> net/mptcp/sched.c    | 114 +++++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 136 insertions(+), 1 deletion(-)
> create mode 100644 net/mptcp/sched.c
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 8b1afd6f5cc4..e3a0baa8dbd7 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -95,6 +95,19 @@ struct mptcp_out_options {
> #endif
> };
>
> +#define MPTCP_SCHED_NAME_MAX 16
> +
> +struct mptcp_sched_ops {
> +	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
> +
> +	char			name[MPTCP_SCHED_NAME_MAX];
> +	struct module		*owner;
> +	struct list_head	list;
> +
> +	void (*init)(struct mptcp_sock *msk);
> +	void (*release)(struct mptcp_sock *msk);
> +} ____cacheline_aligned_in_smp;
> +
> #ifdef CONFIG_MPTCP
> extern struct request_sock_ops mptcp_subflow_request_sock_ops;
>
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 0a0608b6b4b4..aa5c10d1b80a 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -3,7 +3,7 @@ obj-$(CONFIG_MPTCP) += mptcp.o
> ccflags-y += -DDEBUG

This line of context keeps making 'git am' fail - looks like you have a 
debug-enabling commit in your private tree?

This is probably why patchew is having trouble with this series too.

- Mat

>
> mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
> -	   mib.o pm_netlink.o sockopt.o
> +	   mib.o pm_netlink.o sockopt.o sched.o
>
> obj-$(CONFIG_SYN_COOKIES) += syncookies.o
> obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d3887f628b54..b1d7c8b0c112 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3807,6 +3807,7 @@ void __init mptcp_proto_init(void)
>
> 	mptcp_subflow_init();
> 	mptcp_pm_init();
> +	mptcp_sched_init();
> 	mptcp_token_init();
>
> 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) != 0)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index fd82fd113113..3258b740c8ee 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -608,6 +608,13 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
> void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> 			 struct sockaddr_storage *addr,
> 			 unsigned short family);
> +struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
> +					 const char *name);
> +int mptcp_register_scheduler(const struct net *net,
> +			     struct mptcp_sched_ops *sched);
> +void mptcp_unregister_scheduler(const struct net *net,
> +				struct mptcp_sched_ops *sched);
> +void mptcp_sched_init(void);
>
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> new file mode 100644
> index 000000000000..3798a5cefeb6
> --- /dev/null
> +++ b/net/mptcp/sched.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Multipath TCP
> + *
> + * Copyright (c) 2022, SUSE.
> + */
> +
> +#define pr_fmt(fmt) "MPTCP: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/list.h>
> +#include <linux/rculist.h>
> +#include <linux/spinlock.h>
> +#include <net/tcp.h>
> +#include <net/netns/generic.h>
> +#include "protocol.h"
> +
> +static int sched_pernet_id;
> +
> +struct sched_pernet {
> +	/* protects pernet updates */
> +	spinlock_t		lock;
> +	struct list_head	sched_list;
> +};
> +
> +static struct sched_pernet *sched_get_pernet(const struct net *net)
> +{
> +	return net_generic(net, sched_pernet_id);
> +}
> +
> +struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
> +					 const char *name)
> +{
> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +	struct mptcp_sched_ops *sched, *ret = NULL;
> +
> +	spin_lock(&pernet->lock);
> +	list_for_each_entry_rcu(sched, &pernet->sched_list, list) {
> +		if (!strcmp(sched->name, name)) {
> +			ret = sched;
> +			break;
> +		}
> +	}
> +	spin_unlock(&pernet->lock);
> +
> +	return ret;
> +}
> +
> +int mptcp_register_scheduler(const struct net *net,
> +			     struct mptcp_sched_ops *sched)
> +{
> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +
> +	if (!sched->get_subflow)
> +		return -EINVAL;
> +
> +	if (mptcp_sched_find(net, sched->name))
> +		return -EEXIST;
> +
> +	spin_lock(&pernet->lock);
> +	list_add_tail_rcu(&sched->list, &pernet->sched_list);
> +	spin_unlock(&pernet->lock);
> +
> +	pr_debug("%s registered", sched->name);
> +	return 0;
> +}
> +
> +void mptcp_unregister_scheduler(const struct net *net,
> +				struct mptcp_sched_ops *sched)
> +{
> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +
> +	spin_lock(&pernet->lock);
> +	list_del_rcu(&sched->list);
> +	spin_unlock(&pernet->lock);
> +
> +	synchronize_rcu();
> +}
> +
> +static int __net_init sched_init_net(struct net *net)
> +{
> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +
> +	INIT_LIST_HEAD_RCU(&pernet->sched_list);
> +	spin_lock_init(&pernet->lock);
> +
> +	return 0;
> +}
> +
> +static void __net_exit sched_exit_net(struct net *net)
> +{
> +	struct sched_pernet *pernet = sched_get_pernet(net);
> +	struct mptcp_sched_ops *sched;
> +
> +	spin_lock(&pernet->lock);
> +	list_for_each_entry_rcu(sched, &pernet->sched_list, list)
> +		list_del_rcu(&sched->list);
> +	spin_unlock(&pernet->lock);
> +
> +	synchronize_rcu();
> +}
> +
> +static struct pernet_operations mptcp_sched_pernet_ops = {
> +	.init = sched_init_net,
> +	.exit = sched_exit_net,
> +	.id = &sched_pernet_id,
> +	.size = sizeof(struct sched_pernet),
> +};
> +
> +void mptcp_sched_init(void)
> +{
> +	if (register_pernet_subsys(&mptcp_sched_pernet_ops) < 0)
> +		panic("Failed to register MPTCP sched pernet subsystem.\n");
> +}
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
