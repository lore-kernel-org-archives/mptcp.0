Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CE53C3DE
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988026; cv=none; b=JRD+loXLBi1tIDM3m3+gcDtQmJCYZs7fm8xMla96obysRE5wyDgrB/7ykG35xDTyyRX2oYclvYQRWUjo/PBeRW440h3oVotCPkfCF5WL/KPj9TJJSAfQsyMKE0hudUaOS0gV7yIylFr0MPx3QQyTbr2KWnCf7W5cCLfJjGfeqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988026; c=relaxed/simple;
	bh=0WHQ3prEr428kzSV/q4LS9NY2tXkqCxiVM9u7Cdh+B0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qn+khWlU+2ALO/PpSAxT+REY8yxMAHC1cchQWMzdeJKRM6pV1IiOA0rIziFN5yq6oUlYyk+1Xm3IatGl8oklvBXqMmg3RWZgNTnAy0IJdgQlGvkXLFxTiEx3K+EyVk5cQlLNh8XDf3n66fD6fqL6l5WD8kyMW/BFXrGlXqelvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgVWNc29; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgVWNc29"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91986c5cb75so4642556d6.0
        for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791988024; x=1792592824; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E9vf6jLeas6niZEK2khaWTpNixavRz7FJj+AVZia+uc=;
        b=mgVWNc29x3yyxHXH9En2qRcNi0E0oStLYfP/SjU6vYgqJEM7eI1HW7ces+ZOM/1eUh
         z4UQbPlHMXwZO99wMOsp7jZo5RFNdCHrr+Yaq3Qd17RjZhPOrR99Ee6/L552CcMsZNJD
         4bxzW7VrppyxJhfO5nzzJJiobCrlY6fMAQH7nLPrEdGMsEfwRd4NdGbLoQ4Kg2E2Nowf
         K+numYugzaC72WM3s9CC/q0ChR1q8Kiz3+LtuEXVYM15fB9aInnKgZWa/bqxPpQpXlkp
         +kjyC4T6B0MdyjVPef9YYtckZvydKAhOdOpLI+xlwOSPdRxmopdX26UruHnfjZoSuHoZ
         DuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988024; x=1792592824;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9vf6jLeas6niZEK2khaWTpNixavRz7FJj+AVZia+uc=;
        b=bFJI81Mxhu8FvrxzJZl++Z26y7Jia87qZtkBfgy8mGR6Lt7IhP5MosIncjc2YapONI
         Sa4K2ddcaT1h5dp/hvP7M/y1gcNRBZ/LXVCx+hSZxOutzBvl2OOm5zV7PMX/Ndf2gWyn
         xjHrKPxXLo5C5PlMopcgxh7azldjnopIpvsW8jZLAHEIHMpbALMmi1EGLP36SASYTXE1
         fWY7OaWk6rVw8UzM5UvfJOin93R1L/QRaZn5XxDgBlbrv8/UI5ttqQ9IU78xmPgN+YR2
         lRBCuvGks8W8WcoW9lGFf2qwSpWm+9pjr5vhliX+K7glUJWv9Pv0ZQ5hC5F4wQCH+y/I
         xMag==
X-Gm-Message-State: AFq9FYLWTNsY7RgTugnW0w3LdoGFPBGRVWdwedW9GpDjmJkXK6kEceny
	GUzByX+DDrPhfwwAeOAh08gr5Nv9OU1E0C0ADqkVD/riRvGiAzBIbYQ=
X-Gm-Gg: AYBFou2KgmxFwLXPMLlPbAG1mGIRxYP3iOQ0w0QERengGCUs2gA0okzCF3lcoE2uaMr
	l7oXjFncQ2bD7qBLsN7Lm2Od+g+LvgJ0GmuTw1DPamNEor8efIohyyJIzVezR6AgV1rquaoaFQT
	lmBTQoNzLE87vxqDEi73/aZRAG2yyXbN/1fVCPHWdayGAxv9DkVtEEoIpmAGcCCxoy8zxq9EtK6
	BY1i8r9+Y4InjAvvPjVG4bXCFDHRXSEPAhnxrDuj+7/4rQBybvGj+r9Lf4Wq0JCkTmxrfeYF71y
	tSK5L7L3u17iTgK0iyNKOyUJtbDHJa9Ei2nLYJqM+msbSTlscqEM/W0SWwA/Dr7dcyn4e5FuG0K
	NELyAo74E5jepXP+/BcPmE9ZRTmR5VdymAGgEVxxABwC8GbxLmDn474uirx3Pgjpu5ZFVf9kXRg
	bOSi73mQP9yXNk+u0IJbaMONqPazON+8Ah76lkR9W7PiFtISy0tMru/Af0IQO4TsGpEysVj9iJ7
	/uKDYXj8bJS
X-Received: by 2002:ad4:576a:0:b0:917:8752:8214 with SMTP id 6a1803df08f44-91b5532f60bmr265544856d6.1.1791988024121;
        Wed, 14 Oct 2026 07:27:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.158.132])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b978387f7sm53862706d6.6.2026.10.14.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:27:03 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261014130809.1874184-1-kalpan.jani@mpiricsoftware.com>
References: <20261014130809.1874184-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v8] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <967d9d2d-b4e2-ad32-e4c6-121a2afb22cc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 14:27:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38574170831

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8ad9371d2e=
02
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1185594


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
