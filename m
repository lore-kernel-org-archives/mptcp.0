Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102139D6DA
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307669; cv=none; b=RA32utpeqfUpgyJwhKqjMWJ+9IZd0/YkgTIsCVIHC+pk7ilgIDAn7TB9WlYKc+lO0Bhk4EDI20PrnlROs+N5gscan4zy3OKezLbkKwCO3TWXfAr+RoQ6JAzCyfUi83QRWDq6JmPYSZMmzZumfXpimwZZo/XE0oXxxCIxKI1L5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307669; c=relaxed/simple;
	bh=EfamwsU1FmGnIL1rCQsYIEw3cp0Z/rLsMiSaRsICmN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=nU7IjH0XUMjGykol3kldjTTyH9qznoakzVTIrAA45p081D4i4PhnK6EHUp+IdcCdO6ZF6pwLLb9NrhI9CwCSVWNBPVwaWGjRd2rwBREzz9jeW/CtyxR574CImC6HwgBUBSYdQsGE7FwkKh8Q6jq0s2CDmHSBcH1WRHrEzlAc7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcXRQUuR; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcXRQUuR"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso4947582eec.0
        for <mptcp@lists.linux.dev>; Mon, 01 Jun 2026 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780307656; x=1780912456; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unHE869nyr54gHUZAHLRklsyk4hCGzsZh+nD789HjZk=;
        b=FcXRQUuR45sEmaGh0y2pPQl2ZXwH9MZl+NTlE5xyENs5bj6FGi9xJTncCM0eV8doV/
         POBHmWh4eihc2nkc+7i+0ik5KFDqN/DqK7aL/S8/ANoShMq6gytkrdf540fSv1f6jG0w
         39syslHSLuR4AvKoQnYa84C48rfBP1BJAONH2AGpqmfxVlGNQ/ZYbQonMZH28m9verG0
         Lt0qbbPqj+zTa7uMQmO+XNkcY7RDChOqKE9MpgAxPZT3sa5lrwAZzGDhklU1/I7pHn3n
         OXHI3wU96N0PTGSGkZyXh8QxY+TjaOoESR0TP56bcETw3b9D7dq14epIWmqaeQ3jcJm6
         IyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307656; x=1780912456;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unHE869nyr54gHUZAHLRklsyk4hCGzsZh+nD789HjZk=;
        b=plMCsA9DojY3auHiI3RUwIabS8Jr8pU+W9UzZV1Fug7iTOsf4F4ShscoswQipOKg4m
         TtmHFW7mQce7yrvFwFBXBqUuEw5cl3pSc0KW62JkeEMw7JhGS+gk+TANF8lU73UWklVh
         rWFYLn8xLZVCScBwgUEGsY1oGIQhTYqj3g2QhNdkzZ/IDvOnGvKZL55IULyn9mXmBpzm
         UKG5pIZtKVUTsOzRK8BVN6hlgl5BxDGZmW83rYdG5uvBZSdcOWbF3XuWyTUdUIOsP2Rg
         PTdqb1ulh0GsWxlSTE72GPUePRBIhg3Nh/QinOEUflVs8/zJxKABl07abwBuV3C9W2Va
         CD+Q==
X-Gm-Message-State: AOJu0Yz0y+FHDN+r6iPTIOiRJbiimwaWftCLQvqTIrdg5t9s2bSBf165
	1ppfuuRSR627J/nSXbGDLHLSGplYFpYK51NC3zbQ1k7iE3b3E18SvdU=
X-Gm-Gg: Acq92OFsrP5wlviQVtPT3ftIe+4iZYlgpX1LT37BKRFyflSfJQlRHCykPaWXd3jU6qh
	AgLOrmQmA18Ed6egiYOYJrh9OQxbhbVne3Sr9+XwqpwwbqGmT/02CIBKYvSM9ZvwH4Tmgdvydlr
	okX6HoHgGMnX7+f+6YQwvCVsROIMwLokUvkGR6wYBaJvNUkqB+dhfwHeVLdSLt28RIKv+xaKdud
	pNLd2jBfkPAmoJJZcZ/1LI8eeONDpfAXN6Vpe8KHI5ZrJQVFGlJzCpGsQgULClPHBjmNvILni9y
	twUJ+lWNhKoIqL5rrz0U7Mxht365/Qx56XnzD9v0tTcI8LMRvhCMaoIaPnZX/EpXHu96P90bxtl
	k7n/hGJM7L18Teapa+MZefnPCP10DxvZ7fCRWzlrWr/YGLOiTnVl+9Vet+W73B5TNscCsA8ABz7
	VvDJYopsOsKlC7ZBz3C0AhrbciGT06qghLDVzblFeO83fEo1Tj
X-Received: by 2002:a05:7301:1293:b0:304:d14b:b706 with SMTP id 5a478bee46e88-304fa751469mr4198231eec.27.1780307656277;
        Mon, 01 Jun 2026 02:54:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.239.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c154fsm7673658eec.3.2026.06.01.02.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:54:15 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
References:
 <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/4=5D_Fixes_f?=
 =?UTF-8?Q?or_=22mptcp=3A_pm=3A_drop_TCP_TS_with_AD?=
 =?UTF-8?Q?D=5FADDRv6_+_port=22?=
Message-ID: <168dc48e-8eff-5a05-879f-f17fba612127@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:54:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): selftest_mptcp_connect selftest_mptcp_connect_checksum =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/26744856498

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1e1fdfa4d98f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1103837


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
