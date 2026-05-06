Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29136CDEB
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778067747; cv=none; b=T0RJVQGzCc53DgOmnlBbHxhNqs7kPSeGxd+K7pUZDnEwQZ5wh0G0jVsr6S0QY5T6UPIV89Slv91HQ89+nei5dMsRH7df7RPz/4yJKMR87ssgPETBQB5Dcp3SQ6cvz/rxxbcEM87xWNH62n+Ybaegna9BmRizeUkOJ5ThzFjXVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778067747; c=relaxed/simple;
	bh=cFEliZ/CH31J3E7XMcQlGiXo89QWTjxV57g4u36fL9A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=fCYPQtHx4Rie37Rd7aAhwmPWGX6eyWABv66ScqEU5OmnuhogtKPpIPHyUZ/q92JtylON7LKMN+1KiZLCzJ8v3+/2z9yC9qigmjJTrcZAUqGerjN052qbd034mcaSx7gyiZ0gslRuyjd/cpc21LBVxqV36Y20LpeT4aRKDNCO6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO8AFsg9; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO8AFsg9"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c19d23b19so9351845c88.0
        for <mptcp@lists.linux.dev>; Wed, 06 May 2026 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778067746; x=1778672546; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z32lpHCwcB8VVZKxM1S4Lo8oLHLi0hV85Tk0tO2ksZc=;
        b=GO8AFsg9+iPHM2rT9NktFLQgMsbKE11VqXEh4yR7LwLFn7/4DU+BdSA9LRJKoIgCnz
         5ZG7WYKBxE7GN0GfX7mlbY9k3hBuqCOMYO7Ik1CK4e1ymoIKuYbGh7fJIi990NiIXbeQ
         hNIft4IHwCPmmv/oaxIbKxUwgVlI4haKX1XsqLMTKSCpHLfbUKnTZ0okYreF+us1ZRqS
         rT6AMiThleQbL3hb7wQQVUqoUUES8YudIMj2pEW9ECI9hunU+llyhcGvE0t7lWsVDYR3
         T9HcX0qjH3UAvccY2gU/fhcEjHVGwlAmbZo438FeQk1227KNsqR8KnNtz1o8y1jOX1OL
         2mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778067746; x=1778672546;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z32lpHCwcB8VVZKxM1S4Lo8oLHLi0hV85Tk0tO2ksZc=;
        b=IIdRv2QdHkXuxk4q3PubixThOkg9Z4eEvO3/KpHXQ/R4gU9F9l+EXBw9SYq8Sq2jVl
         2S5DBr5P1H5U8ggBGlI50b8jcwVakrOlzAiSsFazJKa0dRwj1IdZBYM+Rbs00SxbjEMO
         TSJBW1+5dOsCGmR+uiZwQ8nrb25lhNhAUpX7A8Lmqbp3RR5SDB5AAPqHn6dfS1K06ZN5
         Rp7Eo6pr4sA2phrueqLYZhXkQmH0sUifUrC4brgjZoYG3RvBGyQv8v+/n0j/AyAibQEW
         2f+Fu0nXhaLbW7FxcuK+IXgzesd+xCz2g5n9UCbFXPSKxH5WzBoCQWWIbxmc8J1ONr+m
         W6hw==
X-Gm-Message-State: AOJu0YxtkUC/PU7NTNXmLksvRqmzd4/n/dmbP0EQ0uEy1sgTFkt6CJWD
	CLd6NxeuzReSESnU4p1p+h+bmKmJAhBbVtWxBTUx+p7Ed/aAHysVYOx+ALxY
X-Gm-Gg: AeBDieu0FIofQWP4+vA5vUQM4q03oe1K6DdK8Rl7DgFUs3/G/PZm6PxGqi1ybXf5A7Z
	8ctaK8/kSDaz9i6IGhaHH80mXZRqNwt+lOXiCdN1+L/1t+4rZ8UGEa1hmKpqBCJ1oYiGR71+WcE
	3ZIgKQb9439g0NPheoPsHmZ4Im7BP3v5BubKZAfleU+d37HBgVOWMz4sny/BjyoWl/bVIKC+p4Y
	52dR+ahOI3QBT1bmIF9vAhj7NIKXYQJan/cWcDgNH8AqQ4eJlJ4xaF9fTVDsL2Nn372FrzHGE5F
	sPPKKoDcg8La8MHSRkey7d3JviMxZ4QGF5lW/fkMHFbM0IHvHpp/Vnmg31o6mh92HfOybnsbTH2
	9cPNBrgBlUis2wbh6wMxaJg2mfZLFvUCVeYdynX1NnKQjrXBMx53yp6IrOo/KJ6A2pYg15gt/6s
	m1w4CxyajYXDKa+H99+zu8gB8od74h1mHigIWzK+TtPSiroA==
X-Received: by 2002:a05:7022:1b0e:b0:12f:1f67:e747 with SMTP id a92af1059eb24-131a6af4231mr1365231c88.40.1778067745415;
        Wed, 06 May 2026 04:42:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.50.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9679db9sm2899042c88.1.2026.05.06.04.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:42:25 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260506-sockopt_lock-v3-0-06bd417c6d63@kylinos.cn>
References: <20260506-sockopt_lock-v3-0-06bd417c6d63@kylinos.cn>
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: convert to sockopt_lock_sock
Message-ID: <01c4dee8-289d-a05a-9ba3-f1561b08ef18@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 11:42:24 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/254308=
78759

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3f21f88a724c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1090398


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
