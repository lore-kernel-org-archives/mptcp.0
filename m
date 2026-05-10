Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4A257854
	for <mptcp@lists.linux.dev>; Sun, 10 May 2026 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778406897; cv=none; b=nZVJGS+ArD/KHNwsqBu2lbh6BFh/qRvZm6ob0kNgsFOuXrsFsSW5kgWfLm+Lt0/cFCF9jjXUg13YRWRrPVhjdsBRNtD5/AMOf3bd/6ctUDyBFWK2gU9G/7I1otT00fGO2uBrVtNV7KgUqwJNvSUEAQc5SC1gPu9B9hP25hsjpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778406897; c=relaxed/simple;
	bh=XNiDW0z9ayZuA6TUnkLWwZEGicVE4hHadW5gnab76oc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=VjRUqmtkWs2veFc42X21nA/jLifUR5LVUrmQ1f1dlycTA/AnbBqYhZTExsg+HIf+i47mPz+P18Us+F/LVzA963ETNv4c/siEUbDPOG7hVDw2qVr2wOc/9Vu1sFMiOPOmVyV3gRZZcXWsRpVJiXJnmbNknqyq86seOfUSdSA3BzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJlt/Vub; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJlt/Vub"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ee1054627bso3247375eec.1
        for <mptcp@lists.linux.dev>; Sun, 10 May 2026 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778406895; x=1779011695; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrX74h9biaPO6xVPrDn4C/2XL3iQ3kW264Ab5WPMQjo=;
        b=eJlt/VubH+s6ttVTozz30fU/uNQyUJCFdAr4R/tnXJ11RBbX9yA0vvmdFvffrAgkJa
         aoBWsE1fqVHSypNH5FZOHZ/DLjClyGGciBRoF+YTuQsDT5v7gJuGBLkdwu2asZUdaOZz
         i9ki4c2bexle8NkEZapt2JyXbJyFWVEQ3TpPOzne/oMohIzZErPZwmDyV4tcz3iRUoI1
         CYKrx0xsGVS0yalOndubmMxgxxpWHLuMeef69QJ2znekJSnm49vm3I19mYBB0+ukZZW1
         +2Z7H+NzCtRDMs3M1tvMJeD5y31qO88Iooe1z3rUEdEJUKEk+8epv/wvpJcjMn7ZyUzG
         PjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778406895; x=1779011695;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrX74h9biaPO6xVPrDn4C/2XL3iQ3kW264Ab5WPMQjo=;
        b=LvIpd4fr29XbF3wM8wvHCPOPebfd0V0jLpBZukDzxueZIXsnJG51CHQt8IQoDbWMSi
         1qzX86wZniXO1UEjPXpJnrxNiUw5ZP71jgMLupkseVC6pdxabpSUZGpL0zBkr66fYgHg
         SFQp9onoML6XHbR2S2BSRms9Ro5zGJJX6n7l0j5A9R6SwwwmHdriulPNYddOtF3YW+1k
         qQgRsRtwIN/OJvXwniXcwCWY0SBdSU5G2BS65vA0lB3Nq4Ey8ynz70EjjnC6GGahX7bp
         aINHu8icuiMKl5Ma29VmGPPEB7ri3qBdFMBNeErqUvg0kz9/K06GkjuQ5IgWOIwWQURl
         jAIA==
X-Gm-Message-State: AOJu0YxmWRKf83oAH+T2ddSGVN6/zg5qvUQGv31erH0YDo0fh8x2h1FG
	6VIQN8CYIjccBV9qLkIOFgLGxpxTwhkOoV7HNQLXEp1C2WNkKkvmlM6xQpzlUDo=
X-Gm-Gg: Acq92OGURjjXW5iKfzU+Fg0e8japZ5a3gS0UEDzqSyGRweai/Z2rTJ6xWEsHLxKrQ0s
	XOCWZyReBO7Ka8WNTP4jWOq0fctuhZ6nz/RmurYoplIsTbF3zZ2BY2MIX+qQUANh2Cr9CVQ3PI/
	Vq+FqrfaHiK+b//AFWPcPwCML3ukffwsxEUA9HReCmz7iZOzLUp/qQCaCvSTPK3BGnF6Fe6nW/M
	/wFI/sHdhKBCe3C/bOHpdq0f3WF617KgBF3wNr7v/pn/j7yov7RZyosMXuNALbAXY/Q2NZneQbD
	qy2lOqIfNDkNvf7JtkVOZ8XiS5wJIfsmIsTPl4VVGzdToifPiPKLLrC6USLiszHNxQsdfdeZuIS
	z/NcUyiGFP46V8qfUvSqeWQxR++5baiLkbBxvLNuqr17FHxxHs1bxK9lPdrC8CfB3VozRCH4Aq2
	25ht196DCSNaeF2Ela6CFy1CzBz5Dq0NcTgAZS1eVVwyzrlg==
X-Received: by 2002:a05:7300:a507:b0:2c5:c532:1fe1 with SMTP id 5a478bee46e88-2f6e1e320dcmr5412272eec.3.1778406895465;
        Sun, 10 May 2026 02:54:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.14.76.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c3b301sm11203089eec.23.2026.05.10.02.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 02:54:55 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260509183335.969018-2-shardul.b@mpiricsoftware.com>
References: <20260509183335.969018-2-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH v2 2/2] selftests: mptcp: extend chk_rst_nr to validate
 per-event RST counters
Message-ID: <10165c54-7617-329d-b93f-5297b4882288@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 May 2026 09:54:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/256247=
08095

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7d57f74d5d41
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1092095


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
