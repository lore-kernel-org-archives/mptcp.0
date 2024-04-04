Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A112880A
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238856; cv=none; b=hXgHtaIwbxa3Q9poSoaQPBaorJGb6IyNaSUCwgmrJm6immICZiP10dBnRPw708XyF49Fawih8Mn1yci+IHy1Ufj5XjYmkDM+N47V7Ei9S5xDf1Hu2DR0y+Ax+dHbtw6G41wEp0CIcY4UHIKvxHCfeEFckMSHLyC8bm0FoFvJ7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238856; c=relaxed/simple;
	bh=AfPJOYpi0YuCDhN7oxUssYhzUUIYaAXQkNqok2TguUQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AuB3w21/WfW2NY5gBgphxwmVY0AtT0SZzopIEYTwLfLJwpdjDed2Zx6O8Fb9x6DLKgt9Lg/tWXl0NqPoC4+J1JFhfIENfzzL5ykuJseWczzpUmDIMScEs7lK/Ql8AJ2A6U+4ceq9BgHHtjTXDYT9qN100brSRGOBfowFHGHKYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKCWU/BO; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKCWU/BO"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43448ff9be3so6211721cf.0
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712238853; x=1712843653; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frU7rjyx4XcNBm7TJ9/Uw/RMnY/MQKk0RqQ7CfH2rbM=;
        b=aKCWU/BOaNLuU8ygOSzGWo9BHZBc4zLr21dthdMH5d6zLqYcHf8dZVYRnkFY6GNWWO
         4NFZkKZ6E9u/ig5HWXnOUOuAK9yRRZo/PgUBCvbMPMkctlijv9lbhjSge6Mc8LoGdElC
         SYBSI6w1ZAJzN3W3EFeXdV9E9uauSDJZvvXC0n69p/rN7C/9F/UokqXNByC/UihUaE5j
         Xr7WW4MwPrM3ErRye3N4mfLE8/upA3hkLleSmHa/f7K5gZ85L3cKusyS5TNDjDTMRBwR
         mNrP13piRASCzyfv5ddqhUqtucbKj8BeyoMTqklzLbF7qCq2J5ANzbV2ypizepmXCWla
         HD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712238853; x=1712843653;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frU7rjyx4XcNBm7TJ9/Uw/RMnY/MQKk0RqQ7CfH2rbM=;
        b=eWoe4MD5vOl4oyF3q+VVFxzGjwOVdBMrbH1wnGTG5hvLnB89YzlJQHcxU+Am9StzKu
         ahvXTMAXivie7I3AU+jaVzwYJv30Z/h/FfPfxFhuh8TttzVLutRuigMoLZOR9HyjBuwO
         J+VY3Zqwcohyoz/MqfTZWgdUTmUUj3bv8gBokG+onHFld296Dy7wyd1X4nZmS1WVhPzh
         Q5fBWuBlGTGm280WXPPEs23+DGfhfk0kWP/ViI4l9MrCBr+Mq32RNt3aXrjsPnpKEWw+
         cGd/YL592aR29hSzC+4f65lSCQvSWksUk+0Py0DaGlY8/7mGxnMWimShCdgna7HrUaXw
         vGqw==
X-Gm-Message-State: AOJu0YxroG2T7YMfb3LX4quTmVnJPL4l0MUKoBzlyRvHB5t3u/3TuEWU
	ejQfNz32CxymdsqJbn13ih79GTp+AG9Raxs7XVRH6oh6zR1n9+1mf/g6R9s=
X-Google-Smtp-Source: AGHT+IF4CysiuAypChjNis6SnXfTsf7oI9mUDryn47hfG5c05h/b4zGtL4DTLq1qdZEEVeKAxnnIzg==
X-Received: by 2002:ac8:57d0:0:b0:431:2a27:47f5 with SMTP id w16-20020ac857d0000000b004312a2747f5mr2568489qta.16.1712238853605;
        Thu, 04 Apr 2024 06:54:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.39.242])
        by smtp.gmail.com with ESMTPSA id dp10-20020a05622a47ca00b00430d494c75asm7631204qtb.19.2024.04.04.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:54:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712235379.git.tanggeliang@kylinos.cn>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 0/9] refactor mptcp bpf tests
Message-ID: <9e4fa571-d821-92a6-a0a1-9a9da87becee@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2024 13:54:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8555399820

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c7b5767b70ce
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D841431


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
