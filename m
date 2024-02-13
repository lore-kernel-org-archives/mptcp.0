Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976FD22EF4
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818011; cv=none; b=Tz6CYi7CBTJYk409F85v00XWQ8CyrRQAhXvhs4V108D07YFFANrkvFjeROPfDzPBjAn0zdx5YL4uLsYbfMG/2sLlK16NzSdpKDShdvV2tAjPNpI+E5Wm/Vf2RViKmdtH3rplC6w+2S0m1FKGJMVY6+eT3JBiCcISf41wLPzIW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818011; c=relaxed/simple;
	bh=HZpHLsx8uhR1cMDtLrn8lJfSB8g225iZcZpxcPGTisc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hxAu7eKTwgHiivUNKD4GGNTdothwpFkt+SfYu6NoCUUuTohPr5zR3bN/c1zQ0XM8xi8InEg6IV3l0h5ARKEcE7zU7zOYMmnDTVCyPpr/zoz3KDa+hkh6EtsLUZ4EWcNSNoA4DfHyuEZt+h5qZUf+grSTDvpHLVWy5fASjsFE/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkXoaS/V; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkXoaS/V"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6818aa08a33so37405416d6.0
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 01:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707818008; x=1708422808; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY+mo2retjLqd9fFUkePbUf6SIfwTAG/ZQX8B00sRxU=;
        b=LkXoaS/Vcx6+s8f2V6U2RUqa53GKu05ViDBpD8f2mVuTcdl78Hd+jz6np7lEgsuuyz
         hCnphZhOcvPK+U1hObsMlkNabC5JJ6O1enD8vr5GSos5QmxnqySG+8LHdEH32JlkadV3
         6e8Hmpg7hWiIf6wLTlKFVLfpmg99I5AR+hGKl6pbhv+egr80+2fScLKqn5CnQQBNWSZY
         li7hLEAsfkw5VTCRoHmjNVHft+XH+CfgitcF+t9oWzxljzt2RllQ5AorKX4XgSvrG7yf
         CB281DO908kZPCu+OnL9688HS+S2x0aunqaXx2reAW6fIqYpNPp0UJsajcaBuP8bjkwP
         3xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707818008; x=1708422808;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GY+mo2retjLqd9fFUkePbUf6SIfwTAG/ZQX8B00sRxU=;
        b=GeozoPuQlxeV8Oscafjwofr2fA5xFAKK7bwDFZORTjB/CvlWEtMNsLEZaSI+wLzL2c
         ucdvHOUOuI2X0sW7uwZ1rvC3XLV0mFgzvKzjJgOcPzLB9cc8SrBYtA/HhIYvCua9u8v/
         EE4Owc5ktnOddwd4vBt5G/DlQ2Ln2iVBAupy9kv6bPYRZINlsdavrQA6UfzDCGLT6nMl
         NihooJ9MSXG+JEIphBrmF8mvRveSH/ELxg6o0OBt2FsElDfCWOO1/J4FqrasV+srMG5y
         8C2dBnImt47LYNT83t0lK/NshSJVuLjnpYC9974xa/SjCwk9idScljgNUiXzSG885Co4
         6Cqw==
X-Gm-Message-State: AOJu0Yxuwtf98KP/YBVitShKAX8c4MAGyT4L8ywJyNNAdmI4c+zStPOW
	0EUuldEtGUWTcvRXlnW6eg86h2i+22ehhU2FNfeVAY7HTQPdKBS10hkrf2E=
X-Google-Smtp-Source: AGHT+IEd15oMooD8sh/NcW5FyhCB+4mvvapyvgw8hOKHrwqTNZXSBEv845x+D5hh/p2Xnr7R98NZfA==
X-Received: by 2002:a05:6214:2b94:b0:68c:c8ce:3228 with SMTP id kr20-20020a0562142b9400b0068cc8ce3228mr3100941qvb.29.1707818008357;
        Tue, 13 Feb 2024 01:53:28 -0800 (PST)
Received: from [127.0.0.1] ([20.84.127.102])
        by smtp.gmail.com with ESMTPSA id pz2-20020ad45502000000b006819aeb62d6sm1108956qvb.136.2024.02.13.01.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:53:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <da768759d9993dc8b086a1ea40131be592ae55ec.1707739536.git.pabeni@redhat.com>
References:
 <da768759d9993dc8b086a1ea40131be592ae55ec.1707739536.git.pabeni@redhat.com>
Subject: Re: mptcp: cleanup SOL_TCP handling: Tests Results
Message-ID: <a9b564a5-0f7f-8f36-f77a-796d09fd492d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2024 09:53:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5917362851938304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5917362851938304/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5890302142054400
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5890302142054400/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/11a409accb04


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
