Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5118A93F
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784987238; cv=none; b=mQZheIdsYWXOnnUJKC/4DKAx0Zk0Le+FRr/RzuqstU4PS50PowWfKSxyl1SB9JRB73o6IY47npvsxhvGOYOYwpql0lXvV4VNlpZGykGC6zlH4F7k/MnLUEvTbNeV68rmUFB8gNxNfadGA+xBGSVv0QMTjtVK8z5ygTA3YaLdddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784987238; c=relaxed/simple;
	bh=Niw1Foau7Hd+cFG6aW2AE46IaGKW+fVRSk/LSqyVcsw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=rFyIrakAL8BR7DI8JPdOGr2pP+e1TDzApMVAGaUN5Mdy7E1p3/smV+tO/7q0OOfhmjN9tl1p0BopJ4X9vaiVXi73h7WZ9WQlXcKVbolGPHd8jOAMB3MzFotJc8a1LmQN5xgWThgvnMm6Um5Dk5GHsJxUvTXZedMTsRAI5ZSqtQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=It8orn7Y; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It8orn7Y"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f618435cso123438885a.3
        for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784987236; x=1785592036; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WwStBPAOxl5k4YUw1RSTUKA48BRWkE1J93cBV5CLnHE=;
        b=It8orn7YyoYbNABF2cbFAOgGeg+e+FiDwFlEFmAXgAuvFRreJ5Rl83Q/wfLzxI6Jwr
         T+MZvAFS2L2WQHIUlH3mUgUbvNmU6CPu5zyZ5bUvKnqbXBBnf1UI6YYYGm+wZG3B5Z/T
         Yw4ur1/5LJysE2IJxuHcVpRd50UOZJrb2ikhDklycjSkFpik+2UDcDeGr6zR3KE6PWzv
         DOGsOOLjvlQAscplb9SARtWHYKINMje0YTEHTesNhHBc0XMOUSDaLtAiYv88o4uXiDdV
         /1YclbA2Cox9yV1zQSvY/0JAGFhduM6pL7MGYhuS8rQxCp7FdHOXf5ASDgc1hfV8Ikg3
         9glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784987236; x=1785592036;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WwStBPAOxl5k4YUw1RSTUKA48BRWkE1J93cBV5CLnHE=;
        b=VmDzqmeI/gCCUUKBmCUJ5ghF77nGiU9lSHRM9KD0YVOUFhJ3NqKpkUohL4BEQ4Dg1R
         AV0hHLpG/QU/cyUVM1LWu2/PLRdQYd8Wn2Pc9DDM8LPFztxCNADLjWrOSvFmmXEqlQqJ
         CO2udxhOZLwJnKoz2P9Dvu+BzJlZvuxB34/9nCfpvCvYWDk+EHkpkloZjngV7lHvVgIQ
         I17qzB68+SA4sjgZZHGk4Wdsmt56ZXqFBkdcDgyYpD9cOHQYHFDDMXXzj7WpvSnF24Ho
         6QIzh14DBsvsZj5hkYb3cp5OmmvyPEiDfG/IEsw+UtAkGK2oKDPwsw3NDMig8TybFAll
         03Jg==
X-Gm-Message-State: AOJu0YyAp8i+khAz84jSiPy4SL5WMDm3nyY0tnAIMwCO/NgSMm5EEkV7
	BVU+D+CLeGCY6e+9O9ZaaON/8UBgVdjSQZgfA0LIHVce5FJhVP+QFOiZdNcf
X-Gm-Gg: AR+sD12hDLoA79Wf8BjLwJ5K+Dh36gTLAP0/CML1C8DnibCJku69VTZsVAnvJL98gN/
	QZDRCwzd9SiRgKSAlw1p9CHO8KJpXo2iLUXWv1Lb0iXdoPKb/DzLxYsfB7ZauIKhkkxUXQv+qsg
	HW5hBOl+Lp5cdv8HCQwuqPpp94smjBnkCY8f+WcRlfOxAyUvGnlxQWohnmckFXGaGDN0nwGXOEK
	SfhWySZXHYmxsBhgQHpq6q3GnTT2Yifv0NT0+DnLkzBrXWZG2cPHsCDGLMiAtwk4SHdF5CRVrNe
	S8+/3J3sSi83EqX5LgAg53fuGCCKJAnUTFWfC7v90lPQxOxdiOJHW6OGvr+N8rnbuS2p/zkj1ss
	N0qIUJL6k7sQipmpaGE4o4mpmNLKb0oSU1z5aKE/DeQSlRjVSQWlL89IT6NTG8G+sXPw7wLJpS/
	NBrIUrN/b6+MXk9pTc
X-Received: by 2002:a05:620a:4589:b0:92e:874f:d929 with SMTP id af79cd13be357-932df6765d4mr183700085a.19.1784987236124;
        Sat, 25 Jul 2026 06:47:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.102.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de66b2b4sm153351085a.41.2026.07.25.06.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 06:47:15 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1784981974.git.tanggeliang@kylinos.cn>
References: <cover.1784981974.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v12 00/12] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <e427f195-76a0-0234-a468-90f1c992db00@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 13:47:15 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/301589=
00549

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8c7c0137602f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1134392


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
