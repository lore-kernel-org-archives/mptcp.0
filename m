Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDD2EB873
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018402; cv=none; b=GWDhVD/pWyCEipMACHsPki1T8fFKGIYmCO+mH8tAIvYImwoc2VtVTczMsd5JHMP2/f/s4hyZ6k8pnFcuuneIJMCcH5YMVR5UQaYh1E1ETyQQgE7nStC8t2p6u9h4xSuyHfqZDf0dbMqTeJsevgpIfsBP0wLFZ6MuJm3jYhnG3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018402; c=relaxed/simple;
	bh=YxugdU2K9NDm5QN0qpwU62BpH9zAlGCaHMTkU8k07ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnL1H46gLYQm5gS1Es8tGRjzuXlgzpjU8IOqSq9rnRk1LelxMF7XR8o26Y1/6a3Vb3snmDXC/aMh4quIL+M9ou0E+glKMUOaVRDtoKbUayDFEI5fFntkG0UTgjTLwIR4DQLJ7LTwpttMp5fzUFOtb+3Rm+LNCVNztLY0ek/8j6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLKbj97b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLKbj97b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764018399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePzLhBUhUs3nmrkyB9IWAlYeUoFlgrM9MHWegC6p1nQ=;
	b=PLKbj97bI6MsTF3JbTiNcIU3TbMVgAwFLXWAPfh4lxXP6UGf+/Rwa+NL1vfGPj8cfFqeaV
	qn9IfbC6XSto+ufQPiu5h1rdwbaKaj8zf7ieuGqNyxudxiZ1blJ+KXrLtXfnfoR583fVJo
	+NxMoK9Md3cb04cKK9lyKsj2SVYn2yY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-qLO1PVdBNu-sLv0FAsMtXg-1; Mon, 24 Nov 2025 16:06:38 -0500
X-MC-Unique: qLO1PVdBNu-sLv0FAsMtXg-1
X-Mimecast-MFC-AGG-ID: qLO1PVdBNu-sLv0FAsMtXg_1764018397
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so21933925e9.3
        for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 13:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764018397; x=1764623197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePzLhBUhUs3nmrkyB9IWAlYeUoFlgrM9MHWegC6p1nQ=;
        b=XoBmuZr/xcABF9Ua2Sk2S2vCehQHSQDXpku64N9BjTXT9fnAVbF10rRVXWkuLuEELr
         T66ZfRLOsXI8tHplXadEizB0qgDcJNxianO2lznvv9J0/FMw037t8j+j3dK9j5CuQk1E
         RGoan71kmbBJRb2HUaF4urky8eVcNKsY1vZ3NAgi0N09tUjipDsXGcTa2cFf7my0dKIg
         w8JAlXLtip7dFwM8HV+fdJ1reZ7h5eJytXegRgGmziJtjNsxoR7Gh1nHG3YP9K2F4OKI
         TfZypH5rT3Yvwtvyy2YK8NB+EkSK4XHBBczaif5HTXGZvag74ddGomzig30fJxOQzbvZ
         ySng==
X-Forwarded-Encrypted: i=1; AJvYcCV1vvrAcfttVs4jAjIYrMmUwWtVzPx9t0wG0Ln3dyWene8znDndUhYkAgk4V+F9DMez4IELIA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8S4/kWpxasb07m3ehfU3UtmC/yt/jUEwfxraXPS8ADPvWGxjC
	uH0gNCGN/b0/gngH/uIzIGyWwwoOl8QG46Ebdz9TB+npRxhYTPW9SQ4B6Lk04KQcrAxNO7KIbzU
	Ykq3LveC10mbFD55PtDvp5nQXryQy+rPLmRpNRJOV55Aj8Lf5oUgeJ/G7R20vQkiG
