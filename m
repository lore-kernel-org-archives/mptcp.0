Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD64398EE
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832811; cv=none; b=YguMn8MjNvAdFg1qtOv4j2uTSMBnfbrPz0h0mrT7EfkCM2aLiuF2FwpT8rt/DRDofCs0uPHZiXSw71wp+xyqDdPdYDnxgNfyGio/TM0Pgh6C2A2BQXOGfZPby915Tk9eQUczpYqA/+4G8lScWVQRiUFaDZwXghTNsydbYVxBRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832811; c=relaxed/simple;
	bh=Hi+AWpMsu5T4/JSv3bw0iU64lx3BicHPiUYz8oNbAGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=BpcS3pGJJLNrOmQnS5UtpD30J4fsd1TqWh3dODJMj5OLEYgOd+gHxGGgIwfhzXg1ZAYKrOBrMv91AbEUCM0rQMiuY4ThZCBMdsgTs2kNjbxZZNqu5SbgSldyXqVWJ27zeWxrzq6W5PMkcI667njVln+y2euWnV7qbbpHxZCZhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClgA+oEU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClgA+oEU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceab75934dso25598955ad.2
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787832809; x=1788437609; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y/SVo99/ULElDKM3srodnrs9f9XzXlg6TPXb4qbnEmQ=;
        b=ClgA+oEUFpKSeHN6qB61Zszn8B90H5u45eH6nJ/8cDiceadxOq0Nrjo/0r9eQveDCg
         Ayq4R44U8U0hzh2fYK0J1L+tiJMP+2IfMdkglQ2md2UE0SAaGguf85zAebeRSzOdQ6j3
         J2EnW2dAMPE58zYH6Y/kxRzg8M7O6UBHQ/GYG0iaoJDK6L6xPzo7tAASA4fsMj5EtCDz
         YsLWziaBAl2OAZwxEEkUKYY3LZdrEUx1P50hkSXrthdCAhNBRZyMuDdKtF0nixKPZyY3
         tf9MIBht0K2OqR66Kz8k9EAOkfLyOmMq8I/DI4qtv/y/ZQC/60XNvrfPNMsLHbHDkEmu
         gNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787832809; x=1788437609;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y/SVo99/ULElDKM3srodnrs9f9XzXlg6TPXb4qbnEmQ=;
        b=BYYAiHzuvgbrsC7wRbDN6M5T2aDqDhr3VFUdHllzO5zoSFYgQOpSPV1vkvqdiHi05c
         elLxiXCXW1ZA2EY2ATD9Ug51sRWd/nZLjpmpk4r6U7vrYQ8INCKGknIedFIXhGFkLT8J
         t/TP37PAGmx757DKmslLjRlhfWkP5pSqsY9nIkKBPGQG+DcEUaGn0VFtjRlW7F3Phl0u
         h+v+ZNVurq5Cmichq5+ClzXv0LpECemrlkhIotfb4bFtPrmkRY/7YvaZmuL4alBME045
         i/DqhHzOmWx06pDkp3V5LxpmhjGLpJaKyygdlKm0pQpQ3LFLixc/flcpBFlmdHDG6f6U
         uXew==
X-Gm-Message-State: AFuF++lGUAVrBCWxBSrP15LGpQHo7VbyFfS3PiEBhNzopfZZ2VHB6Str
	IcnKVKuTP+5q6W/hQoTbMbwqOGrxPji726fCXYtHfgCj0zc1aF0IYE+P8uHrcxQ=
X-Gm-Gg: AR+sD10dP9KYDZKz0HpCR6fgFGgoONvbo8qEbCu7rwbQEWhvS588dWR/zQR8ZBSpGfF
	q35CML7bxJ+qY56WteBbJw9/11GGjFuSx2NBOA9k9/7mFvJYaYIn1e4WVN1CJavNoY4jgwHRN5n
	RSvaGygP6ZGhgJVHbms7R3G96H00q1PRdp8PhOaxr5n7MbL5D2ePA1B+nFM8mjpfzT6TgLOuXws
	00OT7xLA+hGaih2o2gMpFdk7zOvLe0SqxDYRvMFMQg+oGuH7y4yBI5e8qLZ67O7l46I82HMbWdl
	XCv8Y//d3R42HyPK50t2DJJBBpP0aWCP9Fjp+IWHGlm6OmZ7W1F3824NUKUMuWgPEXpo3geThLe
	L5dS9WwlKDqYQ/+9DUCXuIhwVDCwLsusVvdqwDx+sdtS74hzeJZ5gD6wRmi/JxtQl48l99dA4p2
	eIkwDCl8ha3GHy8Z/uMPs88NHAi/AkZULdrZD2HWIFyYDSUKCw7/LYTrsoAa/YREf9k+mvJ0of/
	DGNJmlYTg==
X-Received: by 2002:a17:903:1ae8:b0:2d6:f3f0:3e7a with SMTP id d9443c01a7336-2d707957143mr266606475ad.3.1787832808845;
        Thu, 27 Aug 2026 05:13:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.153.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32842e07a8fsm14855933eec.20.2026.08.27.05.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 05:13:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 00/11] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <a68b7bbd-1138-c5e1-c51f-ec5cd04a6832@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:13:27 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/330672=
37251

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/762a5ba00967
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1152595


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
