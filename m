Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D7225A3D
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264175; cv=none; b=cIo1nxXmiyniLU/SfuXmt9BtpEta2IJQlULQ+BaGJgUbom4HhwVzWIOXtos7YHbP/e4mltGa9KojpLG415U2msWxNxKDAlwP0BitX99Ps0i9irdpO+TB92t43FNXwy6eVPtgSvN6YdofDbF+hwXztEs6KgNAPmqa7TQRuslcYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264175; c=relaxed/simple;
	bh=Nw2xUYLMwwIlCKlDje+hq1lRvGLMWBGh6Nzji5DDJlU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Q9cIXbmSnZg+OkpnIro74fqZYzPYAgAW9KiUMImsATlXHm4ODCP5wl12j0ltBo1rg4Y/tWR63bMS5vIMGxizlbDv+d5cxIQhk/TGSVaZExlqL6gXXoh+GGNzDL97i6hZBi18W3fA2KxSbOrOdvsXG8cx+triKU8bfZlwUOKok8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQRrwtlM; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQRrwtlM"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-93e7ece3025so230718939f.1
        for <mptcp@lists.linux.dev>; Tue, 04 Nov 2025 05:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762264173; x=1762868973; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTIyavlMhBFfYd0AEmFa/4H8mTKVsQU4aiYOmI49upE=;
        b=WQRrwtlMOnRI4I8QYmXSDdBcXiuVIpNp+PHodTfpi6cOJp6P6VrqL1qjxq1pkOu2z5
         /IrfSdIYwgSTeuLIQbEqe7FPFO2ZR5Kbadds80hg2YbV3GotvVCT03Xae2OkOu0nzPaU
         tCFMLwIoKYDbneYeqrRxpgT+tver47ygb989CNfQvLMJPaSh2u6NC1VVTu6s5Mdz+1xE
         UrIVbFY6sfI0ZS6VdPglfzU5p1p0DU1fC3wNtpQgFLC/L6Z5t3Vkf1RXxqgpgWVhiLSt
         btDLCIPq7McNmnHcXzvbJrD/bLEGHRq2/HX6tJs7wTdelEHtyRsN5d+T9p3gHI5AzcjO
         x+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762264173; x=1762868973;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BTIyavlMhBFfYd0AEmFa/4H8mTKVsQU4aiYOmI49upE=;
        b=bgHRIwz7vHH6yBJKyj/78dnLVmORPf+Pe88catkvbQDPz0hkpy1XOFlPzF1CkdAO0h
         1zHzJRxKC63TtksXkNs04/781gldhp9aU9wYpSFRoBvik657q8+FUOmVqFeX5XkEWVi4
         JMrFio9TqUdPLiIMGhBthSxx1iioULqJpwGWalQhd6BQ46pEd1hgRlq1YVYO3L75bDTw
         bbpnTku2BmaSkvrycLN46Szpo4lemLxqmR+3pIGIBCh7Ggrff4bC85vV0ewQQT49OeCz
         wFxE0nJoh7ewtbYnRZUt031US8OZtS1cqyk8BL/yNAz3081WLV4CWhF7up1o9nJMHOYz
         LQOQ==
X-Gm-Message-State: AOJu0Yy4m6zu/cT9TUhYev8krDmYpVwiE9rG6+X+GbwTFIZshDyH/FCB
	iDuqUQ0Ovyv3DcEcrEGj9c7aHicOnXdvADrweoQH3fq1VxA0WPYUP9r+pb80
X-Gm-Gg: ASbGncscnMcY99nRef4+qrk1r0OYaYjVe8Gr8PQdm9MD2R72aw8DMlQPM60wQAR3pc4
	ILrRFLBmMET1mUp/bS5AueZkXUdu8kuoCTL/YgxrhpRamiN3gue+CY5x0pzsRlYKzEDAuMO+Iaf
	x7ReRg68Zn4rm8aT0mEWEn3b7XY5oSd1ImfYcXGAYENwaQ/aAyoM7rTLm1/2M7cQ6Xy+TgZmPoY
	fMfjkpdvpIXNR1U1syNZUmKYzbagl3WnWNyr1lECqGURPDK67oRFvb7CC4t4gj/cUbi5D2yYKdK
	KcvKcmwVHkZwx4/JmGCHxKSoQTnFnKa5zaLeZeEZsk4E/KA1DUk0N+DI1fwducJfvR+B6JJDDs/
	qMy2N87s53w67CyvF/G89TVzKtALJVAm0jpyTAyAnQKt2ywB7f5rkaL0kRHKqv9zkYzkCiDrbqg
	Rq09R4InmbHg7o
X-Google-Smtp-Source: AGHT+IFykwstN/F4kv3Fc7X5rrpvcQ0kcU//W1yhn55RmdFEfvwnwMDw6T5xXerIiYm5cz9PcGMO6w==
X-Received: by 2002:a5d:8746:0:b0:940:e0bd:ed8b with SMTP id ca18e2360f4ac-9485915b653mr394603439f.0.1762264173070;
        Tue, 04 Nov 2025 05:49:33 -0800 (PST)
Received: from [127.0.0.1] ([132.196.32.49])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94854f8cf4dsm118207939f.2.2025.11.04.05.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:49:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251104123416.395362-1-gang.yan@linux.dev>
References: <20251104123416.395362-1-gang.yan@linux.dev>
Subject: Re: [PATCH, mptcp-net] mptcp: fix address removal logic in
 mptcp_pm_nl_rm_addr
Message-ID: <4b10e308-16a7-5ac4-3dbb-3e93bd5bb382@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Nov 2025 13:49:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_fastclose =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19069305465

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6546bf8ea1b2
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1019421


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
