Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A736450FE
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193987; cv=none; b=kuTzDsKslOBQtaHaDeSOKVG5XmtcCOO1aCwYjaWlp0QJSEpAKmT5LuslTgN+Q4vMDYBERZ4nubXeL1XHU0zStJYJdCZqaoFlvwqdIFFhlIL51nf2zVskktTSG07CFV6eqn0Z4G7pgyWP+WMl4bTpsDURwEilBJ5qGGGkkTrHQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193987; c=relaxed/simple;
	bh=miAR1HIwZRf44SUzloVwbnrifrng+qCiT+sH5NUK0Bo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=uH0kuZ0NDbBnf9zN++RH6xKXA0J2mVn+llAnQmGOKufC/YTlW+r6yp0MzeyZPCqREDfOZg5qblEqdcp2476I9wqrCdJKOagt/+81pR5AHiuxMPSsZvXAfGLy6Mn8VPQuA1ned28MOyI3II5erbe1oE4X+k1uowa8Zi6cOs5SxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSrTZsqQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSrTZsqQ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e32c95775aso560768085a.3
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753193985; x=1753798785; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOwYqqEgD/c4nSITfuQ3XjsjQntv3/LrX9ChS0ncpg0=;
        b=RSrTZsqQmw0NJaO7afXsc+Ob7jVVktOJ2u2oey846lYsKnp5Lv9SwCnmeyCuxrV/7w
         IibEICvLj0A88iSTdzmGd7XF5niUwjqGYLCGvPSsgXfktVxsM86Ww4L0TGDy7S3g0s6X
         W8Oft/7L3FO6eDsQHQu3TaCcADs8lc0G2CRfGhE8guUbCzgFDnKxa85HvCWa1CpH33Jx
         EPgz9sWFYrWle3mG5u/yLaLM1YSAtewLmXPfqHfZDJRG3rUJTk9HfafBvE7qn6tuWEXN
         V0P3B3SWHub4UWuYBOZYABlEdfoaseV/BuRuFXVA01AoYQWWxB9ZlmqFfw48BBYYw/C2
         pDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193985; x=1753798785;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOwYqqEgD/c4nSITfuQ3XjsjQntv3/LrX9ChS0ncpg0=;
        b=Dgxz4EdcU0pdMKJpsIphxMB9masAH51vKYQS7J932j4psjHZilR3Ow2u5FHfQY2gVi
         vTgqI4bPJOR+fb3ncJhLQFTXHBXNfD2alQM+iY7wnRL5F+B/o2D4ru6Am1Du/v7jB3KY
         SHzCMHFTAPLYb4096OyiIEePVezS6xj0CqmDTEivR85+rQhuHOXjVOriumZdx4GXjz5P
         hZDs5BPEKbaATXnzPuLZVM2CSj1+yBgtrqijUPoumbXVe6nwrg/9hVQQBGSxvwqsDfo2
         OyVU7T94wX9o4vspExrJTEh9fKVWtSeyF3SMnWRaFEt3mp+6skjSuZvfXRH1A+WbczWA
         v8ug==
X-Gm-Message-State: AOJu0Yz5FMjDBM1JSL2nuZf3zMUDe9RKn8MHR+hTkvROog+7ezwE1U6v
	vKN+dU/Y09Pt3+bFDx1G42Z4aEw5IeN7MtEmpCiFa7caUOEPc3zD+Pg=
X-Gm-Gg: ASbGncuurLWrJLUBG5RZmjZ+UFzNxfhdN4LdabQyrMRnw4Bj7+IdWFgar1o88/QZsUH
	p8/kJ7QnVucJq0qY0PIPsBja2XLJE2XXxciPEq7MIlUW7vgvtpow8akRl6y4j4udSZI/8phQ9V0
	sxoyz8I7/eitZKmoN7Fgv98h/k4Y4nRiTkBD+9Pk77Cv2Jh0BGDIHeWgq034e35J8TpYs8mcizZ
	qtsDy79qGl9G+wfxdA45EJWRX+JJtqqGP6WjAwK4nZJXd/XW/aLZvQM+qjYKodkAvYPuT9htH3c
	gtQx+bax3c4YkDa8J7SpXQP+mSheMBxk+NE5IjbK+28zCDvP2ZSDmjWAWsdiYSIRlNo32B7QkPp
	MZww/CYZ94ynUFarYoJ6Oj1ZUhWCLHGXy2/OEGA==
X-Google-Smtp-Source: AGHT+IGuhRs3BASVzXjx4t3NVKBsOb118ym6Fok//uk5RebWhWoetTxOruekzITOOs6M+XCKW2WD4A==
X-Received: by 2002:a05:620a:7017:b0:7c5:5fa0:4617 with SMTP id af79cd13be357-7e343615e30mr3197406685a.40.1753193984932;
        Tue, 22 Jul 2025 07:19:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.254.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b514fesm545066285a.40.2025.07.22.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:19:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org>
References:
 <20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: set ADD_ADDR retrans timeout to 1sec
Message-ID: <9acda16b-42c4-3275-610e-2be9482a881a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Jul 2025 14:19:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/16444985243

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c047fd7b01db
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D983523


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
