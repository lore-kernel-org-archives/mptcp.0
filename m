Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54E4D8A7
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288578; cv=none; b=KOrAzoSSIhnSbDIv9sJFIxPzFGRjZI8eDC10IoHiGJrxnqZBqEyptr21SE/JuAxz+qLANsUjroc6pkkhj5fZzpibcK9354Jfncj8O8e2GhDTdV0JeUQREdFJLpjaXJXZtjdliMpdSchl7d2Em5zIJZEnlULJZTAoCRb4Fu7fVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288578; c=relaxed/simple;
	bh=FrL2MOKanZ+8pYlRXNQW3PMytt5eFF2PB89MpM2mAlo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Y9XWRBdnEMygnJRZMokIq2vYh3ceII5NvD64xcuqr07Hc9q0Iih1+q9bllgKRMlzxwaae7AD/a2jC9f2ru4Rj95jGiFUG4h5nwZWSIFaMAFiM62glq1YAGBdK2nM3FFX7x03ZIRiANp3juKyemMHTxWXrDuqm3sSZCc0o/4cZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GycUwJw0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GycUwJw0"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so5066692b3a.0
        for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730288576; x=1730893376; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZsCsaYStGB0GqJdJxxeVbXswSMMKgw0FAjH3fAYOag=;
        b=GycUwJw08uUqinJzyirV1gO3i0Jzkqpwt/o6100Ky4Uqey8ZzGc9PnSxEuhL/mcSQM
         SoTz4XKD53gF56k/tPt7RES7C7DWMkApiJjcjOFxGen/pTfC68SWvyZ33iSEENC8CBmq
         8pOgVpjOSYEGuLadZ/9mbkVrFTu4YSFUnnBwpWj+PLhtLJtuzVDh1isMnJOFEqAlgsgg
         BQm4b4XBWvL2sMQa1u3BJeBExr/4bJCf8EqAtQ8b3dHwgfxPEQz2JcqwKF4e4XijBzsF
         Tp2eq1QT8+0X7I1a0HF0t278aajqO6l/Gygkfi41HAfyy2kMpHWtRsC8rDOFoqyu1dc1
         OoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288576; x=1730893376;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZsCsaYStGB0GqJdJxxeVbXswSMMKgw0FAjH3fAYOag=;
        b=BrqGltvppRW/KJ8pRPU+NsMd8NpAJvUPkhpacGzbux+e4kk+h1MXEQ+9hWE1FreC8U
         GNMBumCB7QaqOa2YmSl9FPoT1wZh++d/2aYV9Af55tdv4DOK7FWP5cS1R+Ha+TIrhc7G
         Mad9eTiKDB17ZRwjRsHSRcKI4XEyatJNAceh8rOyi8SLw9VrDBizdZhsUqsyqpyF/ZLz
         B3vRmvN5TgqECy0JrvSM4o484PanZFLJqU2Ani2jMI6QiPsXjzKdVHZ41C1+zr7NF5eV
         lT1AHmMinMB7qLcV041aCPmmc68KmuY0sxPArFIARTkrIhpqmKF1z5+M5krn79VbYGBP
         S8tw==
X-Gm-Message-State: AOJu0YzcyHmql3V60sNV3iwxLsxK4DtJHTOVDrHOW2L/Kk6yOZilMJo3
	EF+TDSgXMCU5IVDxahKw2Bi9HWrt7ShSBSLxKzXuchasXFX5rjgKuAb3
X-Google-Smtp-Source: AGHT+IGQWfKvs15I4F5QsjVB42hCzxBKck6wc6/4+FtYnN1NanSj0ohNigBJ4mzonvtXtPxj4a1YdA==
X-Received: by 2002:a05:6a00:2195:b0:71e:75c0:2545 with SMTP id d2e1a72fcca58-720ab4c5fcfmr3283874b3a.25.1730288575864;
        Wed, 30 Oct 2024 04:42:55 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.27.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1eec0sm9357624b3a.143.2024.10.30.04.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:42:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241030100108.2443371-1-chen.dylane@gmail.com>
References: <20241030100108.2443371-1-chen.dylane@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compile error when MPTCP
 not support
Message-ID: <a11f7a08-b310-e77a-647b-a8636937b4ce@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Oct 2024 11:42:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Tao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Critical: 2 Call Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/115911=
71451

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3ec75e78edda
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D904592


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
