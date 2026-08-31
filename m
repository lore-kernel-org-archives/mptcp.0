Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041E39EF27
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173876; cv=none; b=sMHGmpHqK2IGXqz0Ujj58/Vsfev6CN+zf8ot9BEwpNACXpngkmkBW/XKe0Hni5oJhHjGQ04E9nqGP90eRvhwEjDm8JaNAGEEdnWh15klLCaECWn2+dwWAGN1yDykocS41JoPfOv9wtS1jzVoDrGPzzkdj7BStgquJ5pdL5orBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173876; c=relaxed/simple;
	bh=Jg4eoJalpwBfJ6rvxfYGM8qflwiUz9GOT/mToqc5Xrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WtFf1MKMv34Onh08xzqsDd8DRbX0y1ip452Jqcc/l5tgKrfSAFRaDrtk2LmX/vh9ZFJhoKuAGjvMFADbKnjduYznX8arDQPYcZz7StTshmiE//IQHv1rZlGTof/ssIgiATxbrrE99K6aITcGjqsELIRfXC9dwQ8pERzgjYqB+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDPJTLPa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDPJTLPa"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d9004f39d3so14830865ad.2
        for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173874; x=1788778674; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fTZ35ZYn9kScg0uzCOxo6gCfyJQpyJOLdiUzl6ES6go=;
        b=FDPJTLPaXa60ymZNGZIWlrcFh7O9+5T3BS3Z8dPDuDLI2jN344tuiL0W0BcpSU9xvJ
         YB5sLIP2XTy4c5/ns1OikeSCQdcAFLajvD53CPWIs9QM0/FGoOS5I764gdfRFyGEyhI8
         j8l/c/YwURPLHCAvJ88rWdmhIUe2RVGL3knWo70cRzJGLmDZqHkjDgdbQImE+SUkkojq
         cQJc/W35gf3tzgvLef4Rv3kiI8rAw9CtNBGKyHLxswl7Am+QzRm0yIwRr++86A9xlWAm
         BdiueN01QkJK8b9JmuMvkucd+ZGC450PQbOfqwUu3ued6ZuBbrrgtDFyHXInGfiwZ5pz
         9R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173874; x=1788778674;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fTZ35ZYn9kScg0uzCOxo6gCfyJQpyJOLdiUzl6ES6go=;
        b=XaZ5TvsQ2lWA9xfmTG/O68Gq8picxA49rq4RxPABfsoUkBkZS+/HOl77kuC0cM9xbm
         iX7g5WNdxIDmOJm2FMmiAtsbZZT/Y0hDjKBj3aT58IjQ1aMDYYq6Lei95Nm9Y36Gnw8P
         VvAnB04m7tYuzpLB5f4yFONBIhMpW1rGpAB4xdscUyxgtJkR2SXCO5057AIrFmkfVwhe
         hzbYL0+QRqRe0cUFzigNKVl1yrFCuMmjD1Qv1e+uMnyfAIneg1oTpO4bYuSrWgaBU/Q3
         sigvULnN+5ZCl6LW9UgM6ZtU5eHD27mhHQwr6/ipRXY2X7afDerH06QJ7XDJntByYhqX
         DIXA==
X-Gm-Message-State: AFuF++kWC7iL6ZWIBvncuZ8YIYnQSkO/ECqrKQD0HgPMXwN4GPAOjPCK
	ZdVbsv5/JncP88gvy1CaG3B6ELeplmvMtahwmLkA0ju44uLOXjGxnGHVw6hdt2Q=
X-Gm-Gg: AYBFou39NKx/jG1r487MilBMmgkrOBMDepTXb2iesTrnu5df449ZSsZjw83x54bHasY
	XfeBAGD1HFkqP07i+ZCfhPweIiw+46dKJRMfIzU3PIYShVevGNuxKPU7blgPRbN9mrZQ3dk+vim
	NjNkQFaD7BX/YU/l+6KkFHz+p9Ck25YfOoXh7wlYowPnpM2OPlwCFjX+MRX0NQlxm0X6gEb2L+p
	RghhWOiAV/nuhfLPWR3hxMqzJ6DPZkeGyYbOYKGCcDVQ7PG1PXUTdfLAb5XIMZPh+/r4K15QsBr
	/ivcUuQe0MgULw1M2/0dg4kEUNvOmMDHeEkA6TTORM2x2snavtQv97W+iykjAi6N5O6sUY40SNu
	ZvTFrUatBCy1+nJI17gqFhevraUy11bCL/bYDQDLxhvkm3US6t4eYl8ub4JjLPftQYfsuKNG7mX
	wg4lXO1RgaKdZPEIAilscwC/eNtwYnc+pDdUPhGVQCvJrBzt2otMAK0zvKnkguya1DY/OQY2Lu
X-Received: by 2002:a17:903:1b4f:b0:2d9:4871:393d with SMTP id d9443c01a7336-2d948713ab3mr8183765ad.21.1788173874210;
        Mon, 31 Aug 2026 03:57:54 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.75.167])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be607sm29341619eec.10.2026.08.31.03.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:57:53 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260831094651.2682660-1-kalpan.jani@mpiricsoftware.com>
References: <20260831094651.2682660-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v3 0/2] mptcp: sched: add subflow avoid flag
Message-ID: <02852c04-2d94-88cf-e6e1-748582022f05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:57:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces at boot=
 time, rebooted and continued - Notice: Call Traces at shutdown time, =
ignored and continued =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/33381492140

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/95677b25f96d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1154369


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
