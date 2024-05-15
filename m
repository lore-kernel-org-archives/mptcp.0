Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168C39FD7
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797938; cv=none; b=oaCFHTJMNtSF7sR2J/XE5ApGG9l3OU9K0cw1DhChks0tcN4ydrhGIdeopbYaNN8RWPiD75m8HXQ2oQ159y1QaJ7DAYwN5s1XfPFijMwQ7KHfO2wK/8yyyIYbqjJM3Tv699CVRoWUmAoCrwJw9nw18EZbiCyWplKLhuV2urnbhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797938; c=relaxed/simple;
	bh=zyMDd4Qsti8OSFlRyxOoM0VvBu0eVWnJYo71I1uAplA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=olRKbAgVe7Mb0VJwqO+BrDhJXL5+u4TvirhboxdmkIXAMSYJGVXV+rtilquFnyM0HjHmAlxzm3R6VRiPL0Jhgp4s7GoPR7+5wXBkOImJW5SXJzQjoPyRs5FJFuP3Kybrqtq9kaCT+xXOLwcw87KiX6xMESmWJ4LRbX/WfdRQ1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brGHPf5E; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brGHPf5E"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792c7704e09so517060685a.1
        for <mptcp@lists.linux.dev>; Wed, 15 May 2024 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715797936; x=1716402736; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90TMquFPSShscrP0T9qI3SrIcW+G2D6yjh6Z6GW+/mM=;
        b=brGHPf5EikxMzDZB1QPwv7I6AkdTY6SxRf/op/Y/1cswRUxRXndTMl9gE+W+qP93Nh
         5oAC4v8FChzOBgvyjjFtWvbS9BUDfGM/SEoAJfKstjvGs9gv/hlWPPd307X1mO/6JlWF
         TqH3l7YEGfobxtpef/kwNY+lIzPrWV0DSuJGw1ooBBVDuNLWjdYFwlDi8iQ2Ocr/eEmI
         7ewnIBrn0uISs78zyXlNAT8kWc4GZr1mb3v9LOoBAKEPVsEbjWRuDF6tDtGHomuEVE8V
         2PuON8/CbjAJlVxaNpGWADYgRmwZPg1wsZlvN7pjRrxK1Mjj7ythoGzwwLQ2CiMFF5jL
         22Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715797936; x=1716402736;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=90TMquFPSShscrP0T9qI3SrIcW+G2D6yjh6Z6GW+/mM=;
        b=dg64Sh7uZ0h8nsH7u0qPNYs/byBL0LWnoepNBMTA/bAzLX4qpATdx1FIoAbaW+aYJe
         5vWSi3aSYWUKKhe+gBgq08W/mkxF0fEfV4pN2qhKM/ZlEXujKS42Lindi+IOcX9G/aQP
         lTpBhHfOIP1hVMmBosgFebjTwq4uQKJWkm2W56IXZQDiuUkQygmx+VE8/5lUugsJMxqJ
         4rxvY0ppN/x92EOH285FJYKQnGF1Hn1Db+6gkX7nq858bvxCJTYGHTECC136HDtgIXtP
         2rN85BfyqC3IdzN0bkAY8PvTkxQZ1JZ+fWkL1YYUPOdKQzz0Z698Z5GAJIdFjGodGPcN
         7YUw==
X-Gm-Message-State: AOJu0YxITcf0/r5pu0YU9LyUB5kdPZ+4eBf/RjCxLdOzqZ2RVG+KPWv0
	yXCbzbQZZ8MVz4LU+TDkswWDVHbyuxrHgjG9MeYBWfRhWomT9iU=
X-Google-Smtp-Source: AGHT+IG4BAmvoTCp45nt4wKkizpxx8P3CZUmbiLbEm6ScQO8GzXk0zPzitvaZByQy24LFD1xERhvDA==
X-Received: by 2002:a05:6214:110d:b0:6a0:deb6:7b0f with SMTP id 6a1803df08f44-6a15cc96ce2mr315495626d6.29.1715797936008;
        Wed, 15 May 2024 11:32:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.199.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f17a3d6sm67028556d6.18.2024.05.15.11.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:32:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <829272fc031f542c7a3d8e446eba19ee0f78dffb.1715794371.git.dcaratti@redhat.com>
References:
 <829272fc031f542c7a3d8e446eba19ee0f78dffb.1715794371.git.dcaratti@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: refer to 'MPTCP' socket in comments
Message-ID: <03d99d0e-6ea3-ec4e-83b1-2ec7cd36398a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 May 2024 18:32:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_mp_join =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/910044=
7151

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d54e41ea6585
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D853479


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
