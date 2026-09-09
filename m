Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA01397
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926180; cv=none; b=B2xw4mCoqFE8YNaHufQEgQRpJZEL282h0mGp/21QxiskCBw8yFcgr3enNsYv/LhhVkOOe8IwUFqHXTW2cQTDXPKmWByn+DbEM7qBdSMDVs73VBlN5/7aTsap7zGViekyTPqmL72JEjFForarretIpTFf0IYyvudsUYMbUl6vYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926180; c=relaxed/simple;
	bh=A92Eg/Sw54xDML0XKVMiqMbrTzEiRpwphXq/LVKcwiI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=onuTP8yu7heKG7e1ZbbIA0W34PdLdFduPCHBrRoUJKaWTQHadg027v6q+DraaFF/o3OaUJumdKezY8a75vDnNFv7CM6KXb70+5BhD0VRc1EPok9cIMyXevN6rEYdWp7nJzbrkZBY4xt47YEfc5n3jMDUBuMWK5uPKauGQIdwWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1U59iG7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1U59iG7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d942c7cc2fso46224245ad.3
        for <mptcp@lists.linux.dev>; Tue, 08 Sep 2026 20:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788926179; x=1789530979; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ehv7q1UP9EWnC67eO9JR/lAYO6iEM67pBCPl1LnQxPg=;
        b=j1U59iG7YfRaOd8yl6RNtXiSi13CQiyj1WKOFxEcUKjk5K7VcJFSVpL4CpkNai0rP9
         3TMSlqzLmZUddx52hXjcfmLUBstXuaLLL/uQ+Zn1Y+863cJcTdg75zR4aH5rmy6lTATm
         URuuKL3X4TcgTfXqwOG7GHKQdvXQobAjRjwFuXITOUM8Ighqt4PZyGo3Q7IsnDtLNozI
         Ghvt0d13DWK+TYcP6llIWwyXNV7WsGPlx5oLFq+yBtUhJHw2j38x/i3psRQ47col0fW3
         zPf6PNf3b07ZYku1nuGwXJOwzfZiaEzhHp3ipXk5gEcHAV1kRxpVID6aNqF9W5tEO8WI
         v9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788926179; x=1789530979;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehv7q1UP9EWnC67eO9JR/lAYO6iEM67pBCPl1LnQxPg=;
        b=WFhv8vPvrr8qevLjEDRLOzrh9Qx7HhskdF21Aq4j7YWz2VdjHYZFUkHuvuQMVPFXT+
         yh4b/JKL+XFE7izJkswPolRsljhUoHLGDYOgbIYVFw2L8tA5qioHrSE+weR3OTTNduTG
         2T+JkB3UsLtrvzhzWN0dbooRiPpDSEqxFE27pSMrPO74v9fgD+2tlof1mfNhMeHqV0Bk
         b9jDYHQPQtBQIjSoff2vYenyjVNCMLhwCYV99UJi9ZwKA+4PRZ1ToOn6KhIXKBmZkmuW
         5OdAOkz2RvraYEQr7lgKvdr882kXx922FM75y1hAlIiaFdAkUr8NO6GYpofXQfZJlNYu
         aYiA==
X-Gm-Message-State: AFuF++n4mnmgGvWObzZ3/pRsriefdwN3/5B0WAdLGwZqVWUORsV/PDZF
	FCOq9R5G9jA/w7OQCR4cU3MQgOzGy3zDMTc7zYwR0QV/+m+D6IdOzcKs0reN
X-Gm-Gg: AYBFou0zKCGOJbgs5ck35OFALZTNIOcOaY7HfDGkz2xlqmh8+B5V4tS+JQ4Dmt/i0VL
	KWIdcHtD3InSa2ZsX+PMb4cE/lbeiHPv3VMZpuLm3j5vIOrawhMugknAmH7+2DX7ICkADQvT0e3
	MwijfkRQmtHoCi/4XXUp2ouRHuP6sz3gyZ/GMB1PvywMCbgjPxXWOAtzbGr8n2XhZKS8v3DrNFB
	M/LsYiaKvJUIQklMd6hg18e2Iq1upMLdK7LgoIrxFPVbPpa3unVlZYk19WKY4H+CMyzvllfB8NE
	vOB2GMaQtGf4Y/dNaqrQCFcrx7BFLj01qarOCcJDdbhPipWNRPY+VflJy4tuOoBeZKElYzJCFNP
	1FsC5f6ADkvqVqjFx7RZwhFLsJbJWora6MdbGQ3mQCeq3aKS3sLUFyTzoJRPLbPK2uRu+JLQDVc
	WSByZO4vX8L87SPa8hPW/3IxWKnflfc+SLjENifaAMbCHhItadYBcRnDJ+x6lFJKj1LCk4gKIJ5
	VQnr+LXIsk=
X-Received: by 2002:a17:903:3243:b0:2db:53a0:785b with SMTP id d9443c01a7336-2db53a07a53mr245326775ad.14.1788926178569;
        Tue, 08 Sep 2026 20:56:18 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.63.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1cdb4acesm62707095ad.4.2026.09.08.20.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 20:56:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260909-mptcp-shrink-opt-rx-v2-v3-0-92bb3009a665@proton.me>
References: <20260909-mptcp-shrink-opt-rx-v2-v3-0-92bb3009a665@proton.me>
Subject: Re: [PATCH mptcp-next v3 0/2] mptcp: shrink struct
 mptcp_options_received
Message-ID: <f085fdc1-f640-90a2-0953-359fa6a1fd16@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:56:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/34305335821

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/43ca63ab73b0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1160956


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
