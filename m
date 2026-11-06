Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973560;
	b=ygXbFz06ogWJ/KIt0De/vg652EohURH3jwwKvMC0wWhvPYfmyyQepei2Odx7b5nrZHRJ
	 2uJoW9B8Gheo/bVJVkEANrAYPkU1/Kjny1mo9CMHpsDsMRY7Tsb/DJv3vNgksO22eJEPH
	 uvPeFRiwFW/tf79IE4z6J0yIHTtKY0IbGBIgIUi3odm7FJKwpUDZJTqfgSvrjIcsKo2tM
	 RlePHp9ItP7VqpHEHqHdtSA9D4czM+UrM09z9+pPaD2K/rWY9atKb7wGCOF6I8e9a9Dh2
	 uwKghM+TnDl9WxrxGKl3copufrkepkj9Nsbi3FDlKYhuUN62MczdxYVR5agNI6ginlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=zvKZm7E41UvraxRwFcsJeeB+6C8QyLTZ2pebmlGJh8Q=;
	b=ti7Z+O1lxp8aEy2/s7sCL9Cijt3CYbW/pYcRC9+1CUT8YIH65TqTdSU8ac4TE6jhjQwp
	 0ud0gdXXU9DgnuYG95aOBHEfry8zcnmwHajCMoQroViAoGAtX8sOU3GCveqfk8qiGnxu5
	 QzYZX0YzEHowb6Mxgl+clTX84hRmFMw6s3hSY9eZY6NExTWIoOIY1ZiwbFOhvXhqh4Nrq
	 c2ox/eZlh32lpvhjFGD0qfYEpbQ317J1EkEbMQB2kzwRQSCJeaCNoJQ6v9lcaBWjQcyNR
	 ofloMXeyrAJ7yMTr4ivArx+BqxtFiK7/tRkDzpgCc5JuUp4PBxtNty7OU+9sPt7MCug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D4g2GbOx;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538A606EE8F
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 13:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E538A606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D4g2GbOx
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53394bffe0fso19583901cf.1
        for <mptcp@lists.linux.dev>; Fri, 06 Nov 2026 05:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793973559; x=1794578359; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zvKZm7E41UvraxRwFcsJeeB+6C8QyLTZ2pebmlGJh8Q=;
        b=D4g2GbOxYXzeIzC26GlwodatsjaIMLFXUS2MzMtC/cLJ4W1L/zUvqDRA9s0FD8lKp0
         KqAnwHUrgvitz7MZDNoiIbYViNqhe24kLaRC7WzoBRxWdYO36XF/C38+4nZqhhYkrfOP
         TOmPrMSY2jvDW2lfI+czv1zxNo4Rde9GowxdigRIto2IbJ41NBZVKpWjxtALr8cdoLXB
         aIxz/Y9AhRy1WiTBcvfnGqxEhRpI3J4OrT+vSs6ufdyGyn9flumuyvB5fMai+GluhXPk
         ytK082qV3XiiYcpqGzbhl4TWva3Ee4YkTTrN16sk/lfHysqCs8I4RKK+2DNf2u4tdPQo
         5pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973559; x=1794578359;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvKZm7E41UvraxRwFcsJeeB+6C8QyLTZ2pebmlGJh8Q=;
        b=AUKFqW7rQgjHoJSuX0C/vDtBuYcD/3SsxzwYiYRjTigx7EPCmNmzEPGgNLVQ0IcBC4
         gRPJMzsNxTZS36tMZNy0S5ZKeby/rb9xvBcPTLFxVJnDC2oj8YQgennUC8X/gFGK4Zhd
         rIkFsx87aV69kLQxu6bRxNOEKRtRdJhIHbDC6C6ww4DzMUdwmIEBXouLvBiBeKsp56WV
         K00um7S/gdZWpB8hxLpMKDlPB8K1DXbRSS5u6okhGgvHZbXINJ2CCGeQchrYXS9FD4uK
         SaH5aSwhXdbDwqnhRkNlVsjHEOGT+qbs41zAP8LebaoCdUmpgLxO+aTVVn868sH+1j3p
         BP4g==
X-Gm-Message-State: APuU4Z+UOcbMNFahMS0qL7h/bB2i7qxHM5uPNcQFT7ILYqA096CZ/Bvj
	1GZQGHR8k53ErXTp83rSTvSk+YhNX28qad9Jvw/WTDzBvMXd34WQuDlQWwBX
X-Gm-Gg: AYBFou39IzaMZWMho0X0k0/IsRurXsvZP9OCpFCI+wH4Y29DYtcF49mnku2Nts4aQGP
	4NcQ54gIXbgtEJeZM2JE80hySIwCuvbpdWVfIY0jjv5y11am5ZpJKDqnJi5xzbIdiTAdkcZMpAy
	oR1v0o7cTdaRYW8/kHD+wAqNIWaT95r+AL13LkuwWj1l6P9/Wb1H/HMfqofHMDyRnntvEWXLpxC
	zHjxRJNJbawV3W+qfNsHds4VO+kMM8nPWe7RM8DSeO4WR7HYuSCpEg8W5+lnwyEs+NPtESRASN9
	F64jVPZLIjSLSJ6/KeCJhn8W0B7S2EQb9IFHwwD1m3wfk2owaT3eTRdpjZZgjyClDA/HMr6zUxA
	DmtkPD8IEfp8GmgCj5Jb6oxrWml8ULxsQQfPWp5DZ7BPR1XCzJHtIhRs3yCeaM+YBEn+Xnu8hU/
	BJHoOUSJSPUuKcQWVGH40R27CJpY9b5whXaCBliVFPf1qR24qgSijM2ygOdYCwQEaRAaTQUbHhj
	QcDG4HDCyZ24v2fhsjcTtRMy3J+yGt1WS7dSyYdnupFfdbiE2IakoQnh0+8UAImZiS6U3xGGMrK
	dROFS/viLU2E+W7ZnmeJeDPBGkDlPt3BTZ+31wjX7Sg=
X-Received: by 2002:a05:622a:409:b0:536:6013:be8e with SMTP id d75a77b69052e-54e10501ea3mr35977131cf.1.1793973558884;
        Fri, 06 Nov 2026 05:59:18 -0800 (PST)
Received: from github.com ([52.149.221.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e1ff8d0e2sm21351741cf.0.2026.11.06.05.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:59:18 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793964796.git.tanggeliang@kylinos.cn>
References: <cover.1793964796.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v22 0/8] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <2ade597f-9be6-d39c-3df7-a5544033af9b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:59:17 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/42214270095

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b7283e79ba=
f2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1204114


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
