Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21846346797
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074340; cv=none; b=MF2zS1M/PjVmVw6KGXQ8Av/Dol6O4M//Zz1HnNaPn3Y4Whksr6n1uQKPS0dxv5lZzqwUfKajNfnrP4V4y1ldOaPK1fltFV2tT9UjNhdT4PZFf1pq8C6B1OZvfl18SBqF1qt5BRxor5mQmUbyXQG9idm1cRXfhZEh1TrUQ8q4JeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074340; c=relaxed/simple;
	bh=TbuopAE8Zid65GusjMJxwlFOKntnvUUSO/51zyzoTKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvqKUFl3eiFf6hM6C7Uv4Zoco1CRYi4N5J53MmsXM3zO7RQ6diCNGxkkbXqgCw7SUlxoLIfvBrFy2dMb0Gx+OytYKJPJh34fJGhLgJY5dHP8gx0nvhn/93xdDNkJjyl0XMvo5GNzBaycPr2lQh6TtolWzYpzCa3Jaz7QI2sVe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCXhJCaa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCXhJCaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775074338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uePJYWW1bMWyzB+d1PBuHoI+CzpppVEmg8wdaHT2GcY=;
	b=gCXhJCaafzrYnPgjdTTzzOVWfJdJZOE7yduc7DFv4L4rI7VrSogpXEd3BGTHOZF38rqKGR
	d4hkm3aP/cHkSONx2VEij4556a2cOowEMXgCo8v5BNr0NEi87yungAG93eo5mCr35G0rTG
	obnEYHLPBW/URNZyJg6GKVo2y2wBsK4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-aLH7ln_UOp-m330KfGml8w-1; Wed, 01 Apr 2026 16:12:16 -0400
X-MC-Unique: aLH7ln_UOp-m330KfGml8w-1
X-Mimecast-MFC-AGG-ID: aLH7ln_UOp-m330KfGml8w_1775074335
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a2c47e107eso150878e87.1
        for <mptcp@lists.linux.dev>; Wed, 01 Apr 2026 13:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074335; x=1775679135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uePJYWW1bMWyzB+d1PBuHoI+CzpppVEmg8wdaHT2GcY=;
        b=dBCjzmc9lQw5VAtT+liQDmEnOcbtZ2OLZ5YQqwUF7J6i3676m3oS8rFPHUnFXCkjfs
         QhvMq5ePxjby0vwJpRed4sl5HTwLuUWtqaPZZA/A1Dec7YOs1KWV+sEH2RwK7/KbKNB0
         K6a0dxrlGRnXPW9jFF8iCn5C/CY9S01ntrqOCvgxdU/vIfRtDFRSmYHZXkpt+jwIpbyo
         /6D/UqfI6GmUJowjf4dvZLiRu04c9ObMyjLIEBYfgLwnW9z9W4o/zkJzGlDNXTEbMs9p
         P8mNbp0QWNZYOpr/Ks0AkN3Qwdu7XDqC/ePzBBTrqyl4a8Bdp/FjTrxqhZ+GTLTOGC4Q
         yBvg==
X-Forwarded-Encrypted: i=1; AJvYcCUMiZb21brmzeUxH70k18oPKEFHqid7jBcZOvl2IcK7QjNc7IHrhm4iVCUFamQOG+haZsXExw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmD1APk1fDQYXeHXSxsX+wbN5TMQr3Hu+cmYVKbHItgZGIqFuG
	13DngdSPCmhlB0Cpdh0CgJNRGfEEicQmXQqdRj1ZZDqv5/c0FTuCI1TLLKA5eyv4zSMzmBWVQ+F
	oxmDO8zE4y4sXhUqSHLbRKXMxGT40wFJcQquxb4+PBIxyS8GgfXfh7a3I
