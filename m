Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BE1E9B08
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218817; cv=none; b=eLE0H2vRJVkac2ts7NkYADDB0AWPDPnCTT6MFb3zwM+NaYL8vz3RWmeYZmtzft7d0dDhoCporkWPw7afOYfY8xjSML5LGRy+3u26XqFIyKI2q7MCfWYooxiMRWmDTkwOK5hPlTJKbLrjtx9cN0JprZ94L/dJqc4VMShQL967Ld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218817; c=relaxed/simple;
	bh=ttuZ4dzuxlhYNErHwAJ9BankwuMeO9evYIqPEHgWNxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aPv4RZXoubcq3JCYU/vgP2w8N+xoVjn8SFEKtEIV2ekSxNUbO3YUMDMKNLS0iNtcNg2oB2YREycW0S0jgO67Voev0gMKIvZpq4I+1zLNqZr6Ht7IoNC+FF3caZm91LJ3domHyDARhlqYVuxqGHJjE92KViyXa2QDSpxosmGpbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkygGE+j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkygGE+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752218814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkSgzoKAC01j8EYe3Hb77ouAeZoRtAxtJYNyRyGUqZ8=;
	b=OkygGE+jp7dyo+iMLJT1unKMG/Gc/KlIWN4j6xXqD5nTj/6F91Nygv3GCRTmINw97BRzMF
	YUbvRdJLESZI7Jl6cEhDFEYvtbNfSebXgRUvghw0AuLx0iV/UhK7PtyNrDcN7BxM5EbJqv
	QTkn/ECd7lXu/XGs6kjZZzjPJCqn8Bw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-6k-yAIlMP8-p_W-NXN0gdQ-1; Fri, 11 Jul 2025 03:26:53 -0400
X-MC-Unique: 6k-yAIlMP8-p_W-NXN0gdQ-1
X-Mimecast-MFC-AGG-ID: 6k-yAIlMP8-p_W-NXN0gdQ_1752218812
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso9966685e9.0
        for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 00:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752218811; x=1752823611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkSgzoKAC01j8EYe3Hb77ouAeZoRtAxtJYNyRyGUqZ8=;
        b=LayDB+X4taXBJdZCvGh2SAVcldp/8AOVG60cc9YyMZwkOe7GQULs/bumJqjRxGHqJt
         08s/A7H0k9h5+kwArrdh2Mv8g3ZgFp6aUuaP+A9glJEj8s7PchQxLDTq+oNg1OGNELr2
         HGuGpO7eAGQHaQ0MzokxViSB+LG9d+zzPrXuRZYJ1bz900FQsMnB33p9OtU0Efc2WZNS
         M0MWDQf0ijaHCGreTu9OTBObNESNgQ/79SPxnDT+llgebodrIUTLmDvOFeN1+80CtDjw
         zfG8Biuk8EORmbCeJI9Bmagucsl1f+3Xo4Oa1JFlAc0MM9dAZyOxPFwzPRznmQ1GHrFE
         Cz4A==
X-Forwarded-Encrypted: i=1; AJvYcCVwGboZgPV7zCOJS6Ci3qZ7891YcF1hrKW8yJO9OG6ZZL5Y3pR0Jwt8N1qL1jvbbS/S/NKIqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3umyW3OQKGpkcqCfkgte34Ifv911zecFZRb+TSoqaNU0AlWb+
	pAfrtjwgU45XDYpiHpoujkhMiWRFdgzWAljaxzBqqiA7KUll62iqJHT4yJ/O2bQXgUCXrpq18M3
	ualFqNhvuOc0IK2SbgcBdtgF9LUKxO9QtmOFfVAujENTX7i7P18oVLUOg+JtKWn7I
X-Gm-Gg: ASbGncsHlMOFFShH+lNfspxyxbR+7s/FFo3wQl0Xl33FUwEOyV6VABsHxqR/2C7xeSA
	PCJhApqw8myDNx9WZcjhDgFALZA0aE6+cYTKZPUeLq0GbH12ypUMRgLykkKaPLPLmDPElY4f2hd
	WL7pjeHqxY/mTm1XFypa9n96hJgkXrMC6mkL9sBtYIEUzLaeUEExRC9KmXx3vr78BL5skm6YRRt
	/P7pqzoJ84Ryt4ysVwHxlL7sHFP5rJBdutuaMiKe+XJPY8J7EThiAwYRoj6ljBambJIiRuYvZLw
	3S4NjVL46EkzdMHumN+35sSRRl+ndZF02gXQGKgOjN9Uhb9QwRiDpso60ydeZ4y5EwegD8fgIkr
	h5ilA6TfLP7g=
X-Received: by 2002:a05:6000:2105:b0:3a5:281b:9fac with SMTP id ffacd0b85a97d-3b5f1e87018mr1362440f8f.17.1752218811366;
        Fri, 11 Jul 2025 00:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN/ayw36Ua9jMsnsO3Ybg2CZZxiFD2Nm3jacCrQCgSU3twN/S7B37EDxCfSwk451feWufRmA==
X-Received: by 2002:a05:6000:2105:b0:3a5:281b:9fac with SMTP id ffacd0b85a97d-3b5f1e87018mr1362421f8f.17.1752218810875;
        Fri, 11 Jul 2025 00:26:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2716:4b10:9b16:cae0:6065:2782? ([2a0d:3344:2716:4b10:9b16:cae0:6065:2782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2147sm3771233f8f.32.2025.07.11.00.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 00:26:50 -0700 (PDT)
Message-ID: <b4389c69-3563-46a0-b104-75333d29135a@redhat.com>
Date: Fri, 11 Jul 2025 09:26:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-net 4/5] mptcp: track fallbacks accurately via
 mibs
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1752073685.git.pabeni@redhat.com>
 <b53a37c311ea75427dffb02bf92f09a3d58b36b0.1752073685.git.pabeni@redhat.com>
 <2081948e-6236-4eae-ac43-989c776ae10f@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2081948e-6236-4eae-ac43-989c776ae10f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HxHtgH70Ui9L1eqo24J0fxMIMBZBEdGc5C17kfHJbyo_1752218812
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 7:41 PM, Matthieu Baerts wrote:
> On 09/07/2025 17:12, Paolo Abeni wrote:
>> Add the mibs required to cover the few possible fallback causes still
>> lacking suck info.
>>
>> Move the relevant mib increment into the fallback helper, so that no
>> eventual future fallback operation will miss a paired mib increment.
>>
>> Additionally track failed fallback via its own mib, such mib is
>> incremented only when a fallback mandated by the protocol fails - due
>> to racing subflow creation.
>>
>> While at the above, rename an existing helper to reduce long lines
>> problems all along.
> 
> (...)
> 
>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>> index 0c24545f0e8d..ee51d14ba510 100644
>> --- a/net/mptcp/mib.c
>> +++ b/net/mptcp/mib.c
>> @@ -80,6 +80,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>  	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
>>  	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
>>  	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
>> +	SNMP_MIB_ITEM("DataFallback", MPTCP_MIB_MPCAPABLEDATAFALLBACK),
> 
> I see that you modified the enum, but not the exposed name. Is it
> intentional?

Oops, sorry. I rushed this a bit too much. I'll send a v4.

Thanks,

Paolo

