Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33E13777E
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542404; cv=none; b=XjcdmedV73uZnwo1mzyourW2L8g9vJfJ72Kn1tOe13O9QbF4760Ic/D+t4SD7PtWt7/grApe2VBMzE4/7oTaPkI3pTgvwM0MIjMAfB9GuLsVQ7rSLS+E1S4c3mpzyteyQCecsWF1UWI0PdmvgwCk0GTCGGxJM/2c5Zaeaz+7XPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542404; c=relaxed/simple;
	bh=+R1M2znpmu/yMYOp3lDOkcMEkN3lx8mKrQo6KjBimQ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=KCgZMH6puLK8DkwX/bGGiPTIEj4nxgt9A3xx7ZKa0zgcWUCBtBUT0mIXV7uoo/VuHbofpr/JO/iNjIztO7C6pFqutolpqUNYrPazjzLj+Hmx6sIrpUAt8tFH8L2o7XLLokdpIWRG07O2kgKJD4iWN/7dO4EO2h/ft3SrdR9eJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+R8MQyq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+R8MQyq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacf197759so39124965ad.2
        for <mptcp@lists.linux.dev>; Sun, 23 Aug 2026 20:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542403; x=1788147203; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+/HvDzoRkBgIwrMwg1WHN7hr3OErTt4DsrdALaQouvo=;
        b=N+R8MQyqQRSB8PkG6N7SuIenb1aEbtibQgrYiskU4WWhKbPWEf3SIl8rY3aEApOS1e
         gtiRc7hFfOqVcdgKzjcIwLC+KyxGTeB/yu6SFOUPOQ0oNg+GT4AoEVWU2P7VgfztKo52
         hYXr7khAwx1sU6jw0aPgXA8wmaAhkA+hhmRgTOgIW+72dVLnnAxfEXA8t4Oweu/qmh51
         FnYOoVGlAJnGTCL74UcTvJHDlCjx30n9V3N+lvgfkMWPvFvZNziuXB5uZ2jrHKnyZ11c
         1l4fCX7YvHL/7ZRIHf+KhATH7aNDMuKX8zQTTY3+H7/HPCIu7G1kjIcwbl11hUySa4Nh
         PdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542403; x=1788147203;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/HvDzoRkBgIwrMwg1WHN7hr3OErTt4DsrdALaQouvo=;
        b=Mr9UwIj7DybauhLgQYuEAtPUasadRWmVocoXOqTQQ/GcNLPhbEnSSeGYtPPX1PuZJd
         s+V58yjceMWE7btBHtBDRrmoCr1l1Vdot8hE1DQT9fj5AK2ofcngaSG9dxjXZY0Uqgvl
         N5WO7gI4AGwRGzkGCvX6SWDtLyuwV5IZne8UlZM0DoHG1OYI6rGMKJKreLDusmbMEmIQ
         Hm0+cyXVKNbbMgZTJJCEktHUcJxWFyTiAUk4GcCTbudWTt0CT2/s8KStBQywWQlqEC+G
         XvqQBdjonX53OwxJJha0+PBWpkKxGOUHeUoOrKjtjDPtE7HxI5N4jwSOhU98Y5FtygKw
         1WhA==
X-Gm-Message-State: AFuF++mH3bJ5BiBRQW3J2uScWs5vAfH+869uATNOV6puh6KTa4ZrCJJV
	xBSAFht6h2SiM6G7TBr+CwfiRWcQ2vFbKAy7lkt43GzhnV/tBnb2YV8IJ+mc
X-Gm-Gg: AR+sD13X+fi3AAmqVrAcayMyYrNIZfdEl4pr6c8KHqtJ/8w5k/ROaenNxzCvVQC+0HR
	mfCmwm/fsL8NQ+MHAR7xNq0SjiEpZ8i2hjVUHXsrPn9tze++BsP4SP5RYrdoAPECSBA2kRyUOxc
	jjzS1xKZFDT5RVRW3ktX0bcdBdFLKekSm2ZVQMYpIDE4YQre5jbMfvC5d/BM6VoG8ccrh2NCtN9
	e4fJxU+e9a5lH09RieyqelN/6HWA4TIfmKm12WIBcC1vVklen5B9xQI1AiGuQoIiWrLonXdAH8/
	9dgYlN+aiDQMTr8nFt7hiEE0agq+WGLLChbhZO447UfXuZzJC5AT4m+v738lIcToHyy1WTYUaOM
	Wr5WDcBSR37Iisj3P3MBcW9Ummu6HyToFp4c7gW0UeiG7HMTooC2++8DyHuXcLapamhPr43bKuT
	fO9IN8iHGFlrtO6HytnlHSLFHTWKHNoelAIMdYKhfKStdMnWnIQYUK8vFRGWs1E7v2EkQY9nG37
	2pm8H4wAA==
X-Received: by 2002:a17:902:cf43:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2d64ade9363mr453213735ad.3.1787542402745;
        Sun, 23 Aug 2026 20:33:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.98.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9209fafsm35826307eec.23.2026.08.23.20.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:33:22 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787537436.git.tanggeliang@kylinos.cn>
References: <cover.1787537436.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 0/8] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <843f5772-f6db-930f-71dd-38d31c8d465a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 03:33:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/326838=
34933

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/430bec763fed
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1150551


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
