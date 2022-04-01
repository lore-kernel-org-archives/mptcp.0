Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F0C7B
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1648824201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQoJKsPXJhFjtm6OZ87Yy+eTT+sSdj8WPrwoz+MtSd4=;
	b=afpUgC0xM20S+8J9uWg8txr3w80JWNLbgpKbgWh5HPB8L9b957YPjr87Cc8qFUfFEd0jkv
	K3aVXG4EVFwvJK/chep7UOgf+M8HmN+mEHxLy5vLd3Ke+WfohZdBoH/9OUm47J/x3qs7Pl
	ipsxeoYotchQ32YwnAansoyUe0R1WaQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-f-seCn9BOWmzY2ZEE3P0GA-1; Fri, 01 Apr 2022 10:43:20 -0400
X-MC-Unique: f-seCn9BOWmzY2ZEE3P0GA-1
Received: by mail-wm1-f69.google.com with SMTP id 12-20020a05600c24cc00b0038c6caa95f7so1227942wmu.4
        for <mptcp@lists.linux.dev>; Fri, 01 Apr 2022 07:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QQoJKsPXJhFjtm6OZ87Yy+eTT+sSdj8WPrwoz+MtSd4=;
        b=h5eMBFSw7xl8lv9L5dQYEKwWJpQu0w539qRnOMv2gAAjxM8jT5WnTFxTTnFh+YyGJI
         JTbrYLqTExTFA3hKhMX3tBVBVwaqWY2Y/jix+/zDH/I8bGZGuJINEeI2oKWZ1eya4y18
         tJXGTJ3oAhYYAAHifx0a/vUY9FDMcmioNJb2LwHY75rbaN3/QOPDwcgdOM94cEvkiNDC
         epwY+/8TC6hssU6gjMB/4wZpNYMMgKBC/wfARw9HhwD07qfnqlUcR0Fglh4yc4O6h7H6
         dlpYv/BKDN7MUidLZE5nlaO6DDVBGeEEiF3g44uK8Dt05mUIGN+nCxLXbOoIr0KIlC4X
         7wXA==
X-Gm-Message-State: AOAM531+ToypHuczMRhP4rJ3Kthe7SkgbxZ5dOvQJw9AycYqkww6+PUM
	4dPwdXnPx93BuJvnwIFIyj8ECKuAk4Q3IM1m0ofN8wJzdnIBYiv0WxaG7kc0yVjOBNHanZ6FVNd
	Nf2lJhDADAeeapkI=
X-Received: by 2002:a5d:50c9:0:b0:205:b813:daa8 with SMTP id f9-20020a5d50c9000000b00205b813daa8mr8091093wrt.35.1648824198068;
        Fri, 01 Apr 2022 07:43:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuftgWOEvHeNffodo9nR3RdEJ0q6vYiZwbKXuNvutzPvACdZwV0kee4hjvsGeRKidFrA9pow==
X-Received: by 2002:a5d:50c9:0:b0:205:b813:daa8 with SMTP id f9-20020a5d50c9000000b00205b813daa8mr8091071wrt.35.1648824197655;
        Fri, 01 Apr 2022 07:43:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-142.dyn.eolo.it. [146.241.243.142])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0038cbcbcf994sm2072883wmq.36.2022.04.01.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:43:16 -0700 (PDT)
Message-ID: <38f029432d4e83aa39d8730af3a6a7a3b80df232.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v6 02/14] mptcp: handle local addrs announced
 by userspace PMs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 01 Apr 2022 16:43:10 +0200
In-Reply-To: <20220329021437.1196552-3-kishen.maloor@intel.com>
References: <20220329021437.1196552-1-kishen.maloor@intel.com>
	 <20220329021437.1196552-3-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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