X-Gm-Gg: ATEYQzzSVVHtgGkmBnC/cuywk5H8YF82cJxWB03OP/BrzpGHHMmSN4krbH6jbprMHy+
	rdN8clM+Kx+WIxrlgQxbpYxIsj5zC68leqTiNr1phUHKJyfahjBseOqZCPcvAkiiM1cD6mbNmEC
	5oRuKtsF7uyUvJtVf6z/HB8HXyhniGJXp9aVdPNp6xaZcqv6197Aacegl7OCVcs0x/217Ezc8aC
	6WqiuvhG9xxNq7bEwo/HGkc/Codoc3Z4FzjHloLxeFNbhYPMLV5OcoXgT+4dyB6abthxMgF43mp
	tzIecQ9sSWGuton/JrYNovNS6Eufrsa71Tqzi3t0WV6PbsXeN2V4jWgSLLn/1rujiwljJQCj3Lm
	cqxHjtnZouTflHnKWof1chxg+0wIyWkA1SlxF5zLPQHkj7hOhFPAxcmLGvQ==
X-Received: by 2002:a05:6512:2255:b0:5a2:bb0f:e28b with SMTP id 2adb3069b0e04-5a2c1eedbd5mr1922702e87.18.1775074335196;
        Wed, 01 Apr 2026 13:12:15 -0700 (PDT)
X-Received: by 2002:a05:6512:2255:b0:5a2:bb0f:e28b with SMTP id 2adb3069b0e04-5a2c1eedbd5mr1922697e87.18.1775074334671;
        Wed, 01 Apr 2026 13:12:14 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.230])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c951b1sm183255e87.6.2026.04.01.13.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 13:12:13 -0700 (PDT)
Message-ID: <d749b513-158d-4a3d-ad95-09bfc29c6648@redhat.com>
Date: Wed, 1 Apr 2026 22:12:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v5 1/5] mptcp: replace backlog_list with
 backlog_queue
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
References: <cover.1775033340.git.yangang@kylinos.cn>
 <085a4d26a05fc6625e6e4e4c0e0225b38a01f178.1775033340.git.yangang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <085a4d26a05fc6625e6e4e4c0e0225b38a01f178.1775033340.git.yangang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JvilLl5Odg6wEAPXyYcLiRSD7-19yl7KWrSrqv9ROPg_1775074335
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/26 10:54 AM, Gang Yan wrote:
> @@ -2199,6 +2226,29 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
>  	return moved;
>  }
>  
> +static void mptcp_backlog_queue_to_list(struct mptcp_sock *msk,
> +					struct list_head *list)
> +{
> +	struct sk_buff *skb;
> +
> +	while ((skb = skb_rb_first(&msk->backlog_queue)) != NULL) {
> +		rb_erase(&skb->rbnode, &msk->backlog_queue);
> +		RB_CLEAR_NODE(&skb->rbnode);
> +		list_add_tail(&skb->list, list);
> +	}

This is O(N * log(N))

> +}
> +
> +static void mptcp_backlog_list_to_queue(struct mptcp_sock *msk,
> +					struct list_head *list)
> +{
> +	struct sk_buff *skb, *tmp;
> +
> +	list_for_each_entry_safe(skb, tmp, list, list) {
> +		list_del(&skb->list);
> +		mptcp_queue_backlog(msk, skb);
> +	}
> +}
> +
>  static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -2210,12 +2260,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
>  			       mem_cgroup_from_sk(sk));
>  
>  	/* Don't spool the backlog if the rcvbuf is full. */
> -	if (list_empty(&msk->backlog_list) ||
> +	if (RB_EMPTY_ROOT(&msk->backlog_queue) ||
>  	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
>  		return false;
>  
>  	INIT_LIST_HEAD(skbs);
> -	list_splice_init(&msk->backlog_list, skbs);
> +	mptcp_backlog_queue_to_list(msk, skbs);

This is under a spinlock with BH disabled, and N is potentially quite
high. This code is problematic as it could cause stall and delay BH for
a significant amount of time.

Note that there are more chunks later and in later patches with similar
problem.

I don't have a good solution on top of my head, I'll try to go back to
the design table.

/P

