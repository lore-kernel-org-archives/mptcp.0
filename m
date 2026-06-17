Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C993BB66B
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682840; cv=none; b=sx/jQAC4QgIoHYnFfYBPxHEv+7ZxfQwJZxAlf1NIULS45dRLJ4KxeV/7TfEBh+zKx758fRyvP0rKn2mqxvZfnCP7DauXSrdPwrFi9EQ0izkzKQhGj6qXO/xoqZWEvvzdEFY1HIkaHWN5W/kD/Mkhv0KvcJQy3e7dXhHoGRi2ww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682840; c=relaxed/simple;
	bh=eM8R+WHSmuuKRCqJHDr9053lBq6YqeTU1U/HKRgBLSg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=KsctTbr8yYFiwOdXZ8XJ/uGxJtFsbaWPSlhXWOpHcqUJgLYtG9WzxBg+HY6iDnOM3GFIiqF0aa4eS6LnIzFDqtuHT6zbvQAlpBXf97xUkDqpTsskesIIHFtwFZYCPloUy43AD4QNku9l9BNNo5rJYELuvg8NzlQG5/kiS/6Ea7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOTsjNIB; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOTsjNIB"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8cce87d7995so59353366d6.0
        for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781682838; x=1782287638; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFJ8v6984Kwhclx2hnyfFH+9AB9XikOXIyksoiJIADs=;
        b=LOTsjNIBpabQhz1XQaKlDygLTm92wEPhWgunao6oAQBWFlFqqN7cvqnF/j2T3R62YM
         GXPfZN7kbeeFHYPYgDs03AWcQyOsyPB/kx+HWEnXMOB4BtaFyZWmCpV1jvXy265KLYN1
         Ao9QRUFnR2FjvLCuYrQZBp+awasY08YVgDVYGyr1LIV3p4RiXh7GHyn8kE629GHXZQY0
         lgrpk/DPQZwBEIzJ4mgW1PFUoEhyPPKWXKKEGo/pSll4Ldp98sR9bTcvAR23+g5avWaG
         oPUKU6lbKKa3ceoIy87GsMz5EACylwly3lsAVRgRsT5sP46v/vV7npnJxm3gBBzCmb9Y
         B6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781682838; x=1782287638;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFJ8v6984Kwhclx2hnyfFH+9AB9XikOXIyksoiJIADs=;
        b=aVhttPww78qOqbIDl9mSlK4ZBbCYu5w4h9Ckl9LBsdsf5c3BGUSs4XMrCnwuh4oqix
         aHVVQg22h03YaBSuBLVvvGGDjneILHB1sKl1UqRU/sJs/inQHiASfgj1pUEDp1MHRCvq
         tFFmr69wRR2GlP5V9ZooscGCx512jKZ6YXRqNMkh68qr+/J+mI3OQp0i8P53tfHy+lHQ
         4bTGNDpC6jQU5pVerg9wBJZnmJ1ZtMkSzF9I+xxppt70erhgWvRGfhEARXyLOUd9ZkKV
         I1uuUywdlOHkqdGCCrIIRmRPCkTGuLwtc+jevfRYldE6WVKLUbYcleONJd+adp1V+dfR
         CMGA==
X-Gm-Message-State: AOJu0Yw3Of08V6C+WRRtWSq0YTOTfpep/weRrkvgao4aSqPCnC4MbEHh
	C93MNLsfGlesNAlLXdS7WzTWu79rEhMg2GGfvmwuXWb8s2GwL3BURAc=
X-Gm-Gg: AfdE7clZVv4uQpR514MKggPwYIeFxnpMx8UG7ZMROqtXgiiehB0v8DTyQFYeYOqVJEE
	gL0Hssy8CDkZxd0h1F7dlGcpwAs7Sy8T2nZy+MZPw18srjAVGjmc8qXJtOfHL5L5OHgbNRuRs1p
	E6rUrGLg5eTqY6DVUCS/gOgrmi+rSGI+233ePBps4bUwnafAseqNip3hRq2ChchtUOp8E15hwOf
	F1Wbhkk5Xx5ApDeZGylOcaoggT+qbly7MjHLDjycZg4TBxDIAqrOg03PJGsrS1xovOBXmJjJMbm
	7rnAGA0wNS1DHqCKsWhXx7w8mUqVlOK9Aw2XcbBGPPUvNAntzD2m4nfPZKNSJVxXwbw1re0Shcy
	QTBBJm5juoPC25mfy9eSfuZuDJDFg324KqvHJJNUq7C46XUcN1Tt6M2411DZWYDnoytKVBQ/G7O
	yIk071DOkbgdTU2gZIGKs605Si
X-Received: by 2002:a05:6214:428b:b0:8db:b41e:cfcd with SMTP id 6a1803df08f44-8dbb41ed0c0mr30158096d6.9.1781682838356;
        Wed, 17 Jun 2026 00:53:58 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.79.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f5b8d9a7sm57111986d6.48.2026.06.17.00.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:53:58 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260617064835.2957303-1-kalpan.jani@mpiricsoftware.com>
References: <20260617064835.2957303-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix lockdep splat in
 mptcp_subflow_create_socket
Message-ID: <416483e8-8a36-7097-c2c2-c57eb277b27b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:53:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/276718=
43184

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/950229cf0bbc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1112712


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
