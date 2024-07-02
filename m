Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789E157488
	for <mptcp@lists.linux.dev>; Tue,  2 Jul 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923034; cv=none; b=thl0mt5TOl6UBp9mLDZJlNPrl6g8NEc4Bz34IWdsaElehOZQHI1LFd0BBhkVnySNcUskKqTBV8013m9rWPhwCXxMTn+c8ITneQIFFX2WHCKVK856A4/F5GUhHOCDN9Nc4AsO/itMT4WV/E0obVxxh8hSHWCxMyYlmu1vDNwXbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923034; c=relaxed/simple;
	bh=PGSgMo9CKwJl//VRybDiuRRdUvxGSno0yIF0Ddsj4NY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=stfm9EgEBE64HZ0Zh5p97cauCkwjlftnE5Bb95+khgvlVMuZhS/l0K1luOCiGlahRkrK6ADHjeZXzfogFwu/IP9urVDTWBEZXn+t4MhNidYq3ZAtPqDeqP0kR9iP2RYi0LhbEMT+K5nHDJbiS9/39nbVfSE7AeEdcMCj4IDjLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Apd3qeXZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apd3qeXZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb05b0be01so1942005ad.2
        for <mptcp@lists.linux.dev>; Tue, 02 Jul 2024 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719923033; x=1720527833; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPKwZH9hUQpUmwd0lOedQ8nJx29qEBSIQ7BVUZOAjaw=;
        b=Apd3qeXZvaDeaLyfYJGQvmuKU+3nZkHBK75tXUmynkV/1Itm8dBYMD1YpyTg6QvXG/
         /Kl6UYyars7yQPK8xIAnB6kVClGZVgmU1uY7Uv0RctHkRcSZH6kmGvWq32rK2KdMyBTK
         q8Bt1JpGbCZwbSNkXlFyMpaddD5PkXe9dE4B6YyD6Ba5K6j2B0FhSVZ5uPx+CqKI/9Ad
         F47ctdvSKhJzadbjMGsNJPog9BBTGfm59OEl+i2h5076ZvurmMgQd2qtrZLRgL6Qun90
         iuxl5xzqBnzOUwvW5zGo7dCo8lHw62/LK7p7+wu/83vROBo2+TUwbntvYrki67H1wsSX
         84jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923033; x=1720527833;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPKwZH9hUQpUmwd0lOedQ8nJx29qEBSIQ7BVUZOAjaw=;
        b=WUwMvRTbrn7vTjk2DSPtYkckjJfEUp367/Hieqe1/TEuiCwqrFUGxAx3CdJXax3jQ/
         LnR1n7fSh+DI9hhoSGEMT1L6uFGhoVfOC3biz+KVN1mK7cMpC0FCDr5Xjv+XpazX89Kj
         s3WjFtd3C9m3C475kqaKKK5aaPnZysNxHbL1vQaGZJ4spcVSkiocTzBb16AveDNXyVfB
         TntpgB9YNbWTUbKwLw1HbggpDkJm1Gr1LxAGlix48hLplGKP9DH+rzlZ0RUWozTin92h
         AEGVSZhtBuPHFpau/eBh7wlp5gEuHrfLqxZj9LbTgd++YYxyhsrhJD5YqVIMzF9cAIX8
         eBqg==
X-Gm-Message-State: AOJu0YzjmYS2bU58ptVwlr+TgaRCkpwlxMhkqD83MxywxQjKh87nIprc
	qNj1xeUrwYnCeGRPY4jB/1U8rNFcIgqlzslJaSZUZ50BGeqn0DY=
X-Google-Smtp-Source: AGHT+IGGs3d0y+Q0ls8xMVLtRwD8t8/TivSvknxQFz2b57XO/NITNgaLnC1wm/sdyPB8RJfaMfm4mQ==
X-Received: by 2002:a17:902:ced0:b0:1f6:93a0:9a45 with SMTP id d9443c01a7336-1fadbcc47afmr82865745ad.36.1719923030946;
        Tue, 02 Jul 2024 05:23:50 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb01f6f02asm9167885ad.279.2024.07.02.05.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:23:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240702040518.11058-1-liujing@cmss.chinamobile.com>
References: <20240702040518.11058-1-liujing@cmss.chinamobile.com>
Subject: Re: [PATCH v2] selftests: mptcp: always close input's FD if opened
Message-ID: <4966bd61-f1d7-3906-61d9-b221284ff41f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jul 2024 12:23:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Liu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9760361156

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cf373f748a67
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D867504


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
