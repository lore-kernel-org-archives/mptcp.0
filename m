Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84B69306
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707376595; cv=none; b=GDizi8hcODaz71ietWzDJ+JJZBjybJlWhQ7wK7RV2p4BxJNyMJ+lRF8l6a4Q5dPAINbnTmfWGKmvX2QTD5QAJKlV4tXGyAEYoDLY3fnckoRswuv2/VzGOrz9vaqn7EDhiPThM+Z0eRZxsZISnlCvV45lJ+gJRHLGBg+j48RUI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707376595; c=relaxed/simple;
	bh=QGaNEVhCiB9gXelT47doAtXACO2CTHmka7k9OPHTp2Q=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lUOGPXm6+zHwVsHqKXkUBX80wTl07HCfvl8skFbP/8IgePuswRBKEBtMoM4DOo+ptdgsd3LV2wadlhs7xbEWUIpP2CAIgDRhiCgW+JhQTM0HlBDfR+fvdAPCUTRW3hrfdYtNe6A3r8vGID5YhwiX8LcrKKFkMYMO2tK1Bde63EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIOqcDgu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIOqcDgu"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29041136f73so1121414a91.0
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 23:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707376593; x=1707981393; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCe+n7hd2wj3JhAJTkbAJP8MMYZ7pi9bQTY0QoobRic=;
        b=TIOqcDguOI2wj2PCl00K2qoSoObC/2t15v20qGnOKtDkZGuJdC4mrB+AL9f4GbTWe0
         ltwE4tX0GxwGmxfmQDil3YiqP6g/5Zjxhm4r1OtQ3NCoHKuufj/2G7MRwWWwKnJ345h3
         Tu2X/h8ZE2Yq3/s2w+TCveRd/eYtw9/hz/pigsme2uBsN1PMiSNZyoU9zlwZXP1jDR2h
         GSZ5e6NHc1yf4bIHw06E4amYaDrAQBb7OYsl00OT4NTSE4yX6/7A5d1LRXFAasSQKkSP
         fuZLnlOSATViyDgD2HMj2+SpOQKAeMY/6jGfoWF+eUiVFWwY18gMnoOMpDOjBNcAtiAU
         PmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707376593; x=1707981393;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCe+n7hd2wj3JhAJTkbAJP8MMYZ7pi9bQTY0QoobRic=;
        b=P7gRxnBDbA2+1X9EQeE6YePCdZeqUBoAXagdVeRIT7pm9NSuMbaHnEgNkK0yUSPnEu
         cx6GUJla0r22KzHmFtqEgfdfh1679F89gkR84k6Bk/yDk9NWDLmVbLnRezhrnVMRzray
         jp3m2xZgIxXr7m6gR5AJVRH/nlkHpAaq2uDGZ4ZSZ1d7udPAsdURnZVJp9VudSDaAYht
         HLOMFOxFttl7roKcKEzaS+EBHFYhvEoNGSraDqmzEQPuOYRDfdYQGlw/0iomfTY4Ji8G
         4ys8z1oF00qub/MRkFqG5uVKBtlKY2JRc3ohnnjgg5DTcB80v4TOWKB7bsultA+6NyK1
         Mbqw==
X-Gm-Message-State: AOJu0Yy2GwouMqiiEoPIF/c7yMgzu3tV24x+5fisGJDdhRyosGg9AQFW
	rLkhO2wiVw4OG93CQg67PnhW+UAgkohJZpoP9vzu8g74H+vAkMNFacEl8rc=
X-Google-Smtp-Source: AGHT+IHN/py5AXD0R+OnrUf1XHcUetTBBCN7yNwzrgrJeRiqmNkN7J3Je4kt9dmd28Bihjbl3UDSag==
X-Received: by 2002:a17:90a:e286:b0:296:9d61:89f9 with SMTP id d6-20020a17090ae28600b002969d6189f9mr4507691pjz.49.1707376592834;
        Wed, 07 Feb 2024 23:16:32 -0800 (PST)
Received: from [127.0.0.1] ([138.91.70.181])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090ab88100b00296b2f99946sm703167pjr.30.2024.02.07.23.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 23:16:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <69082b9835463fe36f9e354bddf2d0a97df39c2b.1707373307.git.tanggeliang@kylinos.cn>
References:
 <69082b9835463fe36f9e354bddf2d0a97df39c2b.1707373307.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <95ddb787-dcf3-4c94-6102-dd7166c2baa5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2024 07:16:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_regressions selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7825=
836847

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0a74337f9112


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
