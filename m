Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8F194C7A
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210424; cv=none; b=Bq4T3YrScK/wS3ovb5ds2fA5w4E+H6pCHDLRRP6f53ToTLdMxs8F8NZr003DM4rEDp8/huq9RNvwPMU3juIPmCbGjRaeY1Vz2ZaQugw0islSgR8VZnnFao4C1wW9HMFV768EqP6tpx8/SuGJKRAkWBKjO2utmdVTERhfPVJVu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210424; c=relaxed/simple;
	bh=05G7jKQWeY45sgyfIrLHtITiCVvbfmuhzFrYzkcor5E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sgZQu9Qm62aR1XyJIsgtpf7rw0KqtsL8nS6v6RK7ZHXMTXZZD/zFzGdsRm1sb891Yx0IwnxCG0d8LRnrLUbENOlbYxP9PWe4jBEk7zLeNgth6iPlXLm535SL2osGCxnKK5MMtYWvR7Q0UB1r4lq++S8ehk1UWEQuqTC4jZcw0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/WMiSxk; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/WMiSxk"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so11129706d6.2
        for <mptcp@lists.linux.dev>; Fri, 09 Aug 2024 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723210421; x=1723815221; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzg/qKfglmOJ1VuXI3J//PE8gEpQRX0A2nqtH3Zm+0Q=;
        b=E/WMiSxknhi5A3xFsP44qzGlvmQT9RSttnzQIxWqVqAzc6doysjzjGy6M4ojzUaGCp
         qx8FqiMNpEIjiTnLb0UNtTA2jyq4c6nJEVE3S+qOTquxsp2fhOBxNMjnPSunE16AAqDz
         nSITk+ZMfo9Ps0EKVSSxnNVdVPqv9Nwt7atiSvObvkC64xc7m4EhcrxSq/RWleS+r1kY
         JrsjGFOcamOoMEeA3KE0dI7802exZK5hcv9hlK3b+uA7gV88vctdU03LlDUZzh7bj0yZ
         F7JzO5uLtLoOySi98dVMqXjFFcX6XeA5g+gtY8eYwHHbjxAYmMvSMcbe33QeE4HUelU/
         2MTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723210421; x=1723815221;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zzg/qKfglmOJ1VuXI3J//PE8gEpQRX0A2nqtH3Zm+0Q=;
        b=MeU9UoRiR1Bpo4DbvIsW1LzOGLR+wqOJjc+ND1EI1I9iNSjIDi/9mgHXut8h05HnLX
         B4HcSqK++POvq22wIkEmnUg+9kPM0xVm5/43usyMCD3A12ZtZltr8hLL9dh2SZNT6MkF
         ADg9nfgkDwKllyS7MSWT6uB1X4TeuzcG1ZcOtrRsAu5FqxffGY3TAab1t+7aELpGem2N
         T3lliz5vVed8/fLXoksBTdltW2ho1d1ialQhFw+/NknBHo4L086rFzaqXTHyQIjCd5bM
         h6ch3PCiFfj3JSv6bMdB9BO9t2ESLrqVZAh05d1DyGNORZkajgLZjP/xzp8LG8WET/yR
         Uwww==
X-Gm-Message-State: AOJu0Yw8B/yOIYfYCIuxVsnAGwbUdHKTxwHq5L7HSRSEjK1QGqTQQ17g
	DMWGvHsFCvDQ0vxt/1tsHWgNaO9RnwQCY9NWvHFQPA8mg/Glwzs=
X-Google-Smtp-Source: AGHT+IHJBNQGtWVv4JSIjnYm/F/q+M9bRQZzseggtqxQS735jioko1NzstyD8cgVV8wIlMvcBZZDBw==
X-Received: by 2002:a05:6214:4388:b0:6b0:90b4:1ca9 with SMTP id 6a1803df08f44-6bd78da4e44mr19315436d6.6.1723210421420;
        Fri, 09 Aug 2024 06:33:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.79.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87d7f88sm21420781cf.61.2024.08.09.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:33:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
References: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
Subject: Re: [PATCH mptcp-net v7 0/3] mptcp: pm: more fixes around the ID 0
Message-ID: <38eeb61d-8b80-1e14-8973-86d1b0b24d63@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Aug 2024 13:33:39 +0000
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
uns/10319599535

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0d9537940d3c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D878199


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
