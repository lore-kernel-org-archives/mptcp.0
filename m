Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146247EF09
	for <mptcp@lists.linux.dev>; Fri, 12 Jul 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781416; cv=none; b=JReLh44JPkPY89M8AVy10xW1FQO0yR9HhN9fARV8kwn+jBsB6BgqSiZVEvQKyKIXkmhHxiYMW08I0B7E7VVZ93TQUUM3mGUJDe2si1UkmcHK2Vqq3CXs+Xan6O6H9oOec4w9pon0RUqdOsFBgBQbkmE3XTOiZCsDDPXEIP9UkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781416; c=relaxed/simple;
	bh=h1Wgvu3TAFPLL4M3IRvcyfjmF7oZf3FJzyBgX8uOCG8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hkAyMGsuInKcHK2qP3aBGZacVkjEzWRxTdTWsutbAICu4uTPAp/tcumRRWgmm+0WWvhfeiZGNKpBMbNbSQmDtvCqSUrJLnc3YXI0utx0a2z1WzGauyeKHJJCGf4Hh4VN1EoBo/13lR+VfWjxnpcEzg8emRTacx2hMrl1oZp5avg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUF6QMU6; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUF6QMU6"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-810418672f9so593269241.1
        for <mptcp@lists.linux.dev>; Fri, 12 Jul 2024 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720781414; x=1721386214; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbv188XbJ70i+QWu8wLTghcdHr2XLUZuS7cFyxeivs0=;
        b=OUF6QMU6L3MA01gE07DEtbLfPNXmXkUv/G2J06Kvy9lHkcJiwFroaGQWxwR0pROmdc
         Fq4zzRkJCn6h2Tqc4qbEvIc6jB4hXhimWDoIphVSr2yCRN7BrkVsNb//rTQqSvY1W0Ur
         GI4prVzlevFln0l/QEbbA05V9+/U1anCBJe6wUQjOu0oFY6oXzjUf5e26WZURFgNeWgZ
         0etW2lS8wjlOewLnIXyvtFmZxWsGDg09fIJpzOeDpUecH+0Z6/LfPZp+1634W2GR9EWE
         nGRivhMVpVYivt4yTngtbJN2PK/BYKv+mhD1Qoos0ca9TEguKi+KTvuUlMBo2Hk7D3fm
         lFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720781414; x=1721386214;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbv188XbJ70i+QWu8wLTghcdHr2XLUZuS7cFyxeivs0=;
        b=Q1gHMl09CcNwAtjMJ/xGVYL++GOdA4gFrDyuuyf7+WOJn26hvAWDT6eySd8EJCcw+t
         BEEvBe9ewSeErm4udM6KyuiNH0Qekor2mMva3sS4WEgd+IcAvsJbY/jmHhClHRmV4IHD
         VD3r0gJizi0ZjdAN0Z5ZZ3YV/ATK1C681mM9NANZ/fpFmwRzoSvNxWPUy2YRHWZjr1n5
         T3b7cR12QtN6ViOUyCm7rV6D3Cig+pJnari4B3iPMU5NnvC4zQzV4NRwV4QymUo2eA7k
         lF2n1T2pVd+mBBKb7zkZncjNZ7cou5btQEAS9tYGF8vNegjoGIH/EEOWNRNS8plgl//E
         I2ig==
X-Gm-Message-State: AOJu0YzaeG/svKqGOKrYtmJLSTJ6wXVAdqJqcTtn865qyW5M2g6NZUUy
	nfdu6i0RFP1XHWz1ymPwmZlU8iVD5A6FY2e+fJFVoRGg+ad8uqc=
X-Google-Smtp-Source: AGHT+IG0+Dv07FFDbLbhABJkReeNIM4lD8aLwy7IetjZcbSGPD7hgdzzwSyZ++iLrxKzS2+idV60Mw==
X-Received: by 2002:a05:6102:304e:b0:48f:5b7e:9cb3 with SMTP id ada2fe7eead31-490322a4509mr12483807137.22.1720781412366;
        Fri, 12 Jul 2024 03:50:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.75.95.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3c61esm39530461cf.30.2024.07.12.03.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:50:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>
References:
 <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>
Subject: Re: [PATCH net-next] selftests: mptcp: lib: fix shellcheck errors
Message-ID: <b68fcf08-32f0-5300-934b-a691e28e3cd0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jul 2024 10:50:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9906229295

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6cb5edc9d8c6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D870765


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
