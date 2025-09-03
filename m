Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F54501A
	for <mptcp@lists.linux.dev>; Wed,  3 Sep 2025 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879857; cv=none; b=Bi+RhPWYtXGV2KPiq67Y71cCOyJSe+c0oY2x+8ZVERMU1EUNEAlvsKr4sf9aH7i65D67/PjlrDc8DDvUFnmpRl+PIzutKmRGZ06bDrajCfN0NEbh9Z7HyId3MyVtVdN0wckMTv8EQQojjNcbHYBX+kfLJa4Jk8uuGHplek3+h5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879857; c=relaxed/simple;
	bh=z0CLOT9GlcrZoi6WxpLg8XQIWZwjlro0yrTng/AjyhA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VRgHFyddlqLA5rlHtdWnRpix/K0igMNwkTR/hx5aCPpVqlpGLrFHV7GDfEft+ykpFcz5/PcYyEoaYKUAJvW552KK+F7qTX9Y2/Kol3GN1aMLerwePTDwS2UPhQJmJEOmOL+sk2GRstK0g/qhY/1miLMIOVurREAJgml8ELNb1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAWpsyxO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAWpsyxO"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e870689dedso371842585a.3
        for <mptcp@lists.linux.dev>; Tue, 02 Sep 2025 23:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756879854; x=1757484654; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpjPX4IiOLESDCfJcCuyxKVDWvdhGSh7eOzDLzSZRbk=;
        b=RAWpsyxO8WfzrMv5A8mcqmtlHP1RRnuc2/QRd6TBgFw54FGQz7n8CRmAWCwuBxKJre
         q3EWCGyX+7ZSVc/x+JWr1WMpvQ2q97kzMiyWcaVjGanFeff4cruBcA8oDqW5DoGOjffZ
         Ye7jFUHZMvYw7Ef53tWs4IAiB9AeMGBMjn3EeXfoOZCMIQGVb6r3w/piGh0uBmOnqDdr
         oYG+KJjcfDzWPTaGCoatUvKOkORzVHG/daWY1g55IHcPyiiOobnuVpmIrRIDvrPQnIc3
         yYAYTmZIazwzRehXc/QegzbTwetUTFVg+Ab/k3f/FKO7lve8ECdD4SvCRBe+VW5daaj3
         FOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756879854; x=1757484654;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpjPX4IiOLESDCfJcCuyxKVDWvdhGSh7eOzDLzSZRbk=;
        b=moP4AWnX6UdVpTO6Ebyt3p7WxscAukiOPyYVAnj85KKEnRBQU7woJf3TV68kMo6Sax
         OijK5cU2vpoAStZgG1fEPcQsUFZZyRya94DZ9uAVUyXgrZ5P/2/R4UclzQx3HbNR3SvQ
         R0Ik3/LBJMLzy1pTuJ79MZd42yf/AHNtakUqsslLD4jQ39DZQzq7s8qm2mr6oTyEU4P+
         8WnQ5kvfcMfrs2k7hXPf3F7G3fW0mtPDuesZoeaJQ1VvbfPoPkCOd7ejXblnn2/TXQgu
         Ujei3MIek0tqelUWaXq5ymiess+THnO14YjTCFD7nrb2ywCCsJVbkg5h/82QHjv0qLRI
         Xk6Q==
X-Gm-Message-State: AOJu0YxKYXFf+/c/FEipAaktL28XiU/+7UUIvfteUK0S4UzOt5SFZIca
	DjbM3d9w+S94g9LwMwQAfOjxK+1gwGfpRbnts2pLjaTRQiv/vgwvKMTKcP0Q
X-Gm-Gg: ASbGncsqqBRAgvwEWMECVni8QUMYpCRp9GsDZcWs/gMQZEwR37tkU14YtE2h54q57/3
	1Sd6CPdxiIZ+mxyyobvHTBoWEWPqAignT/YIZFXFddZgHjm2DXdgSkK40EO+jjUMgw96sVou85m
	599O4xe0b7DLHCsl9KMcllIlX/0KYIw5elTLGSKkCeOtJRkvkYC/0W0P3oDEmmwuU59+s5zJ3a9
	wcJYpfDLgiM9LfFigLuTHOAU6jC3wDJGG/l+Z1ks40lPu1zk8EE0euBY45n7sFGJNmx/YOPRHgj
	DOOVwcZWOHWkjm6+aex9CLkZGUThcVcc651qMtDeLV09YbfDaSjEv+zm+2/hk2xJIt9YasUFHlj
	c/VbO2pl1rqv/2Fhci1KMYZ1jG38atLdsbw==
X-Google-Smtp-Source: AGHT+IGUAAnujzoOQP6i4+EKuAMS8YOBOipOp2Od6xyQoPUZIDVKI0qsUV1a/rlZ/iruTXrlkUgWpA==
X-Received: by 2002:a05:620a:284c:b0:800:fbd9:b3d1 with SMTP id af79cd13be357-800fbd9b67fmr1433962785a.73.1756879853672;
        Tue, 02 Sep 2025 23:10:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.159.33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f66cd14sm7047151cf.19.2025.09.02.23.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 23:10:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1756872050.git.geliang@kernel.org>
References: <cover.1756872050.git.geliang@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/3] misc fixes for sockopt selftests
Message-ID: <d2e1e7f2-e643-22d2-70a3-c58c4e417787@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Sep 2025 06:10:52 +0000
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
Unstable: 1 failed test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/174230=
40759

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c5af9373827e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D998230


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
