Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F381EF0B4
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044026; cv=none; b=WihqBnOrL0+JYGQdb6fbuewxqpyj1LTpoP+bn0/pnZO+b4lE/dfVJjJItvjogt3dc76OoFKlNdPF9yLrTXB6biiW5BHjhNuxKwkeKrLlVJMYi4UW54qDjDa9uHCJVxQSJN7CNtOrlUjQcmCwAOnOL+4aYFdJG1xvVBJDqfRZMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044026; c=relaxed/simple;
	bh=rHUChIjlwVDn4yYujT9EmZT16C8nZef3tVbjZsuxOVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sURXckPNBf4/JfNlAsU9jUMVuRNh/urUZcadk57avAaQnf6DkGBtPc3tax8uG8FVgGiKhSHNTj3i09f1smOkcW4OBmccc5I155R4upfxYFrMKhJNLtNcX1G43UXoD39rxGIh1BS7eJTPQ+2gyQomMDDQoXsAmTHw3EqfRSZJE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2BGU/lL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2BGU/lL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740044021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6tia6EUu59EUqMPe31dvcahgUZPW06HRaQZU9x9AzM=;
	b=M2BGU/lLp1osnt2cPNJrMANg+MfD10AzGts6umUOkDEmftRUbZzvu92wM/emi/6+sdLocD
	fuJvS/tXi0Gs3GkpvPDwQTphYRyVs+VgtZoVOLZsBHt+yuH8EWZ6YzXTt7yuyVdzRVR54X
	cP1h+EZbmblFZybOY7C5X+DU4daYCao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-rXpnj8pjPGaqnMdXwC5_1w-1; Thu, 20 Feb 2025 04:33:37 -0500
X-MC-Unique: rXpnj8pjPGaqnMdXwC5_1w-1
X-Mimecast-MFC-AGG-ID: rXpnj8pjPGaqnMdXwC5_1w_1740044017
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c747c72so3043015e9.1
        for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 01:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044016; x=1740648816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6tia6EUu59EUqMPe31dvcahgUZPW06HRaQZU9x9AzM=;
        b=fAM8uCb67cP6lOiET6tseNmb/F0jA1msZkYMuOzmC5AHUtReLqStwozmg3ZcMinkoX
         hB5nS/BS+mZnrp8HwxB8ndEoKy4bvhfrOkZxsVaWMMLASsZHIysqFCkQETJjKJagf2PJ
         GCcdu4dU6NchDxRB7Rh+dRen8uFiONtnDf0PriuXZ60mcle5M5go9dhyVuUK8OFpKLIi
         fE2tylAkB3ZlhDeEbwfyRP8XkP2h9wm+rOX9Pq8KjcmlpnIcSmTd3Ft/Imub+zO3aDn3
         MyYLbUHvYl4SRwcQzCSG2++qxWT+h02EjosDrkLGDkKONao1P3YMmXeQab7/UregVCCv
         HyXA==
X-Forwarded-Encrypted: i=1; AJvYcCW4d8j2lZNjPTw6hlZNg07iD9oPA2HlEK2Xl3GwgsIKIwCz7RkxlGb4taCQX6e/lNnoP+5YPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwII9vEZZ0Y/vrEcUBWJICcG8QPVBoNmrEaoeKatwqkTaWmuyNy
	JTSU5rxuoAVxk5u6QamybcaWOYGl2xY1oPG5dr79yNVDiGsLdk+uR3Y01NAXfz+v2kczxjwOluq
	G2ye0V9BBzCV5cs/4OzJNmrcgyEhqg6C4EFz7dagmi0D5NqCSWftsbImRwU2+
X-Gm-Gg: ASbGncvHPghAAviIS1bsbzvQKPOlce8jPj5v3Cusi7u8aw19XZB5BhK+BYfJFkEkHQ4
	ukAgUalQJJWWiYxiD/E2EsQzQ0QbYyE4pS0XfacnujkFBDKStLALaLCz5F6dYrzJnWGFlljzjt3
	ZVA2q/lmZLwymKzU1VZb5V3IaR1M+YSMmN+31qrP3nN9Om6/9je8/ZTVEYw7j7KMuThg2yYqczD
	a8GkjETIcN84kBChDVHb8nwf0gr9RZl+rK72duNGiZEQCCxO8uWQMoyNOdckI5G583CticTaOcA
	E++kF7TusxryUeMkUHoMWNEgHCY5lj6lD5A=
X-Received: by 2002:a05:6000:156e:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-38f6514a0edmr1446684f8f.43.1740044016100;
        Thu, 20 Feb 2025 01:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVLpMrhtE6fsL0AWleYS4Z+gM+mG94v841WXojes8YyKeiKzoyP8u2elFmnoxD47R/XXGFdQ==
X-Received: by 2002:a05:6000:156e:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-38f6514a0edmr1446652f8f.43.1740044015777;
        Thu, 20 Feb 2025 01:33:35 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2591513bsm20289871f8f.55.2025.02.20.01.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 01:33:35 -0800 (PST)
Message-ID: <2c71d642-cbd6-402c-8300-59f22533654c@redhat.com>
Date: Thu, 20 Feb 2025 10:33:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: always handle address removal under msk
 socket lock
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <61cded134e753976259b48a4269f203dcae6c8fa.1739969092.git.pabeni@redhat.com>
 <a103802c-90e2-4cda-86a4-6bde5bb28670@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a103802c-90e2-4cda-86a4-6bde5bb28670@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KX0-J8SkGSHKkKnLMNzRWbQSiAumPcR_HBdOQeITrNk_1740044017
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/25 6:45 PM, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 19/02/2025 13:45, Paolo Abeni wrote:
>> Syzkaller reported a lockdep splat in the PM control path:
> 
> (...)
> 
>> Indeed the PM can try to send a RM_ADDR over a msk without acquiring
>> first the msk socket lock.
>>
>> The bugged code-path comes from an early optimization: when there
>> are no subflows, the PM should (usually) not send RM_ADDR
>> notifications.
>>
>> The above statement is incorrect, as without locks another process
>> could concurrent create a new subflow and cause the RM_ADDR generation.
>>
>> Additionally the supposed optimization is not very effective even
>> performance-wise, as most mptcp sockets should have at least one
>> subflow: the MPC one.
> Thank you for having looked at this!
> 
> By chance, do you know how syzkaller managed to interact with an MPTCP
> socket not having any attached subflows? An msk being destroyed?

I'm not 110% and I don't have the syzkaller log for the relevant splat
handy, but i.e. a passive socket at clone time does:

	list_add(&subflow->node, &msk->conn_list); // [1]
	sock_hold(ssk);
	mptcp_token_accept(subflow_req, msk); // [2]

under the msk socket spin lock.

After [2], the PM ops can find and operate on the newly accepted msk
socket, but lacking any lock protection and memory barriers could still
observe an empty conn_list, even given the prior [1].

The race is tiny, thus is hard for syzkaller to find a repro.

/P

