Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEDB1E98FF
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997321; cv=none; b=X4xWAZlVSDrR0vtI+4+GqW2MVV9icO5Va/F5lFOQYnZl+W49ZBqDUnWbsCFsa1mL5z6V3JCm182aOdFa9tzdFFi7EiWbZIefYGW+WsbFBJT2s9Keoj4bQ4rm4LL650utTDxlWFgF6+esqiOl2nQmFVV+rChOrHOi6+VhRZTE9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997321; c=relaxed/simple;
	bh=AkeOjs+NmUZVTs9Jz7EidXyhfpj6UreN4TelT5OmOQA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VEcw/1/GCh5OpwNE3/OD/2QkiSZ21VCVkWES5ER28k58lhB0f+ztkw4SAtGqDPzbBx6puGTo4E9TtppdDhfDWO3iTj8KXtLLp26wLbdc3A6fUaKOdMPZpdXNJUrKff0y0E59IyGjQhs2Na/MkaL6ioDiS8Dq++CC+j6sa1nSqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfcf31QC; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfcf31QC"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30820167b47so686659a91.0
        for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745997318; x=1746602118; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roxnESVacpKw//3M59A3laAHA9TOUmpiPmcijpmiyuo=;
        b=lfcf31QCbh0jmRemuIHxWK6Z1MPIpMeRHUejmqJXpqevROrPKmbuVpmOWf2XhjfZss
         zCLrx/WMb95DOFr6RfrQLcPFJpX+/HaG5ZRIr+Kga84WmQTmHBUkyY/DdFx9JzV3nlg8
         KLZ/kW3OUL1RW7HDkMeullEE3J9i6kNKRCDPi42miLWyLT8iuC6/tw0QdtadfSVxFStQ
         f2O148QYfdRWxGA3u66V0nYQQPNlTBUNUXaGi/xrmzEX047coqmnnl0SMn1xqQH6BSKl
         YIqhxq17FNqFhFdzSSnHWjJDwOI+N3fiMEHWcP9ox9wYSLLUs7SQ3Gk9iJjxh15avGGs
         aHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745997318; x=1746602118;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=roxnESVacpKw//3M59A3laAHA9TOUmpiPmcijpmiyuo=;
        b=cP5BuArH360pdOia9l6LxyjWryzNtl06GhsW24pLFZx3FPD5R2RuIQ5bxTrPbNJ6Mb
         V42SwSOEGp7QM1swxyTREBmspcVYz6S7PYbaVQuAxrkRhQkUw0iCdbC6qG+vUt5nglgj
         DLmiqhwTQCLhdG5SPXUMva0IerXv2ehY+qIb7i0oqQZ1SC7UsDhx7qaQmHDbP5OHS/+p
         x0dG2xW4iPEL0gaWlXEHF+PNDdloAH8aLCqard5+NjsfD/TXO8AXeSGkfTEYT+oTtPpZ
         yaM0ZoNA9xcXzVopaCWQWbNh3XrjyFr5+SPpQQi+fxeWuW9C+5ktU7RpNgSdysC5b7ZB
         NGgg==
X-Gm-Message-State: AOJu0Yy1PlIn80kLbNu+5cOUypwFqB29G9LJ8Ka/EL41Jo88c9m4kXi9
	FKpyiJA46EFJTtr5A4grwx28CtN/cfB1D1h2NTGot5K684szigx58K8y
X-Gm-Gg: ASbGncuJ897yS44CyMibQ0kSTMUDrdGRJSyuFksXy/GVqnPsQW96gamMXhYxDZh4BJh
	NMBXUAqw6sMXYJfXwyQ2aUp0dtgbkLYN67Epx8o/CdDz8iCgWZeMKffyfu3UFjNtX2X27xrdzFs
	GNcZAJBrrubQt2Tr3vkFXKLvja5uyLCU7lgxZddR8Ww4luOpWPNLmV+SLyx/xWwgwUILcv1+QQA
	z2/g0Jlgko8BUL/YYk+LhpxG02tLExQ+eS4esFtrQiH+IWkTrHGbfZXR6tDTzpBACXNPMxRI0aH
	mcmKNWUnrltiSGgCYGpfdSSOYLTGBdteIroQczlUVgaXQO4pDCT7gYg=
X-Google-Smtp-Source: AGHT+IFmidWEm6hRL8OwilbHAlO8gNjnxl+Glb9xjA1dhjfGvtNkbmojC8x9qAqIQfbo5S1h+OK2mw==
X-Received: by 2002:a17:90b:1cd0:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-30a33cbdc1fmr2778542a91.8.1745997317779;
        Wed, 30 Apr 2025 00:15:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.165.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34a5f86esm834709a91.44.2025.04.30.00.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:15:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b10aabf6c4529977b61e7662cf1f09db4752edaa.1745991826.git.geliang@kernel.org>
References:
 <b10aabf6c4529977b61e7662cf1f09db4752edaa.1745991826.git.geliang@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: validate maxseg sockopt
Message-ID: <cb24524a-9ec6-4530-69c5-eabca2f245ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Apr 2025 07:15:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/14747840104

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/34632815fba5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D958366


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
