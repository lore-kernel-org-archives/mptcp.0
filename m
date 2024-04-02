Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA22BB1E
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037746; cv=none; b=p4FikElsonNFq1wJUJMzt7EzU0tAtuOO9V2KRYY3ilrmCiOaOttlc/wu7TJWoIEFl3FCdGFBjTkZWOmZqugcXzQCi2EZZjap+mtcS3PmYlFx6GOuHXoqvZxENmkJ9pmGThYfZAQXJGuOww67ijUiKSeHkszhzaaXkGH3NTB+wsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037746; c=relaxed/simple;
	bh=r/o0l52aXR2RZ6cZIrsPMVOQ4U2ekMxkKDO14KIMsCI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=uweols1r7A4HzZ5i5Tsou8Y5O+xOaUkoDUnv42MtSAG4RzgchJ0pTExePGrsmUP1vXUZ/CEehLbYkZrvO/iFkj3J6J70dFn1id5YejKKXhlaPXgmzMWBlaWAfgKNPiC7Y7txbKXWpx/YRL1DvLQDJrLWcoj6f2Xr7zlcSPlASJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqosWd3f; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqosWd3f"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6990167615aso4412646d6.3
        for <mptcp@lists.linux.dev>; Mon, 01 Apr 2024 23:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712037743; x=1712642543; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WZounyb5sw+7zNlKxgw/ivFHbkNIG6dLsBwkp2OSv8=;
        b=VqosWd3fos2L2sw93LzXD+YtDL23mAexTZuf5kzT9cd5oWDO3dO6TRdr1OKtXZTDkI
         JhQvmnp1s9hz9h/xZF9Fm2ZO2XmC3OKGcRvSNJScA1E8TFH8PXbGPBLIuODxg8VapiaO
         YwGnZupzW2NDYulZD7cYHLQ+9nXp1gFsri83u/aVpVhXBkIshPcmQIykTbdRPxh7lrJY
         RbS6HrYbHkfXaWczSHpX88JOU3sntvcXwNXvIAIa7kDkvqs3y0j/5n2U1sYzad1jeUmx
         ugKxQ8mlYIDNm/lkNCDZFuXPtUSXPPVWO3nluzsTr8cjxA7QR5/cT7gH7qh8v+Lq3Onz
         fQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712037743; x=1712642543;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/WZounyb5sw+7zNlKxgw/ivFHbkNIG6dLsBwkp2OSv8=;
        b=E9KPjxwOrIBG2H8oSmBxIPU+ZGg2v65tTYTXE/Ub33bIGqYgUC5nkxzqXjTr04/pFs
         5U8ZBJgXpN3EPJ4z2yuDwznkpirXIAWZznp8TNzkeFzOg7aW6tWocjkoKxgt/U0hveou
         UVl/GuH1EHHajkXUGizsb1CMonl2GLdMsRTUxPyAk58lDiYBTy28JgOt08OBlnrpk11Q
         1srLxIZFjrnummeDgEYL4u5QcDawFVNU0E+gMfeMK3dA23GLDOq4k5+1vhz9wTAKhTYa
         BDVaFCI1S2F9U0CF9aFr51e/h1oztH5gqkf/gKbg/bO3YisrxCAamlZ7S+fJjhsdivCv
         o+Yg==
X-Gm-Message-State: AOJu0YyxQpNxUv6gBkQkS9h6cuIbLX6YfGjqiF+3P/9f1MeR9OIrCj/k
	0v5z3Hr/mv1u9wqLr7HKvAJRVAAgAaG20jddeA2NDHVQazqSz8yYg6GEu3Q=
X-Google-Smtp-Source: AGHT+IFB/m/Xip5hmFZlXhy7dgu+gnwu3zIQL1EuLpBPyKdJp5Bqs6V0JV5eumXFLcu3EiiE1JUalA==
X-Received: by 2002:ad4:4f14:0:b0:699:1f86:e968 with SMTP id fb20-20020ad44f14000000b006991f86e968mr64683qvb.41.1712037743633;
        Mon, 01 Apr 2024 23:02:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.75.95.97])
        by smtp.gmail.com with ESMTPSA id gf15-20020a056214250f00b00691873a7748sm5206222qvb.128.2024.04.01.23.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 23:02:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712034575.git.tanggeliang@kylinos.cn>
References: <cover.1712034575.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 00/11] refactor mptcp bpf tests
Message-ID: <8c2860db-38cc-b1e0-b216-44239100eb74@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2024 06:02:22 +0000
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
Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/851789=
7416

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3491acfdcacf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D840450


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
