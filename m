Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384F2D1F7C
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347793; cv=none; b=JQoyXKZLqOQrZ/bxgIgMxLfCA0ZhkIQVaNu/lvJ9Vdlz3BeZ/46OFfaJxARGw64QwwWz3fXR3ziVcO3oYFbIeaMW+U0ILAcVYs3SWHIVnen7RzbwagNRyfhQb5o6S4qPtz3ArREYkX1zowxvdJd5OKpphvootgXYqfsyMTjeU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347793; c=relaxed/simple;
	bh=qIvPWmRBO/fBSvmcfk2mfBJfl7oJELuo60MLhd1miCM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Yh6H0gZDDf5w05zriSvxOwbuzXuB6A2F7c+YZr/HhFQjq95SgSCzizLpWUHIMDkSJ0J8fwSxGivCTDUFcTurRvkRq87NJE512zqtpZA7RDho+BkF/Xe9SrKCC9tbi2kAcTNfVXRnrXb06r0Wz/USpqFxfYIRG0iSYdoSfVQeKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZFQURYP; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZFQURYP"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4332674b921so11841135ab.0
        for <mptcp@lists.linux.dev>; Wed, 05 Nov 2025 05:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762347791; x=1762952591; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JALAFPHkzCbqDw35UFLPhwzgbQP1jssLKi2Ss2tDGo=;
        b=PZFQURYPqGOABEr1AI4dr5AtW36YfGEyxBjcXaUwx+i9w18m4wA0xx++D0VxwR9UiP
         L8VOaTty5rUJ8ZNAm8/TTD23zUKBaKp6Ozi3YM3JSgmOfyL3N1Ls/QekYUaRcGhiak/v
         INTgwX9fRgxlYXuQEAqAT72RR7bZnNSmDc611fyoSSoJRrOK1SCaZUCuTRyDt6CFYPDK
         +kwftqSJREol86NqFm7uxh7vQcesf6F80vmmiussfC3rzeX+o+igkAlL1ULMvVQOdRqi
         vq8QbYaVRfsBkk67B+ABDKSGXQdhS5Vqfc1g6fIq5nLtXWGEFpcSHGhWPSVOheg2xSqp
         A3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347791; x=1762952591;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JALAFPHkzCbqDw35UFLPhwzgbQP1jssLKi2Ss2tDGo=;
        b=AbBF8N31udhuv3ZqWq2AhvKaYOoT35lBCHHmkjqKg9nLarsuQHIbUE9qCfzINT0SF5
         ZjCDliCDQCsrNb9KaU3P35vVptrhpSGosCzs0P+T2OzRBoyCjYc0JeFBCo7Zt8H8Ij4h
         5xIE/NXJbDDdNby7DgKI55mkvqDqDQ/QDLjj/ECFNmNoFmXaxT/eUPIZacS3rXGOMc95
         Rh50l9avxw2TkzeNDfPlLIEWQJYiMGl3BsfMvXbUtIwFsUvnh9GaiEv3gAjGvmsG0i/Y
         P7A7aBJlTzHyp96q5JSJ2VkLlP5K7V5M3P1+VV/H7weZM+Dh4QRuNXBRDxUzIbsj6O4n
         ZoIw==
X-Gm-Message-State: AOJu0Yynb861InLrxs+snTmhwaas/eJ60zM1jIxM+OBJGBqRMd9RqEwp
	wbWKLd9ba6Jb0Bmo+OaTRJe6UFnQHAZPBaChmxJmIyUWy741stkZlb2IxvhQ
X-Gm-Gg: ASbGncsWU1L/vodIwhjynIpEnnRoNVcLCUIZqEl7hH3wLZoa+J5H9B2Szs2wtnG74wM
	9vVVhyWtNCb5+zKW0FnjaEo30vWecEXl2UB998y+18I8AZ2zz/No8RdNePPzHAoQmdJfbRZefpr
	NoL69rrtWsxBJnFIOHbQnNbC3tBicjeK4uvJsNvWjb/s+Z0MqJixvIQu/a7tcp67oH3i7HOPvEU
	wnkSKmgPce8gcTEvc6h8HvVkY6bZ1dAEHLKyelZTuqCzEubsRaUCKGRuHZHJXJA6jjXGhXUBXPi
	EDYr9rDPV5YfDUkCqna0gYIQ0Yr5pNMWtAt8QbqO7B5cNgjCfRePYG6SSHojs7evoLPYzVmeZAe
	7rHlRI3D2nIhGy0etW00kOTM2k/aZCQxqVQScMTS/Qvigf/GtQcSRHfxPT5Z4WF3TBDL+1hCRK/
	3qh1C0CnZUEqpQKA==
X-Google-Smtp-Source: AGHT+IFmWlB9ohMORWXBJFf931Zy1o+U5Oe0SFEPS2SqIk13m+70RFrYKuYF6r0DuB6vMYOEQOuhEQ==
X-Received: by 2002:a05:6e02:2182:b0:433:2a9b:1668 with SMTP id e9e14a558f8ab-433407e3592mr40286135ab.15.1762347791089;
        Wed, 05 Nov 2025 05:03:11 -0800 (PST)
Received: from [127.0.0.1] ([172.183.94.132])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335b70857sm25611935ab.34.2025.11.05.05.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:03:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251105113625.148900-1-jiayuan.chen@linux.dev>
References: <20251105113625.148900-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v4 0/3] mptcp: Fix conflicts between MPTCP and
 sockmap
Message-ID: <6fcdf637-4bf6-3ed2-0349-a14aef8dd845@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Nov 2025 13:03:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jiayuan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Script error! =E2=9D=93
- KVM Validation: btf-debug (only bpftest_all): Script error! =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/191015=
79816

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c93a653cfd56
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1019848


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
