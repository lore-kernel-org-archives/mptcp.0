Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320B2F3C1D
	for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126346; cv=none; b=QWWQkot/Uyq3HAxSgQPQ5taWO9WgbyCi3PQ36XqKhikDLd+LnoN4TFv3S9EYvbwy3YGp5Jqkb7sSoX6HA3XyCPUnBGvJn0vUg4RyEzAhOYL/0aiKkz7I8Huzr5IwG1fY9R/UxgRTzaonXmpK4RG5vmXnhkkTJFoGoHmspruSHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126346; c=relaxed/simple;
	bh=aWMQdzxv9lYbs2Tlj14VnROpNnIqTE4uMpLUUB8SvKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bLNjs6lVIFlqgD3P5LF4svfSrrcsyuZ6wQaf7IciIgCI+l8CPMFDxS7YxV/e5TkLkhW8OTwzg1aQ8gdQ1PN4JkvshedRrGySAtg0069pp4eMSuHiqhqa+/K8+iuh4P0ZCluHqP7nt/COyWWWS5IjADN7L9OyU4uhBmHWHPScCSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+Fvyo7c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+Fvyo7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758126339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1GvSAL6jZDhSoKM/lTPH1sLuojAAx6vq3t6/lvwIgg=;
	b=A+Fvyo7cbm7wK3tIlQtvKhht1536qjlOaAtRD5/wAfXBd0AAO9pg81QVeeCktva4KQ19/G
	UNw2qhd2X89RfiDm+t1tt3SBQvBhrnqZgIcWYRYNSitMZMvaoMcVKYwc9mzG7U3ETjzqDh
	oqF2/YoiqqxhpMzpatwVeemPxkzO3OU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-LSzYRvMUMRGC47cKZ4A_Ag-1; Wed, 17 Sep 2025 12:25:32 -0400
X-MC-Unique: LSzYRvMUMRGC47cKZ4A_Ag-1
X-Mimecast-MFC-AGG-ID: LSzYRvMUMRGC47cKZ4A_Ag_1758126330
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de5fdda1aso33115815e9.1
        for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 09:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126330; x=1758731130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1GvSAL6jZDhSoKM/lTPH1sLuojAAx6vq3t6/lvwIgg=;
        b=mxn0s8vJyhtF+bTtl7QecUZVi3Gw91+fgRH7g62qShvtd6QpuoxaVd3r5BJFVW03V+
         4BQsfsdlv7EuCPq5O/QGJP22sM9Op8zse8GghAfI7gcspz+6hsIQDU/i9rQV9dxgMmtc
         JNPCTVXPyh8suUNCKl8r4rIe4V5uVhsqQPS9x4/GbQqPLVvQcuQK9HEZU6aBuIAxuNAt
         c43jNtJi5iGak1pPiR4NivcX+9zoQOcO3smtYxYUbMirrCvj/65rGA3RsYL0GAUoHJff
         dYOtJotVO63LRyCuK49q3dYUPakWDm1GgUw3InMSeFL22F/2+H78aDTZC4ApX8Oc46vf
         XCXA==
X-Forwarded-Encrypted: i=1; AJvYcCWdh6fgs26qIMoTecq2mTeXXbXjrsNOCNi5nFSDZndJpHKxtX9rGxKJ0+MeJHpUKE2CQLpQhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLo7bdTBGbcdKmfGz18yIH3vz7y1dt08XrWLioti+0TycUoZeG
	cc8eiauXWWgd8bbKwlaKDY1EmexKxORMUeIj6e8VbLUQnDxO9QKUlCEMfbHLS4RMATwp1VYDuLU
	VLjXjGeLsWS7E2DzA38Wdr9d5ioCvscko4RsTkxIAegH3sVXSRJrCr1hC
