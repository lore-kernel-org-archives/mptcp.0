Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6F249E5
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992161; cv=none; b=axjqUp3l1wJOmnJyrWckrpG6k6VUwagukLaXIBkBBhhOzQCNpvWoU0k0ERkf4S6aFH/MzPEbz3yXBK9vOT+ZNozLbss0Ap4C8Wg3xWa4sI52rurpbcfCOIRi6QhWMxu+dj/PtjmpMSlYH0unEMLo7dK/Gz76DssETPzz48J4oEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992161; c=relaxed/simple;
	bh=JoJeodVhvXNrWy0o9T0KcFhOvsO0jmuBbBl8InaVe0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kigzsO7endUMeIwJvTPRVfzdbT26DrlMpzUT1N/VbA8urUUFFPghiWdHfef4yuIri22u+kUHIks+vFMhJTF9Tju8cg3f5NJgcpsUwBZ0codeZUZCd+tkJsw1owFbHUsN5ZjYWadtodU1rnTZCer99lm3lI29lEwervTbDVRn1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2BEjH9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2BEjH9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmXLBOSF/af91jiOY37rpftWO0p5vH8W/N62Ko7uViI=;
	b=a2BEjH9f1NyBxm8+xPjQm4hYopUkDZBmN1tmSwofBcANk6hk3hQwYQztTyrNPbFmhWjSx/
	eipU7RUBqoWEH7jqn0tbYdSODMnFY/VKtj2cnBsP7FBDGi17zOLWOD+8mUwUIdh1dsNLgn
	aleueop5vZc1ijx7BlaA493Ba+XwG38=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-GheQ8ixpPIm7Y47ASH2owA-1; Wed, 12 Nov 2025 19:02:37 -0500
X-MC-Unique: GheQ8ixpPIm7Y47ASH2owA-1
X-Mimecast-MFC-AGG-ID: GheQ8ixpPIm7Y47ASH2owA_1762992157
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso145489f8f.0
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 16:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762992156; x=1763596956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmXLBOSF/af91jiOY37rpftWO0p5vH8W/N62Ko7uViI=;
        b=Uj08UoJZv9fU27cmApQfqrgx/KWf6wd0uDFWm4KNnuc1KcAc5p1GHmEhM+rRHQSlcl
         OH7qu+SVsJets9AyxW9LStOIKY54nYGEiIofP4Luz7TP6+CZwRUNC/rqV0/bzCkQlq56
         OpjN+Iy/jB6EyDB9pIGXtQ//v/2jeViVO+6r2vxkrh5CWYO1XoBY07c9uKTbZCuT1kCo
         ASipYoef5EInMT/MAp6mwEKsdt6b5ScLzAHYV+th9rpNQMLctdU6hlsIoUdGWGThXCCH
         4Lmkm5PadMFXRaT/XYlKj5BXjl5SBoQ6RkBBNQsp+xFdOMQC5It0uuZJ6dwtAC4fzkiq
         Vo3g==
X-Forwarded-Encrypted: i=1; AJvYcCWhMJko3W+k0Hcaope0RKImrTh/NjzqcsH7w/3Q2/syruJxZrB8UE/srSYV7CRGB8ts4l7wAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yywa09/M7OhTsE1Yd26TaGVyQXThZBwg3iS/GFO/0HXBLIk/n5S
	QzySLKxkicjxRZ/rnGCBo9jN420NRSY7HqoaxtVmIENJMBl++knReMynBTO83zCv+OW5k77DvAt
	HHm/TJ/5PVhUGnM0H/Qm/Lf8i/5pNOI6SMySvbGrOvFTVUIy5+9OdKYPz3Fo85qzf
X-Gm-Gg: ASbGncsaae9DX9ozYp7LXw3aD8VblF0SqAk/jFqlcXcaLmroxCm7e8d+rR4AoXzwEOS
	wgt2kyOSNnlA4x2FjrHl7oxlzf0gb8twStx4o7PWEhKbX2RymuLRkqZYqbd2KYQthG4MmoP0ien
	P/nND4yzH/dlMeaZjNH3XR/Gw8pBU2X7ZunS2OEoSSuwJ/srJystJPtSMpS8HwL1oT4CISgYvID
	MiXoinHJmENfmhVNo9rkLrAQBqG+ORyB8R2TdOu1neU5+Uck5SqClH/lykqAMDLiwQnkhsotvt/
	1IiZ8vMTlOUt6zBAKzfVROC+j3s5svki6yrNpm5ABf5+1n3FVj5SmvolbZ3Tq5Kp/RH5p7oP5Rw
	eudh6N9RqOXK5
X-Received: by 2002:a05:6000:2481:b0:429:cda2:9ffd with SMTP id ffacd0b85a97d-42b4bb8f004mr3459170f8f.9.1762992156302;
        Wed, 12 Nov 2025 16:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4k8rgbeSDc5tsAyNMTFWDCQMQskIikLCzm5pCXZJP1UGtorQ7G2odIfcYgUUkhARqX1oXfA==
X-Received: by 2002:a05:6000:2481:b0:429:cda2:9ffd with SMTP id ffacd0b85a97d-42b4bb8f004mr3459155f8f.9.1762992155861;
        Wed, 12 Nov 2025 16:02:35 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm428212f8f.24.2025.11.12.16.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 16:02:34 -0800 (PST)
Message-ID: <686e7b33-00c5-47dd-af4a-8ac3014869b4@redhat.com>
Date: Thu, 13 Nov 2025 01:02:33 +0100
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
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1929f39e-b3e5-437d-b8da-71e3c7e6f36b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kD6TntySRB6Y4YrIbCYggzFvKyhJ5T8IjI5gO-CbOQg_1762992157
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 6:50 PM, Matthieu Baerts wrote:
> On 11/11/2025 08:24, Paolo Abeni wrote:
>> In case of DSS corruption, the MPTCP protocol tries to avoid the
>> subflow reset if fallback is possible. Such corruptions happen in
>> the receive path; to ensure fallback is possible the stack additionally
>> need to check for OoO data, otherwise the fallback will break the data
>> stream.
> 
> Thank you for the fix!
>> Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/598
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Note: this does not avoid the WARN(), but fixes the inconsistend
>> read() behavior; the ingress data is OoO, we should not ack it
>> ---
>>  net/mptcp/protocol.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index d6b08e1de358..7b966f105f89 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -646,7 +646,8 @@ static void mptcp_check_data_fin(struct sock *sk)
>>  
>>  static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
>>  {
>> -	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
>> +	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
>> +	    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
> 
> Does it mean we should check the OoO queue each time mptcp_try_fallback
> is called?
> 
> Should we not eventually set msk->allow_infinite_fallback to false in
> mptcp_data_queue_ofo()?

Good question. According to the RFC here we should unconditionally reset
the subflow. "historically" we try hard to fallback - even because in
early releases fallback was a bit to easy to obtain.

Setting msk->allow_infinite_fallback = false in mptcp_data_queue_ofo()
could possibly hit performances. queue_ofo is basically fastpath with
multiple streams and we will likely need to acquire the fallback lock to
to the thing race free.

I'm tempted to just do a plain reset here. WDYT?

Thanks,

Paolo

