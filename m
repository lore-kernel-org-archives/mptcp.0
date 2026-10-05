Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD04AE8B1
	for <mptcp@lists.linux.dev>; Mon,  5 Oct 2026 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226259; cv=none; b=AdrpLRGmNP+8TPGl8TWUuw4gEJIW//5bp+3TiF4uanqFncWb146HNrJKwgnuyWVZuV3xXpnEIHFG9DacGmvoClHANlg0AloL/3begyD8d1tqSPxGoK3LeDfJaZZCv8N1ySU6ewf9G9AC1NvXhHh9EDwg/UqEJhAiEqpTewrs/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226259; c=relaxed/simple;
	bh=A+lHB2SQsu0DIT2bbehioxWSAjwhGdhIo1BQVPWIZW4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FK/dIDjcBqMicOx6tYVDtriF9F8PA9jZs7O0PThkyyZpLxGg6ijexrgqZyFoOPYl4cTR8B/RycBnFLTQD/EFO23bcOBnd5Xmdq+6iZpuZbJotSh/PIKoI9OFxgnGtQhOE4KH15tcDzGLleIa1TmCoaLOAmU9/FE87TU+UGX2i0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQFcmVHc; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQFcmVHc"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8247421d2ebso1087750a34.2
        for <mptcp@lists.linux.dev>; Mon, 05 Oct 2026 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791226256; x=1791831056; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rc2+P1720Iv2StY3yibxvdzcf8nigDLAMcOAQXkZQxw=;
        b=bQFcmVHcLBprSfvF+KjAHwbq1WPKKqMBB4dGCarSa//WeJBMI4NDtKJIBrZGvDRAE9
         qAzIYu1hpV/sTNQBVUdRuzjvlCz1dOZ0Xp0c49a5dhZS8fQx+/jqBNOVAiL/enFXB/TA
         hThjDH8oOBmsVe2adTaP6iOsDyUIqxJRm29NGFP65XJgKFbjWGzCz31hkLIL1GntLr/q
         L8tbKeVZ5RanMSV7NPqG+7jWwazc6Gt/QnjSY6wGxtfI5mEV4aJp6Ad3lJZtXp1Oh1WU
         kF/Wng8icu43TmScWpRl3eTqrqtzPVqEm5QDEEePqFojCbSQj/7JNA7oi0yRHIpmf5gt
         fbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226256; x=1791831056;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rc2+P1720Iv2StY3yibxvdzcf8nigDLAMcOAQXkZQxw=;
        b=cSiolb11306EIpa35zKeuT9DQ1gKBi25+llEZBEVjU4FJOcCESzEkND9H+1XP+VT9C
         3oaWS/NBdMhzbwUY80DDSsM46U+vA6NyymXYC9U8MgxdKEx8yec54YhKlNQxaqaRqctv
         edyrNBhHfissBXVyC1xOGHLDiMzVp44bGiHhf7JKnnd5gEuSLGDdK6iBd7Zn51yoHBLM
         FdW+IY3Z0W9WneEFQAj4lQYokGtJhQ4CclxMsgJixonGUEgpD7H1Jqfa5UP6TGWhpV/D
         y91q+h5d4EswB58uv9BePWj4XFX0xEOW9HOlhS2TW0sFIx05SjzvtSABxkjmOPOz3sNn
         ZgzQ==
X-Gm-Message-State: AFuF++mq1DAUni+8bCpxE6SbTt5WMa6R7iZ7JvNa9e68Ehp6GUjR+/3Z
	aHtzSIAJgv7N6je/aMbb1ziPlT6+dO0HFtWRQLjF//av1xP/4SD4TY4=
X-Gm-Gg: AYBFou0/FN6aQBk8Qs5L1Yu1FyqotvRGr7ygM/bldSQ5qDKVzYTPg1mTzSq183KZV8x
	EN4535L+liJZptiPtaUK7SR9Cw3r5zq7OxcZehQp6iTcPZa4rIewmmC/LuN35sh/XtXGfCPdZFP
	JTf2m+0rv7VKDSQ+tJA5Rc3SiFfiQ0d3QbhF79iPI+Mp8EETNsHGlhdqCsWomJJ4SHV3IF9/3RL
	sQN3UQ/Bu33Zt1/dw7XhslBaBRVDqZDuMy5HPFWy/i8+vBfyRBABQoy6n2v/qcyFY57BHA+3+Zp
	29lsJmrwQxo0S24fbXECjf4Rv1tktUjt5thwQFMElAv5MIJBZBjO4Ad2mPdLlFHlPUwP/o7pT8X
	COa86Ufe+mDR/dic8gUwVUdJxG+FWCY0+AgizgFgflRkyVHRfUdVxzQ/8BU2oheYizqgHgJIFaP
	aOhASjuHh8Rd9nskAjPPv88X5gzW8t3VAiJv0H+aposMZEVXPD8GrorQxxwLCV7w6NfM7ZjXm2o
	SiK5CjCRWjyEA0=
X-Received: by 2002:a05:6820:221c:b0:6de:ba4f:aef7 with SMTP id 006d021491bc7-6df35746daamr8991741eaf.74.1791226255681;
        Mon, 05 Oct 2026 11:50:55 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.215.210])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e4c276a8ffsm184083eaf.3.2026.10.05.11.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:50:54 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261005174222.3524381-2-matttbe@kernel.org>
References: <20261005174222.3524381-2-matttbe@kernel.org>
Subject: Re: [PATCH 7.2.y] mptcp: fix msk->timer_ival reset
Message-ID: <b6729398-55c4-149c-81f4-9b9bc58d6192@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 18:50:52 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/37352828680

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b343b8477f=
f5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1179809


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
