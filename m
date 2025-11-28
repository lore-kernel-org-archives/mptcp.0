Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E332222CA
	for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319675; cv=none; b=P6w6URd2dRiOm1CsRt+RDi/ZbPLXPd9lq2GSc9X8tV3D1l6FNOubuPjQgY/PoJSkdlSMnsA4nXlg+nMR8z1a70vHl6nAk0Qsf/s1y/maHKM38qeiPZU9U2XaXASIJzvZCmGjCKy8GNCx36yT7moNI9QTEcECBGZtH9X9nl7Ncl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319675; c=relaxed/simple;
	bh=7HdR08tZ97Adnn8sgx8wyu7sFToLHnyg/vrX3aAqjzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFMVhSn0hWrA+mkSACmJxQG+G9zvMyAmPJwAdAQkma+ztY0wRtYxyY/GpGJGIFiMn5dp5i76Qu7BvVpzD5F9BjRw3GbVc7xma7sBVaOStEcwTUXp5xjavqRKhQkvO2UGvdPbbEERHpLSVIQ4n6YgVgTSqkXTRigcGh0uQsudyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkmsJe1L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkmsJe1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764319671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3X7QHxZHMIz1TWt63r0YLsKzmqhxA5mv9UvfKLIscy8=;
	b=ZkmsJe1LY0XxyJ+5e+/N8kW2j4cqBAIZM3HGQXo0ER8YZ4rLBU2UrOBZhTf6k65+TEOVpH
	ElqCFbOauBcPIGQDuH3tUMp+rw8lNEZNvTl7+GYQOC/ksvbYWizJ6APAkozTlTpOul2ebN
	OxyzQRs2wX3cx8Brt+IQaxTcFmJfEs8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-s7IJ0tywNtqwg0j7mk5-Dw-1; Fri, 28 Nov 2025 03:47:49 -0500
X-MC-Unique: s7IJ0tywNtqwg0j7mk5-Dw-1
X-Mimecast-MFC-AGG-ID: s7IJ0tywNtqwg0j7mk5-Dw_1764319668
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779da35d27so17320925e9.3
        for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 00:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764319668; x=1764924468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3X7QHxZHMIz1TWt63r0YLsKzmqhxA5mv9UvfKLIscy8=;
        b=MTcEoHPKmRuxbs9sgSjY5B11vyPelOu2L8U44RWO80O8BSV6gPvPgQ9OzHrStkMNab
         K3vWBBBeI9rBH3w9luNp13WHNI9ipB9tNvo/4yrsiUOnGc+A9d/wQ9IHmFphANYoBo0f
         1+Qi1Q4OJ29sO7bOTjR/wubRraMUVODnc8aE5O3WSChfayHXWLfPKobZ07Sw9lSNBD2m
         QSlHLHwDoJ/6tsXzVSIQ6VccN+RD2gf9wsNjQ+yt03QmHyApmyprNHQSDRqHXoTRs2ey
         zYtSrx3mrtUomtpMECNuqIL1uPDz3LNrOdD1p1qNEgg9fG3ss/G54U/KtZ0fZJJUI0bO
         G8ig==
X-Gm-Message-State: AOJu0YyZVxQIVQFMeM6Me76EgD6FnXqNC+EGq2x9yMMrpoDBazTZRv6a
	J9A5sOxsZOJsJdVPqqEZbZ96myjFxFSkZknP3PSrcSdXr/URlShTPpz4k9afth9p1EOYVbbwVBG
	4q2rOpa8gICJ8zQWblYJZvTK/pztn0c6wtpdauetSPAipwsqLCK97H9Az
X-Gm-Gg: ASbGnct930G0e1Def2Jf9amTCnfHeqz0tBjuZQJ6phbqcuAGhy4qkvDDWr/XU5glrkE
	2OsoIZdlHN/AZX/UsVMyqnFrgycyWog0JP6eUFxtwBE4s8IvG4qn6u55wA6T45aeuw1TOlFmogR
	uSZ6NOe5xClDYoVA0ItEsdL25IseukIGvB19OSC+Zi42hXneWtUmrr8pNWuM3wpwHc3u+u2gjUh
	C0dXEe20SOiNDyunWzSVTojDbcA69/68BS/nZppZxhug9DSXp1feHrKNcs2t5lXPAN8IhtM2kWD
	c32KfCeYSqF5azNWcxKyBTbtwgGXVyX9gEg4yVd/d06h9QKCbAJFIw+KZCqqfc6g0zgMc1KYYGD
	/PELvNEM0RDvi+A==
X-Received: by 2002:a05:600c:6287:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47904acef7cmr123349255e9.2.1764319668029;
        Fri, 28 Nov 2025 00:47:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgNSspIbu1jtaHxi74I9/hIrpVd98AbAQZWp5YQAaKUj/5kY1XC2BpY2GrwUa7d65d324KJg==
