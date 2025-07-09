Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE8283FC2
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052189; cv=none; b=E7vD0SItKXiEUDx+c7yFul5puObhBK2WZdh+uHZIbc/HRj0G9tCKRju1Nzi8fDHONuig/TcAqW1ftnTx65yEVxuJQPcET/N25NUkUoif8ZC/xXEb8uEl8VrTWAhTfoe+rn0HqrwR9W1lh5JGaPXl+sWSacR37+mUBYWKPYKakLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052189; c=relaxed/simple;
	bh=mdWlPGs029VCnWdvzS+QszYglj7JaGvXQypwSXqC02Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMsPj9gjex3iOxeto242rmPTk0X2lLPziA+MgPgEjdamuEvFDT9rfLlFi9q94TXY1etRR8r1cdcnvfQte2BKRyg/sgCqPhnuN7S/l7+PESmMxljO13fyBn/XRvCEhrVGKqFKJx56SWffgaWnTJSg4iq8SmycMBNta0bOjRku6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPINNXxR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPINNXxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752052186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIHP//FGzrp2zZX66VXM9OOs4EM/a/T14xJnvjnBNaQ=;
	b=gPINNXxRcpuU5qJ3Op2DEVKBG22QpMB3FrdWClKuUUAix/+3m0WiDvG3hLk7xKl97oJJqD
	D5nwqCwIKOQD10AuoRXJU4ID3nLZu0dD32RVU/qOepNrW0hrQbBjEwmVzFophQ8ODMRW+B
	Eobdj6tyQBSs9/D7/CxlLTvl7+34T3A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-c1ieyXq5OqaS6jkLPcHPvA-1; Wed, 09 Jul 2025 05:09:45 -0400
X-MC-Unique: c1ieyXq5OqaS6jkLPcHPvA-1
X-Mimecast-MFC-AGG-ID: c1ieyXq5OqaS6jkLPcHPvA_1752052184
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso3781515e9.1
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 02:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052184; x=1752656984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIHP//FGzrp2zZX66VXM9OOs4EM/a/T14xJnvjnBNaQ=;
        b=sYnDkrfB5HVwYVY7bSv4MwYVY1bsMqYM/xGFwl+mSU+2MYXQ7mvxRTLjejmV6XYS8h
         0kNg8rMxnP7ZjiXSM2V5AUIBzBr6yLGNCWz16Kayz0Dml/dygVqOwcU0SKJvTpQo0rpd
         tTVMw/XHoJGK0PRBDWPZf3GudwQFwT7NwKR0mvSNdFv81UNaKWoE+Ulb25u91D8uHHIa
         3Zt/JBMYmC1MSlg4Dj+cACfwQwMPha1MpF7duhk9qEqPTq7xI6ENy+pyStsvNgM58+8G
         WxKaYRRX7+JQg1Jo08zdcr9+OVMOaVAU4UUypFoyPBu8OZtwHps/lvAQUwYeimiI6fB3
         RvDQ==
X-Gm-Message-State: AOJu0YwLiZ0WOkOuNyuCmQrcaNnNHV/6WUlrsh5hskMoN1n+QaNGRUn2
	oY/X5PoX0suq72CohNtg+nyaOKDidoH0JBTQhJeQOf7nNm4biL0uGxdhHCmrYjpEBb1/Qfcp3oU
	pniqmO8EScEWU0vsmZHptRL3xdpqviJsBLpv86rAufKzKvMkCzY/PmdQT
X-Gm-Gg: ASbGncvkrmd9wudZ394ihP3N7noiZkvc4V2y87oym0zC9V99siQSNFv3wb9Sa1hVf5M
	gcZRuIA3gGH1UMeBrZfq2dQdCDS1HW5Rz6PJd7oceVWakQ4nlpWn8U3G7/I+R4hmSq+Alpq+6cf
	9Mf1uEK4Mlp19AJaqHBbpCvXBrlcZo4UYkBX7tve9L2EYF3JBjDwO/NOr8Gt7wVFPCIPkD36Y58
	95g6dKEj3X43OT3DSS11RSCOaGgqsuKtxYXAIecJYwC3dXBsTSfjMx81xWoC13XmSNfn+0ncI+n
	eyspV0uXoFXwH8PrjgQWjNBMdEoqH2BvrClKkYPxrsKF6O8oZApmyXTd1PywdXDR8yiS8g==
