Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E898296BB7
	for <mptcp@lists.linux.dev>; Wed, 14 Jan 2026 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361608; cv=none; b=F0fg4NJqgXPXN8DwZjbw+ffneUD3WUbPWD7bVOXRzaFykQi4x67ZzRs1yDAAmSltV3EFjTzjkUDEZ8EkJfkbCrJwsH/ZBJee91SJLWKODOdel5Hg6t6GITowIGkTOA8O2r6VUQ6CTqw2HwrVDsjRFJSg1TOMicuQGyN9w7s+vMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361608; c=relaxed/simple;
	bh=XMTLPA4F+EVHRdXFj/CiefvMTHL+4KP8gKEyOmKOwCc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jk4yRQ91brwWm8J3rvebOggbXxaL9otWFUxjr/Z5TIemxS8guwdmcArVIFgPOi0QYUKBFL5Pak1blD5gsFOiR96ZBpt1rZbMGaLq4pLShVA+5n8DGulTC52nj2mNwyqLp7pjy2Esu6A9Iccuck9TEWR/i2FoKCo7MtdkMBWCq6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9kxaC2X; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9kxaC2X"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8887f43b224so132515176d6.1
        for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 19:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768361606; x=1768966406; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNuoHqZoMgzHCnwfxlSsc34qYgQjLlix55tfQJuBzi4=;
        b=L9kxaC2XWsbvrmL65IhIBa7KEPaGD2fGnie+6D2Lk+byWAeefO9JaRDOYH4nmEPo1h
         mZuwFoAfVWKcTYcsP42AOSenuH2CYW9iIhT/gZ9RWh6n+9VLbWG0xkyOhW4rmMJ1bZDO
         swhIEQgovWNy20zoEMAAcDsdhJUajXAxoLaU3DAE3yEZCyAg2deDK9lnjEFydcsg2DXT
         0CqH/Nh6BKd/3gaJBKnrPz5HBHtFR3Mcmf5KB2c9v9w9CQwP2Ay+hcd1frQYwyiFosOq
         MpR4uxmm64HSgcW3TWIHrTW7Ikow+hn4fJebSChmJdj5zI3be9zv15MUuIkdBL5g5PIH
         ua8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768361606; x=1768966406;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNuoHqZoMgzHCnwfxlSsc34qYgQjLlix55tfQJuBzi4=;
        b=Y6RCbBQBVbdQc7i4PBpeFoCivVh/v3GRs4VMvFKXE3mQDUdDBwM0qzsU54Rn57eJQA
         +c/VugVwV4QixNP4FFxkf5UBrJjDoCOVS7/qUbDszN2DwVAyFHgSitTAQIuzQLahb8Ev
         Ek3Uaa8C5h+QbIrnlPoUsr02ZP1ZyVKWNkZ5sRHXwxr5EIKYOXZx5UUoZ8COTauO0lu1
         bCiVbwbn8tDaYtnW+XMMxXpX/aBKXuDqNmhqfOdV1e9p4V5oEMZq4ci+oijJZ0b3CQE/
         XrBc2OpE3qJku10URqlj3V8eu546E6qYGFczEJWkObaZSaeUz9ZXfofvvP1bvdr+2S4j
         mxjQ==
X-Gm-Message-State: AOJu0Yxx91rqNR54Z70oeOTtFLMi0PZlOOgK+qKy8NYyQYVwBmLzi1ka
	0OI+JpkdsquxIcZ2//iut96V77o48VVEIp5p/mdwrZkrW5vFWdlbNRPuJ7AmiBaeaQ==
X-Gm-Gg: AY/fxX5i5vJnXcrCQIN7VRmLdWPAceFH7zjYXrZSD54kgCEhM1dlVM4UGNJFm4mo8Ow
	tr8l83BSSV1SUIrBjiGkmx1yX1CyE+5LvQp4vMevi6f5JVyMmuuaOZ16UzBs8htfR1dTzkIzmNi
	NRPbjQccObFvSemv8GQhKvFrGlOQVYhUKRIfTtnKTbGOBv5OcY48RDJF3VaS75UnNYs6YwgZC8Z
	OhYzXO6ol+TpUztTa51XHfV1uSmuRS7pmxAo0vgKHySxa/6uXEOP9V4cKIPOqK9urqPfbpv0bHI
	P6Y9qrgYIc2Ysww7lHMI1IwBwkkXEbED7xsefup0nyhq+t17/5Uz90f2WANiAFIyr5DBtF2w7Mc
	57ZC52w3o3RTH1VOCbWyhcxYVUd17SZ9LBuR1uTeh35TpUAIJ0NGA7a2LbTNflvVc2pUSfUkC55
	7hHpnMubiYGjKzJ6AiCd47e/Fw1Q==
X-Received: by 2002:a05:6214:5289:b0:88e:f6d:ba9b with SMTP id 6a1803df08f44-892743f22bcmr15176976d6.69.1768361605855;
        Tue, 13 Jan 2026 19:33:25 -0800 (PST)
Received: from [127.0.0.1] ([135.232.208.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077284f23sm169565496d6.57.2026.01.13.19.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 19:33:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3936106c6b3cc45c570023e083a1e56fa6548b41.1768356312.git.geliang@kernel.org>
References:
 <3936106c6b3cc45c570023e083a1e56fa6548b41.1768356312.git.geliang@kernel.org>
Subject: Re: [PATCH net-next] selftests: tls: use mkstemp instead of
 open(O_TMPFILE)
Message-ID: <40f5f3ba-1df1-6b13-98a6-61480c7c2581@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jan 2026 03:33:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_add_addr =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/20980210139

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e5ae1296bfd1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1042080


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
