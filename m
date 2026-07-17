Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EB3CF1E3
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274880; cv=none; b=W8qnF52JqoSkKCd51eFQXy53uDaM6Eyd3OfoJDgnRtexOTsDKWn0uO877Vu4ukpQm/+zu8EDL6caZ2AtYMr/QjUtReN9mZFPRS8voIGcmj/Evw/bEwXlK1eUYqx0WOMC60VauSYUtLThhg1LFLVJMOOu6504PneumLMMuNboUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274880; c=relaxed/simple;
	bh=ondlt+5mX44hwNyMdZFou8eHe4wgtF7pyGAtDJZDmRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=D1X+ril5aPQ/VvM6X7SmgaO25cKrxl6i3thqNPbVZMqOAz7C5NpHrxwY17yJfozf5zlTFKjEF/FQYGvJmME1fZcKHU1JsBy+kx9NCzOrALYsw6qzJsK/kx0PszKOtUOPRMHlRC50ekTVHVC8vuUwz4C8EBMe21vrFXYkQTQ6eKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdnuHStQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdnuHStQ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso2662103a12.2
        for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 00:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784274876; x=1784879676; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zew4NifL3exhz39geKYYxTt8/D5llnXgNalgKiFv6xU=;
        b=EdnuHStQRE728yWzS1U0ci6qw3ZHlASvmb2NzoWxEIhOR9sqcq8Wn4wOcXLKotJZTO
         1/RXtgIuvGUaYLVBfw29fF0BqaW6gm4JcCPOocG7Iktc+mpmim0wqWPqBZyAhOjdg8JJ
         k+MZQrMkjYpN1qTynkV+qP80sI1tSh0b4s7iR+ky7jAMMRkgMFBj28ZEyBCUi7sP5Ryn
         AuxkvAvvY3VwuAq6WwqY8RIM79ux926tZt65bZtplyq5CkJ5zhT2xFRbSffQhwjZevle
         rGs7HLwjmpW2A4WaK30Fc1MNHiXL8P+Ly9XgTrSRktIUMcLE8rq5TnzwMdKf0IMuVwz5
         i49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784274876; x=1784879676;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zew4NifL3exhz39geKYYxTt8/D5llnXgNalgKiFv6xU=;
        b=Zih02GtKNn2KZpQigyuruo6SSI8axBU0WyvPMhs1Hy+IxHYR9+1lto4/JY4bes8+EF
         4yrpqC2dwS7orT263vPDCzBCpBzARjPWgh5eqgzqnOInGoAeyioSC/bg10gCP2VdP8tW
         wRTqu5SqEcYXRYfEvNTm/x2SMKenasLpmKVL5h+TSN81DAWpZDLW8oPfxJTIluJdewYj
         ZbIc6qnEKslCYREFjM5kd7FPKmTSsO3WlvcoWE/vwnVE3rFnlaij43nTJTCZdPwjRaBF
         KJifm0IcMY+ACr+0+iOwdokculaot62+0Eoop4v8yM29Ec54+C3/INDYEhwhwn7iYOBS
         +3nA==
X-Gm-Message-State: AOJu0YyUI/q/JG9OyqdakEMyGKe2ULpZdsgiJIPjDMT/Hokblk6wYw6O
	jrSJvOnHdwjwrRoiuj/fI53D42MVJMqiynu8Kkkm+Rpd2TOi1QLKQ7aZPhhyxzg=
X-Gm-Gg: AfdE7ckRNlJDtLAPoGZUTRD0W8mtyy9ZTB+4O90/p52TNKrUtQwg/qEosJnaPDQDAqk
	dE+Tg/JZSFlQWdgwHEdS/B4Sjlx+7cWWQsLxLNBWy/96RJCjPejDloSXoJnpeDc8W+JcUblUoBL
	jQK9eiRXIQpadXKy3DMiPsSrV3zpBNVf34h8w6jtz6GNVaEE32BAnOtQIb+2K0wxJA/Dbg0E8el
	k6PMYkXhsY5/D/Cg8L+x9b4Sjca+z+TUMR36XovnUnon88ePs5rGgiTkbALZY2YUrdES1gPvS+K
	R1vAlNpKt0RhQkAkZP/fTqKC5HMOazs67E53UjabfDbnsTDhGNDzZEeDV1TzDHH+bOUSKFeCQw7
	LLNd5sxlrGF49zasFbdDMbovCCv/LHJKEFp4sxoqdHHJdFTfaqPQqWXGDVj8dQyriGz5KnCVQYo
	cstt8U1TqZ5glPEK6C
X-Received: by 2002:a05:6a21:1506:b0:3c3:81c2:fa47 with SMTP id adf61e73a8af0-3c3ad7a3880mr1776529637.12.1784274876367;
        Fri, 17 Jul 2026 00:54:36 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d439sm5137740eec.5.2026.07.17.00.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:54:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: luoqing <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260717064028.767876-1-l1138897701@163.com>
References: <20260717064028.767876-1-l1138897701@163.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: fix data race in add_addr
 timer callback
Message-ID: <4b4b73f0-295b-62c6-8e74-6add238af6e3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 07:54:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi luoqing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_fastclose =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/295614=
87863

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1abbe9ec15da
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1129292


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
