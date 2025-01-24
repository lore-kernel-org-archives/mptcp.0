Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF01D5AD8
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721441; cv=none; b=QSNJFxTT0HruhzlymKCmK3bviGvlkh3kUXABxJIaXYXzCNNsAHoLOqmydHU4I3rhCVhhNNMWYz9bk45NSYKrPsiCyBK2f8eY0yw2EOeKR/43hvCeYHv/oc7tRY55bPqq30nq+LA3EO6CvJwGo3SLVLDcI0bs3h2BPY4PPUdZ3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721441; c=relaxed/simple;
	bh=TnWU67tYdhlqXU1ZMC1c97Y3oDUIaH3T3NgEcTWzQ3U=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=H23o0GkjdFZpQWMdhBXFklR8p+zC5SXW+LOdFCadJHDN0p/JRQ6TwXsvu0BPfZd1y4JyJFzS/46Q2xmwhDUi98zlGjtP1xbWBBllp4/pUY0SDKmRlgUyQj9m68NcY3l2RUX9lsZZ4neKw0sBZGLxFXYXNpy+ouQlfmSEEr9mT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrYfi3zl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrYfi3zl"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so168068485a.0
        for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 04:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737721439; x=1738326239; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v85thJnUoGCRcrvGPpyGhGdmf/75UbuHDHL21OdA4zc=;
        b=GrYfi3zlzgvuK+1jgYw9f6sNEdsXpyHh1yGsyWEtJwOoMXfVfCTEZwOerVpAMeEV5t
         LtnWC4hiXd+IpacXEwkjREQUCctSCabY/rQ2mjxlZ4z1rB9KAUECEDXE6O+rF39D3ZE8
         AU/nBNdnrxXF80QVVlD35mMXUxFITI8ICDuIjhNpZ44z9/IWmBloOUS5xVNQkM80szYJ
         2dpdyAvVlSj9Lx3UfSk+CRoJDCZgyaM7THAfoexOpkmHZC7ViUVHiphCDDHzMUZpsH42
         VGp415WBgqCDlzBfP6XZLgp3dwx/+as5zBfP71QwZY1bxBEW31x+dIp+XadRnG0GbPaF
         VJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721439; x=1738326239;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v85thJnUoGCRcrvGPpyGhGdmf/75UbuHDHL21OdA4zc=;
        b=OQD1w2vGQydWamX5G3BaSI50NXDpFp0DDOl+PlW48twNBIEZmQ4dAWZXW69CYayIri
         zY4XDH/lCvcvYM1k22TFC04+gA3CislO0SyEObaNSbepPICj357eFaNLAhGlxpC6yaPs
         0gIDT4RZF5djeJBaXd0/flgF8f21Z521zc7cWH9/Og5RP6iFI06/xrFrDAWeVgRquUCM
         SOK38iEDs2vV/U29dPqHfvqxk0R0eXGdbZA15KqarlEQ+QhPI6Kc5KpcmLa9jAxxzyI/
         O/SZuOs8fHbSQwhfMEHejesQAgpEoKthAKxcdv0kPOQ4A9bVCPsr1RzEC9Pe45GYTvzY
         n0dg==
X-Gm-Message-State: AOJu0Yw4+TcbBAPcyKuh5N6dAMX3m0NEl+UIw5bF6OUAYU+32W9VOZE+
	kSUQmyEl49/hocVwYV14agJulFEHCch1QFxTurDGQoadVNS+VxddYSbP
X-Gm-Gg: ASbGnctUNmUpE4/S9SQrTM8BayJatal5UZGOdDmmlZgD7s1Xhn3J10gHvg+8A+beyxG
	6AlJAfh1nR8Xnv2Fr9Y4lBQpX/HvV10zpY2VkVYnB9dx1DlLdtEmEx3C0NdW/M3BpQlfX5hxPqh
	B+J3PNpIn/NFv8X4B65CjHxkA0lGVh1pXQkpsvGF2y9u+4IqCt3djkqPgcw4FCuAxcxhV5bMIOF
	66ya6mmIzTpma/5Clupv6ovXhmhptLh07SrtullYiHURrVSaGD0ZJDQGbiLTek+g6omyt9Oq4Fv
	d/F7fKMRAHyNGcs=
X-Google-Smtp-Source: AGHT+IHBxzQ8cPCO97MDk78S5zfiKQgGwTiBXpID91mvVuqfF/t0XGFtB+0hzPEHiqhV1AwW/tDKZQ==
X-Received: by 2002:a05:620a:4449:b0:7b6:d710:2282 with SMTP id af79cd13be357-7be632893a5mr5495260685a.49.1737721438851;
        Fri, 24 Jan 2025 04:23:58 -0800 (PST)
Received: from [127.0.0.1] ([20.57.46.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9aeeddbasm87042085a.85.2025.01.24.04.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:23:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1737714424.git.tanggeliang@kylinos.cn>
References: <cover.1737714424.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22Add_mptcp=5Fsubflow_b?=
 =?UTF-8?Q?pf=5Fiter_support=22?=
Message-ID: <344e5597-cafa-b67f-25ce-ecd53a958d65@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jan 2025 12:23:57 +0000
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
uns/12948765422

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/927f2c1cee5c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D928101


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
