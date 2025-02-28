Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA218C31
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753870; cv=none; b=DfBMB7jb76Z01C9zluMdJGADqRwHlK81P6JzCeEwIrNckZWNBcbsZfRSk9VmrHWmbpx61ulWFKdlRWG1fGWkuzcxUTO6RMjW+ii3Eh+CP+zPT3/TnPFX6tuFyyLp9aQOE8m+dbSIDBlW4M+i87FFxGU1cDfXvsoUyqoiWJQCTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753870; c=relaxed/simple;
	bh=7pZeDwevTGU4+70epkmta3xpG/6bHM/zd3uOfjfAMm8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PzUtmZtFCGsQHXi99f3Z1+J4t+CUpddNwHzE02joVsr5/YtOk3CUTQLN3HzowYvX14BL1AtLWSC3H/xRS00cJPFmk/xSgIooDZ9KtFxXS6MAyl2UW87Ttjv1WNm+LwJClEpcTIwCZjyaOtU9zyESXW2ZP9O9c/+NKoleZeLlnos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYB0upvn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYB0upvn"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0ba89dda9so225930285a.0
        for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 06:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740753867; x=1741358667; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKPOSKFrS8N65HY4cMy+bIRmXfqyzsQeFRPuM1oTguI=;
        b=RYB0upvnjXNdKiHzGqzwAILk9Uuow5VYr8xsSLV7wEwN4TLJznm5TlB7FwFo/WACD1
         X130Ti3AKu8Fl8Znbfu+EV9pgtjZUhP7/vkZNrT3V/9dBIglnJ8ETZXjFAGIW76nF1zL
         55PjT67en+n/EZ5QrVAkDDV8Cwkch7PUNeioBfry8I+lVuLnm/Wup+1lDGLplnAXKVRB
         KjrflgzvX/vtP/l/d8SHIy9GvRH53N8bJzMgh1xw8cP8Yan7YMsf0MVxo5yMVNrvxQCl
         7OsLkE5Rt/1Q8M0epbvzyrl8hVXqWKnzl2s/1UzjoL5qTsL+5fucZ1D7s3lD3VLAQVa5
         43fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753867; x=1741358667;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKPOSKFrS8N65HY4cMy+bIRmXfqyzsQeFRPuM1oTguI=;
        b=F8V1gugeXlOBcab9Y7fnE+UdbZnVI11VYgbC7BVloocp7PT/eknliA0dfnxlflDcNu
         pWb4LrGCi4dON1sNemUexrMiNURT5e/lyW+GKQyGnzebTDNYEl0o+h13hIrj33LL8QO3
         o8nFFitCAhGV0m41E7QcA8b5RJIwb3G69Sd//iOHKtmLr3LhU1Iq+2NGZd7vlv7Cpgdq
         LM6WW8AoqfaxGdajVJAWlN7ewGn2fjpl7ye6z7gAcF+9psgs/CU6YC1rVblG4/tLDhcx
         e30DHqpjlUlnT7kRzIFoyFWrh6mnWvfv9Nu0mkonWEQb5WgNwfkr69v6p4uHDk0E2kRq
         V1Yg==
X-Gm-Message-State: AOJu0YyBbP1VnN6uPtEhebG3oYhQ9ZgjlGcBH0My3SxFwbn2fH5REbhr
	q2cLRabSuaVpURTELuO/QMaCs2g3LAUzVDI7wTkmrGTOa7azrj0=
X-Gm-Gg: ASbGncs2ukO8GS/euSAB5i8KL1htvRx/DwfSOuopYdmHNUyuU0qqMTWMFTC7gt2vcdR
	WtgBAYqmeAufY7leNIQ5oWpf3mhLhMMqpgp1qAG2TJp0zVx/iHOfDyaMVZauxce0zb8V3Jbfshi
	8Zg537ZWLWCrxBf4ZXMTW2Jr9MQ9+jW0B7nBpi8zyCmd5YINMsAJ3e164rmY5Suz3LoyDamtMrq
	WiLbqDONauaroPeWZipc/UoW/po+awOPZ73fF2w3ODAxQ5QvAyKnY3mEWeIM26oWJ2ePhZYAP1i
	XFc8haAzzKKRbscpBlh9jgYm6esCytrwUKUum30=
X-Google-Smtp-Source: AGHT+IGXn2snOGTMTRETZ7qk1VW6LPe49o4PY5OD6s+XWnrY+bnjGrSK6b+1b9tIuCvcrPUn294WOQ==
X-Received: by 2002:a05:620a:2a01:b0:7c0:b0b7:493f with SMTP id af79cd13be357-7c39c663940mr478762385a.37.1740753867613;
        Fri, 28 Feb 2025 06:44:27 -0800 (PST)
Received: from [127.0.0.1] ([20.25.192.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378da06cdsm252044585a.80.2025.02.28.06.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:44:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
Subject: Re: [PATCH mptcp-next v2 00/14] mptcp: pm: code reorganisation
Message-ID: <fe871b05-fa5a-90b7-0a4d-0fb255fc17d1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2025 14:44:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13589541066

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5ed3b6f5ad7f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D938995


If there are some issues, you can reproduce them using the same =
environment as
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
