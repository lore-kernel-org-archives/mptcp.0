Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977269;
	b=i8Zl4XwyMlLqiGPhr/oAD8aXpWUtRPP0wtqQ/f6GcO2Yp8TC4CCVUMi1m8+DZBCJXXQA
	 QOLp6IpBXSqakNEHNChulnovwdINns4arupW8kSaAZ03e7S0GjtcsU0rFZ/4Z7u+2jfbc
	 Z+4sagxmF2SdOAKNEqTWE8wMrxuz87PW1gA9sEqOly1kmfkqiujzT1HdYXaUsz9Z/xCPw
	 VuDpWqrmozeUVwOrdLuRHsLTs04ukO/gZcLcSo24JiCYOr9/oAwgiV2oMaupXb29hoEsV
	 IdmAU/fuu3BLqWwmrlxNL5jJXvNcr6MQGhCFO9wkxk9Z4vbf4onlV4UjuCMt/upo/Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=M5MPDOAaXbMJ1OyMeKZyyri3Ta5QKkxKtSqeINlRiiM=;
	b=gIhlYMQwg8NgHy8sp8fk7eoE64vwTajUetNzBt14jSdFdL10m8+uHT7tToKTt+r6CKLL
	 fErQDPzaHHC48Wp9DuRHecvxJWl4aJIjJFud4xJrdvVnOYHi3JMpggbnutTwOcOn79OR1
	 d7XKtGv75sgyk8GXMDSxvlACNhHBZe0d1iigAWF2c4HpFfw0ek99x+lAJglN8Gaizp8Ur
	 JP9/ICawdd8voDvA6D7GOhy1dCi+VHySxdRRSaQS06je82MtVBbkrkVgXVQXAQSx48Smw
	 uj1TdgLZnDsxWDYXMgEqYG5ZrUcNHwRpV9cUtmYROFGZkQgSQ1hCQHCVEElU05/o9/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bkjnlcvq;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F58606A326
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 15:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09F58606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bkjnlcvq
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eae1276409so288600e0c.3
        for <mptcp@lists.linux.dev>; Fri, 06 Nov 2026 07:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977268; x=1794582068; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M5MPDOAaXbMJ1OyMeKZyyri3Ta5QKkxKtSqeINlRiiM=;
        b=bkjnlcvqVEWMqN9ty3Cd0J7evW3BXeCFe8REgBWY3x9oW0bKWAfYj2rlO6pXWiNgVK
         PF/YBbLNkG+0/gsazF3GcKbVwEI6TbUUZJav4lGlwQc5NMiBcBp6NHPwbqqwKmkfqHJE
         9LdAjH+WQDdxiPd8UXtdLIshY6heS2t5krG2HLBaL+Xv9yOsahWGX0Tvxza8Tu16B6n2
         dj6v0TFHD1urf0N3KDfJ0QbdJYONsH2J8AsmaSfoy3W7so0p+PCdRIuphBXr/0ZsN63A
         vThry0J7UCatQDP6N0x3vSaJcuirlMPqdb9pAsTyqsNIgcB1YqYwzZcH+eUNMDbnKuhH
         oOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977268; x=1794582068;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5MPDOAaXbMJ1OyMeKZyyri3Ta5QKkxKtSqeINlRiiM=;
        b=HRC1XCc5NfoJ0d0EUuPLLhxpAm8pOQ8hnTGYnsKSMllmtF1yJ6I60SqRbPVQshmMHD
         j2p9/XlTz0hIRyFJ46Byg99TjG2Gq2SszylRulM1ZHxrP5pz2+TzKxcqWthwlSp+XhT9
         DUDDmCHcjxWmNY8fYxa7ZGNsh2xFQ5Qe3bDJj8xe/WxceNeLFfV85/9QuG9K3mEVdQxH
         iSKYu3euTmbYP12WOMpd6v3OXLKUbf7Ru7RAxNVX6+YIMUE2IoJAxBoS5KrNHRkIZbPv
         65IA8EN2f+92meBTRT2dAjgvs7sC5aqjg44GMMTBR96a1ik0nhF4T3C3j1WEYQzUq53c
         4hdQ==
X-Gm-Message-State: APuU4Z/uzJmvwM+BClwBeYuv4kJ9HBIjDd64iONqujzgkKizD2pQibuZ
	iiWZjDNXMggjeN/eGzr0yjVj8XWVJTFcO/G3engsT8k25Sg7OLRhGs6tXgd8xyzSiw==
X-Gm-Gg: AYBFou0e/dHCYpUoapAZed4YGXQKm43N46mMNMW4GJmifNI+EPpEhcPHNSw7eSryshH
	GlDKUD8TIhbjTkzP7+QWVGeNcfXahJlZNcHWV1sYK0VvAOICRR+6UJ3b3x2sGe6w2a0Ns4YTwfB
	6cg/OZBl8cUmqrbpdyA9EttBbgHK78AxKnIOer+Fq1CR0QMVXoLljGCSjeG8lep9ouapXlezkyj
	ALX20j4Wqk1CSJhWynolVUy3Hm7+Inz1uJWZwjlaRoGm/Q4dWvaJIDPOXHZuSNhGiRXO2Vf2RbG
	mohIxt5PW97DUfgGZyn2Hn1MOop4n3B8OsL74Xg+/VKU8VeOx1l3cMFulbabVoGzjsYtu4pk5sH
	Pyd8vxkygK2FZJPHQmb9odPfSi40gsf7qZJiUMgDDWcvx67ZFHpyiEG97aXhJd+hEmetN0/U20+
	WXNC3T5PPc3jbtVGemHoDcHTI/YedbMXS/OhNIKySwJlIf6+dV2ufLXCkRtZZpGPkEnC6zXt3i1
	Q9dir1bSBJxqWYgIqr+9qqNkNLuNyI4gjmc3exmsrx1lNyuuUdAH4JUY3+8TNDkgGJSxD3QCrKb
	Tk/sbMz2iIGV2eBFf6OqYtaUm3KftPPYzGsxyukDfw==
X-Received: by 2002:a05:6122:8b8c:b0:5ea:c6c1:8dd4 with SMTP id 71dfb90a1353d-5ecc43bb9d5mr1236395e0c.5.1793977267706;
        Fri, 06 Nov 2026 07:01:07 -0800 (PST)
Received: from github.com ([20.104.156.187])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99badbceebdsm1925344241.3.2026.11.06.07.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:01:06 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793969127.git.tanggeliang@kylinos.cn>
References: <cover.1793969127.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v23 0/8] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <fe35d1b5-5eb1-c42b-84a4-f79fca2f5990@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:01:05 +0000
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
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/42224796804

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/1e352901ae=
cd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1204169


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
