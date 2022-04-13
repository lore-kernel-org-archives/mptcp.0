Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73E28FE
	for <mptcp@lists.linux.dev>; Wed, 13 Apr 2022 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1649858807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z09VwKOt37lhaPfB6FDVDUU6NnVrHXTcCybRDApvr3c=;
	b=WHHq5atCZDr4Fv2Wzpw3QGx4Va+3gxAvHyZ3xAJbpkrGGwDHv7i0Vtzf6AGLlAq3sxsbuy
	CPFfQREd1vc8m35diaekdDClrM02eJadJW5HPMzAUYSShxOhr8mNavzi+2+XcMiTuBTACD
	W7yEHF9KS7FA3CYDhR7e63DdwUcYfAw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-Ss7nUJYgPdK3qbNN2t838g-1; Wed, 13 Apr 2022 10:06:46 -0400
X-MC-Unique: Ss7nUJYgPdK3qbNN2t838g-1
Received: by mail-wm1-f72.google.com with SMTP id h18-20020a05600c351200b0038e82e6321bso946871wmq.5
        for <mptcp@lists.linux.dev>; Wed, 13 Apr 2022 07:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Z09VwKOt37lhaPfB6FDVDUU6NnVrHXTcCybRDApvr3c=;
        b=rO/2MfHnRACmPzejaaH5fecl0HXKqq9XQVRfZcVfxDzTteJu/lup6AE+If5Q98rmPQ
         FhIRJzJzUpME4icNp00CuCQQqpaP6QDOrlR8HkpUkYVuZer8R9tBhAC5RvfNtoWk9oyX
         EOvrwH335xAG8Xk7b778dqtlHsdpSflm+l79IcTxIBfKdZZ2GTT/K+ngZMmSPsWYlMwn
         qmIM+zC4Eg1ZrbSWPMWHZfgVtTVvo0D1fYNcO3rGBUDY0EaT9B8i3k866ILpDVWn1BtY
         Zv0EqJQe9qg3PurGoVAuIpC+3invRAoJVCzbb/FQVJGEbxHo3DX+gd2YbDoDMI+yCPWM
         ELiQ==
X-Gm-Message-State: AOAM530ouoyq6BGlHsoOx8pBICwR5SF/qagZHkGCkXfmqSpY48a9n2YH
	wcVDCZZIXi+CU52vrg/jtwd7Fl3rBx/5DQxawN3jGUDVnQE4bq2OuBsaMyJDxvVDbdFmQSkP7MF
	9i9qXbYOqWCW0CAY=
X-Received: by 2002:a5d:6d8a:0:b0:204:909:2d9a with SMTP id l10-20020a5d6d8a000000b0020409092d9amr34167844wrs.435.1649858804925;
        Wed, 13 Apr 2022 07:06:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmR0P1+Xus5Z3khxz13iWtwNjDclipGNJQejAx7c0T/vBxOMLPEkfItoereAlz4h2NFyjzqg==
X-Received: by 2002:a5d:6d8a:0:b0:204:909:2d9a with SMTP id l10-20020a5d6d8a000000b0020409092d9amr34167823wrs.435.1649858804562;
        Wed, 13 Apr 2022 07:06:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0038b7c4c0803sm3068416wms.30.2022.04.13.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:06:44 -0700 (PDT)
Message-ID: <cd3448feaa77b8555a6fe69cfcbf8d7ca49028dd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v9 02/14] mptcp: handle local addrs announced
 by userspace PMs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Wed, 13 Apr 2022 16:06:43 +0200
In-Reply-To: <20220409013825.1877395-3-kishen.maloor@intel.com>
References: <20220409013825.1877395-1-kishen.maloor@intel.com>
	 <20220409013825.1877395-3-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Fri, 2022-04-08 at 21:38 -0400, Kishen Maloor wrote:
