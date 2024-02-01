Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EF161B74
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808471; cv=none; b=Is+KX753XlSfuGXxaqKH13XzhPKRbpqIl4sfNJe18ZWzkWvJ/ELYWvUZmVxI8VkgpHsqUu55eFC6EH6aHEVPMv6nTkJfc/nXwMmnsZlJ8S/MpwqnYHVpomv1N7PmVkJ1kJzT5Uic/VAlOm9qhW78x0ni+XfSMekmbglLrHmvBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808471; c=relaxed/simple;
	bh=SzkWfwiYn8kFIpyYEm1Eq99n4dAlyvJyhWPJJaM6mts=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=rQg4Rzzr4NR4H1gz/wgKk7zOfCGLrWw1k4tDlbYj0OXgkBhXJxAOtlfBERKsuRRqXG0d0fFn6R1UTVJ7AupBXwgRyl2VZXK8U0Td+X46NQi7cnvGXKVSMPqU1cUOBLs1Mov/MB+2QALXjSpwhzJlwvfLeNEIElz9h4h12jvUzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcW9hT7H; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcW9hT7H"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783d4b3ad96so76087385a.3
        for <mptcp@lists.linux.dev>; Thu, 01 Feb 2024 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706808468; x=1707413268; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATYPKMuY2y+LklZ4jMUmKnmMT7u5yoMCgjxAi4eh6Y0=;
        b=NcW9hT7HuCl70kMZKmruFBzRgFyIbggN2VJlBI3N9hO1KHGSu9DI+lNG4/TKP6vOwX
         qtOrfuOWyOTPquhSqTssJ3zXWzaJ/C2PjG8V/Cte59qeLT1kcWDsUb42ISi3bW2vgEDp
         XpKD7Mr8BSOlUD6EadPpHNxiv41s+XYO2AxdZ0tfnjc6pPWg+LjskhSWF78HmOpzdXCW
         QsM5VuA1n7uZGsnSl61bjbPzJ08OblKSLh0kP6mIZMxxSChfj6ytJCMbzVj0Dl0u7pHF
         P83Xm5Bp0BXIB1/Nb1zHyF7ABPmYEcvL70IaCwXOpJ1H6AiNVa6UeEnuYwMpBPoENdcG
         Pulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808468; x=1707413268;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ATYPKMuY2y+LklZ4jMUmKnmMT7u5yoMCgjxAi4eh6Y0=;
        b=LoMg1Seb0hNF3TjPxPGS6+zH2E5VDATWsXIJxWKmORZdlO6fa2hpQd0LbfwqxvxIjo
         RPupzd1nLLZVOCnWTxmtVmj2xKNqcECORZqCL0Y8Utqd4QTez1b+drtHul876R6Lu4o7
         NYGjHLSCk+pBXfYHUdB2rx0RENebarw3KUVnOpsHvgLJr76eTWCWTSHvvGv03tBKmtwv
         WcrtGU1l7Ak81Wdlw+qmay5NPptk4lYcLzSanJmWA6QZAL1jfa/dZQGXyo+jQshMGu+V
         txRUCElq8Mok31t1ANYtYuao+jHFXk4s6xSNpvhnOHVkuDv2Hhslx7FmB7NP2/RyhqCH
         MaXw==
X-Gm-Message-State: AOJu0YxInFfxYjpA4t+CWSOr9GXWNzh4Cs/ZvSrOhTr1ECF6IPQQmOI+
	1CXzFRPaCbM65ld6bNxa9SH1X+pUOTRNuxqDu4LC2UM8bgWZj1NuFl5cfH5shA==
X-Google-Smtp-Source: AGHT+IG/lPSiwvVe9fzVc6hywcHXhPE/giuomQ3upmwDocuL7WW3JFnPDqVbYqIguznuGWT0zT0dKQ==
X-Received: by 2002:a05:620a:4011:b0:784:934:fc32 with SMTP id h17-20020a05620a401100b007840934fc32mr4261902qko.0.1706808468708;
        Thu, 01 Feb 2024 09:27:48 -0800 (PST)
Received: from [127.0.0.1] ([172.183.162.43])
        by smtp.gmail.com with ESMTPSA id p4-20020a05620a112400b00783f9f6d5b7sm3866102qkk.10.2024.02.01.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:27:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240201-mptcp-check-protocol-v2-3-1e253ef51990@kernel.org>
References: <20240201-mptcp-check-protocol-v2-3-1e253ef51990@kernel.org>
Subject: Re: mptcp: check the protocol in mptcp_sk() with DEBUG_NET: Tests
 Results
Message-ID: <bc693a8d-910f-015a-ce5c-5cdb28c3f02b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2024 17:27:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5743237663555584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5743237663555584/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5180287710134272
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5180287710134272/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/05d35e87fc2b


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
