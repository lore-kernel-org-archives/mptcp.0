Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC118C31
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718431; cv=none; b=JxNvuh/c1K2+dzjrup0YjFLSYOv15MoZxqN3JFST+ehifgpusIjkL1It8FQgXrVBmDO1N/R4uDuk5+7et7cB2s5op/Ths8Cx3Ob3RPKPoVtPo1comqDTJJVgqlWJGboFO7209Ufnh4yRWS0cRxWlz+S3zpVwVXI5/oE/JPHtVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718431; c=relaxed/simple;
	bh=u2EdGVJVaaRoJ26iN8BWXM/YUB6ryU66+rON3S2fcYY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CbWF7tRvZoEIgA5QeY/RgKLQqi2zqjGE5QTW6htuH7GU9r6R9vtyqKMJXFM4+QqFsfNO5Pc9wghY7SNUwMYwSbrhE0pEEac9USqrhmT5w1dIUHUHI6qkZsOJJJtyJXwJOVaCIdlRjW6uWCL1fmbuEXNxNzksmvdMEBRLbPvu0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSQS4Lk3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSQS4Lk3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b6c311f62so16652715ad.0
        for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727718430; x=1728323230; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2fkX9M/gPMXwRZvMYuG5W40P8/CqZQ/7rkrXpQVWqs=;
        b=YSQS4Lk335BAT3YXFP0UvlMyVmVvLDCIEZq464zvGgUdIz6QrcnYXqrF8WqcHECpdQ
         AtSz1YCJDrcV0+EQXs/z5DwyPxBQWGpNrS1oaMc/0AWGeUQsaToDz2Q3+inzqwtBw9cV
         qG4I1BsSXdV5PUd6B110I1fe3ZWq3FEW3LcKsKT31e8SwKtaNWJ9+Rsc/seco/gm/EfE
         RyR47bHBhACDjuPordyEeQoWvGM3wtjjC6xNqIa2l0Rb6ta2BD67EWesqgcNuQ/5aykw
         geoDYIeswmJflIOmaYQtvyuovB+R8P/HK3/6KEmY3sewyJz6Q3bml/4WfZGHOR/yu/L1
         4zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718430; x=1728323230;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2fkX9M/gPMXwRZvMYuG5W40P8/CqZQ/7rkrXpQVWqs=;
        b=PO4sbilDwkAqu7jueKTVpctgjkLoHt+cuN2MNIZ93pOUV+9IYQsm/hNRXGYP17KjiN
         pt4n8RloHUoyck1FBVBuZgPnG4FZe2/Xoz1XgLRIaAvG4zwnmc9HthxrDj0VrxcEPL3q
         bIbTOzbWvTDiyFhh/527A/f8YZJPnkXvPa0xZq5s4ebqg6ptyBCIF/tgP0mrmw9l9Dym
         /vjNp8sOPndGmXHEjyFsRq/c8ZnhxlLUHKxyggnfcM6MeAlLnpwgtt7h7CdTnbJ5aZS9
         je2prSX1nTepFA5z1AbtOE9kp4P/vzGRMZ54F00BJbdcYvgbGd9RzMBHjeicbc1Tw9pg
         mE1g==
X-Gm-Message-State: AOJu0YzLWgMSQt+LOdrTBv0VzMKZL+hN5RbS5cR1l2QkPRWordbu3wfr
	Fz/CSXYGLSqB0lRFENxv3C4t6LxOQgFiNO/f+Ic5x57HWGDrqMk=
X-Google-Smtp-Source: AGHT+IFFvwDmPyaPbjEEXes+vuYHtUiEX1TqrUZNWJ5MHdkqvb7XNYOhX0JutBqV8ERk/nHQZFqptQ==
X-Received: by 2002:a17:902:e881:b0:20b:8907:b597 with SMTP id d9443c01a7336-20b8907b610mr51513445ad.28.1727718429876;
        Mon, 30 Sep 2024 10:47:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.6.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b533fa125sm42821615ad.141.2024.09.30.10.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:47:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <55c07402fc274a8ac97d301bcf7d1cdb5ba51700.1727685608.git.pabeni@redhat.com>
References:
 <55c07402fc274a8ac97d301bcf7d1cdb5ba51700.1727685608.git.pabeni@redhat.com>
Subject: Re: [Patch v2 mptcp-net 2/2] tcp: fix mptcp DSS corruption due to
 large pmtu xmit.
Message-ID: <17666cf9-f890-19fc-d66c-02d0c667a00e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 17:47:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11110430885

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1e2d745bc870
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D893930


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
