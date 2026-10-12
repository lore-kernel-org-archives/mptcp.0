Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B548035A
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807873; cv=none; b=rwYclY4oqh0dQIsTq8NFctleGU+l/fxbluCkVP6AuG7ueLisnZWpxn2RoulxUGY41xfnMMXjSwwVi/uQzwcJRI6A8mkZxj3/7liL6YiS1s6czJz3ZrCGNLbRDn2kAD3ZLRqj5vuGoxYQzd5ovhPD0vleD3C7KPGp/NrzxsES6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807873; c=relaxed/simple;
	bh=qg/+XwLsgP5GPIr2NlsHeGUbQ9WfV1Dqcu9hSNqmb1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=rR0AiplovcLV3Gn4YVkrOigmlmV4fgRao6Enp0jROCATXKx3V81EOvc1MsHekq5eI2x8djLMWZn4rrqLvWQQTN5ytCert7N9IcL1FK1k6fPcqzK7L1qZjH6LYAmqEzoN6kZEJ8pMH8Y//SiEMyGRY5n+O8pVIGMINAfv/K3F9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXX41mXR; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXX41mXR"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso536242a12.2
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791807871; x=1792412671; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nutGTcnIz119KOMsYmdtyCURDmy9e/GYgfIVVhY3VvI=;
        b=sXX41mXRccIB1oGyWIzrVE/097P6aTx7Wd7V45feiLYnOgxHO4rrps3Vdneuz8M/hT
         zw5ms35jD4EEJHZFuaJoqqQZ2++BseXb75Bg8so3JviWrGwV+4M+H7NF9mwavNUt6qSd
         1Fc2jsXUFKsXRyl/OUtXymDWHPjVxdpF0ezYOwzPRhC8yTEZ7w5lqNM4edQglRJoor47
         arp2pHeKY5wJYQ01/35V9m7qWXe7xfLecJnMwzn5yHXuIO+CcKyB2xJo7eEPD8MFYGMX
         qCfZVjYJV+e+6iWH2n68Bze1eqXIlTrquMRM9aRCR9Nim/w9gU0GxYMMCMEurQDFOd22
         p9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791807871; x=1792412671;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nutGTcnIz119KOMsYmdtyCURDmy9e/GYgfIVVhY3VvI=;
        b=O2u5jZjajkGILfDRnlYxbwLI7KdEXi/qf/0UkNeOYa2jFqyNbrAatljMoo1IMX4Aio
         zvPAGPhHpWx2ZQ1oPm8GZpMWAcsz8KyCFkkOYOpo5ZUTIjJBegqm1YTPV90a3gbMczGq
         D+KCaSHnM6weh2DMPkD0jNbkykwY7EuMKww26iTN4E4e29EV2TWh2iYwBe5yjisgx0cI
         iuoJciFTJBbKuRVLmttlkGRyZuq/NM2/2NQBUve/K9Aw62SZ7jqPbdj7u9gB5+50uptb
         fB5Gk3MSel54gr9CLGLYyUCvq1I8dRwfQ9wmrmyix5U57qMwHKFsJ284S+A+CuQfuq7I
         QZ5w==
X-Gm-Message-State: AFq9FYIrBxAEUk58u5zuN38w4XUOk/H0Uf94/c4q7+FC9EQcc0V1B8er
	u17b8B2DTkdsKf2S71dhnNneMQVyXwHcn1NQI7qDRLXwU5zwS0ppK9k=
X-Gm-Gg: AYBFou0rslpW4zFk93LdQeaZynXdgXbx71AA/ML1v9oxMVw8XPmlgqv2coExxtcKycl
	K5EzLMni1s2blTlCn6gSGBq5/K/3myj0sj5TVttaSli2LkOTm7JnLdhQZ6et/o5UHXCbgG6rhqn
	aTeakQoCU+lWd6bfFouuOvw/MQTk/VsfPwH5CTYHDNDSBoFMpqq3pA6d0IttIDTmxqUqdybEeXr
	xYS6f6gb0eHMUnG0AjSqAD/gTqNTUH2YlCI2+uif45hr0z34FpqiAAIBTsBbNb6HuIydtE8LDGo
	7D+8JcrnYuLPqmmsnv8IHyJwLsbjlcd1cTlN62il2QvWLaGvIuI2EV0tRWBuIzswQMn/vzFBxCX
	qUflf9dF8+yEsA1KjJB95R17pxpDD8sxkK8QyoLI0ZeIA13pNT7r6aHb4SISWtZkzm7oHoCwq8X
	OgrjzGsuRRCxVe+3EsgiCIt22UFF1a0o0/KChCdkL4M+cLKSO7EKb/L4TRGo2Mhce4vClQezdFp
	vVorks6m7YXgIgaxGj98A==
X-Received: by 2002:a17:90b:1dd1:b0:3a6:fec5:c179 with SMTP id 98e67ed59e1d1-3ab3ad2b1b8mr8026789a91.41.1791807871229;
        Mon, 12 Oct 2026 05:24:31 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.63.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab50ce9d98sm14284635a91.9.2026.10.12.05.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:24:29 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261012111001.542847-1-rameshkumar.t@phytecembedded.in>
References: <20261012111001.542847-1-rameshkumar.t@phytecembedded.in>
Subject: Re: [PATCH mptcp-net v2] mptcp: push queued data on passive TFO
 subflows becoming established
Message-ID: <95dbc624-6b32-1757-7ab9-12cfeae2ec14@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 12:24:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi T,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable =E2=9A=A0=EF=B8=8F
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/38243594367

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7716baaa6447
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1183801


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
