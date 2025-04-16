Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E023BCFD
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798805; cv=none; b=Kpnu6Vgimhp72HF5hkcMXgVeJiybEHFVzA12vOpQdYJkONMzq5FvDcqQtWahU+hKMjyOKYSkQGcJIEcboqGK4TGlZ/7zk+MjOgFeBVuG9p/JTyi0YUKdkO9AuWhTlQm3iHFM/jvmmHXsdnwwWPtY4yOfK21zYUuv8uej+J4wYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798805; c=relaxed/simple;
	bh=GtgHpmy+sFejgTvhTJOqVI59kq+yfSphYqqiwn9PUSk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=t9spDZhJWb0YEJB1IVuAC4XE2rouQ/pyjWa648QBYKqsZuxSuLFb4ypd8trmD1Vn1d6D8ZG8bfgp002c92b8DRt1j31S2wE0DqGueGLG5WD0BcGgWuTjpnKY/yHYpUfprQBfaNdC55GBHdsZHTeBytFIHGRI9VWSAQIbzQQeaN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZyiS2qP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZyiS2qP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33e4fdb8so5296615ad.2
        for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 03:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744798803; x=1745403603; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ689EDU/Kc/3c5TtpFSEZLornUqziROab5g7MyO/Hs=;
        b=kZyiS2qPvAsK6e5XcAVDmhc1FqiVkq3GfZTuTBiqaFACcoexouvRyQ5bf0rzyK0iGZ
         wjJeMqozD+rbhoGbACOzXL/jd0pkr6RVvYI1pLWoOK7QeqCyrHz029MfyBN2v2dKSU8z
         G6laGdPHVxYqjBvvC3grSwvrUKbt54TbRj6lB7u/2Z/qZUFw+L9cPBABaxt/AM+pEg/l
         ZmxKfqeT+DaajJvsqqqc09gxGnzt+ZpDQb9D01sNbevy2bs9mKlcjeT76ISTAeLQlygm
         epAMWb9qfQgXvxcCusJx4cWTh0fYuuCW8c2bfvATfwdzPxJYwP9uRy6yoqtb6Ng34nIb
         mhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798803; x=1745403603;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJ689EDU/Kc/3c5TtpFSEZLornUqziROab5g7MyO/Hs=;
        b=lozNuKxPWgFdexFovAn9AiXxiZLAVOkOS8ZI+zYX1Lny8NudXeww6cAoEvXiFR3Fg4
         gAaYjVIsXD8sjkSqsmrKlk+ZybkEzjogr5gWkPZ+tMw6uQcTvqy34ZtdAwScYJ+5XfAC
         f6zqAFfW8m/0/dj3OzVxI1fJtWLTYRQ91cRoq5pt5RmQrtkfgH10CY0EY98hATBHqHRl
         iSalVWu3DlYWJdOLCBzzVhCi7Dz+t1SevWQ75zBZaFGFAI4AERo4oRRzfXm43B+W6Df/
         6K17ptH3UIECdY/FT3u9W5tYOdSARmdQ04RZ8x53V5zA3RSwR35NDLL5WQJWkQH92MCY
         Elcw==
X-Gm-Message-State: AOJu0Yy0U0ftvwZtXbtymVmJmSLdC8r70kz303/QB7XL2GPlEpfcQojf
	kkTOeposSpHnbM2UI+0r/ozIh3SZcPHRxiBhl8nBh7orcknzas5vAkrF
X-Gm-Gg: ASbGncsBbJSZEzCopUiiG6ti0Su4sdDGdL9dh3s5hulRxJni+5a8eR+C0OxT++9RADw
	ANn2LgNoNn6/Ab+jdOR14q4nGISgvSYAevf5MIdaSJCFwpzuLiDP6rX1kgnFw5X/ymoD+CraKHD
	VQza2Dq3lSdNgDOVCjselaLTqdYRp2MknFNiNVNmlDDVwH6G/hw/mM1EmLGgRXzr82DPagivvRq
	r36ZRIKpftRwoI1EVBh5cuNQsFTvboLkuCRkf2sZSzO4Gjg4BpT7Kp+Vdn1kpSfs/SxEx/mFweW
	zBnzKZGYU2DTwmhqn2W0v9LsbG49nd+3v2Sfj02uBSDQ7+We/ZttP3U=
X-Google-Smtp-Source: AGHT+IG4JW00Ze5hUwZ4nkUAMgFnLLmwC424zNROsOAncaWaKgNR/4kFR2jITT6nfeRI/hTwyGpLmQ==
X-Received: by 2002:a17:903:24c:b0:227:e74a:a066 with SMTP id d9443c01a7336-22c35916cc4mr17129855ad.28.1744798802890;
        Wed, 16 Apr 2025 03:20:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.103.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef1c07sm10336595ad.45.2025.04.16.03.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:20:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1744793332.git.yangang@kylinos.cn>
References: <cover.1744793332.git.yangang@kylinos.cn>
Subject: Re: [mptcp-next v2 0/7] Add 'dump_subflow' test in selftests
Message-ID: <c4f308c1-94e5-0644-d016-f4dd35414a5b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Apr 2025 10:20:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/14489098858

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1fd8c63c0c7f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D953894


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
