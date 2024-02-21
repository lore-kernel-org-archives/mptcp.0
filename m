Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10987FBA9
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527274; cv=none; b=Y50XpSb8DgTM7o+Z44Ey1+npVouBpUXExPUbEMKmb3tEDSHYnYTsRQcKlstXcvFzAHspfA8A79K0Oh94KvXOiHkrFKRi85z5NCnxKvUHz/VCNx8YRtlVTk49Cw2lMsWmuJRMA7Zl7oS7cV1/znIHbeDgFo5YayCcsik99YSNrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527274; c=relaxed/simple;
	bh=S5Ct/HziU8y1jXPxeTGOFcyaZ1MuaMbWi9RojmLsNbg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AMdtOzTjSQRPOOIWm+SppUF8k9DyQhyNj2SRateyW6JIeObtYvY0G0DRUcUSkKcnXMGyU9hB3Bbk3So25W+VCfD8Ay4CEOLrVlkybih3pNtdiDScftDqY4++q4XKG2Xh4V6XuN6B+Vt4K3J2kgoPbE9S9Sja06SApFHjtDcoiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGh5RaTg; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGh5RaTg"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68facd7ea4aso3404776d6.0
        for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708527272; x=1709132072; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4N/DGOtGQPWL/KAkNbG/IWhnho7TR6ZRLYvP/9qfBs=;
        b=GGh5RaTg5e9wui4oykwFwGIiqEIopizVzW7d0wecG8vyiKlKDWpygN6vnVE689yFRy
         uPPgiiUSmLJ/pqn7xpbbUgTWDhfJTcBucGwpBDX53Cu0Ug0nH1CtIeb72J76RBmvH/YG
         0VSe5KFt90diqEj3GZ3DVRWf1bkNlccFNiR4c76OwyrwfWS7B5VaTUEEaNy0pP3hBc2q
         lY/jo2E9tHBawSFOXOEyhPTJfLT9El0ZMLThsu2mP3eTmnaFmoIeliWcUpQJrbgWVZo2
         +AzkMm4eF1RhR+w5mooqdriQPJC2xSmfUoO1MMqcZi68M2Kxy+0IW8DY5gbFS0LtwlFJ
         PK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527272; x=1709132072;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n4N/DGOtGQPWL/KAkNbG/IWhnho7TR6ZRLYvP/9qfBs=;
        b=G+soyKBZqaDAV9YAzQngS3bXzLhKb56zxDH1R7hPJy9WN31KQ4eKYLPq/G00kTqG6U
         GAKQC4S1pKMA8feKK741DE5yKt5o/Wif13Z34EBPZZa8s7/azwvhhd7L3azusr63cdKW
         EgG3FOc8vB7GKmqGtwWxSrE9zkOW9UtuXt7cbnFOIcHQQ8Wt35Bte96tcP5PuzuBqIDi
         jLfWeDG+p0M5Bw2P8M445Brfa3IQKZQW8I8B4MI2IRhRjmiiIUh4mRNpCD4W850Sc7Yi
         572cHZGOXQ8oBIrz8h+HzS4D3iVzcX10t6mqhWpyKYzehwvROqPL4XdxTkZGKVLijuN2
         nvLQ==
X-Gm-Message-State: AOJu0YxUy4SDRjA9FGY126GU9wUg+ORJhA/iQHNDHWuqSqQ/cRuWijC2
	SZTYgxVj3WfZYleHc/HORbym2Xxf/EVBmXLqXEofZCMJal1oLSUUuC7GGEM=
X-Google-Smtp-Source: AGHT+IH4TY1tadHlTDZxP833DHzjYMBUxxoJY69CwrmLigoKBJzeJIo3Xy8z0fEayVO08cJA+eATqA==
X-Received: by 2002:a0c:e2ca:0:b0:68f:3dbd:466c with SMTP id t10-20020a0ce2ca000000b0068f3dbd466cmr20827384qvl.22.1708527271795;
        Wed, 21 Feb 2024 06:54:31 -0800 (PST)
Received: from [127.0.0.1] ([20.185.156.201])
        by smtp.gmail.com with ESMTPSA id ng6-20020a0562143bc600b0068f49b6edf5sm5099386qvb.11.2024.02.21.06.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:54:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <82a62a697fa15f7f430076f67d6bb23a1827eb7b.1708499011.git.tanggeliang@kylinos.cn>
References:
 <82a62a697fa15f7f430076f67d6bb23a1827eb7b.1708499011.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_evts_* helpers: Tests Results
Message-ID: <967f1bac-694a-3255-5110-bba233c70737@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Feb 2024 14:54:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_regressions selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7990=
465311

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dc43d4035da0


If there are some issues, you can reproduce them using the same environment=
 as
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
