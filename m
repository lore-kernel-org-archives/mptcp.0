Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFDC246778
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673453; cv=none; b=dmRoaPM62eXlpLQ7RIYcpUp0qnmCCHKF6epBIaGMJOE0mlJ3e4e9HqnEU5GnWQR/nWaov3gRMmihH/TkFf649CUQtxcsdggbzM5+YMEjdBNlsfmqr57KQS5QuPTHsG0d6piI7ZNJroMpLH2Hl2ey3uN0NBy+Gbx4fBvnoa5SL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673453; c=relaxed/simple;
	bh=MWBBSXKDeM6lxL68IUcmTo/D8IRX5BHkcpo9kPB0o/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=fPUgMKTN9bZrL+MPuKgN3g3fn0NVKhYv2IXRy9uoRfiiwdw9cRKEnit7w2s6O5V/GIdS0XFzZDdZku4kymqgdhb0L3KkeGpRDJlT/0tXuywL13zH90FOARS9rKlhL18xCtnFQt66i09fxN+NvMo1c0Fi+m5DR2zb22NBErZR4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPm/S8Pn; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPm/S8Pn"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-132d1b2519eso2377354c88.0
        for <mptcp@lists.linux.dev>; Sun, 24 May 2026 18:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779673451; x=1780278251; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7Ys8AoG8QpiXqjm5SWTIgc+ipBJs0nk2N9EJ2wBq24=;
        b=MPm/S8Pn61rlSjDH5oECb7ykVQfERSkB0NtfF88IZHGnmZHpNku+/TNZEn0qCGls/a
         pBaAAxDW1mXX58PGaKHJlbq1ziAIH/zuJj5JTuS7HggKaIBh1s/A9bwnInFScTEn9svi
         0jiwR+hFdCmTb+8jR5JCdXT1I+HQ5GDZkdRv7HhhD9InaCNJScDeEi7wFfJlRGy4UEm9
         N1vlsIgjA/CL7ler4lud8+6zBBJtuqimtF+WXmI/YA7fssocsQOxcDObkv6aYhCLhOV/
         SPTpNYpGjuNot6SZJ7nwcUO6RMXdls19kLpJNEDH/DwLd/5WSmRW0FXkZLZ3Sd0GbQpn
         hJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673451; x=1780278251;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7Ys8AoG8QpiXqjm5SWTIgc+ipBJs0nk2N9EJ2wBq24=;
        b=gHM5+7vrswn3VcP33ds8xmxuSgDpn84fbusWiR9JFNYw8GTfLnYspoX/rbRw2i0TYW
         uKAHvmY4e/AGhEo3p8iOSC5X4UB9Xt60u4GhUs/7wWHtnlaQXC2/F9kB7QeF4ms3ZLNe
         mAZkLTNW1PAk7v6NNyBJr1p6xgsfsKZUnFT9kSAL8BntXoGg7r31jSB3lfBvo1t/yfDI
         SOQ5UY0Pbp4w0zJ3Ik+aKSTawBq/3yHkMwiuKx9m68Vy97JFmnWy2YDxmm5SHG8/e1CU
         joNw5ScjbIq1e4le8IhKrBYfvCQCdAkh9HI7kM1+pvPiHxdVVvDcV0efXjbFhD0LJK2D
         BLFg==
X-Gm-Message-State: AOJu0YwrAzuGqcjdXxay+CJw9s2mbAIaxQ9USow9gLIucM1IQuuiG5hn
	fOMuI/EH119pxQmF79k/t0Q2GZD3SsRcNy01N3My+oTrIIZBP9MqzJY=
X-Gm-Gg: Acq92OFdCeWTEwGK7MeV9X4CF+QFv3r6ZBnPXpLinCC5Qclnn72vFho+WlKI+4Fbpp7
	h+GIi6J3LUmVw4IBhGUYsuVGVkUgyiNnIt0cSRPkv3qzOjB+AcE0s5ndZHmpgKZp5ZE5qXtpDaa
	rkeDQERmWOPRv45kMTxJ2GX0U7n01Nw883nHlxgA9///R1xoffpShecdBQFYIkaAjRyxRlFfkVM
	guhmOzHsPIXUk0olnQ85hctjEATYFlWlKLVTyrliBtWI6iaEyjpqYCCBgSojERCUUhzxZ01mfjr
	QoM73yhdjs430KVyXdMTFYxZxnJQ5vkVeZ/Z15GOHBlVH8ERQoglSCsnXWw5jyf37KLytgiWQee
	vL9o4HfIUmUYtoAuSKx17mzfHWnEhpOBdXtW38RevR6IOaNoy/dic//gimkmjbFY5rCDs7g9GbP
	vWCfDV7DXf8qii/LEy2qD7ZFatb5rGRQLrJb5Y2g==
X-Received: by 2002:a05:7022:613:b0:134:feba:3fd with SMTP id a92af1059eb24-1365fd7ccb7mr5982087c88.37.1779673451260;
        Sun, 24 May 2026 18:44:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.80])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm4847329c88.7.2026.05.24.18.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:44:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260525003233.857172-1-shardul.b@mpiricsoftware.com>
References: <20260525003233.857172-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix divide-by-zero in
 __mptcp_push_pending close path
Message-ID: <91bc1ec3-2625-d99e-833b-9b3bc491270b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:44:09 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 7 failed =
test(s): packetdrill_dss packetdrill_sockopts selftest_mptcp_connect =
selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap =
selftest_mptcp_connect_sendfile selftest_mptcp_connect_splice =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): =
Unstable: 7 failed test(s): packetdrill_dss packetdrill_sockopts =
selftest_mptcp_connect selftest_mptcp_connect_checksum =
selftest_mptcp_connect_mmap selftest_mptcp_connect_sendfile =
selftest_mptcp_connect_splice =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 1 failed =
test(s): bpftest_test_progs-no_alu32_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s):=
 bpftest_test_progs-no_alu32_mptcp =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/263777=
68525

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6fcb9bbec4aa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1100122


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
