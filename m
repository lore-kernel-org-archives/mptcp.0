Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F0302CB2
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187179; cv=none; b=rtUOyH5mZMs5BDt+OoX53NHduVDHnapNi2GnEBLPU9grq6qrPOfSD2ds5WBhQaO02VZkvL34dOubXDSKx6ZBmFz1b8gz8Uq1ok48AV7hlijVbqDZGzRwaXPQ+UD/vDq1uUaryAu9nAfQPs7snpkpOnzAu66WFeyox5noR5kIjSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187179; c=relaxed/simple;
	bh=zuJP7tn0pWr0ECqBMOQaE/4jLIofQdZLwFsAlAJrOG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTMpgt8MwLzJPacoczgC7DZavJ3CigXZTQWr1koZAygfKsjEP+9kZBIUw17m/DkpbEoxvFRAVbwdWPtTyk8pNnWL5JDKNnIPN1Pty68JHR0j0hOfBAVEOQhoPplzt7twi8mHhTSiXfXcczsVwACuL3i5eCa/5VqyjU7tEtJlhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nub4kfi9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nub4kfi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762187176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4p3tZDJbRbWNVI2oLBoVouDCAUQN2nV4TCtIOlWoc4=;
	b=Nub4kfi9EKfudsAY68zSkdeiSIfsPWYi/8e38aXJq+g0ecvXG6an5PKLoz5pW926jlcE43
	AvD839NHFofOn1LGyBanBinnIC2x68GOSIkJ9wsLZSTZokZApn86RGJrcClDeMPZ2FE1X2
	UlDXP+oY8Iy5UqVWgAZxYO7RYl6/dT0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-hv5ZBepMNVaA18lR3DAKKg-1; Mon, 03 Nov 2025 11:26:15 -0500
X-MC-Unique: hv5ZBepMNVaA18lR3DAKKg-1
X-Mimecast-MFC-AGG-ID: hv5ZBepMNVaA18lR3DAKKg_1762187174
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso2709301f8f.0
        for <mptcp@lists.linux.dev>; Mon, 03 Nov 2025 08:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187174; x=1762791974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4p3tZDJbRbWNVI2oLBoVouDCAUQN2nV4TCtIOlWoc4=;
        b=PWF/VxMhrPW7leTivY0xffcuyQURIy97BTEf5xMexV/9FgMaT/QYqfu2POPdakyIcN
         hRmyzDp2hfgIsLwuDfITq2mON2vtc72feAhyTAZMurnUk5CA1JWIOWFprL6uF2LPKvm1
         ALJ/MEWyyyJbTYVDRhdZE3zOQA/TTDyu88EnClrkJGGHgDwnss+/Mx+Wrx7DcNVf63Ez
         +G0IE6IH7eG/daiTe963sP+le4RcAuTqua0Wixr8pC+HGYmv0mFkOWcvWyN0BdofS1S2
         Vd1VBwaN/taUQwNRWi8lLy6rq+7abu1/2lCzhLebRX6U8Q1RzXZGYeWPD7BtGN/RV5tL
         uKJQ==
X-Gm-Message-State: AOJu0YxWBOFFbVGO8iwJy0oy6WE4CJGeofStXzoV63wBiFKKw4b+4AeB
	aDBUpWerngRR4kHSJsssb5nL6mRecemgOi3W7ZSHzrN9uXY31xiLZVjYvBkclbCirvdkqKAMt19
	8dee/iN1lld4xHcZIUu7Aa8xCINBwKHDIdEEu47h8GEpkdHSd9OLlW0X0S6DMDIcq
X-Gm-Gg: ASbGncu8b+XDtizntWQAgCkDi+MXqhnOQo68hnfaCxAN470qVN+JDy2yusIw3MM35NY
	zn5BQyqHy5MUK4vys3eJldGLeE4ulyj0f0GGuvyJL4Y2/fSo7OP5wp3YPIN6Bdf9OtPoYq0LHD/
	nRKm1jYYCiWQW/UzC960juHQo3LcsMic6+0991pDqtxsjF46GT2NMtV51blfkMr2v4ekryS8Jbz
	e3k5symjkFoFbHIA4Fs7eGwbbTkZcYaNE/hwX34rJUoai7Ztr9TU6NPsEgjgdFcCgpX9/RrNvhf
	iT7b+Lf6P0BVV6jWfKm5xJWnZ3a/41iALmWdCxGls3zWPG+aRfAiNmjDdnl6nzdkr4mtBaHb4AJ
	UAStICVXzdc7b1ECw74XDpF8vPbE4eBUnZOWSGxRN9omd
X-Received: by 2002:a05:6000:615:b0:429:bc68:6ca0 with SMTP id ffacd0b85a97d-429bc686fd5mr12272663f8f.4.1762187174256;
        Mon, 03 Nov 2025 08:26:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNaTfZgUnFf/KWAsKrnOqQbjsssE1Z59hIp4TmWstR2rDUOz7hxDAEAtO6PTxTTtWEllIw9w==
X-Received: by 2002:a05:6000:615:b0:429:bc68:6ca0 with SMTP id ffacd0b85a97d-429bc686fd5mr12272640f8f.4.1762187173837;
        Mon, 03 Nov 2025 08:26:13 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c85ad08esm16088429f8f.19.2025.11.03.08.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:26:13 -0800 (PST)
Message-ID: <73dcbc22-6f3c-46a1-9e56-1b0734f9f56a@redhat.com>
Date: Mon, 3 Nov 2025 17:26:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESENT v7 mptcp-next 2/4] mptcp: borrow forward memory
 from subflow
To: Mat Martineau <martineau@kernel.org>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, geliang@kernel.org
References: <cover.1761576117.git.pabeni@redhat.com>
 <501fc84688c32f846e262a9fd44683afa73ea509.1761576117.git.pabeni@redhat.com>
 <77fb4c39-fb48-1f88-614d-0cec18e9c687@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <77fb4c39-fb48-1f88-614d-0cec18e9c687@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QcQQGazEqxgEu2KNMn3iLZndGqlD4ti3OSd-wtQSa_0_1762187174
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 11:44 PM, Mat Martineau wrote:
> On Mon, 27 Oct 2025, Paolo Abeni wrote:
>> @@ -646,6 +647,28 @@ mptcp_send_active_reset_reason(struct sock *sk)
>> 	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
>> }
>>
>> +static inline void mptcp_borrow_fwdmem(struct sock *sk, struct sk_buff *skb)
>> +{
>> +	struct sock *ssk = skb->sk;
>> +
>> +	/* The subflow just lend the skb fwd memory, and we know that the skb
>> +	 * is only accounted on the incoming subflow rcvbuf.
>> +	 */
>> +	skb->sk = NULL;
> 
> Looks like the intent is to always pair mptcp_subflow_lend_fwd() with 
> mptcp_borrow_fwdmem() (in that order).
> 
> Given that skb->sk and skb->destructor are usually cleared together, 
> should mptcp_borrow_fwdmem() have a WARN_ON_ONCE(skb->destructor)? Or is 
> that excessive paranoia?
I thought about that, and it indeed it felt a little bit paranoid. No
strong opinion against adding it anyway.

Please LMK if you prefer a new version.

/P

