Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767439C016
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953460; cv=none; b=NC+KDINNlcy23VcT7+x7z2CWk5kX4O5pqUWutgOhMIUZhaBGGdTkQoG1AkS62wsxK6PEzCiCm93KbgAwXaWEAKYgG5lrNnVZjhq/5H2kNnablDynjsF7clgrUSZ/eSlQBjH/pibE8Ok8WGnromU9HXSloNgU2+sdKENAzX9V/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953460; c=relaxed/simple;
	bh=zRPSmVWzrAh8jab7giuiRYbgrprp1DlquS7nhjxZxyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qisIHRT3ZvXlPeYzVyNuXnxkhSxpP+7yfjj6wv6ArCKfpxikKGQCL7K0IGOKIXazH3pMxLWisag362VINgfeJg0hLBTlXLymn74d4QDSxLz6q2HV9e2cYtp4DncasWsgJk81iwBbxohDbAZx7HNINTguvoEL/h3Nr9dURykqCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kndn1JS5; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kndn1JS5"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4671cbce465so2044743b6e.3
        for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774953458; x=1775558258; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXg6TwlOlea+8fDRhTRn+bxjQniMxr4QuZbjCw5ajLg=;
        b=kndn1JS5nj5807SlyfziHfkohb4udqFISg4locTHFszwXMFujXZU7eeCk1K7K8p9z5
         92FiXsS3iDcx90JOORblMlKzLKNjx/tcXFbIhqD3WmK7poLiW+WOF4uYcR1naOrb9clu
         VquxjCkFWLnxUNy1P4/BW2Lq9KfMIZ1B0w9OXo5HDA7d03X3yGxzLZxHZjsbta8XOlno
         dVfJeujzB6/kpLa2ZNGB0JMEmDco8ulZ1CoHtrGIBevQoVuOCA5jjLmIwtaDxqxklPQc
         NWZ5D/ZCgw1MXqwu1tdrRH0p4UtDMpPpGMe+2nWaq69lqU+mGvAVC/c1lpkhih5XA3CA
         vPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953458; x=1775558258;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXg6TwlOlea+8fDRhTRn+bxjQniMxr4QuZbjCw5ajLg=;
        b=I+HEb8LMyDneE3bUQEuUUvS2RGVGLL6VUcdoRl7sSmwsZi+9hjAux/FNEwFfIzT/4O
         ZoS2LW6SBiDNHyRTwhnPhAiioSwmDNwlmi2CZRY/yad9ha34SOUu4XQq3Q5H0Plg9ZZl
         deS8x4gf/P/hU9iuDIivINylCGQ55zTkti8GrWN0CVmfWK8Gvawq0rBIFYjWPnGBMpYq
         IhtKWr/4PFtXX8OzCCqmixQRoY7Z4PmGV2k+fXWzMZ/3cTWcEFnGiqn9KZ4UErQLsghp
         zVKQXCqyMssFrokpPafIe0d1iph5CgMV0zCELqBrPo3MkSaetzuetBo+xRI8u54rXNCq
         UD8g==
X-Gm-Message-State: AOJu0YyZt8OKQGilxt1oe5TY4rsCIQSqSMm2ytInYel/vLmCBnQZ0RZA
	5cASQk7YcWmh7DF5+aIqEyuRjcs1T8NLf2slqd5kOAbt8fp0EGYjnSogJWM0
X-Gm-Gg: ATEYQzxuEFsxHI0t77/+9aHqMhbxU1lIXHod0Vz9mdQr1IaW8giy1H5YtWcrKMzArjH
	xA1AU+PoUSO6ErISJQliJcXzbCwSJBPSLoiOQAH3poHIsoFg5XhVlxOYR/6FcuvNvA3ZY9q5QYc
	21mtMSpbAHJSs3zLE433BUsXpYH2iq0PZIJtA0VBku7IgAYAIF7Kf9Tmo0Wfln5wSb4Z5fYb37I
	q/Lcto3m16D2culjXMpCA1JtGixwz8eMhqcMo4PwG7/T2ItT0U1JEkormrWKMASXKkm4wlrJGtS
	HZmtbu4Z0X2HAxkxZwjiKOcSmvnpqQUr8/oNyR2j+FX0dPOX002uHztHscwGC7MTMvvlhkCKc8l
	K6dtc2A353jg178VzGCul/XUCQAt+nJDI6uvkQA7rvmYlUOpL4GBh93GFRoXNXQVodI/iUrmkT4
	cJ31gUjR3I9ZP+p62rMPwivlEvgXhXCL/Rk9o0EQ==
X-Received: by 2002:a05:6808:6d8d:b0:467:880:7454 with SMTP id 5614622812f47-46a8a456adcmr7043133b6e.18.1774953458315;
        Tue, 31 Mar 2026 03:37:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.132.178])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm8450144a34.24.2026.03.31.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:37:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1774947296.git.yangang@kylinos.cn>
References: <cover.1774947296.git.yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] mptcp: preserve MSG_EOR semantics in
 sendmsg path
Message-ID: <1c7cc254-ef68-844f-4de5-a0dc513d2f17@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Mar 2026 10:37:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/23790407262

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/742ca3f3c16d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1075065


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
