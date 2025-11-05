Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652330DEC9
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342664; cv=none; b=AfK66gxdn1MDaW5V9ZXTRHFEdbgE0MYQDdTdgCUtNCZTCn6g5Ir7OqnFZL+Q4/St6zKUt1oCEjQyhbqTi+DM7M0UoYca4vB+orQZ8WijD6I4oNn25g40fTF78lm+WgnS+HUf7wS80Md01QFU5EC/4BU+dgvc1Zs/qbWGQORVBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342664; c=relaxed/simple;
	bh=Tmvajdmhc09DHUrWEBeabu/WE5lE1cdVj709qtDlUAg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oiJIbFU+DZH89MjFEYl5VDKEckk05NZgJImn9HzRrxih2rTU38o2uAs5o1oTA310imORDenOajvA+pJVRd7m/6TYFEI1hWakNOs4ffj60ka2RoxSRN5kwhvZYelopHU9lg/0g1IK1lh+f63Z35Zu64Dy6tWRSHS+rE0nLaM6EcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5GA4stX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5GA4stX"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so2500731a12.2
        for <mptcp@lists.linux.dev>; Wed, 05 Nov 2025 03:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762342662; x=1762947462; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7wbGUTK1+Ye/VDesW9TcMWDPYD51L4FzY0isEQM7oM=;
        b=e5GA4stXNFjlwbcFrcc//uDWdczt8BeQ+s41BIVVaU2CFahIzqUc9ue122f+zFArZ0
         pHMnVc/tEeaOFK8QVWMR2oW7p97ov5HlU939/lrzPsBwt2KMO9kw4BnG+ewn1riUl5WQ
         /F19d22HTEAv6hPl473C78IDfRbZ4ZYUEIc4IwbWpUqg9ayfwiSQcHog3t6NItVNmftf
         BP7qYhEEqH/k6aSB0/OWBmcWklCnwltynQz6s5t8AKOCaQw/LZd5CkYsqZRrZbO1kGWs
         JBhK6uu/hpDLpqSnGbsl+AkgTBVDjUbR2C9nFSdepL+HhOo9nkI1jDi7/3z4gdHo/zB7
         NZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762342662; x=1762947462;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W7wbGUTK1+Ye/VDesW9TcMWDPYD51L4FzY0isEQM7oM=;
        b=G0g/BCFBuyUL22SB9WWZWAC9hQXdmZD4Kwr/G8xNyNd2VFQqjouis8Y4aXYS6ObRD6
         kx36/byCprFrn0UNwU1nbgTjG45twyfAeQL3uOIIb893eUKJ2ujw0vHprQ3xUTir4IJ/
         pynmtJw5abXB31sdYZhy6eHZUTLNbue7fv5Kh3Qn1a2C8AwlQKF7CnvO0XHZXwGiuwl0
         ReQdkUwE+I09gwUxnv7pbvEw51bk6T3EfKZe8SkkQ+7BO5VglNmMlxZBwKkcG7YygMq4
         b2D3ORYs/gwO5/ec0wGx9p8nQWhXDoigrao0h6cxMM4+gxirgQwgaMHxYRgTUJJgROzC
         pZDg==
X-Gm-Message-State: AOJu0YxQ1NqHPxXkMPICVRmL3/Ql5/PVJ9n19dxGFCY4vB5AFel9rMzL
	PaX0a9gFW5Gy8Fza6HvcWXLSMnStL2NFvJ5fDiVEOqXoWZpWArmJNdT2i/wK
X-Gm-Gg: ASbGncvuruacjI0cRvLvGwa/bIEEXGHq9BjULXQ4dN/XtJFY81rcqdjBWEhXU7AE4gh
	7iQeIltn68SAGlYm54yKb1cK8xp5AAdaQZmJDTgK6sqHqbSTzUSTa2/yCWFeuYFhErfm+0JXGdW
	JyUMSISZn0YeEYv001qStv6g411RE9chKQez7GwIwSPjFHUVJqqF4j6HmF/60ZrjIao/xmodBNr
	ASc6ApqwdRGEE/nsJ3+CjP5nXlCF1RNiZ8Cl/WPp9XOzZGHEqd6eKwvQ3trQYYrLa027ieRxKkp
	0VwslwHarUyl7zPVk7sY/8vZBnt+A/9j+Q2M3tSpKL64E0/3knsRcfSCHjI3BmA9W1FFf26Nnjx
	V23apQ5TQNKH022pUWK0mp94QmqlaBPwIBHYQAmzWysvcy+fHps8ch7QVRsoZp7/+IWAU3sz2um
	4oJh78KPxpy0mi
X-Google-Smtp-Source: AGHT+IFTpHzm6G99loiTQAV4lmyQDI8d0AO542dY+OJ5OZJ3/tIVeeH4Xd2ySM4EJXZphSOqzb0nZg==
X-Received: by 2002:a17:902:db08:b0:295:f508:9d32 with SMTP id d9443c01a7336-2962ae55881mr39009695ad.37.1762342662219;
        Wed, 05 Nov 2025 03:37:42 -0800 (PST)
Received: from [127.0.0.1] ([128.24.163.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a92sm59438835ad.7.2025.11.05.03.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:37:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762334694.git.tanggeliang@kylinos.cn>
References: <cover.1762334694.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 0/7] mptcp: TCP_MD5SIG support
Message-ID: <82102115-e7c4-4347-41a3-7a3453439512@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Nov 2025 11:37:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 3 failed test(s): packetdrill_mp_join =
packetdrill_sockopts selftest_mptcp_connect_mmap =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/190978=
49691

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/73158e211c60
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1019796


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
