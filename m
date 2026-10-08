Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB743849F
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458496; cv=none; b=BxYjoSUgt/R0ATNw2d1zRhzUPA2AFyhT9EpJ8cikw2Owclj+kaJEtDsR96gt2TU6FCJJmqK2Knl5k54kkIjek7JetdpKMznjN8ohgB2kTw6CBym6uFHxbqOW/sgYrAOu+wZxYtHDMGK1Ob1w+ZpN4fRyCsH4Ik7zgCK9o/Pn778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458496; c=relaxed/simple;
	bh=Fqn9tzEEqtreLkYPNvwrCcqkYHSW3AVRabpy5H3rAnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Z1ZmnBTCO32M41/uYj+ji0WdL7iYfq4Lwi+anPtC2/akpYFkXsiddAQuj9DdbpEgbB9eAPxtT3Q16EEgB5YnMRuMy9X/nb+JgP0qSpk5qTbj+SnAAEoGx0+loH0F2aYIisn2SqcM13OX2N++y2Y+CCSiVxyjQDz6w22wvuC7HeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLlPXS7w; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLlPXS7w"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-919abb3335fso8036506d6.0
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 04:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791458494; x=1792063294; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XBtEgCYTkDYlF8rhkAWV0BXkttnNs0Zfs9r0xpCD5IM=;
        b=GLlPXS7w397zpMWtqFq1zTad761xze4QndKwYpV46K/slrxAyZd59pAjUnVgwYaR8c
         M3YmTdx1nGbOC31a19U5YJF+b9sAceCJBHiR9AodFJblE6W6OkPZZIArzPpCNxV4akFZ
         yYo94QKMYMKpCF8Lmu4IJirimCr/zmhx3b4Vgxb4GOisLqpG4oSVCgmwyTxIG/PNV4RC
         ibR6Ucid83yCR7o6fE5erAAja/uEw3brRnbyLODH/3zcZtH1Mvwwox+vOLFBval75yAA
         NommkwgFVZTMuCYr/iUtZMOGeg+33yBRrrvkqoa/DIsuUezBjHSoY7/DQ9EdyJjQaAqA
         47pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791458494; x=1792063294;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBtEgCYTkDYlF8rhkAWV0BXkttnNs0Zfs9r0xpCD5IM=;
        b=eHErWZ3phd8iWM8yH9s+w+Vw+HSsgBnFAMxqcSV3eBlDC21bIK4YvzWZNqt9yiGmQ+
         Pm5f5CLEQQVeOdQxkwLENcyBxaXBCYT4taTeLgZmOXm7DyjF3x20JPKsyYU4v3sSKLyR
         X+Ves3PfQyhXGDpHY6+RJVgaNGi8mesAtal2HiKIuJwYacYDzoG8/9Yk2FYBhv9vhXBY
         JKWsRcUwaFocadjm2e/knosJO6V5guECpNZ0sWLRd5sItwfa9/GUttLXdLfeyaUBGDNE
         nBGzsMNcqSeK2BMrP6xYNY7IVuutVQsuznCJ010KFg2R0SUGBgjtf+St76vPJ/0IXf3X
         LTrA==
X-Gm-Message-State: AFuF++mXxtZJ3qL3h1Tx3U+D9irtEcsfKGuzQvnFxCt2qbymy46ln9vX
	k82qv072MvULSBZwYj1wr4P7cMbXGZuE0WN7+3YMBuuXh3V4VhxtXsUTVyHtFJc=
X-Gm-Gg: AYBFou3+MVu9GKYi3+HXZT7xueksrw1cqfIecAJIsAk3z29hda09EI2cRXYcAc8GtZt
	3KHlFqrtFAJE2Mcjn1QieAg3kuADbn/bm85Ertb4Qc02DFlc7NKPNGfDVzWkK85EwhYVAZssj2Q
	UzvsrsIpmCUdeuDtweNj3d5SJ0HxVSklQgnk/rmPnBVZQ8iOVmAFJ4ycElWectUExWVeNWPYqhO
	r24gmYPaJQgB7gXfbbRxprOSld4dlKjk2fiJKv0WM9ws+q7aj1SvLa8CJH/Of0RO2E+DzTzSf/K
	rNXJQXV5e0QwGZuxsVEBHaps5IP5r6hhFM1DYZLV1t6cl9qEuGm4wfkYVYqNZ2UlQacTwA3mc8H
	K4nBSPfccnnfX9+LCVghXICQ64ow/iiv1TwPmaR4/F3E4j16LO4YkxZmGLGGI2vUyFe9rCHBgkA
	Q+qGk36WAnnIsYKLIQeyPiPtcRehVU/+B3BrVdMxgVLsX4TW21jUoPzGQH0bWXkD5q+C0R4jT9G
	MCHdHUGapUbAw==
X-Received: by 2002:a05:6214:27ef:b0:919:5ac7:5c81 with SMTP id 6a1803df08f44-9199782ecb9mr78993746d6.25.1791458493810;
        Thu, 08 Oct 2026 04:21:33 -0700 (PDT)
Received: from [127.0.0.1] ([52.151.198.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-919aa12c6e7sm18836286d6.45.2026.10.08.04.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:21:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261008-mptcp_rm_addr-v1-1-b4d35ac8afef@kylinos.cn>
References: <20261008-mptcp_rm_addr-v1-1-b4d35ac8afef@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: use offset to match
 RM_ADDR message
Message-ID: <2df6d261-cc78-d19b-ef09-d42e041d0aae@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 11:21:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/37761573416

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8bb8b9b418=
40
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1181526


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
