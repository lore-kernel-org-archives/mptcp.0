Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967947B401
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844134; cv=none; b=LhfmEkQcwi3BtZHY0Y+bQkJTfyKWvD1SEUfDvz4+o2t08MwJwfKd/xeCLBOV9eqNKe1iF5wsq1wDb95lTSmTpRh/C1ZaC7g5yd0C+0bS+UaXALdwDZr8+B6EFbYKhcdNzDk1TgdTjwIfbx9fu4nc0CzTKV9DR7tUxzfjV+5Sgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844134; c=relaxed/simple;
	bh=b1g0U/eGuSmq+ZcA9BYANUL1q7qZxJfNDm2U2Wr4D/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=d72fWdfI5rLTF9ws2lJ3oC2EyF8VeplrV0qIgV6P7f8lH4wpC7xF9BpqLD+/C4NsaUIXbLw80oXs1cE0d8CTS81xtafpAxMTbqCK69U7AL53dVJgQortMieTBqezrvVjLDIajXLEP6SkBZgdyftRtpk/SdfaESJ8z0KcU+ECFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSKwuIEu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSKwuIEu"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-512f09ecc67so63093831cf.3
        for <mptcp@lists.linux.dev>; Fri, 15 May 2026 04:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778844132; x=1779448932; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEtjNSDFWRRCYYlrnn+DxsWNY4dOro5LA9jtc9E67CM=;
        b=bSKwuIEuiLcIwWiaL+zd/tM2eem7+Co/FjvrOkRcm1WeE2ETMNvbt9fEoELWyEFHH6
         H0qzGfjsVL/CUSfL55xzJPjNUoLQHfIUR3e5KqoBxYoU9T9f4pfatJP8Q9+J3w/faK5I
         6k3KNd6OuMYXY/r0tfrcuyk+ngMQNspIrl66cwOUS+Um8gn+cORQXen3iMrSRDTmQy5F
         CWnuy+6BPqr0r3Nn4cpDMtzO1O/7QNWUKqgfk/Wc0SzG+6OAZ9nwOd1eBuueTHGJCosh
         1Q6ytYdSTfKe3ZBThL4nBi3/aXJjESw4XEIE0eg36uVIvnOGRECWmYGErhgyQGIJZ0kB
         h0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844132; x=1779448932;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEtjNSDFWRRCYYlrnn+DxsWNY4dOro5LA9jtc9E67CM=;
        b=s+hpLMdppeuX7i3xkY4KQ+BhpossXboL9aRnsmBYREgu7FKZTzT58/Jz9Iq/In7bmV
         4vLB9D+P5IcD9uEoQ+yLMNkIXrtMouFVGFhjL38sqDxsu67Eh/Hw6wOyygdvfRq/QWhC
         tf85mCYM5Zb9dVVsVr6K5KKLASp9zce7qs/WL7M64Ei7TRBK++LdjnVo8arSMoRq/bqX
         MsnQZPuAeSLJsVXkDXgadVu38o7+Ohjb1CBzQ32+31IISNcL59JHlRBVKOOEQosCowRg
         yzoVvhqGUaVzNm+XnfnUoRJ7NcBAJGcsCzx1HySeNwyh/1CJTIswjgTbNTSYbCjDuxyU
         nk0A==
X-Gm-Message-State: AOJu0Yz0sO51roSltvTAoqD4UrAjevJ4THGjjhkF6FT0HHHbP5mjtfkP
	5mCzc3mY9HdOlViwtRZ+OLH/eh0Iewm/PxhmY791klM4mOBExRNaY02wyAfO
X-Gm-Gg: Acq92OFtRXSeVf6CW4fJ/grbK49iK0uHSSEGtbdYiG0G0P7ThaA6F//sw2K5a7vredu
	bGq8Xb/5PqYEUaXur2vuDo7S2I2SHBz+ZpK71BKPAqeKCZx/HalsVA91rWaFBVWa964ckHWAW4s
	BsvMrP1EXUMtuniGVAvP8BpgJPAO3NFusEIZMu9wv3/IrGmHlYsiPswpqnS3J3oGN8EMNJT2B3u
	4GLWe1CTq7iONgEHAwddLO81b0b/2RoSqzuRGuqAoakCa6nx+y07exXq4XBs+sFnwEWENEdWdHm
	MjsInzbHAgLpU87wrdGQdZxzU471TsFTrZWSWPH3IOrXj98j8T0/4NfpcbhF+/JqbhGko4sXrh+
	Y5YVYLr2Mst2UqSYhQxfhkAcDCkVvX/6/hDcOsgJ9G2eml+/PWa6Pfk0GWdqMzMrnpei9YrZIk9
	kxJzx5pVwB8yxRt1V+N2zLfvsjm/rc8jAfKr/rXnIPFPrxZA==
X-Received: by 2002:ac8:7d89:0:b0:50b:1e5d:992b with SMTP id d75a77b69052e-5165a283e8dmr48456141cf.54.1778844131489;
        Fri, 15 May 2026 04:22:11 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.158.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645856d10sm40821371cf.26.2026.05.15.04.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:22:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1778837549.git.tanggeliang@kylinos.cn>
References: <cover.1778837549.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v9 0/8] NVME over MPTCP
Message-ID: <ce7e9361-28de-f0c8-5e2c-5184717cc50f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 11:22:10 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/259119=
86226

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fd08357db842
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1095279


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
