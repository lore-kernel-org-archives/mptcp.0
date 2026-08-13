Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA5474249
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625802; cv=none; b=e0idN7gS3IKwPdeFzigej9NH+kDcrG39ZowAAWfncvVLnWfmDZNYrwzlOO4Pefy5UcnGSHY1tk/e4IW3qVpBq+F4iwxUziFwpVa7Tu3TKGVDzJa1vjunJW+J7fuIYwJVd3TnhqEJRiO7O2cH3hhi2XqWmlSnYeOPd7Va/7y2kn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625802; c=relaxed/simple;
	bh=OhhAGx7uXNklsKBjeb+jPMR2i0t4AIx6E/CaV4vC3Ns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GiQKO4Kamjd2Dr9wBQqztQKm6Zu9moRwRkkTl3WUtvry6Vfn5d4jLUUgttuxZZgyC6kxVuntFnmsJSa9f6LWZ3P1loFXoQAjphUk4+Z2kSQXvkKk/eX+VzNj+BRiwG1Shf5mmwbeEhlJR3+oHI6FfCkFcazqAJqNpkUc5373MIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oq2SxGTh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq2SxGTh"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so2347789b3a.2
        for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786625801; x=1787230601; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7V2yyfoqpyEXW66X8UQvXNOkpSyUAHgG9Gd9+7cSao0=;
        b=oq2SxGThWzNSePhEcA0Z0FuK86UyVqTzJSmnJyLuJ+0iO30DB9UNF6towbqQ7pAfbW
         85oP3Z+IMi9kWwhwFj+pwTvSQBmvflZwgMoa6uJ0BC1c1e45OUDJ86xe4aDnwpPWInBd
         fyPOtaVmD0mi8RW3caCtafThYleax/5aaB8l0eckANtUb4v56AG0gsoY9kgonjixo9vl
         f9AX9UY2Q9PHaBJPNyzNVHC82lHPKQcstLF1XeMgoZ4D0fEdjKIhRFTKBd1JcXqaGnnL
         IIf9kDdPIy0W2NOR+3PKchnoLpwn+b3pQnAZvDsrSacYkyuJw7alMdUeGsA5LWlJGTBW
         EZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625801; x=1787230601;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7V2yyfoqpyEXW66X8UQvXNOkpSyUAHgG9Gd9+7cSao0=;
        b=dCABGN8WmdXGF3pfg1MAl0JUS4atJkL0PODxrjkM8Vvv95NNkm0Ii72WtHvGq9Ojsp
         mQY9n84jrt9AcTQ1gP81bQWedFBwdoQm7vx68aYyIPRpfV4bwoUGyYtrY6+0OhU8rRSL
         H3aFpnpN66xZMRJ94eehmRZxWdZly8sl13ZSzGrHcWQJs6OIN3+Bm/VvZQFA4aylY03N
         x+pphNI5SJHPB5kKWs3VihLw07sVbR2MYpYJS8vdYUDvLAzeeZfbiGDMT6MAB/Uft034
         pwD4tPpaWCW0nezdo/HHcrBflowZf7Ul0uWvYViliRkcMw6TNmLC0GTA7RR/pGySepXk
         8DEQ==
X-Gm-Message-State: AOJu0Yzi72R6qs5iPhlkk5Cge7fdV8saCie3MAOV4h0gK8BcYpTTsDnl
	lssX2FlP6Ev3K6EKq7Pnuu+OkKgWtZHy5Q/P4aLBZhnMsKGl8brfPsdwevV3
X-Gm-Gg: AR+sD12MVgHzJe8RvFIIzcUOtzXocx3H9pkOF/0SxTRBcM7atDrGqI/ceIo41w/fO5j
	wtJsX9gKKIOmv9DFAEf9q4c7wm2tPUvxHGR52/Lgfl900Qz1GJX0qhyGYTcvFWvimLacksuQqfo
	DQ9RRcCBt/aySVKUENyrpqwr6Ht60Oso8PR/v3M0XQCglq8G5GKksvZ1fZ3Ejm35LwLQ/IDhJ1P
	S9LeGKy93xVWnHGJur+9haFifiZMVupIDjRu5TFRorMcqQsdczBE5eHRQTQjOsnsvd6htlWrqPl
	hN+IjbH8l9CPNPmaYOlfifsSUKU4MWvfYiGIvfvjOpggGCnuizlKbex5qPas0FIBs1u75utFl78
	Q9St3O/cELKpABTvnmq4wo2EyyL/8wUa3FdlkMVrgm+L+oRRzIwlNEZIv6w3Cs4byEDxXFMqhyq
	UPmNoLwRjQ7yIb308EmiClQbBcyWJ8uwGJRib4HA974ODC6q8OvTmTilyx5Y4hJY+3uubfVsmCb
	A==
X-Received: by 2002:a05:6a00:2d97:b0:847:8704:1c54 with SMTP id d2e1a72fcca58-84fc75d6d88mr4596969b3a.22.1786625800628;
        Thu, 13 Aug 2026 05:56:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.225.78.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc4563649sm838022b3a.7.2026.08.13.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:56:40 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Akshit Patadiya <akshit@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260813113208.3809139-1-akshit@mpiricsoftware.com>
References: <20260813113208.3809139-1-akshit@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting on
 subflow close
Message-ID: <711fe5ff-f6d9-20d9-e5df-2fed1c0e90f7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 12:56:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Akshit,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/316978=
73897

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/103292437ca7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1145399


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
