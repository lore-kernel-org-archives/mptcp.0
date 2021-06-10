Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92172
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623319165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xTMipSr6zv1c5j9K07Z9YYJvhf6naG20CKqECaN144=;
	b=b1gDkVIUR3a0iO4ZLDSBipRggKbjulnm0E6ge0vzHvexOJ5yHZiyTyUHVwvGf2MKMXPdSw
	NUGwCBJcKYGodDEiiRxBzy8nb/hnX/LgWRrKeNXBH/7U/0OFNyx3CBMrmu8C+XBN4b7usK
	L+zarMhqNDWjW5FAVAq/N6al5kDgkCI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-se0Z-OhpNQKt0nQrEUQhmA-1; Thu, 10 Jun 2021 05:59:22 -0400
X-MC-Unique: se0Z-OhpNQKt0nQrEUQhmA-1
Received: by mail-wr1-f71.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso636404wrh.12
        for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 02:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9xTMipSr6zv1c5j9K07Z9YYJvhf6naG20CKqECaN144=;
        b=IHZVqKCgbE0iUWw7JG6yTmM9tIJayov5ZIV2ZbYX5Dk5trN94aSiU8yPbwHbNfOIbN
         OcsjrGvBj3Q4sA9b758tq0Jtc75u8Ky0jsqCJTyluvRrs7oKoF1QxEHTkSbDL6scuyz5
         2cXB05gZDEaYod84EUyN2mHtLR2keUDUf7dB6nJeHwO7j8vRI7irgCymx/BDqtceMuRP
         8SZU+jnbRVLs/nhra9IjsomIE0ujw26q48ZCKrqf9aGXylKIZMhL24i9uMZsHAd6wEiw
         k61KXCfmsl0ajhW8ff4NA3pu4LhBT6YNCLTBhrCczlThJ20nVLQ5IEFhj8H3Cattrq4x
         cC8w==
X-Gm-Message-State: AOAM533+4ivSOoGEATNkT8WK29hskhK6BoM2Go4mAvhrmqsVzCu3H1W7
	WPgiWgU3c4/yQQGzmMMXiVYRqpjrVcHNIDSqjHtWzoAoQJx0HAy6bLXb6chRq+lMBGzjkfOl0Ux
	tYu4vdwYz6VoWYmg=
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr4445819wrs.74.1623319161751;
        Thu, 10 Jun 2021 02:59:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrDiUihclv8KnH8awmn+DgmRUuRDoTeSW5Z3bUhufiLTVf4GJH6BJxbOnEXVj78qGD6dxRjg==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr4445804wrs.74.1623319161579;
        Thu, 10 Jun 2021 02:59:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id c2sm9361435wmf.24.2021.06.10.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:59:21 -0700 (PDT)
Message-ID: <1710e345723fe6b3d91f28e7191dae07e99ae75a.camel@redhat.com>
Subject: Re: [PATCH 1/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
 addr_signal each other
From: Paolo Abeni <pabeni@redhat.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: matthieu.baerts@tessares.net, mathew.j.martineau@linux.intel.com, 
	geliangtang@gmail.com
Date: Thu, 10 Jun 2021 11:59:20 +0200
In-Reply-To: <1623315118-57936-2-git-send-email-liyonglong@chinatelecom.cn>
References: <1623315118-57936-1-git-send-email-liyonglong@chinatelecom.cn>
	 <1623315118-57936-2-git-send-email-liyonglong@chinatelecom.cn>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Thu, 2021-06-10 at 16:51 +0800, Yonglong Li wrote:
> ADD_ADDR share pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
> done we should not clean ADD_ADDR/RM_ADDR's addr_signal.
> 
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/pm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d00fa6..74886a3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -252,6 +252,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
>  {
> +	u8 add_addr;
>  	int ret = false;
>  
>  	spin_lock_bh(&msk->pm.lock);
> @@ -267,7 +268,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  		goto out_unlock;
>  
>  	*saddr = msk->pm.local;
> -	WRITE_ONCE(msk->pm.addr_signal, 0);
> +	add_addr = READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);

This chunk of code is under the pm spin lock and pm.addr_signal is
modified only under such lock, so no need to READ_ONCE() msk-
>pm.addr_signal.

> +	WRITE_ONCE(msk->pm.addr_signal, add_addr);
>  	ret = true;
>  
>  out_unlock:
> @@ -278,6 +280,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  			     struct mptcp_rm_list *rm_list)
>  {
> +	u8 rm_addr;
>  	int ret = false, len;
>  
>  	spin_lock_bh(&msk->pm.lock);
> @@ -286,16 +289,17 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  	if (!mptcp_pm_should_rm_signal(msk))
>  		goto out_unlock;
>  
> +	rm_addr = READ_ONCE(msk->pm.addr_signal) & ~BIT(MPTCP_RM_ADDR_SIGNAL);

Same here.

>  	len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
>  	if (len < 0) {
> -		WRITE_ONCE(msk->pm.addr_signal, 0);
> +		WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>  		goto out_unlock;
>  	}
>  	if (remaining < len)
>  		goto out_unlock;
>  
>  	*rm_list = msk->pm.rm_list_tx;
> -	WRITE_ONCE(msk->pm.addr_signal, 0);
> +	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>  	ret = true;
>  
>  out_unlock:

