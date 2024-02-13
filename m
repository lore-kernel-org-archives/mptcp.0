Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515275F551
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839637; cv=none; b=q2wctTLv5+FEPM2O/Voyhfs1x4Pv36PW93WASAy14Js7OqvQzXOawvFyDjepff9rd+YW1Fe814ZrRCSALaXrUzcvV8jRlKa8nhoKzuPf+Vy+EX3c/T+6LMn6xw62AhvdmVo2O4/iXOrk4i6fU4njbkf/RL24yI+xguxAU6lYo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839637; c=relaxed/simple;
	bh=4Z4qSgrZnMeNjNLkjbvrPCUcnzcYzFK14thHpGi1Tb8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Rfi/dcbm8S7CtbpOd9E7F0sCY+QJuoWq/qdmR/boBmF/b+cx1FxIjhyS0Mzb2ZHZbaMYKS20jUGOPBhFT6XkUQYYOtfl8PGB8bkWuJ28e2+R7JRaxhukQhUmioE3JG0VyHBdAC3aY5bs824W02AaZX85Ul+1LwsMrpuDauaf6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Spj0Uf2P; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spj0Uf2P"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-785d567fa26so121168985a.3
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707839635; x=1708444435; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9pL2BBTgYCZclHD5WZ7l95NDpPDGCpYGn1r51/5CHU=;
        b=Spj0Uf2Ph5KJZn91ZyGPOy5YSUjQd7VCQM490Skh62x2xaEa14FtAT0j7PNsKlYEyK
         lCLoRF53aYXZKjBVuNyZOo/mJAKC55lpMJAetDoRRfN27Zby+ivxeBbhUX5e7IFbcRth
         Gb7YS0+MnsjRK0jEKokuUBt7rxcBlHXrrqTehYnHm8KM2w4BPT4uPK4eHHdRn3lGHI97
         4C84OwNNjO7ooZc4lEXM48TqhTia2yT+7Lchz3T+gSGr7Jv67aEmc2W11XBfv941GYCP
         XODOlSPIuuw2OiMedOUZ5UU2e4l5yJ5B81PRZfkp3JHtceENKFI8WAE6bWFfuqWW+b7A
         4fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839635; x=1708444435;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9pL2BBTgYCZclHD5WZ7l95NDpPDGCpYGn1r51/5CHU=;
        b=NFOISQskZjxhvskC6IQ5eHzNF8M+LchnQest+dQ+d+ms3sjVwu2A4p1Go5rTNHIVXJ
         ci/ClHIZa1XDaEUEi7M1lWjQXUsqBose1aZVmWB4X7NrVEFsA0Upc0Aub9Djaza0588R
         L/JVRPybVgCcht29hCzGKwWTQiF12gtqm70brwTm8JjRzoO7fIaXXoByoDFgxp67P57g
         JX8I8SdU0exWx35u66W6+uLJRk9Ai8oR2Vh6WrjK7jja6P4iwZOtesSNfNelG8yJ98Pb
         9O8uXUjllxZftCi6ixucJ85MjQeyIytdexg6g6chRcjjeQMaqajPVwXz2rot0td6bVs2
         mnEg==
X-Gm-Message-State: AOJu0YybWGwW3uIvVVo6G0lRx1M6XdgAjyc6waaB6U1xjMxsShzhWuNY
	mRAz+GT9OY//vckce3Sn+j/SAkAF3YOlRRAW5BY++7CoNKpSWAySMfJw13Q=
X-Google-Smtp-Source: AGHT+IFs55cZmRcBJc7MEoC+l5hM6FUNb5n1n5bTR9edV9uz3tcsPomycMi/4T+57zwdXIrap2WGvg==
X-Received: by 2002:a05:620a:1a07:b0:785:becb:7b86 with SMTP id bk7-20020a05620a1a0700b00785becb7b86mr15183944qkb.34.1707839635166;
        Tue, 13 Feb 2024 07:53:55 -0800 (PST)
Received: from [127.0.0.1] ([40.76.119.101])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a0ecb00b007840b13c58esm3060429qkm.63.2024.02.13.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:53:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240209-selftests-mptcp-uniq-title-v1-5-e4fb3a3b5f66@kernel.org>
References:
 <20240209-selftests-mptcp-uniq-title-v1-5-e4fb3a3b5f66@kernel.org>
Subject: Re: selftests: mptcp: lib: catch duplicated subtest entries: Tests
 Results
Message-ID: <443a4723-1538-42ef-d963-2ba4e58e6d04@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2024 15:53:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6204403636502528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6204403636502528/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4599610446970880
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4599610446970880/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0c1cb32e0aaa


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
