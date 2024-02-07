Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC6F9C3
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275493; cv=none; b=HsHrfwlQDL+kqmeThbRgoBi8Ho1argMBDWWpK6oSkMRpr7CM4hcsPpEVrS5UHv8bV/YWwek7LGb+S4/RKX62LzJcIgak39PzHZPj2SUEpsNJ6gRewLAd2kn1496Nl91wdTV327VGEIw/MSLmqRGBPQMN1pBey8k3Jt4zylvbi04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275493; c=relaxed/simple;
	bh=fgRiGX1z+XQbnx5CeZGZ27pgZCRWKRhFmjxELpwcjMQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FmnH2ISnW0BbTh+Ow4+bleiRwpnzxdQ5R9eMJMOsMrxThhmjLguzUJLESlF0mVqvopm1QQPlRJThVUztQapm3GXXlUwI/l3h/76gCvsc2OidhcRazT/JwN3EUSutORIM3tZ8Y8WTOtdR5I6x/cZr0/cRRhJmPtQcnfUJiFBGxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjiDTJTD; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjiDTJTD"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68c2f4c3282so1009296d6.3
        for <mptcp@lists.linux.dev>; Tue, 06 Feb 2024 19:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707275490; x=1707880290; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EoufIMmC9AczwjtXUCNsfqJU15g8QXxZod3AHbPvlE=;
        b=hjiDTJTDdsZhS4yXDWm6BTQy6itxgGHJZ3C8CECYsrt9Lt9FPMc7dhCmbpg4OiSgzL
         tAZbi+Sy9hm+f5WHo/5Yr+mAMfnUeOFETEm+TiJfFpvf7BtyGNJzFQcwsSSAKPZkUpFA
         W2g+qjcGX/l/TnHLZqITw+3qW5EjcGAoZmPMYrSUoZYD89hSpoS0CS+dfB0ktavy9L14
         meyH/Hd3F1X/tCgKMVhK/5wyLCWgc3j3qu7mdTjBLn0Fm5lCs9Ls1k0vXifCuS8X/ijJ
         W0smRqVhB4sLzDYUw9GwdSTEX8x++jjxEzYaovQjJ+j6TNUmrY6w7zMC1lqIbx+QE7zv
         gkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707275490; x=1707880290;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EoufIMmC9AczwjtXUCNsfqJU15g8QXxZod3AHbPvlE=;
        b=Iq1Qf+JuJqnmfBYb5Eqz3W8/sABmT2pd4pDgEKQORpRSnL+fQ1uqly1E0gPXsYNgrF
         CugkxWZpLq7Z2MgpJpaeMcpVVr1gZEHRFiTtc/9A1G7zOJrrhbR4/CjPUx0ILMfZLjKK
         R3YlJdgABvJS1zED+V91J0WVdLD83LEDLDG9TsgPlW8/OEozvMaT79MS8U5x4x+KvYux
         WrNijQ6H0guTMRUBVSxrrqOs941GFcPSksVtCYw8gWwjHwrnMK0XKav1akACY+mfxFlQ
         /Su57HU6NtfVFFj57pVBVFhx2gYP4dQpkY6VnMYub60tyazlC16wfP21BTUiWd+SHb+8
         KFrw==
X-Gm-Message-State: AOJu0YxhvQBKI5mlqf+IBFfq9/Mb16fAi7gRJXeCgBLhMO6S3erRMFFg
	I+mMNbuHiwxl1lQS3VL9ke6Kz6lXTFONfeXkaJgqXyr3NWsA4Usa/L65W/o=
X-Google-Smtp-Source: AGHT+IHMmsdY8a7uqREX4wqJHPxfkDVzleg8co4UnG6ERkgK78JlvqcA3OnVkbC29Zzm09XfmkTiew==
X-Received: by 2002:a0c:9e89:0:b0:685:c584:6e8b with SMTP id r9-20020a0c9e89000000b00685c5846e8bmr2992361qvd.0.1707275490617;
        Tue, 06 Feb 2024 19:11:30 -0800 (PST)
Received: from [127.0.0.1] ([172.183.122.157])
        by smtp.gmail.com with ESMTPSA id od18-20020a0562142f1200b0068cb9a819a2sm156146qvb.28.2024.02.06.19.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:11:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
References:
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <6ac28bff-e364-49bc-12b6-34756a769820@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 03:11:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5682143834144768
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5682143834144768/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5119193880723456
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5119193880723456/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d954c612ab76


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
