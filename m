Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585783;
	b=MNBf1xeShkHGA7AOKBgvQI3YXhR5y2JQvrp9bYEydgpYMh05fHBKrdsYPaNQamfHOsSg
	 jZcf6mGRN+1RuLubwMhdhRDs4yCcUQtflMHFoLOJs+74CxxHxts0a+pICNmMQlmXB3uwL
	 NUXRRomF3HsY87DHWbygwcKwlA/8YbrskNGmh7iBF9qDD23BzBBjaseTaXA+dZL3oxJ/p
	 YwEXZKvsygBTblRDaVVz/3kkairBYussAN2iaBmaA1p4p5TFVSoboezoTP93N43zyJqu7
	 oBYGOt5sbDhcr95pnTcvO5eeI2RvQRMokq2OK2/KhmMSmuojoCg/s2pNBhn4YPqNurg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=8P8IcXLp/WslG+JRQyQ/swxBa4NBs7BYwjh8AxuoNVk=;
	b=PwXuFwJjKsotHRFNcOWblJChRr1I/JAaOoBf7gaLThnj8pbe/azHmDiTKlrNuPaL0POx
	 IifFPHnkTmAIZVDDKcjF0xZsga6KWr6ynTgFkMFWDKwGCr2vdQatspFU3JQdP4z86yokc
	 EaMAGfdB1pif4RTpAz0yw+4yRDOk6Z0X2iiZSluK1+xoDJ6WBwKdW23yXp7/hVp/2qF4w
	 DXh6FTbVIX7FzVSY77LKcBsViG+k2fVdpgCCSpbdgHVgNkLZiSsI/iBhDDpYcNhq6noOs
	 UkHMLnljLzvqzx/nkew+tcH4ojutiRjKSdF1/7wul3xCLZ4gHtX+ldwKasBSiqYR+3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iXxi4kpr;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C71606A325
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 12:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C71606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iXxi4kpr
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6dd4f3f696aso311012eaf.1
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585782; x=1793190582; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8P8IcXLp/WslG+JRQyQ/swxBa4NBs7BYwjh8AxuoNVk=;
        b=iXxi4kprzDzcTvysHHOdIVX32pGjnRTqLbWG5IdTqtBoSYSb1uuN44ZbFxG+vxlAcY
         Xb5CmVKt6BQ4ODdsGA2oXKsCzZ0CFIiO9Zpwq4k1viGMRHjBl9RtLhJQPkfXOzde8OvW
         lqc34ATQwL7HfC+wCE5N0Dg+9swGK+HlLPaxFh4oLQnbJCr3ObMKsMFuSquegoNnER97
         WuIBFn5dLCXN+nzKMAf9qs/unKnf7esT67obVDMe/4VjqjS5iBFEkZdvpY1S2+9uTzVb
         gsWPxDN5ScRPTCCZiS5uu2kT9vOcSKPzd4i3/WnCkH6MXBSQZUhYN+s0PZyEQdCIB5ey
         kzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585782; x=1793190582;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8P8IcXLp/WslG+JRQyQ/swxBa4NBs7BYwjh8AxuoNVk=;
        b=PPiGS3uJqw8L/5QAxtleTC4w9Sml4JN/rrTZkpqqkIi8d7nGblmkr4aFO40a3ERa70
         krJrTpfKVj/biFmwqjmw4k7t3H7UvYyOC/1XJcRLzpEFIcH+qxzhbIDswpxYnOoY7luN
         XKY4etZSIHQA9AkspLcvJ8gfc/tKahpL145rjt3IqQZllZJtO33HCPZ+VjQipnc8K45k
         PcIaRUwQk5LAVacdSuBW6c9VdMwzFW+oLmO0HwcOgYEK7+EHZxZHPmHWl8zjH2fpXfW7
         TZeAOrsPzi/yYyQYub42XRDumesF4IVTXkc9RSxdSM2NIW6fN+D5c/MVuqBxjEeKLl7H
         yI2g==
X-Gm-Message-State: AFq9FYKs+do6GP4wldRMldseGIoaVvDGuMopHcOUN3TItPyGIO+MNwys
	Ij2iMPF9NQgUe6gvynhvJLPVmXwoJW81mJjSTRZJxdroDVc+8cAbhjk=
X-Gm-Gg: AYBFou2sWetP031GNyZ2l/FvOmkdeQYZWDHZugNlzHCrANV6Yk8iru+plvITRM8pZrI
	1ZEod3KfceViOQCkZLCFYf8TghernoX4t0OogOLeTab49mActQS8q1QkSQk8KKTrxgCCe/KSQ9z
	qqz7mnaVShLvDUBFGhwy7XhX7LfVTHcl/ibsE0zFV766xJ5RSu5oJUk0Udnva6644Ms5053diyV
	zKDnXcyrpYAkj0WyIGHvwLBn875sj+B1xLiYSzuaVAxEkH01KZ8wSu8LQsWWuCyxyRYUSKwF6oV
	nuI6DyQgPfqz11sF9ANK9WOEdeqxggj2LycZjsDs+S0VpPANtzIXXEyd00H3u249Z42gJq+MN4b
	ZPFhRhVlk/1dZktFOKXcpdXUzVgjPqavu20h5qgchxpnZG7MqH99FF7EbeY1wtG3twatekHNgRg
	+WO9/nWV5X1ZEM2BdphzfA85GISpjvN4IlDe8xiPoOd0g8Oqte6bpFqyGozlDNieG48Y1Yx372L
	gSzSflpaQuK3h1yisIuEOkLezta5c5+LpFMJnFFKu5q0FyKgrf0Qwmj+aIdgFiYgSqwECVC3NU/
	uEUwGi7wIsC65A==
X-Received: by 2002:a05:6820:208c:b0:704:b7df:f29c with SMTP id 006d021491bc7-7093d5909b0mr891261eaf.10.1792585782108;
        Wed, 21 Oct 2026 05:29:42 -0700 (PDT)
Received: from github.com ([64.236.144.97])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-709045b1555sm1827821eaf.14.2026.10.21.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:29:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261019185512.458313-1-w453y.me@gmail.com>
References: <20261019185512.458313-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: pm: in-kernel: fullmesh:
 re-add of the initial subflow endp
Message-ID: <69e88927-6225-6283-e0ed-42a9b644b327@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:29:39 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join=
 =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): =
Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success!=
 =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/395800=
81137

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5cda98e190c6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1189183


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
