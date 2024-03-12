Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E333994
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238584; cv=none; b=iHl2PbrwGFEkvg1H1egOxyTQaEv8QEJylP23P39r4oyOLcuSSnVyaEt3sWxihplF8woq7Tcz9ZmA5Qi012pPrEDvrSeVwU4P8dp68ltCrimlkhI7YkV6jTvvgnGbcnSs1kh72tyTie1B0Wbr1Jq8IJkFKNexd9/Ymp0rGN9d3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238584; c=relaxed/simple;
	bh=yjUftx2N130dJJ9/aabBBLWolYz28nl8BlTl+4cgidk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=QagUwwr5AVednMeGUEGJc+lGd140KF3a563aqbQxOVO2l7RCtyQuu9OcO2+Ut9cU7GhJRkAvFCYXBHYDCNjqICApn4pN46AKMmUYURXoOA7MqEzZcdFoFlhWjQfDS6zGUHA+5yW1/6Y4fAfKIrOSFwpox3K9vECDqEIJgdxc24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTFGhPbo; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTFGhPbo"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-690c73735b5so22978066d6.3
        for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710238581; x=1710843381; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5q8HR9jTr+zGKuC49hv4CUEoiAtDNEPRgHe/+FOGFs=;
        b=WTFGhPboGKalhoxDt8cC3h4gjf09MLruAS1uhUafue6dXOBB+MnVivJbZUdw2Zh6CS
         PJAeNpVSgzJc33scFm39uRuF1E9uFydwaEiz+FlO+sYVwnMVIMxPjoXhJDETqN3cmlrA
         8FanM8y6Ya0dPx1GWMYRVIfKCpvJCj8xEmgmDCuPEwbtDQWbZvTy7L/JYumvRol0RmxA
         Dc38D4pBYf6tfbPAKhrufJ+fP7Zmunp2zqCXjOsZxRvFg2gm/vXylnVPw0OS7ttrP2/x
         Hr71/BoI8Li5LU3LNZ44bD1J+XbZYuiGEK/7vLu+sjPUW7jMZiyUT4lZb0IpSFm7UJ4E
         OcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710238581; x=1710843381;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m5q8HR9jTr+zGKuC49hv4CUEoiAtDNEPRgHe/+FOGFs=;
        b=G+wgpHrSyLxYzEHBdx6OP2Zci2tmdRnSuilrgHEnxwY6caXLjU6RRK7GV1A7tU5Wnt
         NUfMYI7H7/uIWmtNu0zhot42v+OwQ4Kw00fBGLiLtHFcNRnax4L5VbGkPTKi7y2pVyRM
         0CDsCWsQYp97CIMQrmw99laHk9ftOwIEdrlMzboL4h2Tjm3MJZhA/7db/Kz6feEiHBK2
         g4RGudfJh4xwOPM/0jSqaYXU/KvphiVwRPIJiwZPTZ3wyUXKgtUjD83ejg3NCem1GPtj
         /Ocdt7/huzsJoTt6A92XPInXNzVrluSB7ZLqg0aSOoIMpCtQkmTlw5B2sA0KzGRf9K9v
         yImg==
X-Gm-Message-State: AOJu0YyecgIrVcyE4ZRb29h+bXNuPSe6E3zYGwe+uGbKKaIfA5hlcz9P
	qyVqtxxEbUzg/gMLm72w8AYbBN+PYT/sJZjmGWYE6aQyuFJRDxLqB5krbFY=
X-Google-Smtp-Source: AGHT+IEDMU1BEcrcA3B+XBxvWqoDuMvcqjEgHrsQYXVabroK5LyWhjK+XrfrqAoq5bfr6mZrZws3Dw==
X-Received: by 2002:a0c:e9d0:0:b0:690:b9a7:b4fb with SMTP id q16-20020a0ce9d0000000b00690b9a7b4fbmr8148932qvo.60.1710238581558;
        Tue, 12 Mar 2024 03:16:21 -0700 (PDT)
Received: from [127.0.0.1] ([52.184.154.93])
        by smtp.gmail.com with ESMTPSA id mx14-20020a0562142e0e00b00690ef7a3593sm377205qvb.76.2024.03.12.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:16:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f95589ded2c77edbc5086a808703c63b4641e60.1710206580.git.tanggeliang@kylinos.c>
References:
 <f95589ded2c77edbc5086a808703c63b4641e60.1710206580.git.tanggeliang@kylinos.c>
Subject: Re: selftests: mptcp: iperf mptcp tests
Message-ID: <1d607745-916a-4889-bfd3-11984c76e71e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Mar 2024 10:16:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 2 failed test(s): =
packetdrill_regressions selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/824664=
3924

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a391c5ecbfca
Patchwork:=20


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
