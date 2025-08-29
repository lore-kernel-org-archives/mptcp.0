Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD67256C88
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756509540; cv=none; b=UcTJVizx8RtlbBjOclrFyZk6yHCAmP83CgyLU6AiuLp+6/wH0hfZssgn14xjHOWZB/F09PYWySmVL4hr4dHgc0MXG6WQuqt7O7k+lmjhGDYb66LxiQ2rS2HVMagx0eXN6zxROmnAlrkyO1zwYCFghMaRxDlbxYgGbsDdQRObWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756509540; c=relaxed/simple;
	bh=LmODThJb9Ca9dYXwuw7zsvw3bllWfKQl/BI0/amKZMk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mTrU+a0uyLvVaTanJFnKxVPzFYjZg2L/xT45Byp7SqboKBD95G1ER1T7BuO6B19Rae7GqqmG/W++oaLHGLQ2Ao97arBJwXJnbmEUDRS4RqKc7NnrBZ95nHgOV0bV971Gy922u+tdu4Rn10WezCNImf8alAFKf2/jLmbiK9XCpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUfe4p22; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUfe4p22"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e8704da966so168181685a.1
        for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 16:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756509538; x=1757114338; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNbe1dSzq83c0IoGDoKCVoTntw8lm83eQQlxJ4y9JGo=;
        b=kUfe4p22cLIFmdjOGBh6yfYkfzLRPlsaUNNA6Jl/ZJ4nSl0KagJUBJHEzOZiPZfmAf
         cMhFX2fWIJobsvoZjZuaQk8xw7NN5D1tFjAIY3wFesQBgtbawr1vaYVDEGz5evcDqQX5
         vwXG6EtmToxuv2qvJl+XmxRqe70Bt/5t6YldPnSX7fthQzkVmkB5ZqZT9Iw4aAHTnpOU
         Nc25K479J/91OPKKOFspNZMdSP6oi7JC2Xjis0QHiHiXN4XfTVhI1FDbI0krfLumE8jj
         rW8N7WQzkN+eNXHW9+erqtiz3hM+OLGrU18RUfh7WOkZ52tLaam0PheEyx0zKKe5GNBY
         PbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756509538; x=1757114338;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NNbe1dSzq83c0IoGDoKCVoTntw8lm83eQQlxJ4y9JGo=;
        b=IBF9s9gbyOO9qFPYpIk+eR0HOZGynF6LG7aTfAEU6iHUWBDnW1pv+jDhLAsSx68o+L
         tiyyxszsHZ80bnjFdxRmJLqUaB0P74HxYWy5j/qcEjgmv6eM98y+K4Uh9DE93PE1nPiv
         UINFbKpOC812yt4NWf6U6n1/8RVnFHIl+jopzyUK4V35l9a76A0V6YWQBlfzsdQOFykc
         WsaoeY1kOY1AgSntdUEd2nAvz8EhGiez4Nnoxexmu06YNferxFLIHfpwEruANFT1b6Yf
         Sy0srHtAUUFCZHa1Io+/rSQCACK58REoFGNFfibY3VFxlx1mtlWmMzsWd+MlZJDbm14X
         z+SA==
X-Gm-Message-State: AOJu0YwS2c5jiHN4WDcCLjCh/SNQXsBS4pQ9V4CGq9Juo5g5TEjbD0NP
	ub7jYVqygmz8nAUsW1vAZplxryTmRVQcKZqMPH4RUHndNgozg+2SbqEh7PQH
X-Gm-Gg: ASbGncspLpuNAGXtYMl609n7nxUZAUCYYOm716YyjXtdxXh9CRjR6tRJg0Us4F/Dh3q
	TaWhQh3CkRCbc9Wo6dvQ/P1FOhP+qzjo9SPSMX0Jiwm8ZhE1spfOerX6dan/fXEnisallQ91hrk
	urJuD+BTzpWG0GwvxeboZWvMIqOg8Xola1t9nZV0t8vsXmchFTw2lt5UwMTNck+o3Q/qkCZSzEF
	fXx626iPZwFLNZbbBI74++sBB8RWHa4n8uq1yUEEyadXMcalj8eAirK1yeiaKbnbM4KijXBMNl1
	YJH1odZpgjA4FXUJ0w+t8bKyQPl7QqHTrMLLQ03j8gqCENizRj7HqHD0+aEXljbqYPQkbvik23L
	YZ/CQYHNPet3ZyKYz9JzQUkaQNLgLWj9EHA==
X-Google-Smtp-Source: AGHT+IEWreQmNFIh1AojPUKC4faPOhWVQ1pQg1G8I7XybMAHl2ytErdGEnx0XACw0UEDvO5nLKATQQ==
X-Received: by 2002:a05:620a:3904:b0:7e6:9cbf:7f41 with SMTP id af79cd13be357-7ff27b20d7emr42680085a.21.1756509537998;
        Fri, 29 Aug 2025 16:18:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.38.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0eea87f0sm259716085a.26.2025.08.29.16.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:18:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
Subject: Re: [PATCH mptcp-net 0/7] mptcp: pm: nl: announce deny-join-id0
 attribute
Message-ID: <812a98d3-d487-dbe0-2ec3-9d7a94d44790@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Aug 2025 23:18:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 3 =
failed test(s): packetdrill_dss selftest_mptcp_connect_checksum =
selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/17334080753

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1fe573a443a0
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D997044


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
