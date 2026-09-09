Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800B56C63B
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967948; cv=none; b=E3Sisvx0xnLfhEfWhOBXdpiPmMmkU2lMwQXFO95Bkc/MiGravvjw22MiVI9DnoX5YmoArMt1suUYN7v1K0cd0YRO7tAvxWiUTUeRhbm+//2aninTdqTvXEi2ntvgZFH2ykPCb49vt2V6I0qVFY8dfKg3eUgkyqa1S6znHRTzo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967948; c=relaxed/simple;
	bh=14M4ZYjhJX3O4zggMzrZLFQTOxB+Uxhxu4feVRw12CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuUOHBbQadXNpGCu37pkhfyENqDB1shwLT3fhrggdbWbLe4LYOJ0ybUot6E9lzbn2M1SbibD3A4TH7Chou5Rh4gi1rqDNF1Gu5hpSDA3tzSr/00xKw7RYz+I1FfEKCvs6Vad6mK7mtZbFodDoM6ed8NivOGianAaLXdX5h4M7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ew0xP6cZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ew0xP6cZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788967945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiToT9bwf6jQEAPqpOH3/rlRkJ/28pcpFwIlQDA5v28=;
	b=Ew0xP6cZLUqrbliDhTFDAhc7hnONzmwrkjvEOiiN7FgSgae+OenEB1oaZR0mSVbSIzgbpa
	ww6jFTX8hRlF/gPcjwW3dSWbHxq/zl/8CIABSNtPziECAWwkeEePJKwZguSlv5E80tZghe
	rkuOeFKOIbwfy9SfAz+QQU/ARPxFjbo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-O3v00Fa2NxS2HnSVNFHrrg-1; Wed, 09 Sep 2026 11:32:24 -0400
X-MC-Unique: O3v00Fa2NxS2HnSVNFHrrg-1
X-Mimecast-MFC-AGG-ID: O3v00Fa2NxS2HnSVNFHrrg_1788967943
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f4bff865cso3727364f8f.0
        for <mptcp@lists.linux.dev>; Wed, 09 Sep 2026 08:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967943; x=1789572743;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZiToT9bwf6jQEAPqpOH3/rlRkJ/28pcpFwIlQDA5v28=;
        b=ZVy1b0UQK+ZTFOqkLGzjKqTUaM7uPGLqo/Sr/1tGLT1D/hY7VinRt97Uqudd7NpcKP
         Hq5g7ssWqtEnT2jWVa7QKEawaJ6QX8zlZJpzVKJA7Os5elB+0WLTz/Hx5ZI7fY8LEPfY
         nrjm5oXodSllsZ8DgF2wOKGxA38Kk76tjVDh8awheNI7aDhKX0uxnXc8PDOJeVI8mqDa
         SZg24U+MlmxFOmXES06QEvfUVQaoX2Hw4Y1ZhzGw02ozFTFWIelxBShu4QLd5RnIjZTP
         Qf7ZNRIeYtzbJSQpBzUKQ6/oK1PDtnL4VKaCax3G/hsrUT1uKzx9yw5Q3wA2LiPXzEal
         taLg==
X-Forwarded-Encrypted: i=1; AKwUvBy+8/IZa7x8DfJZ1WrK+CtwJTg4bEh9tMXnY3tlR8Wmqs2ficPaMbwGPZWyYVoj0tXgLujvfQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lC04yx+l4KyirwUqnTou95jMZgb6rkya3dR9+sePlgGGUy101S
	ELdKRQfU99T1vFhY99P1qEQclT/dlR59CuiwIXYYEum9BFlv5c4KSYaCfGiL0MjH6y6lmq6AwVZ
	hNcDz0tUXS9C9441Ule0pDEiZq29FIbtHs1WS42ZY80qQZ15nO9NH1A/p
X-Gm-Gg: AYBFou39O0lEoiQS65YJtcEm538bxE2wv1lP4g87O1ih5Btr6UpqgrAroUOT5Iojm5V
	nT6xC2jK+GZ/r+oyegrPdpF+0AGHmwW0MCS1mJx0LzE6vxopSwOzmp3o63tgkgVZkwhsrv3jbWs
	UjBlSZ6NLcIrTyID9vuyo8UidcEmpoNBt6DHWkSox3JKNHrlHtMYtaAk1QZ9k+0TDi8gFjmBiZR
	MmNQoQvVbnAcezlF0nb6I3nFQvSWZ4zhqGqWmQOdRSx43HDpXZurFyaaCRGoUCPyS16wrMEJ+5a
	p8Eqa0fF8IJuo79cbK29IakMTQ21Uq00mqTTKsYhcngNBeKcB2ihgLBeoYNleyohGDIZHMCzhkg
	rAvfzXKrQn4SLwXKQVUxe1AMwlkdQcyunKlAxYL0Fnx0MVxG6TKEsEqFHTb1ImM+P2NrtB8q1jA
	==
X-Received: by 2002:a05:6000:40ce:b0:484:3310:710e with SMTP id ffacd0b85a97d-485aae0e2dbmr12699328f8f.26.1788967940578;
        Wed, 09 Sep 2026 08:32:20 -0700 (PDT)
X-Received: by 2002:a05:6000:40ce:b0:484:3310:710e with SMTP id ffacd0b85a97d-485aae0e2dbmr12698537f8f.26.1788967936909;
        Wed, 09 Sep 2026 08:32:16 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm44398592f8f.14.2026.09.09.08.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:32:14 -0700 (PDT)
Message-ID: <7cef8694-2abf-4ba1-9bda-2bb8594140f9@redhat.com>
Date: Wed, 9 Sep 2026 17:32:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 01/15] mptcp: do not reschedule the RTX timer for
 fallback sockets
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-1-df1de70348b6@kernel.org>
 <178896537258.219967.9085177988970978054@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178896537258.219967.9085177988970978054@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N2dQ1GBuBQShfChM6B0ORZmWclgcjv-OsMHSe_TC_1M_1788967943
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 4:49 PM, netdev-bot+sashiko@kernel.org wrote:
>> @@ -4141,6 +4146,7 @@ static int mptcp_connect(struct sock *sk,
struct sockaddr_unsized *uaddr,
>>  	if (IS_ERR(ssk))
>>  		return PTR_ERR(ssk);
>>
>> +	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
>>  	mptcp_set_state(sk, TCP_SYN_SENT);
>>  	subflow = mptcp_subflow_ctx(ssk);
>
> [Severity: Medium]
> Can this set_bit() re-enable the RTX timer on a msk that is already in
> fallback?  It runs unconditionally, before any of the fallback checks
> below it, and the fallback state is sticky across a failed connect().

This is an unrelated/different issue: when (mptcp_)connect() fails early
it returns a TCP_CLOSE/SS_DISCONNECTED socket but the status is not
fully cleared. Should be handled with a follow-up/unrelated series

> Would gating the set_bit() on !__mptcp_check_fallback(msk), or moving
> it below the early-fallback checks, close this case and also make the
> new comment "Prevent rescheduling on close and in case of fallback"
> hold for a msk whose fallback predates the current connect()?

FTR, I can be low of coffee, but the above suggestion is crazy wrong.

/P

