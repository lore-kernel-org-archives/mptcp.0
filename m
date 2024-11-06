Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC14205AB4
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923059; cv=none; b=Ib28m4rEU74cn1sexLZm6I9cAaagEtSjLjOiUmQOXHxLKvsnbqyRVW9GfHcBE1ovNmPrNKdVL6JfD2ylrWl2PL08SZ45ozjEHEfErQZpU6WwKFKINjZYGTHQjYoVIyxG4x2vn2PWH1N6R4zqhjU8LRhIvWibI/mztuCvbfUSiHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923059; c=relaxed/simple;
	bh=u+95mg2q/JhhGW+TPkWTpFhnSAYwTsjG+5Tvzpa9mF8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=liZ2uPsoSmcuK+W3zILhlDBu9uFbkvFoCgjJLnCPguuEOJDEVynVFjRlHWkFGYkOYKahQZXSZhkYu7xmNT48GZm5IxrsNjI1FmgLRWYH4cilQPwCZvqlEdnmYnDN73zHGmaU66rMCzJWCcP0y4TeeJrLwDBwMmbFhHP9e2cpMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxoS6hND; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxoS6hND"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b15d7b7a32so14233685a.1
        for <mptcp@lists.linux.dev>; Wed, 06 Nov 2024 11:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730923056; x=1731527856; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN2/M1rXVfxi5HoBRlFEz4UtKAMxhFgR65Ed9Q0vwc4=;
        b=XxoS6hND0WLrqvVh6y0LFpL4M11Rtcf1lsFjm2OQt82A21EyC//aZ+Yvonhd6RkiBY
         UG18VakMqDvIUyezjSSHhhq3mG472DuGMVKuF8pg29elEqLODAtfN5DOhvEVIpaiq2Cn
         NXzMFpC5bk3Fq7g/2sOv8Ux6Kw/TqeWG0PkurLA96QEupBAJAlilQI7rW5orKIbkziB0
         8CcYXo8cNgr7eAKJjEmZgyceZ4iGOLxgsEfkM5d7F3ghShNZP5wRHNXcH0vvOgmI1sH1
         NliECd0KM7DV46YgFX6GXrYx/kQZwAx/HP8X7FKzY5RlgTxufljzr31PSXmXliBuDoZV
         wWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730923056; x=1731527856;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uN2/M1rXVfxi5HoBRlFEz4UtKAMxhFgR65Ed9Q0vwc4=;
        b=tuQanfrKxlqH6tM2rJh+4noIGzizeTGFxE2RUt0MaXnH/uof39kT0p0I6mNTgIDPM0
         SPdVjXlhrsRmd6F+DD5h7VdXgG1aSEZEdLApXsul8Gwo99arVm/WoPk6KilTFzG7R0Ul
         G1lz1wh3/JRDbHB2e2SiPNq13KNq5vhN4UY5sZWOyC0yMPfmx4TGqufclk8NZiETVAu6
         TvE1+NwcHRWhbLS5t+eP5oXc7i9Al0T/IK4MZvb1Zmvnt54us5x/f6NTEsg3Jh7XFKpJ
         E7D1lzYRcBZVknNy+S86k2gW58Gd9hQntNMWhhnSsBYzMHZTuv45jveFM1bbyMkSV68M
         jVmA==
X-Gm-Message-State: AOJu0YwJDJIQiKVQ7rreqVC78pRIn6vQvUaCbWG8Vxw+Nk9C0Qm/b5VA
	r6/6eDEWOF/SZs4CHsu8wy9rWvPXS1YU8TAIqq4HezmoKDNYYs5rTMqs
X-Google-Smtp-Source: AGHT+IGxIkNO3yEaJX7Uxpn03O/PzXvkwkPxvPK3rwSP5O2/Cru4pBqT9O6t8W/M9FCYWMfUe9si/w==
X-Received: by 2002:a05:620a:1a05:b0:7a9:c24e:4df8 with SMTP id af79cd13be357-7b193f514c1mr5442167785a.44.1730923056433;
        Wed, 06 Nov 2024 11:57:36 -0800 (PST)
Received: from [127.0.0.1] ([40.79.247.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a10bd0sm664376985a.56.2024.11.06.11.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:57:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
References: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
Subject: Re: [PATCH net 0/6] Make TCP-MD5-diag slightly less broken
Message-ID: <2dedfcef-41c0-f487-02aa-229ae143185e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Nov 2024 19:57:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmitry,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/117101=
60691

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/67a329533b43
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D907077


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
