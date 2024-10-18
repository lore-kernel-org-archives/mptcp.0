Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE74168C3F
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247189; cv=none; b=nfE6X+E5xr9Pb46nSDNbGrZgEWYL8BLRHO277qiCaKq+99bss9bEUsMg3paE18SFr8zKLWiq2zqAutFTTTufTIBT7r79NA+sZbCcwCweNTdpj52UduzCA6CFtpqer0rxvFwqTwWCAgiFSu85RHLFCXjnw47kgQSMzRkgMRkqXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247189; c=relaxed/simple;
	bh=qzHaYUQDC2KH6GLQiAMAM9A8MolhpJdBT/zbzBFbKYk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=QB2LjJcx9BluBGX/9eUj0h98LRtL7IMmjSM6VPuoFhiaqV31dCghJTPKFGzfvLYzPTpxfe5LI0CDd7KhJ69FvxTmWhW7PTmyAQHqOJeq3ZWfufPTOnQkCGK7+VUWa4H1bpDU33zUYcCX+y4Kh3YECTL/9i1wNuM495JoBklNITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKkjRheQ; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKkjRheQ"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50da1fceeacso706413e0c.1
        for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729247186; x=1729851986; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQOuMsSyzFzlaLF7MPY5eFsuMY8rMYnipmp9wORPF/0=;
        b=HKkjRheQuZzONM26fw0MgF1JJL+hAksC+hULCA5Gw2X11JHPhQWQlPi4sg3NPciHFQ
         29/3Bmqn2GNrsRo5mjqV8cBHzumiS0zS0/cCYlU20a7/pVEjHH1OMEeRuKGSPKGwBezi
         fsgvJEf6idZMSgMs+KtW7azVwXYRK1wBjqwnhT1DIvj/egKIbGjv0IggXC1+h45fHAN4
         gaG+FrfhMhbx+hB1iC9XDdD6pAA98a1KF5qPDPx5a3NcoQteoGiEnjRxPVq4n20KNx+o
         tIAtpFPcRLd+uGMnA9krV3bqGeNPnnevMh0b3lwkIt5T2Ch04vkxlzTIQmigm1cKY2aJ
         L3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247186; x=1729851986;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQOuMsSyzFzlaLF7MPY5eFsuMY8rMYnipmp9wORPF/0=;
        b=pLgzoTFvWbjtOk131J8bzcBuq1/dr1qM0BIWbKDKiyEP/faZSg/ftCsb0Z+4dGUZy6
         whvBzqjZOeBsk24lCopsmwA9/G9ycmktFoGqxJ6FW09be8uOYgsbXSuqnAZukeiDy4zv
         PQ4HFxXOlfXOzYRM6YehqMQtYll4C/0507qNlGtQGUx719aaBdgZfcj1mfBRd5U6M0RL
         ekG9VCyg+Ictgvo8Wvd/yDUftbhamhcPP2RmWhxpULoKY0qIJ40Bplz5FSX+gZeTNzjY
         Umo19z0zq33p3rQ5u9nXUSoZwZ52BU+O4UjFEwCdXz9tU7wIfz0QujJ2m3si0j3VWwve
         e+Ww==
X-Gm-Message-State: AOJu0YyHEO/PKED1RqwlJbx5s5sRfPg2zekiw7ic/N9fxHCAu0uebIjE
	AwCJisJSzlVbc4m7WAWTUao5931ce89tVBX6y6NPARz6VDz0kz60tyNdekA=
X-Google-Smtp-Source: AGHT+IGYUSxlK4O4ow8hfTc+LRDJIgKpk/sptbopCL11eWbbbQHvFTVkPCubi7hTvyTqd6PVI8UTXA==
X-Received: by 2002:a05:6122:512:b0:50d:35d9:ad60 with SMTP id 71dfb90a1353d-50dda1c47b6mr1882944e0c.5.1729247186518;
        Fri, 18 Oct 2024 03:26:26 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.13.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b15700b331sm55589085a.132.2024.10.18.03.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:26:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729242644.git.tanggeliang@kylinos.cn>
References: <cover.1729242644.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v11 0/9] add mptcp_subflow bpf_iter
Message-ID: <d8f7465d-c96f-d3e6-f2f6-446fbf135a94@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Oct 2024 10:26:24 +0000
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
uns/11401212139

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/60a695fe2cf9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D900611


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
