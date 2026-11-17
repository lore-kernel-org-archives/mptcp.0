Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794899071;
	b=0hXkK7lNAlMy6vAkfKexCFO/OnqbwiQ+j5UhH+8KLheHBMwa5MRFIo9NqNZYIReLlXOn
	 8CM3CjK/pfcBo/2EMZ0Uvvg3W5yzYbWpN8QI6wCFEDRBACs1isWyacQeN8/5OkOcnJuds
	 BwLlZhUjiTn/WXqGDvUT+eE29h1I5uZdC7aoiJXHOtgn4J7iKmPQCV2Wfe0vCfIO3nhYF
	 sj5RUDfESUsHokCTT5msnt2H38wAptCiXazw00cLdudkPi8xiSnKvhiZGN5J8nqybwnnR
	 CndpLDgJv1PWPQ16XccM+xKJew1idsQe3DSosiQyzjr7GKePqMwXHWxwpJc0AQTw/bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=x2EP7O28tYgyxZWxNa9jSLVc3Hgh5NASem7GKFLzfh0=;
	b=W2C/Xr8/lJv2NeyLfYFhDw/1kJe3AfmWAavo/XYjwExj9Pob7x0a7gtz89L19jYJEQlf
	 f+QJPC/nv4T4ZyjciE4KvVV14DXGwYNSnaRcuqYi+yLqJBYge2dC1EMdGUsH7nWGhs2r/
	 u+ix7dwEPOaQDc81lM37ApwC7lFpNYkdIIISlg5tWbSO+LyTb5YxEj8X/nnHbsPmYPUah
	 ARR5cV7UDY/7U6GJZZYKdN2kgDdfRKqN5bcWhyO3y412vwusuT0tdBfmDPDeDfdM0SwpK
	 2qF5X7S5592tzIutIEtuWEihxADcVXy5gLBZ2l680M2bolFvTfefgHkAOVApMlSuUEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NsK+kyoH;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523E606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 07:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1523E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NsK+kyoH
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso2516114a91.0
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794899070; x=1795503870; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x2EP7O28tYgyxZWxNa9jSLVc3Hgh5NASem7GKFLzfh0=;
        b=NsK+kyoHPncs/tIkYuPlYVLILHF4sGg1o/7K4EqfVxc6Bk1b0JROs1ZQC52HbrV6xz
         uRlMwYuD01T9Wo1Mmtv3uPY8NTZcCU0JiRFA9AfjlD4+wv0ThTj3wEvb2s9W7C63izpC
         Wk9jORViuYcvKW5pES8AgrC9qj5ZgtdQWZOLbhGobDX9aq4xBfin3mUyNpXeLz26xhXr
         z1tH7cmqEq5y6/525M0Q7+E9eS1yMSirW85QSreTCGr9yT9WRbIYK9tu32mEer7GMtJH
         7xTUHNY7sF6E1v7an8LxPYxcS38uxhV2Lugpmq/T92M5ql2zhNCS4uha8nxTmMVqwgTn
         2ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794899070; x=1795503870;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x2EP7O28tYgyxZWxNa9jSLVc3Hgh5NASem7GKFLzfh0=;
        b=IyxHWKbeOtd/q5Tc4B5D5dZWMFt1NrJRHlnqUlpvuq07CjYkOKUAKf+WD8Refef4TF
         vpeRlOJmpt13SQvr/idIQfv2jc1p+VID6uOYJ+zVHu54W0iEz4wCLkLDwNabF7lAmhpQ
         YVnku93FpBiKCHSSI3F+oDEmmVbVrECnR7IZvhbiXXQCeo/h5it6Tpl1Wzrxpjmtj1Ta
         S5AdF8aURfUzScr8n57sNOOBi1KThcj+fGVAjwo2W7dRrd5QQlJob7Z/Ep38vN5KPGyY
         UbpUGg8V7O1JDTKHS//82XhRqdSjI5oiqh+ozjJLofWP+RvLLCItSyaE7U2Q5PSQ5rv1
         itNw==
X-Gm-Message-State: APuU4Z/DgXj+BEzcjktfHTYHZkUQy/jeGE2QXzzQNy/U0rgDfRglnXIf
	OZpiQa+qCmwYWSiIBtxYb6UaWcleIl36wzYCSHyQPEEWHcPnKS+JHZc=
X-Gm-Gg: AZFdTZfI/vOKVmKMVkFu4DP9o9ArsnjQNqDLAyhfzZwZtOPajhEvxA3LhFgXAissLIf
	ZvBEph9GcZqCPsE9yah9BAjMrn4iPDLQpDe7G1pNHSZduLKiKxPuggiPNRkbg3MpB//Zp7E/Epu
	h2dYOGRKVvF5zltPEAotEsSH12mtH/f4Uyf1eeTSpfsldR8yxDKEcYvClH5qzGcRcBE2SYsu6Co
	Tg9XEIW2YiVZP8LosDFAYZL/0FUzFCO2NAFKTkftBEDlKWgBoKn/g2UDm1O3u4I7tltPjcMwKHp
	Zu0ysrYG8ip41wDJuTKsaBF1nIbp5w4AilzpKT1Awfu0afMb4gPfcKFnvR3THRhpr4nvmbhfV7I
	zdeNXL1lgotQ0Gfph4KTosfQ1YcIOCWbQRb5n+CWCYd3YMxbpY4SM6lB7tGJTZW2cAXnHdVZO/L
	0e9bryKUIFBzkqf8q4PGyxRrXUZdiWrcwxrKcGvaABK7qBRlmLIeiQI3fG5UdLNGhp5hJGS8tp9
	u9MYYWiIm4jcpWmORx4n1WUufSKOpbFJ0SxfcNg4WpqlGt/Q7HlC6yRBHdx+vQXwtkUpYi0sTcx
	UZ5Vx5308Gi1B2tNxG6jU+dYiZGB80keKq3e65X8RA==
X-Received: by 2002:a17:90a:5d03:b0:3b3:a1fc:136e with SMTP id 98e67ed59e1d1-3b3a1fc7422mr1933617a91.58.1794899070242;
        Mon, 16 Nov 2026 23:04:30 -0800 (PST)
Received: from github.com ([52.250.49.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac4d98b8sm2511408a91.13.2026.11.16.23.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 23:04:29 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: lei lei <llleigoing@outlook.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261117052200.1507847-1-llleigoing@outlook.com>
References: <20261117052200.1507847-1-llleigoing@outlook.com>
Subject: Re: [PATCH net 0/3] tcp, mptcp: fix receive buffer sizing and peek
 accounting
Message-ID: <8811c9b7-dbbc-1931-0d30-eb35cd11a872@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 07:04:29 +0000
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

Hi lei,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): =
validation:sched-mem-pressure =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/440248=
26211

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/64bd1916b1c2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1213436


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
