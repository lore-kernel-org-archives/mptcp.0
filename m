Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8A3FF1
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049195; cv=none; b=FiXqMQ6+OgvQMXvNe3PisEPz/P2vhGI8OSKfIXbXaI1ihvgpKEwqu0KaybU3jxT/pld394q3/w4I9sHuxCPMf1GAHXiW5SaPSYWh76j0gbuTany/aYtY7Kb1LXH75EGZ5Iynio2lTe0wTla1bcBW0Vz8iURBeNfFCFq1kuIEXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049195; c=relaxed/simple;
	bh=pDphyqWuHsViA8A2ipRkDX24XE/8ov+Ycarm/hPMzRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GtL1rS0yAhmNqA7Pk975qRZWIPE17zud/nBOz3x/Ls8mI1I7/7qs8D8XGchSBcoej3WfYU282BusZGMVlfeIhQWSd/Xyj4n3BS+Jh+V1u9+EhCLH+XjHmVpkoZqAnUAb+j2dJVpey1FKc7YAYNuFbIveUw/yjjU/jv2SyTDGL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA+tHoWA; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA+tHoWA"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-516cc5471bdso109841241cf.2
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780049194; x=1780653994; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTwXbVkX9IJkRRxkEDBaKmRrQxkFVdEv3GW5M1FAr58=;
        b=nA+tHoWAhGfIDdZXv/vAfELkjguJtqffYSGOM/N19B7cqSpn3ojAKi63c6wUcIaU9i
         8LI8cgfmg3vAGwPCF/kFtdVytVvz8aoxl42IgDzv+qEFxYuX0amgVNc/RUKYRvq4pR2w
         umQwsHRi+/Uu9nl8qKP6zEBlaEQmE7KHl0/EeJS2q3hF2zbx618gHlYAlV6IKi4wONWr
         91MgF/Em8KrhTXkWeLLlIyVDd8WeQP5mHjm+jqGGfF5P3+HP3TwH8QzWDyaOe5pc/12X
         QkiYMba75DIKLmS1hk0vNrLrj03/U1AMcSf1wSn6lyFbhYfM6USkQtHlJuOAfGRsv9kc
         SYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049194; x=1780653994;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTwXbVkX9IJkRRxkEDBaKmRrQxkFVdEv3GW5M1FAr58=;
        b=JqxgzcRNDEL0NlNUiM+0qA5ojKS8f0dAwxiJb2XWJsstYDeOciu3w4+QP9nb/j6EXg
         y3oxEbV6/4wJhSgbxgwCLHdTf2KfUXnzJCcJCe8DnsdwxjU4FEEZKz9K76UFDU8J/sUO
         ZrWOOcGdE0spt6PGpbiSVgR0p+Ww4Y6VhRWMZemKxARl9K7iKyAKsgGpv+1my2a7ABTt
         VGpJsAMo7snbUqZymQdKH+vMfe8QYGZpQpxv1v/H1vuKNhOmJVLeRxDqdCb3T3Zt7bu/
         b2XmkyN5SYhtcZC6mIEhUyVLG/+DttegUMZ9+AsnLw+OlJ0oIu2OPs75vUO80k9an2pc
         B1fw==
X-Gm-Message-State: AOJu0YwL7Icqme8Iuw/4TUt4BsFH8k8H55g3LD1anC3XfHdpOWWfxGFR
	XVqC4eC3+Exupnpaq8qgIkqEQtyh4QoIf04FRVSu835LoTNMrkZ08Yk=
X-Gm-Gg: Acq92OHp0QuiXPZrh/hJay6Hp8QOegwe6MZjuSpirgTIAgr8jOAszLnRMAKO724rNgj
	doY4hKhp1tFyIkiDb0InehxFC1o8Yw2qFqYr7/B7BuvHSgRV3e8K7pYwtRyfAJfAm21GaCPZ7u0
	evaY1S/j01+6HN7HzQTm50Dp/zqjxB8BZv/6jn/qQJrNdo7r+j6lBfWo93tKadvHfHTG73ggS8w
	uEMWbhGoLHMhtJfEeSJhqntGz6t3lIrmR4RE9pZgyk1ufx5Cp1LVi8OaHR2X1+UaDIb2DdmMP8D
	OzjEajP8yU1mShYyoxAK8jjNdAkk7fnN73t8+b+LEeLwrmadT4HgS9+BEGeLCpCr3sEQdsO0ygx
	PTLQbjymJzK9MSRlw5BqyiKkxPCPmeU5Yg7+dNF+FjYVEbpecJVoeT7Raea9cnTiIOM9lxwGrA3
	y7alsrDuD02VeoUFZgXP7g86GdFAmwP5vOfcmdCrYmkNWb/So=
X-Received: by 2002:a05:622a:488e:b0:50e:578e:bb18 with SMTP id d75a77b69052e-5172dd5140emr25831691cf.47.1780049193611;
        Fri, 29 May 2026 03:06:33 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.160.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1c30ecsm10399926d6.25.2026.05.29.03.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:06:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260529085415.1562229-1-kalpan.jani@mpiricsoftware.com>
References: <20260529085415.1562229-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v3] mptcp: pm: drop pending ADD_ADDR when removing
 id 0 endpoint
Message-ID: <0ed1e42b-fcfd-038d-59a4-a6592a017f78@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 10:06:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_checksum =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266287=
89956

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6e2e266d3b4b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1102741


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
