Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0243A7FF
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158985; cv=none; b=KLOK1c6r4fyYYyqZSACMbW41Kf+3HlWu/+9WrX3nEfe7Hud2toyZYvINQSAk6f+ayafcFef4L4d9RFS7AaXISlLZ501L91+9XZ7Nt3V65tFU1E2O73iv9k4zSWCCSFD1lAAyvPY9wIZGxU8FW0bbcLfv7sH4jBd+kAaH8BGgAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158985; c=relaxed/simple;
	bh=7t5pKudL4XQb7b+EzJFDX22+aGzTqfoSrhO9W9ND1FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CCgTSZ1e+EGW1IysR0euidtqtewSvI4iK2fs1H9V4zOSSv+a/shgHx2OLsBYH1F7TOyx/GDl4HK3UVUCrImZPfS1xeDAInbHvDf2Tg+BaJ7xzlK5cfKMo7JWhmakUDT2AQ25OrLiTupbMQj2C8HfhP0D2gbUKbNUr6+mU3vgYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGufW1l0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGufW1l0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790158982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wGQSrenBitkFLB122sj+Hv6LBFigNND2Emg7rpCpHo=;
	b=MGufW1l0OC7DIW+Zi2FzA9KPuHKtNls/HmjFPJZcE9/XhIq2p9QJnskXgswNCtqA2dJATP
	IwHz9Wt650s8kCshyx9YXHcUktWPExd0jWhS55fqnlBA9ze1DRP/INKyzuxe7z/ZnWbH+h
	LVxFzDP6T5ANe15BY+nxpj4JWnh2MxI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-UsQw2OMqNvGP1_8LpXUteQ-1; Wed, 23 Sep 2026 06:23:01 -0400
X-MC-Unique: UsQw2OMqNvGP1_8LpXUteQ-1
X-Mimecast-MFC-AGG-ID: UsQw2OMqNvGP1_8LpXUteQ_1790158980
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c294ca8193eso30547866b.0
        for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 03:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790158980; x=1790763780;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wGQSrenBitkFLB122sj+Hv6LBFigNND2Emg7rpCpHo=;
        b=cEFjoN5jDo91btMrnCLMC/+RCMf2kZCb48/157/sKYHOjDlI8DLMKkP6poclk6MpgS
         Pc6EM2R9wd079GPZAzNF+rnt9l5yaN0kaVQm6Up0WaQEoekiuPTpSVbLyCNiwrOMqlTF
         X/EQDVycg8S48iwsdrH/WwpzUbdG4oV71+xjcWiqGR3/oaDDYdCDu6u62MFMu9CVmvhP
         05DPYNpPRAigSNJr0AdyP2ufAsPYkqDeOYSaF+1tDolH7L/ntt4JFiEQHa35uUwrZ9xT
         av5MyaVB2Whwg7CVLdcD43N6DBljGu9weuQUgh2GhYPFgMO5gJlg32WaYp3R+ch2LGxC
         bsLA==
X-Forwarded-Encrypted: i=1; AKwUvBzo1G8+8Fp4QmSCaudBjFoMWSJhvnzKkfQodgKAmoNI3F94UN7vCMu+VgqfeCDNtWI/DgcU5w==@lists.linux.dev
X-Gm-Message-State: AFuF++mwzAg9ARDscPFH8Ln22Dauyfl9e/nMn0PKa8MLp8gGeKYop0Yv
	oY53HNyhQKNWTBNqGYmLzn+8QfeRsXNRaR3WUWNiTea+OhekWQh/pQw1kV/r27RhtleXkPoVx3u
	i8aVLIMR22WynT1EwoodZgniGZBQz4F7jnwM010xGXujDXuL4SrBQSUnea3UBcvJP
X-Gm-Gg: AYBFou2Jb+4UHtNeFWQTaWIW0xYpesdQfOnXV99ZML1F6xS3msVI8zhCj2cXfwfSp0M
	F2Pcvx4/rGJC/DbOpawqPR/sgSRdgI7jc5ZH34wcJCStnfkkHliBSbhiS2AxZEVgc906H2Ml6ml
	oNg+rA6z8lGa2FoI3umZEqxYMup65cbVis6WspyG3wP4VxALd9FCrtiwWmOHjnByl2Z3mqaCQts
	NccB0i/j11FcIuFlDESgoZfhsbOhL1DAhhZB4aH3JIsil2llMfqkb0ccFVgIiwLz6ZaAryU3BjR
	sbYkMfXeQtR7lkYiVjT+D7NiM8Nyj+NwgDK/c3o1ApmrtJfYzCFepWjM3rZMyge3ciaAoCZKkB1
	QbdDV80+YUPeX1+wzhoRxVj7JL70wQCJw7GzKB0/q1hFqmY6xnKjHVopKP3KaPs63cFhHjpV9sA
	==
X-Received: by 2002:a17:906:9f86:b0:c29:3b7e:3a94 with SMTP id a640c23a62f3a-c2aae1c0e13mr170029366b.38.1790158979827;
        Wed, 23 Sep 2026 03:22:59 -0700 (PDT)
X-Received: by 2002:a17:906:9f86:b0:c29:3b7e:3a94 with SMTP id a640c23a62f3a-c2aae1c0e13mr170026966b.38.1790158979371;
        Wed, 23 Sep 2026 03:22:59 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33faf4sm89815166b.3.2026.09.23.03.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 03:22:58 -0700 (PDT)
Message-ID: <4615397d-b384-4791-9a46-f9cf2b51d93d@redhat.com>
Date: Wed, 23 Sep 2026 12:22:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fix subflow bitfield misuse
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <0342bcf7f4bc6c4598ecbe58cfd8ec75505c328e.1790009113.git.pabeni@redhat.com>
 <317eeb1d-92b7-483c-b035-fc7df106cf26@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <317eeb1d-92b7-483c-b035-fc7df106cf26@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MiRrimbtVCzNuI7nhWkPZbgP2D6QODK--BKuZviES8k_1790158980
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 09:35, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 21/09/2026 18:45, Paolo Abeni wrote:
>> The subflow status bitfield is protected by the subflow socket
>> lock, with one notable exception: the `close_event_done` bit
>> is actually under the msk socket lock protection.
>>
>> Flipping the latter bit may corrupt other entries in the same
>> bitfield.
> 
> Thank you for looking at this!
> 
>> Move the  `close_event_done` outside the bitfield in a 64bit
> 
> (32?)
> 
>> hole. Since the mentioned field is now not cleared at subflow
>> disconnect time, additionally remove the now unneeded `local_id`
>> check in mptcp_close_ssk.
> 
> I'm sorry, I'm not sure to understand that: if it is not cleared at
> subflow disconnect time, should we not clear it explicitly at msk
> disconnect time?
Yes, indeed. I rushed this one out of the door, sorry.

/P

