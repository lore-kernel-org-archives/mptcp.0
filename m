Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC72AEE3
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368696; cv=none; b=Wv8lmLmIoGKCYf3BOqIeSN0dSeF2l3AgVxN0XYPpEdPsAW5/u99IQw0JF3lr4ccuJ4aB/khi4+unyxI0My/chvd5BJewAumGqsWh90jBBqmza6aQIhbNABfvxk7gx7Us8pJf6Q3WwUj4lfw7XGTkp4NHlL0iZD1yolXp5szsdEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368696; c=relaxed/simple;
	bh=VNj++h5qgTSBWCkqNFGAXchb1Gsl3X7h9qbVeeaGcp8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=H4rTR1C//rbqereGxwJpWvI40gHiIscDS66L2rHRp1+TVrRi6GA3y4rmHwcOLyL3Wd7DvMQ2/dKpis60S6y4WuUN++g4nJ2z9fsN4TvuIgEpt7rfHTLhLBF0svsy0o574jY/ibYvuY+Hnx9gGEZMm8TkFULEnaq0Hq4HYNqqUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/G1xjsl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/G1xjsl"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c559b3eb0bso368025585a.1
        for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742368693; x=1742973493; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtyksGa6Y+kMghM8F+1ru2QMGW8OIsnk2GisDEWmNSY=;
        b=j/G1xjslnziYc6HpZZ0UJBBxW2E+jXz9oU14ieqakpfoiUyGYF3PbA6N0OSQ1iRN3z
         Rf/bks0B7+vs7cVoHn4YMVXXPhFSTKoGI0CUG0Yz54b29H3UkmbrsKlvuGJC+5qAiCiy
         pa47wY8L6uKxb3wTCK0BV0Dhv9i4azbdTNSj0c0n1TPl5KaLRcUNmf3dD+fwpgz8Zxr2
         B3+Eq1AOcFrv95nKm7KMRnVbPX+R9tdQqED79oPgt+LudJoXwFuJ+u9vRASnsZ6dvnCO
         Tul9T9/Asav4yBphephm2EW8ZzRkVk7wxh49c9OtUX7MAyovBxuBswkAoRf+Itt3sMte
         zv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742368693; x=1742973493;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QtyksGa6Y+kMghM8F+1ru2QMGW8OIsnk2GisDEWmNSY=;
        b=OhMHPTfyLZL1aHZrARmHW+U7rZ5X1jOc7rwJvBHcEfK41yL8L5xDI2oyZ4536ETHXD
         gtBM4BBSHzFfV/aX4BxIkG/XGwvGV57GXmQ8P/kLvF7fhv0Dpeiq3d6JDQye4RgG0TIO
         mS59tZh6CUe/jmEZCXDYHy8RHFOCQQIFYHUPpJw722W5Jmnq5itBzG6KwUwXZxcbYR0u
         l4EzBuEZTCh6DnT/01TWlspksfIG7auyhSQYYn0J4rH5A0xPI9A4G60HUAadeJd44ias
         LojXgn1xvx7lAExNLlGS2S4FSlMjaIKAlsHrIIxkeTLLwx6Lub7w0g6uUpilan0r1pBN
         WPPw==
X-Gm-Message-State: AOJu0Yy7biSH9K9GGFRBAH/6EkZrQeDvXwvYlKlDSLZRzZJ4SN7pumqL
	ozqJAmAwKevn1iijqjxc7kMQIG7Hp0YxDcg7ytA5zaF3X4YFWXo1vch3
X-Gm-Gg: ASbGncvOBgSV3gVVKVfUqYJrtoxe++59DMgOCq5WSNR5X7ckAB+YG2VFJae80U3yUhb
	gNig5nNDbj1P76g2zmbwO3P47ICNwICPDgg3mmDwTWYYawJC6ikEWQwOWA5fcLdxknqiOTy5e+1
	uGMy1XVnEDaeDtTMDwJb6ps3bSDi7twe4OuHF56mdHpZ2maS80378CPxNeqe0MZK1VFwk+XzAAZ
	OrkhysPiokqHyzWXBa0Z1hphbW3dXBUe5XKz2jXHxrw2he/wQERJIPec16CNdnjvoubTuYMyWPG
	bfh7iagFm3Yac0fmC3VnWS1u+OOAfyFwq+AYQSSgUfpaD1Y72l7HsXsibvhIx+Mnd7EA
X-Google-Smtp-Source: AGHT+IEBgmY/AYTGukU52dWwxe0V8v36s+X5cTtVC/r7vjcgqo1gvw8bjQPBYG5bXzRgL4wqlBpSMg==
X-Received: by 2002:a05:620a:1a26:b0:7c5:6b0e:dd56 with SMTP id af79cd13be357-7c5a84df87bmr219708385a.53.1742368693366;
        Wed, 19 Mar 2025 00:18:13 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.22.158])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4ddeasm828167185a.9.2025.03.19.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:18:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1742364129.git.tanggeliang@kylinos.cn>
References: <cover.1742364129.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/1] cleanups for main_loop
Message-ID: <21191a57-bd03-b7d9-6240-33f3b5f86e04@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Mar 2025 07:18:12 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/139402=
54304

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2e5015f77aff
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D945438


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
