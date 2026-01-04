Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C073FC9
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767508690; cv=none; b=pNK+o2TqodO+QY6EiNzzIK9RJpbM8Q+b32lUX8d0awrxQGgNgApN/bogJloQi6qw0h3yYOChsOLKYRMSSUSy6W01+3/+ZB7gEAAc8AzGH3TVlQMcd5GHqlhRWg8L4/YwtiCnmmnz6MsIAcAZ1s0cO/MrmcvE7Y9d0uZi3AEsbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767508690; c=relaxed/simple;
	bh=NPYs2HSbUIBxeDgpteU0j4Q4c7LHdqMEWpSB4IPYVPs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=T0i8B+UEB5gautQL1ThN4hs/LAhRgofya4ZhMMyEJml3eq1izBAMOtIPKnOokVf4lFTxQ4LFW4iqYvnZdcRgmVtjTYL5bH4ay9/yM2ZWH7S9jqQuuiMroho30ZP6NJmqgtaYltdfDNUSTO5JEvn43b6Ty3ltrPauSEIJgsTQuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILklzyOX; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILklzyOX"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0bae9aca3so187147015ad.3
        for <mptcp@lists.linux.dev>; Sat, 03 Jan 2026 22:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767508687; x=1768113487; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPZ3s9HgP7wyiy5xd8bRohyQHalS4OS16w3a8yxUSV4=;
        b=ILklzyOXxOK3OCB5w0rt070x8bR+mKkuri1urcEijzY7U5BI6u9T5qGyUMCd1rQq+I
         glTMHinvxwymFQFBE8jnZrlkQVJlWBtyfFY/+0N5LTmIC8eFkejsr4p28x6T2E2NQf5I
         6ySOvdtLrLjA2mgWiNOylrz5o8UhBGZXXjjKYyTb3RtGeZPgHww8gbEJFdqxp/V2v0/2
         UQtwHFAuDaZBqUwSkP5MYR9KLIIw3FYh1VVoRHxqRe/1vwKq7oSbEdHpUm/YtxjyFWN0
         zu3vQ1cOUP10gtJVdUdNfPesvnIhp/Z8xS7B6iS2SK5HeQX24M0S38ikk+dSEsMQD5Qo
         BQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767508687; x=1768113487;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPZ3s9HgP7wyiy5xd8bRohyQHalS4OS16w3a8yxUSV4=;
        b=XdSwO1mjnyNoWz9P5a2L1AddEI9vAP0m606xqllN03mP6fCODkFqJ4GqyEizYc7FrY
         Xx4T8PVkG1cUHnMx6hBXAjbBdFvu3ywn/UCejOtWMBLpj8TQRwbHTAi/I80YVfWL6oTE
         Onvym/2mNMj57LZQkL5IK2TVAK31H9kEF7/Q8xZH9agbuLRZu+1IiPMxvym0brkVK2xG
         JKcu5Jvns68KAV8Tg6hBVcn9/XM/eMu1ekgmE+6t9l+3XDY08QxlvzMTXPVXcMpUQ38F
         Geo+Y+FKFSDYEIsmCz8NEXJueCnS3RRk5Khdr++GUF5KaTVI39IVBU1gPQPRVvRrNf2b
         JVwg==
X-Gm-Message-State: AOJu0YzdUqu9ZTM3zOfbeELKwMVN9pWTOEOG6L9n3rNQQRnWD0uHhU1C
	jM3EOxxJiWiXnqN/txCP8qZTt05oIMbWL/DsPPym3AKOTxlOtKyMuc44UC2DNos=
X-Gm-Gg: AY/fxX6/CIMRiElv+Agvy9fPk/3n5T2MVdhDsiQtuHGnebJa8RjRD3u0LsvnmYpEpUA
	c9FuEATEKKcHl1PK8fSLlxZmg0s6p6wEIHpi0nPrWSWW9Bah3gt1TeidixneL6PdZ80on9sc4i3
	L742/vJfElE5aAHM0kOxaK+QceIXSTacTXumtkql9n8wItU/UkOMJ50+XrsvHk65a6u96Apflgo
	08O6tnfaQWujHJowO7MBak3OJnIoVBTDQ5yWtdhKqw06WQ0uVBkYGTNiN32R6XVF1YHPIVf8vD5
	LtC/56ljR7egTza98/9hn50yxpFR81I8SQdJmQGi1vonKtGde+jqidpnkmPXRV7EeD/85utg5XP
	7bKtTCK8Vel5YppKY//+InWwhvtaCzcixiMFQaf7Qqd41fWDyyeSkAxqOXhf+OHm+JiKDnXhhQM
	PsuX6lsq47zGtwuKflRV1y4h0=
X-Google-Smtp-Source: AGHT+IECmHi1FId3W2cOHini5f5QOpfbenL+Cg1RoTCwFXdaeCpn9m+MtijMXKw8s2BiNVrEbDjIrg==
X-Received: by 2002:a05:7300:51c8:b0:2b0:4ae9:efbe with SMTP id 5a478bee46e88-2b05ec48383mr38500751eec.37.1767508686867;
        Sat, 03 Jan 2026 22:38:06 -0800 (PST)
Received: from [127.0.0.1] ([13.83.166.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e38sm7648613eec.34.2026.01.03.22.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 22:38:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1767504329.git.tanggeliang@kylinos.cn>
References: <cover.1767504329.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/3] implement psock_update_sk_prot
Message-ID: <455bbbc3-4d1d-e9d6-351f-29c30af40eb1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Jan 2026 06:38:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/206884=
24112

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6ca2d68f2a7c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1038151


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
