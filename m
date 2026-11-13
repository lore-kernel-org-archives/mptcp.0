Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607128;
	b=zZNX90MWBfjcIXnJRZNWEwA1qR46tUi1cxPO0Fb6HIyUMIA8qK7KC0C4X8EhcrqKXeR3
	 z4Xdv80TJHNHqMB8I24clkE2vpgP4nUXoQTIyf7dkDzjrD7Si0RRsbRa5U3e1A/DoRTn6
	 DucXvQpkw9+eEwcxxh8Czh5UCkZXpT2nr8PN4O1CXuWE51T5gRm85XJ4wl6q+7KVqJskU
	 z7SMI2F7ycIAPx+8Lr+22Uzfpv86dfJKfh+OAXKypHxsVFvhSg+zdC77M+cQaGyd2lT2/
	 cVrGSfYxNet0PRuCEau7Riuyq/PzuV2Qa4vK79H910xF8ruk2VHTTQoiygNmc8UwgNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=WkEbVrEpR7ybTGHN1J5a9sl49vo/SBzIoK5bT1t5GYQ=;
	b=JTIYFRy2UOxPhJsApuQCwFZwFmYzPZw/wYYFMXt7ipjSiEHLR8eLjXR+6RzrQwOHIvR1
	 xSAnpLQAlU5pGGc1spmfeU+soKaDVnrJJMKPZB9aqjer3qjh9zJ6BdZzc/YdRtR09APf9
	 puc+1k1uFD9+2aVLFpkmRYpigvLG/lV6YT0oHEBiQDzIqEiU/tqu2YEeEVMoV0ybDo+of
	 9PLqhqlpMsXtisogGhW3/etFWiXAYh2N18w0umhZaNLm1cc5rbPCh2SGbXBmRBZB7lWO6
	 bhPZo7cIlkzxIK1gMizBJ8UiZyj+Sn9rm/qUMzHaPPCbAeHFKVgCBbkqs58+SHwODWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RegbBgw2;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325F606A32D
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 21:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7325F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RegbBgw2
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b244fb7fffso1638345c88.1
        for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 13:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794607128; x=1795211928; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WkEbVrEpR7ybTGHN1J5a9sl49vo/SBzIoK5bT1t5GYQ=;
        b=RegbBgw2CNhGWHDzJUqEet3gWYRzaVXApld8g/KafVYlRIV6IpySDVcVEtRAn3E9IH
         qWawcMUkhVqkgTQxqk/KPRNm8681Ls3RMrBRjDqpLHDRRaO2aBeMvZQNTCyrWw0quoOh
         eK3OnhC/YwtNtg0rys1U7c5PG7/5c2glOUBOey6F5fxAG4eUF58cttEBWAyHDHec2sm/
         uJ8K7VGTuypkMihvEzJJn06SD+a/Q1C4AshcC8wyTTzSbCpmTfVGbsOv2LSYkZDXHjvE
         fgz4zusw1MTs5saupkVR547W09xQTiBHy3sYkG9vdSgsNxJDyEFnxS6uk2JLtGCdP2Fz
         +udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607128; x=1795211928;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WkEbVrEpR7ybTGHN1J5a9sl49vo/SBzIoK5bT1t5GYQ=;
        b=mJT8l5QQmtksh2EoS8o3Tks+RyTBqda0sUXQkVptI4Q5gR2tof+lC1GN6/nLTEio5t
         FVQrjK6Rf7JeXMfcZ/tz8oEVkOzl+M5rehHZFQaXLi8Hu+qopKA3gc/N8DpsefPsWgNi
         YXVp18B6j9cRD+OznXipZqe1EuGKPj3dMDe73U5NKBsm1SGHYS5kdiYLHfEl8xAc8zaC
         LFVCAeNOpKX8HMbLerfNiudpbJ3sx4DjGJt9Sa9+Ys4TgBYpM/0nBj29JH8WmqgVOpFk
         VMZ8eEqqm7rjoFe0Xv3nMIV0qoxnYdYiU1JVHUErgVnMiNu6PNeehOV0yDpJ0HVDNZQt
         jwog==
X-Gm-Message-State: APuU4Z8GSibghlpwhb8gYGT/bjzgw+BvuiqNU5IgdMj0BZ7s8zbjslDU
	CcyM0auYLufnbS+dCM58CS4o3jAqY+SqzdfrRduUN8LuCnpAW5M1XXE2wESE
X-Gm-Gg: AYBFou2I3/6oqxW1T2Xz8xX/NQDv128uzGrEKXWRHldypwy2uOqGgZTpMDHiS7Q+JVz
	ka9SVT5+RfctYVPzgMVOAgjqSO7DeQGVlZk7vvKuMoEz/PxdkZCJrQ5xiattNf6jGfmbqeC945a
	PAXubsx7e+TWIwtizIAjBYuxECpyQi6XYP6hwN8nTqXX8rLYli3sp4pGfu4+giuMs45+3SIQRon
	MiKmQQo+cSCf5gJbk9DoXZPshwzmBiUD3DKb64FaKflEJkC9eV4xQFCDcd+SF9aFq9CpI35hAIm
	xrsPFxv7ODp+HW0Mmp9tgKgJq1OJ7CYFKcxSmwnnmj4862FNx45V9QTd8UchoSfjVQ438oyJUQJ
	BbqeaD2Jnfz9lfak8gi7RqvcVljXtmymTqq3VSwJudjM75fRGLQ/qB0cztHS2JJYpu/2MhVZ6nh
	QkI3RqlYfmNigzjr3mtM6/jgDYM0UQTC0GqfJ6o9eO/Y544S6w7b4oFKStw9M2lqQGFxnq5Dtxe
	aiNZrALU0oKqGBYhEe8to0+EJso1lnasUqxhM6uMViJPkjyBeNfldSErDueczuiyoS/R+6H26hY
	lngaHMNa1YUKvlBVfAh5YCuu8j0HnHOSCeuD5fvbRs4N
X-Received: by 2002:a05:7022:b905:b0:1a9:d04f:1b55 with SMTP id a92af1059eb24-1b50311e3efmr3094643c88.26.1794607127470;
        Fri, 13 Nov 2026 13:58:47 -0800 (PST)
Received: from github.com ([172.184.211.246])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm8874335c88.7.2026.11.13.13.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:58:47 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
Subject: Re: [PATCH mptcp-net 00/34] mptcp: misc fixes
Message-ID: <2c25d512-2944-ffd4-a43f-cddd97e08bbe@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:58:46 +0000
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

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): =
validation:sched-weak-secondary =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/435018=
66652

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c88781081116
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1210925


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
