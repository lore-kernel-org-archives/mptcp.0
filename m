Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8E22611
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365807; cv=none; b=XSiMLVltnNXmdsz1CM/MZkywv7llQJV9ZWN5Cc5d+ofeSOPwEfM/Um3rLX/+0jZ7lESieWzPCbCzib3Y90YMmTWRb1ZIIdKUKrAf4G8k/3GhZ5HUzQD65ty189dY59AQWVq0E4myI7+bZTtWhS0ZCY9aoZgqpL74b0YrjtwzH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365807; c=relaxed/simple;
	bh=2F1xRxUwPHTvkjLLf66qSXnzqvAmI2taEKm0xcZAOoU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iUAJwO9rkrVzd4sjwM9BGS7MVWFxlqzmqKEE4A01u+L2nwbayIhDoNuE69kmdqFKmEVCOeo064iSfL496Fqu0/TJuPxhlSL+xIQ9lNPN8Tei+nSFBZtvvQvu0oFtAc4IBrc+XjxKFjDTNiPZ1OvD1DK3iLRi+9qywhEl96K46kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNVko+hQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNVko+hQ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46772a0f8fbso773981cf.3
        for <mptcp@lists.linux.dev>; Wed, 08 Jan 2025 11:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736365804; x=1736970604; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7LOkUaHddJY5bUPusEFSBnsNafiAjG3kx0RTEVzqiY=;
        b=PNVko+hQkR2WU4AHC0Po25zCUA9JL+ChmPnpxe/pWulIsphSUgB8o3HaVP52/QDDs3
         WjmQ8dgcIltYCLCamf7qh/Lwmlw3jJAwkhGH2QtQa/jO90sYXLsM1/8sv63kXcxdWdhi
         iu+PgvRnSm3M+AsydlLRVLz2ewEfs0YryLgwmX9YMqIwrCOC1+rkNa5DDZEI3tBPjbnt
         6Fsr7kUl4DF+mc3lj/VpBCdWJH0it7JwEpl9cWDrKxv5cDUAyUuASTFrTOMIIACf0puS
         E2dfAKR9l3HAY1BNLCXvijm4NcshlEIP7ibHWGWbwD4oq4zatWzEr/AcztxAWOYGlmn3
         D1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736365804; x=1736970604;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7LOkUaHddJY5bUPusEFSBnsNafiAjG3kx0RTEVzqiY=;
        b=o4bAvQ/oZFl3ZukPpH2/L1YaCNhTUwryFihT9WcWG066scT70ZGokc4uGGU8oB8XS9
         c6BTisNT3hQsTXJYq4H5zMixsXKzvJeoAMuNguqOCIUCWv6VzAyFa6rkfghGbTxcLaIp
         MxntNkaJlqvYn19/7VW8mrVDKZpq17j2u+6ggLuzS178ww7Ix15llvy1pTwxz0kegrY5
         vALAF851ANlToQGdBiPP4KT/WMhM54ta4HyI/VZeGN6pfYUbAdwfKUaESAgK0txwAapi
         bBKV6yNaeqAJMc5z4k7EMjpVXxHR+P16gOq6lK/gJ4gviunW5zriG5jgZ0+k+Guwa42k
         pRfw==
X-Gm-Message-State: AOJu0YzGlvSudKxyNDblaHLckrDLCQ/DHtwJQOSBhIXBgMmCEJNihTyG
	U/eKlpFXcT74c3muIqmkRtLK//LCiui5lX9hzGOc8bt5FK+CBQk=
X-Gm-Gg: ASbGncvBkp6qh65pi/+Lm5DyfhhZBnE0rdRlMsbxffZYT9VHAs7h/7jJsn8pMH1Eeh2
	Zc3biAtpvxIpBOwP+6fvEH0Vv6lV1/tfl1HWRSIwlaC2jdgtojyuAat8KBuMUv0KAe5yT5bRPO6
	lIIbWTyjV5cKkuj8jJ/kxl8+x6gk9iLXWVgydpJ5wJ3TdR5CgRtsjg+hffbqeWcOolYJ+P7wgok
	2QIBHVBHDaSjPtMSUgzr2zSWQ8rrqA9zzEoo+N5KQ4LEZkMl5cfgqyBI+fr6SmS1NaFl6TU
X-Google-Smtp-Source: AGHT+IHgBf0HPjLcJlpwy63J33Ob0vD1esm1VuNFNYyrLiOWC/lPL0maITeLgE6IJLhVl3qcxgt0gA==
X-Received: by 2002:a05:622a:1a07:b0:467:4b94:cfaf with SMTP id d75a77b69052e-46c710a1681mr6497211cf.51.1736365804521;
        Wed, 08 Jan 2025 11:50:04 -0800 (PST)
Received: from [127.0.0.1] ([172.190.111.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6a1283sm198793341cf.40.2025.01.08.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:50:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
References:
 <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
Subject: Re: [PATCH mptcp-next 0/5] selftests: mptcp: more info in case of
 errors
Message-ID: <e5b05234-3ab2-247f-a808-db9da2ffce94@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jan 2025 19:50:03 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12677226592

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/75c3a9a72f6a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D923491


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
