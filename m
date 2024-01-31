Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2A63C7
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718684; cv=none; b=mF2+a1SsTOwsA2HFQK1liqWTyn4C1zM5qoKYSnE0WP9Kppuh9UijQvl4CP+ic60V1d5Ul77i6EJSnoZj9JbfHQAwMaXE8SzuGq2YBe4xhnokwhQ86zQT9P+RyYm+cv1t4YN0/AVbmtLv/GC+Wp5nvT6rSIk4kXsNrlWAFkuodFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718684; c=relaxed/simple;
	bh=Q6dltGYsNeepKRYBYaEDnnroriLuMUqlt0gE2S9GP3Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=WE5IsTfOTD29hZVvhKEN4mVepTqO1m2In22G9Xxh+pei7TUv6yM/UgBptG1IePom5LfWDKKZ8+VuoTbx49+OmTn6A4HDFFRUdcy+cXeAhqAk89KeAsY2SQgGSERll2XSTELJ8kf8KtLuy1c6Ymt7wjXMlY/+cGnsRKxOuY8w3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tad7RoNa; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tad7RoNa"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-785388b3281so31585a.2
        for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706718681; x=1707323481; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k44VAAMUI4lK6hwvODfQtrZq9SMr8w4rFQnqlF2H2lI=;
        b=Tad7RoNaCcL6JqwzTRGlW8dURfVf/4d2pRfSKO+GY9hdI32DHyYI/2zAcYkdDCdfVL
         H/NOwipge2cT6HusCQZCGPgGmPc9mCLIZjgwTiKGoFFdzWgd2PFyd4gW17MuMTfIst0X
         Ulnr0IHYVdno4BVtyCDEErC6LSWbUAgHYzG61xx9XP9+zeERIhhAF/m66imL9IoghiuQ
         6kZX00G+v6o6iKrjYZ+oLNaONgMMYjpRGV3Z1tAEb2w3HOdHDnQy+i3VRFiD3XhFhPlQ
         KOpMAmOX+kTDnKC/tfizqO8UcymlLMnviPSdmci3AimdCochzhnwyeNVWJ0aPEheWJUF
         tGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706718681; x=1707323481;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k44VAAMUI4lK6hwvODfQtrZq9SMr8w4rFQnqlF2H2lI=;
        b=ulRED9LqsKvrONuQyNNVIpIRdH5GVpPBNenuJR551gT6bFF8gzgVxovooPbMj7Gaq9
         MZ3lgOjwjugb1jUeV5qNLPDNFQPaYXiqG89WlzW0Drdx8WXoyQMHRxdGn6Ysf3ZDopnD
         e10Bk5ENNpoKd2S+VmqtmnI/PsiGeRYqiozh7zNJ72ztWih5FMokxuBcFjTpATUD96+J
         4WWEg6hlJom2o0cNnKcKV3PV7hrCimjEuv5QqTB1/JxHYC14Wexbqty0HHOY4n6QW0e/
         GJX9d0iFTfxc1y/8HjX+fO1CltgO/fn2v152jrn0r+BuXuZnHayQ3MVuvqCQHSP+zyup
         oipA==
X-Gm-Message-State: AOJu0YxlLlT6dR11NCHB3MPaz6DhBHeGqQMgDKH3mcsTx4OLFDJkrjSw
	6M6agoUhaelzU69hkBP5PfCfogt1bCs+Ht0MOTVxyfWVO+7FXCA=
X-Google-Smtp-Source: AGHT+IGbgQUzhwls+nOgsQoxT86s3VNaSN+hL8E85EeMOJkl93sRDeR78k+vyhSIhwY4046TDtU4aA==
X-Received: by 2002:a05:620a:2490:b0:783:9432:8bf9 with SMTP id i16-20020a05620a249000b0078394328bf9mr2351370qkn.52.1706718681140;
        Wed, 31 Jan 2024 08:31:21 -0800 (PST)
Received: from [127.0.0.1] ([40.79.247.227])
        by smtp.gmail.com with ESMTPSA id w17-20020ae9e511000000b00783ddf9b9d5sm4512056qkf.91.2024.01.31.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:31:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240131-mptcp-check-protocol-v1-3-a06067f0bd08@kernel.org>
References: <20240131-mptcp-check-protocol-v1-3-a06067f0bd08@kernel.org>
Subject: Re: mptcp: check the protocol with DEBUG_NET: Tests Results
Message-ID: <35dd6a01-fcc3-0f28-5fbf-d522adc16680@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Jan 2024 16:31:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7728700216

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/399e99c4147f


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
