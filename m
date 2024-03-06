Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EBD52E
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693366; cv=none; b=etJDI4C823GNAf22CI6KUffUbnMNsFci7IfwDZOo2eS5Xr+UlaLCOwFqQoQjDSmFHtEhgTyXCXrrbrshTfoD6K4y5sK/1bgkf6irmXi6xZqWZZHGx/Y6gwMJ7veHGBwUxOzHng8yjcj5KJ90NhVAd3cseUN0ETvtB3LrObd1jfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693366; c=relaxed/simple;
	bh=+Y2UQ/nm6vLDhEoTLCRabwuSGyeBzOMtUPUDk+kh4eE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=clp+a878L+WhmJXMrfc5M9QRY8vwoZp3gL2056KJ0MpDncO8ERxpqOTe+aRxDgSzbTiB4viVWVILv2Cr6UxVoepatwiXTwQQjMFadcCvxcP5OtH5CXSdQJgPyTFSBMTI3S1569jGJPGgUMPLY18PKByIB8yLkGuWUAvZr9Wuuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZnQOZQi; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZnQOZQi"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e4a0e80d14so396038a34.1
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 18:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709693364; x=1710298164; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5k68431poFM7rB0tvCQbx6BjCssv3Xf248viJzq0A8=;
        b=RZnQOZQiXkF2bLrakaCxAAS60xoVQkWtdD53QK0UxkX5gAndn+XZ9XwZ0j7+0VRu0n
         t/Rh7pPVcgy/UlDMfS/W4NM39avTloNku92nros31xYyXJxEv/TVX8gFnVVmpPWlFP6K
         RRfQ6hOkHwprAiiGXS2FD1HrwKjFHvQ2mgngcfTq3121Kic2+pHqEEM1vD5wwokqPLph
         VE6law4ZvP5gVKnsJzzJiBonlVqC8aLOqqw/jhIAmg5YyA4azkAIP4cbJhPjthiSFSfp
         lk3eWfKKr1OZ+9XjgJCXdGIgfI+lI7kW3oKgPEMe46+4utx4aosZFe7sLRSuepvJp8A8
         U1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709693364; x=1710298164;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5k68431poFM7rB0tvCQbx6BjCssv3Xf248viJzq0A8=;
        b=CpAsFGJoCnk3UeO/zdOwnjejjy9cf/u5n9d3kzQh66+dpE/3Rm0tcbSy2nvQ0V2Vgh
         E4l6sqoowu6vj6eM0Mp2n7JiF07EQohrNRdXyXyZT7/TwgU6M5oj1r4ofUsvmOshPiS/
         g7UiD3RNhKn6qpUMWcFsRsjlBNBvQNbw3audYnadrE1nqsq/15iFnpJ4suw9TJdRg27R
         7I/22hqIYt/NSIIFclsW0OMnBj0+rN1YGI2ydvh08QRFAJ+jxW2e7qoEF5Jyg/qSX4yK
         Anwcuq2mvCtjTVPmWoPV0d+S7sDOfTL+LdlKLt+eUcqaD6EpPmMsi8ypOqy/lLq/BRGe
         yW8Q==
X-Gm-Message-State: AOJu0Yw/Fxwy/fyav3sFoUwp7gLtpjAysOPu6ggcdX0bkycOZcya1MzN
	IU+qpDothP3lkL3fBH9eImJNN46XRt1rAaRrTqndJBlKnMmry92UdMzvUH0OGQ==
X-Google-Smtp-Source: AGHT+IHCsSfeaxUIB/CLl4PQBwJS38dl+dP0OzDrGUg3qteSlUkn9yGCHHLpFUjB7RwebyV3cqyhWA==
X-Received: by 2002:a9d:7590:0:b0:6e4:ed03:55d6 with SMTP id s16-20020a9d7590000000b006e4ed0355d6mr3932485otk.16.1709693364121;
        Tue, 05 Mar 2024 18:49:24 -0800 (PST)
Received: from [127.0.0.1] ([4.242.233.189])
        by smtp.gmail.com with ESMTPSA id q12-20020a63504c000000b005df58c83e89sm9919938pgl.84.2024.03.05.18.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 18:49:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3903335eb71697af9348119b569e29c50c9e741d.1709688778.git.tanggeliang@kylinos.cn>
References:
 <3903335eb71697af9348119b569e29c50c9e741d.1709688778.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <808a6ed9-e15f-8c8e-40f3-5c276a89d381@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Mar 2024 02:49:22 +0000
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
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5965573272633344
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5965573272633344/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5402623319212032
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5402623319212032/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d2baff8ed2b4


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
