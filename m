Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755436A
	for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647859988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A6imOIF7juc/kUiAko2FyIQFIU4X9lN1VsL9pw7I2w=;
	b=J/DiNfNe2SMO3KuL/K07NCnj1bYYTEk3TcgrPnFAC+WgV056IBeD5rk/BfgZTlnG4+Z+64
	2yef+BkJG9OoJ5B1sKjtyF6gw4oCjhQHqVaeycfcpw6hojELlIr+nvJpTmV86i0V4Zthkk
	mecXhW3wHn9KpVONsOeykq4XCLK7b6s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-9HNaLCzaN9aZl3IUQHK73w-1; Mon, 21 Mar 2022 06:53:05 -0400
X-MC-Unique: 9HNaLCzaN9aZl3IUQHK73w-1
Received: by mail-qk1-f197.google.com with SMTP id y140-20020a376492000000b0067b14129a63so9516224qkb.9
        for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 03:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1A6imOIF7juc/kUiAko2FyIQFIU4X9lN1VsL9pw7I2w=;
        b=NLv6bbdf/IUUuzbH89mUpDKVRKsF9QdmSE/qumoFvttu/CcBf0xaCl4uhtyjOZTY9T
         wE5IAULW3TiOynr3TPWX7fQCUUQA1hM7xbbOwN8E1lTNqdcqguQ8OdWCWLoc/zHxW5OR
         hCk4rJ6D2RNvkALn0Nfhw76fjPTqK33/J4mdSYmXHtSaNHirRcO4sB/0xpcf07B87Otg
         6agaIDD76++GYDt2DFligHHR33iJ1hVLxFZeNoF/q1SIeuXJn5hF3njxCsJg0jGFJn8Q
         a3tknhhs9nPIM0J5gifeqPZ33bGkO2Stn1fhhJelOCBGHJSAcksrcQHk7LuOmBdCVx1K
         cuGA==
X-Gm-Message-State: AOAM5319xChSKttwQWVXx7gWMxpyWAB0NUwrpKpqvDiy7Pj1DXeX2FpV
	nLxJtEx7ovf/J1H0fMv9xPKp8Qz22p5nUvBa3OErd2fenWx7yGHvjy80HJsWYsbRX4EeoYHLYxU
	hUXfdO4MTtVaGg+w=
X-Received: by 2002:a05:6214:29ca:b0:441:1f8c:e58d with SMTP id gh10-20020a05621429ca00b004411f8ce58dmr3759754qvb.111.1647859984621;
        Mon, 21 Mar 2022 03:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLKeCzuV3edUw8vbJv+Bsl1iLJX8hPBFlvWEbB/JJeqtqTC8h0f4t1+2mMzB9eT9s1K3SzYw==
X-Received: by 2002:a05:6214:29ca:b0:441:1f8c:e58d with SMTP id gh10-20020a05621429ca00b004411f8ce58dmr3759740qvb.111.1647859984284;
        Mon, 21 Mar 2022 03:53:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b002e02be9c0easm10667666qts.69.2022.03.21.03.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 03:53:03 -0700 (PDT)
Message-ID: <820d78dda48eb1ddc37485826af946505b22c605.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 02/14] mptcp: handle local addrs announced
 by userspace PMs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Mon, 21 Mar 2022 11:53:01 +0100
In-Reply-To: <20220316231636.645625-3-kishen.maloor@intel.com>
References: <20220316231636.645625-1-kishen.maloor@intel.com>
	 <20220316231636.645625-3-kishen.maloor@intel.com>
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

On Wed, 2022-03-16 at 19:16 -0400, Kishen Maloor wrote:
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
>  net/mptcp/pm_netlink.c | 72 ++++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c   |  2 ++
>  net/mptcp/protocol.h   |  2 ++
>  3 files changed, 76 insertions(+)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 98e59576415b..d8825bf580b7 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -390,6 +390,24 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  	return true;
>  }
>  
> +void mptcp_free_local_addr_list(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +	struct sock *sk = (struct sock *)msk;
> +	LIST_HEAD(free_list);
> +
> +	if (!mptcp_pm_is_userspace(msk))
> +		return;
> +
> +	mptcp_data_lock(sk);
> +	list_splice_init(&msk->local_addr_list, &free_list);
> +	mptcp_data_unlock(sk);

Why are you using the mptcp data lock here ? I think that is subject to
lockdep issues. Likely the pm spinlock is a more suitable lock.

> +
> +	list_for_each_entry_safe(entry, tmp, &free_list, list) {
> +		sock_kfree_s(sk, entry, sizeof(*entry));
> +	}
> +}
> +
>  void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>  {
>  	struct mptcp_pm_add_entry *entry, *tmp;
> @@ -878,6 +896,60 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
>  	kfree(entry);
>  }
>  
> +static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> +						    struct mptcp_pm_addr_entry *entry)
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
> +	mptcp_data_lock(sk);
> +	list_for_each_entry(e, &msk->local_addr_list, list) {
> +		addr_match = addresses_equal(&e->addr, &entry->addr, true);
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
> +			mptcp_data_unlock(sk);
> +			return -ENOMEM;
> +		}
> +
> +		*e = *entry;
> +		if (!e->addr.id)
> +			e->addr.id = find_next_zero_bit(id_bitmap,
> +							MPTCP_PM_MAX_ADDR_ID + 1,
> +							1);
> +		list_add_tail_rcu(&e->list, &msk->local_addr_list);
> +		ret = e->addr.id;
> +	} else if (match) {
> +		ret = entry->addr.id;
> +	}
> +
> +	mptcp_data_unlock(sk);

After "mptcp: introduce implicit endpoints", the above mimics very
closely what mptcp_pm_nl_get_local_id() is already doing for the in
kernel path manager, with the main differences that it avoid the hard
MPTCP_PM_ADDR_MAX limit.

Perhaps we can re-use the same code? e.g. enforcing the
MPTCP_PM_ADDR_MAX only for the in-kernel path manager, or possibly
retaining such constraint even for the user-space one?

/P

