Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611743;
	b=y4YEFUKxRpGDe0sPxwD9jF9MFDftpf4zlZjWTI8KvTUpGif6JmA6Sj3jkLdgDOlTiHvT
	 RFYeP+ahsVVakT8Rvl6w1z7hcgarzSLM8GwDBqBX/SBzyHvlcsSpam+uT/JQLkivCDzVU
	 q6SyGgf8TDTWctLhRFfbCk7OLY8MhQmZ3PpJm2fApBpPMolHdRCwdIQs3xgA0kHZ+tA38
	 NZ4TLS3sk8zkwxjuG026HapCSGnjEJEbW3PD0pvjzEG76pLwQhYbrXqQL3aKKVTioHJME
	 5uLyBGpApS3wi72od4euFZmRD9vbGdE3pdtfaeGvLcT+Jqle6T6h6tqV/xqyJwS6SyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=mymOLEfV1mOqxTEIkZqjiVwJ1RxK6wxpknAsbCnTxQc=;
	b=AHiJ05c/1jf5a25YX/uCFPJsQo+/Z4yctSjyooAzzIuJowXPzspZ3Esd1JUQD3HewTJs
	 VVdEtO66+6PM0Sjp+Lt0X9s+jhY4sE9v0Ja6gF8kQiLgzISy2pawjUCOVgPQ1k0jEUMmO
	 nNhaIonsSb1R0ceT1F3aKtMZF4eXFn9pdmB+OvhhKXUZze6RZGz5948R18GwBRzb9/fM9
	 IBq8TAwFz9GjHVvRKc2syTnsJAQxq5nHafwrKQFQnZfuAuCIiQHhDxm9gHQwGcRtNmzek
	 uB9XxsZQgWDwlzfljU3sMQMZBjm4ySBcsdvAUZH0RXKvNjg9/QqyauSD5MxI9YLChnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHqlk1Hp;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C8606A327
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 09:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A52C8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHqlk1Hp
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e7ad9f78dso363062885a.1
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 01:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793611741; x=1794216541; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mymOLEfV1mOqxTEIkZqjiVwJ1RxK6wxpknAsbCnTxQc=;
        b=CHqlk1HpuX/8HTfTcFbN60dz3iLMlDcLgTIom6GEc1xfz1IcKod8Mf0lnAViyUZgZN
         VC3Ijez8qy1bWlJs+yF/72wpp5B15IM8U8s/TMhiF3K5SZGNohwzbVuzsWu0Hn2DjhxG
         QFwXFqJ8sjKpPKlqQ7Xf3095znNlhWffb1QX8L0GDFC/pSEtu2Kpl1Rrer8Wk/mOnRL7
         +jokqsY+r6SqTjdD/ZoXp1JbwErvIl2KmX9LnvqJNJSPwZnYZVFSdzR69sYyg/eK00Dl
         M5ADWGIs4tSr1KLpGvUOEm1sZGJGOw15knA3VttYjt2Zxaih2FPRj0Z/tZ4sk3/OYhLQ
         phPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793611741; x=1794216541;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mymOLEfV1mOqxTEIkZqjiVwJ1RxK6wxpknAsbCnTxQc=;
        b=nMFL27dSFH9CqbYo43SFBbBaZ0F2zg7dYqZC9mjGIQZ6oUquZ8iWRsKIdRA+JiOZC/
         pwgOrbXkDtZA2ORwTc52bEW5Fi8uP2217B8yQvzgnmJ8uqn7Fe+g2GdpnJ5IJ0rsIbGG
         2ZE4VNFlLnTGM7PDHMS/gdrLBGLLKmOmLZXncXCux9i529L4yJXsLxvA1zzDoR2IjGnp
         T2vLAdYSP4h4ZueKmEIzNHOIv8s5mP3nMCKMJEScM9Y6pzaL+5OlnZ71WJcEcKe+7EMW
         LX6ox9ouzTUtN6C7zaMcExzQT3wbIX1Fql7YuRn/DF7LF6ZxIW/OghIg2HoMO3hee0kY
         44Bw==
X-Gm-Message-State: AFq9FYLU0jYnOrHlWf8ImeFeGzl4Zogg9yTCYY5fd71f5xv0U/M7vyhv
	w7wj6XEYyGO1UImRXMh0B0maJ1zj97h1ahtceVLW/ntNAkopZEJ2TY8=
X-Gm-Gg: AYBFou3UXPVumsMGwOUMWk+fR/dd+wnkQaXAE0aprG/fIP73+FXP0lYPJSuQUxPJ9XL
	eA31D/O/lWEkMotQGtqFFs1480YsS4dEBHpppJREL0T/apFOCp+pXctyczbeBqNa8+SaRLsFf5N
	y813YVh93AgeSqsXRLgx2NA5lgwVveIOY0p7ZgSO0w905bO3kXZrWcotzqLp0Laiwdyeth5jy9I
	O0aIMGb44SGnSyZeA0zdRqXHcS+Cm2v97ExE72kdq2pgga7r+VKjcuP0IqaAHj4HHVyF9o2cPOC
	wmeli/PRtF/rqUr0ofb8PsgLPB/iAdJ0VxXRkrMLInXwoigfVQQxyn+kwf06gXGp6I0aE8BkI/L
	w1SVh3gkfzzTKtxJafx2VF0vELREohu1Xe9+S+JHlb+rzRU29ste7UufbgKLW6SoGHfW/Dz2wJM
	7LIZosYuQ1vuCvM5aePeRUTXLXjcKHVLDVaNrh8IkJW1QV7wfxBl/RcJ+GMZZv6TJdVYtUTNYwh
	8RdKj9J9s/0O6hix54RO8mQ7VuyZ/jrs8OZCCwVK8WYBTyYayefm0Kp0H54CnLt1JedlmFU5vCO
	3Kj8SN1bCNoZo8Bqg7vjjYtiBmNivpYdUqNeoexIyhkO
X-Received: by 2002:a05:620a:444f:b0:93e:6620:bde7 with SMTP id af79cd13be357-94421712a51mr1652318785a.20.1793611741579;
        Mon, 02 Nov 2026 01:29:01 -0800 (PST)
Received: from github.com ([172.203.196.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f26f1esm87753176d6.13.2026.11.02.01.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:29:01 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts,
 redirects, corks and recvmsg()
Message-ID: <8f73d96e-1679-6988-8376-f047ac918c97@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 09:29:00 +0000
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

Hi Alexei,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 3 failed =
test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_mptcp =
bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug =
(only bpftest_all): Unstable: 3 failed test(s): bpftest_test_progs-cpuv4_mp=
tcp bpftest_test_progs-no_alu32_mptcp bpftest_test_progs_mptcp =
=E2=9A=A0=EF=B8=8F=20
- Perf: Unstable: 1 failed test(s): =
error:sched-mem-pressure =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/41408213721

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ed7b3ed15cac
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1198506


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
