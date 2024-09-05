Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D6757FC
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547941; cv=none; b=H8NQPPyP0Tb0pIae0MzJKNfdGaR6bZsUzUtgIcZi1XXnUNitvfGcUSif0A/Ck/LMFbDy9pBa1t3xW8T+0wt+VzLMxwIeRRKIBVNwD+C5gjltNW93JqnJMZLxq/U1bhL/Eg9frrS/2qFcyzT5bjpdnBeeMjiFY9wrPiZ9kM8WufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547941; c=relaxed/simple;
	bh=9Kl1m8VlA8dRGngmBasirsmse+Rpb2fcJy6tB81ldJs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HvuU4j/HhEWYbIFQShqbq3Jyr/lYPMS83Q5M9gIyz3fH3if2dDEo7/TonXNKhbbbIJAh8YT+z30y+2DdWC37JLYQf2GVZJ3XbTSgRIn95O+tOxXVXURTyLIG14TikGatXjRplYog2q8t7posOPP/DiZWv5oFfxj6v1bzoroqRdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6CIIfOR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6CIIfOR"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d87176316eso1529590a91.0
        for <mptcp@lists.linux.dev>; Thu, 05 Sep 2024 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547939; x=1726152739; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0tGtv9WLFfeZi5XPbJ3oif5Ck3QNrC43yYVTInQLyo=;
        b=F6CIIfORICZzAMRZP/sz96sfnyXz6O2qY6SguK4b2zUJuFKsx0xM4RzB2EtI+4Q2vX
         b8dBxYdS3+CpokkszeTM3D+Yu7nIr13icOdYhr5B5pBvoswvVPal6EG6Q1dPWMamV330
         lEPSbNO20mW5rEnAFFajrLxATsa+6c2VP42FERglf/DrjutptsOM4qH/S+onbt3VsIIi
         8OHpqE3LcShwgaRzw4cdjsQos9n3LdV7Bl/Pgxfm3jFL7n2NP2UC7Ioez+9KdALo/0H7
         G8lTXjA/fFDSjdixllDgP3i0tXxk2+s7CtBTH++yTeInNEWLZC1QdXTSKZvByGtfbnhJ
         7FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547939; x=1726152739;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0tGtv9WLFfeZi5XPbJ3oif5Ck3QNrC43yYVTInQLyo=;
        b=c/+eSO85NEw0J+wn7JjZaM1qNY6XospGHvdi+1PdqOm8D2mRWdlc0nxnhllIXTHEUN
         9kJ1pP6ES1Re2ZU1N2+Fzph8+x6QTB9LIXv1TIkFTfDPSKEV6qp0ouD0Qc68omBcz7WB
         zpMTKFhfK3UtPxUoEXfdffigEH5R0oriPFoMV1ZwmEnzNqqezOZ2XJF8KT9KriLk3B5l
         QWwIlRVpV9B405POcEgnUTgwxPRWINC+Fs7prJdTnSYapXE6zVWtDIMY7W5lOx4PDJEh
         qCqBWHNAwzdbbiEvZdFAnY3OnMQeVGL67C/t6XAZ3S21m1YmfkXKA792zDO13AMqDLVS
         xC0w==
X-Gm-Message-State: AOJu0Yy700ViYYL3gydsRm5geH2d4WiyzVbcLhtRbwFZdOOoT/gEC7Wm
	9k7pAnSf4GBfqOs1v6/yqDS/aGA3HtMkVLX30t+/soB5Fr/obYU=
X-Google-Smtp-Source: AGHT+IHMurjB9A3/qkZDgE4ub1sQ/VYphQ9mVAJB9fOUTaLgHmNNaDgd1zEy3FTZWFjthETrNX7qHw==
X-Received: by 2002:a17:90b:4ac7:b0:2d8:3f7a:edf2 with SMTP id 98e67ed59e1d1-2da8ede7effmr9714312a91.12.1725547939017;
        Thu, 05 Sep 2024 07:52:19 -0700 (PDT)
Received: from [127.0.0.1] ([52.225.77.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8f308b8ffsm7873003a91.4.2024.09.05.07.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:52:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
References: <tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
Subject: Re: [PATCH net v3] mptcp: pm: Fix uaf in __timer_delete_sync
Message-ID: <251407af-794a-589f-a627-82af7b5ea413@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Sep 2024 14:52:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Edward,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): mptcp_connect_mmap =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/107219=
99077

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b6a976b908cd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D887227


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
