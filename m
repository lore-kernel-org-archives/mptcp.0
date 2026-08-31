Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B9401A00
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176173; cv=none; b=bOu5+rNWx3qGvvYha35uNWXiiYCS7w1s4mDLysTc963sPpDRbR0b4dS1hl1u1LpUhSCfZqM8tFHqUfjcjeUQ3FEo3Gf1NblESKOFRuhhldQH4CZ7/8yL1rz893+oejsWL48pfzqeqLSesR6CifErrysuhLCqvLk71wvyKfDiVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176173; c=relaxed/simple;
	bh=AQv4Q1xEZWoZdxvJuDHGP3+CCgNAWYzQJ5CU5eVMFuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=u0dcvfaCMl2jLaUJUnJZ6Mkxpi7cfqaJscIrNrlEgtCcqtDYELxcOj+4tQNHqhPoPcEY2VhP2fKSZi7YvsOwu/DKPeCzD6fSYQ78rtm6OCJNi7/ozO+vS2omxBTtzPyjh29L0/XLD8UVRbCldr/N+spBWFWGbmD1Hd+D34tWecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3hfjz12; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3hfjz12"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so3327138a91.0
        for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788176168; x=1788780968; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZfcENk+i7eVwX+D57PF9O+mtm4ENv11qaHk5Opl+5VQ=;
        b=o3hfjz12JqQh6QUFCqDXvSDKsjqGIpLNrl5TeR7Vrs4ue118m6zCgENATDkaue+clX
         0p/vdtrhKx9jxt7QhHlWDBv7STHVo95ZBHB+Zyr0vVMXVtYJANmDNsIIaRiN+AwnK4aI
         HILPhQ2GNXCJ90FAQcnXqQ2SsaKJ4LxMQc8WKiaoT7TXvQTdaq/yI5FbFPQWV6/LQfY1
         rvLx7Ystpp69i66xlXNcbR40NUMMF8HR2bESW9yHkQB7ZFOY5jJr5G0y2LjplH3xoa1m
         Dl7tLrA4G6kenenDCiM7KCdwBtuctZf0z+rxHS8YLfXZH+jQDVeGcT2tqBZSMVA7us3J
         5Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788176168; x=1788780968;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfcENk+i7eVwX+D57PF9O+mtm4ENv11qaHk5Opl+5VQ=;
        b=m+2/sJz0awQae6FguPKeZILEsiPdaNtTa6xY/tw+1Km4jZahGCHaHXOtD0A6cs+Mgv
         +eLSrToT89sNROJRt46n1/m/wgJ3vxccG96YbPX2ZOvGFgRvvAjXLnKPvOEpi1tvOq0l
         S49uezUsfQDwc9WyyGhuIituklVTSAO4/qdraTsHxwQDsGt/rf88Qbo7JzKD39l5DcpG
         1HbwRaqAhsMebEU9bPIQ0/q3ioLkpUq/HqAXrQDSpmOl9CFiFiE5tHJ0YxZMh1a6+qhs
         pBx2SBgTSloPSBmKteV7Tdk08kPRBZiBO6YoiTi5OKogyv2EQLMjp3/UC5vDdjlW/dUH
         jS4g==
X-Gm-Message-State: AFuF++m9h4yI8xCDVGivMb+QSmn5ReM+22e1FkBsKlbtKVELaYeP06p7
	YsFHk4JqcvhXFyZ6x7V9TbvZc0x5XXG7KjvpJ1FvL9FvDFVOJmkAmZzV4/sa
X-Gm-Gg: AYBFou0PKkqPsLnZ91Df40yjy2nge+3yiyFtU6ni3V+Mhu0OzW+Y0D5v90jH2+KeSjg
	qQTx9eElh6f1Yp3i+/3AYhpYYnYcKyVoHzOkjc4M6Th8431cX2w3r+hky9cQz4sDZu0dfb7DzgL
	JND94pVR8644y8+jBLxMJYOLBU2Wm0TlOMKrHVVmanl/Dcbk8fgDPdHpT5D9XZ/SHE2VoJoS6Hv
	6iebc1MPkV+BHjTieTqDiyJu3RSjBO+W7YhtLi72Rsf1ez7RKLdwmJEPAhEEzxivkeNsAoNc0/B
	2sS/bZL3ob68AKAe0VjYA94pPSrxPG0P0jaJaRiDXVMNgGHira30oUSWnfup6TH3EL3XOrNJ4WL
	LwAhzQRdvS7bQ3J3zYdzpXwg4BzcaPTx8u7MiZNxJ9nMtXJeWfgikk1uemZjBql0i+u2ILr07yS
	iVyYlS5yurc9UVHCI4sNLNtpechJxOllKwXAMWCzxWoDEFYmiW/Tv40yI+3mlsmIEpa0w4WO+kF
	rtR6KyIjfEe
X-Received: by 2002:a17:90b:44:b0:398:9beb:a2b9 with SMTP id 98e67ed59e1d1-398da8c0bcamr7279606a91.27.1788176168550;
        Mon, 31 Aug 2026 04:36:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.69.171])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e41837c6sm25251178c88.11.2026.08.31.04.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:36:07 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1788171508.git.tanggeliang@kylinos.cn>
References: <cover.1788171508.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v12 00/10] Reduce the differences between
 TCP and MPTCP for TLS usage
Message-ID: <9edf1138-fd8f-975e-e57c-5442d9082ffd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 11:36:06 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces at boot=
 time, rebooted and continued - Notice: Call Traces at shutdown time, =
ignored and continued =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/33384251213

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/db14b92fc6eb
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1154399


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
