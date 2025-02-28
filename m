Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869291B4250
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739544; cv=none; b=R+rH9+gweTBnCE+MGDp5Q2Y/w+y/2cV0qsWETqh66tQrh7BQ3UpEAsFrJWnRPkO2Knpw5LtW5jWZiPIdXP6H9vdiJJKNSz8MDt8qt8XtOh7mUmBfBknuVA3TU6tU7iB3hIcCFOEsylQJIjsFc2AEOMXxNBbIt7zdRQzcRLxvC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739544; c=relaxed/simple;
	bh=Cw3sR8cIZ/iJLZrsK+dhLhwBAGHpEBjA1OyOKKoqwkw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tQmsIYOUzBWeOWkj+fN2Y7gWaBS2O1h2Zij2FftdOY1WVPnFKwNlgIcuOhx25xdpovh06BEajDBr0vrXM3ikvLuFH2YE7FXiDeEr7Q3+jKVTRmth+vq/h4wNRodrrQ+US7C0HTltw2MlhyrG2a83mLaiyNyXUjgcKBYOEQnGx9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7eE1gVX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7eE1gVX"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e1b11859a7so7904856d6.1
        for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 02:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740739541; x=1741344341; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4WsPI8O25QHPUfUHuSLla42woElguDhN7EkX9m6zhk=;
        b=M7eE1gVXzIq5fjvzy5tqWJwRKbFOilh3P+g1HlEA53b353ZJtORwDhJoirGRBuE+Hy
         +CkKZhHK0y9bb5x6gtSr0DnhZun30GyZBEe05sGzg0p22aeNMiskILMfUd4Doh+jydTT
         Lr6NHgpOJwbeMw7q40tGcGiKqSVpQXw7cOevs2+anJOZ51dlJgoS/g86nSf0I0yHFAez
         JclASwqQ+FgD7XxSceNSZq8Q/L+vXhVWlkvJC1x5zYwCTwfd3ryg3FKGWNeGn6aJMTDp
         1UdLtsecboOCKXRX6N8TLx3f6FzbRTkg6b92xoKj0QYSyPImPPRQvI27F4CFzciNE+hi
         CMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740739541; x=1741344341;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4WsPI8O25QHPUfUHuSLla42woElguDhN7EkX9m6zhk=;
        b=wjSv4MFXSFQ1oKqzsMe20DwZY+9jLv1cfVEPxO/OekU0FiHpPC3M6oOwa0Tvv//Hxt
         VmjUO5440pNsts4MmxUtzU6aP9NZCrYU8XZsEWYTF81K0XqSGAVup7ZsqFVYj66fOk/i
         d5GPy5Tu/M+Qfau6kxCjW/+Ri9UgGaZvtrNaby9gWpRe7WVRPsKjpXBpgS6kuTYYQsoo
         1e2ndhkbahxpzqamKepr+TF6QlKdTZS3z2+MMBeY86f5V1zUMR80BtDO7OMhh7C4QpP4
         j3RA9V6NTEB+vKV4+wphexgDLYBmf89sYOwA/iAv84jXFoFL6xusW1BcIm+2AgE6OrsZ
         ZYEg==
X-Gm-Message-State: AOJu0Yyi2DdeAAidmudozqCXkXKZRIhL1slPRscUJYQDSFw6XZqaKnX6
	kJhefb3D7db4Ln5uNMxx+gnn2vLqncqk3xBOq/kPeA3dvElPxr0=
X-Gm-Gg: ASbGncvkeXI3VXB4hA0+CCFGceefB+ypwl3aQwkvFpOVdBTZqI994JjMD0fJ1QB7usC
	8vJ6md1hc2HE69Cv7vN/Lq1fMNTKranCyt6jmxAwOJOW4CS8naSRZqVhFymOCzNr/bue85dEcJG
	yrBj0fdFXndU9+PY9TuwslHRGLF5yJjGKjS/wflJckdAkRHUCul1nQ/+qeERqc2rv1QzEX/GFbc
	I8EaimYarNFMacRkKCVwHKwcx/2mzye9agMcDoZ+gJo4j1/Yl2PF4o2KCaa5zgIzkd23T84CIzs
	wdB83je3X4FBpadDuUCc07Z+al65V3cgP9P1C6A=
X-Google-Smtp-Source: AGHT+IFb066YzuwXY2WqXFfWYOBlbebSWca91SsReL6MrBwbngzu+mCkWZDt/Z77kLQnyw/65jfTKw==
X-Received: by 2002:a05:6214:da8:b0:6e8:94cd:1120 with SMTP id 6a1803df08f44-6e8a0d38eeemr41848206d6.22.1740739541289;
        Fri, 28 Feb 2025 02:45:41 -0800 (PST)
Received: from [127.0.0.1] ([68.154.30.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ccbefsm20660306d6.85.2025.02.28.02.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:45:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250228095148.4003065-1-yuehaibing@huawei.com>
References: <20250228095148.4003065-1-yuehaibing@huawei.com>
Subject: Re: [PATCH net-next] mptcp: Remove unused declaration
 mptcp_set_owner_r()
Message-ID: <43d98e34-2ff7-7ea9-22d5-d3bfe0e62c2d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2025 10:45:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Yue,

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
uns/13585649743

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/077f8a1c5011
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D938898


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
