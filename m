Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785361C292
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078446; cv=none; b=pdvU9l2Ntk++ovOYXN8D4Ga7RNiwcDF7JC+S9Kct8mXodyaQHMj1INtPSNTH4TdIMDI7vAUkaASYYQFIxrru1+I/mKfVQ4B95VW9HRLVoEnCPVxEhAtqqqyl8eSZVjmQoys9eIAZtCzeZ+VtH/vgIoVT2GJiGqMrolKGge7gkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078446; c=relaxed/simple;
	bh=eCM0PneWTqoBGhtlXYz7X8vVtuNIjra+m2YGk9n5bZk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dRyr+qdHAp8yv5wjs1ikq9Demw5s3zFsTcfjzs8Us0MMVcFH5HwWxUkWBK+7rhnywOmBrp9c/GQdO4HCOCsVPW327cfRZeuGPnf4OowfKCAC1lHsJD5ARVjcbijAv3LqgM4APq6LL72SnndKmy2yXXn6x0VGtyz4yaaIKmWqVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDWSJ0ie; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDWSJ0ie"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-783f3d27bfbso25728985a.2
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 02:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708078444; x=1708683244; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBZtOXgJO7VhXxFF0sgA0tVibjN7ppXxDPMDgqcgxmU=;
        b=TDWSJ0ieQO4n9AYZpLKcN6ks7BQiRSejwo1BrC3QLyKFvtngv8AFKFRlZRP2JvX8Nj
         1Gr6WiY5MGfh4J3Sm+koSTnorepAQtocMHgQy+lWE8mj19VCkhI+buhQ3H8okYsCpWbn
         bSawTRHYxrLG/IEpuBKNpped2pwejYxedGZoNQUK7RHj9UH0q4wwUInEIAZC4qISbnTh
         KERSN9SNTYhZxbLWCUh1SH97YGNFt6BhYJLrLqteTLOgM1yn/14JlFvGYZHCiwqTBdDC
         G2hdob113tCdkoMgiPOTLmS8rBdA4NJr5JZJ1/BUv4F/nEEwXLypsntWesyXGxzmMBfC
         d2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078444; x=1708683244;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBZtOXgJO7VhXxFF0sgA0tVibjN7ppXxDPMDgqcgxmU=;
        b=Z7O5egeM8S8OMNWiBbdmQGxGcJYn0XQSgikVx2szkDAstn+CSBI5tdKKeH3+7woZbM
         eOSAs+Xs8KZDD/d6SMvl5jn9hWRPLkHwWHeKUqgWBeumyLiaHpMZOXp0vLZbfcbLvSc0
         DuX8L1uoCSgYAvilYhZl2EnwFWDLBfIx/JdN5KNVCv0IblAngrjLPcV2D4JE+wVwJMzG
         vkwZK46XaXh7+dJ+IOlsiMtY+hhiXq2D6BXoxAykZEjb/HrHtW6FERqEZfSPOGY/GR9n
         VFdqpBfKQ7VdG2J87RnrXdumrK3C1eX3nuAF1o20utwEkIBXcI6DPdhrTBOIa9Aao3yZ
         y98A==
X-Gm-Message-State: AOJu0YxvowDXelITDFN66JlFlb2zJ1A1m04oXy0IXfAnYf7BdXXk/Np3
	fxMOR+1C2HdSsIWZRhw2kfB6Y7mIZLB3pcHrqHP7JEjbO7G/aerCX/AsCeE=
X-Google-Smtp-Source: AGHT+IEnriKzML2rVtT6GaAIzfOG+BsSOsZVvMtGxDCy4jwc0abTeqN5tKa6gI5OkdQlALS072mOfA==
X-Received: by 2002:a05:620a:e10:b0:785:bdfe:6430 with SMTP id y16-20020a05620a0e1000b00785bdfe6430mr4307155qkm.19.1708078444095;
        Fri, 16 Feb 2024 02:14:04 -0800 (PST)
Received: from [127.0.0.1] ([172.183.77.192])
        by smtp.gmail.com with ESMTPSA id wa24-20020a05620a4d1800b00787177a1a15sm1385727qkn.69.2024.02.16.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:14:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f7ca03a3e2d9b8c8a49e9226d88b40c935875e14.1708076886.git.tanggeliang@kylinos.cn>
References:
 <f7ca03a3e2d9b8c8a49e9226d88b40c935875e14.1708076886.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_check_tools helper: Tests
 Results
Message-ID: <8824f78d-0071-0ae0-6dcb-69006e6cbf34@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 10:14:03 +0000
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

- {"code":404,"message":
  - "Can't find artifacts containing file=
 conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5854280519778304
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5854280519778304/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5291330566356992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5291330566356992/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e6d1487a62d3


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
