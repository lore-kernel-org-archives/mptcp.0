Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC893F9D5
	for <mptcp@lists.linux.dev>; Thu, 26 Sep 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369907; cv=none; b=WmZKeOvCl/StEBV6iayyJWif+2g+B95aHwB7WSUl0cf85GaTrqlXs7swr0XK1uv76KyzjdVMgKmbqZH7Q/D4ZZzrv68jNvydr3DYlEqwySYitF4elU6uegBnrNpUVeR4UwoD8UNYeif5Eoa4nyp9zOAuI8FdjFyqBkH3eVHXr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369907; c=relaxed/simple;
	bh=G/fowntihzCOrg+MGCB0/ykf2VSs7uZl6B1Qmfib5dc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=I3zsQn5aL1PNLFjdEWBGwH/EPnumsRGqQNi/13bc9TVsOZ3v1FVzJ1uDdLyPTrB27uAfeEwsC/0fTTIs11S/69dhQ8NOZSeV1bLJ1+WfxHiyrANRyNn+Wxk8rSHSr+Qpaq5PR1tfRxcnmTbQXEmmi7wq54//6VclFh74uiuksOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JICr880M; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JICr880M"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb2f272f8bso9112976d6.0
        for <mptcp@lists.linux.dev>; Thu, 26 Sep 2024 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727369905; x=1727974705; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCSp42+iqdXE42YeXZXl/NfYcTQwlTeDYiIXyfBd0UY=;
        b=JICr880M2IwWz3FcirRz6x61QnYi9+2EjZR8irLzt6fRo5gEapuNqvjpK9j2VlXnwY
         MhWsOe7UL08doYZY/8lpq7Z2jea+DSejMbaGbIwr+xWLW4sdAZZ+Az0XPezk7dxsy45F
         qCFHtM6tJ4XgNfX55KBR1KynrIvwkoWeY6OuusfP/zkErp14Gbg5VdW/rpyBm2YacB+j
         LDmkPNkUm3eC/VDVlOEFvdV1MJlvldc+Ycai5uExoqgYkOm7Bbj990kD40mYIBODWel9
         k8A+Qm3LS+43SFYNo2XpgNF934Pb+jTxaZGXGV31gU5X9+SUfqyi67FwM9rHp5FVAOUw
         iEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727369905; x=1727974705;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bCSp42+iqdXE42YeXZXl/NfYcTQwlTeDYiIXyfBd0UY=;
        b=vKiwtaZnPvOdHClGdChZZSd+rbI36iHLAYPgg6zTgwsZD7RaQTES4t8HT/YVcpArop
         jHPT4p5ymzGByjAVqwZtE7B8NkQU608S7X9T/1zbWeNVQvnCLTWwDsud+PQNtzzKEeB6
         S5rOsPhqcIWEQzT4uQSbzUpuqATYruolOHhKsDwJIDOewr/lIEo4w48yRAyiYE3Vpj1B
         JN1W+BuDlpDLcp0BsU3LK2/1BGQBXOIQqSEnuc7NYz7d52WF4ASJ2NCC/IUDPCmlPFM3
         0fYwPVmEWZOlpQy0MM1u6d6PPR7CCojdm8rrYXJQO28ygDAAMASovDeKaSWVnSPx42lb
         Peww==
X-Gm-Message-State: AOJu0YwCuiXxxDnQ+IrUFtkHQiwZFOaCJ4d+OYg36/ZYPGmZMUoJXXVA
	mo2gu11xZh3DupLR20ukO6NYKBQcqFDdBe3v0xsBgiU8dWMZ+i+fERlb
X-Google-Smtp-Source: AGHT+IHdvhmQ5xmwkSYkvjGvutC2lfd5WKu2vj/5L7AZ3hN3xd8htCk7d2MiVeGy5dEKcTJeSefCQA==
X-Received: by 2002:a05:6214:3c9a:b0:6c3:55f3:ed92 with SMTP id 6a1803df08f44-6cb3b5e7233mr4970496d6.2.1727369904630;
        Thu, 26 Sep 2024 09:58:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.51.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b66ceacsm956576d6.93.2024.09.26.09.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:58:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240926-doc-fix-lcov-link-v1-1-46f250cb7173@kernel.org>
References: <20240926-doc-fix-lcov-link-v1-1-46f250cb7173@kernel.org>
Subject: Re: [PATCH doc] docs: gcov: fix link to LCOV website
Message-ID: <4a5d7539-0cc0-6aba-89d4-c16fe18dd9e2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Sep 2024 16:58:21 +0000
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
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/11053241411

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/67d12a840f1a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D893147


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
