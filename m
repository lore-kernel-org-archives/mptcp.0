Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08F19F102
	for <mptcp@lists.linux.dev>; Mon,  2 Sep 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299741; cv=none; b=ObRQYcnJLLa49JvsQKJGeXzLp2nswkHSMR5PE4nfcDEnUe60Jdk4I9kJCMiIILHcmMTI5ZIbfoEcAmqzgb+7e8aKuybCcLEuD70gIBBI2Ir70NOkmczh14KYn6ufFy5VR9tIZ1dbEQZn5ozNJ6nCCbogUAtg3XEjMsJ5U3eVZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299741; c=relaxed/simple;
	bh=wG48XpX3FzQqWgjI4eVZzzsMdKaDxt1Pf1a5vmZ5IQw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RkStBh3Tq6ngzxNFgnfdowIDcKg9KaZ8KlmW5JIv5Jy8HyFCgCtxpxtaxbr49fnew6vsDlM6bnrDaPZseiuigyht/WzWtq3Yo23YK9WdojgGegOo5K6+VBn7GyuOLx9jNhZXkfKZLoHEBgc9f0GYV/LqYb8YAtZ4K13yaDVC64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF7BU1Nc; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF7BU1Nc"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c3552ce7faso20699216d6.1
        for <mptcp@lists.linux.dev>; Mon, 02 Sep 2024 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725299738; x=1725904538; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLNORC7mJngsQ97reSu5FimFu2Bp8LqwR0iCQ8mWxps=;
        b=EF7BU1Ncbrm6GngbDupH4CrwzsD+LDH/1vwzpL1dxPHNzBuwkTR+B+PX2CYKmeR6JQ
         lTia0dfLG2CNcRl70ggZEsSrXTo/TlFYeg3nnLVjvQK1CV+I+ETR/3IBgJs+XHWZPs21
         j9KcN08qX02WYpuWqOj1WBtzBWkhFQksvkxukxvKhBziDe47eWH8W4DByteZ8aWIrTfp
         ZRubbIWMAPsEFz0D4Qm2UgO+sY4phS604ZEdGH4vcTLjk84WwPXxqW2F3wOznESI1Had
         1B94arLLD4PL2rSR3R1EFK01CgLJNyX6osw35hrYKfwVt7txFmAkFJXeBMST6sSz936Y
         GBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299738; x=1725904538;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLNORC7mJngsQ97reSu5FimFu2Bp8LqwR0iCQ8mWxps=;
        b=C54VWDaZnXDjXEHnb6WjAinLSZ0xB6X3+S5BkY5wtQ2qygY7DJ+6OF5WsncyP20+2Q
         VwdEQh3hXfVLqCnv7kfr8fU6/ateHJJRNY1zHvinCiFnr8PsQa0sGwsSiQ0fqBO8D+ql
         IKbAVFRteJz+b1RN/V4DVsLOR7UA3QG8msuDNbhPW8kNIG5xfu5HY9vGmfzJ7DfkJugS
         3l0gOogFEg1Rqx2RfFno0XiaKI0ToqZhmiarp0xYFIui+7VC2W5WDRUtjgJBKP2i8jlw
         mCaZP3N8DIqV0ObtJH9g45tR8Jd7Ow7ivRsGOmUMSSQSJX7+VVjUhOQszj3MCbfs+Cxd
         UY2A==
X-Gm-Message-State: AOJu0YzZZUzi4Vq3Br27wNsaE54XgCfmfJxr8MAuIr53wT0pu7vsF0Xf
	9cLC+evPDBlRd10n0cswLzDf9BREwFWfKiy0C34nckHdd3KjBH75F/oe
X-Google-Smtp-Source: AGHT+IG+jcINP0DeEuEiGrLqjYWTz+lnu7vP8aB2F3EXY1NqwMK4sTRzOnJCA23U6y7WxRqUqCZLzg==
X-Received: by 2002:a05:6214:4498:b0:6c3:5db2:d98c with SMTP id 6a1803df08f44-6c35db2dc44mr130887956d6.1.1725299738373;
        Mon, 02 Sep 2024 10:55:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.222.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c36eed68d3sm5200666d6.48.2024.09.02.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:55:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725000687.git.tanggeliang@kylinos.cn>
References: <cover.1725000687.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v6_0/4=5D_fixe?=
 =?UTF-8?Q?s_for_=22new_MPTCP_subflow_subtest_v4=22?=
Message-ID: <65b74737-39d7-23a5-d8a5-80332ad8a018@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Sep 2024 17:55:37 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10670890802

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2a3f3a1b8296
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D885041


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
