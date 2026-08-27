Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FA306775
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817129; cv=none; b=W8oVf8oQD6Cfr6MRV+bZVeVAyOwtjuwQv9XKa9ofx5ni/uuP5gwhlGrfMQGZCzeHSjIonx1znlOHzXEh/4fB7YVD8YMNW4FsWehLmOjzC4OgMCh15rWQ6vUHM0+wHqDAEyvOcgzfUgGowTu2Xpve+W5yHSf7aR2RkUkxS5mx2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817129; c=relaxed/simple;
	bh=mdd0+Tkp/vkHv2X5BfPUWitYD0aEv/hrU3zQwCEthh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UXhNFIHr5XxTmdb6TTD0TbJYErEbCpPjt0RRgH0i+x33T+QxLOI+9m0dywtPDhIFKCU6P0L1VraqsLYLzriti85+suMiT1rAJ8G+jO1hvVCkaApI8XBTEfaMQs+3tKuj54SQ0aA7iNScySo5GR6AZniS599Fx7/Rx2GeIPEo6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPVBUdGu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPVBUdGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787817126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2C0cIGjOJgi7dUCuUij1Yxiil3jWHvXl3NdhdY/Ym4=;
	b=QPVBUdGu+CHGJ0aLtwKZ28QMc05fcdkx2lSSPiTtB70+Ivb1BvCtaPOlabOyYmhZFYuH+2
	uHZ5Te7TgADedvmLB5I+S4BrNFmX8RyypUPI3xdVJ8G1mxiKdgl+65Ek7m7Uxj8CpuI4FH
	PQESVLdfzxAVk3GbTf+u99hmYNwEha8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-j87QTeCbOUu0dULOMIqDmg-1; Thu, 27 Aug 2026 03:52:04 -0400
X-MC-Unique: j87QTeCbOUu0dULOMIqDmg-1
X-Mimecast-MFC-AGG-ID: j87QTeCbOUu0dULOMIqDmg_1787817123
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f726186c4so1065149f8f.2
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 00:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787817123; x=1788421923;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X2C0cIGjOJgi7dUCuUij1Yxiil3jWHvXl3NdhdY/Ym4=;
        b=erGzTZIj42Sj4mkX3F0a5ouZvmFngcpICeITlHQ/fkNtuwuCjwBX61dKXCm/VBifo4
         2MyMptFtxikHBZ+dQZh3LFJOTvuJ3QxkBGX/YUQwSgz0PJCq1q9PPUy87BDKepsiXj7J
         CXY37CWiteuKp5ceQc+PmuYXqJ1HwV2vF8Np1MeY6aRLyIw3t41E/iTKawE69CiOsOZG
         APbNrbYITbNg3ena46rMJZRLI/LCSX+eDPbxoJ0H+O2eRYFz4RTv9/j6gRV8jCYsMiR9
         Q9s1CVrV7OHE6EhEPLp5p2aEhKoVfk1t9NyL0YkPwUlI5pheD06tZ30Paa/5raO9vllE
         9GOg==
X-Gm-Message-State: AFuF++k03Mi/g7bEDcvAvykhxU0c00ztJqz28n52Xg5tCm7I5hQup9LA
	AnIpNx6LAbQ9IwQvZMq8jGiQR166XZRdIDahlgitw32YFYTPMuAf0xvYvfT5r/+wCLPXmZDPen/
	24NAAveLcDGgPINu7V/TMb7G6vEg8f4qzuyaND4v6Rv3L6rvuDU06G8qApYmohagdeldzDPUR12
	0rLBHoqkom61s5rYFZer0qdJnHbvGSC8YHuOCrPg==
X-Gm-Gg: AR+sD129hwF+m28QRqIkC5XXBW35dLNabtcorNAznJ3r0qnA2R2xIzqLu40awxszOOX
	cEw2F0H3Zmk3pQEEAl6GRRzWhX009xoMnfh3iJP/0riHGWO4saDIPnug0+3QyyvSW1DhxXVbZRo
	MF1x1Due2FwnDCSOHx8fDsMFLCsNPO5EjnpMNUvuYrBLJEo6D2F2Mr9rM+M0At3qAvsC2nRlXX4
	PCafNussbcsB7OsDTQfx2F3nakMXP/ZajU+jGvg9dg4vvH318I6ooI+61O71RPOZpWL/zodash/
	rlFIB+K5FVUS0cQMY6sJDoAvGcf356q8eML1rrk4/Wa1n0XIpx7X8RAzdrU6FpS1HKDlUpcgQFA
	rd9Mr5x/5KSl4yviJiGS2VzTnAvu6KUiaJznRxsxWZe5ljvYenNmncKYElbxuSr8u/HoF/L8=
X-Received: by 2002:a5d:6f07:0:b0:482:e658:bb88 with SMTP id ffacd0b85a97d-482e658bd47mr12137468f8f.5.1787817123220;
        Thu, 27 Aug 2026 00:52:03 -0700 (PDT)
X-Received: by 2002:a5d:6f07:0:b0:482:e658:bb88 with SMTP id ffacd0b85a97d-482e658bd47mr12137393f8f.5.1787817122662;
        Thu, 27 Aug 2026 00:52:02 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dbe29sm7265668f8f.17.2026.08.27.00.52.01
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 00:52:02 -0700 (PDT)
Message-ID: <6d1859cf-1bb3-485a-a44b-7f8f329f1a2a@redhat.com>
Date: Thu, 27 Aug 2026 09:52:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 2/2] Squash-to: "mptcp: do not reschedule the
 RTX timer for fallback sockets"
To: mptcp@lists.linux.dev
References: <cover.1787760635.git.pabeni@redhat.com>
 <134b1453d11ffac177571c72b7832a6c62fa06df.1787760635.git.pabeni@redhat.com>
 <20260826162525.8D5F91F000E9@smtp.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260826162525.8D5F91F000E9@smtp.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sMpWtK84vb604wmttndv9Ctrx80kSAUbudnzvRC31tY_1787817123
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 6:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The MPTCP retransmission timer is not properly enabled for active connections or on subsequent connect() retries due to an early return in subflow_chk_local_id(), completely breaking MPTCP retransmissions.
> --
> 
> commit d97031273df9e2f644d64a1baa6fef7afaac166d
> Author: Paolo Abeni <pabeni@redhat.com>
> 
> Squash-to: "mptcp: do not reschedule the RTX timer for fallback sockets"
> 
> This patch changes the MPTCP RTX status tracking from a 'disabled' flag
> to an 'enabled' flag across the msk lifecycle.
> 
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 01db7edce18a6..ac35ffdaf37f6 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -634,6 +634,13 @@ static int subflow_chk_local_id(struct sock *sk)
>>  	if (likely(subflow->local_id >= 0))
>>  		return 0;
>>  
>> +	/* Slightly unrelated, leverage this code path being called once per
>> +	 * connection before sending the first packet. Early fallback could
>> +	 * take place at mptcp_connect() time.
>> +	 */
>> +	if (!__mptcp_check_fallback(msk))
>> +		set_bit(MPTCP_RTX_ENABLED, &msk->flags);
>> +
> 
> [Severity: High]
> Will this flag setup ever be reached for the first subflow?

Oh, crap! never rush things out of the door.

V3 will be coming, but not too soon.

/P

