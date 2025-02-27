Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048BFC2FB
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648814; cv=none; b=GMQnw490gOt5OxfsKjwlt7XxX8bEotC7E6Z29SHpWFogNiXBGIYcc3kiCmMXC2wKQhjZCSZB9foGaQ9BVmiUL95byNNGuZCjH7Zv6LAzJ6HRNoUhwiOtDAWZElxBnWejo7LK+YEjk6BXf4+O9VWPYaHz/riAeUF+L9/ZptS6Mjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648814; c=relaxed/simple;
	bh=5eXgZ4Aqty7NRWzHvykWhiYWE+sb8s+Bk9I0b6qepkc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AH8Gclyh27UH8Tcdf+JOGRUv9QYgk+1jSLh4qat5RjZmS38gqdO7XBjXUxNK1heu0hMzoQvxp5ykoPAVWi9Trv6sbeARBEX6GAaRnPexfUmtxlc40Eobyez3TjnlEIqc2lhtm6q+pElZXpgtthbzDw1eReOaWAPck2wwY50+f6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai6kdfvs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai6kdfvs"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22128b7d587so12358975ad.3
        for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 01:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740648812; x=1741253612; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpItj7flB65IeldfQ8I5dsNtDonxgF9rxALRHorhetg=;
        b=ai6kdfvsiADdqy+rwvjkSz1918NMW8i3nVDQlSMs0xzyefuKElE5cOxlFwGIdhVDFA
         GjPff0zw5U3lmcffEs4s9sFYUdGhIEP/rnsGg7WbVZ8MB5thNBp2bGqKvw6Y5z5T9CD8
         +J/VvVVawiBcHsVe5QeXFvp0egvvDL0DUJZ9pSiwr7ayOoX4zRdtDKBvf1NdB4m1vXLT
         96LyiZrld1GzBFZSZ2HQCRhhKzkdUlquGvlwX2h8UPJCmgoF+p1LBLgT3YZj9eiuURo1
         /R26VW5/RPnlk8qsnbaJj13s/xIOPeC1dZD2wd/T7MIGSzzHD0C33SgMBpZe1Q99e9x7
         BYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740648812; x=1741253612;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpItj7flB65IeldfQ8I5dsNtDonxgF9rxALRHorhetg=;
        b=XUpAUKT7agb7E/9SKb2DweUtoYn7BtpN23FPnsr1StD8FjhXjaOxSyBzmvlAc0U8v6
         G23UpFp582PnCbHtk9Zo0vozVXuvysvntrmkrd6VSExA7QRJS2h1FVfFHLduP0Vg5Nhz
         AJhzElGaltzYV0KcGQncaSZEk47y9YUQWBMaYnBi16aL+t2YaBTTBD/y1ouKS65Yn4fw
         Pnzh0KwMV/1WmsAvngzvtQ0525RK34DVXTtbd7He94XrifilGXf9QZqQzWUzdRqi55xl
         h4ahz1V9gcKxqmTteeV3ER7PvJlBHejOTBgorHR3RBJadY4Yv1Q8WgXAIsmd2V6iHFAl
         hsnQ==
X-Gm-Message-State: AOJu0YwX/hKd2oGR/X+aqTSp/WIpYFDauDuv7jUUu1SWEZg+lU3SvJfn
	yEj3r+f9R00/++SykUqpxYjJ1e2KA5jtzFopzWlApYwxIYyBqFiIQZIZVOE=
X-Gm-Gg: ASbGncvvxjOLaR28+MW2j5g/qKOVTap29/Wfgzae+Ml+mMoRHYnFhpJn02MDIJwzHxL
	1v+rwpCLeofz2H/RL7DDkHAQWP7wUXHJNY3TIAKSbGLyprb0F16YpUUnMcsLzrGdfjiYijb2gJS
	8PV1/yQpR9r6bgTgiulRUw9Q8TLjwWNr1DjN240yX4x1cV55Mfdrz+YKwOzY1qpsh5rcEFjc4H2
	mnwyvMzrAUG4YaCBeAiGnU5bb0RYofSBymbLInfCNtrBqHGMMpTPFlc9veqIjgBZnhFA7Le/3+r
	VSjlq2tAt3XHCzLgG8G7X0oSgEiLfAaKaPd/
X-Google-Smtp-Source: AGHT+IGRpkAYa32xYKDIUJRrGeJcPRgZVV41BV60hBftuS3LKJNi4+YoXPXUy1ibh9NizISH2AeB8Q==
X-Received: by 2002:a05:6a00:18a5:b0:732:a24:734c with SMTP id d2e1a72fcca58-7348bdb1ea5mr10574274b3a.6.1740648812068;
        Thu, 27 Feb 2025 01:33:32 -0800 (PST)
Received: from [127.0.0.1] ([52.234.7.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2b558sm1092773b3a.21.2025.02.27.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:33:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740643844.git.tanggeliang@kylinos.cn>
References: <cover.1740643844.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH net-next 0/4] add sock_kmemdup helper
Message-ID: <3e4c07cb-77b7-5577-e7a0-e082ca9496f4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2025 09:33:30 +0000
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
uns/13562166243

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/24afc58bb11f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D938382


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
