Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE347796
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542423; cv=none; b=Xc1r1AE+wujnUkCm0wtt+IuV6fw/2RiMbqgbhdF8UJT2uO1VKbVjty44mjKbFnLuxJoiudR8iV4AULxVMvcfBYVKjrxhTGVxAaiQ7Zb0XKiN+DwRCxUIu73h4f2GFhH0P8HFDIn2+KI5rzwRBZNN0JwmsKj0mhdwboQ2ic1nKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542423; c=relaxed/simple;
	bh=dEh6Yxa3q9o41/QIQdZEqS+kfDaFYHlUIyUFulyRqfY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nnD218exg/f1LSny8iUkm3x1A4fTcj4bLtPQBdkNSD9hhSOTmpDmq2gfw1HYLWtF/0maGyuExeBMDmnGpecYDknhU48ZOr84ODB7rAxN8LNMgcX3ygenLLQFLxCPBlECslnl8wRYpEaOBkZQ7KOmaORFrImkoqZumM8n9Dhi7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAn0AQdh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAn0AQdh"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-699ac6dbf24so6851027b3.3
        for <mptcp@lists.linux.dev>; Thu, 05 Sep 2024 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725542421; x=1726147221; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tP8YYHF94aXYclOKU4lCFQx6ILaxHqPRsCfqziBz10=;
        b=TAn0AQdhI1WRbgiP9GryXR4ynepKJFUvv8gO+swfT1No2N4WQs2hhJvSJytXcEwZiq
         LCLO/KGTxfR0EnR1rW5k0+pnKKXpehsv7qD1uaAqdhAYC4U8BsmI/UO784Xl/ITlq5FX
         Vlx27PxlEPtfU2/tz7KbvTMqsnDUVnKNkjUGti2+yfNCPvSQxbgn/f/LnKSmiU3hWVBm
         CUlt/v5EiXsQBiTO9x20/oh3vhqsqf2bW62HrMyXFNZ63YbWFfiJLQda80/HpcYnt/7d
         5pOmWJduQsUj7qlfoFSR/Jca1K/emxjIir+NoUJqEBlmGvUNBRTcj1abxD1Qy1NNTyOu
         WT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542421; x=1726147221;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tP8YYHF94aXYclOKU4lCFQx6ILaxHqPRsCfqziBz10=;
        b=gXgDO4EycPP+4O/SrwBvKRQfDuMpVaXRNg0aN/cq/3j7nETlVixyswZS4kzn+2ZGi5
         gRxGLLCQAnu8gvWyCgRyDCjsNIv28FI3UOF0LyAAE9j0de8dYFtWabW8j60uBHPnRr7C
         N1mgXPpyb2jVribCJF7kikSALnTwJqt4hyt7d0VNxzNZ9VW8Lgesj6eptt/rd4CCX0hL
         iYhIHfWVlm76mBy6jx0VNvhhLMcoLDA+7tdXGxbbb9+waCOARPtz7+C4juBXo/5zQVc1
         frFCBdFoh4cEIrk5iXJeiVVqJRd3jK5DtIeICFb1BoRcrw5yYf/gzbqTNC/lufhnWTZt
         0/KA==
X-Gm-Message-State: AOJu0YydpYr7y/IlhlJjgl+FYaqj66vtCXQAGZ+Dq/GBIAmKUE9cFwiw
	H8U+FXzOvdETnE92vg6TDEdZMhVPl9pkxQF6B5qHTeCWFpXrABM=
X-Google-Smtp-Source: AGHT+IHyQ4+rfzAEnCy+slRt4i9ey9/K/iIUwPiB2y6tSpyL1J8S56U4yC2RGPsF/p4YjtlK3EWvDw==
X-Received: by 2002:a05:690c:60c6:b0:64b:5cc7:bcbc with SMTP id 00721157ae682-6d40f7224c3mr263088377b3.32.1725542420937;
        Thu, 05 Sep 2024 06:20:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.161.205])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d3c1588527sm25405917b3.65.2024.09.05.06.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:20:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
References: <tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
Subject: Re: [PATCH net v3] mptcp: pm: Fix uaf in __timer_delete_sync
Message-ID: <e669d90d-7779-08b6-57b9-9907231ae61b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Sep 2024 13:20:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Edward,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Script error! =
=E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10720554167

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a896db33c525
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D887227


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
