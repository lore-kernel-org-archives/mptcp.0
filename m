Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F3139D19
	for <mptcp@lists.linux.dev>; Wed, 11 Dec 2024 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890660; cv=none; b=K0w3ud/g38OWNJ+9uaasdhA4cyAwZOiC1MTQLCezpckdI9O4PYx0k7VTymbmsCh9uyqymi93A0SWLSQ0+cPfC9rQ555iBg5PIue7KvX8pI6yfuZ1vaS2hGUF4yoK2JzcP8V0c5Zutj8QCvqilkgeSB/lA2sYoGo7Y0xfvRLK/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890660; c=relaxed/simple;
	bh=1nXbwZxKDAcB18yCzscnlxClzl7l76K6Z39AEOxY7fc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tqv4JAA/1NbGv45+r4+nvF0pRp0tUC3euM0sKM4K9/KI6/7Afu4HW9odWGtvvBVW7lsiNzBHbAjP0EkLOf29UBmq/QQ7Qi1S+vXiQxEJb0rtmmaxMT7VCFrmeWp/mvC5nZhEwg7O3g2WF9oo4qvn+mXmjELhtJKGtDeSix4ELmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efwqcmku; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efwqcmku"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d87ab49423so61880136d6.0
        for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 20:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733890656; x=1734495456; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAIVnX3uKNHgx9ivYNunNmUFRe2tLKA4PmFP4ByLb8E=;
        b=efwqcmkukBFb05K45ipRNmpCJDLcXSXeUBncn+OMCCsdsjZY14u2oeDpLN57L2zU27
         Pz798PBkKVRlnfHNb/16Y9ahtNkNtCECsyuIT8tgInbuKoJPkwuw2GbPyKFPYWnHFKzH
         fqH52dTZOzmQhcAz13mibZSt1DlfY7ivEUeGCE4niHcfdTSPdM6Nqn8TOsxHyiRwZoKJ
         1+AtRHFQ2fFbkxR5R4LI/YXoDLjJojazL3lP/4lqZZWiRENm0fTwLVqShfOHvIQWyAVn
         YZ5OMsVOqbbvVoE8MNJmoAaXJ+O9R39VlVcdtRhZp1cxaLFmm+W9PaXrUYEsGrFp8Dv2
         adMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733890656; x=1734495456;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAIVnX3uKNHgx9ivYNunNmUFRe2tLKA4PmFP4ByLb8E=;
        b=bmDd0xwaad8dTciG9Zl68k8T5TQl5K3XWtAfGniNh9gjoE9TBlIb3bpuSrMab4u+Xj
         7npAPNNU/Sna1IRFTb1iQLSenGwODUqyyIrcH+GzBNE9piuttn+qQa8JfU504za5EdPX
         +cVeh9og//BT9FZqxUXhCENB12X9mud1F2cd+fuYf5XMvm5+qmdN2cXRdOvMG2cIWtRS
         /IeX3gSYamrLKDTnJ/wX9bKa06owPWvP6VrpLU2GZA24cFpc2IxxemFloPZe4YmFDbz3
         et8KjDpVdH6JIlLgZ5QtfsdNU+C6tjLwN6iF1a6r74FCYyp7WmGKDlLP9hV1phn99NSa
         1wvQ==
X-Gm-Message-State: AOJu0Yx47af6KMZwoeVsrFJ450P9lnWcQhTqo5Uh/Gu/oVnQB9WvjNrV
	g+KONrm+uwaLX0FLaIwH3vhQlbmkvDADbrGRkm3G3BJ41n6z7KxSdO4W
X-Gm-Gg: ASbGnctd2/sBgvWDU4UipdGB7NnDRkc0jdT47ICvIdVDe8M6OCcCEsmD6eJx79oJFD9
	Ahu/CcX8fKvLrHvyAySKGDD0eyRhOPKQMvvd4B0o25SFD8m8tlaxrDkOiuCVlfXab1Akj9ougDe
	YzHXgcwV18Zf0G16RXJk43ki7HbJP8Tp7DHqi5fboDOA9eU6i9dW1usOHRpVCvDtff9aB/E4Wtj
	uLD6m4qtcH5DiDb9LqDJg2168bYkryrpg0MiX4DLBNFR7W2eTyPVq3maQ0qSu2WiIA=
X-Google-Smtp-Source: AGHT+IF0DBcyIVYrFS1iPyFGuQbtLKSn9jPQ7MxokaqP2pF2Epha2+0DEv97AL2jTuFtGKG4aknkmg==
X-Received: by 2002:a05:6214:2029:b0:6d8:850a:4d6a with SMTP id 6a1803df08f44-6d934ad1c7cmr27589696d6.1.1733890656296;
        Tue, 10 Dec 2024 20:17:36 -0800 (PST)
Received: from [127.0.0.1] ([40.76.181.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cf2a2745sm330137285a.56.2024.12.10.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 20:17:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1733886326.git.tanggeliang@kylinos.cn>
References: <cover.1733886326.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v5_0/5=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <b9588a74-edb7-2a21-ae1f-d21aaa0c1a69@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Dec 2024 04:17:34 +0000
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
uns/12269151441

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ac38a98bb667
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D916627


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