X-Received: by 2002:a05:600c:6287:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47904acef7cmr123348995e9.2.1764319667538;
        Fri, 28 Nov 2025 00:47:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791116c0acsm74929955e9.7.2025.11.28.00.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 00:47:47 -0800 (PST)
Message-ID: <7e85ed1a-3072-4230-a14f-b7eecdf2d4d2@redhat.com>
Date: Fri, 28 Nov 2025 09:47:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 mptcp-next 5/6] mptcp: better mptcp-level RTT estimator
To: Matthieu Baerts <matttbe@kernel.org>, martineau@kernel.org
Cc: mptcp@lists.linux.dev
References: <cover.1763625391.git.pabeni@redhat.com>
 <6ffc28b03d35f1b5698ff9ed6b22bd3e82fc81be.1763625391.git.pabeni@redhat.com>
 <08ca5b33-8592-4060-9211-ecbef30cda0e@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <08ca5b33-8592-4060-9211-ecbef30cda0e@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PNIoCCMsqtsivdu7hrlshxXzXcM5Kj3pjbYZxyvHyzg_1764319668
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 7:13 PM, Matthieu Baerts wrote:
> On 20/11/2025 09:39, Paolo Abeni wrote:
>> The current MPTCP-level RTT estimator has several issues. On high speed
>> links, the MPTCP-level receive buffer auto-tuning happens with a frequency
>> well above the TCP-level's one. That in turn can cause excessive/unneeded
>> receive buffer increase.
>>
>> On such links, the initial rtt_us value is considerably higher
>> than the actual delay, and the current mptcp_rcv_space_adjust() updates
>> msk->rcvq_space.rtt_us with a period equal to the such field previous
>> value. If the initial rtt_us is 40ms, its first update will happen after
>> 40ms, even if the subflows see actual RTT orders of magnitude lower.
>>
>> Additionally:
>> - setting the msk rtt to the maximum among all the subflows RTTs makes DRS
>> constantly overshooting the rcvbuf size when a subflow has considerable
>> higher latency than the other(s).
>>
>> - during unidirectional bulk transfers with multiple active subflows, the
>> TCP-level RTT estimator occasionally sees considerably higher value than
>> the real link delay, i.e. when the packet scheduler reacts to an incoming
>> ack on given subflow pushing data on a different subflow.
>>
>> - currently inactive but still open subflows (i.e. switched to backup mode)
>> are always considered when computing the msk-level rtt.
>>
>> Address the all the issues above with a more accurate RTT estimation
>> strategy: the MPTCP-level RTT is set to the minimum of all the subflows
>> actually feeding data into the MPTCP receive buffer, using a small sliding
>> window.
> 
> (...)
> 
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index ee0dbd6dbacf..b392d7855928 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -269,6 +269,13 @@ struct mptcp_data_frag {
>>  	struct page *page;
>>  };
>>  
>> +/* Arbitrary compromise between as low as possible to react timely to subflow
>> + * close event and as big as possible to avoid being fouled by biased large
>> + * samples due to peer sending data on a different subflow WRT to the incoming
>> + * ack.
>> + */
>> +#define MPTCP_RTT_SAMPLES	5
>> +
>>  /* MPTCP connection sock */
>>  struct mptcp_sock {
>>  	/* inet_connection_sock must be the first member */
>> @@ -340,11 +347,17 @@ struct mptcp_sock {
>>  				 */
>>  	struct mptcp_pm_data	pm;
>>  	struct mptcp_sched_ops	*sched;
>> +
>> +	/* Most recent rtt_us observed by in use incoming subflows. */
>> +	struct {
>> +		u32	samples[MPTCP_RTT_SAMPLES];
>> +		u32	next_sample;
>> +	} rcv_rtt_est;
> 
> I'm sorry to react only now, I didn't manage to follow this in details,
> but I have one question: why not using a smooth RTT [1]? Is it because
> the goal is to mix data from the active/recently used subflows and only
> to take the minimum, and not "combining" RTT from different subflows?
> 
> [1] https://datatracker.ietf.org/doc/rfc6298/
>     srtt = old * (1-alpha) + new * alpha   # alpha is 1/8 in RFC6298

TCP already use EWMA for rtt; the values seen by MPTCP on each subflow
went already into such processing.

If there is a single subflow, doing again EWMA should only cause slower
reactions.

If there are multiple subflows, we really want the min() not the
smoothed average, because:

- there are high spikes caused by the mptcp packet scheduler: we want to
entirely filter them out, while EWMA will make them contributing the the
estimate and results are very visible (negatively) in my experiments.

- different subflows can have very different rtt (say 1ms vs 100ms). We
really want the minimum, otherwise DRS will be fouled/the rcvbuf will
"explode"

/P

