Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBA33EAE7
	for <mptcp@lists.linux.dev>; Fri, 21 Nov 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719525; cv=none; b=HYXEc7CqWKnzpChMer+8N8EGSLHPFM9rHLunOb+Z6jN/CwzmIBB/ngIqRiatwaWW7uEsaQB3ghrEixWuvmLFAM6Rgqzcomskk6wVgYhzcgV4qs46CPLuYbAAEiqlBqJQTpiSaNNGUJq+wQV28QaR3f7/Ls4vdTfjKxsvFK/8gWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719525; c=relaxed/simple;
	bh=WnbHjMiZD36INw/J5PuG9W47KdbdCs73eGGyZQWZU3E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=vBkQNH8DE5hOWAjjz5bBKZrKpCkTaxfQzo98LgBwbvKRVu7yfsgol6mQ6nxzrO2uN3BcvQR70PXkoUTQIc2FTpE/19WZ0SFCpeKTEDKqEf1uUcDJu02yKlzCn63o1VVqf8tvpGP08EPte0lWaUaOa6HCxW7HtJEI14DjeOniq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV5wpibe; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV5wpibe"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11beb0a7bd6so2538408c88.1
        for <mptcp@lists.linux.dev>; Fri, 21 Nov 2025 02:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763719523; x=1764324323; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HL5wfU+xjVD+V2SnHGC+vZSbexXhxkE/uEUlekml7hM=;
        b=QV5wpibeKlWQfQAd7PkNjA3dmji5Fl1kx2K+qPWXQ0fQ/jeUEu4lwYdJliTp/eVPzh
         6QUcEsJ5o0MO8Q+fGTxo2+73ouYVIxlRBBgfh6LsgPiA61rZe2i4Le/Fs91CTuFWaeKU
         3xNrp7zAUvi4Rsj5yWJ+bnGRo2SyqubDVmG9A4msrHPHdYBxzd9e4Ua59hH5wdbVDsBc
         GcC/pXj9l1O1OVswPbYuYhY2Wo4ORH6LwsB82FDzRZ+oantac2A5UvyRZh4Fx4+OWDgf
         WjU0hZ16vWMoGcZHUT9l5yfDD1CKVxdtXYvlyBvmnFzbDCBwr07axCOKcXDlznhuf5JG
         K/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719523; x=1764324323;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HL5wfU+xjVD+V2SnHGC+vZSbexXhxkE/uEUlekml7hM=;
        b=K8V+uoiGWKlTRWcyzWSy+d15gEgeGZnT9dymcFIBLKZjFkZRC+452LN+SbMIXGGsu6
         zKb+6/707wJNqEi871E8siv9DHxUsiiSrYxmfVke/Y9n4BOzHBbxBaLmslpYe/GC4/s4
         fJ1T6CuR7G0Rpd6zr1+DUSaliGksLm0PLQD3Nl2K013kHp7Lz2Xzctyh1uECIQIWIOBQ
         pI18QSet11rfM443Sqe9ZvvQft3SoQLDaaU4SELwzskmWmHSU/w+0fSfk4Wh4eJjCEjP
         kCeJ2aFuO6UqEQT21CYlfjuunYSsKaD8Dg3SvQK79aLxzxwQ92E3dU12D5D7GYAD0vBb
         QL6w==
X-Gm-Message-State: AOJu0Yy4/WVN1Bl8bHTpwMvLmox1hawNrna6qhRv/JAoOmaKnB2iYVaF
	CALwTA/PZhFEv0xNZq0SHHg4NUFmmjvCpOX18SqTfq8ARpG4KH6+anU=
X-Gm-Gg: ASbGncsGMQTV1ZuYM7pe5jLzkJIpyhT7W3BCVVUMryF7LGHVgAYYIkOFnuUHYIrNl/a
	4UvUCfXXczwgnyYt1xVMcNNnok7K3Gp59z0ZJ83Vy+M8BPnOgGLsBv6VJ1NbHXlmxGh+3ANyHrg
	LUWjoqKYlIDAC07dBMcGXpa1Kx323cvcMtFGRmxmeqIl45mLakpQg3xImbmMbC5fHjPWnb0xdpZ
	5Uq3l5kVD9K7yEmZy0vxoz2V7y9v5uD1GkQGKNorlOwDThQsQTDn5t911ss/dxpwf9z3XY94v0j
	Fd0uyhMzvJme9wt/jaLvMR704HkBExU9g4ibqTymcpOBuQu7ah655AV8sn7n3ZEJJYAO+YAewop
	7Ftki95FwZJI0sBp0uvP8H/o7xaFIw0LxCHTq47taOZEhS/xGQBfVFTblG9W5q1EJ3FhzgWtIX3
	jAtoVSIljGAacxJWSp62ZJJiW/NXZqcr/hEr3w
X-Google-Smtp-Source: AGHT+IE1jhgKgtGvhsfG/XzE853cj7rRwMs/ZiXc2mLyySr7FxkajEjzO3/EaWBvGscMKp7pRECEEg==
X-Received: by 2002:a05:7022:418b:b0:11a:468a:cf9b with SMTP id a92af1059eb24-11c94b0b693mr1795225c88.9.1763719522500;
        Fri, 21 Nov 2025 02:05:22 -0800 (PST)
Received: from [127.0.0.1] ([172.182.224.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm14957213c88.4.2025.11.21.02.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:05:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9f5e5b6c05fa0e6d303126c6a68a19305d166d36.1763715034.git.pabeni@redhat.com>
References:
 <9f5e5b6c05fa0e6d303126c6a68a19305d166d36.1763715034.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: schedule rtx timer only after pushing
 data
Message-ID: <1a4c1891-1d2f-9b5a-6b2f-b1ba1f579979@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Nov 2025 10:05:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/195653=
15895

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e7f0f49b0657
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1026213


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
