Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228931400A
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725848075; cv=none; b=VJYRsUxOrEWa1rPVOy0VlU+M6ttcqFMK9u2Y5K1LRINIZ2YUqXu3wuht3ALZWDaht3atl5eJQDNWxjHlRhfc8YcGCCnSIUxDltpXovALQVWss9goVMEouJNW+QV9lADUMCeAUl5vNtK9TBUK0Udy7lXxOd0TcGfkAXUdiswqZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725848075; c=relaxed/simple;
	bh=6CavU5SkobrV4YdXc46SKLZsFGzA1XNhljs1dopVyFg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HIiyzyTpO5L/+7xrcI5nAyD1bN9cebPorpJ7UTropTnbHtUCKi2cMUEfiPz9FVxur9sT9OsB1l9ysBrtgh17PS3Js6oAbVD70F+fTzGcqjBh4wahDhlVj7kFzau590r52zMRLNAFnK9VeUQaoo6cWLNHJVFPijLaXZbue0PCF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV0ii+VK; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV0ii+VK"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1a7c25e350so3659370276.3
        for <mptcp@lists.linux.dev>; Sun, 08 Sep 2024 19:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725848073; x=1726452873; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECb+etaiy7ysBFcQBv9MlKHaT8T36R9mZWYKjCc67y0=;
        b=IV0ii+VKApwSFibrzkFccx8l2q1PS7djoBKcdEzXR083QfAxLTWtu5yW680uE99drY
         0Sqgnw2cKdEGcj6GXFhnp19dXr9x+clbz582NnB5elrluGY3oU2Qsa+vMbjouOmLS2zB
         IaPm6bVkfBQK/KLHGgopGs14ZgjiBxIYplTxIXimZ+k5eIjTn6fH+qlUI+y6siFekeLF
         h5JEkwbbigjQvskdf6Q8gROEDcFH6s35H9D57rTWAIP3KQT0rPhTuHkHwSuwR4gKuUd5
         awGQwhzedprdh1dFf/IW8NQ02Vmz8619/ry6n2S4B4/fmE2Hhki7S6dDHAjdPGbaiLAH
         +I+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725848073; x=1726452873;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ECb+etaiy7ysBFcQBv9MlKHaT8T36R9mZWYKjCc67y0=;
        b=nnnIj8oU+/T0IndErzUz7D+ZBoNNUIl7llODdaxsBOl1l41OJCXbPDjFdyi9pkSuQr
         Ca70lILD6kcbphTp6tO/Va2are0GDyt1DhzaUdlTNy27ukImQbcQrHPh0+ydbDbwK+bS
         KdOYBZRUj0Un2bPSMqtWjThyFS4kRsyVNYFcDTJb1Yv5fDFQZZID2apqQ0jXiZrsDp+l
         JkAJom1u5EiYSgHU4d9HMP05XxemUVDiSm4SKAYL6wC5BRdjRRxh80k4rkIyPhkRJ1Yp
         ddDfYiffM/knPFfgsNLvOwLIxPOGFmLocDQ/KyedQStsyUCzjxD+GF1uPktkyx6JSeDx
         jneA==
X-Gm-Message-State: AOJu0YxgFniicmLnjCqWSxh2vm3P5KqIRBbN0YEy9veWzI9fF9EcuaPW
	DZ4KUlCGLe/0rB2znov3uyKcwU7Utsusj+we5FCo/J1w9fF2cdpS/LCZ
X-Google-Smtp-Source: AGHT+IG+3dC89uUfLurmrb9kEDZEAB/OWTat2otCuivV1y5WUEKvA1ghPONtr9VTM2bOwE+KTj1ITA==
X-Received: by 2002:a05:6902:a8f:b0:e1c:f15e:1f01 with SMTP id 3f1490d57ef6-e1d34895c36mr9613665276.26.1725848072938;
        Sun, 08 Sep 2024 19:14:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.107.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e80e12sm16410291cf.36.2024.09.08.19.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 19:14:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: YANGANG <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_604F30643CD92D084CEB0AA3BE951B30C009@qq.com>
References: <tencent_604F30643CD92D084CEB0AA3BE951B30C009@qq.com>
Subject: Re: [mptcp-next] mptcp: Add data race when accessing the
 fully_established of subflow
Message-ID: <87ae87e6-fa01-057c-6fc3-1cee008143e3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Sep 2024 02:14:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi YANGANG,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10764974403

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e6e94402fe1c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888189


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
