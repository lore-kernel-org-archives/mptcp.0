Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EDB1D5154
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763972791; cv=none; b=A6yGfwj2wbJW5gxaBO6Ylst881rRsXV2Ol/45quLWeygT11h6HgiZwNaOUGxqfDjQ0VZcde2hix0+4wiD7qFXt3prTF8flg9JZ9Zuf1Rd5BekzL0TS+pe2EZIZhcfr3xDxzpZ1o+x1ZmNmzCtZ0TmGd2SdiprdTW9D9h/18diN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763972791; c=relaxed/simple;
	bh=Kh6IeM981o0KBtN5h9yZJO5odVpOmVW6a4cQh69fRxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfefuTcsL53RIeGPLgj6IVWnaruX9LeLVEqvb1Q2FmArYsVpSukDf6/6yiNpZYLQS8n/jNPK5C5grIACx60gwnMC8JCHIsK39M+9ZbgBrWEtI7oJx2nM8jeYbmhfo7OTKQRAwjFx762cuDqYgiI+MbaV9E/dCmGCWoctzi+eU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qp0a8+Wt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qp0a8+Wt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763972788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K29t5X6Iilyoq5HyyMg1WygdeftRZb01MBBrNVkBfwQ=;
	b=Qp0a8+WtmFVhvsDZA2nodh/CxCtgxrl4ZsQhyO5gFB93452IGIoDwmHHomTeHOlmHx49z+
	mDTbukyKY/4/T7zTUhy2HowwFKHX8B8iE0rjFwpDVfLab99KqS0Ddiw+GzyKRDXEaXasAs
	gzM2qKF1ztRm+NqwehqSe9+ZaR30W1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-lk4lOKwCMwOb63KkKLbZpA-1; Mon, 24 Nov 2025 03:26:26 -0500
X-MC-Unique: lk4lOKwCMwOb63KkKLbZpA-1
X-Mimecast-MFC-AGG-ID: lk4lOKwCMwOb63KkKLbZpA_1763972785
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so33701275e9.2
        for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 00:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763972785; x=1764577585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K29t5X6Iilyoq5HyyMg1WygdeftRZb01MBBrNVkBfwQ=;
        b=aW62rKO0spIPiES+Jk6GAXqTu7JXndFncSrQ6IH0mPWgKSWPltFjoXk5yGlukowQ2K
         5d2rcVGauX2INa4/iApr/kRTDlfIpgfifN+zVp1hgq7sgtPmAyNX1Mv/8hc+fLN5uTrw
         VysCQgltilNwZcNO+AgRwQCbO3vSI92KyfL6AZliv7To06htb9kdyTByPBkJEQ/WtMK6
         D7EKtgfq4EZ63NDT+zkW5mua8CFL6Xk9la/qJfPeHhr2KIgasYXU5g5R0uzcmsK1/Ybo
         rBo3jv7Rc4CunSszEz1g/xnnQ+PVkLMK/wM5S4QT7BLG10DPNUrt9yZT66eJvIHQnGuS
         FuDA==
X-Forwarded-Encrypted: i=1; AJvYcCWigmuTq2IMm4pc6NElfHCdPYVCoq8hOHFMpnKP46rJdI5gIS18KoyXCZRwTDc7l2S/mt/L+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6WD9+H5EPFAnRjZDj4l3f72ifXzhzfkyPsQC6nVHSHNXFIyeK
	jcvqYpAGCbHcl7ci3B27G0gAMN0yoP2FVntiu8x4s+pD9Nf76CstWZMKiwPjvnxH0kSP/SEyhLt
	xmS+t+5L9fjRStbMYyugyUdgupNMy+rtCdz1xuufyp/i/0R/bMnBYHOvc
X-Gm-Gg: ASbGncseUPmS4QpkUf2vva41BH878z3/95M26TC5PHruG44W3U5n29Kvk1w2VAK8287
	AvaJPY4EQxFi+tu/v5O4pv5R2ncVWWVnY9v7eZaitU96GeSKXQO7AvibzYr5RDn/ukd/OKreG2b
	JeS7Y4IMBusZ32QjoKoEWgTxznnVvQni68dk5HuGo8XtetdyxCn6lWHVhoGk1kpvB3B3SJfS3c2
	15L1t6FxJ9hp8ukzlER5ngl7HAtOmo/xZxAcEJpi9ZANuz+flIphnzvKznntRUswIss9DHdsvY4
	dQcEr4cJEX/ej8E2rtO2AgkkgE5E2t4GkDgsWPWTwwi/IWXzbPDLvxP8RNXSp/r4Pw44fNc9jk/
	yE45aWAv4WqTSYQ==
