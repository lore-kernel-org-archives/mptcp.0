Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91AD14B07E
	for <mptcp@lists.linux.dev>; Wed, 25 Sep 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259201; cv=none; b=XlBSybc26GDgXUxmA4QdUiHsnrvGJvRQTCLpqXro83+iC5OxGmSvk3vDhZQ2RfkFD1kQI6BKbyHOfPEKbshQeqdX9EUb1kCN16baRCUNSjMfrUNaWV3RPmrNmbJZpGH7PPqcxqGalWOlt/WEjAGkcOm/krHc9Muy6ozBk9OXBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259201; c=relaxed/simple;
	bh=Pd8qbOwNIrpTcomVUaabqGmEpk0/RonZiHgA3KRuvxw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YyvHTBKKxyfgWx6N/05z7LkOvomD2p6j7YyyGoeUQx1ic1iBukVtzQ0q7NRBvfbeo5sqD80EtnGakeNrfWKZrZkO8KDrCCWOCVinCGzkn2MESfQ36F1EvBQ+vhamqQIPE0/ZqRPbJkXk/SVPbvuh7JD21mnyWk0RddT+mkBV/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7xett2C; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7xett2C"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d7a9200947so4157526a12.3
        for <mptcp@lists.linux.dev>; Wed, 25 Sep 2024 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727259199; x=1727863999; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXrNhhyEkKzBu3cXPYKHa9KoX0f8fv16K2dLq8hjJcs=;
        b=a7xett2CAo6RVPDmk2tzL8C/u8il58jm78skf+GPQ8J6dkVAmfpCxOqfKeZOb0HeMb
         94dBLJCKMFKH+ryq89j86srXdAFeh4GRCuyv694+QcH/pCZalVwrN4yP25WDiuJD0LXL
         JdzmHvFM6QKI7fy9Cp2hk4jsBOM0U3eGsWVYQQMHj3ePQdTqOAW4titIr7bAoSy0Ue1t
         TdsOcIFuyhw3Zhw8ZKXybtkOMZgG06QP+Nln5wyoxVpVJ1mFCpSLEvn7x/t1aRqqWsF0
         h50aP2h1PMlv4GbqVHMtCy0C0Aq5HjACSbZ1DTMOWvXrkbg2egSE1+3Zl/UwL4lpGwu9
         5KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727259199; x=1727863999;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXrNhhyEkKzBu3cXPYKHa9KoX0f8fv16K2dLq8hjJcs=;
        b=C6/r9eb1bnpcjgp02FeE/TiyNrsoC1rIMczCuCu+Mw/jaLOwvgx4zoZvCeyK8vgkhv
         BY1c+l/R6SS4cO9cBatFU3nv7eZ8ipe3wwEK2hjjmLBpaUjzgVJHJ4SgBHavx14fKS7P
         eVZCoSAaSqipqv2cPwD+obpG3Ry1KhHgoWKfkxz6zr9GSOdSbRjMKOZVt+NiKwZlQiJ2
         eJW4WOEr/ozFyTH5RVOr9l4FdGH+G0JqqDB9hGXxl377LP4/mxuwyh+W27GyIi1MdMgG
         iNgRPuPfXUBpnkkT2YtfDDU6vOCYP6bvLcSfbgJ5Fmx2kcQSs03RU+rZ6l69HFfHNG/E
         XdcQ==
X-Gm-Message-State: AOJu0YxkWW9TIQIFjtDxwl1tjt+afWVvsjD+1rq5tPWn042zZv4K44Jy
	aNVWX2l+ACvrMMgnS1Kcb68cVnJ4NiMtILpYeht4rOhUHhjYJFk=
X-Google-Smtp-Source: AGHT+IHceflrrbWHNuuHWAnJZ3vUJ72+IFydT+slwGntqVWWcnBB81boB1AyeA1oygWfn7UheiutEg==
X-Received: by 2002:a05:6a21:2d8d:b0:1d2:e8f6:fd4 with SMTP id adf61e73a8af0-1d4d4ac8e26mr2627005637.27.1727259198838;
        Wed, 25 Sep 2024 03:13:18 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.137.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c53778sm2473206a12.52.2024.09.25.03.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:13:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bb54c97dcc2b2d4ca80d03127b9b0e9a610929a8.1727255036.git.pabeni@redhat.com>
References:
 <bb54c97dcc2b2d4ca80d03127b9b0e9a610929a8.1727255036.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] tcp: fix mptcp DSS corruption due to large
 pmtu xmit.
Message-ID: <324d9709-e3a1-d017-795f-e6f07b6e8451@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Sep 2024 10:13:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/110300=
27569

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e561300c0d34
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D892715


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
