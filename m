Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F3310652
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348773; cv=none; b=P0URPPNdkihQjKwN7TYebGYZN1KZdH72OHGT160HzgUOUiGHEIWwIvG65Tddhq6OijgfNoVrJMzHlCxIf32+9E+F0FD9MORmpPYVT0WG3Hy1/Ot1KV/GjFAw4IIjo9U+PL7d6NZLuUJCyDXYfZv3b8+oNN3Y2f9zatkBNBwk2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348773; c=relaxed/simple;
	bh=+83FYdyoEduc3Gz5fp89SZvEdsUn6bcdSU1l8SjogXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=r/G1pl4UBV9PnVzxm44ydz4/lUHZ+ZhqfPQpvlckh764Bnk71gN1+nuNKPjpJnUXMAL9NWdnswVSOEurAPnU7qGaqJnbaXo+1Qg0/fHM+RG4B3N9pOEw/x92UbiyXwzP8dLXuwrhvk9+SihzAgpN0ryQRKSVsAvRWCo24uf69xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMBdVssT; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMBdVssT"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-46f53c8a5fbso211893fac.2
        for <mptcp@lists.linux.dev>; Wed, 02 Sep 2026 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788348770; x=1788953570; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ST2I61W8pXJ3KWvV3TO3W148XT6GNZ7E+DYw2AQGPsk=;
        b=iMBdVssThZikdI8R0ppkCHK0ehk+h3R/4tCtHqh5oA7ieKTAzbPt+xBd2xbYwWIUpm
         2u4avaozhxzzNkXipcI54Pk86C0sQVl9HlRPTDyjvZm3t8bfAU/NuCrtxyxMVAz4wKFw
         QJ6p8a8S1XJAJW6r3mo8YA/cDerh51AufdpZuRSDGPUoDqSQe87LlsAYNAoPDc5W/FeL
         xC0ijwxaiWY0wFcPXiYNRHsCeP4lxC8P3tAhmxmWYQ4TZvywr/jkJMOO0rGWxJL7SoHp
         VMbg3i4BZ7yB3S6ePMgTVSHQB5ILJNLYqWtsAcFFjjxx080UvwFbY+Qrbcz3gFdvXdNc
         aKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348770; x=1788953570;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ST2I61W8pXJ3KWvV3TO3W148XT6GNZ7E+DYw2AQGPsk=;
        b=h90SuLKnW+BCr63A8nfdcxxtQz2OAqZlYtnq3c65pTJnEnyqQvPYSPerJgWF/FKu7+
         oYMHJXVGxtVIVXA7LUQtb++hFkHkTJsYOcAiXEdPIZRO7dOZPpE04SLrV+yAuw5Rw4zG
         rFHAus0som7TTbMT6ylccap1+sF5RqW3u5hFJ/8untUg3xGZ3hSg+80H2cJdFAGdnrAd
         oMoISebTRUZ6XFJzxO4DH3mLyfnLESKeShRbQoraiF7uHhG18GWo2D5FMgO+lMOr0795
         boDZpWD0x4CnDrrz5dzO+Fal9OldFvmOq0owIGa2T0vIDIKTy1n5EhrjHHuMUZEwcwfe
         Z4Ng==
X-Gm-Message-State: AFuF++mbmAPk6Q7hM7LwBEYIcbXyjm1Qq65F32hBAOY5LYtmefB7f9ys
	R7nOOqkE18AUJ6KscreO3uxTVlNGz6UNMz/z3leRV4DlrcGdKJGl8mhbdU88
X-Gm-Gg: AYBFou2mnwaRUvz2IhajqIkB3nKU0KGH5Hh0UBqEgVGoAea7kdQAw5QeyB9S7tBbvPA
	MAInm0Ed7F9ll5YhD85EswR8HtqRXJxzX5q5LhGmN2W0ZOVwMdoSEw7Z3p/YRVdgfbR6/hJwG5b
	Jc56tGbdUmgtqztg90wny+DyXaY/F4taflri8NmxwhE9zyHsxS8dcjBgrS3x0FGbyrfSwpoAAEc
	Y/cTEQ4YYYpScOEQMcK4x53j5nXVCnAod0g/9/adUUge3mUmIgmfsBJAJqbEucaZCEZahAAE74H
	Icbc3ULWIcCKIjArKm2iwvKSMzOPNeakhNC1Oyvrs2bofeqihYhaOsgXwa7UGeh/uakhd9ofgMz
	8K5a6HAzH0hyyYs81RtYI1VIoXTSeqlhxO4W4r17PF3YNsbrT7XA3Jg7nmGxVeI+aJHh+OjKYA+
	HAGmrRrJGGcG5WohhtVcU91m519SEwIG0i7GBxQmIHTh6Q9kda05VPNVgLAhoMt9CILH280fzi
X-Received: by 2002:a05:6870:8242:b0:455:e6ea:bd8f with SMTP id 586e51a60fabf-46f88408032mr3380244fac.16.1788348770475;
        Wed, 02 Sep 2026 04:32:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.29.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f3046b2absm3438428fac.1.2026.09.02.04.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:32:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260902102125.2035540-1-kalpan.jani@mpiricsoftware.com>
References: <20260902102125.2035540-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v3] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <86e3a365-1dfd-6b84-7742-807a98e20907@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:32:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33621202423

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a9bc776c7de0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1156037


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
