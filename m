Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AE35DA75
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058843; cv=none; b=CpsqZtDuOjF8gFvdKzGlw3trkWlKXBKSacUoYtZs4lmqcsb66crYEYRt0YUEIAHEnMiUoldvYX01kZ7AZMDEjZW0adt+5RratJR+GhEb28bvdHdqZ2vQHOxy3Yo8ijdzUZPDxOmOaa9+x8e267pCJQNv3lclkgEkIG8T5c6/cLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058843; c=relaxed/simple;
	bh=7mskTTOuQwRlapnyKslHUWukDELbmn2cpwUvdIkv/g4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IW/uZluLJaiNCBqMbHw2UvC7EVFYPlcHEEuuz/G06r3Ke1FVLk0asbtKW9TPRKSb2xkUQ9kBzc2wzcMFqhf9FATnoMwcNmlrpib9E7Su3c1fRbsZydpYrzFm2UZkb8SbiqgzXF/9XJmMr3dbfGtT/MPFrDnPKDsLLZ13kXSMRbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af8uZFzv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af8uZFzv"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca80d708489so1180988a12.1
        for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785058842; x=1785663642; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/6Vl6ogiMO3Y/SOj1n2MfCuZmRATGaDUtO86rnUuRgo=;
        b=Af8uZFzvxCc1QbMOZa+W44gZDyC0K+xegV3JUNFqouGkWSSiurnmxx3YZM3j39mKA3
         34+ZclyVg8j9Mjry7MwZagDJ8AuETdfJKQW7lDGaBPCw+NtyeqVcvGNcjgj+Wgr0ghhe
         rkkIOSXllCPHXsnjWyCk5fF8zxbx4kkIxeMjGmQjfp0g7Chc9pA+vesQUoipY4GLClag
         9owJRBX5QhK+mggT1ODOxtGTF6BXTQ8RwqCm6UcBJA5/jLMZKJg80bPN3fwfm4BLHHR3
         ZTofk/bD4tABUJjfQnxi2gRveftQMOYxrXCrHMtcDPbSxXj7gqeX3rZmFHOamUWRtKFi
         WntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785058842; x=1785663642;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6Vl6ogiMO3Y/SOj1n2MfCuZmRATGaDUtO86rnUuRgo=;
        b=CnUzKx9/rd9i998luMuZz9jAqVkG25yVtbYtzRhbDAUnVLYDD0egD6Z38a9kf3h17x
         cEFbPcm0/ueFDW76ypGbVZj0e6XszKyDJC6ROLMykEbxgi0H/93apIEM1nEsEjrOZWrb
         Wn6B29Fly/FVVKDarLa0lgyjeEC5aCeyLWQUfPnWE7L5vDFCZwnmxIFaiH96D2bSv9XU
         bwapVULdOYff0Wlig9qT63VTICHM5FZb+vUB+FQJhjKQB1WEvUref8s7E29Gu28YH6oY
         krbfDCmdGkKqoXzFwmmwEl+Uw0qsreqWqaNHU7wTTWjkX9CgH4DTio6WyHO8gIt9MagO
         2SZQ==
X-Gm-Message-State: AOJu0YzMmTT1YlcLRx3My7GUTB/q+A9DK5ZJNdKdy94f9DXLDOlq4u+b
	iE0tBQ1QHrpUiwkIpWzbXjnCDKYyAMnOr3hIAT8HgyqyQfD4d9xbUXavvleR
X-Gm-Gg: AR+sD11AXQN50oZev13JrLJcTfinhG9nv3L/FGFwL+zH2Z4S53vkiAA++knw35pqdhz
	gGciy7TKm8Uk7IuhIiNPxs1ZB6DJqGhH2zyUauzaREZFE/VfcsPykIAiaKpLXI0nwkbVATj1m0t
	na1042474ihJ4lT0OqxmfYu1oIMggor2ZwzVqguCJHZNUaKcgyI9vA4zh7ZiMrJ++vU/CBVfdtO
	0PIBVFRjNS952zQ1JmKoKUgOvsWvMah84LWtTT0eHtHBRitsp4dTJcUevWm54Emx7kH5xDxt6Pg
	Fgut5LBzq1Pc7A3DVph0ZOp81LepRYrPixg0RnXlKDrSoNKZ/4raWGqH2oDGe8Q4uB0p8W1RPhz
	2hzyecVg5pn8E6xCubGJYuKMP0Unp7Hq8afc4wEfm7IQG7ICYTG4E0HyIdWcp6diVdAuR6169pY
	dBhJhG5HpunxHjzJxkdg==
X-Received: by 2002:a05:6a20:7349:b0:3bf:aa54:4cbc with SMTP id adf61e73a8af0-3c67267fbe1mr6277860637.26.1785058841764;
        Sun, 26 Jul 2026 02:40:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm15018138c88.8.2026.07.26.02.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:40:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1785054129.git.tanggeliang@kylinos.cn>
References: <cover.1785054129.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v13 00/12] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <6eb1dc9d-3306-5f12-d42d-e447acf734ff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 09:40:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/301952=
03951

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f69067f3be5d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1134601


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