X-Received: by 2002:a05:600c:1993:b0:477:abea:901c with SMTP id 5b1f17b1804b1-477c0184be0mr102210725e9.11.1763972785346;
        Mon, 24 Nov 2025 00:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfFZ3PNoEhmYRQof+lb6UCgJDZYeU37kgcxbcFJZBZ6X8mSYmG5g+cQFdAb0Gq2NetWI4l/g==
X-Received: by 2002:a05:600c:1993:b0:477:abea:901c with SMTP id 5b1f17b1804b1-477c0184be0mr102210525e9.11.1763972784915;
        Mon, 24 Nov 2025 00:26:24 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf22dfc1sm182742565e9.12.2025.11.24.00.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 00:26:23 -0800 (PST)
Message-ID: <ba08e829-009e-4858-ad25-b7d6b0b6e20e@redhat.com>
Date: Mon, 24 Nov 2025 09:26:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: clear scheduled subflows on retransmit
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
References: <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
 <f53b9be4a701bf2696a96fb316f538aca2566bdf.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f53b9be4a701bf2696a96fb316f538aca2566bdf.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H3Sh3h7_NFxrkgovG-Sbt6ZmOAtqnrovO05g_DAN_Lk_1763972785
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/22/25 1:59 PM, Geliang Tang wrote:
> On Thu, 2025-11-20 at 23:16 +0100, Paolo Abeni wrote:
>> When __mptcp_retrans() kicks-in, it schedules one or more subflow for
>> retransmission, but such subflows could be actually left alone if
>> there
>> is no more data to retransmit and/or in case of concurrent fallback.
>>
>> Scheduled subflows could be processed much later in time, i.e. when
>> new
>> data will be transmitted, leading to bad subflow selection.
>>
>> Explicitly clear all scheduled subflows before leaving the
>> retransmission
>> function.
>>
>> Fixes: ee2708aedad0 ("mptcp: use get_retrans wrapper")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 6f4220c8b5bb..3b327e9ccb78 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2763,7 +2763,7 @@ static void __mptcp_retrans(struct sock *sk)
>>  		}
>>  
>>  		if (!mptcp_send_head(sk))
>> -			return;
>> +			goto clear_scheduled;
>>  
>>  		goto reset_timer;
>>  	}
>> @@ -2794,7 +2794,7 @@ static void __mptcp_retrans(struct sock *sk)
>>  			if (__mptcp_check_fallback(msk)) {
>>  				spin_unlock_bh(&msk->fallback_lock);
>>  				release_sock(ssk);
>> -				return;
>> +				goto clear_scheduled;
>>  			}
>>  
>>  			while (info.sent < info.limit) {
>> @@ -2826,6 +2826,15 @@ static void __mptcp_retrans(struct sock *sk)
>>  
>>  	if (!mptcp_rtx_timer_pending(sk))
>>  		mptcp_reset_rtx_timer(sk);
>> +
>> +clear_scheduled:
>> +	/* If no rtx data was available or in case of fallback,
>> there
>> +	 * could be left-over scheduled subflows; clear them all
>> +	 * or later xmit could use bad ones
>> +	 */
>> +	mptcp_for_each_subflow(msk, subflow)
>> +		if (READ_ONCE(subflow->scheduled))
>> +			mptcp_subflow_set_scheduled(subflow, false);
>>  }
> 
> If this __mptcp_retrans() needs to clear scheduled subflows, then
> shouldn't similar this clear_scheduled operations also be added at the
> end of both the __mptcp_push_pending() and
> __mptcp_subflow_push_pending()?

AFAICS none of such functions can currently schedule some subflows and
terminate without descheduling/processing all of them; additional checks
there are not needed.

I think it's better to avoid adding unneeded tests in the fastpath (also
there is a generic guidance from netdev against defensive programming
[it hides bug, increases bloat and makes the code less readable]).

/P

