Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AD16DEA8
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661283; cv=none; b=DooeL7OlH9VWdxoAUou7sUgrZu8I5oEwQhJFmYRU/7Os0l5GL69cM0zWahFpCOy+Yipv2Vgt8ZOzFxgYxKEkLbqsY+svyzz8jJzFEMnJ8CMDg4xnGLki2SOYsgmbbJ3K0iz3EOCg7v8BwpakBDajBQcVvVu3bLNxipQeV0IcrCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661283; c=relaxed/simple;
	bh=fJl+rK3WD7OLLxxddv/MduBoht2PYUTc+QnomWsGmGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TGugEi+zYIZvcF8voGiPLN6kuwYmIPCGzXjmG8DwvRYuFOxiPjdj4UdF6802ZvMZIIA7Y7woInOKGJhWfrlDIZ9CScp2UOoHZAXggISLjzV86nqDpMCvuJUEMUNTfxRtJrN50XFuHHLcwkXW7DT2YFzzDMbe3/HbktsX6SuwPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBcIE+HF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBcIE+HF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721661280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKYcddLpuDDmeW1Pt7jsiOvEL2ztc1MH53N2A1a7BfI=;
	b=DBcIE+HFRXAqdIqHSrMOdhfF1mp6OADk7CvKQLkV/QU1ZLeabo0Dr1WxVNQsvuHRmJEXeE
	l9RlVRxmiHSQEAmVvEj/W1+Io05f+bwNGTPbCw/7+ktxd7KVFEQtcNF+1scS8yDW8vt3aA
	aYw2iKAEwtC+XfRhBxw1buQNBigeVc0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-AiIUCkW8NvGzQtLOSnArrg-1; Mon, 22 Jul 2024 11:14:39 -0400
X-MC-Unique: AiIUCkW8NvGzQtLOSnArrg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a281e55710so486783a12.1
        for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 08:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721661277; x=1722266077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKYcddLpuDDmeW1Pt7jsiOvEL2ztc1MH53N2A1a7BfI=;
        b=aytfIlqhYjELHdGxOMkkVN5Kd3ooJrh7wOHj9n2wyaFY7mQc05mPneb6xhDrG5qvFP
         Cd4AQh7SxhZ4l6ja06Y4aaR3ZkheXr+56eAllFXcLSiCGZlLNnjGnu1LQuVRe5IE6Sa9
         L6wFJEdN8f30RvgpF3dsUsUyn396lBsFYIpakinvfOYgq3V+6oFs63Y8p1c5lxO2BtqU
         HkMH6G/KLIevnNkrYsWAnDTyKDgH6LYVrTwjH5Di5kGU3hvjTVkZ7K0Wx7097hRwWC0s
         y9T5I1Z/+i5kT20w/1bd04jKGi7AZQ3biXXAdLYSKs9AVupqPyUmjpZ2BMBs/uSdBJP+
         Q7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWOXjQr9/pl6WcR5PlLuu/krnqhitZBgdGVJUl2YVWDF+ACOJsaC9xuI8TAMMR0Afl8fZHzDIkE/ouYccJmoYi1XVEZSWw=
X-Gm-Message-State: AOJu0YzlnL7HeAjZyW9eHw5b63cvJV1pQVHFQ95hxonja1HQLqJVnFPs
	9hk9SzKjQxcMkoUd3WPGhfALW0Yyeoo5NvMkpKgPuzA77RdbKsTPzrNcT5MLQGTBxewo2T7AO7x
	oUAR+YjMFfXgKLfb1gf7zPchRaC0sAaGF96Ct4h03qMU0Mirk8Pc1QPHlf5IT
X-Received: by 2002:a17:907:97d0:b0:a6f:186d:9e9f with SMTP id a640c23a62f3a-a7a4205f969mr361106866b.5.1721661276866;
        Mon, 22 Jul 2024 08:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqTLhQHRVfkr4L1+tqSxzfw++zHTd2VXVpeyUklupCqp498hO6wYBwVaoyps24vRD9VJvZFA==
