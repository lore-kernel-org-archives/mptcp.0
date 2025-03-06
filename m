Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5E1FC7FF
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262722; cv=none; b=J/RRyOTOKKmtIXYjANwVd3Pb+DtLzHl//QdG6h7jy8inxyYHFvnrICCWnd77sPlKZjanusYHbx+JRWrodAFsX4R0LWkHQ3OW16Xy5pmtzsvOPV8EI2YEUg3it9OPZrKEcxydAFGlBIka0uFm6xpv7k2Sl+pXXPzoSLAErHOrYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262722; c=relaxed/simple;
	bh=PJjw/OVW084LTuTprysXVk3Dj1HIWnQAzn6UWtnHw/o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=J3fmcchlRUedm2JB+z8Fqo9OwtjmSw/KQrUZfnCP6PF0O//8IF8USACJz2uYkMwb8H3ICtwigFiZa29/QwzvsPi6TKj2Fv4lNZ6hrOhgW4EBd5hjStYMzRPLwTo6ggx63QK6Pji7fimDC2oD4aucriK7wGPSWWMIDK9vCWmvmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0+6DP2w; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0+6DP2w"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c3b4c4b409so89566885a.3
        for <mptcp@lists.linux.dev>; Thu, 06 Mar 2025 04:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741262720; x=1741867520; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eC7itKlI484jvN5koO0EvXmjKGYD8N3TdX984jaFfo=;
        b=D0+6DP2wluMocrsn8w/B3qfcG4H6Z3latDowzEO1ZGz4a5WNDuXYznUaSc8d/Vq2Ll
         KMBZM8j4avxwmkQx10KzLGU8yJDF0kECkHT7I3Yiol6LoBLpgyL3dJ18AhRDqCje7wiU
         Sdb/To6r14rZC5k6C/EcNe+CLHbv2gKsbS4BN2gg1GPeiV0EJp3OLHkuHHHqA2F8pf4f
         onQK31F9NrSBrwSpp4SH16LUHaeUTwAMswWx3+4yZqRK+ZWnmTBTCHfHnL1wBEBrPpqz
         47AiwWDh7IpOuHpK4fA0oR2TMdkKZE+D1RTyaIN/B63wClSu3mbPzrRB8rNw/3SYb0Ar
         L5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741262720; x=1741867520;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4eC7itKlI484jvN5koO0EvXmjKGYD8N3TdX984jaFfo=;
        b=NuIC5uxTsh6QwXnfYzHzVhVAyIuOPfGgiJE+NVIBv34MmcXTuDA0gUQapylnmv4MEX
         NouHSaiCCAVx3nmtlVTgauypuIEnj9xfuiJTVEH5iS04l/wDJBOLA6A8O9bogzcy7rW7
         FQrIa8PnusPVAIAfCMfq43NX4B3jFnkHnKNZrHC12PAWMxr43XyzDCK5mW91nTP6/szZ
         Y+AWr2QjCvbqEPCDsDPB66DzrU0zipbtZkl2Vg1/xVYH8XteVXmWrz+fU+NR2gPFGFfF
         Y6WAi32O/rtSzfQqTug97SGgEb9tNBK80XrSJrNT/qKtDRWBl/QWY56xiJIV3PUBtUXW
         Jvnw==
X-Gm-Message-State: AOJu0Yy1lMEafcL3xSPhMXDndtDypGxNfvjgfI0A95qwJLDimGPDgl74
	D/qaehHv3DJZeli68wQZJz3EjMLlmX+GAmFlDdrPbtpyy32alQ6PRzEW
X-Gm-Gg: ASbGnctsECDBBbilutAG1tq1L7b05i7z9e1gou1wWA58vg7fX38j2g+7b2WzjW9zitL
	CaGt3avGqm5HBb1bKIskScjhHlbvgqgN7BUOGGmLTRV9niRwlsm9SY5MNYvG8aMULddsNIskwtx
	TearUXHIqYp2e5niFceBrhkwz3Y7P+/UNgV0KuPDvt1e5BSOY54VkCZDm9+5827U9Hiyizc19hY
	YTGOyWq12kMjnTMenevVCqlOlgxJflhYV3kuw1oG46O6zPDKhA7Eseau6JpKUWW3I8h5nza7MID
	OmY+2bJnoEmglG3W7YoQI1GW0Hf23tomk9IfRE2so0BU9lPRUF2fsLkX
X-Google-Smtp-Source: AGHT+IEWk1AF/uyomLLkMKAHkhKMPpyK+8OPFO4D2xoprzaEYY2VKJw4DyTQ6FK70EuWD6raU/KCYg==
X-Received: by 2002:a05:620a:6891:b0:7c3:d63d:7bd4 with SMTP id af79cd13be357-7c3d8eb146emr944358085a.42.1741262719783;
        Thu, 06 Mar 2025 04:05:19 -0800 (PST)
Received: from [127.0.0.1] ([20.57.47.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533e6c8sm84439885a.24.2025.03.06.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:05:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
Subject: Re: BPF path manager, part 5
Message-ID: <8d06c42b-1dfa-fec2-d21b-1be4dffda792@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Mar 2025 12:05:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/13697375040

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b2ea54bb5a22
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D940967


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
