Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7713B288
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115657; cv=none; b=dqxEGVaE91S7ssTmcmP9atxJrmK51/Rcq24uf8cj/ZmBGh+kbr9XhrSoi6Pl7UuXcUxE9GKcwwtsDWY7SOqJ+LaiBZ83IeP8ZQ1CEFTDNntqQV7tTlotNFgTKwEP07sqUZ6BaTFgKQi+ZS9H31HUd6wqADnDxsCO6bETNyoVuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115657; c=relaxed/simple;
	bh=bzpiUGESh+VTr3QPsQ44zsaRg/rh9A3kIt4ooIjFytQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=k9+3gySU/n+XqrVxC0JrQGRUIr9B32o9I00VZDzgJ53u/7FotR0hBxnw3vhEb4JSsYlpIzS9X7KAcuZ4TMnvpSmm9v9tNQh6ATi+z3oG+e8GeoRpE//ld3/l/dNfJ5G+RUw7qGoehum29wNITCr6yueM1QO6HgEeXlNGZzCH5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP2NY+Da; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP2NY+Da"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783f3d27bfbso59558385a.2
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708115654; x=1708720454; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEC08kZ2GbqEaDR4ESduLv2sdUistYLhYs2DvCW5kTA=;
        b=WP2NY+DaHb4ZRruHvnQW3c8aSKLSGHT8X9n55LehlLiHoLD9eboTOk0olD2hV5dbUL
         cHly34QdIS/wDHsavD7XcO8x/LQlSFlvRCgofYJpI8VxTt2XU2fXmWvFgRP6blYye0+V
         vhVoHXu2Qr4c50WEZu5fJu9SOei0ye7zMsbHwUPLyBoNOCVAe1k2qfJJgJsyxhpUiugG
         t2VSJ5VYbBIIzsxnfveCET9gUSeg22qRMeSc5RIDRinKhEu/qZc6g9TNvLKJldLZ3N6h
         gP0QCmuw0pojHXyAgdOpK7XCsU+RsoBYsKJGu2PoVxT1uLOM5ReHt45EvSJbLP2MUEpA
         gmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115654; x=1708720454;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DEC08kZ2GbqEaDR4ESduLv2sdUistYLhYs2DvCW5kTA=;
        b=N9bXRVCIs3JaQfC0GVOGaBro2/cSL5IzAYvjQobMA7LHdUaSDa1g0WpD9JJgQRQch3
         wQTd3rzpdn96ikgiBL8Lw/I7QH8jnlPpyhPJH0uHGfUvyCYZKhFg7EZ61lLV2I3Sap4B
         yrGH3tLkUcqCBiDdHsqpZULTCzUVzzMqB6RSmasH2Rgu8V1ZykD8cSxavkB6rIbdaT9P
         U/1//E8w2CvUGqjC05jQzKLrAj7WVMMFt1ay4/21JIoLV0dI30ImO34ZSM4wl54XjYdr
         L77BolepdnCiAGckws+IdYhsk/B0y7ukSO5rvLV/aaiJf66Pi6+YhcyxN2iieLCA5ybQ
         CyOg==
X-Gm-Message-State: AOJu0YzsYAU5ef52gLyfqjPs415Z400H5j+ngsaG7iJcLOeiXHAugjmH
	KXRpe2ikQN+nL6jwMmTv32P7GKKJpIA8zy/BMv3EK1Gv0cWN0GaPGEeva5M=
X-Google-Smtp-Source: AGHT+IGd+PL8DmR3VvOHzpkjc8od/nyxvUD0km1qnceTuFgVUTW6ibOK9WeJ7bXEQl2wNTTPxPSdOQ==
X-Received: by 2002:ae9:c301:0:b0:787:4161:9344 with SMTP id n1-20020ae9c301000000b0078741619344mr2576363qkg.5.1708115625018;
        Fri, 16 Feb 2024 12:33:45 -0800 (PST)
Received: from [127.0.0.1] ([40.76.119.133])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05620a318800b00785db3ebf93sm260608qkb.92.2024.02.16.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
References:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <4d406425-29ea-016e-6ce5-1bcfb36e3170@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 20:33:44 +0000
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
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7935566630

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1d4c1fb5ebca


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
