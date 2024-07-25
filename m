Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1419AD8B
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922220; cv=none; b=l8YVHN54fRp+Hw8hMYfTrIEopcHyQc6eQAb4FvQHzp1P2p0YjTK0OK1M7i2H78nTwHx+VWtkAxOtQyKasHydOPv4i6v1kbqR7q/EgaVM85kQcwAjelX6QYKx6W5s1mrBX02DAGcTMXaxx8L49nGDebggWa9SkyRos+xGXPoa/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922220; c=relaxed/simple;
	bh=mgv0ONrJaMoKJ5BAQbF3DScrGzayl4fDkRQQEJZZweA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ofy0IiSbz9qIdnuIhzypZULZSVtenXXOwS4s8OujBssDOugGS2PNvmDVRrpAw/bDs9u1V+D4yafbOpMjEtk6fi2dlSiD34ewSulykyJ/8VVmBVApkTwEa3DA3IzKfBU0KVqUgnZTzp5hgatMdvJX2kq5xzIF9s5Jol+5aFY1QC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ewpi4whU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ewpi4whU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721922218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3f4QiJjbfph7oWnWE20fOlbLUwIdCwAKnoBKS8+EtY=;
	b=Ewpi4whUEAVn3lhujw4RS0xr5A9vMWiVCUbBJrRkvPFXhGEgonAw2GSIw0+vOWdV00VAXL
	vY9KjasfEdnkAAuyJ8UDBS2A9McBQRz+6WjeGC+zLygNwgjjDgMyPK1bz2fhY2ry/zi7ai
	yW+8OTgXPBlfA5VSEYlDdQBG1WXkK4E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-zO-qDN87OJK7woN1OtCAAg-1; Thu, 25 Jul 2024 11:43:35 -0400
X-MC-Unique: zO-qDN87OJK7woN1OtCAAg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36860dd1fe8so209217f8f.1
        for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 08:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922214; x=1722527014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3f4QiJjbfph7oWnWE20fOlbLUwIdCwAKnoBKS8+EtY=;
        b=jMW+Y5N2d/R5LO+u2il/txNYYw7st7XrgZz4T7InNC8wpxf2gYkLciQ2ac3rXy57UR
         CQre4L6NJCbUld8T5H9fuZGgtcXc0pIQ9Pr+hDjFX6v+NFfnSvys64H20PpSQiWCnZh1
         X+ROQpvfP8rS1NqacPTwptIVkOXWQdWztpKly/JrIyS4YajP0YB0YpVEd1K6mGjJ3qk0
         spjDK37QiNKi9OfmBOz2mG0mT8Wf9pU1gWSQdyby/Iz56XsmYhSere+lBulI0wiR4WB/
         5Mv7lhqMd1Rb8jKLzEua1CRQULNfLsVWTrpTFk1XvhzswNVUl7jfVeKKACj33gtcm/AZ
         xGTg==
X-Forwarded-Encrypted: i=1; AJvYcCURlCVyYc0g6wnhr2ldr7Hz9p9dx9D7k2VLlUXPO16djIKKvVda93+EBtFtNWv6Tmc4vT4FsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoDhXN8PVl44/HPh73vODpnAcYZaSKWHd1pcPWI5WsQ36AyITF
	/G4UEVu27F98oMPVrgS36Cy4qM6uB18FwfMKBiV6Y9Fl4qVGBBSnVfpkigU/b4z6vuRFp1TAj2C
	gpYNz/QAnmtaEa7Xnf7Z55UNjf7ZUqZzQqLxthJ7sVlHnnLVTOiy+MJd0AKo5
X-Received: by 2002:a5d:6d83:0:b0:366:e496:1caa with SMTP id ffacd0b85a97d-36b34d2a7c0mr1287206f8f.5.1721922213775;
        Thu, 25 Jul 2024 08:43:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcktG+uB1lMtZ8yCvY9q6M2QCWXFRdAlj0EbeLzaJU5GBQzralUftq6AHtYXb6jRvwYs1PIw==
X-Received: by 2002:a5d:6d83:0:b0:366:e496:1caa with SMTP id ffacd0b85a97d-36b34d2a7c0mr1287193f8f.5.1721922213315;
        Thu, 25 Jul 2024 08:43:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573edbfsm42986565e9.15.2024.07.25.08.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:43:32 -0700 (PDT)
Message-ID: <5f9a3d16-9a55-4a9c-8d1c-6ec14985e33d@redhat.com>
Date: Thu, 25 Jul 2024 17:43:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v4 21/23] mptcp: pm: avoid possible UaF whend
 selecting endp
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
 <20240722-mptcp-pm-avail-v4-21-15bfd73de384@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240722-mptcp-pm-avail-v4-21-15bfd73de384@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/24 21:35, Matthieu Baerts (NGI0) wrote:
> @@ -159,17 +161,21 @@ select_local_address(const struct pm_nl_pernet *pernet,
>   		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
>   			continue;
>   
> -		ret = entry;
> +		memcpy(new_entry, entry, sizeof(struct mptcp_pm_addr_entry));

Minor nit: why don't:
		*new_entry = *entry;
?

> +		found = true;
>   		break;
>   	}
>   	rcu_read_unlock();
> -	return ret;
> +
> +	return found;
>   }
>   
> -static struct mptcp_pm_addr_entry *
> -select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
> +static bool
> +select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
> +		      struct mptcp_pm_addr_entry *new_entry)
>   {
> -	struct mptcp_pm_addr_entry *entry, *ret = NULL;
> +	struct mptcp_pm_addr_entry *entry;
> +	bool found = false;
>   
>   	rcu_read_lock();
>   	/* do not keep any additional per socket state, just signal
> @@ -184,11 +190,13 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
>   		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>   			continue;
>   
> -		ret = entry;
> +		memcpy(new_entry, entry, sizeof(struct mptcp_pm_addr_entry));

Same here.

> +		found = true;
>   		break;
>   	}
>   	rcu_read_unlock();
> -	return ret;
> +
> +	return found;
>   }

No need to resend just for this, can be addressed incrementally.

Cheers,
Paolo

