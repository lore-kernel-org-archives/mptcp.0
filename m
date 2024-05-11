Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1454FB8
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715427277; cv=none; b=Go6Uabo1mdW6UMUQHI5FYrWX/6lnsKn5EDtMgkiZ06zL3NewzyqK2CKVkx1djN15rhvgQVGHIv/z57xTSkf0JXyslxkGgoX11GUBCRXAAfDrF2zrszORloF7RTArHyfmGpItZC0s0gLVcHARWx6ttWkXaKOdjsxHd7nleGaBhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715427277; c=relaxed/simple;
	bh=kuEFg/XsZT1yEMoQjONw9E8fCg4onEe9uL0TwNAsIOA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dQwEykffi5Bp0J9SPMeH1+E9+qE4XfBq409f2hpS5aNmaiyzeCkCgTtIs1qT9C4lkefDcggj2kGTJqFUI0KXUPGK2FwPwa9dwdsu8myeOsv9gh2H4RB1UTmEKdp9Sm4OuBSx2+7BQunPTmA6cVh5ZNRa5Q9DHkRF7D1ndKR2Kq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJbqut39; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJbqut39"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c996526c69so1414684b6e.1
        for <mptcp@lists.linux.dev>; Sat, 11 May 2024 04:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715427259; x=1716032059; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTB7DDXX5eIc0Quj7KB4Ebk6n7Xr5mlLSvBIbzOKexs=;
        b=ZJbqut39QEyIa6WuaU7RbOuHyqPNzrGioe0hl+4aJz1kYEH7M4qoYwSjq7eZke/nFX
         TDbVul4ZYWrhy+wV4qDVmrPNlvRNHovJP7jm5FhEN1Xlf2c5L5txdTvyXiWpaK6Mo1oR
         YwmD3s3coJPc1YF2kCTI9aLO/IroJJfRiXF21pGV+/1pgj1zZyEphMO5XoR2azTgZvLF
         zjwoiUoUstnHPGnZHSUJ28hNQL5BoOzezGldnPDALXJ0I2dv5rwH/lLMRAItmZJowJsc
         73+kQAAvR8O+L7fTKk/fW1OjkLTpe9+/nYShFtfd2H6oJqbhdQg+TrYzyh/piFHXZtKZ
         krPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715427259; x=1716032059;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTB7DDXX5eIc0Quj7KB4Ebk6n7Xr5mlLSvBIbzOKexs=;
        b=KNACkZnCtJJgH+Sx510SIKD8SCeW3o3EfIv9guC8fpUIYW0OePAdxw2e5FvnIF9x+a
         LWQHFrLRBacO2if+WuU8Ir1ZY8UoFzHpXpddZ7itITHoOL0oUSOra3X5y98q3DuMaiK0
         o2opju5wT2ahXgKaayETK/Bw4WitxjcNvgs4fyOGcH6IZcXfckPthfBcJ4QjG50tar3U
         383fcY0BZXmCsdTYrG/znzW93OYAl9+Aqx3XAeUglBad3Cfx8qkO7AYbrC5uZB6Hb7Ys
         KoUltLpwif1aPBrtneVLfonchst4soIS6two4ImsLCQOLo3KdZC3Iwyv4fpsEb7yH5al
         afpw==
X-Gm-Message-State: AOJu0Yww82wuQShhuyHfQvlG6vpzrf3oVcclKXMKClzRrJOEJnpomk+p
	+tBgUL6QjzB05DNTQNSgS8OGlDKp5uWxILtVztyP2VA07xngtZ0+vG8RxzA=
X-Google-Smtp-Source: AGHT+IGNSv9IEGJmW7BDaY5kIOx7nw9J6zouyPm0BEp0kUaMNzINeGNGJe+Y5RCJe56GgeOORSRYTw==
X-Received: by 2002:aca:2412:0:b0:3c9:6d44:8210 with SMTP id 5614622812f47-3c99704c46amr5465285b6e.17.1715427259330;
        Sat, 11 May 2024 04:34:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.76.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f185520sm26082726d6.37.2024.05.11.04.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 04:34:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <48d243a507dc8b48932df4995ff98e5ec056e733.1715424100.git.tanggeliang@kylinos.cn>
References:
 <48d243a507dc8b48932df4995ff98e5ec056e733.1715424100.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_mptcp_subflow_su?= =?UTF-8?Q?btest=22?=
Message-ID: <b77982f9-aba0-9fb4-abfe-4f11a747ea0a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 May 2024 11:34:18 +0000
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
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9043165180

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/925c86d2d498
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D852516


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
