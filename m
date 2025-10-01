Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3302D8781
	for <mptcp@lists.linux.dev>; Wed,  1 Oct 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350200; cv=none; b=ltTo/vhUhHkumnCKUjwChZPcdefRXdQ9aWUGzqy5OAIVHc48rFkwmLg8ty+LUlGKZ5PyiO6Zz4Il/8zVdkgVdj0EAozM8SQqjfgWRpBSiJV8C5FW5p2Ag+grd/IwQnug0jQffsskvTpdgIIWqOarHe0M6Rbd4tAH2RpyQkE4BLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350200; c=relaxed/simple;
	bh=sDgjk+ktzv45pAziz/W/rEGBe9ilvei4D3+TtKwEeiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=icOrVWNc2CD6Ul0Idb5qe8B2KBz4CMXdTy/OrMpdEjQqaSk3HpjJU+7j5HbP7WkHtSFzOAMgzMsPvbNeGKXAs9w+ufaIKTKIP9cuuJIrUeoZwkyOEEyasvUqZ6juShfH8Q90kE1iLOXa1hxvU96tSzdU+Q22kQEhtquraxtL9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9LBtpOM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9LBtpOM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7811a02316bso266381b3a.3
        for <mptcp@lists.linux.dev>; Wed, 01 Oct 2025 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759350198; x=1759954998; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sDgjk+ktzv45pAziz/W/rEGBe9ilvei4D3+TtKwEeiI=;
        b=G9LBtpOMUGxJFOposdIeCt0h/dTxVGU4zNe5ddsJMSEgAhubm3U07smKscXr67xBe+
         1j8k1QK8GYssVMYf8lSIy5p4mt62jKztS6d9D49WV0NnSR3kYti+YMgcu0cIBnqdFXOx
         ax32YZ/W6eE3yzT8ihpBanq8SsVa2oUru9mwKiFMU8K6KkXTdGu87uEz/iDcmZIQJrAy
         eWmMyoQ2SySiSCO6joANQBqdUscMbV5JggxsQ6HO+OOshlgfCz6mZOyuVh0bIr0p/aPc
         0Q9578fSRcElHkcAAQnRPV+EKvDkqfmzr1tbPyAgNaohfCUfPA4Yima3C4+Ho5gVJqsd
         2Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350198; x=1759954998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDgjk+ktzv45pAziz/W/rEGBe9ilvei4D3+TtKwEeiI=;
        b=vs95/LA/2xAKfS4pZFgaieL15vDd8/8ERtjR+JLJ4UIF5NI5Ljb665YIar0+CAM+W6
         1wbmj6n8SNJGgTJV7VIb020UNKhfdrdeEOSDTZ396FUmqtSOeqtu/Se1zCWdv4vTTD32
         yQJLT3Br8R3XNKschoZpq7dlya76dosCwu+x/QfEFbR1mIV3NSMs4eRpUOkB+TMYn26R
         suVHsrfBiRYqDp8DuRVAZ+3tnwg4wnBd8BHorNiMaRUcPIuIOW/q6GIyFVf2HwKRo/DD
         4KMYeqw7hXJy8WCmCBzJX2Q+Fdd5ZWga40nwlmBWTZY+K1OxUfaO9OIrtd2Cim8uLr5e
         0fIw==
X-Forwarded-Encrypted: i=1; AJvYcCW9/BG7KdY+UD36HYYaXrVethYhJs8+Gq2L+LEQcj5AGiLBLXNpNrsuHMDwfwOZF9Q1vJVgPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrR1/5HvOUT7uv2VX0V4LmEiwELosX3+W+0GDvWBU2CUehkdQp
	Ds0Us5EkGmrvGc1RQADo6UP+6HNZnFy1gefCt20Z5oM1OLSzOO3JQu0X
X-Gm-Gg: ASbGncvfhVpmGhOUBRCOocS5/FZb0NlhihCSJ43V6g+QoWadH2/u1j+n7CREGcxeAkC
	P6nbvCA+QmlrDnxb6Z/mlsnijysHB14eANsIucizzHJV6rUejcZhMuPH4z6ZqyuM0agB7NOU3Gf
	nnTZ4SaNUpFEY/GDKPN/1CGYt8cZu2l+29K+4t8+wdqdTr8JWYmDOFMnqbSGNpjZXU3dwVRt3l8
	LFluA7QF4QPPwiJ/obyM5sMOfgpDalR00UDArA0us90ZjX6svsGnSuBODzZQzCCMYwH6QB+Xmr7
	evz9okwnYRWBWyOmRSVbvksNUIeKMvExeptqULFMnPjjIQsZqOZQuoqO0GmCrpVYrBwCTue6iT6
	rD6ge/CD6gfY4g8cxj9DfnOuLTmcY7vAgnwFWg0xfsnte1azZlV2v5bg3jkJ28LYnLy683DI=
X-Google-Smtp-Source: AGHT+IEzLJ6xMI4TZdMZ4T+zFjMdd8zd+FBTLRL34IcHix6v7TwCxHpmo0m7KR94VG++00tXP6UsNg==
X-Received: by 2002:a05:6a00:8d3:b0:776:138a:ec97 with SMTP id d2e1a72fcca58-78af4176ab3mr5284861b3a.28.1759350197746;
        Wed, 01 Oct 2025 13:23:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dae7sm531831b3a.9.2025.10.01.13.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:23:17 -0700 (PDT)
Message-ID: <fbbeeee096dc14332c50b1086b2089f1b2f496d9.camel@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	shuah@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, 	davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com, 
	ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com,
 emil@etsalapatis.com, 	yatsenko@meta.com, isolodrai@meta.com,
 a.s.protopopov@gmail.com, dxu@dxuuu.xyz, 	memxor@gmail.com,
 vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org, 
	gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, 	James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, 	linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, 	david.hunter.linux@gmail.com
Date: Wed, 01 Oct 2025 13:23:13 -0700
In-Reply-To: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2025-09-24 at 17:23 +0100, Mehdi Ben Hadj Khelifa wrote:
> -Change all the source files and the corresponding headers=20
> to having matching sign comparisons.
>=20
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> As suggested by the TODO, -Wsign-compare was added to the C compilation
> flags for the selftests/bpf/Makefile and all corresponding files in
> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
> carefully changed to account for correct sign comparisons either by
> explicit casting or changing the variable type.Only local variables
> and variables which are in limited scope have been changed in cases
> where it doesn't break the code.Other struct variables or global ones=20
> have left untouched to avoid other conflicts and opted to explicit=20
> casting in this case.This change will help avoid implicit type=20
> conversions and have predictable behavior.
>=20
> I have already compiled all bpf tests with no errors as well as the
> kernel and have ran all the selftests with no obvious side effects.
> I would like to know if it's more convinient to have all changes as
> a single patch like here or if it needs to be divided in some way=20
> and sent as a patch series.
>=20
> Best Regards,
> Mehdi Ben Hadj Khelifa
> ---

I don't understand why this change is necessary.
Have you found any bugs while doing this conversion?

[...]
