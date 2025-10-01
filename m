Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672F2ED164
	for <mptcp@lists.linux.dev>; Wed,  1 Oct 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350523; cv=none; b=qGewRSEfpLvBTiwgIwZ9qv9oi/ko8DyQFq0nYJ0kDqcP4/Rv84K4ktDKEwWrdi9fhxxLoMrFbfPtOiN9Oyova+4yfkUHV2HnodbmO4OXNUTW6ulOddzEPlHo5mXM9bcawR9bYEmIuKhxvhTpLAOvYcwqyW08EjMiqWXz3m7e38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350523; c=relaxed/simple;
	bh=JzNNoDWyqa/zS7UWyDTfg/U2MEu+uqwPpkYQr/cahAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mG5lMvQDrGYItWCzZM0CRgyGeGwaoTFLLqo1bUOEaEvLzswwGmKKOngUsWCNJvpUHXyIzzSk4/FlSo6NOBpo2ky+6mZ6xY/U9Kw3N89CvfJTo3oruxl4qwuzrN5igGZxfTFTiklvMss6Y6CPw4ZaskPP20IXV3GOFWOwO4xKYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJBRNyIY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJBRNyIY"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b47a5a17303so5019966b.3
        for <mptcp@lists.linux.dev>; Wed, 01 Oct 2025 13:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759350520; x=1759955320; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vx5hdGkahy1NQamogmVtVf5yuP6YF2+NsatonLX9Rk=;
        b=LJBRNyIY6v1Ldftc6k2c6FRuzd3e2P+pZ9UbDDEc1a0jCq2ZkZn2j/qOp8e6PW6wvr
         TABtq12Fzg4DbuECnNVsqvfIP6gfjJhtdWLA31Y9pABzzW/rlAC/QMArcikKkiC6oP/W
         HjS7c/nN2aCTAzi8Frch80Z6jSMgk6tOo8BfQ68tUu4KcoULDAv+o6K15gAiiU/7eyCY
         ZRYEnCPSuisJ/tLHiDKWgFJhyagbPfH+Z58rTcO03wslL8jsr/j23TyclOJAsRvoVaVU
         8mFOEk4aknkWk8ErzAw2l3w+WytxMwbdglirjybsdw3lX7v604vflyiI/RLOHCuajauk
         OFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350520; x=1759955320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vx5hdGkahy1NQamogmVtVf5yuP6YF2+NsatonLX9Rk=;
        b=X98H60u0PGyywwL6cCh48+ZyG2DpDNNj5SXTT5Rip/6fI1T2ETVy0iz1H5sGwZGNMj
         bLw4gaHusElLBKGYLWscO4L73SMj+j6RriI1XtLa5qbMg65PWrv6lcxn6osDSlZoaZgw
         H8r1Uv+5hgxSCYL8LopYLa0FCsA7Us02jMv0xdJpqDNF1n+OiovFnDGtqHqGnwegUghB
         Xy7gzTqWEOmVqto5dTLuSlL5sh1/nxC9HxtN0qpoVTxl7AmCOXhJkAKlyl4L5+cFv/d+
         yKNUQyIR9zP/r4a08LwK3F1YeFJKoCi2M9tzxxBUKqOA4rNU4zh5/9XBzpKMCk+/vlHD
         KaeA==
X-Forwarded-Encrypted: i=1; AJvYcCU3YiVDXh72GGuyYs6TRvRsWKQs60JxzxHG/O9XniHZQYIlndN72Vwlllt3FpYdF55LrjPr7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQBPGKrIL+Y2NrbTQXv2EtBWu4ag4BEGn9aChEOoGtQ1HNxjP8
	EfKjMRYMkJPsPb/AI9YPuWj9SJbyT2ZKvJwpNt2vvu9K8JgONzMMR2WY
X-Gm-Gg: ASbGnct+b0+V6h01+0sAnJe07+BvbaI1Xf105EKIuwdGJvkR/SRFRAtFa04tDNDjKFu
	Y1qY1GMWiks5AU38nyiCs/fUx6kX88NlL2gy55i0xs6jqpJayaOTTFnXjmaVf0ahlsKkD/c1ofF
	2Pd/v96J2H6E70+CAZMwyL0CCgOQwtcmCS7S13ocvmVza5k80Hi1ctJKxl7yGlMVbYyyZtlxaZO
	YchyEVozzDiCP03VESLNuMB82LVpFoOkxSKjAZv+fuW7gcVrgizBbEGyxQw2t92kwUmz82gFQAW
	Sq/Lde1Aq4wkUSJVEMWJOvIzokN6qlbMDHcv1a7VAXhgkdrobJxU5uzqTBresaHsKCx6nG3MID3
	SvsR5QE1pTNuydjTEI60+jGde0vsjrci6WZSArGqEgLadHIfYzf/+V5HLbiEXdajCxLm7pg==
X-Google-Smtp-Source: AGHT+IFypxArnR4xsqK1PVKw3BTncFOVNbk0EzgLn+bv/Qi9HndoSHc9qYacyAg9i+F0I7m7EgQ4fQ==
X-Received: by 2002:a17:907:7eaa:b0:b3a:6c29:3552 with SMTP id a640c23a62f3a-b46ea1277b3mr326729366b.8.1759350519925;
        Wed, 01 Oct 2025 13:28:39 -0700 (PDT)
Received: from [192.168.1.103] ([165.50.124.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b23csm40909366b.61.2025.10.01.13.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 13:28:39 -0700 (PDT)
Message-ID: <581decf0-d360-4da8-a247-3b207d5ca21b@gmail.com>
Date: Wed, 1 Oct 2025 21:28:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com,
 ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com,
 emil@etsalapatis.com, yatsenko@meta.com, isolodrai@meta.com,
 a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com,
 vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
 <fbbeeee096dc14332c50b1086b2089f1b2f496d9.camel@gmail.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <fbbeeee096dc14332c50b1086b2089f1b2f496d9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/25 9:23 PM, Eduard Zingerman wrote:
> On Wed, 2025-09-24 at 17:23 +0100, Mehdi Ben Hadj Khelifa wrote:
>> -Change all the source files and the corresponding headers
>> to having matching sign comparisons.
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> As suggested by the TODO, -Wsign-compare was added to the C compilation
>> flags for the selftests/bpf/Makefile and all corresponding files in
>> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
>> carefully changed to account for correct sign comparisons either by
>> explicit casting or changing the variable type.Only local variables
>> and variables which are in limited scope have been changed in cases
>> where it doesn't break the code.Other struct variables or global ones
>> have left untouched to avoid other conflicts and opted to explicit
>> casting in this case.This change will help avoid implicit type
>> conversions and have predictable behavior.
>>
>> I have already compiled all bpf tests with no errors as well as the
>> kernel and have ran all the selftests with no obvious side effects.
>> I would like to know if it's more convinient to have all changes as
>> a single patch like here or if it needs to be divided in some way
>> and sent as a patch series.
>>
>> Best Regards,
>> Mehdi Ben Hadj Khelifa
>> ---
> 
> I don't understand why this change is necessary.
> Have you found any bugs while doing this conversion?
> 
> [...]

Hi Eduard,
No I have not. It's more of a future proof patch / improvement rather 
than a fixing patch as i mentioned in this email[1] with more detail.
Regards,
Mehdi
[1]:https://lore.kernel.org/all/e3a0d8ff-d03d-4854-bf04-8ff8265b0257@gmail.com/

