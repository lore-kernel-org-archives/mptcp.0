Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1A1A76C8
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680406; cv=none; b=O4/t2ByS/4JZASC6TZn3mpmn5iahIlEISLa1L2KssdKJ6hpkD5q7UfKxMJECHSH7mbrgUE9Yj/7l+5ZMcgWUjf16lZHNiUpccRL1RVdsLDyhx4IyjnJ3JPCXZ4i+8KN3AwmEeWorJI79gKdAIc026r9BRz+H1OuD2Y7L0W88qkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680406; c=relaxed/simple;
	bh=UC6QrgulNGfb1l0jGD5xUMHdZgMo6vpM2LjQgZ0tiqI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=neXEVPUpkMXztiZai3+XNeEgBLBuuL99aootFzfHuTDGHI0lWStO5/k7ys3qr1IxQ/BEp+qzo13WLZw2wtqtHclyyfraBFq65Z5QIiIoybXnACEFVIcy5SwdMpPfOEFVOLvQHcalX2P+YS/bsPW0ZNaYGldxbr95yco0p86oGdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGUO8POZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGUO8POZ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4609d75e2f8so5852121cf.1
        for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729680404; x=1730285204; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYo6oduLlf3Cy2B296+PVAcwmVQwAZURdPv7RR0BjkQ=;
        b=kGUO8POZQhRnDBQlK5MXu6xMaOBiVeqGYNxh2CvrdLD2CMleqXmHz8fahTG5d1mXXM
         ZJ33rUNNirEdAjTqGq3vRZfrI2TY8tOPWV/heLy5iRwuntZsS2czxXD6tvpo3S30L/5l
         5nfZ23UHU6s2jn4/XT8/wUE2qr5NsbKVDveWt6a89PJLV1y1ge1DisSYloz3XMkeOSG9
         i8lAEp4O+0P3JJlmxlK7K+OcdAr0zKXh8oWzvf8/zvtc47QHD3uhZo8Y+vNpnuyHsuda
         /TFVu8C5hD8O9NtDcqld0dXYW71kUPx4IhXpYsAAD81H+LT64HKOczW5fQLq8U0PFMEW
         rUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729680404; x=1730285204;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fYo6oduLlf3Cy2B296+PVAcwmVQwAZURdPv7RR0BjkQ=;
        b=cRUaj9D+6mA0qCn4UeYSFBEq5Hv9VZOtXJkC1H//LvzN7qmYTFKla0o3iwW/34SoRq
         UifzgukfgCCQBNS5NAAS7HijderqhzU3jNVPFfGOF4q9nYnF/pC9pZJtddLNVFXTFwW/
         67aPnSIMfxX/uADrzR73Xa76N+8sBruooLagIvY10BcG8ysvVa9UkeyUo91LKMnWbHdR
         6BVqVG8l8Ms+j+kf/2icj9xkDuLJz0jSOrG7Xzrh4toXiW/4Utb8Ib7krWibypfjH5GR
         XseVjya5AHhJwyHplZUCoFe2OpDc122n4aXnfcD3Ew4osnUjNH1W+kTOymsAqcyvhKyz
         rdTA==
X-Gm-Message-State: AOJu0YyTrb+sk6EJcH8lrkx0G8F6PVVnNQ4MaflwNcnOllRYNilqFoxJ
	vkyzz+5XVpbK6+LGGCKoGk3VQ0eqDowzVcFn3BsRKSJ7k2uuEiHzrxzzmzw=
X-Google-Smtp-Source: AGHT+IGn8PAQGOShEKfR68xmnWa9QsnSkySw8gaJemQVioL02efEJSrz19Qut+yjVtJ7MqK7CQpY/w==
X-Received: by 2002:a05:622a:5a0f:b0:460:d10d:aab7 with SMTP id d75a77b69052e-4611411ce6cmr37983041cf.28.1729680403716;
        Wed, 23 Oct 2024 03:46:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.147.206])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d69448sm39054471cf.65.2024.10.23.03.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:46:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729676320.git.tanggeliang@kylinos.cn>
References: <cover.1729676320.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 00/13] use bpf_iter in bpf schedulers
Message-ID: <3fa75887-01d7-4a3e-8e88-55c473938ff4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Oct 2024 10:46:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 2 failed test(s): =
packetdrill_regressions selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/114774=
58493

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/71b79d10031a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D902168


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
