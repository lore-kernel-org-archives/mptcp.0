Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E324A12
	for <mptcp@lists.linux.dev>; Mon, 18 Mar 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751893; cv=none; b=uYZvaXimcsfq0FbC1tHDO0TNQIzlUFChG79gRG9USPXuCp1KK0hQjb9gH7+Zg9hwDXuDjQXdb2DrO2LEeUCRvSN4sqojRQYnFQ1cABaBhEXQRwxvdo2SNfJ912qpUizqQEjBQBqGY4m71WXkZiLCcV3v1hOiG0JkRAd+8dmlM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751893; c=relaxed/simple;
	bh=6AawAzziewaOG54yJjoURBM/LDzhW2nY2u55gB1MMRc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=u05yevR38uTf52p230tQ4j946WyarEJOcSGWv1fNV5Sqe7+8/dCncQBiGQZQznZPgfddrmTLEQg3ushxQ/bdCj74bOpzRMLukJjld9hqtgoMDoF81nTANNcwWZHSuP6O1MDEclx8zId/RHbJ9sefDID4gv7ENClS2qfNZanmt2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJo+vWUU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJo+vWUU"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6b6e000a4so2903083b3a.0
        for <mptcp@lists.linux.dev>; Mon, 18 Mar 2024 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710751892; x=1711356692; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp3h3YorW8aYWA3R3+GowB6pl7EPTxYPahKE56QciVY=;
        b=HJo+vWUU5IsgkGeV4NV/27igBoS4p4SjQr4v/zTALfk/E6+nMxpljhdaREXSftYbBA
         YoLqkFMsSyd9TRLHPLxydGDK4c/2F1bqgOda8w2kCIvqSwvljScJjkdIVrBcLHDUhtD/
         /knA9GeHAU/dYaza+Moo55Xo3XDLQ2EWvplcj7q7f/CB26DeM3HrirAPZuVsVBcwKYTv
         O4RFG5eVdgA2JUXNtThREz48THfO6hSME3D7vNaOnMW5fmVlfqpJQQmwcNffGxEBWTko
         ogLlhxeX794XYLFWG9KZb58lDNj2yPjgu2a9uHSG6pztvTv4d/o95popBYSO+RQup265
         JvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710751892; x=1711356692;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qp3h3YorW8aYWA3R3+GowB6pl7EPTxYPahKE56QciVY=;
        b=ju2+F1liy51CmY/J6XaCxK7sw39xgddcI1dcSt0fz4g2W1kwmAnUCot3IDObeqYrbz
         njoQ9cEKWXYCMkNANWJ+IWzZxMy+TM44d1+flQz11oUqgsK5/A226jvCs86D2tGmhUfr
         ocb4z4d1DjsiYTZN/QXqACaoyjaWspZWYipG/EZSl/ARolNp+pNHFa/gm9s0OR4NTIpG
         k6xektZAyEtjxmXebb8+Ku2tdaXiEbtKXq+q0ixbvT4uUsBWBbxS3esawhDC1Y5XPiA5
         lHDHoBzALJMyqcLFzR3YyBFdmJFFFnodCSfg6RYp85MsuH6LZoDZw5usA7rHMtm8ELmx
         Ohxw==
X-Gm-Message-State: AOJu0YwRdzV/LKL4Dz4LGmnhPf84dik+vm2DPSwh6QV3fsGQMwwmqHxA
	utfr+NU71rk1uCbMOa/zEhmqbtpw9mCm2QqW56Mnt0vX+J6Wvxtm/nBFRIc=
X-Google-Smtp-Source: AGHT+IGdc/SxoHsINfBsJc/QB2Y1VM7tBOFl5LkZ66Ld+WB1WgaCwyZwLTbkUo4k+Ao0Pr3EC5IEww==
X-Received: by 2002:a05:6a00:3d0b:b0:6e7:312c:14b with SMTP id lo11-20020a056a003d0b00b006e7312c014bmr1414610pfb.13.1710751890884;
        Mon, 18 Mar 2024 01:51:30 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.81.106])
        by smtp.gmail.com with ESMTPSA id 22-20020a631056000000b005e17cad83absm6692415pgq.74.2024.03.18.01.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:51:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1710748923.git.tanggeliang@kylinos.cn>
References: <cover.1710748923.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/3=5D_display?=
 =?UTF-8?Q?_=22last_time=22_actions_info?=
Message-ID: <2f412e04-6040-be34-8e5b-3c5251c005e8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Mar 2024 08:51:29 +0000
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
Unstable: 2 failed test(s): packetdrill_sockopts selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/832327=
9037

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/75ec3d556008
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D836000


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
