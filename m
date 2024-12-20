Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A9199E84
	for <mptcp@lists.linux.dev>; Fri, 20 Dec 2024 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688203; cv=none; b=HCtX1lWPZSg6JJb/mDse05PVmYsV2g/eXeXLM2n0zCxHntxOhmz/mhzm37pamS0NRmdDtY6G/AMIce7+w0nYQMeG1KaXCdt+6W82j1AapWGTafpPKf3Za0QpQx125i+QyhiTQDNQfoUH08KZ5XyWjTE8CJOtv75uWvOMSm7/Kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688203; c=relaxed/simple;
	bh=vnvX8RdV5a72eNPR8qpuH6bW/s8MjO7mFYN3A8u9/c4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZrgqIB/m2tQeqY6En5bX7gnwVAhTH6NEvQqEbyOKBt0Jff3DxTy5O3xRmkRnkttXn580SadXz+RqYvN+lImke8gBc31DLfU2EJcBDqfHQ/FNRwYOChdNxGBQnd2az/3oFFKEu+FcpJyvzGKNW+Tc8/tVZBLB+fWqiTM0EZYrp5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiHfmOd0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiHfmOd0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso1234503a91.0
        for <mptcp@lists.linux.dev>; Fri, 20 Dec 2024 01:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734688202; x=1735293002; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7id+pbwD/Kgnfx8+o1H9rOXX4WXrTDlQNGhTv3CYDI=;
        b=QiHfmOd0HM4lKCec1JmJviJPSybMFZpuzc09s9mUlXPVe9jdPIOBEFcLLS9+zoyj7R
         oeOFwpUMbE93Ksrtq8pQOQWiE1BxMD3UhhffWnABUiuStNhFbHoe7wMy2qHSDQziW3ej
         Z/H3nlWgI+AW3g9r/zDSqyxgNJeAOPZOSJj6joBqhtklepWCRSAsgLLAqSpAXIn+qVWp
         gTvpnxxm2r8fRHrObOS5pQ0jQ6qlJPrlQo19n4O2b/+zLOmzR8zqY6zdt1nqPLQuK8vQ
         8Hyhq9CvJIwkCx1gvSR8RpHME/Mzf/1r+XRrr71jFhu10y9Q0GKa5CDslA+Uphfd8dSz
         r44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734688202; x=1735293002;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7id+pbwD/Kgnfx8+o1H9rOXX4WXrTDlQNGhTv3CYDI=;
        b=UTQ479fELR2UzwfNW3p2ZdXf0zqR55vN7DQK+9hrlm7yTj0zpH43jNV3JsCMjV7co8
         SP997FIu1YheBV/SZVlo58S108zcbehEKV8zMDiD23LounA5NL9dNMj4t2GkAdi94x2X
         vq6wEReR5J6gS3yLp0mJnHamOZmj4a65oCygb4DS0xl87tWTq3kute2iZXYgRqt3Qxm9
         sadg8NRxcCWaXaSxQ6Ui0poOUegVxB7p1/4Y7TZiNWJcNy3UOFFigRLYCmO+R6RTB8ZJ
         xjitfpwTXUl0mYnNpLLi22p5O48T+/25xEqHgj4ISToj9sVoA/P/oBXCFIU+c4r3yMAe
         +Hgg==
X-Gm-Message-State: AOJu0YwQ9htVXBt/qQUXZQzSVY0ppaLp1tuTRYC/aKZOiSmnqFWZlkEM
	rou/7OkXrTauCMTDpuRKaDBes4uL89BeA4hB1nK2ts8c1RK0wDko+KPL
X-Gm-Gg: ASbGncvB7hb+NpQy8Aav9DusIjPXDDhj5ZgWnlclTcL9sglxfc005KVXeA+atd8p8AR
	ygT6VAOg/uw1miCs0aplymD4xSL891SJlF+VAAMFyYNJfbPiuHzHE+3IMaJ/NSlQbd3By1+BhdX
	w4Io7IAXqASUaTlldiH1O2MlHr6Nahjp3emK8n57rvWEmuQdnCXkl5aRrcDENhSk+Gt6gdUtdsl
	8xiXakJ29PXyb8tKUcn4ZTjizHprEZEPMZEQEMjWFVg4yte13iGbmLe6UJBhgOUdgw=
X-Google-Smtp-Source: AGHT+IG9UJRIX1m/bd6cWPkM4ZIrrYT64gp/Me0uur84057nWHjnNKiWjv0ZXmgP3RgazQJKRApwMA==
X-Received: by 2002:a17:90b:548f:b0:2ee:8aa7:94a0 with SMTP id 98e67ed59e1d1-2f452f014f1mr3278024a91.32.1734688201712;
        Fri, 20 Dec 2024 01:50:01 -0800 (PST)
Received: from [127.0.0.1] ([20.172.7.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52dfffsm4820044a91.5.2024.12.20.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:50:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a2efcb64bcd072611eac0dff346af2392b3bcb96.1734684556.git.tanggeliang@kylinos.cn>
References:
 <a2efcb64bcd072611eac0dff346af2392b3bcb96.1734684556.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4] mptcp: use GENL_REQ_ATTR_CHECK in
 userspace pm
Message-ID: <2496d2e3-816e-b883-c19f-4df1eb50638c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Dec 2024 09:50:00 +0000
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
failed test(s): bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/124285=
99219

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ef92339edd23
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D919775


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
