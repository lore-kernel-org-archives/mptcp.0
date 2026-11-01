Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793539260;
	b=U/xJWf6Mw0ZOpCWbGRt9l7FvkykjD7vHLaeikqgNcUUsQQLHSngsm9o8Ko1izj63mddD
	 Rzeo53dta7TmGy1uc2y4sLVYhM8VY9Lbjt8fpGsNORzCkrtwI7Bu0GL+BzojCwIlOtkv0
	 9sSXIjSG1eKzSGbwpeP4xGxyRL8w9MFEsvxbmfd0J9xdjXPGWxwJSfi98NONw/cqkKlyn
	 RbTx3uxyen/r7zJSAAjxoEuH1RXU491qKXnUhAjP/FBLgKM1AEvYQWIaTAE3Hftmc5yjP
	 UFy360dLrF2B1RGu8DW6i6HpC9oex/XRtFBHChKVGmuz7Oh3YfD173YAd0KC4noHZKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793539260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=HHYQqgLJNVv/xqwj5WoE8Ct0OvRKAy/HS+HFrPo3rB4=;
	b=mZyN9cjRbspb11N3th1r5lsEkemKUzMZ1+NvIdJFbLjbQl2Pw2dB1sXv/NUu/wW057jv
	 RX4JLjloXFk5Nh0xNJrsJAyKj9EpTmb3oPXtcorBRQzR+HbxgZnkG5aSy8zDhSSuaf4ns
	 BqwSWb7hxM9orTZrBNkzd43+BHLmYjgxB14n9lj7cjR8edXXE/5CooDt1EdWuldQ29ZFb
	 Jk7DHxNQ8vnY/SHwccHn3eBNrvqI8lKM0G4u8vM0d1qVUBhInFKc3p3gFKnxY3sdCJ5c1
	 BmFQQPz7q9LC9+d9Zg0cwJMQWvJSEn3blk3Ii88MwxTzDsqV3J7hjcOh7hC0ZqSmHFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhNqPmdY;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A9606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 13:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F7A9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhNqPmdY
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c8fef5ce2so29002856d6.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 05:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793539259; x=1794144059; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HHYQqgLJNVv/xqwj5WoE8Ct0OvRKAy/HS+HFrPo3rB4=;
        b=OhNqPmdYBPesSD574i+C09G7mfe5dhd7CDBqx4T5oJtym0SZzue1w+6CGx13f5YJyD
         FUcVukYx5GOIu6LdJBfELOKPL7NrXNOaR7xdL/siQhSUFDv1IMmixzIwpXF5p6Fwjvse
         4XEHm6NTDTYnmQ5+anp8vFHhlbvv+qPykUpnTrTQKBYHw7OLmgRu8icmxN06eHAGCZY9
         SYPi4OLsn6GCjKjA+qxmOP/G8HjAN0MKmRsh5mvDZpVPuxXxkwetfURxdDt0yXYAYpM4
         nbTUeBKS7STQoLQTnN9V5nVtHVhMf1iFFvRS0SCZ5XSLgKQdTFEcbS1cA5wwe4xpBNIX
         qKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793539259; x=1794144059;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHYQqgLJNVv/xqwj5WoE8Ct0OvRKAy/HS+HFrPo3rB4=;
        b=F0G60LXchlyZYQRW7LPZZpdqbyHKUe5JP4VZq28a9wgU0iR9cSr/tI6RrfPcw7wpmd
         GPknA5oYfSMpIm88a0CfdPEmYlkJGKSb5esXAHQkKOebSNOSTlaDiRATr71R4sLg3dio
         WemxhzT0q0cV/RybBiGWOkS6uLhpIMvLe037h3IAg8ShR99qPco++orovuuYg+ZlBHfo
         8AoqZvYLeDf6gs+1YTnOMeX3tH0AIweSmt+YHOQaaw23guh+cRW++rAdUgZxcvl6uVG7
         iIs7J+phjZMk6udfSIQXMP9XQaLKRL0ZzDyuK146MG7TcM72zCYhCfFm8Yv1QPUthLIC
         NJVQ==
X-Gm-Message-State: AFq9FYJXFC4nXz5cxKx4bjmvOvCZ0GHb9v+xE36/NuS2aGoOzvslu0fB
	1RGzQbWN6kbDV4sozRu7mxs8s0l/luVNqyQeSaOYX8LyQN/wcORPZTpc4lvH
X-Gm-Gg: AYBFou0B5MVRB+lkmOv9jAYGEDDXzHtDLwZ9vj9zkOOoUS/iVlt8rFyvpNPfE40VmGR
	2sCsxJ/lKCR74U3pErqcigY5iVpGSpaHxB5KJcW3QCNRzIw9FHhtXPEqC9+cR5/Anx13iLmJKCM
	HepHE5RRTZV9RBRkv4QAIKGBeq+W8Od8HOSV9BfwuNVdyTqk92DgRyQXx/juH3gSS1co14PLJDx
	5hvWgNWA3hPzs4YQbPFMjWr1hUeqVTgx6vkIjuc/3zS0z40JAj/7J7Fz2GeI4i7BWMF2ugreWmo
	jQimAycqTDyZYH5Xw36bL4TFJqE3yvUhuGjmLnz1EOkgvBeP0smfVRz1daEyYaNOpUSIUZlsOs8
	TvgM6nWOjmuG2nREBIT72toBDSM0dn/zIQtYYa6vHzR4yFy5Y/NvGnXgiWOJ51OJ4qAAMuw9Jmm
	0PtqxzUS/KpVFQp1uOf2oBYd/FRqlelyy3NnVlZLoLJZivuOwh0JUA9KYjUUfWOy1E249CzTZDk
	I0aA+tuaL9J0ly/yvyjixYV2rxVRaeBELqu4JQMzjusICEdY6EPhPO+JS0JJOvuP+L/XKFQY//m
	4mGRO7sfUd7jzvHdcWBxEKo7K0MzIR1+NVbgMDiD3w==
X-Received: by 2002:a05:620a:25cf:b0:93f:3120:6c7c with SMTP id af79cd13be357-94421799b6bmr1198666485a.50.1793539258855;
        Sun, 01 Nov 2026 05:20:58 -0800 (PST)
Received: from github.com ([9.234.149.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2c7sm600803985a.10.2026.11.01.05.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:20:58 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/8] mptcp: sched: reinjection and a send
 limit as scheduler actions
Message-ID: <107e0086-a57e-37ca-a9a3-280c7e196313@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 13:20:57 +0000
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

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
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
- Perf: Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/41303657351

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/43988ca731f2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1197916


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
