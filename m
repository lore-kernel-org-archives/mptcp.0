Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB821ACDFD
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055151; cv=none; b=dkXVSeGyl4oK5gE4AIHHIdTVEHsuQYZYEnE0goZlNI9IIsM7ue5vr8JR0f4FjmBXGTzjKuKc4FVIYDEsEF9Qu1GChRFdyj7xFyIxePAlPyU8s2ja6pq+EXiCQiorsQfj/mkeg7OZWkdDkaXUXXJ0XOUsGCD4+F1CN4Yg30NZtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055151; c=relaxed/simple;
	bh=BTFaMewXJ1stYE78k3gi/tyTyB2pd4K0jTnFTC373fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kg5kMfrttSrocUxARiGEPBhfkP2l3psL+7qsCdXliC/2zABdxiU21Lyp1sqiYBiP4B7oyfXMAvLa33U6I2UuH7CB3TOOnDMSWzZCY/AFGc5FiwYEz6UvflbiTB5Dsg+ic7fETP7mvxTbWptmKolaTYdoGCAR+0vANdBrQnCl0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zq/CqN+R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zq/CqN+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763055148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lysE2EIMdxGpVP+Vy3RPJf2fQVXDxIz8c5ImJRVZb0U=;
	b=Zq/CqN+RLqvLILgrJG+qtvvJ8g2V7gNtDIj8Q/Meho2BlOw3mkmrN+930VN50wN7HKTc+K
	k04n4oOLj8hledTLxRc0dLFih2alMhgj810932qIXN8WXWmcVm3SxCqHMWxgQOdd92layq
	0IzmyPhSyesC4ZoPKSbLguSL4RXXzB4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-1JoOSB07OteR5Pu0J-yhgA-1; Thu, 13 Nov 2025 12:32:27 -0500
X-MC-Unique: 1JoOSB07OteR5Pu0J-yhgA-1
X-Mimecast-MFC-AGG-ID: 1JoOSB07OteR5Pu0J-yhgA_1763055146
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47775585257so9528785e9.1
        for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 09:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763055146; x=1763659946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lysE2EIMdxGpVP+Vy3RPJf2fQVXDxIz8c5ImJRVZb0U=;
        b=ZmYs+EtulU1XZA84Cv4vtglltw94brNssHX20jqMK313uvFo9m7pQM52u4Wz4MmUMA
         F59e0PL8Go9+IVhLh6xP5I+2IV3jeokdVbcROEG7Oy328VmRh8xU0DF83+XAMTyGBu2I
         t6nMPRW42cGmLR4sTf4GIopr0ARjsF5mE8MYjemYGddlxRss+Sj59EQv/j7P1TtPoklM
         y8gCQcisKXGbq/OxMmIqRj1BKz4IoC5+buZ8haGWz0TgW4arQiXQoV4TdmpCvI51sP+b
         3bfKdH/wPuC4rtULSC1/AqYMvG5my5qj3H8f0XiO8oE/75cj0o8MQ2Owg+CVLRBoSwcx
         0UlA==
X-Forwarded-Encrypted: i=1; AJvYcCWqX58E+ZoGs4UnSQs4FBwsJw7QPbU7b7PSeYXvoh3UvTWVi2cnXG/tRRUWQVHvpm9nnS63pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YywAxnkftAxwCunJNJY6w8QZhAv62ziWqhb/udnC4nfD7YF60NH
	gA2G4Db1BokuP/OymoCx4n7+kiqGRwkCryi+1/09SsrMEBjl0Xo+bikxD1CNnZ6lMj7KXhZeDJs
	HXQsrgamZLp8ifGOVf9wyJneaQCViUddBX22pHKanKbr4lNtZrw+/TY6I
X-Gm-Gg: ASbGnctRE1H5WfuhP5POw0+/gQ4xpIKMAU/Fvoz4L9JQvWj4k8g6Qnlqzj39/6ekkvr
	SC9PSBJkaJNJe0sf4zW3eVJSzTshBBgjCUPRYq2o04YiSS202SN1L6xv88klJxFVQ04bsv532Si
	vz5d3Kwhu9t+OcxzqyrAuIJgd1cSaNy3S+k0uDkC0RvjfVs2EWtG2AOw8xtR1yzJYT/2lXiqiGN
	fx477ph7fQNF9Dzs5SORfUNnguMukTnlkKOZTLgpY2XB2ybVtFxHSdycr2VX5m3B1cCMllBPv+Q
	AWQiL55AeRkrD+2w/gfiuvVF9OoKoiXj1gsIW56SuA1w/30M6FKotmupWGRS8AkDtU+bHGSJA28
	zBX15mXbIlDfq
