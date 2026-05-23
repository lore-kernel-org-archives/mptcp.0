Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62691FB1
	for <mptcp@lists.linux.dev>; Sat, 23 May 2026 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779575471; cv=none; b=eN7y/U+XSimC74XqLRE+XItC/GYVK5bliH+GmWScr4SN5wWSD5+xxYzsYYET/4HC3aFBYTVNHXGQpszkdF0RAl70H3SNWnC0eT/sSpdEldZJeupXo0znUuNpkLHXF44o2seuLzKFFsY31HgblRr/EhTTRnzCrxtpYgr5uh8ey94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779575471; c=relaxed/simple;
	bh=NqNl9Pj6xsNqMt4wNPTZBjNXHfyoDHA64iRkWZ+e8UM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=PSXpRNfsiLX123tYGEFh+BSqbrORYVTAjDB0EncjTBmpTEP/C2aMj5akCpvg2RB7iMo4UuGGRV+l+vbvAEt1xn6FnhZic8PI60HVt/L6Zkfk5HjcXFY6DoScN3Efz/cD/pKOQDeR+/wz8fPJNaFEq6krPr6c1oIfNg3ymY22cn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx5cqwKD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx5cqwKD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3697c35eab7so5078125a91.0
        for <mptcp@lists.linux.dev>; Sat, 23 May 2026 15:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779575469; x=1780180269; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhM5l4gJo18urUvmmbbCGymvlyE15sbm3buLPgsL0gU=;
        b=jx5cqwKDZfht1YNNgpkuHICkW3eL+xqdF3k3zYNXtvTfv2Bly/2e8sX19MBjL+s1+z
         Q1tzTkabNoJl2jg6Z1u6Srte0zhiW9eHTAHhfC2xGTw0hQ52+qqLdxtoA9Aic4DD7Eo/
         75TG5t8RQzKlGkLTOfML5Q7dMl4mv3+e6kYdDkgSK9GNPuVdRxzeZVIObi1vAq/ztkKw
         WE7abKI+PDdQVWUfIoujc6izL2t3FMaUxxOm+8RUuhzxwohMHPUhFXkTJv0CXyyHKqrZ
         2r37Nv/ZVZpRtX71jmhOjFQFxQ5NEoE0lWFgEnBTYdVoq0z1+T9ooH0QWSSulwxCPEZq
         EBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779575469; x=1780180269;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhM5l4gJo18urUvmmbbCGymvlyE15sbm3buLPgsL0gU=;
        b=EqRrkqqID99UurT/Fw72aIOi977q29g6WHdl5RS1EINc0Xw5iEt64CRtUSKMlbWaEG
         77/t3uEZvjCvceDrzrevJulmPf50w+5UQr07c5wHF3HuBGsgvIVIdQrom9FKbZIkooIV
         HDU3DE3uPHqm3Aea3hIeu6CJXYqX7Ui5ZXCnms9GMchtnDC2JqnXNCmt+KJEo4qurj+Y
         V+XjVecvlqpu2NRXuFUL40Rr15TrePT/p0L5+UsSnnV+4BV8/BKNVAg97PD6AZyLS6Kp
         EkYDfq2NzALMtg+jIV0ce1SKpfXwO0dbwcBk3aMN0yyduB55ArmSfUHzpcVXYbKNb/RS
         voRQ==
X-Gm-Message-State: AOJu0YzSLY9FyoApn8LsqnBjGJa6VwHrDiumZi8zA5kbUNKt+OL8VtBK
	oWhE1M6n6se0RdigXnRXRliODznkfU3a0O2Troa/58ugKbND3Cs2hF/o/WPH
X-Gm-Gg: Acq92OHfDrpfWrg6vtoRZSPSLqqcWEAcX2q4ThKQsvHZ+AFddsocSWWgyScUuumrf01
	QAbnIX20u3B5I3WWO/3NH/ckGMMstnEDtyknClUTiOirCdvM7iXw6nwsgtuABPFhCPo9wmKVPR4
	RmmlatyZRb/D5koD69dl3Wg+iE8fmrCWNUipo/bUD4YSKqSmHuQOlNv/hYriu3ldZo9Mv7qK7Vd
	kprUm7yNk2wrI5LqyP6iJTV111d5d9K6T7PZqxcxzQPkJtpDGXZJFqpZoFVCL5QERR85s4Yvd9j
	uLPYjVGBghaiVG5aB7vcbevoH9PB91BpEKoy3aI+5HCAJOqO+GW5NUiGmvbS/2sRtg3hF4mTZ0Z
	+UModHUVa3xqHa258PrnshLrGcasA0paYnzGhjq0EPlyw5ufzsXqqUOwaJAFQVRGfzX83bV32hH
	VFYy720Y/wm+EHQ08ee+52AoF8lAINHZdvkX4APaObFlM1Jg==
X-Received: by 2002:a17:90b:5188:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-36a67853b18mr8510738a91.22.1779575468853;
        Sat, 23 May 2026 15:31:08 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.117.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6d8c89dbsm2331831a91.14.2026.05.23.15.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 15:31:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260523212930.2957096-1-shardul.b@mpiricsoftware.com>
References: <20260523212930.2957096-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH net v2] mptcp: pm: fix memory leak from
 alloc-during-teardown race
Message-ID: <6b0f9876-9770-bc90-4566-2d4f068ad8f8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 22:31:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/263442=
00521

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c67bb4bfe409
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1099906


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
