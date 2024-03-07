Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6C46AF
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777089; cv=none; b=NXS7a1u2yNAeGAxYA/+XfDNHGZRYvKbNnY3U4xsZwfxFfUDzLs086//l6n0Z2c9f4/3Yp/U4PRcW65Dbeev85Al2XfGaELlUGs9b8tLUrEBFCOHm7zVKEGPQoW9CUlrPuX9+qaNw0kfF8GHEdoExbBOrNlP3so9Hh8AqSvWVY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777089; c=relaxed/simple;
	bh=1eBc1KMRFCzA2c1Z6cxKhqO9XcRscX5frMsZwvptKjs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XObAsyAYT9kslfkEfvUGwIntJJBWR1nloornAUANBUmSa7fj3RVXP/bPmMwW8hQBcfBh4fu9AIIl7iK7zB/8vxmSFSZTqLXUm2sZV5eMWkMH1uKsBI22ynY1Eo5PhvNw71VYMcscpQz4CQzDtqjnFOBggWaIxtTexSUp1HNdqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3yi6NQm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3yi6NQm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so2967505ad.1
        for <mptcp@lists.linux.dev>; Wed, 06 Mar 2024 18:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709777087; x=1710381887; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfqtPNyjMtJFRwjUE4yb7E3O9trlF6AMWbRzx/WdDQo=;
        b=Q3yi6NQmIQRj7NoWL+eH7DfV7ZxnPwR26g49EEt5cuMhsQIEQWAbkaXUaVVXiCFZkh
         SQaN21PRf+X79OLxFAilInPm8DcOpIz5paIWw3un2ifjU/kiGJcxalGHfjNKyvJIgYwi
         oOkYxpWhLYMu+1cr078ttNzxxdbI8TyWLCgbFyzYAmEPNe3BBO7cPtW1khVIsDzk6EMV
         EgRsEil361pDubemlnoq6YkiM8qkj2bvUx/bCXY1e/qFCtQDdkuMXcgZvOiPgH9egp+H
         0SChfA/vImAE4viYR6Nspvmr4/DphEEQqiNK4ZxsIhQS8CebMwzmsBqvzLGzIfLRHIq2
         LDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709777087; x=1710381887;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zfqtPNyjMtJFRwjUE4yb7E3O9trlF6AMWbRzx/WdDQo=;
        b=Ie58EpJxLTlgYyjggAe7KA1Sufvaqhxno7M5h/yTR9FPClzCYMeM5PzoWzD92DvSIT
         IEqDA6ZGT03IgnY613Y7FHDnPz/4t8NpxCsdfb9naTJ9RDhxFzOL079a1/Jp67uXrmBF
         eosi1HmCvNLOWJ/HRm0FVToKhoz7RqE/+sCl8gQclr4g22lRwl5L4/8MTvFr2m3xVg4H
         w2BLHlQ/0YbsaUzoQZ8IranlBRv6LpGnMe1olRrXlOUxfsa3+6U22zlBBfFokJp4alvA
         Z71J+5XvzCFYI12xWXoWJy06jILTC8YCCYu6PPYvZPXewqfIrnaX9/Yfkfawm/4I8/YX
         974A==
X-Gm-Message-State: AOJu0YxEbVJXozZJBgsyW40GvuYqaeY+DSGEkMOg0V9cD1xPF4dpDoRv
	YaZ+HD6AihTrhm8x80O9hdKN3SxexWGiCQ5Obzqx1YuLSNsUiNMCXQ+YcLI=
X-Google-Smtp-Source: AGHT+IGW0NF9ouP49nm1+HFPYgTO0baqaTXd8lEDI3CUsrheSCrPxAyAJ+peaZTuq9qzU5lnHICoRQ==
X-Received: by 2002:a17:903:11c3:b0:1dc:d8de:5664 with SMTP id q3-20020a17090311c300b001dcd8de5664mr7886594plh.33.1709777087124;
        Wed, 06 Mar 2024 18:04:47 -0800 (PST)
Received: from [127.0.0.1] ([4.242.224.21])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001dcc28544dbsm13286478pls.78.2024.03.06.18.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 18:04:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <06f55d6d6a1f37da444bbaae9262079d300efe0d.1709773913.git.tanggeliang@kylinos.cn>
References:
 <06f55d6d6a1f37da444bbaae9262079d300efe0d.1709773913.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_connect=3A_use_+=3D_operator_to_append_?=
 =?UTF-8?Q?strings=22=3A_Tests_Results?=
Message-ID: <0563f61a-a389-65e4-42e3-38d0635ac98e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 02:04:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8181456175

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a61bf0e8b8fd


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
