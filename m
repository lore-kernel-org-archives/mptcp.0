Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31179248BAF
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939780; cv=none; b=RWwNBjJi3d5bq0pI9HEieUz1zKgpDOT4GSMuR4P8OSq8Ih5tUgmzOkQ6AypI4n+4bCXTCBWzj9MMWr22KM282xhCYffpubEAWSlpDF6mPbqOv/sUQZ39XVIChDzPq0G4OW0YtMvQZ9z7pw6nvoKIGuX5XxCiLlc+lmGjpCI3bik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939780; c=relaxed/simple;
	bh=XXbSs/XdViq4WRPb7hZt3ax9Q23sfYMgSZ9pYLAxuwQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=efspiLfTzjv2sQexmZyZiKJ8YMCczCVLKQ6qHTJd9s5mrS9LdHyW7G/GGmwMaF2fLSXKK/vrBTb/km6oUS4x+nrZiXy2/hySSZajjSgAOIw4ANiQf2wHIrQLS5rA3g7sS9e/jlhUj4T7jMPRryQVOxl5rBI4y9Qjg4p35zsSHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc+jmUky; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc+jmUky"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so19860996d6.1
        for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 03:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736939776; x=1737544576; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKGIHUZKGdXvIyZocnNVIfsclSjbXmCKX7i18/CNC0c=;
        b=kc+jmUkyX4KEoDIIdQBznLhVzXlW38HV4HYOotRHSI7yO2DetJu0l+sQXVSVqWKWCb
         OeziAlh2uiw2B/bA7soekQCE2VICRCdFVHRZ5D/asyFryZxTghwSRsbrocHGLArKut+5
         ge59VL+eKH8b3pY8dmHNleTiA8foMAPAA4twnR+tsZMkMg6XEUfzzTx2ffty9plQxDea
         Mo3x9tM1kBE++aCB216JaP0eW/lQ2eqA0eL5yPhXS0ij4GExNleX6C0sqJ5C8yJOqWJm
         4wEBxg8mD+D9Qi7ViEoeMtBDUvcy6xmeu9StFf3Fr+OU5RbNaHtRPRfX5CwQyOk2/q/6
         DGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939776; x=1737544576;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nKGIHUZKGdXvIyZocnNVIfsclSjbXmCKX7i18/CNC0c=;
        b=lA4/zeEtKzAbi8wlkF7H2YeYdhv8iA1AAOlA1cHnkl7ytPLCnGhWwc+opIxQZeNdNU
         tjpECA5Vyh5s6UW7SUzvUfRNM3c0aBTHDozN+h9MINQbNqK0/ZBd/tYwlnPMmJHinAOx
         3ZComx4EEj0ePxvDp+R5wog9eV0wmvVOu7sznVo8FifuT329WDgrGMlCo7xvYxuMUlQ0
         fSeX8vXcMas0IvWDgqVYVzMMin3xe4Z2V1dYX3XEqe03hAs/YWPxEtgSXlafXzv9OyXx
         yeluXbUYzv62b/MOyE+gVIiuZsxJ1tYuS3kzvUvauzXa1Y74YAy8uM+3R7/718M0JZmW
         8EAA==
X-Gm-Message-State: AOJu0YxRKyzVXzFsf7QY5PFUdx5XaelzIxEzW6nUU6XjmJSill5MpP40
	6SzCS6I4h3NN+vTu12TQ26w97JdolsipKZIF+Z5Cl9LJ6jSt7cnQ4uJ9
X-Gm-Gg: ASbGncuF2lSdpzwh2/3zhDKu90lTOJb3U4nh6+CC60xIhFnzj0Rf0KwiWu5HNQ4MGqE
	ClNcF59eUuBqACy+tV5x5RGrmeHLtJAtIi1hk6HWRYRINl8qWFt3csanhizoz+NxD6Lggf1g47/
	Wa+Z0gY5iGsvb/+N8yuNIXJgqhk+xZzP6nSkmq/9mSlG5V7daN3wd5RQXWettFzMwxCadAO/3n4
	k27HYC+BleyNTRhMGA5BLNCcZEnQ41CAUOxSY4aGZUBLq7GGtfGdCDIbEOEHmv9dqABDbU=
X-Google-Smtp-Source: AGHT+IEknlhigD4t/LIng5mcgssF/JG6TTqfNwR1IS1oxjk+30qIHCe7h2FgFrkKo6cv8fiVAhzXug==
X-Received: by 2002:a05:6214:55c7:b0:6e1:89c7:bc7e with SMTP id 6a1803df08f44-6e189c7bcc7mr89740186d6.38.1736939776058;
        Wed, 15 Jan 2025 03:16:16 -0800 (PST)
Received: from [127.0.0.1] ([172.183.229.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873216e6sm63627511cf.2.2025.01.15.03.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:16:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736935433.git.tanggeliang@kylinos.cn>
References: <cover.1736935433.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/3] BPF path manager, part 4
Message-ID: <1042f29a-1af8-8c97-55e2-7db9b495ba37@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jan 2025 11:16:14 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/127861=
55697

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/70af88472329
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D925640


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
