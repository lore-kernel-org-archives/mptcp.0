Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C372C0F6D
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165124; cv=none; b=BVvPf6lUjrsJBDfFLv1g1/N1d7ZJLszlj9Q8t4WSKMUJ+9UIX7xW3a8Gm3df4yyOuyc+fO7UHojyXJ568oQ7NpN/qIhdxv2bIRAEcl4iNXIATCCMdwE77/MUugbH5tUBQ+00uQdiNLRZ7ldXmj9vybSJxp6zTJyz2fzO3MWrUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165124; c=relaxed/simple;
	bh=o9ui0DwZCxVWohH1v8FDc05x8E2IwMarRkBhQSLqeqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=hOcMLxFO+tbOfUQP5JTNSaXxXQgRbWxvAxreBXTXF6ySfJECs+Yltb3ZEaT7eJmKYbao3x63GgxJN+ycxXPb9TeAZlhVTvyqrOH/EHiNdONASgZBLe3hs9GLeeu7rVzc31kgvXHK3uv4ceLZf8ebXdTG2xgtpslRUuFaOCuqIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHzdfIAb; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHzdfIAb"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13809223fd4so7541810c88.1
        for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 01:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781165122; x=1781769922; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFnOMJvMePwq2CJMBPsoaUbMwjIQlR//yWip/GWngMg=;
        b=EHzdfIAbIfJF53+L9SVRrNoLRkhOF9x8YDRbjOIz42/qY93eVs40h9X2DFq++9OI9E
         +Z+fGD52kaSd49kALBEhnRVuXXxmyOi56TRSJZNZUEcllSs4nsHmnQyTP+gUcWSawnNU
         +fC+W9uQn/HReuPPahIVdXjVFFcJz5sg2ZTuEUfjdkhvzUxSUTeTPntPlW+2URE/NnW4
         eQLOpMDpe4A3xt1rLPix//lz6bDxoyfEXVXPliGasZoYXjDK23XxuBlz7IUfZJVGw2OH
         UXjKvNoBAqnaxylf5cBGwhg/I68/YynAirVstpcAMSGd5ymT7+0Q0SYFDwcwu6Ke0VO+
         H3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781165122; x=1781769922;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFnOMJvMePwq2CJMBPsoaUbMwjIQlR//yWip/GWngMg=;
        b=SpGMgzmzpawDTpLcyO3s5MKSUujtt2HbekNfvsceSRX88umC2BcJ90AO9m0D2YpCmU
         Y0Nz9n0GKbGngxbFA8vZfIQ+35eMorzwGpUYccyNGHtKjl9//exf8SLDxVkoEJY2NSf5
         MrzEwH3GsKOQIpLwFWvkLFz6z4tx+hfLxYM8DC+vZKnmKPEX1Ots1MIB0DGKJnwYjLOc
         6HZ6C47Q4gH8ycKlqIF6FyK8TlgJfvcY92zOPxFLv+5MoQ2kqK9LblCtJFbH2LB73pdn
         K+M8tzMIAcxwV8cYaKyrp9BCleYRTri/iDm6fY4MiGpNrYmFKnaaUKp37Bmo0d+5Sz/f
         svwQ==
X-Gm-Message-State: AOJu0YyPqN1bS29J7XIU5cSwHCP5//21/0cma2hoCD8plXuTz0Oay/cu
	HXpNgVh3/0ieDj9NkR4MC1ZVDkktnyncqCaQ3O6nZOsovm+fdIG827B+10W3
X-Gm-Gg: Acq92OEVFPmDC/j2lp3QxaWABgQ9xrRDbGD7eCK+ckPew37IeHWdA4377L5pEEQSo2E
	KN5z58b2ZTJN0FKoicj/x+dw5LAhC5MfFZtsV9HUhCNYy14EWjGr+WK/APXWPlXPoSNxXsldXSD
	mY6w4XnwIN5utu5RnkBj5BRo2P5ZQYwTJ8Afd6b73/tz3UmYEy+VDACylKj2Na2ZPZCJPoXbGXg
	tjRaVsIeb8EMKf2IHY5lMDyu85zQ3mEgPH0jW9FIY/HekNzqXSujLD0J8ze3ogk/LiUk9IGTlBL
	t1SEBZs5baOxzhI+7GOZFyAKryuOxkMLrpc8BFED3E+xssFZtpD6CFU0YuJlwbjJdcHRi8Tywgi
	OrV8cOfbuosLCiosZBrSEMW3j1I0E6AfW6quH88FuqvzUZWp++idqsocFwC7DQxWhu/6zsx/7PE
	fK6jvrxJlLl9ONwhiZo5fiune36UVl4OfIYyg9AEHOBFUFoYU=
X-Received: by 2002:a05:7022:ec8a:b0:136:ff02:d00b with SMTP id a92af1059eb24-138422e12d7mr1039038c88.25.1781165122034;
        Thu, 11 Jun 2026 01:05:22 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.201.83])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138430452a2sm1111108c88.14.2026.06.11.01.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:05:21 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260611064937.422416-1-kalpan.jani@mpiricsoftware.com>
References: <20260611064937.422416-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: use configured TCP RTO min/max
 values
Message-ID: <2598445e-e29c-e7aa-2fae-cdc0df1b5bf2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 08:05:21 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/273304=
00492

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b86218ed0f1d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1109791


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