X-Received: by 2002:a17:907:97d0:b0:a6f:186d:9e9f with SMTP id a640c23a62f3a-a7a4205f969mr361105766b.5.1721661276369;
        Mon, 22 Jul 2024 08:14:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b093:b610::f71? ([2a0d:3341:b093:b610::f71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c92225esm434292166b.167.2024.07.22.08.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 08:14:35 -0700 (PDT)
Message-ID: <45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com>
Date: Mon, 22 Jul 2024 17:14:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] mptcp: pm: reduce entries iterations on
 connect
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20240719-mptcp-pm-refact-connect-v1-1-1027d648a65f@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240719-mptcp-pm-refact-connect-v1-1-1027d648a65f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/24 16:26, Matthieu Baerts (NGI0) wrote:
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 1b0e1617e90a..9fed7c92e52b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -633,8 +633,9 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
>    */
>   static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>   					     struct mptcp_addr_info *remote,
> -					     struct mptcp_addr_info *addrs)
> +					     struct mptcp_pm_addr_entry *entries)
>   {
> +	struct mptcp_pm_addr_entry new_entry;
>   	struct sock *sk = (struct sock *)msk;
>   	struct mptcp_pm_addr_entry *entry;
>   	struct mptcp_addr_info mpc_addr;
> @@ -655,14 +656,14 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>   			continue;
>   
>   		if (msk->pm.subflows < subflows_max) {
> -			msk->pm.subflows++;
> -			addrs[i] = entry->addr;
> +			memcpy(&new_entry, entry, sizeof(new_entry));
>   
>   			/* Special case for ID0: set the correct endpoint */
>   			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
> -				addrs[i].id = 0;
> +				new_entry.addr.id = 0;
>   
> -			i++;
> +			msk->pm.subflows++;
> +			entries[i++] = new_entry;

'new_entry' is escaping the rcu protected section, dereferencing 
'entries' after the rcu unlock below could cause UaF.

Note, AFAICS we already have a similar problem in select_local_address().

One possibility would be to do a deep copy of mptcp_pm_addr_entry, but 
that will waste a lot of memory on the stack. What about to copy the id 
separately?

Thanks,

Paolo


>   		}
>   	}
>   	rcu_read_unlock();
> @@ -671,21 +672,19 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>   	 * 'IPADDRANY' local address
>   	 */
>   	if (!i) {
> -		struct mptcp_addr_info local;
> -
> -		memset(&local, 0, sizeof(local));
> -		local.family =
> +		memset(&new_entry.addr, 0, sizeof(new_entry.addr));
> +		new_entry.addr.family =
>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>   			       remote->family == AF_INET6 &&
>   			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
>   #endif
>   			       remote->family;
>   
> -		if (!mptcp_pm_addr_families_match(sk, &local, remote))
> +		if (!mptcp_pm_addr_families_match(sk, &new_entry.addr, remote))
>   			return 0;
>   
>   		msk->pm.subflows++;
> -		addrs[i++] = local;
> +		entries[i++] = new_entry;
>   	}
>   
>   	return i;
> @@ -693,7 +692,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>   
>   static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>   {
> -	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
> +	struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
>   	struct sock *sk = (struct sock *)msk;
>   	unsigned int add_addr_accept_max;
>   	struct mptcp_addr_info remote;
> @@ -722,13 +721,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>   	/* connect to the specified remote address, using whatever
>   	 * local address the routing configuration will pick.
>   	 */
> -	nr = fill_local_addresses_vec(msk, &remote, addrs);
> +	nr = fill_local_addresses_vec(msk, &remote, entries);
>   	if (nr == 0)
>   		return;
>   
>   	spin_unlock_bh(&msk->pm.lock);
>   	for (i = 0; i < nr; i++)
> -		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
> +		if (__mptcp_subflow_connect(sk, &entries[i], &remote) == 0)
>   			sf_created = true;
>   	spin_lock_bh(&msk->pm.lock);
>   
> @@ -1379,28 +1378,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
>   	return ret;
>   }
>   
> -int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> -					    u8 *flags, int *ifindex)
> -{
> -	struct mptcp_pm_addr_entry *entry;
> -	struct sock *sk = (struct sock *)msk;
> -	struct net *net = sock_net(sk);
> -
> -	/* No entries with ID 0 */
> -	if (id == 0)
> -		return 0;
> -
> -	rcu_read_lock();
> -	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
> -	if (entry) {
> -		*flags = entry->flags;
> -		*ifindex = entry->ifindex;
> -	}
> -	rcu_read_unlock();
> -
> -	return 0;
> -}
> -
>   static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
>   				      const struct mptcp_addr_info *addr)
>   {
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index f0a4590506c6..97b09dffff6d 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -119,23 +119,6 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
>   	return NULL;
>   }
>   
> -int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> -						   unsigned int id,
> -						   u8 *flags, int *ifindex)
> -{
> -	struct mptcp_pm_addr_entry *match;
> -
> -	spin_lock_bh(&msk->pm.lock);
> -	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
> -	spin_unlock_bh(&msk->pm.lock);
> -	if (match) {
> -		*flags = match->flags;
> -		*ifindex = match->ifindex;
> -	}
> -
> -	return 0;
> -}
> -
>   int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
>   				    struct mptcp_addr_info *skc)
>   {
> @@ -394,7 +377,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	lock_sock(sk);
>   
> -	err = __mptcp_subflow_connect(sk, &local.addr, &addr_r);
> +	err = __mptcp_subflow_connect(sk, &local, &addr_r);
>   
>   	release_sock(sk);
>   
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f2eb5273d752..259e247b0862 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -722,7 +722,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
>   void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
>   
>   /* called with sk socket lock held */
> -int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> +int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
>   			    const struct mptcp_addr_info *remote);
>   int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>   				struct socket **new_sock);
> @@ -1015,14 +1015,6 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>   struct mptcp_pm_add_entry *
>   mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
>   				const struct mptcp_addr_info *addr);
> -int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> -					 unsigned int id,
> -					 u8 *flags, int *ifindex);
> -int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> -					    u8 *flags, int *ifindex);
> -int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> -						   unsigned int id,
> -						   u8 *flags, int *ifindex);
>   int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
>   int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
>   int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 39e2cbdf3801..0835e71118b9 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1544,26 +1544,24 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
>   #endif
>   }
>   
> -int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> +int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
>   			    const struct mptcp_addr_info *remote)
>   {
>   	struct mptcp_sock *msk = mptcp_sk(sk);
>   	struct mptcp_subflow_context *subflow;
> +	int local_id = local->addr.id;
>   	struct sockaddr_storage addr;
>   	int remote_id = remote->id;
> -	int local_id = loc->id;
>   	int err = -ENOTCONN;
>   	struct socket *sf;
>   	struct sock *ssk;
>   	u32 remote_token;
>   	int addrlen;
> -	int ifindex;
> -	u8 flags;
>   
>   	if (!mptcp_is_fully_established(sk))
>   		goto err_out;
>   
> -	err = mptcp_subflow_create_socket(sk, loc->family, &sf);
> +	err = mptcp_subflow_create_socket(sk, local->addr.family, &sf);
>   	if (err)
>   		goto err_out;
>   
> @@ -1573,23 +1571,32 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>   		get_random_bytes(&subflow->local_nonce, sizeof(u32));
>   	} while (!subflow->local_nonce);
>   
> -	if (local_id)
> +	/* if 'IPADDRANY', the ID will be set later, after the routing */
> +	if (local->addr.family == AF_INET) {
> +		if (!local->addr.addr.s_addr)
> +			local_id = -1;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	} else if (sk->sk_family == AF_INET6) {
> +		if (ipv6_addr_any(&local->addr.addr6))
> +			local_id = -1;
> +#endif
> +	}
> +
> +	if (local_id >= 0)
>   		subflow_set_local_id(subflow, local_id);
>   
> -	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
> -					     &flags, &ifindex);
>   	subflow->remote_key_valid = 1;
>   	subflow->remote_key = READ_ONCE(msk->remote_key);
>   	subflow->local_key = READ_ONCE(msk->local_key);
>   	subflow->token = msk->token;
> -	mptcp_info2sockaddr(loc, &addr, ssk->sk_family);
> +	mptcp_info2sockaddr(&local->addr, &addr, ssk->sk_family);
>   
>   	addrlen = sizeof(struct sockaddr_in);
>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>   	if (addr.ss_family == AF_INET6)
>   		addrlen = sizeof(struct sockaddr_in6);
>   #endif
> -	ssk->sk_bound_dev_if = ifindex;
> +	ssk->sk_bound_dev_if = local->ifindex;
>   	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
>   	if (err)
>   		goto failed;
> @@ -1600,7 +1607,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>   	subflow->remote_token = remote_token;
>   	WRITE_ONCE(subflow->remote_id, remote_id);
>   	subflow->request_join = 1;
> -	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +	subflow->request_bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>   	subflow->subflow_id = msk->subflow_id++;
>   	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
>   
> 
> ---
> base-commit: 52d9822897dc3649af506ed28135dedf9cf8ba3f
> change-id: 20240719-mptcp-pm-refact-connect-20050690bdbc
> prerequisite-change-id: 20240620-mptcp-pm-avail-f5e3957be441:v3
> prerequisite-patch-id: a804d4bf78954addfee863b9ae1b19ea01a7103f
> prerequisite-patch-id: 1cbde162f714bd28430c4985fb701762e536021c
> prerequisite-patch-id: 1cef710d16564a7f101184bbe9aaf1bb09d82743
> prerequisite-patch-id: d05eb1ef921bac68264c994daced70f46e707868
> prerequisite-patch-id: b7f76b3d50c14f862433d170fd48c30076da649b
> prerequisite-patch-id: f1e8aab49982c3de4092b9940d5dca1586dabf7f
> prerequisite-patch-id: 8ba292b3b2b681ba08dbfe22470ca01b9100c0f1
> prerequisite-patch-id: 6b45b393a5341c38a1ebbdeb212989c7e53de3bb
> prerequisite-patch-id: e5a410260d84101e6d099487545da0c9f19ff9d7
> prerequisite-patch-id: 593236babe3ceb10d682f8a8e8acc8b095e98b58
> prerequisite-patch-id: 7b94591f5d92cd183b3713f360eb29ca72d3c129
> prerequisite-patch-id: 07ddff8eebd1cfc9db306546307eae5157451ded
> prerequisite-patch-id: 55cc1b1f59a365757e4f0d23292479d4d12f1534
> prerequisite-patch-id: c6ba8859f84b0b726cdf57fa5ebcbf83d82f949b
> prerequisite-patch-id: a40ab15bd28a982b57f7bbc66564086a79e77070
> prerequisite-patch-id: 2988a4bcdb5a53ef659c15924a3cbfc6888b55ac
> prerequisite-patch-id: a5ea2de5eeaf719483e2fa7977afd94ba5fe507d
> prerequisite-patch-id: 9b37053038fcb0e952f21cb39389e7446e11b02a
> prerequisite-patch-id: 36b922942e9510b19c0c45646307c433049c756a
> prerequisite-patch-id: a565fd838caf63e4474de807b04b7fcde2acdb62
> 
> Best regards,

