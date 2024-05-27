Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC1F503
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818914; cv=none; b=TBnN6v1RZMjpk2lhUGX3By+hkQPH+2xhvZtsW2qJAe/CDHzDzysPIiXetGRUuC+033VYgfdFVHXXicjXiqwsYY3EaVxMo40YzkgUpCpCY0fNwkoq9eZZ0AoZOgimkWVEXctw9q0sxazefWGxC5LQKUZ+1XoEoaehdUSn1eNOj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818914; c=relaxed/simple;
	bh=Vg01kc8MD3i73wR7D1Jl2aRi8QzzazzTU31Ts5sFsPU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lMzwrsQzu7F14QxVwNU/ArJc2v+Yb7cTQ2Urdtwj+5LY2o8xWf3XjXNMUGWDd6NRmV/DV9V2gxjX/XjCZ9wm9ilQ4etPi5GVBR+sl9Hw+aGlesQ8/VnmgiTWfSIdYJxGxdUf8YlVSVKiN9HPXICJfEbxHG2E9qUDKEyVo73w5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I23vMYvz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I23vMYvz"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-794ba2d4601so109938485a.1
        for <mptcp@lists.linux.dev>; Mon, 27 May 2024 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716818912; x=1717423712; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4piEtMV5nUELZooeKOQZlc3JKXi/F5mCNvfA8r88gQ=;
        b=I23vMYvzw1eL0IaFQv0x+VVOdqEQa++2i+cuL1AbF7ufGAMJKPpYR7sex784fYQUip
         dZPM+5056MQheTZK+E3k7i6L0kRIBRSGWCqt4FkB4EHzl7DU/Y01p/7wPuLxfJ4itLhk
         LLvK95VhVmmwmgLst5OA/gmW201lJUB3CW/MAqb4G9ODpumhCrQU00NuG6unfnOsrGc5
         47TdoEFmzPjIY8tcDU8flltn05s08OWJdnjA30METhWNf1evqhLxPUhasJBrcVwAX8Ff
         1zxVswr1ICyw7ayo8fATopPg5lpdIuwpnRYpYJat1zOgTHX+ZPT4Ol1AYVSLsCfvCiQ3
         PoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716818912; x=1717423712;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l4piEtMV5nUELZooeKOQZlc3JKXi/F5mCNvfA8r88gQ=;
        b=Nca1hICD1spJ8uP3zItbQVJOoL8+pEoC4OqTSrgIsbOxFQi2wS4PFZcnMgAhwN9o4m
         eggrn+B7zJxgGrLnHIf3nZSXY81tlbEIrPiRsIlBoPNf07dT7scCVE9CmQ2xGfSB0IMA
         BuHrNlim+s1VqeHE4btHuOiQlynxFRFB+Go6rwA42neR2xQWuwwETt4gF2AHqzY+Waqq
         7BUQ6FuxEUjPoGC/uVYfQG65vj3sX21+fx3JbEgygyDkDNGvVZ4UnCvskKLbaiSk4GnE
         LLY7UbVqjFHN68EnTqSzNP+okqpaor7OnnIrXWoseckbWBphocqhN1Eqzx/PLRRR510q
         JuIA==
X-Gm-Message-State: AOJu0YzweWak3qZnkMViYzRmuv2z86YRrbOWrykuR93eopTJn9uMJ7/L
	DK0iS7IAs+gDC46/tK8JP0zChRadldtQvmApUAnnLYUydWSXNLI=
X-Google-Smtp-Source: AGHT+IHkRUWyjgXYIyhjPJAXfcNIhr37VvGCS5AgVW0jvpw3iURopXUpUy1eeCDfcPI6cAsZGU+MFw==
X-Received: by 2002:a05:620a:3725:b0:794:b4e3:8fb3 with SMTP id af79cd13be357-794b4e39054mr711260885a.71.1716818911637;
        Mon, 27 May 2024 07:08:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.223.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd4406esm299260085a.128.2024.05.27.07.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:08:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gregory Detal <gregory.detal@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
References: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
Subject: Re: [PATCH mptcp-next RFC 0/4] mptcp: update scheduler API
Message-ID: <068e93b3-34db-9b95-6ae4-56694378cb08@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 May 2024 14:08:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gregory,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9255729312

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d60094641280
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D856158


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
