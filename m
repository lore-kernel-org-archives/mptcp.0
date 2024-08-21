Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB54B5C1
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242929; cv=none; b=afMgM3N/3kgQyzIq34hs67kR6WhWkcTOelucI6GCHwBX1/KfosmpKIEryZx27NUm4a38uAAIwsp5Y4fYlHw53x8cImQtHTYU06j/dytOFkHY/uoA80TFXfzPcOgS0K5WxR/p9I+mhmmHimQE3FAQ7FgR0KiOns8B2ZRuqslMpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242929; c=relaxed/simple;
	bh=oJi5EmPUJjVEKAtB8ttRu7SRJeNo3xITN7O+iwrwzb0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CWDXeh+Io+LvtV7bFRLLfygV5Frr/7tCJWif72ylMzlTCzNKTkzvhcHACNewjdw3uiTNBayvZ2M9VL2EHbtFpaVLqTTAkVHPubO1K7BYxpxrifjPu8JGMAWN+sLSpGGBMYx6+yaLiVDG3dZJHPARzfQ1g4a7xVN5PBb3c30nOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akdxW8Nn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akdxW8Nn"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d024f775so484559185a.2
        for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724242927; x=1724847727; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0scGg0jNhmRpgHYRuf0oSXA2+bwjGRtGWppR2XXIHU=;
        b=akdxW8NnimvG0SLicElIaqtIVVOeLbNm3jW43vd1z1EgPskdA2SeBFf+vblX3+/k6y
         kQI8hwL4W4iia7QOz2pPKBOcFDLPa2K47+U+ao2jL38CvSfmAHfA/br+mrddA8R+AtQj
         Zi7XtrxyoenTA8KRPXEzaTlT7oAcplp5ZUwf/U0x56VQSPxA9/PkmwFzmHaYjCZ+zDJv
         i7NUrc/HS7bWrc2CF0cVA+hIclo1EIHyNzfYTzwD7dishd10hC3yYUFwurzurs7SgMlZ
         nIdBPtab02XZl3CkLlqQ+7vFW3V3VQntMbfloULyS83fHnlCIMvcr8B6em0wJzRrUS6k
         9+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242927; x=1724847727;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0scGg0jNhmRpgHYRuf0oSXA2+bwjGRtGWppR2XXIHU=;
        b=cky3JNvHhnyXYwUXMRic6SF22YXJOP4IPczFjx1wCcxBZzHp7qWcqZ/MAEO1RAGiBR
         MMjMx/innhLFFe0mE1yNWBWuOW8N21O5yolyDpOgC96sbuBAwE1AnF3QxRdVdkE+tXtJ
         bbenkuzDnNrzMrrQm0H3WkPfpWzShfCQr5ZczkSrCVLdBbrlcrQroqSqbH/UuLNF97zg
         46oKo+nrcp1JbTyp56DuyLHHVTSC0O0yH+URm2e2hqEoWlaWHQ5FoMkmNTv2krO0c6Uk
         wsXxMKkCuOkWrlwwSkqTarFFmNVYWQ/geXoSdEJD1BUDN68Q/JUYLmPWBhmJtfRj1SEZ
         b8Fg==
X-Gm-Message-State: AOJu0YxBk5bY4RFrXQ+uuC9tYpL9H7MqDp/PE0YO+gBBKgmDNggLzPiu
	hIJKZq2gnle4N7eCTYZae7EIxAtXTUu4lagr5mV9N9CTvUju+CA=
X-Google-Smtp-Source: AGHT+IFjupyQyRDulZpq8qbxpIvj0W/auLNqAc5XgYo11pa3zxz1LGv1U0DDFCmj3Lr83ZW/ePkEKg==
X-Received: by 2002:a05:620a:3953:b0:79e:e302:7392 with SMTP id af79cd13be357-7a674047d68mr248804585a.32.1724242927057;
        Wed, 21 Aug 2024 05:22:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.53.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01de0csm618433985a.1.2024.08.21.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:22:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
References: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
Subject: Re: [PATCH mptcp-next 0/3] selftests: mptcp: add time per subtests
 in TAP output
Message-ID: <6c0eccec-f1c8-1c5c-0113-2291b17a5159@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Aug 2024 12:22:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10489178247

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e69c1c7d48b1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D881720


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
