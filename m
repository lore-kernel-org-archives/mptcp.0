Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DA3C7DF1
	for <mptcp@lists.linux.dev>; Thu, 20 Aug 2026 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212595; cv=none; b=cu9dWG3aqQYg6pSQZKyOxom1qQgbgeq+wBHfyXoLxck0FwcJ+5BkPsR1mrCbvm1R25NhpCAOaiZb0EjM5FhmU2PfhTqWmfMF0zt1bg6I8JteULwNJKWpvQ7lFmOkG7ab+xwww70jF10RcVqtkZJOPgoR9Q8GNMPsQMmiSrUjKIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212595; c=relaxed/simple;
	bh=8nwe6f9UbMA2Raao+HmQ8beQer6gwt49KvEFD3EaYf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ITt+E/VlVjW4P/y3Ns08YNp+0FmoxNO7ZuA+fqUB438NRU5r2gJfLU5QdrEg0jERk8BW1XUC1fcz0Azib35u0NavZP01TPTAgIjC5fvaL4NMyiv3OvVOf450NGgprkJIwGaInS46S1QiHnBDvzJ1OUmEi4fp6Gfux4UYJ4a+6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6vBfyAN; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6vBfyAN"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b28df1f600so1465429b6e.2
        for <mptcp@lists.linux.dev>; Thu, 20 Aug 2026 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787212593; x=1787817393; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YBWfXrAtUJm/HpzLzPyZACtBgkMIykA9/uyMrFZEVjs=;
        b=V6vBfyANmx/kyMIu+lkfZxmGEpn6W+v2ePtqYGfn8UifNkcrR1DrN2LlT6f192+E4e
         NZeWzyo8Y2F/gsJuJ67QfsKM9uzCDwRXJ4A3ZE5SFhHCpvevnA5+JcjuPwvAVrzRQP98
         SmWMqOGW3tB7drg53XwQXaYche/pu1QhpK4onEWEzFeE9ZOB/ehF6dUtWE5480br7Xmw
         amJWhLqllGC72J0pdueJCf8IjCBhBP0bJ6i7kT34Q869aZvDEzzCzmo+2zYWFMASFVq9
         dEhFOV4OcjLrbVxbiqjQX0oHz80ugM2cS9fanhvay5xPlAMqhx6FV09U/FQI3kRBuYTS
         E7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787212593; x=1787817393;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBWfXrAtUJm/HpzLzPyZACtBgkMIykA9/uyMrFZEVjs=;
        b=FbkUQbFr5uTeVEhFly7RPQtTdpW8tx4Hf5sohieO43J3H8SH8CqKdhgpDGqhEpd3p1
         FQzA/ekt+mGSjhG4/jNRXYI6069ikL+KATlJUIvS5AKZU4PMeI3EwLJmTnsQJy/8l7am
         s5t8MUu8fbQLvbeHF+Fng+8UwMFGhBMcqLMqckOjIyRtr24+tecyPW1aJykYgHXmBXAT
         w7dc179sO/FMSl79bjsi/o8KqgGkERZ0gujpFfNkFZxMztjckB1OvboQZGdnyax9atBy
         rR6zLY3b2mMIxDS2G98PhJx2HcHela8xIWHq4qOsy/lyH8wbyHQFqTzcYWN6kQrgieis
         u0aQ==
X-Gm-Message-State: AOJu0YzQbkCCKDzt1dT1PMED3PuLQ7pGExFPQvCq1o0UKwf8oeRiTNJX
	RwVTCHx5228LZX8M75ZLxl2KCa/KEna2xeGzJvBR3EZoc/invGwxDQjG5meZ
X-Gm-Gg: AR+sD11waAgiGeIpBDdSYBEYq/+Wfh8JdBsAX4aEvInLGJRjV1lHtASWVOKYhVXyrTn
	N/wDyTqKSSlAxR/14f1JEpTgEGxkojplO9KAsCX/3+eQ3IJEGioJ9GxDYzKEUgkzme0QZzGmLRY
	pDMYwEjPxluFh5h67xxLOaaTVTgLkjMyqCc2hUjG7hMBEtIo0OssQBmqPjvPl67cLM5yAYPim5Z
	28y/4Fuo5HU2JZkYu+P2rBYYBZZLzovEYV71iscFvnsXe1SEmS/gAjVgLlm1DtTutWw3/QVT6v/
	qNGFBdAkolZuV+vk6XWVCnOVEWCDBkVSNkpWAH6WemgdMnspbqrn4ihtXgYchWSzLx02u16nOPj
	1QcNDnkLsQeb+wfqcNZmML207u5wgJFObc4sQf6JacuA58A2V/bAX1Y+NYZZwtYe/+79qziNeYo
	S7rKX0qU5Ve07K3VAqr7I4mJceADA6yaAc+0aVtBJhEKLvTS92LIZaC3BmiA67EYhHN5tX9YVSg
	rw=
X-Received: by 2002:a05:6808:2395:b0:4a4:934:b316 with SMTP id 5614622812f47-4b2bcb4eaf7mr9559849b6e.21.1787212593082;
        Thu, 20 Aug 2026 00:56:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.94.164])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d37c02sm1115914b6e.14.2026.08.20.00.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 00:56:30 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260819125629.49823-1-gang.yan@linux.dev>
References: <20260819125629.49823-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next v3 0/5] mptcp: avoid data-races around the
 sysctls
Message-ID: <c203264e-7987-1831-83c1-4e69563c0039@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 07:56:29 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/323425=
98821

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/892be88bad84
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1148469


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
