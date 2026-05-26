Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047291ADC97
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808589; cv=none; b=l4OW7/7QFu7JG6JnW3JRo6Ui0jovTi+bnpEM5L9sQyi3n3Z5rjnC9CDY5zrl/pRJNRnZxmGypeAknNYXWizs3yFIPsoaI5MgkM6FjRm+EhRWXjKaCZJ7fFW9vtFeZ/J75EtM/l7gdzSlqJ3zE82cniO6aGMqWoW8LRPDRbu921s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808589; c=relaxed/simple;
	bh=PjdvEBcGD5xmheBf6FtIGFHj1SObMjOBt3jTclYmiLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr4aXnpw1rSBpRHH4b13Bo+ewwBZppB1VU3vWj8B+2qBota5TdkrO2pOtoRjPuzFwHHLiJDCSvaKmKQOyEsqwoywM94Xbb2TDFMlm/X53w0YMHwheicGamQuNXidNRrxYwxUuCNggoerrbolJ7JOebZOv/f7pVZxS9NkYppPaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKtnFwmS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKtnFwmS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779808587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMDuUtjs92OX2yRxkv5i2B24D1RJrBhFiGWukTY5OSc=;
	b=FKtnFwmS7TriRn1UStonJ3b1ynhKB+3Ar2eYktto+D0VjSjfJ8NGUI3SlAH1oQ3Gex4Db7
	wMYDdOefg1ZxYAnvyOZ5YfY0blBqEKC3kStqxxRNXFoKsSq9ITRHFVbIgc2BudglztOp40
	A73Lwne9Lj/K+Z8wGmEjScR1OvYesR4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-j1ETC4jqNnWB57klLajLhQ-1; Tue, 26 May 2026 11:16:23 -0400
X-MC-Unique: j1ETC4jqNnWB57klLajLhQ-1
X-Mimecast-MFC-AGG-ID: j1ETC4jqNnWB57klLajLhQ_1779808582
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so8482999f8f.0
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 08:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808582; x=1780413382;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMDuUtjs92OX2yRxkv5i2B24D1RJrBhFiGWukTY5OSc=;
        b=g2eFRRzrip+WvuWLrL+r3wV1BBmF7RPR9bVNQSW+OezQzoAG5taS4VcsCjU1EUkXMW
         0VWPVR5yD3GX2wTG4AfTAKN4dNVj+p/BA9C0s4uZggO7NshalhLgXZy28TFaHNW2q+sE
         d1S2hWsQv0FhHfsZrv4IC5zO/SgSutSdNneoAWsrvTKoZDzXAoAoX7YGUCGy0bSVTnay
         gndCoIfTg54y0L9JNrUF+cFf5Aw+U73hdGVabyFe1TJaB92AUKXubdMHaMrfg64v0xVb
         8Xk5FXmtUSsUl8tHgks7APoU6KCTUUZIjIuN8T8jPHf4bKky0MHb49EeGowA/lARQWsq
         1aDw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ach0viFSZamHb+ltxSykyw3qE3biGkJQYfWBPCercZK0AQjl3qWIxiGcWEUFa59GN6caOCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YysaNuNU9WtWPXmPeAe35NO2jvAwiKyKv0brXLhZUIWMdyBMyUr
	uZrXGKdg+CfJeFyxJKCjyVMGhb/OP07Lyy2Id6D2FCLfgcedkj5Z0aFnTkI4J6rAVgzgnognB62
	HloPMUFDElRj0okCobcg3wehvFStdbnttR/9aK2evb8EECOqdntPibXNmTnkjiqFc
