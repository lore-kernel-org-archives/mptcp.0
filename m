Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50947155330
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760978; cv=none; b=lYMoKudNeCiIv2s9uYjY5AuIlvNBzBwW16PFzmQdKOw2E5uIejq882Nebbpgnu6cz0eVS4zbly92QMZF1RL41sZ1BySS+Hm0dVQV4+FWHDhmMZAOGMvJXEJ3vNSEv6GmS92uXJRGGCc/kX57TnTLjx0VKnmMhCVSwNMxQZ+0/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760978; c=relaxed/simple;
	bh=ApkRviq9+CDOqkS3C6WC/48WzlQK4UQErypVnO2/ksc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GINFZ9Pddp331TR1oeewAEVKN/ZU05pDtLr6XFQL1mcE6epA7/uY8kOCz3/LT/zu/74ybqcdbefCPTyErOhVYOR4pztbVHRQ4fpKZuDiizzsEOtpBRg1oc/1S7ajWaEc3h5b5EJGYUQnOF8DtGpEkwqBXgdCYE4mFh3CoJX9fQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOYrQK57; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOYrQK57"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fe6672297so8384721cf.1
        for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760976; x=1724365776; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehlscsZqCRp/Y9R9B6O8rOorUGAMJ+jGcImAU0iopAA=;
        b=ZOYrQK57SqZUa8ivg67Zf4VqlWlok7ditnDKresKKgmyQCo/XaAC/jAxT1U0EbHCzh
         EYsUXcbebJF9cj/rIOc92pTmdtybA17kfNfFUTCPwbm9P1LY4J8dexidT+9AlPz1jMsx
         C1XWzM3VH5tXIKu7+qho91i+0Ey2VL++i+0o3iHM6QeoWhLVkQxBS++yBs3ayvqJ1470
         sT9YhVLRc/kmmRFYO9UuX1LzG9QKG8wZGYTFYPwBZaVLq3hXZ8kdYFlXVDOro6EKOdVR
         3VCDuvSdGkrooOtHw6ChFs/OTsvPpm/a47EhS4+1bgYX9XDS9VKl7itWju/f1sdrC4SX
         ffeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760976; x=1724365776;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ehlscsZqCRp/Y9R9B6O8rOorUGAMJ+jGcImAU0iopAA=;
        b=cDUvFbsOTgNkCZah4nnpd7l4mm5jntmaBryXBY4ck7EXDr/IkkVhCtfkKVqOHw+wSG
         CACTRCn5q1qE2daWbq4iZtaciqR5ysYfDH0Ca5V6q2DGfXMgICQpofpBtqGoxel4v8+Z
         EY21N0DPy79TG9Mnl3v3NHXj3aC/LEQPOLibO7Pws4fqZJjHCDeGziYyssUqsBY+qu2f
         /yvILTWravfhOREnnhMtDltaMnyMYZXqaroq9NA5lvotZoz20HemsPCctHEREYEVQkII
         SeMFpBMBFA5EA/B9pLQdcXr78WOD8RIiu3tN4BPUwYWsl9bHELBBS1lpnaCSL0iuYgSb
         U3QQ==
X-Gm-Message-State: AOJu0YzeXlN0/xRgv7r9oJUEWa4se9CObwrHfR942zLH1WNPEBp0H//j
	bZYFe/zphzdxOWrKeG7ilOP71HlKxLdz+8fTSy0AE967U0wxeEk=
X-Google-Smtp-Source: AGHT+IERtW9D1kc0ZoQ+7et7mrWtaQLfHuM0boSW20jMV9cZLyhUDpUuzyeM7Qw0BpeZnv6vP2nSZw==
X-Received: by 2002:a05:622a:2510:b0:451:a0f4:c037 with SMTP id d75a77b69052e-453742586ebmr10298911cf.31.1723760975907;
        Thu, 15 Aug 2024 15:29:35 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.6.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd8fcasm10170181cf.1.2024.08.15.15.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
Subject: Re: [PATCH mptcp-net 00/10] mptcp: pm: fix re-re-create the ID 0
 endpoint
Message-ID: <9b1b8253-4979-27ed-9143-7def92d0fce4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Aug 2024 22:29:34 +0000
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
uns/10410532494

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6a0e89f29675
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D880118


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
