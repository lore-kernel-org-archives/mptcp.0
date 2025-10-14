Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AD18A6B0
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450013; cv=none; b=teQigThseX/s0K+NhMHKjxd7pDHSbWHDTj/leKaY2L+urITJmab/7jh0ylCSyq3IhMQUySaR7nDLDbXaIu1lv2nnMjvsCwBDLPidwx68haiVCiPl+MiO4rsY04aFd+QNMfAq7xR6O+SvAaHxAffpmNA2WwN5mJZ0QIdmRzucpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450013; c=relaxed/simple;
	bh=FRHx77J9rp8/HRgirWQzgmqowDrmgVO7r1SJVCO6bFI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SoOX12r/nGnn9RCEw5hdBCyWos8qEYHkOtzl2EP6Xrcud8o+J1rC4giYJLwvrs4Hiul5ptArmrrWLb4WPyCmDVO1Perhfch11vC2yNYknIDiCHktQ/6sjfmPVHwimDxUsYxcEgLmJBNKiSR47jYtM6b8PldrkH6OocmJ7SEE46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXl1/01r; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXl1/01r"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78f15d58576so63615406d6.0
        for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760450011; x=1761054811; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmImWrwVKbjYizoS5dHjyW8iaBm+ugSPrrMAIGeoFbA=;
        b=XXl1/01rbiwQXJMuk8w+fVqHkXcks8XH3ZvYwOLhGe7T1vjNw1oPs5qmaYb8MTreAc
         80Y6qtN5t8WQvEedsoIZKWPUsTcmqpLJaDwXADf7GyWG9dgph03gHRDJjRRsOKuQ+KzD
         sJ/wiJx4yXFNCNNQc0Q9WReb4SLG6JVPsCySOGI8GB0ssCaIR9LyvSp/e0GE5MjVEql9
         jgkpPMcop9RL9YLG8PFC8zLTp2SMMC39oBPRyCMCMthV/HllBSFUrAJV5Ob9F4ww9zVM
         PH73ryq4elkSKpuqpIhgcOKsxtlewahOy/z+nQEtkhenkthKE7A0S0GI34dihMFgif3B
         Ztgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450011; x=1761054811;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xmImWrwVKbjYizoS5dHjyW8iaBm+ugSPrrMAIGeoFbA=;
        b=Mc6T6utCNXyCUIlBDyaJZwTov+rJB/bHj4sZXEGElqhrupzdjzHmj34PWuDysZ45OO
         koNRAXz+eo+s89A6buBS/Y2ZwPxqqIa3LH9avU5IDQc61eTTflxHVt/4MqFKl5D/PoPu
         rHeDOTi73jE5aTOmgNCRpvvBQSnPLwZgio8NBW+eDGq1qLbJsterE65h7oIa468TFBfH
         fCofBfY8pC/rWgpew5uTDGOwK0Wr+RFgFLoIdD4gHMMGGqhMltFSH11+YV5mNSAWi4dZ
         JdPK3DU8a9p6CrOxJbeLdU50Uk+Hjo+Yn8/iNb2IGelk6JcGviTCH4omoy06gHCmc4rA
         mYsA==
X-Gm-Message-State: AOJu0Yzs3t2/UuX0jCl0XMzA9OpZm9Q6gDvPV3mfFchwNdBX8Lx6d+rw
	ZYT/iZpOYUm4wWy8Cdm0zom+o4NSVt0XrlaUZVN7jvHewsW/vvegk0M=
X-Gm-Gg: ASbGnctElo99zDnz1czMWzX2v0I24OsGngiUTOd1vDYgt244hohvMA2x9S7JYWDugHm
	922kfF9IKhPySRYMwjHFkoqYgXahqjM/sSoED6MuRzIcjkRHab6gzouVUGyKNTnjynZntI/e9Qx
	Ikd78rMXK7A4IS7Hr7TunC25t25F+6+0ESrSZj1BGl9Zi6yjXYru6n20rLUonvCA2Ayv88/YHya
	Qq7uFnPd2jSsWj1ml/0Nx1lNkSE32Se812A61mI7Q+HjrzXHQU/FdAVTonxO/OvpH6OLTJHEBel
	ObvO+lMYI5i997zcI+q0X+DGsiZg9wjyo4+1ebsjrhj8tXTA1MwCGBNvJ5WdOSQ48Ga3mbPIXhf
	SauBuUEqGPWBz9cTksoay/Qlp5nX+iMCCFsawmWB/SiJAvNGS8Z1vv23M0vA5PcmSTI8=
X-Google-Smtp-Source: AGHT+IGbmfEQZha/X26BjobXdiRo+z8JRFNkDpKOBDTG/7yb3LO0F87PyrdHRvns44c3cXpCXPfzaA==
X-Received: by 2002:a05:6214:c67:b0:787:f736:bc66 with SMTP id 6a1803df08f44-87a051f9200mr380193676d6.1.1760450010782;
        Tue, 14 Oct 2025 06:53:30 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.102.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35b1f1dsm92172546d6.59.2025.10.14.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:53:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251014122619.316463-1-jiayuan.chen@linux.dev>
References: <20251014122619.316463-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH net-next v1] mptcp: fix incorrect IPv4/IPv6 check
Message-ID: <b88b727b-ed08-1a20-6ac0-e51d2d1d99bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Oct 2025 13:53:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jiayuan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_mp_join =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/18497133102

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3d065c91b0dd
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1011291


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

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
