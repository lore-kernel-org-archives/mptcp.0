Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F448165A
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111131; cv=none; b=IpVvo6AD/klNNy/HdgtwsmKn1rixe5pJ/EKWBXMIbAOS/qdP3Ej3Vae0+H5sP2vSTIxf80iIxpzvH7gml/d0lBUXE8KaMn36NSwgYE1KAbTPmE6YsLWs4i+OxaS2f3pZDkxSatp8uzlpXLpLCFNvU/LSmOmtXywQyeP6Qo5OYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111131; c=relaxed/simple;
	bh=COW+22TthhlPDGpeGkfLjtIh7LlmyTYk4BpVT1cWriw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Bu9r5GgzSLhx+VkFz6R4cnPaBxp86GRYEdFMcB2ygs5RC8XY5bBGKP9DWNg4mTSHzLDU0+QSSCcYObcxHcJ+VQzYiovsKfpVFPtzmacy7DeYYLwxTjz8iBLSI8EAnUNgnXHTPw7nXREW6LcZ9VUrXqcI1wY0PIyURDIGKBrjWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8QpzX4s; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8QpzX4s"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65dd9b25829so1754644d50.3
        for <mptcp@lists.linux.dev>; Mon, 18 May 2026 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779111129; x=1779715929; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lepqeg95Z7rOFcEbMPVir3ofJLxzRc929WMKGQlq8AA=;
        b=K8QpzX4sh3dFNV/EXC7SAHaMktL8By3hPWHCEyhD3y+oWLjHLYlpnLmfawCzdbmVuv
         RjC711OCedb15da1zjLb/iVofYFnmaNnLoR4b79cBLIWxg80BxBTSY53OBSu58wQb+sD
         Zjuoff4R2aDdcLL/HRcqsfPIwrv8BnOdk8gvOCTTuJ1TA9lhrLLn1hIFZ/KxIHfCiZeJ
         OSCZgqcxnKohI/SKrY95i2zXjZ7gqmUmK0210HzxFqk+CzcHtWdtHwFDh/Q1cIm/sDAB
         vdz/d5u41PGGIBQOW79Qw9jmUTYTfIVM8HzqtvNOzJCVJSJnRDQBIG/fWNCgam9Fl0LJ
         nk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111129; x=1779715929;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lepqeg95Z7rOFcEbMPVir3ofJLxzRc929WMKGQlq8AA=;
        b=ZqJzP/0eDkkzhDTu4gVNAhuG8OKjzcyoFaRFJo85/Me90wXkGhdiRydmT4Wk06oa9E
         ke3D1xJ9iGg1tIrEPSvKeb6tt75qzMvso6hRGYs2PHkDSBEJTCRkD/mNsEcQJBRS7ztt
         gWqUfzudgHWBeZBYeragPOIpMYX0LvJ8tjesQy/bIuDnbNJld7xS/Avc6yiDjZtuLOHI
         wx+hDhfkeqiRijpiOU+SD081jZxaelsKD7ibFTyUdyAEkdnSLShEyobNDcFp5imPOEH0
         FZVCHYM/r5hbZzMeEy8fVB+FsHOusdpG55RqhATQeKVSht6o0BuhCqqBeKKUfGblS+e8
         6agQ==
X-Gm-Message-State: AOJu0Yx9WoHyE7J9nEabIFoN48ZPx2zJ2AopFZXxq35tKOog5GWfKmP/
	tD47MHjo0vtVzf1uUROSbacii4pdn52BUape0o3k4og/3x9l3FnpfBaIjgYK
X-Gm-Gg: Acq92OG0XbP0q0V9Fm/0Tr+kO2s6VPg8uQtr82F9aKPdlpXbCUS+vCuaib8fhIfcBtK
	vREiJi+gJ9FTAPHqq0xPzEJlKxB0PTkXb6r+HTES2jhkyEVBakjMGXyc+ZZ3o/wVp0s10WxA83+
	DJ6iOYFT5CbaW88URw7xAwVnWwr0tBsfoFTaMpkNz1pc4kBSktEH1xNWl7mO6QCSGgbfQ7/Vgw8
	OoHc0tMjhxJDK1OUYLtY3tAs5LYCskV+kSYITepBdYr7SiXSlc7SKNnVTedMK4OaAQ4sip6f/8Y
	6InG+51ULAJl3moyouKDKAErcfQ1uYkIxzx7zmxf+IAaM86DKl69fxvqha1rMZH0blC7Afs8KOb
	V5tgB790o5vCPSP2KOTbPX0adlj1zVcbcLLCFN9gSUvzqgV+lR7DA+KpIahOiyxx2CblrnaUtAL
	M+jhPhDM/5rgIcQK6akSIOckIaipjWrM7g7A7XCjI=
X-Received: by 2002:a05:690e:134c:b0:65c:22f9:859e with SMTP id 956f58d0204a3-65e2283c7f1mr16227123d50.53.1779111128483;
        Mon, 18 May 2026 06:32:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.135.244])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e7585sm6413906d50.9.2026.05.18.06.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:32:07 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779104752.git.tanggeliang@kylinos.cn>
References: <cover.1779104752.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v13 00/12] NVME over MPTCP
Message-ID: <9430a24f-46d2-3d6c-ba9a-d8d2ff36b5bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 13:32:06 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss selftest_mptcp_connect_splice =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/26033547186

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e10c1e53398c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1096571


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
