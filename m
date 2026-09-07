Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E150AC29
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798303; cv=none; b=qop6u/58ZdAevLl7PdjvcCrvOcKH9JvJflLuQBti2K2y7/Xmm1ipqwi9IH8U+e+YmDyEFGKWl/c04p4wzXJ+iN5Sa0ucstzw38CL1ecgu0wsqaKzPzSvufcjWRm5YNKkcK0dB63seFJ+4dEUigUjONgeBYMFd3MAddz7FV5NWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798303; c=relaxed/simple;
	bh=z+NrtwWvSb6Qh9bOGUyHH4HShsBjeG4NjRxC54htCg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=D8KE1KNjm7/b06ROb1rMX9yFIuLix2L6j6UCMxIYpelJl659sAQVqTsznajTZN7UBbe+lnWAxbQNd6mdq21u9XRTVsL0VhlSfGkhYJJGw8OcyucvyL6azWt1+BrUsYD58PAzqh8BN/7/wLx2MSR60hRdPRLciD3pQt3vyfYCOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwusgL1p; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwusgL1p"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso3718607a34.3
        for <mptcp@lists.linux.dev>; Mon, 07 Sep 2026 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788798296; x=1789403096; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oeb2su0E+FfQvCPmdITeVoqpGXMCeDqO93zGV3RGgwE=;
        b=HwusgL1pGiTUl7CmpqzIgk87CXmEwVJF8xMsk3my8SR3xTXKJhAkD/B9gZrdiNPf1b
         y+9roI0A4TLkECjU0OjiAiJPrR3cdNHAMPjuMGjxyVptcnvqUSELCk9lG4LirNWu1ZtU
         yg6donknb1PcF68oy5eVwcCiYrATVjwBmPT4s1E1zrLLhHC8q0x3aopJRI3Ez7Wgb+n0
         7tVQXFvGihjOKkrA5VGlQsHpYXnZ/aGOhEOR4EfB07OHNynvH/lxU/slw1hFJ9tPIWDR
         y/O9G3o6D17Bh7SCrF2Xom6nL0O954veYmZ2o22P4WN7I/Ra9NnktrU1cI9qngWhbaQr
         FiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788798296; x=1789403096;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oeb2su0E+FfQvCPmdITeVoqpGXMCeDqO93zGV3RGgwE=;
        b=WlJLBIIBHEfAzmhrl8ESPK2XfW31e8BwY/ElZHNvL/sYeQS4q0Hj2OtG6iBxwe7sAn
         12A28ssAq5Wdd2umosUPE32ytm5oDx1gKURn38cE0M1LoY5Ut4Y/nrLdGCsrYWbjFB/K
         AYO2ob9hziC1qKfMROQayTYNoEyVm2fkgVbYdszwrcBxftj8rsUIw1ydGASoDoMSmQaQ
         zTawDJ2Q1m6fZapsieNYUn4/7nOVXqBzGWyfCTTVo4REHs/ewgkmgDpdZaWRw8g5JjgA
         T+JFx3O5vkk++aT6XxcTed/Su0oqvaUxBG9Q73NzPyUIXwKIZ/o3+L1uCCUmD0r+/iPu
         zBvA==
X-Gm-Message-State: AFuF++nzl4CsvyC8D0U/vauzRnbJC34sVBdMgWk3kFxyG/VGZtKW8qzP
	nFwl/hBi9rDHx89ot4J1xffe1o09A+7N4S4tRFZBWtfk2tqdCbhxPvI=
X-Gm-Gg: AYBFou3FoPYmRsgUsnkTZmdvkXgx8gNlPQjPEFUE0yIbBRFg2eVXifKkhrjEXOgS3xl
	g4d3KiI6ATpUs/wqEmXk1j27Pf3vwXKLj9uB7YYC7xZ6qiQebRb8ih4Ih+zrHhqfIZzunp01JQ3
	mqm1MCV7cLUS+ImqKpgzMfdpjqKoLPQEnpLaqsDNnRsh76Pf3bnkNYhX4vEwkohtLsjrRsyZgZR
	4q/1mgZPcQGZ+stMAbEX/2MV4JA0Vj2wN6vV3e9Jb9JCzjdTvDKOc9p5qAr/KYPeRNC0S3sCIeu
	F5boq1cnEorArZVAEnPmr9JOB9cX3AwUWoojIQSEqE62WAIoJCuaNB+sJFeV831o7Dk4vDDVrbt
	nRpQ5mhxIT7QzS5q3cFqxCNeujXL1lV7pRk1+6816NdYVCaW9dlFP5GAbM44Ii2phM4Cdyfxsq7
	uWvdKOgvPOPXhn+VFpZoelidbcYpduFUuzKdWxyR/2WjVvyViLgLGTgbZ09QcOI/8hDrEq5+2T
X-Received: by 2002:a05:6820:160d:b0:6aa:e70f:301e with SMTP id 006d021491bc7-6b6fb3d16bdmr15203421eaf.8.1788798296205;
        Mon, 07 Sep 2026 09:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.29.96])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dce7b751sm13467241eaf.9.2026.09.07.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:24:55 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260907-mptcp-snd-una-race-v4-1-6cd76668a8e3@proton.me>
References: <20260907-mptcp-snd-una-race-v4-1-6cd76668a8e3@proton.me>
Subject: Re: [PATCH mptcp-net v4] mptcp: fix data-race in
 mptcp_subflow_get_send / tcp_ack
Message-ID: <83c967cf-ce19-2a38-9a26-4c9de00a2e3a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 16:24:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/34139102133

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e22a0e139bcf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1159854


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