X-Received: by 2002:a05:600c:4b95:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-454cd78f125mr41388165e9.15.1752052183788;
        Wed, 09 Jul 2025 02:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvEBKW+6nVya/wahdgj9Hoxyzx3yXxMGjUELIwOe+3+bRnAd8jna9tch3zhcJURzeSSQl7+g==
X-Received: by 2002:a05:600c:4b95:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-454cd78f125mr41387935e9.15.1752052183282;
        Wed, 09 Jul 2025 02:09:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5103c2asm15757305e9.33.2025.07.09.02.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:09:42 -0700 (PDT)
Message-ID: <db250f41-1d8a-434d-9a4c-3cada39ea736@redhat.com>
Date: Wed, 9 Jul 2025 11:09:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 1/5] mptcp: make fallback action and fallback
 decision atomic
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <7220b3c204d75d50e480f6045295a825ae80fd38.1751699999.git.pabeni@redhat.com>
 <af295f45-be11-48e2-94c3-fdb99f7153cb@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <af295f45-be11-48e2-94c3-fdb99f7153cb@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V-VrTiHr3uVxkQ4aq0TYz0HsndwPc7Wl7RYH8rL6CoA_1752052184
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 4:54 PM, Matthieu Baerts wrote:
> On 05/07/2025 09:24, Paolo Abeni wrote:
>> Since we need to track the 'fallback is possible' condition and the
>> fallback status separately, there are a few possible races open between
>> the check and the actual fallback action.
>>
>> Add a spinlock to protect the fallback related information and use
>> it close all the possible related races. While at it also remove the
>> too-early clearing of allow_infinite_fallback in __mptcp_subflow_connect():
>> the field will be correctly cleared by subflow_finish_connect() if/
>> when the connection will complete successfully.
> 
> Just to be sure, will we correctly handle the case when:
> - a SYN + MP_JOIN is sent
> - an issue is detected, a fallback is done
> - a SYN + ACK + MP_JOIN is received (or later on in the join process).

Plus this also plugs a similar race on the passive side.

>> If fallback is not possible, as per RFC, reset the current subflow.
>>
>> Reported by: Matthieu Baerts <matttbe@kernel.org>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/570
>> Reported-by: syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/555
>> Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v1 -> v2:
>>   - remove unneeded and racing allow_infinite_fallback in
>>     __mptcp_subflow_connect()
>>   - really close race in subflow_check_data_avail()
>>
>> Sharing earlier to feed syzkaller.
>> Hopefully a follow-up on mptcp-net-next will cleanup a bit the fallback
>> handling, I tried to minimize the delta for backport's sake
> 
> I fed my 4 syzkaller instances 1 day and 6 hours ago, and everything
> look good so far. But please note that (1) it was not easy for them to
> reproduce the issue, and (2) you removed the warning that was triggering
> the splat :)
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 56fd7bcb786c..4680d980e605 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -978,8 +978,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>  		if (subflow->mp_join)
>>  			goto reset;
>>  		subflow->mp_capable = 0;
>> +		if (mptcp_do_fallback(ssk))
> 
> It looks strange: in case of success, we reset?

Good catch, the above is wrong, should be:

	if (!mptcp_do_fallback(ssk))

> 
> Not that the selftests don't validate this branch:
> 
>  https://ci-results.mptcp.dev/lcov/export/mptcp/options.c.gcov.html#L977
> 
> (also, I wonder if we should not have a MIB counter here)

This is the minimal patch intended to reach stable. Mibs are added by a
later patch.

/P

