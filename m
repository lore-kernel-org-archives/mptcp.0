Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62128223330
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816497; cv=none; b=UjKf2zH286cMt2XofM/nHDkhHUyseGlV1Gi0JnjuRfUfMkeX+a4afPJjQmVUCfpY6Va8OJ7oVspeRCbIa174DXKbi1QJjWBrnqy8pbl8qcVK90s9po0EkEw8qrHC4N6owYD9OSeLrM72EFn37banFamtb6GmKy/Hbeifwjo82x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816497; c=relaxed/simple;
	bh=8AkXwT690kL4j31mGSZRiMpjZRFyfRKVrGH6wTXSE8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eY5E/p+kG2OYv+weH+4EETVupZdwBqvZv4noFKwNDrFdRfP2KfURPN552qoGYtaHb4a46/jylqZKMXMFmp4aMIlQPiFEN9JcvaNDYBD6N/O1i8jOEv3vEsiQ6G6EzqMV4OHbI0OKmiVVV6OUaZMQVGA+1tWGpKuCIfms8ra2oV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jla0BIju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jla0BIju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739816494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTovghgrkM430rBG3/dTBg4Tfra4TCT2/ewInaDtL7o=;
	b=Jla0BIjuZi+s6PE7KBih0J1Z0F7zJLAgondkNvWSeapOf2chIevHKKvQqYybchirnsY0a5
	u35JfgnJ2Rn3N85wi1/wEpd0i9jCc2hT33GQGONB1AXJTl3HA7tZ1edj+C2nC0OJdF7Yd0
	nxlvBo3sVIc8OfWF+o8MTj0Co/XIRTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-1XCaWeuqOES5Et05wlGUSA-1; Mon, 17 Feb 2025 13:21:33 -0500
X-MC-Unique: 1XCaWeuqOES5Et05wlGUSA-1
X-Mimecast-MFC-AGG-ID: 1XCaWeuqOES5Et05wlGUSA_1739816492
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4393e89e910so24939845e9.0
        for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739816492; x=1740421292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTovghgrkM430rBG3/dTBg4Tfra4TCT2/ewInaDtL7o=;
        b=lV50fJmT2JQw6nT5tNlRDO0AcF71NTUiOXOQmuoC0f+yrw6OI0PPxLjEHdihhXkeHN
         HpuOIN8LD3nJiyX9GLDNvmWkIa+v4LEOMHbGqp/uvTeyZMsv2jkZVcqeImezXW0U1DpP
         zeC08HAzubFOfQaZqzSHENg+6OnRcsN4nR2DnGi+risUGnT/LxHpbOtIcn0tSgKwAIFM
         GMA8J6yRzByD3bEt3wY4nvqejdN/++vfZuMrnU9D+EY2sABk6i16oJxzvHJHMNofBlqC
         +ny6XEAhtUCx7sYv2sAX7WBoOhHIQzfH6Pmk7wEruGOjRrBRp6u4We3zLR0nLokMxMQE
         tI5g==
X-Forwarded-Encrypted: i=1; AJvYcCV+E1v36n+aeVmo3cjgDbDD5H9pPWx7P/blgNa2HDSiMgp7DacygbnAUMmXRdQm1j4Xr0R6jQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzS9ERqBWXd5Ew6n2lWf6Ndg+NhryGSMHgboQmIjTnNAvGN2tS
	FbTIKBcv2vXWfniN/SQ8mKDxt2yZrrFuOKo620bcbyzNqpXr5HXgWaU/Hi5dKrNrYlWwIK2D+wo
	tWWk9v5FUp+TLXKY2EpenMINxsAd9AO+62ZsX1ZKEV0KxcLe7jwwQ2ONIrn63
