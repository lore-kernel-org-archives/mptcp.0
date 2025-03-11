Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198023718F
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688233; cv=none; b=ivn5KhpF3DSHCMDebYXYuQsfj6aUWBU1QX2Zspj4VAZh6uqZkPkAxlxaqDEKc/AjhbKca/1OO7S7z/Rv2nPuzQ5rM1SOyM/pBkkaFIZmMSOpMbdxcsnr3C1JiulKLN6DBig8Q+cYRrF6hs4f52uypAiQJSHrvfbuQ3gQdH43Ddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688233; c=relaxed/simple;
	bh=1ONI1PCD/QQd1+taG1R+cnmB09UJIXfTFALibkLIRHM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=V3JpEOETgqb5pj//kMESIxuHLbJEsqsjG4u4ZqtjuLJsii9Gn6We9PhAN099HIldW1l0mZmJBe2vX2Z7MU1hYybPWtNTM/qMqSz4jGouPzvfYdb/4igDNe9MdRRFuKdC/32iCYEajtpSOmhve/sSZkFwgg3/C9rwCyaIs/yRxgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJoU/Tf2; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJoU/Tf2"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-474faf23fbeso64399971cf.2
        for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741688231; x=1742293031; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CUXXOWFVQejJrjqZE/hpIi2yD3dwcJL4yfTJ826cns=;
        b=lJoU/Tf2SawsbixvV3CPZDC20KsnBuCQ/729Xg1pbAs6RxH8yic7MDuyWAqwj+1P4x
         1CWKFxNxJuKDi+p5fPsdT2fo+2PgfrvFDLL9TrUZx0ujTQISxrEhXsW94HXreS+MXcmT
         m4Oc0/iIZDrVElNt+NEMdUkTL6+LyuDMiZke85TLVByjyoU+veXMnPPcBIUQIkhCdNnD
         zJd5miMuXR93CtjiwIf8BmdnqZ5hy9I8xFt5rgkVmSPZb15y639aTWHI2x0dzuAdQg8l
         +W4qwEDSsRGND/3UZqFMPaS/7oiNIotyjYHZDpKWvhYEj+SevjCME+ONy+KwXfbi23ey
         a1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741688231; x=1742293031;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1CUXXOWFVQejJrjqZE/hpIi2yD3dwcJL4yfTJ826cns=;
        b=Xy5S9OSuZyIqrkAG21l0F9p3fmzZRcoMtpWycVTmToz5f9T9RzZ/2EKE0nUmrRCK2F
         bYppUhvs7aMsg61MdxvjIOJ17In5j/6U+zG9azZU+JwAokRjggkZsIhA7YnkZbjr8Ugm
         cJvTjYIz36AzaIpISx+6rUcKsxyT5jo8r0zdd2/rs9ySkB6Sz/s58jfNvg2BbU/Dxc/j
         ENhR1eKhcGOKfmC2JsSQ6ctoZV1yMQ49rTTsjpP1bZW0gDEZkW5E8qpDq3f7aQfLLoBt
         jfiPbOQuUBsc/rk6KMx1i1UpHRHLqyAUu69oMLxZ47iWXvRAU0rXu+7N7fSOL2GcG/h2
         8b8Q==
X-Gm-Message-State: AOJu0YyNr08R/wIy/YEsd0aA12n8NSiRyMNmkXCFMe44KI1YkJBkygbE
	75WMx61zgdTQ8yjVcco9Wbh+g6Diy1uPeIBIo4+Ncy6pE9c/Swe8eOub
X-Gm-Gg: ASbGncsGG2eGVtXV2Cm9P+yRF/ARVq3I84lu6EBS3V/kuDCcn69FW5xakCs3dTy7jrd
	V+kMcb+xpQ1cKBwlcqjHOmQUpyF2r5nw9gPG2wIODj4rQCo6883FQXchTW1e4/BdqoSlx6DVIv8
	oF54tkPRVgwIu1oQuTfpxT6CtdHWTOzYpFrQpot/eWUawfku5Set3l1lQO493B+2UpIrwYAUUJs
	ivRJP7hm1aa3cs+aCBd24/kA8zsincwl7CGRxtO4JRSKnKOwbrq8UX93tPgjRcj7BwTcaMF/sKV
	zjxuKi8ivjsKxrorOWJMjW5Vd+vMQ3CGeENqvw6TnY5Uzf9lkJA8obpuCBU=
X-Google-Smtp-Source: AGHT+IHCxrqLJzqa1MZe/ApDZZC4tacVzYEub1TGqW9Ij+t8adu4M3M1KHYINoGN8wslZJCOcXZp0A==
X-Received: by 2002:ac8:7e87:0:b0:476:8028:71d3 with SMTP id d75a77b69052e-4768037e4d8mr141096031cf.3.1741688230830;
        Tue, 11 Mar 2025 03:17:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.212.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4767a003c0bsm36848521cf.21.2025.03.11.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:17:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741674285.git.tanggeliang@kylinos.cn>
References: <cover.1741674285.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v11 00/10] BPF path manager, part 5
Message-ID: <a9275814-31b5-85df-b106-c3e6876c5fc7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Mar 2025 10:17:08 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/137843=
37084

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cf4f2ea21e3e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D942579


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
