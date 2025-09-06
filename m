Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60E315D3D
	for <mptcp@lists.linux.dev>; Sat,  6 Sep 2025 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757125734; cv=none; b=CG92Dz8x2w5V00BD9GH0ZlPyt9EtRQZHh/7YKu0SIb/My+cs6xojtwYAV+QyOkchrIDOr9wRU+ipospOwHUBgcl6tY0xOo6HZeoURmwL3ldUfUuJQtKmyDnjlze3C8vDJ8iulltwj/ioIVxr1kg6y9CU/0tjKiG9C+nCJ+szIX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757125734; c=relaxed/simple;
	bh=DhZoxG0LSDBF+alJYJmOYjt6hePQIAM8GgJ8DJZb3Zc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BbJMYavnyuqIbm9T9AhLvTWAJ+WHiOFfg+eaN6BQiXETtPwbJ3F5xWoOlZhEY2H3k1y2dy3Mm3OM3ToULxo37c8zpxKQTx3V1igJDV6wFpRoHTQ6jRudpskUrljl4tHVi1ny7GZdCoSSspVFZwhq6/8vq6oBZul6ulzPGLrBxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CapFaQ1O; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CapFaQ1O"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7723f0924a3so3725246b3a.2
        for <mptcp@lists.linux.dev>; Fri, 05 Sep 2025 19:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757125732; x=1757730532; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swiub7l+Na6FRNKB+OjWbf643lKOoc2jUZ6LitAcd/4=;
        b=CapFaQ1O58I9VEAr8NhswiD07N4nfnq4FnZYjZ/r+t+/DvqKbJxuddS5eQ/guB5jlp
         5YUPbIUqfI1U/23TJTsjxkPGn9GCPXtwMkjDiBmg0xTOY6BL5iZUYkbbOrYkszpfLu7J
         p8HAVawQPBiBQHjSMOKqI/zp5PJUbxtJz2ecWuP2h33Izv3+AqJEb/JSrGpaPACEyu+N
         RB/8xtMWKSAb61w+K5QvReMfj9xIZoYOnrivBiUPAmJWa0KX4ipAdMo2gAWjC3W01lcp
         F1f4tAj24W4boTfN0Hf9U4JZxQMOvFHuQpmuBPiaIHOUvkzkzvILLxzl8qlGw2dblnfK
         L2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757125732; x=1757730532;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=swiub7l+Na6FRNKB+OjWbf643lKOoc2jUZ6LitAcd/4=;
        b=YvxWOVpaBqtmmwbXylGF2Mcq5jM7lCHB7NaeAuIZYJbqtrxlS8R5bruLTlPeVotd9V
         ICdX5Pi4WtlTKaXS3Bj9+C3jkmcL3g7C9ytuNbx2fnHKP4yi048349zxLBSto6URf1M8
         hEn/Iv/Si4Pyf3/IS3mqwL1abXnXKNec93TdzGKCwyvpnDMV+qloiyiZH0RMKi0WWF00
         u66ZT+iOgaWeFycnJOdLtd7UEEhpeUj8snbaEBfwntIs0EKH6qYz5rC8XSWCC9vgA8sl
         pxdywhKnRazuvhTeZfpCRXcvqEG8qImb9yN5V+qXn2dmbrEbsi7EmDpqPrAGZkslgPGC
         9Wog==
X-Gm-Message-State: AOJu0YwYCfU4mRMYSDB7lzdxCqLAkL3/0SAC24WmWUeHOVx2ZXo2y6ld
	8tcZjbMtg9jLIEQPkBdHkP7vbPoMwR9KP/zlzOGAwcx07xY+yS6ivHU=
X-Gm-Gg: ASbGncuKeRXGKsGk987vIFg0qvc1srmBO7XhdkNoLqH5GdKGjoPJChmMVOqAaO6YKII
	dC3oaE2cjingZEj2VXj7eH77M+VcNXuQ4/9xKIFT7OcGrv1B1zNuSbaXTV1ChmBr2LouSrjKtgu
	wA0iFcu7k/gf4J2jJkVIWQwJ13xU8+1tUrEBykxjloJterq+B7RyGLUMwUcl1vZCoB8ca6Y0DMX
	nTCYxeCLyVjB7ACs8J4wRGYvXTQy7PdLqs5aWzW8mLmzrSsXpvi7801epiiWy0kkbKCoRpgwIT5
	BLFzrl2IdLhfEoIUug7RVfyzLC476BnozOi9xt4z7N8nRhdvnz7Qg6TPbNb2Gq7SzrpVtLb/YIE
	AsnB2Lidy/fuXRyVKyHQNFugTnIAfQpvQneZFfPLIShWPJVU=
X-Google-Smtp-Source: AGHT+IFep+0B1QEv0Czv8/AaObpU6Xv4kXyMx+1Fxg7noxYq3XwlKEzVutU3p48Mpd8Fl0YhRIhDIw==
X-Received: by 2002:a05:6a00:2316:b0:771:e8fd:a82a with SMTP id d2e1a72fcca58-7742df20736mr997128b3a.23.1757125731912;
        Fri, 05 Sep 2025 19:28:51 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725e419913sm15359432b3a.55.2025.09.05.19.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 19:28:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <aLuDmBsgC7wVNV1J@templeofstupid.com>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com>
Subject: Re: [PATCH mptcp] mptcp: sockopt: make sync_socket_options
 propagate SOCK_KEEPOPEN
Message-ID: <4ecc8d25-3a99-72f7-9c65-9aa8806e8522@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Sep 2025 02:28:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Krister,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17507741030

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b682ae8c4184
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D999551


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
