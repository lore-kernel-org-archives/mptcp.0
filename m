Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399D15AF6
	for <mptcp@lists.linux.dev>; Sat,  3 Feb 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706951314; cv=none; b=K1SiqsAzgHsKZ8EKGPBRwC4wUwRtEprkj74653VJZ+Rqd5OEVOb1LR2vd212XvwOQUy0AwSNDWm+faK9S0uXY/sKNaPgGM67rCl3t2P9CSW35RqDDMAiyBlq6i51eXX/dflttwH6muv0wMfFrP3WZA+vqbUPKTOWqIctPbnj5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706951314; c=relaxed/simple;
	bh=JrsIOMSIrm/emnDlGRcT5Q3WBF4WmYct/Nxvv2rDv0c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ucx8P7BpPoXaN9TBZULmkq8kM8U38ymBC6O+2vuRZhjYey+vV3DsovntCVJjF9Eq2lS00FcMh5fyflQvvDUnt3vk0O0d5yIO/goZ7exTtla5lWJkExgfYHvWXmFbtDWTdKDxK9BLfFW/z9kZiqnCdBnvm/BpRUqSYcOe2XXT8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFjv/Y8j; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFjv/Y8j"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d934c8f8f7so26257445ad.2
        for <mptcp@lists.linux.dev>; Sat, 03 Feb 2024 01:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706951312; x=1707556112; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9yO/DbMBoWDD+H3Etmku/7aXoSAbMQfgpH+t6Bix1c=;
        b=iFjv/Y8jTiFiKNrwgGlgub2qJZ/yZ+FWlJ5BZb9g2waprZZL+/w8yM7iBA8CO1U71c
         SWmebPFRTWwJbqEXtMO0cx0tV+W+fOGf5iiTfNv579S4SQJPE+JCdnLPSYmED1q512gJ
         SG+CYz33ZB1fsOBa/hG5Oo65Ps7g62CtxytSmKTFcS9FnOBdKtE0J5chIrp/QfI5sVT+
         zGho1Y9Y9zPq7gtXstz2IL2QUYxswheDdn4KrGdZDOyAsIO/fTXQCGjaRhyywN7tBNQ5
         tLTLNOb1O+YakRz4uHQ8hYoCFYPFzc8zZrtl5k9eKDrfduDJaMa0Le4Wjbb3Bg+4meqq
         l0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706951312; x=1707556112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O9yO/DbMBoWDD+H3Etmku/7aXoSAbMQfgpH+t6Bix1c=;
        b=KIYDpp4DZDFP7UzoW/SfzuAnBu+rE/WWSPos5Lailb13H0naL+BmokESBjdskdC/l6
         ygntQhMv0vvc5UDePAC58us0inu2+7uMn9IJxwWePs0vss4GNnXl80CYwRN945eMZLYh
         FIL7ho9LTg6lvuzGCc3aYM6H/pC/qLDzihUU8nbrF3hWPJZ8Olk6hIsM423QQh28y7hX
         ZjmpFmyPYJEF8QiVfKJVkuGOK4CIkUFLVBDfcyn/rhj+p0ySsuv1bx2iRrTe/PEd53Qo
         eCt66c5Y8dube2xdbQVSnTJn94Ku4G9FD4pImZz8Mg8s/0o6JE7rJIR171e3As0CNiHe
         wyiA==
X-Gm-Message-State: AOJu0YwL/4R+JweVEhZz0en8jgQIKiZNtX1TFNhXuf8NE5PbjFeiCJLj
	n9LAoBLNapqlckZnqsUbds7DEDHwY+89zbJT3p5DxWD8PMwtmBIo2vQrhfE=
X-Google-Smtp-Source: AGHT+IGX14RGM76K/uXL2qoTn3zXJWk6Y4icBZBYM59x02WxTVwLeNnSjDqJUOHqmYFge3wTm+bnBw==
X-Received: by 2002:a17:902:6bc5:b0:1d8:d705:c4c6 with SMTP id m5-20020a1709026bc500b001d8d705c4c6mr7448206plt.21.1706951312295;
        Sat, 03 Feb 2024 01:08:32 -0800 (PST)
Received: from [127.0.0.1] ([20.171.70.48])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902b78500b001d71937c37bsm2852266pls.174.2024.02.03.01.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 01:08:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e86da7508219125aed45d869cc02161acee418aa.1706946547.git.tanggeliang@kylinos.cn>
References:
 <e86da7508219125aed45d869cc02161acee418aa.1706946547.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <495e1e3c-f960-3763-3d5c-d0300b16aa18@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Feb 2024 09:08:30 +0000
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
com/task/4543210647715840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4543210647715840/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5669110554558464
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5669110554558464/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ab6eec4814bc


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
