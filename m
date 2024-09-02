Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B661F38396
	for <mptcp@lists.linux.dev>; Mon,  2 Sep 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299116; cv=none; b=KjFrw4m7owZTMFH01zcY8mldaz/EPGiaXDSWHFr8K9XsdhozxvC2STfz/QfwygDPSAyRtuCwv6pATMARvMsVSgJ7mDHw4P8PiFUM9HrbjwOQMLMdaAm2oSjMPK+7XnSooGuI6j+HT/jHM41fN1/n58nvYgiRi7J7KsK0e3qF568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299116; c=relaxed/simple;
	bh=N6zg1rKRf8egQ8lkcHqv1ISehP8fgM5KzBj0BrJvsdE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=S9Id2WgCBSM9HHW2Ekoam2dtWr6xZRU43yLiArWFxXtkFkKfM7ZLCJwd9cuRKpY9om/zIc4GG2jWg4YqOtDv5TBACYQfKJaGR7bksvgLzYFVlV1sYbO6EjgL6AINvG/ilFdmjXEOhCB0b3gf2e+luCVCi9pl6O0H9Gm+Q0nh5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ4rvaXZ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ4rvaXZ"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso4593659276.0
        for <mptcp@lists.linux.dev>; Mon, 02 Sep 2024 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725299113; x=1725903913; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etBRuI23Ee9iFysBnii2+5UhvVuBVN6WUeRobB8tR24=;
        b=CQ4rvaXZ3fHMAfBqs6kXSsZAZHSpaQq5sDs1uyAwJcPPOS8Qw1biiMvd/1ga0pGc1M
         Vt0aE4lC8bzpmcJha1VRJ+y9TByMCitYe1XwQhWEIVS9c/BvlxxJ1o+Oq41ha5RWBDoi
         f36jLBIsqUYbgiAKdbo1GOpr9wMJguTFepRX52Q5j6wYQiKWXlD0vmTU6qDlwjtlSFTk
         cEFlOmPr93qHcZk6UFF2SFP5VIbIxcF3K9c7YyhuUUdjqQyuPLiNOciflcppJkfVXBO6
         fegppC+/a0mTs3tYvUdMaLV9Gf5d9cNwiLgeAK4xFy7MalDWYQpAL/Gm3eI+3Lq50IZn
         c7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299113; x=1725903913;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etBRuI23Ee9iFysBnii2+5UhvVuBVN6WUeRobB8tR24=;
        b=EAlLcW0S0eP9IYxbdkS+SI70mpHqtmQA4xi0e61aE9lmR6tKr6SUt6uaDB8pn/Vnm9
         Ll0tCxhGOoCkI2ZXaD+5V4QJ8mMT8Z1/OBwnkchNaLm0XUy/uxEZzHRptOC3a5Cp1Wkr
         8rgGkm5nlCSA4LZ9S5Fm3xPhYH+LqmYzdBhfn9PbLinPSvLbJ65ZyGOogqs6G3Muvn51
         AEqsuiNc8WAfrEPBg/PHiYDqhKN3d1xvIqMeZJu7XNYOScnmtCthvtBOBsythI2KJDJ5
         7HDIsKSo97lIG/zVilWp7bJ3W4S/BaeuKHYOYFsGOceJXhxSkW8VGTeZgl+xVfejZ4us
         drdQ==
X-Gm-Message-State: AOJu0YxRFch1xp+GAU9nevgua/G8agmvz5vqp6QEH9Js4o+TDVW1D6Uz
	VROUFnqA4TpXvFawL/HVHFu24Oi3dEV5ZuFxoddxS6ZD3pjj0nr1WrgZ
X-Google-Smtp-Source: AGHT+IEsyf8VyZ7CTaeO1bj2r/aJxhr5sz2FsvjcFwJ0eYQ9xpoq/xVNnnlK6T16x0ywXvTKHgc9Sg==
X-Received: by 2002:a05:6902:12cf:b0:e16:67d6:1bf0 with SMTP id 3f1490d57ef6-e1a79ff660amr13389871276.4.1725299113562;
        Mon, 02 Sep 2024 10:45:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.111.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bff43csm44409826d6.33.2024.09.02.10.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:45:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
References: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: fallback to TCP after 3 MPC drop
 + cache
Message-ID: <05c36257-e991-bdf7-940b-06350d05f6d4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Sep 2024 17:45:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10670881116

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5f9d22a2f88b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D885758


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
