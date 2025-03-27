Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5679225D7
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743059713; cv=none; b=SdhMs9gDg8Jnf4V2cPl+DkXu2Qg7tc0nzneCcbFnVzjdbQ4Konz2rxzTjNUD0LPF8TI20ZFD9fv6tb6V9PGBk320fBEfCdz7d98sFxPlRT05/vhIJttyEonoeWuWSpO/lYbtPZCcnLlGx4Nl1KWmb5Tf2porgk127+jGP4s6/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743059713; c=relaxed/simple;
	bh=OGfzzKGX03sSBTzCk2kztKzCTZ98FBdpjIwwkejS/P0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cXHgWyz9HTPTj06ywegBY7Xoc2aP+sJWrTyvHYa+kT6COH4bl13bBWxUwAtK7N4jss4okUih0bL6ao5wJbZxXjqvng0BAIV3OE36zvYrSpaXpAnKMa+fFYxedv5BDkiHbUojbAKWkb7lfHNzwgKoYRmJJLoM9/8ObCM8KhSmG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ0yHxrl; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ0yHxrl"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so5486196d6.3
        for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743059711; x=1743664511; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sr349lG/sg5+Sowf1jqzLXGQGr3YgBj9LblK1JWupmE=;
        b=WJ0yHxrlJFyIee3tsr2qg2ZhrveHBnm3OOUaNJM6WZD6jOfUWsyq/S2YrFnW2uNfQS
         me6QKjxRjj9ayNska73SpZHq7NYzTnoH7ARohbtRPbnSZNeq62WLqcU+7upzP1E0vxHf
         E9eT0VbMIzBeCvJPLVg8oqJnuCbL+ReT5M3TAxrpkvw4YHUOyKbnSOs/QZ2iHMVzriM/
         SUcLtDd9o92Toyc1POZrrtwByXKIvkR+35ZoN+R+DRGKalUDwrqf4GPrQiP2kx041KbP
         zO4u2w06JXWiArmzaJzY23MJ31rGyR+3uiHk/wG/1Sbvck/gTKCV76zDcjUF7w5xKycN
         voDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743059711; x=1743664511;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sr349lG/sg5+Sowf1jqzLXGQGr3YgBj9LblK1JWupmE=;
        b=LpNwbJKjDcqqOKxvVpxYwvBH7832bqEXyAMNHnkRLiTDX98BI6kxPB3LqeX9V+9Kqw
         xgE7/S5LOqytC5RyV4sDORyyoP3UKGewDAlZNkfs8fARXXMt0Xi2L7O0U6DHLdTZIWVF
         OAiE18MmAPBPdCFL2ki8iPhnAeSeRoEQQSGkV33X/AuIYBu5FBOB1MSlBOpaIYP55GdM
         Fd84FqEvX4E9pxdpHz3VkznPcye6QZyOp8xcwVUwYkRaFms1PSWVMfIxteP+dA0L4TMz
         5+lm0iOG1Er36gbiIP1BUyFVfIzlN88//9gIezm5Y8iXU8mVCzw47td3nwKxwGOTVXce
         pVhQ==
X-Gm-Message-State: AOJu0YxoFOlObm34zHD2Klh9gfmjyA34+fSwggFWqIcmXN7BuiMYAhmz
	1GlCGHWrZvCV6hrf518Y4mswoDGOmfksDgQnsQVga/wwQKNdjafge+/p
X-Gm-Gg: ASbGnctXtwFFAxWBPS2IOtR6WxLowyAn97WxE1j4Uhz47bZIvC3WyX/FFZRECBzHv9A
	J8xWYEI1LEldxQVJhOXOhrx+pT/PIrUhbMVGx3FA+7utDCZlE7r1QFeejDC9HGvlyuuKgx35u+0
	d2KjzShlELqnoV9Kdvb9jMzba9PMIi7umTSU6d/5lp2L1zz1EVQHrzivyanfBYJixiXeg/hZnhN
	m0T8+JVGSiVM47Hjh2UyAEXzA6vNQjI7M1gvpNeZVIFhuwNvYtfU5/fdavVnX87LDBWPaZ3LB7U
	LWYm4KdnsttjNojI2bzeADAcEVYXTEcZo8d1SKp02sVOopg5baA3hIGc
X-Google-Smtp-Source: AGHT+IFGUBXpM46xQ/kxfnQrf1hbK2lDS32Up4iE5Hvh4KMH4dZv3itX0shmgCykBj1XeDGGXtnhqQ==
X-Received: by 2002:a05:6214:d67:b0:6ed:df6:cdcd with SMTP id 6a1803df08f44-6ed238ad4f9mr31281026d6.21.1743059710489;
        Thu, 27 Mar 2025 00:15:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.71.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3f0005b0sm77260836d6.124.2025.03.27.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 00:15:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1743054942.git.tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/7] BPF path manager, part 6
Message-ID: <26258275-9fa0-389f-6af7-13b689a877bf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Mar 2025 07:15:08 +0000
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
uns/14100178411

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/55c1c9f50291
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D947653


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
