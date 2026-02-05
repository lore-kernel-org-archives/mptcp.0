Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985C35FF6F
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278297; cv=none; b=l6LmFUQni7iMpGVk0swXQRxJMQSRB8bSkCNll8Zj+xAx1QEH/YCe5W+/+Ixe/1teuT3z+7qJiwYpzjCEwUrTTc+YhJImcsTYyOxSMH1AUFLxIpP9gbaI5R0/DaLrb5TbL320z6nKXBNCiuwmbgbQ4/IyMsBUfYhqpce9LwQVMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278297; c=relaxed/simple;
	bh=R+5ExZHyBrhTFOsOAKaiwznXbSIH+Ocmj8Cp4owd0qc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oTkUZTyiDoXX9YgNsqs0de5oLhwUIik3T+jnqBTmwu86TtnIT+Wnpofa5l3GmVwbsH3T2eibK0BOTSjFRHrv1aBxEKioE7n/bHEwQNYWyhOc3e141N8twHo3hIeJLW2MBoXTKU86AJ+QVFB/UfKa4TD5p4MUFUuYfyPv9WsLTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/dDT+lj; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/dDT+lj"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-5062fc5d86aso2312971cf.1
        for <mptcp@lists.linux.dev>; Wed, 04 Feb 2026 23:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770278296; x=1770883096; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoEEfC86MS6GtF/fpf/0BeAkLvpGWc7/Q5XHoHvD/dw=;
        b=E/dDT+ljskemEAEA/D69VTmy+4YovgrwBQQY/uNoSMoQLW6uLDR4YWttFEhR42Xof6
         TQ4fYwguU/n9XQwN7mp1+dUg+BHhyXebi9i5pTzD+spOoTCde8lbeS+dY9HizZXnl6Rq
         t46W/TYeaTPmSJuM6pzui9UzQLcbV/6Hzhz1tpKoBbjIOBcDsSVJ+NLHhZf2nvDvsmYn
         2jzkbT170a01rD94AmrqYOU1jbJ2j31sUqXiHapgIWaan+CSeTU4h0SbiKGoxWzYcXPQ
         sHe/FXT84qvmjvQIaaVGcF5Yk79FPBBAcc1ePiQBL2wDtM/omxwjfUc8gLYysmc2DWKb
         3yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278296; x=1770883096;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoEEfC86MS6GtF/fpf/0BeAkLvpGWc7/Q5XHoHvD/dw=;
        b=cJjHWi8k9rvic1suzDKjID5i+5oov5PUXhEarvxlUGYJ5J4qsaMHrvDWIWsgKHIYkv
         p1hxsjX3ESByOLZ4F6KvDrFlQYKcPln0Fz5lFTR0oCd05S3TNQ1oykvfc0nrlHOdLZG6
         7hVT+koJvktAV/R8pS18XrwyHxY6JVlOjX4etEbL51jL4to5EgAZ8cYug8eN418cglpp
         xvEHde2vbTPULwP3Hq3F1wSm+h92tjzfvkEDmHNHzEw8+JJrmnpiCgx8XYZxuvVK1WwF
         6TJWiDjY4ot/B9BaLxq/5CxViwPJBwKEs1L6xZl29zP3Ttx9qb6hjixCbV8gOhbKx2tA
         xYIg==
X-Gm-Message-State: AOJu0YyFVF5qn+MuXRRfuzT7wmTxCn8LfaLmBlazyNJZhWAl+eoY+dZD
	b/vpFo0Bd4P0Iwji/Tdh7ooq6PIZCfgh8D0OpIlWATtYBtTDSnRr+Z8VdyLBFMM=
X-Gm-Gg: AZuq6aLcFGCe6UNOI6NDtj7wffCsUGk5z9iMm2PWEpmirztkDheK3Y04pg9LfHBUFXd
	rVDVuv3y0uesuHiIqcvi+4XMgBXdsERTaqf09m7Qgm4l31BuCN2c0b4C/qVPHSxhhN2EsudI0i2
	ddZElK00ulZ4Z9NuGt3gRiFBzmWKh2ilS5nSImuVTrWM7MpvSGHGFFXc7yDHAl2/Hc7BoUj5+Nz
	cu4+TFj8v8w4UN7MaZU6Gh2r+BFDXQ6lbyLv3CklCicvVdF4NpH2VQMll3zDOPxBuNSgFbr6iRp
	/LztS+tj4CSJyPNpbYtUXHF4sApivtbbBKrQ3fDoRGY5I3jyeb65VGyTbx2pqJjk5H+6TpMzb29
	jH49vqjkySwQKg1fi+A8nSv0+kbaABkVL61mh7IXM+vE1LQP33Kq2UjWYT8NvT+IidqLKaasLSI
	ShHw0OLnbGby95drmA8u8X/v87
X-Received: by 2002:ac8:7f09:0:b0:4f1:dfc8:50b with SMTP id d75a77b69052e-5061c1b4e34mr65579191cf.76.1770278294702;
        Wed, 04 Feb 2026 23:58:14 -0800 (PST)
Received: from [127.0.0.1] ([172.183.95.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c211b9bsm31947271cf.29.2026.02.04.23.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:58:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1770273341.git.yangang@kylinos.cn>
References: <cover.1770273341.git.yangang@kylinos.cn>
Subject: Re: [Patch mptcp-net 0/3] Fix the transmission stall due to
 backlog
Message-ID: <2fbc35a0-0bc0-6a90-2752-505414048a26@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Feb 2026 07:58:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/217019=
56586

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/189e81c8d4e0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1051012


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
