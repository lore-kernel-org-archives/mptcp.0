Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E34168
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642175652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iWw28C12chyUT7SrUY7qYWzf8xa081PPyc6arVqYgU=;
	b=hN90Q14HRK/UEiTjlWIPO5KKqdJbVMefOM8OB7dN4yYykgikvHX9qEdD9itv24cPInTvvc
	WcIgYH6BMrR+HOAZx3qhe0K70b81BhGuFfNNDg2BxmkHZeVACg0EiAwrBfAIpbCjukjVgz
	oKmz7jw1GZ8qoQIXhSao0Ibcqwo51Mk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-FYRPBKpENCK9B1g-Jsyqvg-1; Fri, 14 Jan 2022 10:54:08 -0500
X-MC-Unique: FYRPBKpENCK9B1g-Jsyqvg-1
Received: by mail-qk1-f199.google.com with SMTP id w8-20020a05620a148800b004798ef3e7d6so3877340qkj.11
        for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 07:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4iWw28C12chyUT7SrUY7qYWzf8xa081PPyc6arVqYgU=;
        b=A9a6wYfiWX4OcIco+UMv7hK8WKLJiEI7Bt6Z0xEeLBlPkYfGOaHxY65okorY4V3jq0
         QjXEC7+/oozfy/yJxgHm0602ZbNpQUi/pn7szB0DjPBXe/OLZskeMGTnE+bZkpdxXjSE
         wT0hhjJKvEXwqhzL2xaM/Jq77DdTfllSVW5QthBdFw8cJ5rzADVs+VydKdwPTtV7OJTY
         Y5HVqWc10Tu35yWCCSAubnCrN/FxRr4sz9wURv73WZ1pipzL9WIcOzgXoK7cgXmN47Nk
         2HF2CZE1tMrYfplRzkLFpo/6d5ElG5qt1AhrYWpE+ZiEyLw1db/eOyFMbUX52Uu84/jN
         fPsA==
X-Gm-Message-State: AOAM533MP16yEn7TcWVvXnAxa3w+s7oRUpSv+XvHA64RkNVnvjLkaueB
	6WhfkviL53q6O7EvCyZcv2Q1F21D3uxM2ZERXlcQC8H9bvd9C1o0JGHG9JYY9zVh1jjkiRNyclB
	0ly7DnYexuIbmruk=
X-Received: by 2002:a05:6214:f05:: with SMTP id gw5mr8675075qvb.38.1642175647578;
        Fri, 14 Jan 2022 07:54:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhuzJkYp+5p0qTaRVXBZWgdLUaorM1ZbR6ssoT/i1bkp1+Hj0surA5ydTiERMfzHFvu7EiOg==
X-Received: by 2002:a05:6214:f05:: with SMTP id gw5mr8675062qvb.38.1642175647291;
        Fri, 14 Jan 2022 07:54:07 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id c11sm4023359qtb.8.2022.01.14.07.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:54:06 -0800 (PST)
Message-ID: <c187fa2042e25cdc85aff2dd6687781b2511d86a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 08/21] mptcp: attempt to add listening
 sockets for announced addrs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 14 Jan 2022 16:54:03 +0100
In-Reply-To: <20220112221523.1829397-9-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
	 <20220112221523.1829397-9-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

Hello,

On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
> When ADD_ADDR announcements use the port associated with an
> active subflow, this change ensures that a listening socket is
> bound to the announced address and port for subsequently
> receiving MP_JOINs from the remote end. In case there's
> a recorded lsk bound to that address+port, it is reused.
> But if a listening socket for this address is already held by the
> application then no further action is taken.
> 
> When a listening socket is created, it is stored in
> struct mptcp_pm_add_entry and released accordingly.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
> 
> v2: fixed formatting
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>

should be either:

"""
<changelog>

<tags>
"""

or:

"""
<tags>
---
<changelog>
"""

we usually keep the changelog outside the commit message for
development history before landing on netdev, that is:

"""
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v2: fixed formatting
"""

