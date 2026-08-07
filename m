Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D51130216D
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092423; cv=none; b=MuDv1ppCiNRlmAwqtKpcdkKWtt50EpC8o5qFBREbUiJZhU08lTK5blV6qDE95jJglLH2H9nhlwZkasg0CCkbRysPc+KorYuoin/hrBI1zNikmE+h/9ZsS+Twzp5JXL5KpP9YNAxLfXi7R4XMXXoGkHnbrUx6dC2Y5Chm28CuRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092423; c=relaxed/simple;
	bh=lDpird3hHObWiHWHu0yhpWUySgHrZhWTgSEwiQKulnQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=lAfp4ZCsjLYT+XuVZA9p+x9NHk7dEaY9FiR6cxuhr0vHQ14s3A43soTQjYVp+UhAZkPsC+gcPrA/ztA7tNptNJQUh0DuPhG3+RMpdmZSK+wxyoUZIQhzM4NqexUv5ZWjg0Qec6pMnzPPRgZmgYj2UKwKjbbem+ObV3Y8/DBIwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4EIym3z; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4EIym3z"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8484f229529so2699997b3a.2
        for <mptcp@lists.linux.dev>; Fri, 07 Aug 2026 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786092421; x=1786697221; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bLaB3uYRir6YQN0QvA6Cz/FFX8vj/+D/EnGWxK30ic0=;
        b=m4EIym3zMiU3WJC9cZD+7TBZUDny8QtVQtFL61ijiTXEL7kDtiHxS2CZdvUMj+MWAq
         XayqM56BimnA/UgPWsgMxllqt4r/GeHPZoA0fb4RQDE7K6ttK/CQ5uqxCWW1EtKE+0K7
         XkfjrJPiajp71eObArqUfMCHIrq4Q80mUkLVOxVsB1iBdFQmn6/1B57UH/Or8e50qkau
         dBjRRsdIy8FGQ6rPdND6Gg7XxUhtxeRUoZLVOvMxxardW+siAPhgsa2bujM+MaJplPsQ
         CtWKobezlelDwdkybTphW4nRfYNNISaa2Z6jOXKpoENSpskLDWd5vj8Gl+DX43c1R61U
         efYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786092421; x=1786697221;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLaB3uYRir6YQN0QvA6Cz/FFX8vj/+D/EnGWxK30ic0=;
        b=ZUzOUqTqHyJPzGHvStYa0hLJIp+lRTeewLh5zdwfaP53WbX81ti/wgraDt6bbQSDrx
         hKeWsbizHp0N3B6k2h3QuvGyhnjQ8OmdvlOVg/WWRlUQrcSQpyT+9FB3JJQqbEWHOORG
         qAtmnj1HBzoP7nDiT+bYfjApxzi4bSx29+nWStPlHjncj+Dmsh0AtlRZgRq9OKAiqRbS
         B+bEUNDwqmDWKW7h2e8u5M7DXGSqisM/180WsziLWOk5I/ncj0DE7pNKYqh6+eIoB4H8
         6mRljYGWpFllqJkPW4I5HcurorKbnaKLAeqbSHzZRBjDa6Kv45bz7QYjRNy5JLqe1Syb
         eaxQ==
X-Gm-Message-State: AOJu0YwkMoVfTHRRCe8mGV4GvAW1PrmOuX3jdUSLjJ+sR42aC+2tzxc7
	NQjRvKkk7xsPACVqaR9vVH3puX9b/OJHX3Q4yaRzwPsD5zysfo+8GVqlZzGs
X-Gm-Gg: AR+sD11XelhBd5qo1C5ZfLQyKipiCrBfi5xQMH6hkIKxZRwhf3KdYf99H7bdQ4Uc5J5
	UIVf+u/y02VcSS5vecXGNZRYKpvX127nJrLfvZ7EzWJi7WlKyejD5YEqKpFK3d4vV+LcL73CHSZ
	AsMEMez4sXfHvrPEYO8UZeDEtfpL6y6XIPcCjwhM5J+w7BU5wERm0Q8dPHV59phKjpHA3Yv1pk7
	N/1nuuzeUVWVA5Lzsb7UgVulF1lpZV9+Dm4LZyCDESuPcdw94Z87QqW/tKZos0Y6FfzLCgzyZaf
	buKeI0+W4bujSF8IRZQhmDP0r4x3l9iHZ/gc+8MH+Ke2QkU8P9bwwYigVyU3TfHkmuJF4lywKqE
	aO9G//T1853wV9r8WwqKhNjLD33835Dr3ARhI6BjK4wAamX1eJtGq0Ug3MYXJJzDKhjRDNvDSIo
	72bMlbgmsLINhqsuGFUD+6pnI1D3gQ7RpPrcqEUJc4Mo4do8Vh1V7THxsHbg4J6J//jA9wIfUGU
	Ru0qVvqgIg=
X-Received: by 2002:a05:6a00:390d:b0:845:31a6:d84d with SMTP id d2e1a72fcca58-84f2e0316ffmr21432219b3a.7.1786092421378;
        Fri, 07 Aug 2026 01:47:01 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.85.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f19634dsm370950a12.7.2026.08.07.01.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:47:00 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Qing Luo <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260807074110.566170-1-l1138897701@163.com>
References: <20260807074110.566170-1-l1138897701@163.com>
Subject: Re: [PATCH mptcp-net v4] mptcp: pm: fix userspace PM address ID
 overflow when all IDs are exhausted
Message-ID: <f906b0d7-902d-ea12-d342-68eb909def91@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:47:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Qing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/311601=
30229

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4f69b893564e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1141997


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
