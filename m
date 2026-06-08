Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0443B7B7B
	for <mptcp@lists.linux.dev>; Mon,  8 Jun 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914276; cv=none; b=DgBgfFMiCG4k9GqLo1cXlM+TOSejYW11LDCYbww6Xdw4C2+JFT5ZFL2MlSjyZ2FepityPMrlfINX05bapKnxAsA+Zx2/t5MtvV9El0f1VOOIvaT5qQhWEWYCHIgmyvLEJElvjtouI5tbLoJqVdc7gX0vowOA3ZkGFeRkeAakhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914276; c=relaxed/simple;
	bh=8tsnIV9r3Fv1YWZrFmltT0huf8DBApOh2q0BC6vZLSQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WD35P5Mdo2zGPR7oqU20Zf8xZgq+j7G3ZW5qU1QF2lrui1VEpkFv6pePjv/Npjun5M8vRzk8xlhtj0hjHs++ltp5CNYs1FZmeu45LfVRC8OYdkARt5UrwSVKlo2yFK1QnqwtzgW+VK9fm2Vs6/wWFEgmn0WotR1iwxjdxC9G0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsHMpR5w; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsHMpR5w"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3074adb8fcaso6496277eec.0
        for <mptcp@lists.linux.dev>; Mon, 08 Jun 2026 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780914275; x=1781519075; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/77HCqZZfoOmegg34EkF3gqitakQlz4J4gqGQQ4zwbg=;
        b=hsHMpR5wrP4kjKwy5SS64aNV8g1xeByL4zAjimVbCj6hqz+nsyWii3ithRS1EQSQH9
         imo3vbcPBxOrUSDWWEEU6w6rvNNnBONTcVFv2ydq4HllCKzRkwDtf1k63IoIXtvzXfbs
         SYA78UMLstiw2+3c15jS/OPRK/YMfskaRexOYJ/sjJltjcD9PND3UG5QKevGafg2YiqA
         7dvGpTlNOx6pKlrxgC0LXFdJJJcdZu1wY468awsJl0ZEyU5PWnwkk7Hm2ZX+TPxtgHuu
         dwwYSDVDeWU7DJITBnnOGwVjBGdnew3oVHozcmqOKKpdG516A4MQMyGvKOiA5et+EeGy
         3YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780914275; x=1781519075;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/77HCqZZfoOmegg34EkF3gqitakQlz4J4gqGQQ4zwbg=;
        b=RIXNJnjhrPvsx44RosZxR542V5ZZiCLwSi3TCXfVfuRSH9JmQEaAQ1aSdgLnb9Wzv0
         Gn5TarfsHQHmMpN0qLhbsnPQR8qrqNFHPwXJPfoCq5oGJUU5W/GnquLFK/fgijK6NexF
         e65zUzdUELEwb3Jxof+YYcTkOl0Y6qn5ZgJEQoREVsuAVrvAEWZaOqwrUxpC1TXGOzY8
         6OV6QZMVgWKVQbhCxhqogwJoIS7RknTcIo3BNVqR0xT6lhTNCU3ebuN/WcWe6ZiePGSe
         4pm5t7VnR+sw+H6IIuLd5x+zTk+tasuVZ2d3s00fQ6oz7LI5Psv/XdasHrT1Qn2rS8qp
         lhbw==
X-Gm-Message-State: AOJu0YzuvPwb1aF+i2qKS+Y5lXvgI6qIKKuCBL9Vkx/bT07Y1j+EAimN
	b/rdIuxfQxp+n9gXVtVjpfpyZOksdICy684d6IH3SqNFgZe9FZ79l92lM/s8
X-Gm-Gg: Acq92OEYoFuXCRqI76hs28MrDzoOl6NbjsQ141IUdq0RlUP7jIMn38PGGgpGvuzDA/Y
	AE4ef1PEuKG2HF6fpo16WkVIQpW58f8krzpVmB26IXx7n0A+GDzi1U5ojVuongqp4r9aiexahNF
	yC6kDTpYih0ncgQjxYuc+qM1zTEcgs4k0LOLMegvinQh8YlPpwIsrlbDLIRCTMILUuwZPNyUPkk
	0ujEoLuJRbWl0Os2j+CCPgP3VJQYQxlCRzNDJlqeELZWIwjAU4ebKawb0vE8j9uN6v+aV41xbWB
	Hh+HiKgIl1I+Od+7B6SLNsedBiyVSRMPeZhoxpCYwvbDauqrqTWYXlqv9scFmzeOl9bs9zcentO
	w/ScB+YsmD3Y2lPWKhYRZq746Tmepd7FpqUWkNZjzAC1Nm71eBoN6+buxLTJ3U1vzq/ebfs9Xsp
	5i9xg5FrCFGiH1qGjysRLlm8foLL6AoW3gpdPQUmAL6ZvtWMI=
X-Received: by 2002:a05:7300:50b:b0:2f5:5dd3:1fcf with SMTP id 5a478bee46e88-3077aee7fd4mr7476638eec.10.1780914274565;
        Mon, 08 Jun 2026 03:24:34 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.11.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea9226sm16610580eec.19.2026.06.08.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:24:34 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780909894.git.tanggeliang@kylinos.cn>
References: <cover.1780909894.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/2] implement .splice_eof
Message-ID: <a4ac5e97-d469-ff6f-79a7-fef0dfc81e55@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 10:24:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/271284=
91669

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/abdcc91878c1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1107616


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
