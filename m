Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818035;
	b=n+a1sPPWVIQZXkCy3vBtBHHtVRJzBYkfYVNeYDx7o88m2s4MPkpZNeT8pxnYv0krL8XH
	 HTUzuZVHSFUm5w+iaZiJye0bUviLwEneJ8eCZkap4STkl5IbgtTirf6esuSgZEsDlXEjk
	 VQ0o8ofh/mC4H7zD3CzLt46Jn5if3KwzT7wrowqPUgBwM8MAFpIYn5EaHZPLNiXjkEgl7
	 GXLjHh/GuDxrqcv63H2B3nr4MPoQaJZ66+AO0ascQ5IjjnPyXZP/ucxAs2Qg5fj6mMd93
	 P5+TrDjFbiJlyo6Ks7Nog4XTyt89n8I2XXmYvmcCCHX5W8sWuQHfh3p28WbVV50RaZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=lmi3jAItBnPlbkdV5NxHe9GQITzMV4B3dsG4mWhxoUY=;
	b=o+TC/0KTDodcqBOXHUM9DT24aTrhzXEwNvxV8vXz3bSetv7R9bwULkg6feG0rkrXuegC
	 /iMRmCwTK6uVaC6Gbv4haV4oNiB6QsF3vnH7R0XjP7omdcdYXsgS7I44dCG0rLfeP8AQi
	 2G/1Y1/UzRD4WyrLiBVzQ0Fyvp9R0wljKlq4z/kZ7OuL8c0bLY4wVsIQKTD1YUpX4hfKj
	 JGXqq1Y2kCoUnRAC1eyxt3GKX0LYS8/+nmxkF2TlK9fmsOWvUpQ86wz2I155zfT+MF21j
	 bkMMXc3sv+XDdUwUOwBTkTEyl9yjxQzNBR/eI73yDCxlikDK/hXWtPbRSaY0PxX7qFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENuReaVV;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFFE606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 08:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CFFE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENuReaVV
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1606937a91.1
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 00:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794818034; x=1795422834; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lmi3jAItBnPlbkdV5NxHe9GQITzMV4B3dsG4mWhxoUY=;
        b=ENuReaVVVq1N0bWYUKqOjGI/rm182qW3r9mfDze3irwSyebrQ+sWM2ZAuVjXP7oO5M
         i7urA5MET5YO5XGGUtTH9kgXezDYxD19hScmOwBDhrOSwlJLnkqsV/ILe3MGLktOgtGm
         jYlsADoEAS5lwoZbXIMik3WAfWYtC8prM0xJp4CTHxyw2TS5xc2qOohLV33+l4BC1VAo
         rFrr0AdVnT/FM8XQdkQACBcX80klASm7kbhiCAMUo1ZXOMYRg7PqAKp2j2tgjNyop5V9
         xYG+EEPm9h0mdEuCutDjgUK53jZw5CJj4oZHy3973ioIVkUSCsKw2zkbS38lGwoTdh9g
         yWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794818034; x=1795422834;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmi3jAItBnPlbkdV5NxHe9GQITzMV4B3dsG4mWhxoUY=;
        b=yiQs3M+bL3LArBprb9pNrCMVrDZjxwR7xWLee4eZWzi+FLL6R58D8SgHqpoLxMbZMm
         W1clpBYK57s2G85SU9sxwZhxmdeLDZRsCwup7QheDIt8w4ZvaobA6vvVc8NNDMn8M4j7
         ak1EVEntfClGKrpPSRFYlefZm7kZ4b6R9g0IWW91HVclnOs+Tg8n+KFbO4CdVNcLPBhm
         Pcf4DeLCrXGOVtKd9bRglxqogrjTOhVOy9u98a7PFjN6u9e9H6HV12PsCXcTDARm0xeM
         ki0RMlkutTEq0CTEAmb0RCTpQaC831+rGcMI4qHjEJPZGyUlxJjIfnBx5ULhrlNOXiKe
         W4BA==
X-Gm-Message-State: APuU4Z8bJnCAb+mV1UcHyIpnpURpq+aMri65b3okPU8LVegTXaHVmrp+
	50exKNYvlCSXWNBybeAQUfx0cu3N+R2LH+nbyEemB9Vn2kroPPvS/FM9OtYc
X-Gm-Gg: AZFdTZf11L2rZFQkHAF1N/oCSAgwpQOGkReKGHgy85L2qwOqjGHwvw4DW+e2LxMl/IC
	K1dEdVaLcjj5ECdzhpJh1F9i9mQ8wjHx3VGV5uGyc7EBl3azGagXNtQMJgOxwiQn8Xy42Ph0tre
	t/G64Qqyf6nD0dwNV01JARkaUdhhKK0r0OqPz8lPkXs+qqjhLAALMN4UP4A8oOUEI9z042xwA55
	+6ET9/A/2HSW8nZlLFRfYP9D0vU+/8kwhQXzK6ZnVK2sQT8HMVSVFlaYgL3ZxKgk5xJyu5FGWr4
	OIxaaegunFLE1ereTSqK5f2PvchWSS0wrFSr/rBCtEZ63dqH+g43AoC5MmQZWiCZYBm/KcrQa7Q
	sCfxjeybQkrt62M4J9W4S2hCnF6BkzkeUmScgf/UQtcxOOOFXcVnAph+WWIrIz0/bEa/EJFTpqI
	iqA5/6cAjpNiD/+E1H3p3BlbYbFf357AgCoqFmptPmD83hixj9ecKKuNfmhs2vP7d5lvfWoXxWN
	KTGoGocgNWCi+Fk4mffbXQctpi9a0av85DthbFhm4pvNfosWvgDUEUew7HalduvYDwluBGpkSRf
	NJSfM6BKDBg2hnkq3L/JIv0U66ycnfYapEwVdoEt
X-Received: by 2002:a17:90b:5627:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3b1b0ba8ec8mr10378017a91.52.1794818034225;
        Mon, 16 Nov 2026 00:33:54 -0800 (PST)
Received: from github.com ([4.246.71.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197b76ccesm20686860a91.0.2026.11.16.00.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:33:53 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v28 00/11] Reduce the differences between
 TCP and MPTCP for TLS usage
Message-ID: <9063ffe1-9e85-24d5-efdb-a842f1e80e2f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:33:52 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): error:sched-mem-pressure - Critical: =
mptcp-perf/01-Test_1/client.log: 1 Call Trace(s) - Critical: =
sched-baseline/15-slow_primary_upload/server.log: 1 Call Trace(s) - =
Critical: sched-baseline/16-balanced_upload/server.log: 1 Call Trace(s) - =
Critical: sched-baseline/18-balanced_parallel_4/client.log: 1 Call Trace(s)=
 - Critical: sched-mem-pressure/03-bloated_slow_secondary_receiver_tcp_mem_=
parallel_99/client.log: 1 Call Trace(s) - Critical: =
sched-mem-pressure/09-balanced_both_tcp_mem_parallel_10/client.log: 1 Call =
Trace(s) - Critical: sched-weak-secondary/01-weak_secondary/client.log: 1 =
Call Trace(s) =E2=9D=8C
- Task: https://github.com/multipath-tcp/mptcp_net-=
next/actions/runs/43820031687

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6ed4908217=
c2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1212327


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
