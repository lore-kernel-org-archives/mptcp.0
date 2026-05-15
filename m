Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10353E4C7F
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841313; cv=none; b=eax273XpQOTo/b3CW5Z3hCBTxWhFLEiQ2tuXYHT7Rxe8b3EA2Qz2kZNoVV0kvOecoBqvLRdM4bR3IQM5LGG+mLo3rI4mVo1xd8WfjtcH6ZObDgbluiY4zKLnQUdu1FTKk4OxFtGCYTTwem1s5wqdHe4v4fRRsgmFAZlUFQSPFv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841313; c=relaxed/simple;
	bh=E+7Lz+LLnbcr6xhXFxLTxGoX9vglGc0fI1wW0dKBQrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WvLSQO6UW09dxSY/GQQC+LzDLzxfB+baVxGV2bx2ipV33z6zi5ic7lIRrHJQ0omKpfLLwEEWs/bLb/ze92+5N114HcjIgo1eaOkphtHM/5Hbg6WDIwkv8/tIM/8557T7kksSG8cM0cZIFGEmZwkr4BljxmCqMNdCz0ekgFPCE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnkDUBgC; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnkDUBgC"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so137824136d6.2
        for <mptcp@lists.linux.dev>; Fri, 15 May 2026 03:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778841311; x=1779446111; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0LL+N685nfwh8ZwqARrWKovtnVErwbqZ9tTGFRqqt4=;
        b=WnkDUBgCWDZ83Qtv6tQCfg7ZYjyjbndNAUBMDlO0v9X3beh2yq1HHZrAtNhAwxyObE
         oyPkp5fu1903SK9tPWVpVjL3JDEGH6E+AfuAYZqdwgWWO57s8iOM7yd1qExEweaKI45F
         MBmkUokFPTV6GqNsLNlI9H5HJHLLwPxc5iE7dEbuu71de9wFnIGE7ukp6dEOCpqyx+vE
         nO6In1xoXpKpyZ4jpPpBNer22ehkRiO9raK4MbMF5/qYJTJv4VIsYrwEdLBg2qEmK82V
         KDniHOnMc7c1KM3y+kvd+EAaup8KLd5FRIadc49oVUCYIGVdtTetlHiPYatn6wSfTXLx
         jz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778841311; x=1779446111;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0LL+N685nfwh8ZwqARrWKovtnVErwbqZ9tTGFRqqt4=;
        b=GUng26hxZZJdPYS/oM6VW3N0hgxmCrvgLQBWo4k31phBYhQqrl+N9MdSAJl78BBwqu
         R/W4yY4vBOSuYLP/c/4b2qAvJGd8Ly4ISs44cS4if4JLfjU3nF1qkc9rTH9u9VrKn23S
         +POzWvn8QwEEHiM0Ev+gEZEkffSX4oqLIeooiJQP+qBOp39t/CuXLj31uwibBOSVnC+E
         kCIZPA0ID7dtqmCmNT5cmwfFVkzxjjoVwYuzOrSE099DAHPsFmaGps4+Uif0m/PBsZIP
         WuoJVFTtGBikSW7Glu7a7dPLPxrRvvzl+A7zTkHSKmUKMnUkvXLskKqUbO7y82erT43U
         wdKg==
X-Gm-Message-State: AOJu0YwBHY4uTueXqOiddxsM4XsjZyaNhyQYvOK9mHHK1xbpoATRSNeP
	nY/AdxK3UtFFGsPpAXydQgGtwIhBrxywytrFnuxZRBScK/HDrHx/IorPGlOR
X-Gm-Gg: Acq92OG9C3fLG4UyyD8o8EO500bM/GCyBT4+dqJts1kbOoE0w9t4IoGwJnMSmIsXl2m
	ubR3XYnnF4mq66ng4fo/CdJDsEgVsNpbc7Te4jciyRmVvL2K4T0OdCfwug42WO5GfznJWoQhrx8
	ZRKxWpc8sEHT9KOxWBJhOL7jy+kNzNP14Swx3QDQLsSZ6j3e4agBvrpGJloclercKhvy0bAkBvf
	+mGGZFK9xKuWqgIGgXKu/PeEqS8YeMY37jS/b3VnXDhDw/HSB8LHLnFpOlSCaS0/7gimNTXv3P1
	ZViYyjZco+9qxnHZuU7IvRkCXimL5vshoS0GSO3UJch0CuGFoMCkp3vkIiPPubKuGWVoJBLbqrU
	uCagQZjCd/BSxv90P5DqbdLVIur5F/0giaUDVRrSVlzyP7BGrEJDW1ErgSFwFd0gj8oDqr4rHXT
	1sMgrOcx/xX5Ydo1zC51uSods3aaA8EIs+PcANgwPUtnekuQ==
X-Received: by 2002:a05:6214:2d48:b0:8c6:5867:115b with SMTP id 6a1803df08f44-8ca0f5e5f83mr60190206d6.8.1778841311016;
        Fri, 15 May 2026 03:35:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2dc42csm48710106d6.26.2026.05.15.03.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:35:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1778835009.git.pabeni@redhat.com>
References: <cover.1778835009.git.pabeni@redhat.com>
Subject: Re: [PATCH v6 mptcp-next 0/7] mptcp: address stall under memory
 pressure
Message-ID: <69d9a687-5110-7906-2f6b-a44482112fde@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 10:35:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/259106=
12780

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0c52f631034a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1095238


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
