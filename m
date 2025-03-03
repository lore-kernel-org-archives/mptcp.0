Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FB23BE
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740979965; cv=none; b=MvSXJfiKcPfJ/ZpHZZCN/f7JDimPqFP9AxHQ4mbn0WmovhzoTFF/ZRCMf5IKtI8GZor4vgOVylp/ivIcrEdgYK24B7GxhzBUmHHySP1ciisymeQE75tEDaKE4ha4ibCg19SiF9o2rJ3he3i7EyRkM079JkamgGZg8Xcz8ri7dhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740979965; c=relaxed/simple;
	bh=97L0Z4I5VsUNe5rdaJXuUGlrLlnPRVOK4xBh79Zo/Dk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=JM4tTnHoEJ9lEwwgy9J+Fx62ULIGkL9hKU07+R5mtZ8QVyj+Q0mWhMYST4RbHdNZlJnFVViGNY+7yvE8nshRtqraXbC+fNN1s8B8hDFfkHfVz3IvAk9b8rn4vY8n9lc+81buYuM8fnvNYEqFW3oz5NUGxukeFJIPEU293G6SZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAXgH0ZH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAXgH0ZH"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0970e2e79so771180385a.3
        for <mptcp@lists.linux.dev>; Sun, 02 Mar 2025 21:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740979963; x=1741584763; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2NFP4i0eiaXBl33yIm+AtKDT0a6hKHp2ihrdOo641g=;
        b=hAXgH0ZH9gNbS6SwYGnJZyCGjk+C0rdjh67kRhNJKM31Hl3VU6xeV6WARUAW0O/2r8
         DDX60ESL5KKJuMaHotFyC41Fh/HedfLsF4A3oMf5bCeRGrCdejetWdYoiGcs+4HDrqoX
         UMuapIS83KQaSeBSwedJv2dtz7hiUWPbG8wHn8kiTKLFRzb6sZgcIzkYDW5XSvCM2eNG
         uYNeluyUiqF/Nfgi7qPUuBcBP3y+X21B7/a0r63pf6rHh97FVrwgqDJbJGKXPKscuAqE
         qUqDzKXRKPw4cJ9Kj5NStHY0uofw10Epoig6XOzINuKB6k3Q95C1E8grCkNVDVPylK29
         cZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740979963; x=1741584763;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2NFP4i0eiaXBl33yIm+AtKDT0a6hKHp2ihrdOo641g=;
        b=txkZ9ojt1YsOX4nrO0BJ3h+7OSpQeBLsglFYV90D0yGSqdiyN8L7QaKUcQXB2MszDb
         MYfb/GjsdpCqmHSvvvBj+x7bxCFfN6+08LBmHG/8KlP0+lHXeeUX0/BSszZtBZanHUAF
         XKeDPnLhdjuAtrbgRP5/gkCYWZ7wevY33GRejF6ega7BM5THiiq+cwvtDEN5Ew79YOhC
         XHVCEVqPn5QTurdwHnI5ef+2/hLFIpRmux5MGwQtT6Apg7V8saFki7CrcatymjEO/QgP
         i/aPJ4faIILFBTswXg1qIGeeo39fkUVNbSKgSlm343lN/Zmp4UQAtiMBLT7edwCSg/qr
         Ln0w==
X-Gm-Message-State: AOJu0YxzsiPcaUkS1gnvWnogkudkvAbYwHooy/3dxtnjEtWXOwVDloYd
	DUvJV6sTAIKcqo0QTc+GIv2+qLlcOTybF6hSksn7rNjzGbew7PlXy4Pw
X-Gm-Gg: ASbGncvc8ih0dRBwlcPmCWxTdLN2JOnNeSZ3kQWunmB11x8Ov7kJkHyZi97tqxU9FZz
	hEH5REy+tLcz1aHy2FqCHBucK0L5byDqeO3BdZxItzXXC+ueSuJCDOYpWVNoCqsFNxygggJiDPA
	PcaV7gk07NVKfQ+I7I4TeGxWQrhHkoa8uQY65JDcV3j3vKbviKDxfglHRc+COk3bC5QfrrhoFLN
	s2NKA8XwTgcl4IiuXbuV5e/YMZJ2hgM7EtjeJiZgfdJ0nkOpz1Z1RgXNMFQXblQ7bPEzFVqVRbk
	YMlPfnTLIXs0JmXhNppeylZNyy43681UeNnea4IJDjIWykYKVPVlmpKR
X-Google-Smtp-Source: AGHT+IGPXax6h1U1SwNZWleQ9xbIK9OshPFlqvSx1dW8PErqO+/0ZeZdF2fpE3cuB5GIzqzjtMPEAA==
X-Received: by 2002:a05:620a:4148:b0:7c0:a3bd:a779 with SMTP id af79cd13be357-7c39c65273fmr2210778585a.47.1740979963335;
        Sun, 02 Mar 2025 21:32:43 -0800 (PST)
Received: from [127.0.0.1] ([20.57.71.195])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef5c0asm562837885a.33.2025.03.02.21.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:32:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 00/11] BPF path manager, part 5
Message-ID: <a7720d06-204f-9f3a-6299-7ca5ee7be2ba@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Mar 2025 05:32:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/13623533080

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/65991e4e40e8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D939439


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
