Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF3444717
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755097; cv=none; b=Zr2ouyv+YPKAmWk3TKT/t2fEJEVoh/M/jTbugSQln3IUlCdHXxlUEfzaRXOmhxf66Rd6dG7ePQwUqOhD2R3+j/LV5khTLzy9g2apLw/vemN9hzTyXkNWVlAWIo0Qp1E90pUiBMyKoFVjqty4A8hDkR2/7L9QUZbCa9gGmevxdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755097; c=relaxed/simple;
	bh=pzGUH4WtVUAUboCc5tBLHh4iZ9jGUWezhGIG1THnZZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VjywNyMtmU4zhshZVzV2rRNU225fM4neMHmJPteFdc7zTy759ynhJxX/9xmpyZZpKrPPVC3N10LDmQCRcwfPXxVeBIVrGhG7qujBLIUrTDcJGsX9dV86ppa2lgXmMOKaa9qo93xJlIXFq/aNHPXJw+Unw5w/EjHk3XxcAZbYMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CONU03mx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CONU03mx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787755094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oElIZtbT42jRMEAqmYa8uDHXH55OEzy4u8APh40RoYA=;
	b=CONU03mx0S0Ke91XhTQ7quq68Q/i+e3BLG8Y1Ssv6y74fJE87RYl84zVq4uiXdie8NXf95
	3Qay0b5RtKEpiwQSIoVCF/nrk13bwHQDs0tiwjJKoEHcvVWa5fJgMibWvJF9MlXWpG5zuG
	hfC8fv13LK5PbZGNoPmAfXQ3PLuRgvg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-h-Te2TxJNl-tCGaN6O39ew-1; Wed, 26 Aug 2026 10:38:12 -0400
X-MC-Unique: h-Te2TxJNl-tCGaN6O39ew-1
X-Mimecast-MFC-AGG-ID: h-Te2TxJNl-tCGaN6O39ew_1787755092
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15f4732dfaso94552266b.3
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 07:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787755091; x=1788359891;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oElIZtbT42jRMEAqmYa8uDHXH55OEzy4u8APh40RoYA=;
        b=Aj3WbBwdTWax0dQGBVe2ROPiBiKE5FCm0cmRNw7aUhRJ8+fdcOJz3b32Ak8yk8s1np
         DxMfhTcRhv8SVeOijqP2LO7LKGE1xiYoHE0VyBE1FregWgN3GEYQTjGaUV3+Vn5yLnih
         gDgiceQ5IMxp/SJmKGEuibqzBTarnOGdlV2aYweFYKyDUSNyxEm3Fp3x34flpHG9hFcJ
         8qmWkfuN6kySKM2yum23z1Cb6Uw8QEQazHXidMf7wRrJtaZ5C3nicXxsJlFm2P8gldQ9
         K5L4ZqXpGRuFUE0q6+Gw8yFDXsVNwSy91efFwyUdAxqpAcDyRsxt6bX/Vm3D+Esfw6zu
         EOEA==
X-Forwarded-Encrypted: i=1; AHgh+RqPr2atchmNHe+MZWYTppw8RXqsm02WtN0KfwzH3LSJ29/bgMAyIgOXMPtBBRO8G7FJ08o5ZQ==@lists.linux.dev
X-Gm-Message-State: AFuF++l+I8Z6Wvn9B7GptXF7ZkHmyzR8PLd8f30l6C+laX9L8wICy5Mx
	mDKch0qEL4Ct0zHCX+pqxMJq/fxzMQzKLudzrx8/EVvvmtuOtMH0/naOawjmR8kSH7ICyqiTQR+
	iqnoGrTNr8p2o3xEct+et0QOKI5OtopS+7lvydSusWGyUioE9K5C9XNSP8iFTiS7K
X-Gm-Gg: AR+sD11xKyDpO1INbTKIrCFD3tfTWNdTfiiI3pIwOrylC2njtxyQnr9EtqR8huVl/W1
	s5j82rpaNm3xhxbyRd1DV83bfe0Z966RQDM3r2c5fAnpEozAoF4MA1A0qqB9jJI7m+i2ro/OxpQ
	cpS346DYIToZnM/+jD3ISMryEm++N1HxQqlZZTkKs9Co8K0AVPqERbs0SU7sSFD782acsIQOkAW
	aLDyfuUPGDr45wSqbfVIG+Q8QLfxAGvKm9LMC4K8qgoXcbQYHx1qPbUi6//inVWyZkgl3IsmTw7
	I3rlFlxlBV7QIXWPy5hEIizr60hEQ5Sx2YF9rb66W0KBtD30bCZsfR2jx2Qaz7oF18zVyAQ9B5N
	bDaSUWVZx/bHY4wSyRzQit7JDCUG2qf1VqhBNy/5gxmnw/Fk2OWR1MRfaFLFncC4O0VQTEEo=
X-Received: by 2002:a17:907:1c17:b0:c24:4128:c19f with SMTP id a640c23a62f3a-c250c596866mr917579366b.11.1787755091530;
        Wed, 26 Aug 2026 07:38:11 -0700 (PDT)
X-Received: by 2002:a17:907:1c17:b0:c24:4128:c19f with SMTP id a640c23a62f3a-c250c596866mr917571866b.11.1787755091054;
        Wed, 26 Aug 2026 07:38:11 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88ae4dsm693265266b.39.2026.08.26.07.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 07:38:10 -0700 (PDT)
Message-ID: <b6687f58-df51-4785-9451-0900f055a24a@redhat.com>
Date: Wed, 26 Aug 2026 16:38:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 2/2] Squash-to: "mptcp: do not reschedule the
 RTX timer for fallback sockets"
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787739122.git.pabeni@redhat.com>
 <3d8a1534a8b0609c6ddcd593f4ed8957be019657.1787739122.git.pabeni@redhat.com>
 <5c2cc035-02ae-4ed3-886c-d20dd799b0b4@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5c2cc035-02ae-4ed3-886c-d20dd799b0b4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a647XW2Oz4fAvo5X34tVns78VBN495PZ_SjTUgqu7kU_1787755092
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 2:38 PM, Matthieu Baerts wrote:
> On 26/08/2026 12:13, Paolo Abeni wrote:
>> Sashiko noted that the 'RTX disabled' status is carried over
>> across connect() failures, potentially to subsequent successful connect()
>> or listen().
>>
>> Explicitly control the RTX enabling status across the whole msk life-cycle.
>> To make the code more straight forward switch the newly introduced flag
>> semantic.
> 
> Thank you for looking at this!
> 
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 8 +++++---
>>  net/mptcp/protocol.h | 2 +-
>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 1e7e59d497c5..db745d9dde59 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
> 
> (...)
> 
>> @@ -3363,7 +3363,7 @@ void mptcp_set_state(struct sock *sk, int state)
>>  		 */
>>  		break;
>>  	case TCP_CLOSE:
>> -		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
>> +		clear_bit(MPTCP_RTX_ENABLED, &mptcp_sk(sk)->flags);
> 
> Could this be moved to mptcp_disconnect()? Or we prefer not, to stop
> ASAP for some cases? (but I guess most of these cases switch to close
> before transitioning to ESTABLISHED, no?)
Why do you want to move the above to mptcp_disconnect()? It's better to
prevent the rtx timer from taking action after the msk moved to close
for any reason. IIRC we had a few syzkaller splat in the past without
such check.

/P

