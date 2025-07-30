Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CBD26FDB6
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867320; cv=none; b=RV6K0MH1NomVb6kOXU1IXahcYERhMxUeRMp8zoURbJR2I9EpqI1jHNx0XEuWId8fJqc67usIeNaJO3GsvhhXVvgrpdsYPeEvqXezp+tGiZbEFpY4jKYVd3qKLcHAfJa5iaKFEl7hAEroa2rHjrN87poge+v6NopkXmZr+2KyFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867320; c=relaxed/simple;
	bh=N1Mhqe411E/MB4JkzRLMM6mVmfydViKXUwEH73tPrPM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OT2mlMsoDauq/wamKdIwpil7arKnEFS9yXBUX6BdA4WNqxmW/4lVdu8OmcGipzGafTtUXIaPCZ9NbzWx48gfqBCrdHitfUXpHQkQ0BJ5m8olelvKLyMQNW083nSnW+djSgCFel1CdHLOJyrDVE3QO06c9GzyJ2LBgdacdAkFBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6bZ1K4F; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6bZ1K4F"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-879c737bc03so209273939f.0
        for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753867318; x=1754472118; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfTu1Hh8/fNbAXjMLd68rcQI6rjRZ/bY+3eKgUZ/XP4=;
        b=i6bZ1K4FuJ5v4e0qO2Ns+deCJ57mUVl/RIuDYflRon4/8vTxn1Kw4Zr/EDOHoKwSEC
         tzqe2D39+Wf1UzxbmgdfHEyJCPpVyBHAonoNC/R5ChIHTqcbPv2waaX4edaFcV6UJFzd
         Lu8mp9P5gIIhh0VnH51V6KpqQG2THAX2ZchSCz46e1ISzjjM/TUi8p8BFaxeBaQm0vZf
         tn4pVUCKi7j9GjFf58foaNDNpI41SiGwCW1pQbKMLsrQhlRhMZi9LfpnkvU+rOOVH5GP
         9m2lSXhhQjRPzeJ9zZL0D4lbLsw1HFhVC/CY2wcX6jxtzOznl67kCJtAAufKpRbVQrT9
         hnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867318; x=1754472118;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kfTu1Hh8/fNbAXjMLd68rcQI6rjRZ/bY+3eKgUZ/XP4=;
        b=ocW6AsJa10RvBPiRWZ+FK26a/LLRjL3+UBpdicnu+kJupXJGJCG5yLQYZ4CWioYXzg
         3+2UG63g0foeZpIdQdhSnSQt4xQk0BEjTSzHFm1L13uKIpfupkgARkpDE9PnJrYxCfAP
         KQne4bypatSPe9EKt6aqPzJnE1Zq2hPun4zHM+U+OK2BIPxY911wLoMQ1igXOcSP7ulA
         654UH5mxTF4zgJy0lHmLsGiO8qB8zLafP8cqtvR+pEP1p1j5M8vxchjmfNSq+LeCKOoz
         Oe7S3DbyrRRUADUp9aDIwZXw/FMMau6DjWx81YW6WeTfGEVD2uQ35EwIu2JmwXQkayg9
         aRiQ==
X-Gm-Message-State: AOJu0Yz31uy2paPhOGZcWgQJejKm3HoJw1mH9bgm8GLF7Js1H6gifBb8
	hyRtv9Tgj9C2kiYIQEy1bYKijiFLnwbByBYZybtE0HKkIxCeWgPtKXBGU/wz
X-Gm-Gg: ASbGncsKahnJMBTpG5t3hNKRIWfK3Mb24fyGdGmnq6nXYI5VnouG3zNpYNH0i7HmeQ2
	UmNFd/gDGEAPimSwCg04YvK1fse14IbHtsnZI3ydkPGZDUYgQWcgM42eze/utPWyI5ut23re6u4
	a00CtMv2Sq7tsiis8GQoEpdfymxregWZhYm6s7Vs1idxlZqlEno/Cd+mC5lss7M2+xRuDbDO7Yx
	Iz0iYRwRCnjo/4kkUzwoZ3QZ9K2S2oWu6eeBc/ud84hYaU8kGrnU+UqWWi/VScAnaZuuBk+HqJn
	2BpnD1zhcrrVhhJMA0CL/AccmjzBF/sbAqypXwcyNnulb9c0eRZl9pZ3mZinP3JiveMZvV9VzKf
	npib2Uuixc3j/WsBoDIfeMTzbeef10KQnQNKhRrvoDXeV3UE=
X-Google-Smtp-Source: AGHT+IE0jI/rreQWncM3bnnpqXLcU30bucsxzMVLGBDrOwKqOoSPCmGoRmbZ8mnYosK6+MCM4gTfHA==
X-Received: by 2002:a05:6602:2d84:b0:875:ba1e:4d7e with SMTP id ca18e2360f4ac-88137817f76mr532844939f.6.1753867318490;
        Wed, 30 Jul 2025 02:21:58 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.66])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c91ec0e7sm3231619173.32.2025.07.30.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:21:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1753859907.git.tanggeliang@kylinos.cn>
References: <cover.1753859907.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: TCP_MD5SIG support
Message-ID: <0db1eb0c-e6bd-f34e-0378-d79ddca18e7a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Jul 2025 09:21:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 2 failed test(s): packetdrill_sockopts =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 2 =
failed test(s): packetdrill_sockopts selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/166163=
93711

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5bf25749282c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D986936


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