X-Gm-Gg: ASbGnct/ZAaHfwMJaWDxydTyUYAiwWJ8SETUbpO9ZrjJGmmL+M/Bm4i38IH67DeRE1b
	DQfW9rs1N6A7lgECFgQe0RfcqkDjogqPnI0BBSs9winiaK3KJ50NDXBAEaXfAj5Rwkd+rpE9bON
	H1Pezn8sFHheEMmC5sbCOgFNcADBTJTlYozfqa52J80t5MbwvW8/Iz76cFX+AJK7xhEoxCRyK8C
	bcVgvEMYhIsj5y+DmmKrbze8v4oPPHtXiypAqp5H0cJQQKX9v4Xh8mLLG9bpBtFrZEWeLvMCrE3
	ri1zL/R7dzYi8uHYZDTv5mHHhaWtlSOYJCY=
X-Received: by 2002:a05:600c:a014:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439861fdba3mr35721355e9.30.1739816491558;
        Mon, 17 Feb 2025 10:21:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi6OJY4g98p8RKYlbDHMhtuxrjMlOqYDpK9JM74ZUjyLoR+GoqT3iwdAI1IStwc8o9NNi+4g==
X-Received: by 2002:a05:600c:a014:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439861fdba3mr35721145e9.30.1739816491140;
        Mon, 17 Feb 2025 10:21:31 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439880531a9sm14204175e9.3.2025.02.17.10.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 10:21:30 -0800 (PST)
Message-ID: <ce88eac1-1ed9-4ffc-837e-fd5c9aae7b5d@redhat.com>
Date: Mon, 17 Feb 2025 19:21:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 2/3] mptcp: only fallback due to inf mapping if
 allowed
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
 <20250217-mptcp-dss-drop-mpj-v1-2-d671d6b9a153@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250217-mptcp-dss-drop-mpj-v1-2-d671d6b9a153@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2HHqabVYi0DReDjRyy2QDu0nZo4GYjRjRbvzh6uSEvM_1739816492
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 9:37 AM, Matthieu Baerts (NGI0) wrote:
> Any fallback should happen only if allowed, so only if this variable is
> set: msk->allow_infinite_fallback. This boolean will be set to false
> once MPTCP-specific operations acting on the whole MPTCP connection vs
> the initial path have been done, e.g. a second path has been created, or
> an MPTCP re-injection -- yes, possible even with a single subflow.
> 
> In other words, the !msk->allow_infinite_fallback condition should be
> placed first. If it is no longer possible to do a fallback, there should
> not be any bypass, e.g. when receiving an infinite mapping.
> 
> Now, regarding the conditions to do a fallback, the RFC mentions [1]
> that if the checksum is used, a fallback is only possible when "it is
> known that all unacknowledged data in flight is contiguous (which will
> usually be the case with a single subflow)". In other words, if the
> checksum is used, a fallback is possible when the other peer sent an
> infinite mapping indicating the flow has been altered.
> 
> Note that the issue is present since a merge commit, where both
> subflow_can_fallback() and the previous extra condition with
> 'subflow->map_data_len' got introduced.
> 
> Fixes: d7e6f5836038 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.7-11 [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I have the feeling this patch could/should be squashed into the previous
one.

> ---
>  net/mptcp/subflow.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6ec03580ccec12fb50fc3aacf3d22413647b32b5..a8ad16db1ecd08ef7155a38161555253e4c72399 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1298,16 +1298,20 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
>  		mptcp_schedule_work(sk);
>  }
>  
> -static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
> +static bool subflow_can_fallback(struct mptcp_subflow_context *subflow,
> +				 enum mapping_status status)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>  
> -	if (subflow->mp_join)
> +	/* If not allowed (additional paths, MPTCP reinjections): no fallback */
> +	if (!READ_ONCE(msk->allow_infinite_fallback))
>  		return false;
> -	else if (READ_ONCE(msk->csum_enabled))
> +
> +	/* More strict with csum: fallback in 2 cases: inf map or never valid */
> +	if (status != MAPPING_INFINITE && READ_ONCE(msk->csum_enabled))
>  		return !subflow->valid_csum_seen;

Is the above branch (csum_enabled) still needed? AFAICS csum fallback is
handled by the previous test:

	if (status == MAPPING_BAD_CSUM &&
	    (subflow->mp_join || subflow->valid_csum_seen)) {

Thanks!

Paolo

