Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4A27BF8D
	for <mptcp@lists.linux.dev>; Wed, 11 Jun 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638654; cv=none; b=KXPP/35FZYfKgGBUtYrS0dx0tl/lQAfGX3HAI8eFTRC6BK4bMd6RHrv1hrlwIJA/zQ/rg8DZE5l2mq+nkoy6BWlkuoUFn+yLhAfDz7tpITTSOFcX77R4cr4UtmTE0TP686dYN8ZLalbGwDBjvZt9qOVqXQsDwAX5HW9pGAIsYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638654; c=relaxed/simple;
	bh=Gw+EcYbiRbKjFbgImyTfdQDlG66LFDeeO3AcIUixWg4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZoyClFaOyyE6n2ExRfUal8De/NX8PDM9Wn77AA17cCZHQ94w9au+ZYZhIEjo+KQE46fgmCfvZAUAPwsFHn7vV4LSWFacxd6CLuNvsiTrU9+YpCLOccPMuTQ/I/zxvNOKjM5ykAthN+RYRevVg0ZLsspAhFiZMfCVCQ/O8lcal/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqcQQuRE; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqcQQuRE"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d2107eb668so992291785a.1
        for <mptcp@lists.linux.dev>; Wed, 11 Jun 2025 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749638652; x=1750243452; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ5vgj5hF+7Gj0msV2M0yTyx2HYD+kbPO1+EHGjuhEE=;
        b=EqcQQuRE6A46VJvKgG9K5te1KeuDJ8mO8UYAJG/FiiAnePC8K+G4gSNhO02Ia8jNoC
         XVBRh4MSoWZ5uqFvyzsJpMt4r67wSesUZ7hvYsrOEW+ANFjY8XESahogORusyxcBrMGR
         91cX11eFJGFrzZ6F6dG5IVHgq2IlDRMm/Qjf9UC0CmBDSUJGQYtgKWIkK2iotUVFtMOh
         UG3WXjXl5R2mSnXdkNXVAWcWYdFxy3d6EqOZoIHWo477hFEHkL/TJB7gftVHBczTjudV
         0qA92WN6WU2AgdyByJSh+vZ+KMzlZjjIKAlKylFTw9BORSq8pEB7nlLJdwcPGAi9XjJi
         sk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749638652; x=1750243452;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZ5vgj5hF+7Gj0msV2M0yTyx2HYD+kbPO1+EHGjuhEE=;
        b=Jcu4XrYQdvlW6LWfJiZgzus5EPiohaxnnYRrKbrg/6ibrfl43ow5uEi1kgukgDjDlb
         PCBrnNFiwfBoTafLvtiFdmhIPQCwStLNElnG0Dpp74TgxKvW/Qspe94m9LCm8BuqISeG
         y/rMD5tVExnRgh/ox0BSkSWv6srLO83IIRzRdxgexc0U3ScgnWc+4MsZalyXbbHKKtbS
         wz2vwocyFuBYMiPhTxDlSFVFhoi8HuICWhrX8+lxpCeBjnZr0Ia+tT7Zdq3EtDj4tWLs
         vkPZIp47JCJGgdylvcO7D51+UKekk2N7jOHeBDpDZq0PDHZc4bhKOSIRxoTbYlYubs1+
         0NbA==
X-Gm-Message-State: AOJu0YyBO/dZLJDAfFSllZ5U4Zvj++bf4iYxJ6e6bHsFHOy4kaTGTJEv
	VATZS7k+TwFrt/VYvfSMqN7VzwL2eXwVKTlA+cFw9fidE6SDWRWnTw7HBZ1I
X-Gm-Gg: ASbGncuj3vxCvhRZH/OrKkNJKiqrCNTTQ/1t5jiqfwfC6CPKBSY6WCe0LFz9RWxQobT
	uRtgL0cmCUkIJx+OPYY16dLrNDwJfkqIbKAL55/r5pqqrnWhtr/04CtPfr+a5u0kpf/Zkxbl8SQ
	bf7G027iYfpsE+2MWuD/G3Q57FSPS+qT8c0Y9lxK5UFYJmiXfY9HZxXsnKdADpEPYXpdc40keRN
	uXHjMkUiRUHmgt9AutGfWiUM69fXPo6+/9uapaAwbF98rnAREBNcgrmXO5T+zmtJIbIY9U0Wurr
	nWooz8aC4ANy9DdaNbx7sT3MdtCJEwkxjiNGf+PKXiTn2trqiQA9ZjAfe98EEPUok+cUgdnDvM2
	x
X-Google-Smtp-Source: AGHT+IFd11LqncT+DkWE96META/dJhon5zMNvA61zWRfqOxE+TQwdnQ54hyw/vWudlaW6fx92tGoCQ==
X-Received: by 2002:a05:620a:ac13:b0:7ca:f3c6:c0a1 with SMTP id af79cd13be357-7d3a964f036mr318287085a.55.1749638652027;
        Wed, 11 Jun 2025 03:44:12 -0700 (PDT)
Received: from [127.0.0.1] ([157.55.208.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ac94e7sm79628826d6.40.2025.06.11.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:44:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1749633671.git.tanggeliang@kylinos.cn>
References: <cover.1749633671.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_squash_?=
 =?UTF-8?Q?to_=22implement_mptcp_read=5Fsock=22?=
Message-ID: <eed5c153-e806-2402-31d7-fbc71cf253de@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jun 2025 10:44:10 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/15581436214

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b571299e8f55
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D970730


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
