Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E1314A72
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466214; cv=none; b=fGw4Nl/L7i9fxsaD/Q3J24oFBLmkS4sL/QAGG2lVlG6Ki1LikEhXB2NtcSEUCrSqyR8nYLj4lKG36awWMwg30vOcum9xPovVMcUUv+kVXX6Nhp3jK6vsGAleTEkJ24l8bC1rLq7+5lnF6lKrX6r8xWInKIUy9BXjpyPLYYFLSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466214; c=relaxed/simple;
	bh=DoXQjzOE4WdeHDGLCZczs7Y1FeVUeU6FE/kKy7gELuc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bNiFPwf5+H0XbAFsaBlFihoM6Zx2QYIzorTTiBkkV4ZM+CUDfMB/fxX19uByfnXnY7aHg3hRo1Zr9RsnkYK09sEnBWt+ULrjQioORpUDFwv0cJq6vfm3/w8KF/6s162Qrq0KwSyUfJRJSFPp2l8fTtwe/f80g1YsuCWdEvi9I78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu35jHAH; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu35jHAH"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3f0651cb971so9419565ab.3
        for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756466212; x=1757071012; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tebn7aIbjDMrgE6QKqVe90Z1niBJ8muco/ffQd7JUjQ=;
        b=hu35jHAHKlLY638BncaXD1VhLQ9f9rM8vD9w9CvYf6JzwJo1EvZd7H1eEzT36D0qIx
         ZK8WOdIbhLyRwV1SyEXAJQ5rZ8M2MkuYAdG7wga7s6NZ3drKXK5nX58jR8T0t4vZ7tLU
         LXDIKmnfCv2tr/CzA1SiZV42ws2seOlX1BB2Li+oIGncvzTevTJcUOh9UKWRdFXJ9WFA
         NI+Uhmxd+6nB6KFJowM6YD3fP4Lit0W5kxVjsjIpbz9LqDjSW+C+IRLXkrrHnDFjUfLr
         EeOZb3AbsKAldGvm8WAVUU+MtG6yKeMt0hYsaK226E0I7TCwCpUvx1JzmTO4n8RVOOxY
         i/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756466212; x=1757071012;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tebn7aIbjDMrgE6QKqVe90Z1niBJ8muco/ffQd7JUjQ=;
        b=t6TI2VKTb81zMVjUltdkOOfr5Er/4lYdHGqzXBmkZobO+/OQXGNq4IrqDz+RGl2q3a
         WUrN9WP+kL9cFvv2T7yMmGFW+Mv+GnyS1B5FdcXqKE4YOlSw+keaPdAeC7jGAoHTARz0
         CyQkoj469gqAbiI0e/YgxaN5aqRAjGThB6mO068X7sJxZ6KvzGIuwc7VkbfdUp15Rdph
         X3Qj7VSoU+bBncqs5mQjOlNNfCsTibUqSXBpuz3XfHReHavde8wspEBxH69ZW6AKhgXd
         jbywzgoNiLjSqbvaHv2n+YG3iyg62iw2wD6HuS2vPiBh3Cy088ZGhGkjpLmkec6peGN0
         vOHQ==
X-Gm-Message-State: AOJu0YwsFgfNojTSaB3zPce5mjbIz1Zxyew7WddSMtiOkwuikj0KMznk
	bL14NPJg7XU2VyB6vVxFVqjm+s4epE2WFAyReZNJ4qgsQvJ0n3+HM4sbfnCpl6s=
X-Gm-Gg: ASbGncsW2kvWbdmE8ncADHV/i+jnI1q3fb9Ana7ZdMXZHm4wAqcT4F6urZ+Nhlptxtj
	bAAuRSAYUMW1fi4m4m/y6s+VnaKfY0mXHjR8mxVfCwwxWXqgu9UWVs1j0y079JYmaLT4Fu6ULoo
	coI/8AHNtSt9ZF+/shPVyC96LQSFeXIn9oaczHNrSU2krE14knyN1m90Lsss42hD+wnJYH9XwPI
	GpiiJ21zzeRrfOX64El4yi/ApjFjwOgW80tx8mLM3xBUhRuunFAWkAgbDDLnXg0a0Aa7Uri0q+U
	JSdxNjJCjSL8CvXmGdbXlsU33Qt6OUi5k8D4eiDhD8Vr7y/viJBzP2WpRg7q+a6ZS/5N9pgLBzd
	BiKxhDRDZi3RRQiQBJxhmZVodhjkId8vc4SfW
X-Google-Smtp-Source: AGHT+IFV6lnyYukckIW8G2DduceNb2slHcr7I2JxOsZhBuQ+tUHUqm8O0C38oS5txNTaBiGmaVZmVQ==
X-Received: by 2002:a05:6e02:1885:b0:3f1:7f29:e9c5 with SMTP id e9e14a558f8ab-3f17f29eb39mr95947495ab.13.1756466211987;
        Fri, 29 Aug 2025 04:16:51 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.160.195])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f29edc29e4sm6317485ab.5.2025.08.29.04.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:16:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1756458375.git.tanggeliang@kylinos.cn>
References: <cover.1756458375.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/2=5D_Squa?=
 =?UTF-8?Q?sh_to_=22implement_mptcp_read=5Fsock=22_?= =?UTF-8?Q?v9?=
Message-ID: <a6a797e5-53f0-e07d-0632-30a142bf2fbb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Aug 2025 11:16:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_add_addr =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/17320054633

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d89353d190d4
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D996822


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