X-Received: by 2002:a05:600c:1f8e:b0:471:989:9d85 with SMTP id 5b1f17b1804b1-4778fea2d11mr3008765e9.19.1763055146040;
        Thu, 13 Nov 2025 09:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ4jx8S9U4/IgESbMpdOq79zMnZ9Q+GlfuOI44j+YWLHq5TJRQmdOUbaxcDvmTvXAkOpsGkg==
X-Received: by 2002:a05:600c:1f8e:b0:471:989:9d85 with SMTP id 5b1f17b1804b1-4778fea2d11mr3008495e9.19.1763055145581;
        Thu, 13 Nov 2025 09:32:25 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f29c5fsm4970762f8f.46.2025.11.13.09.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 09:32:25 -0800 (PST)
Message-ID: <6e8bb6a1-0c96-4fa5-b8bf-cd0253e4450e@redhat.com>
Date: Thu, 13 Nov 2025 18:32:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-net 1/2] mptcp: do not fallback when OoO is
 present
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1762845791.git.pabeni@redhat.com>
 <fec239b14fa74d96fee25928de089de45f2c99ef.1762845791.git.pabeni@redhat.com>
 <1929f39e-b3e5-437d-b8da-71e3c7e6f36b@kernel.org>
 <686e7b33-00c5-47dd-af4a-8ac3014869b4@redhat.com>
 <3990718e-e4a8-4eb2-965e-02847bb339c0@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3990718e-e4a8-4eb2-965e-02847bb339c0@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E7421WRPqmX0RwdIo9Efm9twNU1H3XnJ21BbEvc9OgA_1763055146
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 10:08 AM, Matthieu Baerts wrote:
> On 13/11/2025 01:02, Paolo Abeni wrote:
>> On 11/11/25 6:50 PM, Matthieu Baerts wrote:
>>> On 11/11/2025 08:24, Paolo Abeni wrote:
>>>> In case of DSS corruption, the MPTCP protocol tries to avoid the
>>>> subflow reset if fallback is possible. Such corruptions happen in
>>>> the receive path; to ensure fallback is possible the stack additionally
>>>> need to check for OoO data, otherwise the fallback will break the data
>>>> stream.
>>>
>>> Thank you for the fix!
>>>> Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/598
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>> Note: this does not avoid the WARN(), but fixes the inconsistend
>>>> read() behavior; the ingress data is OoO, we should not ack it
>>>> ---
>>>>  net/mptcp/protocol.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index d6b08e1de358..7b966f105f89 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>>> @@ -646,7 +646,8 @@ static void mptcp_check_data_fin(struct sock *sk)
>>>>  
>>>>  static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
>>>>  {
>>>> -	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
>>>> +	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
>>>> +	    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
>>>
>>> Does it mean we should check the OoO queue each time mptcp_try_fallback
>>> is called?
>>>
>>> Should we not eventually set msk->allow_infinite_fallback to false in
>>> mptcp_data_queue_ofo()?
>>
>> Good question. According to the RFC here we should unconditionally reset
>> the subflow. "historically" we try hard to fallback - even because in
>> early releases fallback was a bit to easy to obtain.
>>
>> Setting msk->allow_infinite_fallback = false in mptcp_data_queue_ofo()
>> could possibly hit performances. queue_ofo is basically fastpath with
>> multiple streams and we will likely need to acquire the fallback lock to
>> to the thing race free.
>>
>> I'm tempted to just do a plain reset here. WDYT?
> 
> Can mptcp_dss_corruption() not be called before being in fully
> established mode? In this case, should we not fallback instead? e.g. if
> a middlebox start to alter MPTCP options after the 3WHS?

Even if we would be before reaching fully established status, the DSS
corruption caused by the pktdrill test causes MPTCP-level OoO with data
already acked at the TCP level. We can't drop it nor we can safely
fallback, we have do reset (if ofo queue) is not empty.
> Or maybe moving this RB_EMPTY_ROOT(&msk->out_of_order_queue) check to
> mptcp_try_fallback()? (mmh, we don't have the msk)
> 
> Or maybe just a plain reset is OK here?
I think the main question is if constraining such resets to OoO cases
(in the attempt to do fallback in other scenarios) or always reset here.

I propose to keep it simple, minimize the difference from current status
and always check OoO.

/P

