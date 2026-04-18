Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58F40DFB4
	for <mptcp@lists.linux.dev>; Sat, 18 Apr 2026 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776471331; cv=none; b=iB7LaUWgLYUdGr5g75wykdKr2NvIMAHiylE/KJVKk0TdW+XWpP0u5yz6eeSpPNgmrNMF8834r0Mh2f3/vpI7VXolMZXZeeYhIJY4K5+jJ3ghw/nKQn4aCun8twX3CqsmhiJoPpAEmWCpwBa45JmeEgzKiXCmM2v+cvjFSBCQS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776471331; c=relaxed/simple;
	bh=PwMxp9YS7jzIOStqWSYDZRzvCwTUeWzQX8LJGV6H6Fk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WhcWOi5WLFxs+9rKIJhdThO51aH2kfxsp1TG+yIOR/asWZxN5pznJ7mjTmLQO4rKRmqDF1umz74EbQ9Pxe5AfD0gxsBwDj4cYiE6+mAy0Oc/4Pbc6pCT8Gs+SLQLJj+diNIiBsznSORsmWqphDm1zurqJtj6CYEeBbUeEBSgASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lE3dBpzS; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE3dBpzS"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1619902eec.0
        for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776471329; x=1777076129; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5wac2m0R6BkfnzeE1Q/aEcApRwn7MJRdCjY5vf3H+I=;
        b=lE3dBpzS3AOd7XRXfHTP5Vy1uOsORzZ9C29L9aO8CcJIB/b/vF/4jfltPgDmUhfRod
         QJCSolzud/9jUhNxI35oQ66az1zJMqquFp4yfr9+KqQ3MisAF0+k4ltO3mi/zMEtIHOr
         tzS/z5xLLpKnzboXcf4USc5wNbRCNPP4m6Q/EM4lbtpTJsLZKTTKcShNx1QolxH+XIIi
         xt8LCR0oKvigsa6uJLc1FkD2fgJUnAyQWKdRTgGttB9OwcIColBzOM2FARbVzOVRQegY
         oktw5hn8toMtBZ+xjyItqzaemra2OMwJN2rROSdvoK/k9R8te2e7z7cVDVZiVSVOVbLp
         4hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776471329; x=1777076129;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5wac2m0R6BkfnzeE1Q/aEcApRwn7MJRdCjY5vf3H+I=;
        b=hjRHL+gNyi2PVWIBZXBy0YwHoKOgBH8NpOhxujeC2Mklo4AQaPvohhGiH8IQt4aCD6
         tR9QD5/sRNmkV4I9pbraBCTVE4Vzy+CvCm5yt93wzXVDxN5/6QbJiWlPhJViPtb/w58V
         15ncZiOSqnF9JwbexYZ6BSxoz5O5xVl95UanxrDtLSBPjs641U1RJjwzjfR9Y5gS7zPY
         +IwcH6BCx6NmCPFIRc1ortH8uqSalcJfbLdiavv2IBysoRtS6QuIlM4+X4RR0gxKn9AJ
         yfKo7TQmdL2Ussx5WN++Jj7Q8pZ0v2o9dz/hUB6kcD3MNyaynAu8TMR09EOb53Bw0c9M
         lCCw==
X-Gm-Message-State: AOJu0YyEYKbeRIQ+ztgODcFtlVt6PW8xDnjqjObt7sY9NO00fBpOuxW/
	cT/3q3d1ZIpi21DITGesoebsoq0G1p918wqOzbpFIFgB0aUnnUj2ra5oUUhQ
X-Gm-Gg: AeBDiesuhzFuWjvztTP6EBBrL4cxdoB0GTMkN70Nu1QeiYqxhkU2rQPafPq8JxjbEj6
	W691dmpsLFe3w+EjPCe+aY9p3jnX40C2DJsimoi0BetlsqkURhwomZAZBFsOniJWFSp8emtTW7h
	2k+gUP0O+XsV/SID9FD9oJoWKqkFi3XlMp1mqjbn1WN4k+3Fa5Cr3icBhYUOWAw29lm75QUnB+J
	RdD0aUPD4aynLCZQfPSc3GXh58VgoYgXTHvK1w8dfM77V4bIKNn4QzMLfPsPQ7bDEjMccoLcFpB
	jGCvJlrc7stw7064SxLeXMWy4fxgNYVW1Wjoks0B7GpXGFeo5xXYns2dRv76RgP6O7BUPRNojvR
	QZwljN9r1VT2GJcMg5Fd1PWL8ab00kFlIQZwUqiDpkWA8sjB9Ya1twbMp+ENNvbmtsRqXjin+8w
	/8OaTnn6JLFcHxRWN3HilfDfV8tqQCGqIEZVPSxoR9Slj8f1aK
X-Received: by 2002:a05:7300:fb94:b0:2c4:61be:1d33 with SMTP id 5a478bee46e88-2e464eaa230mr2467442eec.6.1776471328806;
        Fri, 17 Apr 2026 17:15:28 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.11.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e536e54562sm4418278eec.0.2026.04.17.17.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:15:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1776466833.git.tanggeliang@kylinos.cn>
References: <cover.1776466833.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/3] only remove entry from
 local_addr_list when sending a REMOVE_ADDR
Message-ID: <64a09241-edaf-0519-ec03-5a8526ca608b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 00:15:27 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/245910=
44565

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/df304e308870
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1082700


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