X-Gm-Gg: ASbGnctSswsBBeV3Zd88ruu6uFRi3INP+0hdyiKw7r9/bjxjKCi/fcjxkKiEt5NDCir
	l7k85QH2WsNdCaZrjFeBBOKOoYz2KAFOdZditL3z7MNLWbxR7VxbKPBdtd2xU79FER7ZNEUFRlX
	Eef0NXOc86CCjvnR1+lW8EI5+s9/3YfBEwmuywkl1R4i8mFUhsjkHlC+8pMRKSYE7kQI7dKCts4
	GTLhd1DwDiWAhcOlvBt7zXkRvqWCkN4eBu7QEfo5+M9rVWErZTuHei6bcGyD81N1eV7ZU3CMy9y
	vePFR4duseVXlmi657pjclaCuV66Yl3qsSiEKyoog9v0rVGbG3cCajFvkm2HiJqgeg7WzTn1ntO
	d6XBg11e4EKyjxQ==
X-Received: by 2002:a05:600c:4583:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47904b2bcd7mr1987925e9.34.1764018396950;
        Mon, 24 Nov 2025 13:06:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIp6MN1zur2PHXGtlHNFrykrMeEJK8GQl2mTGKepPt4VBy0jTxlICnf0wTyQ14DG5eal8QlA==
X-Received: by 2002:a05:600c:4583:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47904b2bcd7mr1987785e9.34.1764018396590;
        Mon, 24 Nov 2025 13:06:36 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3af0ecsm217044555e9.9.2025.11.24.13.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 13:06:35 -0800 (PST)
Message-ID: <0c7e9f23-ea1a-48dd-957a-956dfb3d6dc4@redhat.com>
Date: Mon, 24 Nov 2025 22:06:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: clear scheduled subflows on retransmit
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
References: <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
 <fbd12dc4-ad95-46df-965b-43bf9de430ab@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <fbd12dc4-ad95-46df-965b-43bf9de430ab@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j5lEHACG5H2BuM0yHo3gDXug4XGA7TFRGGNNat61xJQ_1764018397
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/25 7:18 PM, Matthieu Baerts wrote:
> On 20/11/2025 23:16, Paolo Abeni wrote:
>> When __mptcp_retrans() kicks-in, it schedules one or more subflow for
>> retransmission, but such subflows could be actually left alone if there
>> is no more data to retransmit and/or in case of concurrent fallback.
>>
>> Scheduled subflows could be processed much later in time, i.e. when new
>> data will be transmitted, leading to bad subflow selection.
>>
>> Explicitly clear all scheduled subflows before leaving the retransmission
>> function.
>>
>> Fixes: ee2708aedad0 ("mptcp: use get_retrans wrapper")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 6f4220c8b5bb..3b327e9ccb78 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2763,7 +2763,7 @@ static void __mptcp_retrans(struct sock *sk)
>>  		}
>>  
>>  		if (!mptcp_send_head(sk))
>> -			return;
>> +			goto clear_scheduled;
>>  
>>  		goto reset_timer;
>>  	}
>> @@ -2794,7 +2794,7 @@ static void __mptcp_retrans(struct sock *sk)
>>  			if (__mptcp_check_fallback(msk)) {
>>  				spin_unlock_bh(&msk->fallback_lock);
>>  				release_sock(ssk);
>> -				return;
>> +				goto clear_scheduled;
>>  			}
>>  
>>  			while (info.sent < info.limit) {
>> @@ -2826,6 +2826,15 @@ static void __mptcp_retrans(struct sock *sk)
>>  
>>  	if (!mptcp_rtx_timer_pending(sk))
>>  		mptcp_reset_rtx_timer(sk);
>> +
>> +clear_scheduled:
>> +	/* If no rtx data was available or in case of fallback, there
> 
> When reading this comment, it sounds like a "return" could be added
> before this new label (clear_scheduled). Is it always needed to clear
> this flag or only in these two cases?

No, we can't add a return before 'clear_scheduled:'. At least the 'goto
reset_timer;' under the 'if (!dfrag) {' conditional above could reach
there with one or more subflows scheduled.

Cheers,

Paolo