On Mon, 2022-03-28 at 22:14 -0400, Kishen Maloor wrote:
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
> ---
>  net/mptcp/Makefile       |  2 +-
>  net/mptcp/pm.c           |  1 +
>  net/mptcp/pm_netlink.c   | 34 +++++++++---------
>  net/mptcp/pm_userspace.c | 74 ++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c     |  1 +
>  net/mptcp/protocol.h     |  7 ++++
>  6 files changed, 101 insertions(+), 18 deletions(-)
>  create mode 100644 net/mptcp/pm_userspace.c
> 
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index e54daceac58b..cb7f53f6ab22 100644
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
> index 8d04c8d8a8df..836f6df9f744 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -55,8 +55,8 @@ struct pm_nl_pernet {
>  #define MPTCP_PM_ADDR_MAX	8
>  #define ADD_ADDR_RETRANS_MAX	3
>  
> -static bool addresses_equal(const struct mptcp_addr_info *a,
> -			    const struct mptcp_addr_info *b, bool use_port)
> +bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
> +			   const struct mptcp_addr_info *b, bool use_port)
>  {
>  	bool addr_equals = false;
>  
> @@ -120,7 +120,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
>  		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>  
>  		local_address(skc, &cur);
> -		if (addresses_equal(&cur, saddr, saddr->port))
> +		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
>  			return true;
>  	}
>  
> @@ -138,7 +138,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
>  		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>  
>  		remote_address(skc, &cur);
> -		if (addresses_equal(&cur, daddr, daddr->port))
> +		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
>  			return true;
>  	}
>  
> @@ -262,7 +262,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
>  	lockdep_assert_held(&msk->pm.lock);
>  
>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> -		if (addresses_equal(&entry->addr, addr, true))
> +		if (mptcp_addresses_equal(&entry->addr, addr, true))
>  			return entry;
>  	}
>  
> @@ -279,7 +279,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
>  
>  	spin_lock_bh(&msk->pm.lock);
>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> -		if (addresses_equal(&entry->addr, &saddr, true)) {
> +		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
>  			ret = true;
>  			goto out;
>  		}
> @@ -414,7 +414,7 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
>  	int i;
>  
>  	for (i = 0; i < nr; i++) {
> -		if (addresses_equal(&addrs[i], addr, addr->port))
> +		if (mptcp_addresses_equal(&addrs[i], addr, addr->port))
>  			return true;
>  	}
>  
> @@ -450,7 +450,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
>  		mptcp_for_each_subflow(msk, subflow) {
>  			ssk = mptcp_subflow_tcp_sock(subflow);
>  			remote_address((struct sock_common *)ssk, &addrs[i]);
> -			if (deny_id0 && addresses_equal(&addrs[i], &remote, false))
> +			if (deny_id0 && mptcp_addresses_equal(&addrs[i], &remote, false))
>  				continue;
>  
>  			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
> @@ -483,7 +483,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
>  	struct mptcp_pm_addr_entry *entry;
>  
>  	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if ((!lookup_by_id && addresses_equal(&entry->addr, info, true)) ||
> +		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
>  		    (lookup_by_id && entry->addr.id == info->id))
>  			return entry;
>  	}
> @@ -498,7 +498,7 @@ lookup_id_by_addr(const struct pm_nl_pernet *pernet, const struct mptcp_addr_inf
>  
>  	rcu_read_lock();
>  	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if (addresses_equal(&entry->addr, addr, entry->addr.port)) {
> +		if (mptcp_addresses_equal(&entry->addr, addr, entry->addr.port)) {
>  			ret = entry->addr.id;
>  			break;
>  		}
> @@ -732,7 +732,7 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>  		struct mptcp_addr_info local;
>  
>  		local_address((struct sock_common *)ssk, &local);
> -		if (!addresses_equal(&local, addr, addr->port))
> +		if (!mptcp_addresses_equal(&local, addr, addr->port))
>  			continue;
>  
>  		if (subflow->backup != bkup)
> @@ -902,9 +902,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
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
> @@ -1031,14 +1031,14 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  	 */
>  	local_address((struct sock_common *)msk, &msk_local);
>  	local_address((struct sock_common *)skc, &skc_local);
> -	if (addresses_equal(&msk_local, &skc_local, false))
> +	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
>  		return 0;
>  
>  	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> -		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
> +		if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
>  			ret = entry->addr.id;
>  			break;
>  		}
> @@ -1409,7 +1409,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
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
> index 000000000000..cb8321cdb4ea
> --- /dev/null
> +++ b/net/mptcp/pm_userspace.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +		id_match = (e->addr.id == entry->addr.id);
> +		if (addr_match && id_match) {
> +			match = e;
> +			break;
> +		} else if (addr_match || id_match) {
> +			break;
> +		}
> +		__set_bit(e->addr.id, id_bitmap);
> +	}
> +
> +	if (!match && !addr_match && !id_match) {
> +		/* Memory for the entry is allocated from the
> +		 * sock option buffer.
> +		 */
> +		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
> +		if (!e) {
> +			spin_unlock_bh(&msk->pm.lock);
> +			return -ENOMEM;
> +		}
> +
> +		*e = *entry;
> +		if (!e->addr.id)
> +			e->addr.id = find_next_zero_bit(id_bitmap,
> +							MPTCP_PM_MAX_ADDR_ID + 1,
> +							1);
> +		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
> +		ret = e->addr.id;
> +	} else if (match) {
> +		ret = entry->addr.id;
> +	}
> +
> +	spin_unlock_bh(&msk->pm.lock);
> +	return ret;
> +}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b2c654992de0..b016822f44dc 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3103,6 +3103,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
>  	msk->rmem_fwd_alloc = 0;
>  	mptcp_token_destroy(msk);
>  	mptcp_pm_free_anno_list(msk);
> +	mptcp_free_local_addr_list(msk);
>  }
>  
>  static void mptcp_destroy(struct sock *sk)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 187c932deef0..40dabf9462a8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -208,6 +208,7 @@ struct mptcp_pm_data {
>  	struct mptcp_addr_info local;
>  	struct mptcp_addr_info remote;
>  	struct list_head anno_list;
> +	struct list_head userspace_pm_local_addr_list;

It looks like anno_list is never used when the user-space PM is enabled
- and userspace_pm_local_addr_list is never used by the NL PM.

What about reusing the same, single field? Ev. using an union, but not
strictly needed, since in both case this contains addresses [to be]
announced, right?

I really think we should avoid adding more data to the msk struct for
user-space PM consumption only, it's really counterintuitive.

Thanks

Paolo

