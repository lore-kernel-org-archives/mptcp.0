Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888C213EF4
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422268; cv=none; b=Db1P6Qy6gLLNeo3BIGyps+8Bf5siQzDcET/zXGQddzVZwxGm2W5u7jiC4g5Mbd45xd4ehzCmVGSBwA+MAxSaBqLjZTHbcPODuNQofJ1DW9/GRAdvMaRkc/1TFT5IUYYgtkot2Grrnm+zlj/LU92dMH5LLUg759KkWwDfuq5g+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422268; c=relaxed/simple;
	bh=/dgZkuCqEyGb3gv7cr4ZxaCkHWplS1/lCEINjkjg6Pw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=drjOhE+IgTQ9jupAWiqCb2uJxbgcxghGxM+/KOV1Ozv3ZSimrKh2wD8c4+pMb+IRjrCBpmIhsMrV+KnAHmPZscWIO3kNzDfTYnAuS3h7TYGbJXDtCH+7JUscRwwblwBtU61vwNXWZKqz8m0H0PqckqlNTuzYiTsyKUjRqwrN3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNdw9pF2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNdw9pF2"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbc28f6d10so6734686d6.2
        for <mptcp@lists.linux.dev>; Tue, 08 Oct 2024 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728422266; x=1729027066; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QSyBJfip4y3JIjpRHw7X9zlzecFh+sn9B85e80/T5s=;
        b=PNdw9pF2uLMPVMBC9qxqtXN0pPuXBADcC/xd/7cypuiYWlLxc6H/w9y9uPN0lanhv7
         k2cX61Ursn/78HMjwL3OrapCHd8cCsJ8t9uviFs0pQFVM6BzkwDNQmz8ggNUbYIqIxEQ
         UG9kAu0HNVLNFgIhBhB829n6yX7m0/KJEEHRWkn2PAOOwTMXdKnM43TsXwE1v6SYN2wE
         7vrwrMHSwK8mmPQZsw+x0d8WTSaQ2xSd4f4ZvUQQce1/DY1czP4hKi5RpyGHRoBW84QJ
         4K9osNiO9LkCtITureuCO45UQj87Au/JrMg4ZFM7KPU1RCRxgMobJY5ls/aNZAKEenu7
         x2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728422266; x=1729027066;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0QSyBJfip4y3JIjpRHw7X9zlzecFh+sn9B85e80/T5s=;
        b=LrgGDipMa0twfEpufGZBcyllGdkvhjfDidYQIVBstddnYDe7kVLaU3RydsdXYBleIb
         XgoZ01Dz+RfJ8rjYYnLPvgaA9pD5wFLQtsuiUyB6FTQ5zBrsW+FLpmpkn5Oz81U9zMa7
         5aiW8vs+b7FUfPRb/+fUd9hgJMqMZ9K/96JFTgnA0fANT7iaBQzJcQBSWDiEIv+gBHln
         ntKu+ZLc2/iOfiag8vlPdekgD1CWuPwb2mgX4jFYR2rxHw8qiruo3Yu5br5CdhAjviIm
         JQF6N8HC3PzfdHXNehpfQFbzcL83hlv8nhd5NPfxYNoqCJjsNE6AB3l+KSQ5egj6fY1e
         KzHQ==
X-Gm-Message-State: AOJu0YyELh3s7fyhPaCKA8pYF4Ex+WiHge5CiETxOWVYfibtVxR29mkn
	6Z7LhyOCB1ZGFYCniyvWn90CKYIrZ6oPic3+kqUpvG1xwM5hTfVmw97f
X-Google-Smtp-Source: AGHT+IG/FPNIqh7UPQ8r4ot8GPEVLb/xK+0fO+RbU46UZe1RiXYZB8GDipN2ZcXDp2kQ7CGuK+nAaQ==
X-Received: by 2002:a05:6214:4608:b0:6cb:c45a:7c9 with SMTP id 6a1803df08f44-6cbc932f819mr8561246d6.21.1728422266300;
        Tue, 08 Oct 2024 14:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.14.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc51afaf3sm6816796d6.9.2024.10.08.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 14:17:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4b2cee91613e597a172b46bb0d9d3143053c52da.1728408247.git.dcaratti@redhat.com>
References:
 <4b2cee91613e597a172b46bb0d9d3143053c52da.1728408247.git.dcaratti@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_mptcp=3A_us?=
 =?UTF-8?Q?e_=22middlebox_interference=22_for_MP=5F?=
 =?UTF-8?Q?TCPRST_in_case_map=5Fvalid_is_false?=
Message-ID: <5bc8f718-9949-8c86-de4c-f8f2d6ae1b6a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Oct 2024 21:17:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/11240855539

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/184902b101dc
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D896827


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
