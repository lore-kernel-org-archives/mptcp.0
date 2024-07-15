Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756433C5
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073704; cv=none; b=gel5jGE6+GefyaWPiA3uDmSA82tJB99/Esy5i/0JJT20Unx1ap06IvZQJL9FdTQFCBF6APJovhIOSluvkJd+3RFS/9P6stE//I45HQLdfJeFNhfi9VDyZPC0m9q3segBkOwecftQzCs2GVMlvoxG9Z1SoMuZilefPL3wonV8CGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073704; c=relaxed/simple;
	bh=14H56FPnaSPNUCeygEG8920svIbbkBbhGl7TJPF6cQ0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sxX4AdGbzPhvS/TR4PTdGbz5dUk2M8RIrGxHD8QQpofkApZFavyatorX7ieS0I4q+2ohgtoSrfNWJYrh69m6RGaLcL8/aQQR8TKhJWMUdrKK/MLBCFq7HOmAx5jpYZj5JrbjvTR2/nVtn+TkM2wKPc8I7V3rx4+sQdFP1nTwOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgkXGdse; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgkXGdse"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-65fc94099a6so21170027b3.1
        for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721073702; x=1721678502; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXapY6ifsGvNOhMgTCunQSluBBeIjYeNveo7qROBd8c=;
        b=KgkXGdseK8pR2FW2hFrszEPCcmj0rXoYLvRqZR4nUqGyiv7LrASIgkrri9wsO3nwno
         3ys46OFedRjB80iEwxnoddWsrqkvlhDnswIesKuf9ckNwHpffStJlJnc5+60eS/WHvPX
         DSlKcGTJ/Aj2MWrIPTYCCtVqDu77ZwLd+KnlWap1khmJIpyBCYM35/A52STyVz802EeS
         Tzb06LOQ1Djt+dbpqcAQj6fO5Jl3Wzu2CcLzBwNzfdXwLdkkF/Be4SPl0GhsTA5mY8DW
         C3HrwIRBk6emGKeqNmASE0v3Ou5tZ3EWs3QPC9cWGrsydzgjaZmDkSs4P0HOnMQDlgsf
         HA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721073702; x=1721678502;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MXapY6ifsGvNOhMgTCunQSluBBeIjYeNveo7qROBd8c=;
        b=IbJYsLxmbYwkV2AlKBJMp6fpsAbRqixjGLYJvNo4NyFZZXOajQN+kBAfPhDjUAjbXg
         5zQAz8IpjAvAZGitHNkA1QCTvDbYEEct2V438i3Gd2WCwegErkC6WA+vdkXQmVQi6uWH
         vuynNxgK/w5KPdLXwBsPkmARS7C9jg8f8uCCkGrTmFFWASRne5uhimkolxL0UzO0uGdr
         NxhL+kM5P4q4WJ7QSnavwKR83ggcCpPFutzQ3NkOq839f/g4GLJ/aKkQ9KXdlSZIqMZx
         ef4DrHamDosoUyOPG87hf5v1smh5SMNMR01roGqxSQlXhIAgiJZfVV3UyXZAscV82lCo
         qLnA==
X-Gm-Message-State: AOJu0Yz1LDdBvBdlrCxzfr2yixjh+/vX+qJcFVQVeMzmTVAf1E6oKh9L
	0tnTzGxrL1s6ydVO0JsdgthQDK8XSo1gviVtxEqdcBlyMCBADbeb62Vd
X-Google-Smtp-Source: AGHT+IEPiPM/FRu1kzLo9ykqIV3nrtKsqeZJpbQwEfKNY75ye2UUC8yFTJXXK1aF4Vtr2jJMINgMwg==
X-Received: by 2002:a0d:eb48:0:b0:65f:7765:8710 with SMTP id 00721157ae682-66380f169d8mr300717b3.36.1721073701831;
        Mon, 15 Jul 2024 13:01:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.53.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc3f78233sm9123117b3.83.2024.07.15.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:01:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240715-mptcp-process-4th-ack-mpj-v1-1-d44fc90245e2@kernel.org>
References:
 <20240715-mptcp-process-4th-ack-mpj-v1-1-d44fc90245e2@kernel.org>
Subject: Re: [PATCH RFC mptcp-next fixes] mptcp: process MP_JOIN's 4th ACK
Message-ID: <314c1394-26e2-8bf0-df31-067368b0c030@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jul 2024 20:01:40 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9945407425

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bef94184aef7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D871475


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