X-Gm-Gg: Acq92OHnaB2tkqtpm9UJHQGGi4XyQQhhLGPkBaEjK+Yfm35MzfpJf7SHHChL/rOKk3C
	GikWhMxztBNUYsbPzkcCfY66vIrJ0qvSGf6SQjyQAD3w/y9xa5X5Ddir9R1ENPUVyElXtCgoEkf
	bWAwASBd8Y9eULFaQCNePFAjZuGpEqKov3ypSw5yf/JBkAwMCmdBba4q05DMYoysGcprh5JxnCT
	0TY2iTJtAQ2ULA6/8BiD/VWc9MMlwR0+RFNy81p8yHjfIlXHqFvCLEtRQs3k/5tTJ7LATLrQDW4
	BWP28ClAhH9vgX7Qeeq7APe2GbCI2vfS0rczLvoi1jx0E5aWGadaJaRjXYw7NvMeVy1D9bxdjET
	+PFvAt+MxO6eOQkU/VMBZMmTusSr+jTD2bVTzgkrGMUpSk13fNnW5+xuASw==
X-Received: by 2002:a5d:5e84:0:b0:45e:6550:9557 with SMTP id ffacd0b85a97d-45eb38af95dmr32660512f8f.31.1779808582384;
        Tue, 26 May 2026 08:16:22 -0700 (PDT)
X-Received: by 2002:a5d:5e84:0:b0:45e:6550:9557 with SMTP id ffacd0b85a97d-45eb38af95dmr32660453f8f.31.1779808581948;
        Tue, 26 May 2026 08:16:21 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d47b82sm36306822f8f.19.2026.05.26.08.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 08:16:21 -0700 (PDT)
Message-ID: <d625e428-cdc1-4443-a6e8-e779c7282664@redhat.com>
Date: Tue, 26 May 2026 17:16:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mptcp-next 4/9] mptcp: allow subflow rcv wnd to shrink
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <661603fa10737a624bba854fb2515c7abb129a80.1779485511.git.pabeni@redhat.com>
 <a3849de4-a4da-40e5-85bd-ebeb7e395fac@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a3849de4-a4da-40e5-85bd-ebeb7e395fac@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yLQsS8UKxsX4RnjvMmLR0i9vtsGhLhI04DlxDCxu53U_1779808582
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 9:48 AM, Matthieu Baerts wrote:
> On 23/05/2026 07:43, Paolo Abeni wrote:
>> In MPTCP connection, the `window` field in the TCP header refers to the
>> MPTCP-level rcv_nxt and it's right edge should not move backward. Such
>> constraint is enforced at DSS option generation time.
>>
>> At the same time, the TCP stack ensures independently that the TCP-level
>> rcv wnd right's edge does not move backward. That in turn causes artificial
>> inflating of the MPTCP rcv window when the incoming data is acked at the
>> TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).
>>
>> As a consequence, the incoming traffic can exceed the receiver rcvbuf size
>> even when the sender is not misbehaving.
>>
>> Prevent such scenario forcibly allowing the TCP subflow to shrink the
>> TCP-level rcv wnd regardless of the current netns setting.
>>
>> Fixes: f3589be0c420 ("mptcp: never shrink offered window")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/options.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 4d72f286a485..97ea4aa37b33 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -566,6 +566,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>  {
>>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>> +	struct tcp_sock *tp = tcp_sk(sk);
>>  	unsigned int dss_size = 0;
>>  	struct mptcp_ext *mpext;
>>  	unsigned int ack_size;
>> @@ -614,6 +615,12 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>  	if (dss_size == 0)
>>  		ack_size += TCPOLEN_MPTCP_DSS_BASE;
>>  
>> +	/* The caller is __tcp_transmit_skb(), and will compute the new rcv
>> +	 * wnd soon: ensure that the window can shrink.
>> +	 */
>> +	if (skb)
>> +		tp->rcv_wnd = tp->rcv_nxt - tp->rcv_wup;
> 
> Do you need to call tcp_update_max_rcv_wnd_seq() after having updated
> rcv_wnd?

I think it's not needed here, because the above will never move
rightwards the rcv_wnd - it sets the current wnd to zero.

Note that LINUX_MIB_TCPFROMZEROWINDOWADV/LINUX_MIB_TCPTOZEROWINDOWADV
for mptcp subflow will be incorrect - as they are already due to mptcp
changing rcv_wnd after such accounting.

/P

