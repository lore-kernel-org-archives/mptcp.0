Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145A610B
	for <mptcp@lists.linux.dev>; Mon, 14 Oct 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916288; cv=none; b=td/+hEG3IKoATYzBLCL2trPxMxp/l0l1SXOYGaCtlUn1wujJVtNsM2dx5Y0DqO3/sxIyeYLj1DEpBNiEi8w5tLY5glJdSPEylawNQBpLV3x5jd8loZBdPgVZiP7l/GuUTBeVCLHL67zH7ww1/5PVHssIVCXZYmNmzkIarmZTN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916288; c=relaxed/simple;
	bh=qJH5PyEeFwvsZMXN+jR9s9tPqKitU51N3b4cZJr4gns=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=J7U5WLJ8l7Jnm/b7ywqioWyfmrrtB6FnkjJGbwOum1GaIAVysBjxuw8Or6UnPiiqc1DGgPWyF6VAFtVtoIh5G5CGMJ9ZcV03LkLO701oju6KYBGfGuvow+mee0j++4rhmZ7PF2ukSOKaT0o4BEnjw5HAvUzjhwO9XQmQTt/ewD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRzmgIvy; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRzmgIvy"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b11b99edd6so216538485a.0
        for <mptcp@lists.linux.dev>; Mon, 14 Oct 2024 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728916286; x=1729521086; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9Y9WKs6MwIgJa63MjDD+CPhKCihTmvX5o0WH0y9dwo=;
        b=NRzmgIvynZiyVyviuaq5JLQrS2JvvGo7U5e+8d04MZeVifjl9HywpLZ7/oxEBATOcx
         8b3A9lHW9uHRrfANG3qIQmp7vvqvdMlNwMxs1Alx6jxkpLAOjLHuoRVNiyerqAc7iQXz
         z3i3HGIYd2bMhBOwVf8ppAYGI7RM6NkKM5JOA/RU2EuKWTOUrZ+tNGG96xQTyT0hua3G
         U6yo5dj5aR4UKS/6jdO9ekpIqqXtXB814TH81xpzcifMcWECluzCsYGTZ0ffhtoEOacZ
         Xq1OzTj78l0uFbPyEPqxVyAtH1CH46LoFHhQmLRKX1y839FLkCfIKEh3X7SHYWdRzfK0
         Xmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728916286; x=1729521086;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9Y9WKs6MwIgJa63MjDD+CPhKCihTmvX5o0WH0y9dwo=;
        b=fTFPh0ecQnKrsg0lO0UMYMVZO/QNkNgp1ypKvjI5PXf9Bgqgp64tAT1PyJ6Pb+cV5f
         JPExyz7wBLRgvssHz0IBkLNV1bWHtDmSmnceicrbhYgavc+wPqYAmXJZzAPYwRku+X/8
         JEXVaN9XQfiQ/fWPx3+I6zG+81uVs6taz5vX4ylzu3wlb1z4JV2aiv8wILfVIyGu4gi2
         JL6BQvBoUsR4oP9QUIRUg6qqYa2f9HX/uNDaeWHYywcY3wdWEQqWMQEY/dsi8OOqygZ8
         i31pGOYEHsirnNuwzJqQvrrD8+toW3L/MShWcGREIbPT5xN4qVNOu3gRb/h9Zfxnqgmy
         S85Q==
X-Gm-Message-State: AOJu0YztPU0SmNu9MnusW3T6d0s0Vyv/xHjmc3gvXMm7ZaYtmJebChAq
	x+cLUOdk0ZUchz/SCHDaBfbwTCp+P1bLzKoomKnxz3sVEL60kct9kzYP
X-Google-Smtp-Source: AGHT+IHl7muXaaOm9ywqbyXUOqJJUl912QyqyDbtTMctzMv6U1L+5H6QjoTAsnmK31chGbkqDEIiTQ==
X-Received: by 2002:a05:620a:2848:b0:7a3:7920:5500 with SMTP id af79cd13be357-7b11a37975fmr2031863085a.32.1728916286136;
        Mon, 14 Oct 2024 07:31:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148dc758sm424343885a.45.2024.10.14.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:31:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9cde7341aac14f85ba9741e70e2d542edae5a1ad.1728911803.git.tanggeliang@kylinos.cn>
References:
 <9cde7341aac14f85ba9741e70e2d542edae5a1ad.1728911803.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_More_endpoints_for_e?=
 =?UTF-8?Q?ndpoint=5Finit=22?=
Message-ID: <93442774-335c-ad8b-25dd-4c8e961367a2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Oct 2024 14:31:24 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11328728606

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/645e77d4357c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D898896


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
