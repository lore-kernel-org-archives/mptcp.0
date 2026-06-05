Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AA36C9F0
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627699; cv=none; b=YLUM4j5aM5flk0AAYZKvDN9qMiiI0ZiXaAvseW2G6OQxRA/RfZoBQb9KR2KjUh/9UfnZag9Kfkvxe4KdnMU3eJ8SQjkVz+x/AFjrg/YGHk+yak/R4zAmbDI6MarI4cBtyWSqd0msSlw6oFDlJhHuddj6ozqh2L1cqUrMoHTlvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627699; c=relaxed/simple;
	bh=OdueOsFrXRm8MNykKLqdv6YvuwljlWrl77vhedlqAfA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=dYVaLEH6r1vorm1xTdc6HF/pm4vI0rHgTvB5Dqsr7pdE9kOOv8CxiSWnpzLtjcYpX48reSYo0g0B+38Klt0EwqdnSgwj73b5S07oJaq9jwJOwk9fjqf563swX9t9wz1iylgQZe4BjFG69vib+ECDJuxbDSp4v1KJwFIJZPyjbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqISkNGy; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqISkNGy"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9157f7c1c0eso139367885a.1
        for <mptcp@lists.linux.dev>; Thu, 04 Jun 2026 19:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780627690; x=1781232490; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEXvxzro88BgDn/VpROU+1VGpB7eYwGqKiIpqEjcjP4=;
        b=TqISkNGylOUxpAzeOewzX3odqWyqjoYRyyCxApmq4mYBh5ounA13i3NXaknIS1nAoC
         BjNipEpC45F+4l3IwvjRF44R8U4hXBvtvcD+FAAchhH7i8Tzxz7NLsSArReBc0ib688n
         hIc7uuoKNnjIWXTBY8u/F82fNAzo2SGgkq//ODsDSqqp9UlEtw7OyxTxTQCGKm2r0Q3/
         ENR3/olMuONhyMfTEYEsGz+jc2vF3QPsRVdJCAs/FDya1/LJLhEMhSBYMkYfDjbT09UH
         J/K8FXjv6ou7KIJVS0prdwaYxfMMdAWD3flTTUfERTV7FkffrwyzftpkX59BK69XMBni
         sn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780627690; x=1781232490;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEXvxzro88BgDn/VpROU+1VGpB7eYwGqKiIpqEjcjP4=;
        b=HH5vKXaDRlqAr0DOvH6da9vy/Wi8zXUHqzJz8LyTsu2iA9pIs0z9m7UBTgDMmh8BbY
         IUsh9aWaA37cF1lhlrSbIOrU9mMD0LVubH2scWgXZ5Sgqmxc9cO8Mt2nORfl2MTzE8ZC
         Ls7RoVZQqCQQvdKpSFDRQnnatnmOdd6hrHD1962YOHJo0wxSWOPtkAIbTiQJdgfN2s4h
         D+9nh8soeFCftpzXQX5d7tDjsqT0pD8X2CwTSdx/GKy8/0D8VLwE8C3X/SSHFqzr4eck
         W21M0wdZukgDT7n5HbVLXortzJfeqaQuj+K/3vV/dPB729/UJGI+k3V68937TCtOik6O
         YLqA==
X-Gm-Message-State: AOJu0Yzg9jwJbS1rBq7mfRDszo3vRtThFkpYY1+TZKMO9ZzNeUFroZKW
	At6E6wobbDvNP36mI9H0ZZMa6GdnQlv2Lqy+HfWgPhb/xM0rmH9t83wYzceJ
X-Gm-Gg: Acq92OHaoarhbha9QxvW3C6wDiBpfP6zJ25/qB7ly3yrc6tljfPmmd1XtEcVPqsIurA
	mVoEaQ00hihiu1NZisqD1sRLn+jcm0aW73uS9C6oDbaT0/hglDpUhLUIzXh0kbYktftQ4649/eD
	o4l9HhcHZiF1fmCW2DcUVr/7+X/p9RwVPFpYDTMqj48DPdQK1WtoHmJE60AaSU77yjEhSzpu0bS
	Xt+HS7MUG1zeBNWZXbuhruryWZqXWFgzvLWJlTUgvtNK7ULLLn22dyqH8HrDElgqnx7zAgeVXEg
	ItmPQM1CVC0jOeQNtGv/A+Jfh3My+EhQaLfZSZ+Qym6D6gS6Up6wThiRZPmDl3y/PjgUZwhIofv
	ZhOK7zhZe3m40oxnI37syDFJbwtSskLswH/tv9ReJnbsCPpagqEtr8MdDjPJw/CF5UETQBdTIhL
	82mPE3OZiAtoQl2XjiLEtRA7OqOLbYK3tLCp1RflLiHnJsypQ=
X-Received: by 2002:a05:620a:254a:b0:915:6758:24d8 with SMTP id af79cd13be357-915a9dea2b0mr350720785a.42.1780627690293;
        Thu, 04 Jun 2026 19:48:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.91.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d250dsm761027485a.38.2026.06.04.19.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 19:48:09 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v24 00/18] MPTCP KTLS support
Message-ID: <94b59e63-5545-094e-6ed8-ef048344809c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 02:48:09 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/269902=
00448

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d313aac2bb3e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1106279


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
