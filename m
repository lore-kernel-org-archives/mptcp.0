Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD836894D
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747549; cv=none; b=mnFsDEmNwCmc6AP8V2VegA3qok9084BP46PfWE7XU3DotEEb/XEOykgEIq91j7WkzllSU2TG8EqPTThKHiAUMhApOP/tXEH0tSlCsMp4QITMbUIa+ys02M/DYL8MSeM0oQnS6+lhisC/dYYhgkq4d7NVu9uDUiibQwRTKrJaPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747549; c=relaxed/simple;
	bh=4L/PGocvDJpsddnoF2xxZmmuplFeBdRXThsZkiAQA1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FWQ1EPnXPTqqJ9Xdx9Y5HN+eKN5sBRFnP7870CcecT+CtII8UVGwaRX0SNezGMa/H7K/3wayQhmzr6iSa+xHoThDKI5QeQzyKlqWCWfsF1U2svDvlYNp/+tI59+QEA/jnvfmLP9+WGcT9bngU3b/JX/9NFjf9qDcj7H8JrlV0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVaUv91+; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVaUv91+"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f032b47e3cso8444046d6.0
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786747547; x=1787352347; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nG3+a16E3e+F5NrbgM18EtqX16ovMQQcLvzDKchYPQ0=;
        b=HVaUv91+M71VjZiZy6kDFbnHo1WS5/vvZkuzfNrE0wHCrvoHXZJiE1L28wIXddYtI5
         LY8GFe0A+TX3IpdmIwjauv/rge0YjhZOiC33klxWuSrcYpT7WyS9VpILlpO5GNKWPvNS
         UWz6U0RjaWXHeqHjj302xJOw+2iA/nGOWD480SgUmvFGiOW0sI9n6h9FkKt/QAI/klCI
         XhzXr8odTYo5ou+epW5MZigOKSuKlDPlsERz4OP6YJFeVsG3dNnuUbxzEw3UCR6ubc4X
         vZbQV+fWQfPGV/fpf7B4NaZkmRKUr0lycxXJLsDsOQKUPq2ZSs2PMDk2zS7EQRNvIDxB
         RNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786747547; x=1787352347;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nG3+a16E3e+F5NrbgM18EtqX16ovMQQcLvzDKchYPQ0=;
        b=Ft4zYAVRhTAflM5nAFUIpy+tmlPgRnaY+W3HDijWVTBDch/QLHpiqC1YNbLwmCaId9
         4fg2wNJ9vfTdh4KRJqIbvjkSH1hV1rNXVKSpLoVOWMybAJWxTcA65bRZKPBew+0RRqjf
         6sOH0OYVicCp1U65DXRz4MahPCgcBbjt2Nq9eNQGT5geHelvs5GugYZQx3J6QM2ASXPb
         vMhUnA2xUmv56ZueYL2BPlZbWBebLZeb2MvivhaU3JChkrpJBYex6djGn8azlHqKcWTj
         5LlzilmSw1l8qMSZjrpvCOsNqjw6hM5k/zuwjpUnJlkdQxs9CN3al0YJECZOCP6XXctK
         g3bA==
X-Gm-Message-State: AOJu0YwOMIIHJUtRR42Q2UIaiJbFLva7KChvkHkIoIZK+kP1PJvmPzn2
	BzccdOhOVaowtfzZAqCNRm2RQvn+ZgXpa4JAjtETnFgxCBrkM/Q8NulXrSdq
X-Gm-Gg: AR+sD12v6ENjPo7R55Ir4FZdWmiJTh4xKCzAxb8KW+jsIQ77Kgm8CiNE3o9iucGvSgl
	6aMIaTO5+RCvr8jz7znllp5/dv3D2k/u9XPUmaOJGaMNNGunZYaW5KYLB/pOn+0Fc1nUnnJdxRp
	LgCyjG23fKYZYEHDsoy1Tt9oRHYsEymFR//ur2jhpavLc7vITFY/yMNRmOQyBZhOrusIYXS7vLT
	VkKFJXrzjfv5Fb9owADlleYt/5bvVSaV/p6vNhoRzbhqFAQ8BUy6rIKDHvi2Msm5/RQtlr35RZo
	eFA3uyErUyanCRjd4qnntoYZvXIq9TsRkpI2+zv3qJrc2FyyskENPMQHxpo2nAQgG0UDxvrYLJP
	TQcDLaDjhCp3GUL3fBFI+hwkqAcf+zpeddC/Yb3n974U2S8twqxSiOBlGJ96JFHjb5cXVKbNCug
	KOQmYHZirA47eIVrmQboWkJihB4in84fR/He7LmTqXWN9qT9a5vxbqlwEfXtkQUp0FENUwYRYi
X-Received: by 2002:a05:6214:4385:b0:906:7fea:354 with SMTP id 6a1803df08f44-90a91de99b2mr117947836d6.18.1786747547040;
        Fri, 14 Aug 2026 15:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.239.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a9359658asm29051636d6.47.2026.08.14.15.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:45:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260814-mptcp-dfin-csum-v1-1-08d0b9b86bb7@kernel.org>
References: <20260814-mptcp-dfin-csum-v1-1-08d0b9b86bb7@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: options: fix uninit-value in
 mptcp_write_data_fin
Message-ID: <b15612ec-2ba3-b10b-edc0-9e04c6e5c8bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 22:45:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_syscalls =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/318447=
25190

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/10b4213297b8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146309


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
