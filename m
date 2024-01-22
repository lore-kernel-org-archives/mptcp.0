Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0A1368
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892427; cv=none; b=D2bJ5fQv/1RKPs0lz+lNIWe2w2UHUOxFrd0Ce170+76NsVatuTmkgLW0O0HfyMuRyhYvgwMwpv3P0OmTAn3GJJD0ZzQTPZyKz3VVGBTkOlTWzy1yMpVBLEZ+vRcz6AipeBbtnar7ApCWze2AnsSd0eocHesApPaWj+FyGkhCq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892427; c=relaxed/simple;
	bh=J+el2oUoe/XeYckttSvastsgu2drIQ2u08bf0jJAHMI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=j53GdAa+mTIbRpS6H2JEdDKJ1PQ93kTnk+Pof7aS9FppUCVRn2IktGtbrbhcH7DtazrbfwDVS5dg+tjBgDzJYx9j2anQBqoT6GoVLY5Fs4C3tHl/YWrfJPDwjbUDMwt/0yYuKD2sortfw34ffCCYOFEUTgN3EdUpMNlJ7aAFAXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py7KZLGu; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py7KZLGu"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ddf05b1922so2182554a34.2
        for <mptcp@lists.linux.dev>; Sun, 21 Jan 2024 19:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705892425; x=1706497225; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e45fSNGm8ImTFjQsIxc1wNNtdol+RvVOG5e6NVgZxxQ=;
        b=Py7KZLGuIchuafhMZYO6VsLiENvP9Kt5yu/ZC26r3NTjGXN7utwo1Dr+dky92KQTeK
         4wTQVqm4AroQaxQOH7GQX9bShW1WbhjfrY9mhkSTRpYeF8JyjdHcg9NEyiPCoBJ5HEB9
         WWh0ouf3rOJXGgZUVDBI5oR1m91Hf9CsCY2Gj53vhcpdMirJ6EQK6zxpiXc4BRi+FlqN
         9g0Q+UYqGN2nWEiYWiBQGK+i1ZP1xkeUrh0R3A2mZIgbt+FRFnfpSOtCg5UrqJAau04e
         Bt0rGx+2fOwFvm5l8jW9P0sn8AeLXdSUXa7fvsiY6ANsqs3bx3ABFNFWll9B3h3NM0sh
         031w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705892425; x=1706497225;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e45fSNGm8ImTFjQsIxc1wNNtdol+RvVOG5e6NVgZxxQ=;
        b=eF1VXoqt04adCMSCdSU1V/fYguHN/pQG2vF+cB3hwpEDr/wjLzSPtiVEp0GkK9z8q2
         a0OtLtoN+KxEtZ1MUxYldGql1kAlIp4ORFBgYDGWsKNiEfbW7/uq7V6Vb+zArl2EeAv1
         k4HIiFrODZz/A4Mhii05tHghjPED0pMQQ2bBkuzgCecuLWwmcraQFU7SHFnrqixJWlSA
         ejiQhzOw/iWy36H9uOmnAot19b2EP1O4lhZSHYjyKWG6FR6rD5ucKGLy6e6zX5YkT7qG
         HWTvqUqNUkpDbwYKXtT0/REjCdWFPv7DJ4/8lzpwodeWfrIzMSkPyJXYPy3UEYIV+7se
         /Jhw==
X-Gm-Message-State: AOJu0YzM0URtVh7uq7GM/DATkpJcloP78rySiJdhBqOV3DgB22vgvtaJ
	tAH8QfAAw+A7KUy78NxM1UYZ6etUuu2w+km82/8TuzZJ2fPBp0Q=
X-Google-Smtp-Source: AGHT+IGGckqteSgt0DGyTBdmUnz5ydLm/dsUADOgflgB3PT3PYorF9LcBE02iha+JI5gELxySbwlKw==
X-Received: by 2002:a05:6830:108c:b0:6dc:1ff:e36a with SMTP id y12-20020a056830108c00b006dc01ffe36amr4243855oto.6.1705892424661;
        Sun, 21 Jan 2024 19:00:24 -0800 (PST)
Received: from [127.0.0.1] ([20.168.58.79])
        by smtp.gmail.com with ESMTPSA id c32-20020a631c20000000b005c259cef481sm7311218pgc.59.2024.01.21.19.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 19:00:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
References:
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
Subject: Re: selftests: mptcp: join: stop transfer when check is done:
 Tests Results
Message-ID: <e991899e-c21e-2af7-ff10-e13ebda549c2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jan 2024 03:00:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 3 failed test(s): =
packetdrill_regressions packetdrill_sockopts selftest_mptcp_join =
=F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/act=
ions/runs/7605531103

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a54e692a5628


If there are some issues, you can reproduce them using the same environment=
 as
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
