Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9336492D
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853822; cv=none; b=uUWbCp9ktfIH1s3T/lvXQzrPNR9r1KiH5iyetMhav0b3IDd60KF0oopx87h/aSy8ktxGFI6RJZlqTftqZkzxAIjXu56I+brvLoiTXwXZUrz/gVgDkvP9rnOPLot2uxyBqXFmIK0lnFeKGHEyDgE2qziEmJPcu+6XM/q1XEx3DfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853822; c=relaxed/simple;
	bh=aNz70IwvAN2WqFF+gWmODutU2Nm+nIu/VLfSRYvJne4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=j8GgAHKm38d67u/rGtZiVFJqE38KLYuRIiqU4wrRIEbVm91JxphPAa6blVgTOhzvUzibLZjTFEThcmiw0OGt+tVTEpyt3eLH7h691BBlRuirGjkXWDXONeqC/Zqojji4bGLPlgo8LHpalvqTCx/a7KUU6Q1sNjbM6pXO2hZXIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNAf7E35; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNAf7E35"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c1632faeb9so7415573eec.0
        for <mptcp@lists.linux.dev>; Sun, 29 Mar 2026 23:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774853820; x=1775458620; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsOkJ27UPEag9tvaBvRn2JUbwwlGt/gr3QTFEQaHldA=;
        b=WNAf7E35AI4an66fi6lYwoMfSCJIsEzsfdGdR6oSW/yodRoCZIpdYw3zSi5DrxLrsG
         N4ZxYK2xj/6kfwRukKXd4P7q4wmh0JMAROoW64G3q8SyzXjIrGX3bkzvEr7RsNTG/OlF
         s9oX8ugkC63oGVwbDUpiKoLi3eKfOQ+2dCUCo2n3QX3a6p1ncZnHAPuEI407HMqdjzHu
         mc/BC2xmWkvm5xTZLqnWhUOdTKgNfGyvSxResC2sg/vrsxyvGesLCr9sOyOiXPQu28Pj
         66JK4E1oEUVLkMY0H/fNgTt5VBPWMISaeBDi7soaIsbbmbDQMv2yl/yR121jPIjALRPI
         hvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774853820; x=1775458620;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsOkJ27UPEag9tvaBvRn2JUbwwlGt/gr3QTFEQaHldA=;
        b=Bhk2lRR421Um8neWhhSF1AcLNX/GkViMzTjMZnwm9egCtbtDiW0K7osC+l0B/eF2jA
         xipG1AjYk9BFygrURU3ED41CG/Uk2EIunnwX/UeD5tproP8RnuehHbGd1jDNeUra7nep
         sXcTQ1CQdC4/bWTJW1aY4ukiZiZUL/vDJcnPmo3lBNAhHWsH0DHfd2yXXg+AIHZCWxLu
         TPSOsjEAIigjVnx64anVfIyQfQjOrgGY6T3jzDhvMCYJ80URma9lnkAn1cksVZ7OLQmP
         Al4eckudWc6EWV1i+JtIDkLCgpIVRduluVkXldi3vr7GWVizw/AOune3Zk9KaU7j9uzz
         jiMg==
X-Gm-Message-State: AOJu0YziZRgTcoqIYFkw4HUAj67BAfOOgClEV+LPiC78QNHf+Jt+QWQi
	pbpUHswmxqYtWsbqYnHWv0tcRWWixZWoblwj3plf4brfLa6XdKsTLIfLIVng
X-Gm-Gg: ATEYQzzpq/lgX3eaUFnsVd36T7oI4jVemDwC4e0bPQNxQkTYuSbIy+4WYH3p2gxj7fK
	ZL2skEP+9NJwv6rcK3hEyT+Ifg8c46zGnsAZf6GkxZkM5Rq5QFMxLY4NZoaOzjb7GaXXLcTN9nr
	vN8GrlmEpFgSyZzTNfDbVHDMD4UpPIqmWnFLYoIixLCN+7TcFbg53SWk1tz2bPykiqt30XUMLaN
	Stjbxg299PWAeMF0eqMWqoT5kGM+KGjg6NMvJphxoCDZynuuhxs0Nnsnyj/PYYdgI45S8OFTk51
	0sE5ZYo8P4yP6f84jrj6RejBT6w7oHZnYodpEmWr2keOTl/Vcg0Z8/uT2Tn0Jn7X8MWcW+vP31X
	mWlqRbVkjO8/c+m3ljmqrlbOpoFmo7x5u8OG/FYX5A7g0cZEd2JJgayIOyt89w3uXewiyd+tsQY
	tfzieoQwvofryXUys7EDYwdE/2JtDcnCGcAqslkA==
X-Received: by 2002:a05:693c:2b13:b0:2c1:778:d897 with SMTP id 5a478bee46e88-2c185dfe901mr6184385eec.21.1774853820100;
        Sun, 29 Mar 2026 23:57:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b272esm6195331eec.15.2026.03.29.23.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 23:56:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260330053300.15717-1-gang.yan@linux.dev>
References: <20260330053300.15717-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-net v4 0/5] mptcp: fix stall because of
 data_ready
Message-ID: <ecb73b2e-cff7-851c-c6b9-75d596a7b9ca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Mar 2026 06:56:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_fastopen =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/237299=
81055

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/723fa97ad85d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1074352


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
