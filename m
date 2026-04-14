Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09B40DFC3
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178291; cv=none; b=IKDSHuus5kiO1LqM/OyuMcz9AX5SvPQj75yjRolHV/fAwa+T+1fQGKqK+SWHv1jliQfmgDzHx+qEsE9mjwNeTAtnX2Q5T79oN2OZi+bcvwPk142bS/nJ8cYDgAlzOn/YHU407A8O6iN9DTmq+l4YeCRofu+HuflSKtvUtK/i+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178291; c=relaxed/simple;
	bh=g3CBOaQFAln/s+M7KNVIY+L04CDsSFMFhQESlY6YJwk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=NX38dW8b8j7pdnm2UrHb0NdwFceCgwLu9h5qpOb6wGC+VAg6+1ihW8WK5ikXDQfh4mPcKVjQoZLzn/RM6Wa2swjK2KTS5q2KWsJ++ZupJ30m+9/Ge+wBiDvcY9MjAmE9vLB1a512SbimaonUb4K3Ci5fs7y3FElBH0KpC2pqsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyGL6jwo; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyGL6jwo"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d67a483d3eso604282785a.1
        for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776178289; x=1776783089; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnZgRqBHAhvUNhpusC7eFF3pIY9iglVWTw52qdxOx9o=;
        b=SyGL6jwo8xp8uC90eCy6GCUKUOsJaQ1RjOJxct+EraStwylaKebkam8b3WeJhWuWWT
         15Ixh/ZO2XfsE5IjdACcBGLXEzxEnO66eef5SogWxuDX/cRtZX9Tr4btShoaLJzha76n
         hkhfnigTy/GG6B81AxMs9HKNfVty+7FA6Lu8skOeNq+TAxqWuxRklvQ8Vs5LfJVtK7Dr
         mWZdHFFgnSG/8CXl0wOdfspVqONZDXc1xoOjDi4BMVo0vPneANxJYzoX8bIeryksTfQH
         eWNvOGg+39+aEZ0kRb+bGn8I60AMflaB1afMT50XifdvaEIzT6Zqs86xPxdVPap3JAHi
         G2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776178289; x=1776783089;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnZgRqBHAhvUNhpusC7eFF3pIY9iglVWTw52qdxOx9o=;
        b=W1XRN8QNoBe/5RA8/Y/ye9YXGLKsvi5IuYVXE0ip9bzKetHTYpzUyJvNWPKH/hrPr3
         Q9IgxT3anUi330iOVEEYYaRGCBKoMm0HHKxfPlSoWa6cmILVug3Hmv9C2czNR+pSyk5M
         T5fpVo2Ifw3vRqD7ASGD/l+gUtTsp2EpFfkJiCouJGOD+GCihH50Jj8F098QXebkD/0r
         osWYh4wXn5bYNwpgx5tXoK5yJ4MqJBYkxyjgf3K4Xc9RiphcX9snuc42VGj1x4kr9aNI
         VOPTF1uq5wW+O6xoJnnpLMnjdaJD1NSG8PnMJHPmnyRr7AP+pyK0cRUijIhMo+fFGhic
         PcOg==
X-Gm-Message-State: AOJu0YxY5rU7vkXDJgh0beka49NopomOwTpQHyeY5kUeLsR2voULaD46
	DfOwlOdu52u41xDM/IdBq+xGb9RV4nDvxO9zKf2JF1inXAifL+7KUsA=
X-Gm-Gg: AeBDiet89p9/YnEGte6VHgSRCHGbHXWYkEqxbgbz+UaJ0VS17VuL4QTSnKZ3eWGxvou
	U+k7upeD3LcoA+guXF8EMfMsFnr3b/HyBi/7tprMdfSWa9r/ifnFa2wQUZ/d1eaPyODQ7+4WNkS
	lGVboKnjB+IAQk362SEHzd8VX3CFF03MgbAFJIKXbU/BWZUmKKD3LyljwWfBHEALdSUESMNi5pP
	w+sjfyRmJUT0lUW8irSZ5nw9TDh5rhC9QHSM0xGYeUMutuAkIOdFv1nNN2oNVcBThZnfmiXJ9gf
	PE27mox9om/ebfIEH1qFkfcoR0yBAcj0AYKz7aWCuW+Qdx46K0BjuvLg2ZUtWyYoJp/5AS4VATE
	uc8/CWmhNjYlYVk/rubUUZNQn17xwhDU9LUr3DIsrWdy2X8Tfclzi4eGRlg3elEsNEzDPA5tntq
	aqhRXEaNA4kEuIfIjsnhVVrYQH7bNjg3zgglPbVw==
X-Received: by 2002:a05:622a:1b8e:b0:50d:dc56:d682 with SMTP id d75a77b69052e-50ddc56fa9bmr236399401cf.48.1776178288853;
        Tue, 14 Apr 2026 07:51:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.245.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd5607b83sm112341011cf.24.2026.04.14.07.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:51:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
Subject: Re: [PATCH mptcp-net v4 00/20] mptcp: pm: increase limits, and
 related fixes and cleanup
Message-ID: <376d5a93-205e-2d81-8da0-9f3d609c437e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 14:51:27 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_mp_capable =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/244031=
27637

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/015a75cc8e81
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1081148


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
