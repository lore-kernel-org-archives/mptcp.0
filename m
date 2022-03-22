Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5E6453
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647984099; x=1679520099;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nHo4OfeCjF5/FdcnscZ0v7P6aPhxe+XaFQfUpy4IhVc=;
  b=RmmBrwb4u0W3Ooa0CB8nOLLnGWlkXXlM+d+on7IHH35XHA930OMKUByD
   ax4KcXZKsWuA9yWwg0XGFJz2VjCWn9HY4BTyfSPak0m9bSHl4NTxvzM96
   x/NcL8lc9lOenwpRXPemyrhR3aMmonmK2t+SOT5CiVxVnCgX5QAcB6op2
   aCRVLpLh6rDUnY+hSA1tl0FviaJvThpD+5ds33uJC+cNcb7hYac60gcRG
   4878Sqf4qEGf5jcIdy6PWYFHNF2PWwq+LHf7dVYrN1G7xL9pbzmRE4ejt
   MukRKV2W4Mt1PGduZn3/9f4gw02dxWdocPuUk1AhNMJ+O9Q0cnC8tbsX9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="318660738"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="318660738"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:21:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="552267309"
Received: from priyankk-mobl1.amr.corp.intel.com ([10.212.193.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:21:38 -0700
Date: Tue, 22 Mar 2022 14:21:37 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 1/8] mptcp: add struct mptcp_sched_ops
In-Reply-To: <02c1d2d2eee134713737fe5c5f73127e8c741589.1647942374.git.geliang.tang@suse.com>
Message-ID: <af371467-cc1a-7c7c-9b13-b1361ccf8992@linux.intel.com>
References: <cover.1647942374.git.geliang.tang@suse.com> <02c1d2d2eee134713737fe5c5f73127e8c741589.1647942374.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 22 Mar 2022, Geliang Tang wrote:

> This patch added struct mptcp_sched_ops. And define the scheduler
> register, unregister and find functions.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h  | 13 +++++++++++
> net/mptcp/Makefile   |  2 +-
> net/mptcp/protocol.h |  3 +++
> net/mptcp/sched.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 72 insertions(+), 1 deletion(-)
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
>
> mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
> -	   mib.o pm_netlink.o sockopt.o
> +	   mib.o pm_netlink.o sockopt.o sched.o
>
> obj-$(CONFIG_SYN_COOKIES) += syncookies.o
> obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c8bada4537e2..500dc7b3fde8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -605,6 +605,9 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
> void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> 			 struct sockaddr_storage *addr,
> 			 unsigned short family);
> +struct mptcp_sched_ops *mptcp_sched_find(const char *name);
> +int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
> +void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
>
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> new file mode 100644
> index 000000000000..53a1bdaae2f1
> --- /dev/null
> +++ b/net/mptcp/sched.c
> @@ -0,0 +1,55 @@
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
> +#include "protocol.h"
> +
> +static DEFINE_SPINLOCK(mptcp_sched_list_lock);
> +static LIST_HEAD(mptcp_sched_list);

Would be better to have this list per-namespace instead of global. Then 
the pernet lock would also work and mptcp_sched_list_lock would not be 
needed either.

> +
> +struct mptcp_sched_ops *mptcp_sched_find(const char *name)
> +{
> +	struct mptcp_sched_ops *ops;
> +
> +	list_for_each_entry_rcu(ops, &mptcp_sched_list, list) {
> +		if (!strcmp(ops->name, name))
> +			return ops;
> +	}
> +
> +	return NULL;
> +}
> +
> +int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
> +{
> +	if (!sched->get_subflow)
> +		return -EINVAL;
> +
> +	spin_lock(&mptcp_sched_list_lock);
> +	if (mptcp_sched_find(sched->name)) {
> +		spin_unlock(&mptcp_sched_list_lock);
> +		return -EEXIST;
> +	}
> +	list_add_tail_rcu(&sched->list, &mptcp_sched_list);
> +	spin_unlock(&mptcp_sched_list_lock);
> +
> +	pr_debug("%s registered", sched->name);
> +	return 0;
> +}
> +
> +void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
> +{
> +	spin_lock(&mptcp_sched_list_lock);
> +	list_del_rcu(&sched->list);
> +	spin_unlock(&mptcp_sched_list_lock);
> +
> +	synchronize_rcu();
> +}
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
