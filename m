Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140B34D3B9
	for <mptcp@lists.linux.dev>; Sat,  1 Nov 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761996036; cv=none; b=Stj6FzV9P/YsgGpVtkUjo5M5TKYDLHRq3dGGY4USxjeerLd0Bc5kftN/mNa9jzEOB0l1z/zAk6B+N5f5TJaimHsvSkXgVicKpg7Pc+WX1nQ/ZYEd5ZgJSqf0cSlkv9gEZEkuQlacJrlgFT+flOshFX7T8BbL1XV8kjfGB6dQQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761996036; c=relaxed/simple;
	bh=IFzhQKXe5grNpUQ+QbRJSoMRd0dncngjvrn95oguhXg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fchu2cRdALWZn/RX6FfICjPnzOKjx3bty5yutXaOSFAhrg9VBSuN79jtHqatOZishTDfEvkzDJPlkh1Xdwhq1GujX7GXcVGCLAhsIB4wnMeGi8rbQQuwfafTrlAkHCtp5s3QkrVssh+VJXXuyTtb3jcHB0bNlNT7RmQluz72I+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYqRH12l; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYqRH12l"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a27053843bso4492913b3a.1
        for <mptcp@lists.linux.dev>; Sat, 01 Nov 2025 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761996035; x=1762600835; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf3ULd+FcrCCfNAd3JbcDOowxnsphLt439finQd857c=;
        b=JYqRH12l3+lxV2begN3Dz1kXPdR9+PYAAubWznyFn1/DOhquo99RQ265FJcUwonF3K
         u9pHH2fwUkKME8gSZiYpKNdErLMh27RlECwm1O94Z+eJJaoHzMGfyYo8kTPEjVYSiR2f
         Y3pczGFGo1mHBf5cUOVmW5myFvs/YDQLDhR742pFObyJP+GunRi17ATCNX8C/aYvdbTw
         YhMiP4Jwf2AlNhU83uhX1EqAWRHC3QRkvQ5zwstdGz+FWdA45mNng6pt/HgCIE2SNQ5q
         ITJxlZRDoTqqfbkVA+qk2owEf/CMHjZmZCbwydYFcT75eh2nS1VrQ5+a8kqbuTb1RebP
         bnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761996035; x=1762600835;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kf3ULd+FcrCCfNAd3JbcDOowxnsphLt439finQd857c=;
        b=vFa4JdO47QHsevrROB5oN3FCGeL8stO/j7sy1hhYn4ozPElfNhbEtv3MSjjBCyXm8V
         ZYD5hnCl0VgEHWUb8yi/bkQ/dHQ1zVVZc/yjDvn6GqH/ji3LsguCXwi/szqEYLtkqeKG
         33OZir1b/5uP1APYDYygcewSVcwXkXmgBQcRb5kp7Upw6hCstpPEKGK+JpMhSjAI/LRs
         VUq3SDUvtVgySsFOK+nGK1P46Ciy6MocH9cMP99v4b/IGOnzEUamHA+IbPfi6Jb8HejJ
         2/pfkfhhdvMsmUxuAYTpHgjM2wqX0HRcdoHuziSzrWLFc/WeF70Z3iu6c4x283CatvsI
         jssQ==
X-Gm-Message-State: AOJu0YwItJnYBlbK0NZfwbTZUYJzKQidQKLUYmmLkQTZsocPixefNxnv
	bykiPo/UCnzLgSWSNGMFMy+lgfLwHZsJHVSgprL7K6yY9j6qzecvHaYj9vfB
X-Gm-Gg: ASbGnctC0gVDv8egeDpcetW6gIw1v/XPI5JlcHA9x1bXtYcb9zPUQLvTQvg7EwO6Inc
	adxNr5IlOYamccxp908N+SB212HE0JRuHghSUyAENnNSnVATMd0kE7jLMTCMJexvj6IdAZLYsfG
	fhnLdXC3bq75YjdE4YKZeNhzRgkaGWyQt77zj9/OhAorgVuhwb+WKFrlNKZcFECD8ltF6AO0bIK
	1raZA+sjohbEQBSLHjquR2wKjXNvb2xyvvIw1tujXWEE9gVsZHamMjT92YXaWxErUhmZglnPdDP
	JC+RAgoAaYA3s0poFFGtdjjXs9a7Y4YqWqjgq2xyCLQm8YbntyPyABpN5L6Q2+MKRj/fkNkUAOC
	UtklA/ETilGzSMEJJ11MErKN9Usa+a7lHb6fd0YqOWYrQcjecMNVPzTnZZo1ygQBHwP+Tl3Ekq3
	KUZzin5T1Pn3jzc9bzExKqeKRL
X-Google-Smtp-Source: AGHT+IE1iWqk6YTIhVgd+vveuxbTjepzBfHxQAK2BqhNqkLRbOE4KuwUtOIZyjsXUl+1M0E8+oVPIA==
X-Received: by 2002:a05:6a00:9287:b0:78c:994a:fc87 with SMTP id d2e1a72fcca58-7a776d97f3cmr8617103b3a.6.1761996034632;
        Sat, 01 Nov 2025 04:20:34 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a07cfsm4931934b3a.39.2025.11.01.04.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:20:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1761931390.git.pabeni@redhat.com>
References: <cover.1761931390.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: autotune related improvement
Message-ID: <0a5b1aa3-065f-70b5-ec2f-9bb058f27b62@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Nov 2025 11:20:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_sendfile - Critical: 1 Call Trace(s) - =
Critical: Global Timeout =E2=9D=8C
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Critical: 1 Call Trace(s) - Critical: Global Timeout =
=E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/18994741164

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7e6786f6a20f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1018332


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
