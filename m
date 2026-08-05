Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78211305699
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934070; cv=none; b=YAyM4tfBvib4BpNgUqjUxzFCWh1s5/WldO+LdcLX+S5teRacOhGDDoKS5q62ECvaY1wNqT7TyKf1Yfvg2ogoYSGPQSl1POoCn3CDIbzlG7qRXQpn/Dt6eL0XSl0vE14WEYSKgFe08hTrq4o5WvThbrD8CRhAfCHwE0836xYEXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934070; c=relaxed/simple;
	bh=/aYCxVl0xXNNEP1FZ7ruSsrObmtDL1+pOodBtUMDWmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=cfGevZhCdxJbkP3eV3AdPgY043hzPi3M+zcHbRvVjpRTOoFb0hWqiw4SXXLR7+363+2XkbLbYLQncoqRUaI3iPJE4x73LwACJCyKTwmRnrmeycJ1+t8KMm8ubmQVrx0Qg8yXec2Vchs9Cm/m96umGj2I6TL5pGlR4Dro0p3a0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4owqPA7; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4owqPA7"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66807ba2f0fso1341102d50.3
        for <mptcp@lists.linux.dev>; Wed, 05 Aug 2026 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934068; x=1786538868; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gpwZkNbU8/qwImr4VKarf9RiJHiYzufFo9VnnOqYqOA=;
        b=I4owqPA7UzUSvFxs9G96t2OhcztOqWapI6yqP4yTUDcqQpCGqj205/Afs6d6W1RItL
         /vSZBkpqUEipUM28ONlOOZemX/V8T6blMayz+22SXJZ6YLBcLTcISW8vL9pxtMNb6ic0
         AMfJp9fBii8SzrnOwk+unAzall9StqaHqUxIvppowV3oqx1Aj9lf5+fIBLVkduh6g8Uk
         Zq+MPsLmT/DYeaqp+XAVzLsYR+CmHbsKicw0YhC+SPDoe0IKN9gwRsvDP51z65K6YP2P
         yxyuzzlXvtnHqpN7JbjMs0yoF1mMfqWrXw5HDeb+YHUF4HJWj8dL5gQIM5yRNt9sRKXZ
         pa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934068; x=1786538868;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpwZkNbU8/qwImr4VKarf9RiJHiYzufFo9VnnOqYqOA=;
        b=IRTtBNIpdT2stTSEET3P9al4oYyByltyU79xIBuLeBaoaFlS2/5BJjF4FEu1CWaMD4
         1RVzyc4ysOID1PgBoYTzaesRKFv1NfT6dW7e4Lh0AToXJIe9TCNAjfSIo05yECewS4KF
         MhHW/TCjjmwxbZnVbUbEyifKniIJLm53yZuC7+GsQKnG6zH/BAcD3AHwI/ZHoAJme+8Z
         RKk3Bah1GXMgXAYSwxM9rPzd8BsZ3K3kwatsZaT+2L3Tq1aRFK3JroLpZ2LjP1GeX5pa
         rql6E/UnyWXPcEeepcfBjWFRTOE6caG88Tk8ozEpjAiExR7tfxfHyoMjB5h7IMksep0l
         wM1Q==
X-Gm-Message-State: AOJu0YwWftqp9I0avpn+40GbKfHvbUAWexpki5hqbJdYjaseu96E4buA
	l5WM/4wVYLQefbnVYE5vVRvue+0mmacu8Iss6W/OCJ7m+ruqNd1UeH4=
X-Gm-Gg: AR+sD12ebTKKc5T1UAsPielzQOxdbutLPeHG6sg44ToRSwEJBDhYhAUtchlntqmet0z
	EYVEK83l7sRxGK2AH7bjqobgEXzQZnBPRB/whYhEdiPM04ce0c2US5Lb0bx0HfgfAk0YolqmjjC
	1cJIGAA38lCFePuIbK8yGomYO6UXLx9cXIO0uuYEGogX+5Gg5e9CQGh9wFIyBuHdQGYLe4bIPsm
	NdYzaVad61eIhvq1crWgd3LWNjIt/O3M9i0hOc/s/ucC4SmAb02UNn7wLWzhiSUiAv+e2ZNgNN9
	3L7qP29ybY0/BcXKhVGy8BkDazp9Q1estEC6kXoxG9/uFE/IY8C8fJ48aRzkJfJpMUoDf4UHsO0
	dihPVT0DypzWYBJnPowtPqe7YC6S21julj81vI18HOokMOVAsvGKxQR9T+K+oRYpgRQTasAusiZ
	53wO05nOMKxGeALJZolkDySkVnGjuUy4ocaVRFzyJ5wxPgzbp9aJuilF91jFskvZj3ykBr+KoMv
	1g=
X-Received: by 2002:a05:690e:424e:b0:667:d9af:27f6 with SMTP id 956f58d0204a3-6699a90ba6emr3244658d50.18.1785934068298;
        Wed, 05 Aug 2026 05:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.214])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66991672ebcsm3034174d50.21.2026.08.05.05.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:47:47 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260805-mptcp-opt-mpc-csumreqd-no-csum-v1-1-cb2ad0b9feac@kernel.org>
References:
 <20260805-mptcp-opt-mpc-csumreqd-no-csum-v1-1-cb2ad0b9feac@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: options: handle MPC data + csum reqd
 + no csum
Message-ID: <082e519e-15e9-17f1-cfec-76375efe62f4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:47:46 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/310040=
40711

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3866daec4517
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1140736


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
