Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD837A83F
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522147; cv=none; b=U4pc9z+ycUV/GXmlSJFLthB1tsr2+hcfZm2ENDpb6vefJHzkq4t9o4Uzz+qixMv7T8qSBunBJOjSyh+x/wHxUtnoIWaWdMgB9fA7HmNXWwrv+jO15Hr8hA3wCfgGQ4MdSuQ36QMv7b2QJG/vEQrMRM53UdOBSA1KUE/syIE4YI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522147; c=relaxed/simple;
	bh=F4R1fU+3l0wonLi0FP+sQvrJKfwe7DMKV2wom6dLH8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=EOPPj08SmFjl0uCfUrvyT6LgLoYUXGGpPJmzhfEp3B9RGDcFBTZYfzSrflq7AHFtgMgMlOJPjscG3++FjYO4mCrSQ0bm3aSPs/DxqhPWuj4zDG8AEE6pinwomaht957LSD3Bl4Enm8dm++4BhSV4RCxTcKXvppkwjJ+Jvj2Cmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzGNs7Qu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzGNs7Qu"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f032b47e3cso3635886d6.0
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786522144; x=1787126944; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pQh5pjiUi9j/ic1htc/pRZDIBTRzqmBlJUJ4oCFkDE4=;
        b=AzGNs7Qu4N/+ncEXBG8A8sn4wnFWzeTohwmbrtE4Ahgc1Yg0kL2ysvYlreEp3tSHLD
         rW23CQQfC5DbFfXx0aAwe1CqFzuhkPzd4Lsix9upSE1X5Z3bWsDZqkYpPSFFuy/zVFYy
         koWLIVqeT3CR9DYRaBPEY04ZSid9biQU7xSiJA/d2D9ahJl/+f6IudE7nUtn+MzftK2B
         QhDD0wOVVKsNdlvVi+Yd+Fc1QDIMF9/95hjrvDaf8zE4xqcYKpQotzzJvxEFmualtRYa
         vjuAEhaQkpz+5uFkIg2YOliWbjh6MqZMlRu4zbh0l+G9D9o5spYZOMziRsk7ijgJffus
         vTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522144; x=1787126944;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQh5pjiUi9j/ic1htc/pRZDIBTRzqmBlJUJ4oCFkDE4=;
        b=iToC60hpdHBc6nmlreD3efMZtFjlz4DZtdxzzZnEQNjndiMCAPrTr46Iwbzmx03SWA
         x6oTFj4zIOM0pADN/ye2m9tX2x/ZxQ6B0ylXg+q2vx2+1IHf/vRjVvWLpADCrG6uHTse
         Thw3eYDm0lTPQte4rS8u5EBhYhtU9LX+qnYgvpFNLsicJgiIV5yOg2zN6nMHgqkScUeQ
         ORalT5DEwTIesEKmELS7b68aVtC7e5lzXwtkfI75Gg+3xtIIVFygVdouPCCgMaVi9Z/g
         OTL+jVpELICsHS8DSWaljPIaGN3fAmPb/f840hsPffWdla/60zXBB6QjZWgxgLkWIm8J
         +fHg==
X-Gm-Message-State: AOJu0YxBHZBMD/PkrKiOcNtIrdfqB1J/O50tbDEy0Nr6M6pqdWXGQPCf
	iyyNYbpgX5M+eba0xz/EA/vnNRAXgbpJsRAVdzLLfFaEZY0fd5AA8j4=
X-Gm-Gg: AR+sD13StDraLqUCnRhgK6CmwFJcRIRgJI/P2g7BKLzvU+VEBUuNs4G476vhuUBuC1u
	kW+OnbPmcXWgasgt4vSBcAkF8j4d2dnR+cDUgDp8OZ4V9Lw+8vuhqAR5bpHLECkAzDDZr1Px3+h
	NSUgnWH3WmyChYpDke5wIEKFGCF/ismSdUdJEtUj4tUWhVRdhgaQ3SNRAcMXlhAmE+mZVLzm3rn
	d/DIR11tt2r7gYWRTYlT5naGGnvtdVFn0jzhLUH5cXHPNvb5KGwrgy7043qEuhzXHbJ6E/2fUEM
	jnDqeQccQkRipEqLjx2WqY0IYfCgvmkmqalR/mUwHBBrChs1q2aRtJweyysk0Ye1o0FNo6hLArm
	VlkX90fNYY1R9Jj8vG9ca60Nl4FFOda7coxyFxsjd+gS+4tiYL5P/G4kV93as9t1Hcr0zfNr2ft
	RK82UN4OiBLpO11eTf6xNn/Nlg8qBzRN3+jwvaU63H5Bx17vXU7L72iw/SbOncRariz8I6SlAD/
	Q==
X-Received: by 2002:a05:6214:1316:b0:8fb:7e7c:b494 with SMTP id 6a1803df08f44-90a700c984bmr22465906d6.26.1786522144489;
        Wed, 12 Aug 2026 01:09:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.13.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3ee4d4sm16241666d6.46.2026.08.12.01.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:09:03 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ruide Cao <caoruide123@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786497414.git.yuantan098@gmail.com>
References: <cover.1786497414.git.yuantan098@gmail.com>
Subject: Re: [PATCH net v4 0/2] mptcp: fix request migration ownership
Message-ID: <5df29db9-b1a2-7880-362b-36ced3bc26a2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 08:09:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Ruide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/315734=
13030

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a56198440b38
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1144501


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
