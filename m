Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74F55E73
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240068; cv=none; b=cIz+VbGCLmfwCxGsIJaPsdf+KL6TgT26aHOIxKosVVMvUwwy/ywbOwLMyyYmb+iGRmvQNq5JIpjGyhnWVaTL3Mhg04VuAj7NoUF6Yjx6Df69jluq1il/vrbXj/4d/tfT1976Sty39+E5JRq52IgRWCKdK5RLgXpoQgq9TbL2CB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240068; c=relaxed/simple;
	bh=7oMpyBap5BGaxlEeIscPCgcO10pyAH2OEPS31HDLvy4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OAkrqcUbL4o3OAZq5tYdt22y9m/2cHcbT+cA58EiEHJd6nWfazmocOov2n6kgFJL3iIAvvl88hkmAdyREz7lAJIvBXbPpQ1LDbLS9rR6Qwbr0Mc2ap9gZv+LcMuad6rOaprnTidh5W4Uty2qtII2jUi3xv0vH7Mb3A0h7KDXn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cno8ENks; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cno8ENks"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690cd7f83cdso14348466d6.3
        for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710240066; x=1710844866; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgG+9QRp2FliohrBfOEXxpRp2xOgpLuz4DajcxY9q7Y=;
        b=cno8ENksu52Q16tDoHMwYdsG5DnqwqGHJZeZl21RR0knFdBRWa7I5H3Y09h0WpYQ4t
         NFyW8l874ecVaYOuqqcpl+PRCjduVT3ApwelWbJTJmzSVyxQ2BzHBKyxZOyTHHPatM0C
         KzUiWPx6wsLyNBxaSW6aQxFUJ6T/0P/eJOHdqSF4f4uFFzMd+YESDnFWBX2Kw69L1EQn
         ya4+G4v+PYZomTlTVmv0VWpM350rDrRRHqRKTKQuvVzB+BipCNf0KdEC6Ls5HFdTp04k
         Gs2m4quot4Dq65i4T3V2OD9op/2hz50RC2iZMSXBCFfDXxvtmDfOos9LyTgtgqiOv4LZ
         oiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710240066; x=1710844866;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgG+9QRp2FliohrBfOEXxpRp2xOgpLuz4DajcxY9q7Y=;
        b=pZyRWxn4CAdoJJ4qt1arky8PrLykronLptCfL7ZG964GZex5nrSz9aqfxZhXinUGVa
         +FGMc+dgEQg3Ujvb/AT3/+G2kkvswhohwqGCjuzrtnx3zDFJegPUWw1GyruXsZpG3Cyl
         WxzeAd4in+boRpmk+kmmYBgkw/J5K1RAHsLauG4H2c8868ixKJ+JLEzlbGb+sqj7jhpX
         2worX3FocWA9ulIkFZOBYEuDe5gGELjO5tcUunaxvvG2RLfpVuBBRCDU/nauBxLLo7MF
         8VMn45r+J9G/YitH68c3JxSVZPCg++iaT2W+BrH8S8MPccSx4P0iJ4J4pJwF1RVfnks+
         2krQ==
X-Gm-Message-State: AOJu0YyEymnoWMlDLZxV7BHNOKxWkRKt7tfabSqpIcBA3OwZD00TqhwJ
	XdzlKv9X65S7MuALjppP6M7hvSwDTgXWtM5rYZmLj5GAAJ5/6zsuKns1vM8=
X-Google-Smtp-Source: AGHT+IE7Rt80yphfT4TRi2U2win1UyyNlZx/f8optHRL2MSSJnXYWrPjQi9ivM7qvs8tOM7bEcI4kg==
X-Received: by 2002:a05:6214:227:b0:690:dc3f:4fac with SMTP id j7-20020a056214022700b00690dc3f4facmr2956550qvt.9.1710240066309;
        Tue, 12 Mar 2024 03:41:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.123.38.50])
        by smtp.gmail.com with ESMTPSA id u15-20020a0562140b0f00b00690796f7f3fsm3532193qvj.28.2024.03.12.03.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:41:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5f63fbcf13323d8cf293f42849673093d1bf45b.1710179839.git.dcaratti@redhat.co>
References:
 <5f63fbcf13323d8cf293f42849673093d1bf45b.1710179839.git.dcaratti@redhat.co>
Subject: Re: mptcp: don't account accept() of non-MPC client as fallback to
 TCP
Message-ID: <bc085c36-8a43-de77-d9de-0e324d507448@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Mar 2024 10:41:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/824664=
4363

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/996284bfbb50
Patchwork:=20


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
