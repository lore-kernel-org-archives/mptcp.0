Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B0345755
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435227; cv=none; b=qBQnCaeWU0+21bdw4F3854GTNpJg5Xl+NLTZ/HE2oxZASC9yIFSaC4mHaii8wvNUD6Oz9ZQKQZHFIQFH0Y629OGJdnvs/Hd05x2XNL+F6YUtm0mxiQAjoP6wJN2Z1au1/n+A4QHoxNxON7cW1WOaToqYwnxXsorQZYdymfDGnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435227; c=relaxed/simple;
	bh=KKf0U3xZ2WXVJnvtNdL8oZsbqb9YfWmCRj1bertRTDQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KI5WBLAaVF5fv1md0JHEUv380g1QkEY6xJo+sQ8c1vI9mGN51tDs3nMzsQjKYnkOQS/akdmxdOx9V/+AY9lcUFlskYXiyxaGadgy7zWAURcfIxZIlImIGVDte/PqUyBkrnjixCfD8sMbYsMXJmbt70BY63K1B5GNWf6CCPl3xJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiJzLFWo; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiJzLFWo"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-81076e81aabso441931585a.3
        for <mptcp@lists.linux.dev>; Tue, 09 Sep 2025 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757435225; x=1758040025; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK4eD3rdODEBam2CyfGnkFc0vwm83bjL8UViTnM5my4=;
        b=YiJzLFWoqKWlmRsYTAJ8jDeh0S98okCb9NuBwOjdfbSmvJErxC+i3olxypcukMt81d
         RnnFAbeETcz42lBrBld2LXgjpYdzHAzfX36k4bvP3FOezWuy/qXB7+vQy6UXmWGKEqrS
         AG03/vE9KeCKIqSC2CBhn6dADBIPyPjWyN+xRxhZBMvg+xKQLnw7Jh6I5ZVnIzGvOR7k
         FTj6mMXK/oKPjBhlHJhiQWQdP4HoB129KFerhqMmu3ShS6DUbWr50Lajvg6HGUXxQ7/6
         QL9WSYluDCz4kl2kMfRnHYLq5vZ9lOEgg7D7ff6bkr3/qvoU48TKghh+BBA/Z5VaGo9h
         JmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435225; x=1758040025;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LK4eD3rdODEBam2CyfGnkFc0vwm83bjL8UViTnM5my4=;
        b=hoQpUIQV6xYHdu6L85PtLqNi64g/JuESiZf3WEF16HeGTn9WNFA+9wrmd7FJC4ITh+
         NFoH5TcJcIcqmrm3EVbLluS1dJD5mcHVHyCiUivVL2MUDioF8Ibo5t33hla/Q3z+CP9A
         LNd1UaO/VGrIV3amlJg6U4loJbUjB2vDHRroH+1epHqfPMAfIeHsMJk63oQv4JPIIoy2
         KGd3puw7XHZr67ljV8qZ2wKp9Mas9XJlS4ggdf8udSLfQu0Ffk9FlFELomoAUSwkz22m
         NI7RTnDIZ4A3xBWzYHSRiFJ3GnCatlKGRVU+Mhqc8B18GhO9RDYmCLy/KagMkoJu4mS8
         f/PA==
X-Gm-Message-State: AOJu0Yzy68Rp+YGC1A+/5RjIMn9cyZ6fYirssGvGlsRcMwAccfn91P5B
	PiGUczVm5HOYA47dghllW4Gp8Iv6Sh1jJuSmrC8R8PzgdCviEYHhlJjFIRaI
X-Gm-Gg: ASbGncs2pJJBIy6lWLnmwCbdBZbU9rtBPRY9xujInxscJG3fevik93ODPKJIm2m+37X
	9iOKK8UEgpVyHQcUMCKziDq8vJ/cfcNNJPhqYl4mjX586U6mlYtYZMKOTN/ZHw9oEPE8DEX1i8g
	FccPrIo+2XQsYfmDfvqGwZ/OA7YShpz8rG93c6yp+fEC9nvJ1t5xI3+LZIMXYZZomtI37c6paR7
	9tBiWadPZo8Ri/FJLoy+97AoaK+QLbN9/TMjdS4qkjnXnl6nfPgTJQUbXqKxNNSmgmF9lvzEKvb
	wQIcvkLf4dKtdDVblr6LQJcc1wgRLZE0iHJBivzu7kDq1y6hu8ITvzHc7Z/IIXWPaa1bCTDqHmp
	nVyW8BP6qqqUNqUvcDqYiac+wjyjkYQ7qOcSFjKkldIrMMJk=
X-Google-Smtp-Source: AGHT+IGxqtRqsNW0sj5EkN4XAvtxuwEya8YNAd+lFoKz4EbULyOIqYZ7o9lcOxCKLZClNcRvBhE8Mg==
X-Received: by 2002:a05:620a:4048:b0:7e8:38f2:1128 with SMTP id af79cd13be357-813c1c9cc04mr1479919585a.54.1757435224648;
        Tue, 09 Sep 2025 09:27:04 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.239.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720add668bdsm140828776d6.33.2025.09.09.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:27:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
References: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/5] mptcp: pm: nl: announce deny-join-id0
 attribute
Message-ID: <99fe5173-d03c-9428-ff35-864e2876665b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Sep 2025 16:27:03 +0000
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
Critical: KMemLeak =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/17586663636

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/94bc72bd6390
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1000542


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
