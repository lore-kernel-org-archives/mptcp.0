Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F23C1F
	for <mptcp@lists.linux.dev>; Sat, 18 Apr 2026 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776475308; cv=none; b=PxGGJRRoqDvMaQy/kkXomD2tiCdGw5rZhqPltrcylmsEZViz7rgaJ5jyqGG15p7Vyv0l3shHG4O+rOOF/u9dfgzWcpCBMJQEcfqhGr6x/qXIHT61XBmGbqr5oS5CgLo/cIkc+cEEwxpzEJPpHzUoVd5JSsGkg116qZ2Mnl2L46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776475308; c=relaxed/simple;
	bh=WRw7xRsbOJwK1Z/+a0Jgol3dvMhfhfOXYiDq4vKf/pM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=AP+RMaaV+gCfiDt8X3gewhwIvpoZ2mF1L1Q70aL1Xd7FGlzKWEY+UjeZT+mBFRr/kDzu0AlZgaCgygvKab8DN3+7grWFkkUeuMGTvUEqS8CK+SDjpFnxlor91wtB6b3ayYL/3ZHxczo8Vn7SQECAKKsNQz1OeuGzuExitQpvwAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZA7x++S; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZA7x++S"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8aca4e14411so15503496d6.3
        for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 18:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776475306; x=1777080106; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WaJM35hNRCycXQ1J1OstKdyPjWSxZHTtVDfuDk7Ugc=;
        b=gZA7x++SX3t792B/bjak+G/da+HKm5EAPt7iYdrZlr5tgzsvM2LrMpwhBMeX7PFwPX
         jpyFFS9kWBp1SdZXA1F73LQiXm/iCwJ0/tK/sxLHsdlcnGVgL+OxD8r7mKw1yLIy+zDi
         RP6VJnmfoh93AiGhQIXWPMh8ijwiVdcDX4EwH3b2205zyt8NlDQGlBjIBlwH77L1hjE6
         /ckiuv2+UYQCzHYzkl6lpTvDnXV0aJpl20cuu0V4DS7P0vcUYAbRQg5myUtAw5d5m2cp
         X24AI6Vt73q1yF6CW3PI64zOgw7qWOrvGKepoEUTwwwT/kVyU+erp9SUFoB8i8PmdVIy
         ub7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776475306; x=1777080106;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WaJM35hNRCycXQ1J1OstKdyPjWSxZHTtVDfuDk7Ugc=;
        b=Ju+Ac0Ii4EFC5HE0BL+mxwh/meavz0lCi88XO3n7mk4wd1xNJzd2Jyr8zU7k8CDDtz
         KSQ5WhNghXTljgOP+12xKp3ykZ5VqDGLZ2owJfJDeJmcup+yA6v0D535JgSCImRfKPvx
         2CBQZANXUvrD8G9sTSwyw5qWYCRjRi9tvVdJr37ltGB/WJYd79fw0Hej2ZyauGA0y823
         7Fney79t8U5WVQ5xMZ4B2NS3HrimK6wMMPZ0hDxxFH9w7XLASkJNDTsOxvfyUlio49MR
         Dp6AOrObnuTxpH1qHSc3iQrvDBuLGMPnBHH23/rJqXymx+q6pkOExYFukPQsfXgXYh1i
         y7/A==
X-Gm-Message-State: AOJu0YzLZlY/vh1Eor5qvRD8E8zKr/z5nhlDBi9hchUGX7gGCr7hsVRi
	q3WDONokvZoAeEm4cQMk2Gxfve27RjBRZ48UiB91kitSdISmKlQbKjsWwoU+
X-Gm-Gg: AeBDieszJCIA0YlWUEIBRuhmveReXatV0zSNGgOs8PNe0EkNHnw4D3lrXj9Y2ULr3M8
	hihllIGoZcNEvwCVWLZKesCh9s4dvKYZUw9bb0vStHBGQKUvCtzqGvlVhf8w7VU7L7k6OHs0NAq
	xQ6MHqN1i9LFBvqanIDd51V5jC7YPt9Wg7505aGTnbpl5eZadenlOhoC9edEk7gA/tddfiYNuNz
	XZNHwC3aKCWgvLNyZNKXmoecTmWcBfl7f2e85rmjwCFLy4I9rzFmbZ8lt1pLlDfvUKoajXtqyC+
	0T+tyfj03yJ8UZrwG6Td1y6FDqXLTLxvqD9gk3ZISf1RkiycbPWlNAeJksahjwYLi1gsrxIjve2
	wGnjKuB3dkCsVHbKvnZXs6tLmqbErSB4zq+S5nnNxA62/+Df26Kpr/8sGR1/rKIMoJ89coEX0t5
	r+RSPfLhyHJMl1ZGTFe2DCZ7BnEc7uwora+h0bBUIfDUZdBByx
X-Received: by 2002:a05:6214:459d:b0:899:f0b1:7332 with SMTP id 6a1803df08f44-8b0280d6c95mr87492176d6.32.1776475306478;
        Fri, 17 Apr 2026 18:21:46 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.142.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aea639fsm22087566d6.45.2026.04.17.18.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 18:21:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1776469068.git.tanggeliang@kylinos.cn>
References: <cover.1776469068.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v15 00/15] MPTCP KTLS support
Message-ID: <74546542-f95d-c44c-9c95-082d21c50c34@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 01:21:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/245921=
08878

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/eddd9cab992c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1082710


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