> ---
>  net/mptcp/pm_netlink.c | 56 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 779ec9d375f0..e2211f3b8c8c 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -43,6 +43,7 @@ struct mptcp_pm_add_entry {
>  	struct mptcp_addr_info	addr;
>  	struct timer_list	add_timer;
>  	struct mptcp_sock	*sock;
> +	struct mptcp_local_lsk	*lsk_ref;
>  	u8			retrans_times;
>  };
>  
> @@ -66,6 +67,10 @@ struct pm_nl_pernet {
>  #define MPTCP_PM_ADDR_MAX	8
>  #define ADD_ADDR_RETRANS_MAX	3
>  
> +static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> +					    struct mptcp_pm_addr_entry *entry,
> +					    struct socket **lsk);
> +
>  static bool addresses_equal(const struct mptcp_addr_info *a,
>  			    const struct mptcp_addr_info *b, bool use_port)
>  {
> @@ -438,7 +443,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  }
>  
>  static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> -				     struct mptcp_pm_addr_entry *entry)
> +				     struct mptcp_pm_addr_entry *entry,
> +				     struct mptcp_local_lsk *lsk_ref)
>  {
>  	struct mptcp_pm_add_entry *add_entry = NULL;
>  	struct sock *sk = (struct sock *)msk;
> @@ -458,6 +464,10 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  	add_entry->addr = entry->addr;
>  	add_entry->sock = msk;
>  	add_entry->retrans_times = 0;
> +	add_entry->lsk_ref = lsk_ref;
> +
> +	if (lsk_ref)
> +		lsk_list_add_ref(lsk_ref);
>  
>  	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
>  	sk_reset_timer(sk, &add_entry->add_timer,
> @@ -470,8 +480,11 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>  {
>  	struct mptcp_pm_add_entry *entry, *tmp;
>  	struct sock *sk = (struct sock *)msk;
> +	struct pm_nl_pernet *pernet;
>  	LIST_HEAD(free_list);
>  
> +	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
> +
>  	pr_debug("msk=%p", msk);
>  
>  	spin_lock_bh(&msk->pm.lock);
> @@ -480,6 +493,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>  
>  	list_for_each_entry_safe(entry, tmp, &free_list, list) {
>  		sk_stop_timer_sync(sk, &entry->add_timer);
> +		if (entry->lsk_ref)
> +			lsk_list_release(pernet, entry->lsk_ref);
>  		kfree(entry);
>  	}
>  }
> @@ -570,13 +585,16 @@ lookup_id_by_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *add
>  }
>  
>  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> +	__must_hold(&msk->pm.lock)
>  {
> +	struct mptcp_local_lsk *lsk_ref = NULL;
>  	struct sock *sk = (struct sock *)msk;
>  	struct mptcp_pm_addr_entry *local;
>  	unsigned int add_addr_signal_max;
>  	unsigned int local_addr_max;
>  	struct pm_nl_pernet *pernet;
>  	unsigned int subflows_max;
> +	struct socket *lsk;
>  
>  	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
>  
> @@ -607,12 +625,39 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  		local = select_signal_address(pernet, msk);
>  
>  		if (local) {
> -			if (mptcp_pm_alloc_anno_list(msk, local)) {
> +			if (!local->addr.port) {
> +				local->addr.port =
> +					((struct inet_sock *)inet_sk
> +					 ((struct sock *)msk))->inet_sport;
> +
> +				lsk_ref = lsk_list_find(pernet, &local->addr);
> +
> +				if (!lsk_ref) {
> +					spin_unlock_bh(&msk->pm.lock);
> +
> +					mptcp_pm_nl_create_listen_socket(sk, local, &lsk);
> +
> +					spin_lock_bh(&msk->pm.lock);
> +
> +					if (lsk)
> +						lsk_ref = lsk_list_add(pernet, &local->addr, lsk);
> +
> +					if (lsk && !lsk_ref)
> +						sock_release(lsk);

Let's suppose an user-space application listen on 2 different address
(A, B) and does:

"""
s1 = socket()
bind(s1, A)
listen(s1)
 // at this point incoming MPTCP connection can be established on s1
 // and ADD_ADDR sub-options could be sent back 

s2 = socket()
bind(s2, B)
listen(s2)
"""

If there is a signal endpoint on B, the above listen can race with the 
mptcp_pm_nl_create_listen_socket() call, leading to hard to track
startup issues for user-space application.

I really think we want at list a configuration option, off by default,
for this feature. Some specific self-test would be a plus.

It will help reviewing, splitting this series in at least 2 chunks:
* pre-reqs up to ~this patch
* user-space PM specific stuff

Side note: it would be nice reducing the level of intentation, e.g.
factoring-out part of the inner code in some helper.

> +				}
> +
> +				local->addr.port = 0;
> +			}
> +
> +			if (mptcp_pm_alloc_anno_list(msk, local, lsk_ref)) {
>  				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
>  				msk->pm.add_addr_signaled++;
>  				mptcp_pm_announce_addr(msk, &local->addr, false);
>  				mptcp_pm_nl_addr_send_ack(msk);
>  			}
> +
> +			if (lsk_ref)
> +				lsk_list_release(pernet, lsk_ref);

Probaly not very relevant, but something alike:

	rcu_read_lock()
	lsk_ref = __lsk_list_find();
	if (lst_ref)
		if (mptcp_pm_alloc_anno_list(...)
	rcu_read_unlock()

would save a pair of possibly contended atomic operations in the common
case.

Thanks!

Paolo

