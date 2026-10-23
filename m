Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771726;
	b=y8uQpqxDUbEWvZgBJF341XdRjqUKBBbcLkN7HApR5vMQZN6ePHYCwe0wlILPW7QyH1a3
	 aDUiuR/5kpshCs22+HtpeISX8rUDppz+o2IE7FzBzQqRgmf11piiINlq+BC0XanxWX+Ju
	 CTGgq8+MVwMoMK/fYILJ3AFa+q1OBQvPWjrVdjpdY7InWLt5xOV6YZN13w2ipY/b8YFME
	 GKHbfyvi9w+t+h291TOT+a6WNQa1KSxMMV4cWcuaiA3dKGLgUrV+hbhYiJAh13RvVpW8H
	 a1tRlFO681RBOEnttWfdIPVo0heCJmLHPD51EtE744yR6NMOui/yvDb4WyUGILz5pjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=LUCiwypk+d1NYe1g+fJ7OLIy7dwGFUhoiIysH8RimDc=;
	b=bn0Jt16e6mj3hl+QOiZdpSpdwdtHnq/doZZJOQRlwhmNd+Lp6k/oWANPzdd7AcPs26jI
	 FPOUfKrOAwAkjnJJnzJz8X2RzhPd/Rm82Er/I31Sbedjw07/hzwz5k96NjLHjpLQetdhR
	 ZTg5u3Klm5I+uLI4cN03mUU/k62N5LmKrzmFTe4tlOhv/pI95O+5rCmf+uxgmiFDOUS5W
	 rK5WVHjPVNCWIM7SDT7t7fWxmZQTL9NrJNLeC0I4+n3d2mSNEhoUGsYsQJCDezWk2IFio
	 OnuenhYE0gq6lN04w52933+9toz+rbjRA2rjrcgwrKtBbRPNl3QnZqaAv/S7Ksvnrdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CuzPr3Cg;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AB606A31B
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 16:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E30AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CuzPr3Cg
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so779127a91.1
        for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771725; x=1793376525; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LUCiwypk+d1NYe1g+fJ7OLIy7dwGFUhoiIysH8RimDc=;
        b=CuzPr3CgUCpX+/9FY7jxaIvC0+0SEsf2XY04bXrGKyPBUGUckvYtpB6VAtc6lvjGqp
         xg/UkdKr4O1P45TScjnKL/uQXqy7VarJ+VdCVRuvwLAwsuXLwI59vYCUBE6TJ29damx+
         GF8AmkZAF3OtqIXzAkaVtCsF38V5xeJCF3lEu7I4FjFr6jb6z92JRbTvjabNFD3jgOtW
         C0V7x58dYM6/Jxg8XUSPrlXvo+5J7Nop0Zp+SWqHdTUmsEExAFt/E6xh+taZ6kj+txU+
         gXNp1YN9eF64ckQgjlI4KAEhLmj599cq/6Q2yCGS5cGG8PZ+fJMQ9dbkFYMJuHza4pM9
         Z4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771725; x=1793376525;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUCiwypk+d1NYe1g+fJ7OLIy7dwGFUhoiIysH8RimDc=;
        b=a8Ssx7ioV2qgSRvAaH7i3uofrUGjZJBtAgkA5XhfrV4xYl7Cxk7z7sgsEsW5KutAl3
         tRxR5RRRE8xKkVhPY5rt+CwvJv5PK9LWaIuedFp16o4pxNhAotL6RIVSpP/aOlgfRwl3
         JtKDGFSAHR7VBs6M6wRFf1JcxYDxICSQtA4zbLWO+yAGdExa9h9F0ENu0K72A6eyRWne
         8WjYYZeoYhvyXZkETDEb0+r9IW1niKOEk+TFtiqxwSyejq1pp3vw3q0Vyrl//JFKo+6F
         WjbKg3QSABUqkkNkPNEkofycDsyGtsEJV7ofFU6/5/SlEQ658OBVceJpZ3KjIpKTR2Bk
         Qkmg==
X-Gm-Message-State: AFq9FYJjqz7kcyCi3mpJek45AD3OleOwF/3nQ35PRoTGhmgAS4Q8cife
	mYmlezwZscvAOYoFNsdTNEERgo3wnYMliA8eKIKoZs7gEsZ2XRFGVG4=
X-Gm-Gg: AYBFou0FYUMogVRHGLCnSzu0HMJwiY3rZ+VhrsYja1tJIiV6o63hIgA7MPuUNHDOKFw
	zcb5Szica4naobbojHJ0Dp7M7wm51qUxYdI2AhBeYoma0ATc+/ptc6bdAyGZO2CETYOQCWIRN7r
	60E5mmj/N3L7Kc+BU2u5c/cQHeGiopHVuSqoZGLSBigPmO994g68tvxK2Gv3KSO1mXRzEKWgTqE
	Uv3dd5RPgGroMFSOXvaiwN4DJrfSb5461exT688/+zsHdS/zZOYbhm9eS4DN+5GBDI6xP6SLLHO
	QPMzO+oMp0r2TQN5DyyjrSaHfced0nvfotHLZW5bQM4cwDkMI4wKhzIVPUH3q/QhzMO5h4WZOJr
	aSc0Mop1EeSsPGq5TUJEChoHLp7cDGcC16kmJpiW519HOhLTKz4p1SN2j1EoOrX1kOfARw9b8CD
	RpyaXCL5tQLn6ZEyLi6abFSS6mFhAb3sqUKB9POU/hP6QPR0/qxzHkneLuZ/k5N/bHp6DcwlGaA
	xMG6QLjwFCxazZs9JOKAORMDcwQdPH5Nfs1KqiaP6RjZs3Hd2qnHLebDZqCQxItO1ISbDxVEdwc
	WFGyZ6nbsEpbug==
X-Received: by 2002:a17:90b:55cd:b0:3a8:49f2:8ddb with SMTP id 98e67ed59e1d1-3adce159119mr2286459a91.60.1792771725160;
        Fri, 23 Oct 2026 09:08:45 -0700 (PDT)
Received: from github.com ([57.151.128.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ade296a8fbsm251198a91.1.2026.10.23.09.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:08:44 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me>
References: <20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: sockopt: echo until
 EOF on partial reads
Message-ID: <5f0409be-78ad-bda0-1f6d-78df42302e38@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:08:43 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/39975743414

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/05ff40565a=
5d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1192207


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
