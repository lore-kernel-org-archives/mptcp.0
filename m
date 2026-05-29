Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9B330305
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050343; cv=none; b=pT2ahhAmNxgHpe8fCLBXg4ToGHTu3+Sadjr8D1XUqTjTmIx4ytGAe1y/Pp113YJmtPtMftvf9uYhYhodEDN9Fko1FfiId2vq9sEJ5GUkK1a+6N3ZU8Ns7ro7B2It7XwvsQS0JoVLwZqNIQYeEJyQhJkeZbk2nU1Qf1UBHirKAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050343; c=relaxed/simple;
	bh=Dm0no7Uj+FAQDPiDtNNX4LQXBeptb/DIrsKx0fncxf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=o18b+HMRlrYhoWPDBT5fSpGql12mg6CakoNThIlR4TsMNa3DUCENcPHUw3PCfL/Qn/LaOqzOVeeBa8ty+Ti/+zYWVF0kIWySKozxa+jzoZqvziFmMx3uvyzM8tCpAwFH21g9QSS/mapES7MPiJbYiSEhxt9d/07G3clWIQoIM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5SkuMdX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5SkuMdX"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-914b5f85129so649066585a.3
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780050341; x=1780655141; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdcZzNXBmwzbLMRW1ev60nvhF4CawoJGP5MeTM6zNBI=;
        b=n5SkuMdXWfCxzXxeOcCqsWyBICMxIeaxWxh3ijoAEUvnFmV4VMSlXz6kmHfa5BNmco
         Z45v7WWobLW1CdjtuaXQvjz6Qnd3W2nnaHxQnEjyq7xTg5L8jwgm8/0Ls6AsD5rwdduT
         dIhB14PHDEfBURYYCEbm1GD/UH0XKJxlGFyQUeZoOtrc51t0MAWbqlwDlEo0L90YeIVa
         MzIA6ad+PJ9K0POIaqwRbN/KumdbHlQ1Nc6Naob/wCcEisTvutTMe0rMTzZ/T2+vHF4V
         s1N39vXaUkP4Lqwam31LmDO/3M5mte6+u9PizWmwyuY2BjcBGawec92WTuiTLWi1oPCZ
         4A+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050341; x=1780655141;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdcZzNXBmwzbLMRW1ev60nvhF4CawoJGP5MeTM6zNBI=;
        b=lGFcuti9q60P6BrYZ2ETXHuyVcU6Odqzo9haHV4nGZnkRnBhuWYZMBi6KHYpUyvgFB
         0Ewe337cCaBXHuNOT2uFmcySf+6s5LI4IicNAJhsrzniwbXey5IwYEF/G3IS2mPeMlFj
         +tBAQPzyZqcBLe+1QJfTqOthF7+3Pp5XYvJHgbeooQWdqalsGlg/lBdMXZKStJ2gbVig
         aFQc3LQMIX4sfdujb6B90POptEJgATZmpbsRuu/PdYaIRIM+6YuOx7J3ULrg8rT7leis
         dlAAI4ala6PNT/bojnGwi3K6TjN1qZL9XkCJRVnpr7BGlN2IVPKXmPrG0S1kXIMbmIBf
         A7ww==
X-Gm-Message-State: AOJu0Yx0FMKlq9MPlKcJMpubPKkP95SL7dtQhz2K2n2NfwS0gEL2UU2g
	aPTVTho3ujgHStVK1mnGYiAB+R5VS8xA0zyKSD3c+/LUgD+pRLiwK/KYiT/H
X-Gm-Gg: Acq92OHac9Kx+9jej9v9xikqBerNfPc5SPyKDXrcpJ2RFH6mo6nKQYIbBcYnQhMmuZD
	WsJEZ/bPkNhJ7FTYhUH6MxbocQONu914IqVaMmKKXZg76zv48rAkyTTxzLVFEub0v+i+JdDqx1T
	OBYdXKtw0jeGH7ryWkyYcs9pY6WnHV9mibtJIZcxxwHm3gWOR54tgXHE7O45v0hyVr6gSNTCpGj
	V9P5nGtaTgQ0/CHJKkmQ6uSBEOeAzTWyVvCGK7r+Qu9AiRJy5wTotYcJ1yiSHjX72UmlfABSMHR
	pKIwDkakTJt/CA9ZItRLd9rpB4WHGMpaK70Lnc4Hv5a5y93hiWbKTGhyDDnh4i9mJME8j9f4c8i
	1P7JbKlaWcUT1d8Yzbloy9MzNqiAW3mCGwaBh59CUKRyPxSE+elpuEP/TS+KHwooFaBZoIFBH6F
	m3mIDd4ZYOqJ/SFaXg2ohgZWxni6ngepneiWeP8aGM9s41cfk=
X-Received: by 2002:a05:620a:1996:b0:8b1:2853:673f with SMTP id af79cd13be357-9152fd1cdffmr289767585a.15.1780050341311;
        Fri, 29 May 2026 03:25:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.95.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea23e115sm10839836d6.42.2026.05.29.03.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:25:40 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260529-read_sock_fix-v3-1-bb3fc3f44b22@kylinos.cn>
References: <20260529-read_sock_fix-v3-1-bb3fc3f44b22@kylinos.cn>
Subject: Re: [PATCH mptcp-net v3] mptcp: check desc->count in read_sock
Message-ID: <85b14f9b-849d-42f6-c8ed-d14bc7f4ab20@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 10:25:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266288=
30138

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2de62cd3bf50
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1102746


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