> This change adds an internal function to store/retrieve local
> addrs announced by userspace PM implementations to/from its kernel
> context. The function addresses the requirements of three scenarios:
> 1) ADD_ADDR announcements (which require that a local id be
> provided), 2) retrieving the local id associated with an address,
> and also where one may need to be assigned, and 3) reissuance of
> ADD_ADDRs when there's a successful match of addr/id.
> 
> The list of all stored local addr entries is held under the
> MPTCP sock structure. Memory for these entries is allocated from
> the sock option buffer, so the list of addrs is bounded by optmem_max.
> The list if not released via REMOVE_ADDR signals is ultimately
> freed when the sock is destructed.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> v6:
> -Move local_addr_list into struct mptcp_pm_data.
> -Replace mptcp_data_lock() with the pm spinlock.
> -Move mptcp_userspace_pm_append_new_local_addr() and
> mptcp_free_local_addr_list() into a new pm_userspace.c.
> -Make addresses_equal() helper non-static and rename to
> mptcp_addresses_equal().
> 
> v8:
> -Add copyright notice to pm_userspace.c.
> ---
>  net/mptcp/Makefile       |  2 +-
>  net/mptcp/pm.c           |  1 +
>  net/mptcp/pm_netlink.c   | 34 +++++++++---------
>  net/mptcp/pm_userspace.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c     |  1 +
>  net/mptcp/protocol.h     |  7 ++++
>  6 files changed, 105 insertions(+), 18 deletions(-)
>  create mode 100644 net/mptcp/pm_userspace.c
> 
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 168c55d1c917..4004347db47e 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -2,7 +2,7 @@
>  obj-$(CONFIG_MPTCP) += mptcp.o
>  
>  mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
> -	   mib.o pm_netlink.o sockopt.o
> +	   mib.o pm_netlink.o sockopt.o pm_userspace.o
>  
>  obj-$(CONFIG_SYN_COOKIES) += syncookies.o
>  obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 5d6832c4d9f2..cdc2d79071f8 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -469,6 +469,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>  {
>  	spin_lock_init(&msk->pm.lock);
>  	INIT_LIST_HEAD(&msk->pm.anno_list);
> +	INIT_LIST_HEAD(&msk->pm.userspace_pm_local_addr_list);
>  	mptcp_pm_data_reset(msk);
>  }
>  
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 98b205c2c101..92d47e8e8983 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -66,8 +66,8 @@ pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
>  	return pm_nl_get_pernet(sock_net((struct sock *)msk));
>  }
>  
> -static bool addresses_equal(const struct mptcp_addr_info *a,
> -			    const struct mptcp_addr_info *b, bool use_port)
> +bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
> +			   const struct mptcp_addr_info *b, bool use_port)
>  {
>  	bool addr_equals = false;
>  
> @@ -131,7 +131,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
>  		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>  
>  		local_address(skc, &cur);
> -		if (addresses_equal(&cur, saddr, saddr->port))
> +		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
>  			return true;
>  	}
>  
> @@ -149,7 +149,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
>  		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>  
>  		remote_address(skc, &cur);
> -		if (addresses_equal(&cur, daddr, daddr->port))
> +		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
>  			return true;
>  	}
>  
> @@ -269,7 +269,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
>  	lockdep_assert_held(&msk->pm.lock);
>  
>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> -		if (addresses_equal(&entry->addr, addr, true))
> +		if (mptcp_addresses_equal(&entry->addr, addr, true))
>  			return entry;
>  	}
>  
> @@ -286,7 +286,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
>  
>  	spin_lock_bh(&msk->pm.lock);
>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> -		if (addresses_equal(&entry->addr, &saddr, true)) {
> +		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
>  			ret = true;
>  			goto out;
>  		}
> @@ -421,7 +421,7 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
>  	int i;
>  
>  	for (i = 0; i < nr; i++) {
> -		if (addresses_equal(&addrs[i], addr, addr->port))
> +		if (mptcp_addresses_equal(&addrs[i], addr, addr->port))
>  			return true;
>  	}
>  
> @@ -457,7 +457,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
>  		mptcp_for_each_subflow(msk, subflow) {
>  			ssk = mptcp_subflow_tcp_sock(subflow);
>  			remote_address((struct sock_common *)ssk, &addrs[i]);
> -			if (deny_id0 && addresses_equal(&addrs[i], &remote, false))
> +			if (deny_id0 && mptcp_addresses_equal(&addrs[i], &remote, false))
>  				continue;
>  
>  			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
> @@ -490,7 +490,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
>  	struct mptcp_pm_addr_entry *entry;
>  
>  	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if ((!lookup_by_id && addresses_equal(&entry->addr, info, true)) ||
> +		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
>  		    (lookup_by_id && entry->addr.id == info->id))
>  			return entry;
>  	}
> @@ -505,7 +505,7 @@ lookup_id_by_addr(const struct pm_nl_pernet *pernet, const struct mptcp_addr_inf
>  
>  	rcu_read_lock();
>  	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if (addresses_equal(&entry->addr, addr, entry->addr.port)) {
> +		if (mptcp_addresses_equal(&entry->addr, addr, entry->addr.port)) {
>  			ret = entry->addr.id;
>  			break;
>  		}
> @@ -739,7 +739,7 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>  		struct mptcp_addr_info local;
>  
>  		local_address((struct sock_common *)ssk, &local);
> -		if (!addresses_equal(&local, addr, addr->port))
> +		if (!mptcp_addresses_equal(&local, addr, addr->port))
>  			continue;
>  
>  		if (subflow->backup != bkup)
> @@ -909,9 +909,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>  	 * singled addresses
>  	 */
>  	list_for_each_entry(cur, &pernet->local_addr_list, list) {
> -		if (addresses_equal(&cur->addr, &entry->addr,
> -				    address_use_port(entry) &&
> -				    address_use_port(cur))) {
> +		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
> +					  address_use_port(entry) &&
> +					  address_use_port(cur))) {
>  			/* allow replacing the exiting endpoint only if such
>  			 * endpoint is an implicit one and the user-space
>  			 * did not provide an endpoint id
> @@ -1038,14 +1038,14 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  	 */
>  	local_address((struct sock_common *)msk, &msk_local);
>  	local_address((struct sock_common *)skc, &skc_local);
> -	if (addresses_equal(&msk_local, &skc_local, false))
> +	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
>  		return 0;
>  
>  	pernet = pm_nl_get_pernet_from_msk(msk);
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> -		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
> +		if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
>  			ret = entry->addr.id;
>  			break;
>  		}
> @@ -1416,7 +1416,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
>  			goto next;
>  
>  		local_address((struct sock_common *)msk, &msk_local);
> -		if (!addresses_equal(&msk_local, addr, addr->port))
> +		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
>  			goto next;
>  
>  		lock_sock(sk);
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> new file mode 100644
> index 000000000000..c50f8900ffba
> --- /dev/null
> +++ b/net/mptcp/pm_userspace.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Multipath TCP
> + *
> + * Copyright (c) 2022, Intel Corporation.
> + */
> +
> +#include "protocol.h"
> +
> +void mptcp_free_local_addr_list(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +	struct sock *sk = (struct sock *)msk;
> +	LIST_HEAD(free_list);
> +
> +	if (!mptcp_pm_is_userspace(msk))
> +		return;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	list_for_each_entry_safe(entry, tmp, &free_list, list) {
> +		sock_kfree_s(sk, entry, sizeof(*entry));
> +	}
> +}
> +
> +int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> +					     struct mptcp_pm_addr_entry *entry)
> +{
> +	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> +	struct mptcp_pm_addr_entry *match = NULL;
> +	struct sock *sk = (struct sock *)msk;
> +	struct mptcp_pm_addr_entry *e;
> +	bool addr_match = false;
> +	bool id_match = false;
> +	int ret = -EINVAL;
> +
> +	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
> +		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
> +		if (addr_match && entry->addr.id == 0)
> +			entry->addr.id = e->addr.id;

Is this condition reachable? Which code path use it? AFAICS the later
patches require the user-space PM to always set the local address ID -
which is IMHO correct: the address <> ID association should be up to
the user-space.

So basically this enforces no dup IDs usage, right? (Which again IMHO
should be up to the user-space). If so I would simply avoid all this
code.

Anyhow this has been pending for a lot of time; I do not mean to block
the series, I guess we can later modify this section without impacting
the user-space APIs.

/P

