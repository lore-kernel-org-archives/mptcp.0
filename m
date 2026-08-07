Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029F3EE1E0
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095824; cv=none; b=I2Yl5jJ3HdRbeSVbq4kEJr2kKySZtd7+fWqpmWIl4UBbRwe7T8FOC7wq8iUOpYDXPbrAkUxYMc8eM3ClSXI0k40nmwbsv73EQu0KleHsIcLDstCrEj9ov1ZPAUP8gedxC43TtK34K/bI550zWTcsPIBtlYJ87bJ/Jtdnq/mlOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095824; c=relaxed/simple;
	bh=sjc7s6lk2cpL2fiYUigrHisc0v5Jj9sbEBf7z1HOXEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=u0nw4c00Ro4ayKeYvnF1VkB4lJZ8PPKJYgBssji2uoQz8RQb9/RHZxzE+v5CLRYgXxn29kQdIDUYNeOYsNyVSQQS15oCs4hZT9Jqio3xXLv4sQ9fMQNxTdAzyYCXC1AEtkgu0rH14ANtkdzenSpelFvfw+LBE6f0VK6SW6v87bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrObxIuw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrObxIuw"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbb7926836eso2387912a12.3
        for <mptcp@lists.linux.dev>; Fri, 07 Aug 2026 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786095822; x=1786700622; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xg/EUGcMOlgG9299LiUjoRCF4UCKyHI7lj8ZI32UDC4=;
        b=UrObxIuw6PSEKp3/nkMOPIwJUK+sgp1Fb262sDR/SUFAm5lhsamB4YLuuKbsq0ErVW
         K91P9kRv/AM/9FSXOAAR5GxANMDzkm0GqvEoR3r5Ry1AgC6Tv7MlfrTPMRWOnLIdfYlU
         egLWgvRz9Gif/IuCb9BMB6u+DVqkIeGlvRjfWTKcXuoBaT4a986vFZMrBgWkbLqSIO4f
         siba3B/gnPsoJlmJXK9a1fayI5afdioffn9fY586MRNz9Ust9b3dlZqsJQh1Q1T1kVur
         AhHOURe1Fju0HHjq+qh09DufyqZZixu7qL7We6cgS8ocmHYi7UuCYOXcRTCGNcxWKjy6
         qKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786095822; x=1786700622;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xg/EUGcMOlgG9299LiUjoRCF4UCKyHI7lj8ZI32UDC4=;
        b=tH5wQfbIrjc5ty6rkoTmit72KoVYrO2rfI0PIdu/UO9UP7dOaSk8x7fUtUxCVTuaQx
         0EPNY5Jll6nu2O2aXRRB/g+lQe4GRJOLAEIQwD0hPdG7PMLykF1EKjE7Hcxm9p2BZ1rh
         0ON4NIiJlCNZEwMAVyxa5DhHz5bc3zRdGqCKU/a+C203G4vkFxdqRHdJ72xGrMBz4KE5
         rSLJlkGWgq1iYl6QsFuYbGBYqrdm45fKAGhC0AZ2L1tyvky/9TzTJbPFwv2iwDnzE83l
         XQIUmQ9Wu2C6wbBtLboF/fVaedbj8U6Eoraci3qtCQ8/A4VnMVwOWR9oA2GPvkWGCrbR
         aSZA==
X-Gm-Message-State: AOJu0YwRpYxhQnEed32m5YD7fIooQXLSdx0J2krZJL7EARc8iqtYPRUo
	zcnahBHPw+r/sNoWYtQp0M/iHS/xyBsZ0KtjIash0bNkSBbnWOSEZoE=
X-Gm-Gg: AR+sD108bgug0NgyppJ2gF2Q8l3E/YLVx0PWYRv2XLDiGfL9VT0QrBApKCV5wu/V/lT
	B3vKZ+iH+7k4eTI0tHQeHB8IFa4nBaDcC0R0M8oIkMnPBmJgN/EAI6Q3nruZMjjy2Vywjl/uR/v
	bk6/7ElJxcvdpzEsyngdZQgTFnZly8h2rMcolCGHDe+8A1Lt4hzj84rjiAfGw40R9tqEZQO4aAQ
	O8FJ1wqbCPI2VwYZ+TXcUj3s9V4i1D1IyEMX2sFpeR+gToOUAh3fyWSACHnjzdZQzwT9e34GRuq
	StfvTXrG1ZxEEdpW4w+WNku2IRzlHBeXJ5Hvs70yJRdxL6wuxwCss9eG+wxWCJN+3olWljg3OIK
	gJrCuZku+2/DEExuUSgBP6ctJ3FH6bDeLzKMNcMrKqeck3eTp+p8mJuifF2PdqzhAmuPVff8s9Y
	e1KHuiUKiMBls3tD6EcY97haXYXasghflw+lT7IzxGOI0mE4Sl1pxzSo71amCMWyUqszD/s9I=
X-Received: by 2002:a05:6a00:1810:b0:842:6a3b:60d1 with SMTP id d2e1a72fcca58-84f2e07772dmr22311790b3a.31.1786095822459;
        Fri, 07 Aug 2026 02:43:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.1.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f17csm722988b3a.31.2026.08.07.02.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:43:42 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
References:
 <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
Subject: Re: [PATCH mptcp-net v3 0/8] mptcp: pm: userspace: properly deal
 with the ID0 case
Message-ID: <c08fec12-ac93-d808-5538-62e334db10de@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:43:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/311639=
06637

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/91f23e3aba21
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1142037


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
