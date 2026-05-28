Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE533DD50C
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969059; cv=none; b=qmocawyjZWy91XAANkycj56Lp1uZLKAKtLB8l1wNXNNhVZq3Vr7tupJUBRubGugInjTmGM0uz0Z58oELDpZ/Hz2F5gEMZFXkDEd8meLYB1TiBcBsPop7WlGp3qVWnwYntauQA/0vZD3RcjEgEDX2rjk5G1l0O8cDKCtA1xLsmpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969059; c=relaxed/simple;
	bh=vPbBphjriCuIjrf4UtyUwy+kMPvOjSbVxPY7CEWpkVI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Wii6cn4DkkdyLx99QbylmrTw6L+cTqqQuVKbQSZu31ThfyQaILp6DCwsa4UTwfSPE1x30NPsbiWvIZtwh32TAOBaJ5EHRWWhNXe15jCmT5rVcp1/4r9ql925GyrsNRr/4SdXLmTnBe6HRoPe4FC5b3TlVE6DBCGBg4USmQQZ2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK4gFjv5; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK4gFjv5"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69df6127fc6so337452eaf.3
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779969057; x=1780573857; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEnBut6ZE625Heg0j+dB0SJLUhLpLGWZnPxQxiZON0Q=;
        b=VK4gFjv5FFbz1uAEFR8qp4mSZIgEUIPXJGjSxRIudphzs4Z+2OrmfkjbDPD8f6YkDq
         3mDBv0r7rhugjuZWg8Ppk0LJXw7nNzmEtrtPYFPDWMvy++hCQqcfgiYEe4thAlvLvAR3
         4e70wqwoU0uJdz8Af0fRUcEmnUzoZYLjpZPsYdJDPJaTbqzFNBIR8j1IgMsONEDgEqoa
         JwF4MjhROsTkAvXnvEvxS8XGsXwnTQXANzDsxTUnpLp2RKIJyb5AjaFYCCC9Igd9Lb/L
         FfDOo7ql5xRaq9jXgK9+npxFv9JOXRqUDs0Q4V2Ne3NSU/czb2m91/FXK1bN8FjZOGPj
         nxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779969057; x=1780573857;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEnBut6ZE625Heg0j+dB0SJLUhLpLGWZnPxQxiZON0Q=;
        b=YldPMX5bzDdqDuAEUUNGTsyHVFo8hdxU6Mqhfr/15zBY4p5tJ+fvGS1rRNXqmrKytu
         zpuFSiB03FhcAbNwZ866OSxm90hi0LLMU4aBiy1t1XOols1RlYmdC6IB32qSsSiHpPLU
         tQftOZAEuz/x0ZfSAdDz5cnn5PxYyYadZLqUdTCBLeMYodvlVUYLZPL2xCpib4VgZlRN
         QABlisbv0AGsrqtKaa7zSJkDVuNsbMcfIKZYuM6KCZ4hWZRmTp4uTHXLSYPod5pvrTrO
         tHq5tIOZ2qyYr2BTFg56+V4k9sj9GFc8CCVp6rhsroYB7uQhu3rPo2+txmwoe0xMEk3+
         6efw==
X-Gm-Message-State: AOJu0YzTgaJazEbH9KzX870egP4LDH9m84f7gPYrpH5dHI6ozsBvvWuv
	IMkx3oDxAQdkFNXijPTRjrLxZc822syEvhmCr9AJ2KwzDO57BrGxL30tyIQ1
X-Gm-Gg: Acq92OF7G8QAp+M1/FGt1C2ziESjt9nM7GVuL1B0b00/79a0wWYbSEiEqV5zXJmNR9M
	208FVi6cIXPdDKWgNP4BdS+G+axyveyt8rSd966NtYi2bWFUDeeIwfoODUEAPdx50ldEJfZQDLQ
	H0rI0PoqUl0f2ho2C3O/QhPFrFmpqieFe45OHdC+OPmEMDP4VyW/TpLjuam8kPEhpbya0PFfRgs
	7eyUYJnfix7zZaA25eBh5IsGQrEhr0lgAlOOmGN2HFL94kZkEYQbCxxSS8pyIv7tidqaevS8jzf
	xfeh0YPrrJYwwWcfLwfzv48P+T/ZDYyfv75k0dEz0R6OO7Fwe3nso5fvlqxLwh1eImsqvep4bP8
	cd1Zv1zRNLqCKEUhP6iqrX7DWYWsQ9nY3dRPYRuz5WOTIAeoFRFkycfjJLroYpRmjJaBVadDFm+
	D7PEFc3BXXu0W08SkAxIN/ljkZC/gWtwusn//YcsZ7R74/KEjZ
X-Received: by 2002:a05:6820:16a9:b0:696:1a85:586b with SMTP id 006d021491bc7-69d7ec6ef55mr12919340eaf.35.1779969057258;
        Thu, 28 May 2026 04:50:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.132.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83700d55sm9521054eaf.4.2026.05.28.04.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:50:56 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v21 00/18] MPTCP KTLS support
Message-ID: <e38f77f9-e731-c89d-1a6b-f21d4dcd13dd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 11:50:55 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): selftest_mptcp_connect selftest_mptcp_tls =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_add_addr selftest_mptcp_tls - Critical: 366 Call =
Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug (only=
 selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26567486220

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9d759520fe7c
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1102136


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
