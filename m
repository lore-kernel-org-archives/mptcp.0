Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376D1C6A8
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680355; cv=none; b=GY1DpbCjoXH3zWI4egGN3ePMBFycYPD0DZQWWwZyb+ExRUOKqHMo89so7IZgjNIWzOZUDMWehPxBwVROhAOY9nDz80X0+KYqyffDshcKf5ng3iI8ck8eDVI4btjzsyVh+Gauz80zb0lZBaufzmZmw6wg1ADTHeeSAArxa4JLbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680355; c=relaxed/simple;
	bh=0mtSyx+C+PQ7PZKRWO8CIqsFdz0QdNvVAG9h238hWeA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=o6vbDXfKNM2rBmq/ChpL5cNPmBlPtJL2/k4LFI254yVKRQUBI65pQMI72VWt+m/2dQPp8Bs28Xu0hB5lzXaYG2JoqHwSduqFoQRE6Ss84DRsBrlrjawCU7S4uPQ8Gq2+stvFXlEyfjG6VBjTZDfi5KACnQt/Rbm5I079705bY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXVUAz/8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXVUAz/8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd78c165eeso19451125ad.2
        for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721680353; x=1722285153; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4i9zGXEWcePqG4X7Cqxq32yO+VFSIALNVThJXx9+f0=;
        b=lXVUAz/8Dijf8RDjeR9t8x1YJ/bckI0eMhPINcehz3hXBODwTiGYMpY+nKDQ8PTRX7
         xaUvKb7aBapyZrHc71UTiPzAkV04nsST46Mu1DEcU/8VuVkXqw6XICWc90LQPgBc6SC7
         oqXeht5S8cBbVA3hv5n6chqWtOJT/Y2FDK+DKrKhesa23kRxgGppjNGCAAG6XoADTefp
         2JDRs9MlRO9emyx5E0voceEDWPDCHblEXPZORgef16ODFxqgDRBbb9Bh17ImSPo+u9pG
         o+dLHf4VBvn9WN2Mlu5OvSlVChj/xRKuktKpvEJrTj9TN3xftW+ddwlVD8bM8ofZmY4K
         90Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721680353; x=1722285153;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4i9zGXEWcePqG4X7Cqxq32yO+VFSIALNVThJXx9+f0=;
        b=Uuag6qJniSSsiCvP9VNi2TSxiu6sSAgaX2n/GbGdRjLa4m9dCQ5d0y36rOSZNxDHgY
         N0+sN0kt2sBQA3YccMANXly3MDgnDBB50dV4Z9aBH835VUEgUIvqaaZ+au2zHJ+AxOQq
         y5IPOUY/r9RJM+NhyIT6NYo8MgC7pf0HVPw2a8OWoaQU+Miiy1E6CIENEt4qR/GIKGZo
         lGc1HNHIxK4KpRK+BzLIS6Yds2nYqGi1bzEZm8IEIngF/Hg2juStrR447NRej7cfiCjJ
         mZE6H1BTl5K8ny3/554NwNqhOwCPWbYryqnWVtepbjZCK3kCa2DBc0RPbUj9SnFgqk19
         789Q==
X-Gm-Message-State: AOJu0Yz9DiiHhgtDvy9XyPMZq9NHQQI79P4kk5caOOvsjgJUMZi2xkAt
	yWeQDRb7cEolV4hSRdVXsOmDfBurFHB1dOU7S/g2n8NOsBGuiZ8=
X-Google-Smtp-Source: AGHT+IE92uf6pKvM4cvuM3IvjjSVuY8eEt8qQ4WrhsPbT7PkZStwycaaYkO048z4HkRGJtbhHDNlQQ==
X-Received: by 2002:a17:90a:8a88:b0:2c9:98c2:f6d7 with SMTP id 98e67ed59e1d1-2cd273d5280mr6207744a91.5.1721680353269;
        Mon, 22 Jul 2024 13:32:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.123.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf808f01esm7464495a91.42.2024.07.22.13.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 13:32:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
Subject: Re: [PATCH mptcp-net v4 00/23] mptcp: fix endpoints with 'signal'
 and 'subflow' flags
Message-ID: <1bcaee82-fc92-fed8-eb11-941d82769e08@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jul 2024 20:32:31 +0000
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
uns/10047466924

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/86bf23fada47
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D873047


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
