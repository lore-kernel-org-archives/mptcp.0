Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF102417FE
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928691; cv=none; b=WQQJI9ppNnX0rFXiisdCTAXszpSocNM+1A58HSbSbZJXFkbBHJX7Pqu5nQ0proHxPpSkcnskTCt0PEwhT/8gJ1lFFruz8V7R+rKrrEkudo1HCyNdZpswCs7nwT8IZjZLGK9QYJs1HFbNqkdxA13+zEkjCJQOZeFtTLDYC9wiID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928691; c=relaxed/simple;
	bh=DZY3N/0WsWBcSQQBWUfvoT8lTZYdlxsYPtgbM68akjw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XKG4id+38cUdnepPJsUcAakUeekHsm/lTBFEa4e5ST85TgDUsd87ffB+Xal1+2CY2WIgg+LTRtFYDVUOiYsvh68hGG7jlDDl4LRcBovrPH2Bon7r88lluRifIQ/KsW8e79R+qcgyGGfGLvTw/Al6BH4KY+y8P6SV8kHwaIsGXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLgk4id9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLgk4id9"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa1fb3c445so1576701a91.2
        for <mptcp@lists.linux.dev>; Fri, 07 Feb 2025 03:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738928689; x=1739533489; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voD+ZrbYLw7ARdFr32ioMNp6co5E1XSusuPVRmm85J4=;
        b=dLgk4id9X+0cNpmIWqtedcFgVbkyvvfkLYxQ0E2k5ICppqnG6uhFNsau2uwhjPo+a9
         k0Pa0BK3E+qeJ/h+7LtuiBXuhU38TJT777SQXOF2l0OYSPO7GHcJkn58Eu4NwyVAhUM+
         fBSP30I9G+h3xOLZ8D2zVaQ/xtYSNjQ908Ti7Zw5ExlB9rxF1Wu6H53bFgKZcsHHTR/I
         MGMEklv9Om5Gj3yQ35022aKbWEWOSG0bCYE6vFpPq5wvyPiH3cXdCOyL6E/sHIm6ffVx
         aJAFdHnaspIae0acBpuk3SqtyTidG3dhyJXHV4J9xx2LXHZDEgua1hF0PVNrrMRZieYL
         fn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928689; x=1739533489;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=voD+ZrbYLw7ARdFr32ioMNp6co5E1XSusuPVRmm85J4=;
        b=elGz8XlIIxXIXpqvqi7G/8J4kzsTFlgw87KmPtxFl2anbsyABH8AljDHc+CkbtRjzy
         LnGxfIhKsFEY0+imNc8F+vCLuk8Cekz7e3ifoWVjSf7ZqLDqMDO7KgU+6UQVX3LKU1/I
         rp8aHO9EG37JIbSueHHCCjlOpEld68diRTspm+BXDsNLOit9hm9Xp31R3CfCKrCvNfPQ
         BOO6e1+ETdgBbv5yVRTD/jgOriWQgjLKUdSAqCLpLlds1oQvMRA2NVee0vLRhLgNdWJI
         gqT131MoAkOub6cGvkKQWsFVqlESnbGkNj8zsRHbgTh+D12NaULwVeeltQmRaYlce86d
         wnRQ==
X-Gm-Message-State: AOJu0Yw5KNB2VA5dL8ozaSD8W/11iGQhf7obJA2IeQvd9Or7//s3UC8C
	hyXfRaOR88uxvMuIyi/ckLHAHmHxqEuaYSqN9So1MIwEpkIE+xuK25SV
X-Gm-Gg: ASbGnctjc004mxnuUpqrHZjADZFed4DjnjKmCZ55Q1klin4Qi46fiHEVrqGcrg9+ehT
	3a6bK0In8fYoYv6PfGsTOVHryoKONBiIAahR/5SFP/xZ65NWcTL0RAFiBR45H6W7GbYHsgjREyd
	PeF25w/T/Rdv9jFeFyG3QqH/e0qg89lUbUuwkgQRZtpi/b8NewIlJ3qEXheAQS775qu7xqteE7t
	vDBDogWtMdzbpD1LrZ/fYF7F8q0is3s421lPUY0T4noaevxU0bZFrgwA1y6ULBkpR3i+IXB3o/W
	Cb0BhvA7p9KkHr2c+c/1Mbp32Tr3
X-Google-Smtp-Source: AGHT+IESDPkqC/Q5zNyf3CaJXsGNJOuebIVaKLLcek+lLaxfp9Em/xwICgq+dhh//5anzguANxHckQ==
X-Received: by 2002:a17:90b:4cd1:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-2fa23f5ebb1mr4789777a91.7.1738928688719;
        Fri, 07 Feb 2025 03:44:48 -0800 (PST)
Received: from [127.0.0.1] ([52.234.38.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650f382sm28643215ad.29.2025.02.07.03.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:44:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1738924354.git.tanggeliang@kylinos.cn>
References: <cover.1738924354.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/5] add mptcp_address bpf_iter
Message-ID: <5394c83c-25f2-5e31-d8d9-5e79db194624@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Feb 2025 11:44:47 +0000
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
uns/13198351458

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bf5c2a4b6df9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D931534


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
