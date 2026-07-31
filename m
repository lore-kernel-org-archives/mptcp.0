Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20457241695
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 02:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464275; cv=none; b=oeLj+h4KtFzzqM0KMyyDo+t5D3EJb1pgGrc0jApa8ULDTPGhPpvkxKGll2ldbshHTeh4lq8lKLtelIlwTa74rkhibJn+E8hnb9oAYeLm8ODabtqfwc8m1UQpu8XV8XKsjD/wbl5oFgnxRnhVhf3qAK4HzIyc4Mzo/angb1oo6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464275; c=relaxed/simple;
	bh=BMeEwqW1zpyw9vxmgwOXuKUN7nkpusrblOld4mEjxbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=szE7ICezB6gMEYXPvRdtIE+BiPL7kFWGbNYfDC2GXyvuWO/sFTnmA75uSJQFM5uvx3kHen5J/F5cTYU3B5YOdMuzempu0mXBbkMnyCqg3pFZjJeKGw8fQr+LE6hpz+WP54hXV6dIjPZrmZqbZ/ykspXhJ4fObOpmH2nohiKPsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obzh+/oc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obzh+/oc"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38deea72eebso529936a91.1
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 19:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464273; x=1786069073; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VBCZV4Ilsi9njHGlyKCqPY3OmNgsgpYCwcuSgFvnOZk=;
        b=obzh+/oclyFmTEQylVfaSFSt1c5sUxzoSopnU41Nb8JQQSOSrwMQqwq5i37wCSvbvU
         HHOI3Gm/G6ApY7H5sigvbRKybl+ivL5Xr++d9MLYDCfaNtDLE1YVjyl262YeN2YC1d3M
         q++2gSD0PCU6JHV3dBD5slFCJoeAl3CtxBBuNPZlbKGLWBAsC5S8N+Xfx5t6G0STfRTP
         UcuDt2oYiyHrPqsESqhe16UTHdnSDtwQQ3BlPQXfoLNYBFSmR6XcCZgK+eQXZC8N+7W1
         THtMXeOFbM8CwOKYBPgcDzIDNrWW81jZPl0Pxc6GiZ7IdLJ3BCwVH/C+qQoy2maHjq+T
         ypWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464273; x=1786069073;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBCZV4Ilsi9njHGlyKCqPY3OmNgsgpYCwcuSgFvnOZk=;
        b=I85OTJouZCZgNJ6uKoQ5frcU4SItuukaY6i7dOo3HyYWUJLzZTpsHrGJ9bNG8t4cjx
         AUnaYCURnA1s5Xm5/UwBDgmRz5LgaB/ydqrUnAu/K2LsFmYY9xpoesPVv3T+lf8WF72V
         unX3AtL1S4sGHx26B+wtvWw1AlUsEibt4G+UC6W98al/tG3NzoIA87JUP2eDxxaaeum4
         Q0IFBCNIp14oI7aOgHPrigOYOVRke6T8lKg4y/SHnBKbLEVHa4CvJqgzSqJsqxc5eNp3
         UK9NBDr2mtVmT2dMoJLX9qi9KxgNZ/WQkkO2FRXYVmBrYDRVGxTqjxTubPr4Lrjrm/mY
         I6mw==
X-Gm-Message-State: AOJu0Yy15HAE/OV4kBX6gIRZo8KafSLjqJ9cuBhhHyY5/BwNsziIe4L7
	4TrrR3CWH7JgMfCprKwaqUnbFCuvRabNIojqo6XE4W/rlZxj9N+l/soW7zNV
X-Gm-Gg: AR+sD13SvrPaNFqih8M2aIFovZjnFVwoL6CurCYdiM9GmGMNqiYIeGx3/TnkxT8hXns
	FLBEM2LcxV+GLc0wUPvATIhzXusj/O7KfeVeIJxXTVX4lkQjvVheTw+2jX0P7uYVARYmi/0iGqB
	Ky4JMio689KywykF/Iux/fnehYKRhFOBwpyH7QcIZgj9BraZowC2O0nyRm3lqEF7ij2kaNUVa/1
	kM4IKvO+5M7Bf/kUTIzXN3QOE6c04ioAebCxmFzradTHn9aLUS2NTeNQ/n4SFVSw6PyNZOwzU+R
	LqOHj5KUgxEg1X0FEtYntD/MHtK4JyBxj9Hm0RIwFdagLW+8W6QHOLjjm7Lf8jwwbvJ6BrwSAbr
	f9SmqtaCy9n+/JTLNszxfdeTPJddQctpb6nlFlbIx3eRQdCx0BpggSFiYXkM0sq9AURVYX7vJ+e
	QNdMpnfTGxAemn6S0wp5EjFeAZePXRCesE40AAfO9lIKk0v3c23/MCsiHlBHlTq0hwXo21qmOrC
	Ms=
X-Received: by 2002:a17:90b:224b:b0:38e:3fdc:62e5 with SMTP id 98e67ed59e1d1-38fb11f8994mr221141a91.19.1785464273302;
        Thu, 30 Jul 2026 19:17:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.125.136])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153aedee81sm593885eec.26.2026.07.30.19.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:17:52 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1b103d397cf4a506c608d9ade586e98db770daec.1785460213.git.tanggeliang@kylinos.cn>
References:
 <1b103d397cf4a506c608d9ade586e98db770daec.1785460213.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_sockopt=3A_add_?=
 =?UTF-8?Q?is=5Fmptcp=5Fsocket_helper=22?=
Message-ID: <373217ea-b74b-934d-4210-7858f9ffeef8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 02:17:51 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/305966=
26106

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/87682d22935c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1137792


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