X-Gm-Gg: ASbGncvpkV5SXRrTLoTRMsbm/R2Ppx5OIuPJtVp61zc+3l8A3tgLWxvRBU7l+LMl8lF
	l8xCBO9YIT4CM+prpZlbSyH5aFaxP9TuPCCpnuO+WLkxvjxy+dH8ugA3hxzgNQUfMiNSezK0ssQ
	NLyCypzC7SSwD8SnFz9lZWHtwItNLYqb9J+2kuRHUlTrlSJMznBQb0crPb6NbI9bN6P/BOsgoQy
	QrML11Jg0UeZzR0e/vFZlEfNWz9JMbHphd+x4rf2JRIilcgj8EtUnfzRt3DDVBirNySF0BOaXop
	OnEYq8NaGrUppExCXq4au7UOtwNOzgsC22xiw4Rbal1JBfydstU09fnpJ9N0BzPW2SVvlFMKpKl
	MCHjoRkV+BNyY
X-Received: by 2002:a05:600c:470f:b0:458:b01c:8f with SMTP id 5b1f17b1804b1-46201f8a42amr31787555e9.8.1758126329813;
        Wed, 17 Sep 2025 09:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNJaJI5RDH2ZSyq115swCYn777xp7vQo5zz6Ggxm5K/wGxaFKZsCF7cjZW1bFK98JvdT5Uaw==
X-Received: by 2002:a05:600c:470f:b0:458:b01c:8f with SMTP id 5b1f17b1804b1-46201f8a42amr31787165e9.8.1758126329311;
        Wed, 17 Sep 2025 09:25:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a2850csm2217285e9.19.2025.09.17.09.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:25:28 -0700 (PDT)
Message-ID: <360a350d-5823-4773-bcdf-dedfe4751043@redhat.com>
Date: Wed, 17 Sep 2025 18:25:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [MPTCP next 10/12] mptcp: prevernt __mptcp_move_skbs()
 interferring with the fastpath
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1758039775.git.pabeni@redhat.com>
 <d5a0349baeeb725be8de01024dae64abc1a7499a.1758039775.git.pabeni@redhat.com>
 <44782f5f4b2fabb1a3ebe476de6b671270671244.camel@kernel.org>
 <a078369f-3dbb-49a0-9139-032912955829@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a078369f-3dbb-49a0-9139-032912955829@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qeDEdljUxJWef023eKOpqESVDhSmLqYLBJgLWx1peeo_1758126330
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/17/25 2:53 PM, Matthieu Baerts wrote:
> On 17/09/2025 05:39, Geliang Tang wrote:
>> On Tue, 2025-09-16 at 18:27 +0200, Paolo Abeni wrote:
>>> skbs will be left waiting in the subflow only in exceptional cases,
>>> we want to avoid messing with the fast path by unintentionally
>>> processing in __mptcp_move_skbs() packets landed into the subflows
>>> after the last check.
>>>
>>> Use a separate flag to mark delayed skbs and only process subflow
>>> with such flag set. Also add new mibs to track the exceptional
>>> events.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  net/mptcp/mib.c      |  2 ++
>>>  net/mptcp/mib.h      |  4 ++++
>>>  net/mptcp/protocol.c | 40 ++++++++++++----------------------------
>>>  net/mptcp/protocol.h |  1 +
>>>  4 files changed, 19 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>>> index cf879c188ca26..7af9d35cde884 100644
>>> --- a/net/mptcp/mib.c
>>> +++ b/net/mptcp/mib.c
>>> @@ -85,6 +85,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>>  	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
>>>  	SNMP_MIB_ITEM("SimultConnectFallback",
>>> MPTCP_MIB_SIMULTCONNFALLBACK),
>>>  	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
>>> +	SNMP_MIB_ITEM("RcvDelayed", MPTCP_MIB_RCVDELAYED),
>>> +	SNMP_MIB_ITEM("DelayedProcess", MPTCP_MIB_DELAYED_PROCESS),
>>>  	SNMP_MIB_SENTINEL
>>
>> I guess this line was accidentally pasted, which prevents this patch
>> from being applied.
> 
> FYI, this line has been removed recently by commit 35cb2da0abaf ("mptcp:
> snmp: do not use SNMP_MIB_SENTINEL anymore").
> 
> I manually fixed the conflict, and sent the series to the CI. I also
> restarted my syzkaller instances to validate your series.

Oh wow! many thanks! I though I pulled and rebased the series just
before submitting it, but perhaps PEBKAC hit again.

In any case I'll send a v2 to address the comments on other patches.

/P

