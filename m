Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97581350A35
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949354; cv=none; b=ehHVa7vSShiinsZWWnOuZzp3y+3wG+VsYCfhsHoo0rhOy/S0JYrtvkoMgdfgsjRRSwHEpe/CaqGtkwfrH1rX0eBVqGymbdJw+0TDmsZPV3Z4dsyj8tLg8u+qqzF+piUkZRTSzbBlviRlZrnKiK6Zazi5JsGFATopKZDmdC9qnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949354; c=relaxed/simple;
	bh=LU269jz9Kh8ecQoqK3XOMrQMn7K0Upmcp1g5DkYotOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=CzHDJ0bnCcN5V9phJHPl2ru4U0yTF15fs1nT0hPg/vsq0lidRzZ2cpqO6xoIDq4kKhcRIdRqAz9B/u5rd63yhApgWJ2cp8ikkfuu3CeiJMd3ofsBGEjSzFO7S59/DZAc2+ZeH4exl2jU/FpSqCZqcTrSRfMi1Vt/Y+SwULUPo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haHe1C2V; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haHe1C2V"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5c9211d2so97075785a.1
        for <mptcp@lists.linux.dev>; Wed, 05 Aug 2026 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785949352; x=1786554152; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TMPblJDqvJNE6FutexnM3HF4de4T1h2BdhwB2F10WK8=;
        b=haHe1C2VSwxSMVqDELxV3CWdKc3280I65M+TmjBE4RfFTF3bbGbXZDU/wqAz8wMgMP
         yaFc2P/gAXLUrQ4XnpmXbZkU4I8KC0M4rGjS1v/ojIPyBGScmSVb4Bvas+CxowET5Ily
         hji+PioP+w7ZHN5P7q1hQh220Hds+cSzjx+zt+2zfwL+LMCVkCdfWxG9GcCO/2erJanN
         IkvVhIVPL3jg9vvJm/5J02obwDhl/O6LcdmxdO+X9G4rsPKimklKyWhKm3KDurlLty0l
         XFWqI+m4GT4k827Uv9cWWac1mM6GuQMbug6CcvzEJ9KR8EHy8XQ0ppiPxcesRYo6oA3i
         UjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785949352; x=1786554152;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMPblJDqvJNE6FutexnM3HF4de4T1h2BdhwB2F10WK8=;
        b=nscTjKmoWyJ3Dz8DRKF3fKUVQ7VcIFIuA9EaXd/wJf54N+ZJ7K6kgK4EXg8x+4MRU/
         O8tFgMWTzaJl6wXt7tuMlJnGlJ/10wy5xb9PX5acZYpJIhSET8c846SRET3ickRYs95G
         xlBXZ/Mb5+AimguKqVIUvbMcZuWnbS1OTFhj6kCxkwqUe6seXKoQz/T2LW1Nea3pHzJi
         aheHOvxQj1U8/TZPIC2nYE5ZsbbsOtd0ub7hAamfMDgh9LX6TGwuabrAU/MwdHlHHIkZ
         cqAo+XjWX1NCoCFrxz/mL6aKrDInGj0fAeqZqZlF7GNNXmAXnFLg4BVaV+NAu169qLKE
         QoaQ==
X-Gm-Message-State: AOJu0YyNG+18y4rYfBvjY/i5naxrrmSeeVrFKXVP4fEHo3QwDJ4HTc8L
	U7Toaj1KZDO/eenzBHInf+oE+qgaiWmzZO2MGSPwLCfX338JMmEzYty1G34I
X-Gm-Gg: AR+sD13ys+YtFSPWHHy9xIEPqujK1XZ9pJd049aI2G42vg3t+HPuzScleSt/wYFCPP6
	GuGRo+xfiSYUx/gBYbD2fUAajEKltuFxcntnTGCOOWee0u0UZyKZMIcskYc4BjcgplRXN9CtejZ
	v7iIkXqKP8akZOtHj9VVxIm685DdEjx3Lmtb2OikOgKf4ARh5Pqn7PFfOOXtz4fsJ8OEK8Chc94
	t7kBzVhc3BhRIbPflFTR9mBZLG1j2T5u5GnHOTkEo5CJBwz3twti9dojKSjvLokOilzjwkoafoh
	XXHeIrhKS3IYaTacPWbTny3IdvbMH017qe5lq4ldXlE3lhopuFoxeVGLpYCmsnqu7oLmCzUZO2r
	YibsICqzqwgRED0tGhkVgvZOIIuJZcPB6hzLtcpSqGW/zkRNLclxEVRETiDx1XyMkvsB4RkhZxF
	kjV3HNWs4VlAunYJNIstLix+6YFC15i0ly5neZb9jsiDX4zng6ZGo+B2O7+zr2mmFk3nJRX9LNe
	Xo=
X-Received: by 2002:a05:620a:a494:b0:930:f735:1377 with SMTP id af79cd13be357-93649097cf0mr707136985a.19.1785949352214;
        Wed, 05 Aug 2026 10:02:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.203.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a42a461sm191031685a.12.2026.08.05.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:02:31 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260805-mptcp-opt-mpc-csumreqd-no-csum-v2-1-dbb52e01a36d@kernel.org>
References:
 <20260805-mptcp-opt-mpc-csumreqd-no-csum-v2-1-dbb52e01a36d@kernel.org>
Subject: Re: [PATCH mptcp-net v2] mptcp: options: handle MPC data + csum
 reqd + no csum
Message-ID: <6a48e793-9cc3-bbf6-f531-97f4e06bef5c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 17:02:31 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/310224=
52135

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a564af426f38
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1140877


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
