Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E85770FE
	for <mptcp@lists.linux.dev>; Mon, 23 Feb 2026 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877656; cv=none; b=lCWmgXHgDF4GbG9ySegaO5aJxphHBclHSRGPAtRaCN1jWfsXa4QsngdEFOVeMo6+CMvu6RHFIyJP7riPjM/3F8LFSLShr4IAu1sdHLEsO42rShO4n7V34FssrfbmeEb9cGMkjr22Ly8q+ecucHG7Es68UDZip1v6lNPi1sVZm9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877656; c=relaxed/simple;
	bh=zXPYiX8gp1EQGYHJqaAWPYKS3hjTIeSS4zWiKAqYFoM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IR5yJ3ovDl2gtPkMFbbxRx+oW4ZTwc774zkpeVzg9rIvRP4TBfSSoEfKVOkHp0YOcnYYyAUtfwS6MFsV6k7fryCHZMOjddCFkltSQQdfd/lqTz5232hVcqAyY/1L8ZZIyXic+KoQBPianfdPNNeukKtlsTBLFm9Nal/7kfQ8c8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljJNn8OH; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljJNn8OH"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cb3dfb3461so485548085a.3
        for <mptcp@lists.linux.dev>; Mon, 23 Feb 2026 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771877654; x=1772482454; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7KyLoEbH+gpUuCO9DNn9HmB4PPRV1tSRW4xvTUHKY4=;
        b=ljJNn8OH+0U3DJU7EaP8PaJmLnw+bauutJRGkXR66+7Tl3pIfFuYJrNvk6QT35UhDe
         sudcVm69vuvysHOz5k8j2QrlqrvEfKqx2G6SFLncgHuCmfKSMCPe/+jGEYu+/Ldzhrfx
         BSnC6gFEmHbuSS02bWERODdOpJHpNvz1bvu4d4xEfJLC0GaVEDM/GFXUVjXjjbcGMyNz
         SFi/rZ1/QPK1eDPyxJMGSQnYPQjPd4iFmZzbLMVOWNnEKQFCNe1nyH3CJmQMiQxwfe1D
         vndjonhN3/4FA+ZMUUG5PIG4cgXb4xRCfEnBvSI9kwF1qaw7+GgxwHAoiTGw42eI+ejY
         fmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771877654; x=1772482454;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7KyLoEbH+gpUuCO9DNn9HmB4PPRV1tSRW4xvTUHKY4=;
        b=IIVdiT2bjyh8SozkQxQVKyvy7BKoEX/7xS2JRAJVUXZ5McC5kDTDDmrIlvRorBs7uc
         oZykCr1CMYMQEct6Yoy07XR+uGcttXKuKiySRYqXmG5tMgDWb2yrD9V4ip2wGf6O+6uX
         Y3CnIYnfW2foRD4OBGbZyJxmnF+FkHaaI2bdNdD93wu/CbH+mzTqZt7VSvptJOcjVhco
         lXI3HfDF5BETbryXG6NmksmtVi26UwVMMUAWSIRH4ZEPjCNfoAkoK969rGS0r8IDfyXt
         p0CUia6VwkVrU/9SmrCq3GubV2mhvJeXLXmwXs7rxQLWTOJ2mSpOEl8WodCqQojvnPtB
         lXHQ==
X-Gm-Message-State: AOJu0YwzvwkqibTgfm0T/aPfmw6EKX8f7zxVwin5Cj6knhBqQt4Fd0Ij
	I7qSQMGwPEMF7rNXBvVD9awO/oWRrJS4TTbe+rACCQ9LBe1qEGpinHk=
X-Gm-Gg: AZuq6aKQcqTk3ou7lxT8iYejw7X4VFJd3QKj1v33g0CgHpP0PjHTShbPmIuYvqAMvmT
	2FG/08eGkf2YplJ9EMQhkCbvaeYu5p7P2DAhmYFsqC+RvH3NfGyloJFeGvYPqNtOA7Yu2b2udKX
	YBewmI8bkf24944RAVw61ej7ydfNekoQsobz+gwM2bWIiVgAZXPiCiVIb8p3dV5vXmbt5dPsr1Z
	EMqpbI6oAS+fJA/sBk7lK8ezQNmKSPLZJPXFp77Yed3OfVGp4yKqllKqiijlJ5Hlfln2GMixYAG
	3uPDugYFHBxmjsWlCHlpXpC7/3pG6J9nrj9KbOAFoMx3prBOv8sP05TYK2stTGI434xn6td3VQg
	Ds4J2gjm4n+8ubfeEXWdCPja3atc/OvsvBkLAZivooV9tfmymfsojKYhYxSB8Ii0LQPX1OC8Ao6
	lNpOR1QElmrGrs+2hSYtXv69AUWoZo+50rGIQV
X-Received: by 2002:a05:620a:4005:b0:8ca:90de:43f1 with SMTP id af79cd13be357-8cb8ca7f96cmr1353620885a.63.1771877653467;
        Mon, 23 Feb 2026 12:14:13 -0800 (PST)
Received: from [127.0.0.1] ([48.211.210.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm933534085a.8.2026.02.23.12.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 12:14:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260223-mptcp-sft-re-use-id-v1-1-ec648a8bda22@kernel.org>
References: <20260223-mptcp-sft-re-use-id-v1-1-ec648a8bda22@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: join: recreate signal
 endp with same ID
Message-ID: <95b4f718-8e7f-2701-ff96-18794c12e50f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Feb 2026 20:14:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/223207=
93380

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/334f2997e09c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1056723


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
