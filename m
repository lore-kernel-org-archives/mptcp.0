Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF66AA2
	for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705474868; cv=none; b=ioaYuCcZDWbUAB9CQyLObNAxCwJlqo/idfM9B0UhDIX/FJYK8Qw+E6/ioDQln/llvhzQVPQjAQh2e3wsWvvgYNDhpyJ7XkigI3Y/9TtpW4qfS9vR7a/KVGbBjTJXc6NxHSStZVEYfoWsh/PYNMmIgo3/LUIIk6KlY6i9pxxQY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705474868; c=relaxed/simple;
	bh=lVMz3epfBEvBWUXd96mDS6Zisyx9+Ky0VzAQ8OnzqWg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:From:To:Cc:Reply-To:In-Reply-To:References:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version; b=tFVPepigxLz4chYeNGEiTgyQGceG9Wmr6vhNydGrBawOnHmgVfCW1a6FXojZ1AYHzxEPKQwljYox04LLnJt5JwsQMk6qsPQmtSdZWwTPDlv9HlVrdI8+yTyKPqWbikTjRdgcuFwwuh3WvZ8qTNcxDvPlLjuHgHptnaiof4M9A3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdlhBJv6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdlhBJv6"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6daf9d5f111so8658728b3a.0
        for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 23:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705474867; x=1706079667; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoRSQkV5rkudpIujsdN6ehqzi9JEg5fBVKKVd/WvZmM=;
        b=VdlhBJv6BmpharINHuSwplHZRs1WVqs1gg8qrXww8Bamv0l6hpJULGjQNxixxKS934
         J7uoBss0F6x13M3wgkuj+dxhmxcGJVbV4D7GIXOEsnSDEksDa8C553125+QsmmTFh3a9
         EDqAw3suMuz7NPoVGMBFL/ml9H/Zn0MRvb5WoFTuyz3IUrRMtyUkdYUzXlz80Po/3JkY
         2Plg9DC7hMDdn+xujbvxCS97m8rYELF0Tkb97Xh5M6UFza6q3FDsCgt5P/TTIg713l0p
         G+aTueahPxAa2HjSrANFcJ7IAYyBrKQs1IVYaxL2WyPVRhJkrz+Gm6zxnf5NlXRTpXud
         4sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705474867; x=1706079667;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoRSQkV5rkudpIujsdN6ehqzi9JEg5fBVKKVd/WvZmM=;
        b=lj1K8056qsHa9ByTNJYJ0WhXxW8kRapilmGNeM6gW/P6mHqB9VS+a/0aBY1UZXhwGj
         wwZA4WkFb4MNFkOBrFalBNeQ1X/5uCH9dFupfDqzo/0Ol49KCIUnnddhiKYui0ednfqP
         4znylYHh2x1DRIRWc1MXjwNXIwciu+gMbs3vfvY6lwA46mWv0V3pVHVgxEQ3fyEpU2M3
         Hq2D18kFssEoIPsQTHmin9QBDB9F9WocS458/7B7mzxzn+4HIV9IYZikTTqdKYmjNo3k
         cc3KdCQWU202sFVw3htjdGONXsOya1lKXeI+eBkaZrcWlT6FXyMQp4pL4U55cqCLObVX
         AZxg==
X-Gm-Message-State: AOJu0YzVLediL52oQjHKy8h6swwiGSmTmkJDKijeNBYmz7zJ9bPp9vmY
	RbRIHP5DXAll/xxE1XxDkA==
X-Google-Smtp-Source: AGHT+IFA6htRDNectmxw4VCmZD78/gmT9BnQ3wUaloWReluBR0PgF2jUBcr6IZQ57XQRqfnDcrljcQ==
X-Received: by 2002:a05:6a00:2d9b:b0:6db:7543:6952 with SMTP id fb27-20020a056a002d9b00b006db75436952mr7415028pfb.52.1705474866929;
        Tue, 16 Jan 2024 23:01:06 -0800 (PST)
Received: from [127.0.0.1] ([52.238.29.135])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b006db11bab9d9sm671113pfn.202.2024.01.16.23.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 23:01:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
References:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
Subject: Re: mptcp: corner case locking for rx path fields initialization:
 Tests Results
Message-ID: <1fe3cf0e-f7dc-7fa8-0537-3df1a8da37fa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 07:01:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_regressions selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7550=
415246

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1fd81af266b7


If there are some issues, you can reproduce them using the same environment=
 as
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
