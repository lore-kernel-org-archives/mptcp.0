Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CE2EB0E
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741388; cv=none; b=hEjgkL2+RPhQ8mU2NDPlVGT4cSxtZhd7LQPTFiVw3TNsW9PBE1FpqXwsofQAcF4ty3VBEn/FrhcZj8oO7O2P8i4eXJiKHF6Ho66cktGcwolE+sihz/OqjVaaz/VNZdqAb39Hs5hEnSs5T7To9TDvE7ano7QutMBQ2R4q9z9b++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741388; c=relaxed/simple;
	bh=Y3d97UlOwMAMBSTYN3lPfJrASV5g+vSHoJ6uqbNvfMM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ulc86gUHb6FT/uMWs/SzOr0jgmYQQFPD6jKHlgLttCzm6KbhrAftUDs1MK2pf9GZpt7x/ZKHXJ+LLv0i9RhU4GtXt9m0dpE0y8u8v+xfTjAJqCdAhgeX0rzzIYbb3TbB5necIOV6xwlnkPUOaeOyOkrADMKcB1WW+k7HkkNSEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mkj/fXiZ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkj/fXiZ"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bda4bd14e2so2640922b6e.2
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 04:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707741386; x=1708346186; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SOFbHYUQ3AlGVqDBvtc17G4KuO43mmi1l8eKvx/Hls=;
        b=Mkj/fXiZkknGdQvLxEocjNC9/8T3c1gzp+UYL0ZHO6w2CLXqBkKMBaE2oPb1BhTujC
         rO8L+PONWTOIQvrLm3rPADq0bTkwscYQ7iVq1EuFtmntLpz3jo6SdQtWXz3vsezmRb5V
         TK42KYJ3k/yXieYmjLu4WNCoPExaTLo2kGJ1h1hjCTjt9K4ww6/YPhKjHP8ElEjpaI+j
         TRO7wZNjiwFkr8JNrWJG02NCSZ4ivfgOPtq60m/T9RzwADC4KlOry9xbZszWsOlvxyd1
         qIK3/khtiZmq1zntwxeOKiSuf72Yudz+y0//XodEphZgkeCIsGjpobMTgf/yFKZhySro
         TKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707741386; x=1708346186;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SOFbHYUQ3AlGVqDBvtc17G4KuO43mmi1l8eKvx/Hls=;
        b=HliBclVPe8/ZPT5pQBcj87s3IoDaSgM0KW6CfBkT7u+9EdEi2QCWv9W1lSuyvgEVs7
         vf3CJqRi3r8DT7lG70B1Xi7VCRhGeObl//mrc/NwE5BqcqfOpOBRXZmNjzhummQrThzY
         yDN3W9HvR8F8hTt3goQffb0zYxvU0xYC9qsfNw0+rOKZIjsqmsvlxd291UNMxNc0au44
         WzuBkGt7Y6ebhfFuzHp0MKwSkmCfxFfNVVoajgk2xZBfXl4aZvi3niONUvt6kYPcaSc2
         UfhnV+/76w8sef2biigDEq1UDJp6kfrhlHdhp7cWlRopGBYGSruVY+oGEMe98WjClluE
         tuzQ==
X-Gm-Message-State: AOJu0YxenGPvfx0k1Ep8YZVShJQu3h9gPtxszOD4HQeoTByXEobehvDk
	zYz2UlMI0eM/ZqsDzULPCZw3WS/FxJHTZ7CCeDpqsKGyR69Uar4=
X-Google-Smtp-Source: AGHT+IHC/csaxNvgAhJZHxvUHR+R0l5FoYududzu2T5Pzb48/yffvsTFrP4Q9Z1pCTb5nsmbsDoCFg==
X-Received: by 2002:a05:6358:895:b0:17a:d4c0:d59f with SMTP id m21-20020a056358089500b0017ad4c0d59fmr5526166rwj.4.1707741385673;
        Mon, 12 Feb 2024 04:36:25 -0800 (PST)
Received: from [127.0.0.1] ([52.157.4.193])
        by smtp.gmail.com with ESMTPSA id n23-20020a056a000d5700b006e040c3374fsm5474878pfv.64.2024.02.12.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 04:36:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
References:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
Subject: Re: configs/debug: add NET debug config: Tests Results
Message-ID: <06115d45-5572-bdf2-726c-628d64863862@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2024 12:36:20 +0000
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
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5661347283730432
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5661347283730432/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5098397330309120
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5098397330309120/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/367eed27e7e3


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
