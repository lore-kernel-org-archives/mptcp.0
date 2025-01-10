Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B33B661
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736482234; cv=none; b=ZmiZocEGpudOe3hVNyKmcmZjmWWXWbsi22bikSyVHoj1TKaVmt4Yd0EpMV1q+pE7mX8RHrOVGc6sLkzquLej0tk8cs+dqWGSaqZ8g/CIobXpPlV2l1LbAQJT8GO2ZlGOPRV1kdiL4YkMvimt6RTMoETpK+jeWeE6Dx9YxCBgg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736482234; c=relaxed/simple;
	bh=HNma28ikdUceu0LkmvZoIUeavaez79xDSfdqF0vcjtQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YCvBhLRsOyDTJVqyQuiaKGpz8oTybk+Q3V3icDF3kCaQroOcNCgPUBjZvaRc+IYhl0XmRaDWnCOnMC/LCd5Din9tBhpr6YdaKK/HK3T8B7z6rpPnGC4NHL/PxbeIlRL37zrmYiFnQUuNluficwCSk7DlsboKWjMM78qFDuPwYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsoShcK/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsoShcK/"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso23151286d6.2
        for <mptcp@lists.linux.dev>; Thu, 09 Jan 2025 20:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736482231; x=1737087031; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmvrBH+TKHcVp9E+iuup5k181pgzZdt+ZuNhCpMbAMI=;
        b=PsoShcK/5J/SSA8vrIons0sgPhwb0q5vsbhf5b+C5grLLgLGn8ECaazffcdB5+ZidX
         JjocLkKuf8e1kvBCSF/+o4KocYL0iJebR6UaXZh4BKuxTBjHgHDTA/gMNG+akVVUoZks
         5fCWS+X4HZGsraO1zQA+T2mw78lCKgwBmOtmHvjHJj0Jjq+8hdAg5QwUHc70mDNKCIkk
         hIenzq4ujW1f+ZEr7ZSrb4Ln3JUbvbWT01BXQoxoPbypYn19Q3+XRMjwt/ROdoLqBkqH
         rIVUdnGVfTFuJuzAhjH1J6lT+eZte3J4ib/okinNoyqf29OpbgjtD7J0w6ApFlfP60dS
         Jr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736482231; x=1737087031;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmvrBH+TKHcVp9E+iuup5k181pgzZdt+ZuNhCpMbAMI=;
        b=PqKrNXEDKJf3FY7YL9dNoi5qad1j0N+0Tb8ju23wJ0pfsts2oqglgCcGzMrTpBJuE2
         VON4Coln1+IfmG01eZedfdS4CaEXmXCgn7ztPk6SIbz6SWuOqa/zhf3xE+8bBzkw+K6B
         E7sPyj7Dhqa2nGjaM2mUppKOemQ2AGAvWodTy4LnPLXdB4jGQnXLCu6yUYRZ89i/2d6J
         Ez1ilezmx3aHsWgBiuqmX6a5ixBys2/j5rnQLu+cffRx5sDvzzuamjqeI2i+aKJvwBBw
         NHrLsV0iw6YP8+aZNgFudwfO40T6uNar6ZPVgFmJPo/iQSwzXYgukTdbhySuxH8VW6Po
         SjOg==
X-Gm-Message-State: AOJu0Yxh68YNUTBVUDXFRjtgyI5c+nFIlF5KjI//SyEJ/enaz9HW4Kmt
	oZSYGTQ6Mx9xgdLENIV/UXJZfL5lJQwwNnAG5vkoiAIGdZJSJr0nYXLZ
X-Gm-Gg: ASbGncvkB9pCWWPiI29GaAAOlmZFhzw2sWECdfbRaC2zkcvR/5VQRDufnT0ps0IgRkk
	Mah4XwtkICkIACElvOJEwULAI+OdDUKEP1212usYK1l3vJKi/wVByfkQszmlC8tF//Lon/0mhl1
	tDr5E91SSE3f/5HZyi9q3ESpaQgw+GuXmoxvt857yHGzdqWEKIcpo6r5OXqt+ZaFwes6l+6ENpD
	h8RCoTAwRcalyl+M/ZuqgpFCn1GegIzdp2yFKEfqSE2CZ67ioLD4ptYcCtxzMuRRAio8as=
X-Google-Smtp-Source: AGHT+IFMV+XtBHgFV0cmQQn3dImPtfrwEMP7spld3rMpStsAifXiwTWpizU7Xx38mpHgOkpW1IGxxA==
X-Received: by 2002:a05:6214:3289:b0:6dc:d29a:b19b with SMTP id 6a1803df08f44-6df9b2cf5c5mr152128986d6.45.1736482231327;
        Thu, 09 Jan 2025 20:10:31 -0800 (PST)
Received: from [127.0.0.1] ([172.183.77.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad85f6bdsm5446606d6.17.2025.01.09.20.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 20:10:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ff9a10bb4359ec77fc0b7499f44b388d737abe0f.1736477907.git.tanggeliang@kylinos.cn>
References:
 <ff9a10bb4359ec77fc0b7499f44b388d737abe0f.1736477907.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_move_stats_info?=
 =?UTF-8?Q?_in_case_of_errors_to_lib=2Esh=22?=
Message-ID: <5e066aa8-963d-311f-3a05-ef70f8c68c86@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 04:10:29 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12702676978

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3e692c59a11c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D923993


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
