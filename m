Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66B13D51E
	for <mptcp@lists.linux.dev>; Tue,  5 Nov 2024 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830913; cv=none; b=HdziB8WWFsi/aWNxdSj57n6hIQCOm+Ked/ONq738gENoQsf0dNCw6nFgvZD6Y5poowVFdSCV9XKMDdY+tL93v3Pp0dRnWy3kGVf+tqlQ8da4WhD4r6VZxtmsfvxofH5bQdQ5MLgdDQR9gxT1PIzs2cHxPKt00TeA0mfXl7NP6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830913; c=relaxed/simple;
	bh=wQ/+TWmB19UC3lxDrGoVUztHISHUynMOoZj21RXKbzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=klnqxM/amUxd8x1aGjwmlUMokLc2BvsPlOiJlkceOxvftZ03T0h2sEJPIGOLkI5++yeIhUQHU9kfO4YHTVvYXlvqnNWy9StX/qRtHvCVtjzKdPdGpO2aSPcYfGakllqISKSBVAvcRLcm4dSnxRUuEoU5JABWNL3SbwSU2Qw2YoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsUNhjnR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsUNhjnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730830911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvMTADZQrfTgsHV5SsEO4rBb9btCw3+cfbmsPWE51Ys=;
	b=LsUNhjnRtYD6BWUxGhhjQ3+seQOsGf4Z2iqTYVEkyy3/zLyDa2Jl4SiQinqBNqynJVSB5F
	06n6H8mxj+6+a5zphvBd3GHy8kxTRDRU3dEAVaMl/Zkg9kpgCL8Y8p9/+RyzdbBl5G3fLi
	YJ52H3cInVUIqxx4xnSOY7up1Q0UebM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-ujS6cN5PNXG267klbNYP9Q-1; Tue, 05 Nov 2024 13:21:49 -0500
X-MC-Unique: ujS6cN5PNXG267klbNYP9Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso49168615e9.2
        for <mptcp@lists.linux.dev>; Tue, 05 Nov 2024 10:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730830908; x=1731435708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvMTADZQrfTgsHV5SsEO4rBb9btCw3+cfbmsPWE51Ys=;
        b=ngWplW2OHEvAeLvallrQw5AqzMlV8LSsyAxecywsDPbgWiEcFw51YOZipKOVgxTAwo
         HXqEQh69nPqKUQqi6PlVOx9qQV3kLWcNH9vXOlHYEpRTuFeezg5O/ifJkADk4upboOoc
         LQ991U5dB1Xag82xSM1TKSeYz0pnGAi8mw/QCVq8+B2dxcUeNCfxzMPaVfnnqWZQ2NJ2
         1xBPGxnZlgm5s4s42uz7ys5QPPlX4zdhZZo3zWkyBSaIZzk4FEQqpsNyH52032kHgok7
         5TswZHvYGeoM/JXUj7nKevwQb8FIJspyMl2bERVpikZ0hogCfeObGIJDoF5xwTJnDYSU
         ZHmw==
X-Forwarded-Encrypted: i=1; AJvYcCUhweey7XY5VOGo1mJvGSlMD4Tp6vbG2lJb4W14d9mjkbJOoqv/k8D7A9WOfpvp3D5lAj+6Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRmiSuadnqd9EHJjL7FER37brfNtpiK78mDjVudnggxLZhd96t
	UhFJmUp1eery5CgSsmIOaJjUf3R7RktctKDLsnnNY1iQxrdzIcjz8zTBjCMAQTCQknJu2k0Ughp
	0QDGxWJzGxQp7Gi5d87rsXntHZu2goyeWtQzpt8iDZ91xuGu/gi5x
X-Received: by 2002:a05:600c:354f:b0:431:518a:6826 with SMTP id 5b1f17b1804b1-43283255a71mr182946625e9.19.1730830908673;
        Tue, 05 Nov 2024 10:21:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLjjL5L/vZ8lhXACNjfpXNDyjxQNV4SxQx0FjAWubAfrWY5W6dnTYgNAt/7WbdGQhpOCOJhg==
X-Received: by 2002:a05:600c:354f:b0:431:518a:6826 with SMTP id 5b1f17b1804b1-43283255a71mr182946375e9.19.1730830908252;
        Tue, 05 Nov 2024 10:21:48 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf4b0sm195714595e9.14.2024.11.05.10.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 10:21:47 -0800 (PST)
Message-ID: <053267b3-a22e-4c3d-833b-55edda46ba25@redhat.com>
Date: Tue, 5 Nov 2024 19:21:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
 <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/24 11:32, Matthieu Baerts (NGI0) wrote:
> @@ -2060,17 +2062,17 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
>  		bkup = 1;
>  
> -	spin_lock_bh(&pernet->lock);
> -	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
> -			       __lookup_addr(pernet, &addr.addr);
> +	rcu_read_lock();
> +	entry = lookup_by_id ? __lookup_addr_by_id_rcu(pernet, addr.addr.id) :
> +			       __lookup_addr_rcu(pernet, &addr.addr);
>  	if (!entry) {
> -		spin_unlock_bh(&pernet->lock);
> +		rcu_read_unlock();
>  		GENL_SET_ERR_MSG(info, "address not found");
>  		return -EINVAL;
>  	}
>  	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
>  	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> -		spin_unlock_bh(&pernet->lock);
> +		rcu_read_unlock();
>  		GENL_SET_ERR_MSG(info, "invalid addr flags");
>  		return -EINVAL;
>  	}
> @@ -2078,7 +2080,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	changed = (addr.flags ^ entry->flags) & mask;
>  	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
>  	addr = *entry;
> -	spin_unlock_bh(&pernet->lock);
> +	rcu_read_unlock();
>  
>  	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
>  	return 0;
> 

I think we must retain the lock in this function, otherwise we could
end-up with an unexpected flag combination.

i.e. set_flag(MPTCP_PM_ADDR_FLAG_FULLMESH) and
set_flag(MPTCP_PM_ADDR_FLAG_SIGNAL) run concurrently on CPU1 and CPU2.
entry->flags could end-up having a single bit set instead of both, if
both CPUs read the entry before the other would store the new value.

I don't think _ONCE() annotations will be enough to avoid such thing
without a lock.

Cheers,

Paolo

