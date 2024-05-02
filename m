Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0A1384BE
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657737; cv=none; b=IqFwcsEkBAb51KHOrxGy7Vj0UIiZIv006MgK4rlxOZX+1wfPT0dU/lHCRBRrQHUalPXGmDmpU20LDT3vyhbJBbKcNOCpfT7E3ivAHIUHDXoaSFc0dwDC8YLrSt2coLlu63MunhWY52SbJiiRBcQtcsm1jF7yFdGhOl9om7dOAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657737; c=relaxed/simple;
	bh=o95b2HqpS1nxKbHDkxe3hfQOUNkvEyi/aC2Jm8dnxiQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AVNfrHXWdErNDkYe0dilYiV1R1BCxyDItdg6vFVwqCnl+N8L9tMUD11t3PKJ4Cs/cnjsNnTk8vCt9wieLE9BJd0a8uh96Jfg7vzGBwNv4vcl8GNCClhHCLvA7AvSZADMpueQfVlTVKQjnPqBOn3iKH9icqA2OSeyWE1cxquZw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1Bi/qPo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1Bi/qPo"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec486198b6so24552235ad.1
        for <mptcp@lists.linux.dev>; Thu, 02 May 2024 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714657735; x=1715262535; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtUH9pnMg801W595e4ayXFBACaFUlXCoyajrw+tp3B0=;
        b=M1Bi/qPoiWG9d55ukjFToj9sZGeDVNzDrEtIUh6wrgcBKQOHSUwqz7x3dd/8pEkYID
         WFCNJhKRb5qKhkoqx1JfcqMXjb1z0DUjQWzyAX4xdi4Xwhr5ER1pwydesl+bRDnqarDr
         s9XBVfvx89iqhnevb8d3tQMAWecIzqL5jhbZgY4Dkfs6fpXn8rtNCRR3FKoCM1i6iZVQ
         MR7oTDWk5HzxLdLiwa59n2hM4pv0w41ALBMmktEa8ONcTZNUnCQisHTnEVnMnWu5vVIR
         KZ29f9d7MwZxyEzjk8vul6ncMCTOrVF0lKv7miKH8e7Qhv7/42VLSeMqhJiPKLAKPudW
         iU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657735; x=1715262535;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YtUH9pnMg801W595e4ayXFBACaFUlXCoyajrw+tp3B0=;
        b=EEhfuRjM9CAfI3zd+Cj/48Q3Md9C1eKaZiyIOAssaGHLtIDKcfmIzI5HV6e2I1HaFh
         iEDDaBHG/sy0jf7pAQ83p5qHBaU9NI3rU1/YH8h6wOpp5yTB/ooUlqd5tk6dWnejsYdR
         OJv9sMD9ibDSC7XNuNS/E3XsocKZUN09ABPDUcyfKuWIcUv6nI6FpPcqVdTKooUuQiu3
         /i8Ib2D2fTFuLaBzcpRDNhrJpKguwuI4+x6YocEVYX7sP0lSv6yoV3LJWHw5pAbigLkN
         0GDUJt37xBEzlvzyLp+B59y7rvlTUCCoIHBqLEW0R8Vji5H7IMuAq83YoFm+UkQexz/4
         tnxA==
X-Gm-Message-State: AOJu0Yy0Q3AcV4DPYdydY9f7eYVlxcv/vX96yUvC/h5WEsrF859J9eZK
	sP16zgknBjHITIwcGPWQBd7bHwpUU0g5V2VP7xgBWeKp46ir+B5dPJ3X
X-Google-Smtp-Source: AGHT+IFw3h3Ye1ZHkJekXLiZ9sci9qoMULjRLATCRc/EVel3bqVHLlpE9HNFOdyg7PlyXBBPjR4yug==
X-Received: by 2002:a17:902:d509:b0:1ec:f2ca:d180 with SMTP id b9-20020a170902d50900b001ecf2cad180mr1757153plg.55.1714657734950;
        Thu, 02 May 2024 06:48:54 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.115.107])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b001eb07ee30e4sm1281879ple.2.2024.05.02.06.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:48:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b0ae79b3c2e446dd0f5ac09470db661d51575227.1714654747.git.tanggeliang@kylinos.cn>
References:
 <b0ae79b3c2e446dd0f5ac09470db661d51575227.1714654747.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_bpf_scheduler_te?=
 =?UTF-8?Q?st=22_-_drop_send=5Fdata?=
Message-ID: <136f488e-7deb-1150-041a-dd8b5dfb35fb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 May 2024 13:48:53 +0000
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
uns/8924472364

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9c0791ebf569
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D849888


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
