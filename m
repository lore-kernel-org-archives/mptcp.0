Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4844C4F2
	for <mptcp@lists.linux.dev>; Tue,  6 Oct 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291250; cv=none; b=nRks8+8AwnZfMJYeMXWqSuoQAp5vaAVKsZpNZc8AfzRT6AjVxRYrsETe1imZCNjqQbuqiI081IgtGrXWldzVzLgoW8x2wvIuVxhtQuobAr++1HcYhdn6HRM/y0ymnPklqHgUHgG5Cp7QVJQnf7T9kPU2sgyfEma/1i79QtE7AQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291250; c=relaxed/simple;
	bh=SZ/c9STy9JmOwdOmtMglDoLb18kjv1klXqsc3ruNR6g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=aqIQItxefnh9rLFBbu8ESZdFvT/4y2tExV0MqfNkt96z1FmMLdzDu0vmPYgoGTsoyhZWbmUSnfMM79UUe+02QWCLEDnZz1eeKg5YfbcKgezNcn6kNxUKUsIa1cs2QZOu+6EiH5jpf5Cl2nZtA8TWIEP4TwxE5zFPRUbPUMgVVYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9oDvnkv; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9oDvnkv"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ad549a2119so5529597b3.0
        for <mptcp@lists.linux.dev>; Tue, 06 Oct 2026 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791291245; x=1791896045; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qrOJ0OcgtgULSivAEBWXasMG6IcIwGvKxK2j2BFpAHw=;
        b=R9oDvnkvH3WaIbln0L0z04FE3AuWxw42EVidd5aYBvVyed72lSPIA5zBF5hOxfcfeJ
         V1dvimZuAbWtt5mslCbQchuGqUKwPofnOuqNhwANhqcwkU6oWGcvDBVdcExoM+PdqvuQ
         3BHCtkQA+KiFI36pGHA7uteoqPSUD2x0pNOulE07+nMYdPgYq+qbWKIX0KZe/vMJY1c+
         lllskgBcm5POJjSFBcAMqGyDOHogKyFMAHr7urCXAudccYYpAGz6Mr+qQgmOZ5bZqrnd
         hbWvmAHBLDk0vTStPmHSObe8olhII75K5yQA/uUgN66KfsJlosr+33KhDen19V9wk6/+
         EELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291245; x=1791896045;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrOJ0OcgtgULSivAEBWXasMG6IcIwGvKxK2j2BFpAHw=;
        b=ToTFr3ZPBaOo/dBgdeIB7JEq9La19BMVNJWcdB14seflO90UW52ZcndbS+GDGDJcxm
         cLg3yFwyRsb7BT8dc3rg4xIa0txul0A13zsa/XEcpfOOSeLa6iIYm1iqPVRBJSI74V+K
         l2o210Nmy8kla4x/x8z3U98+q46B6HJ/sZIUDML1sOaHLdTx59QEwKwprBvWWshp5/8n
         ZIDpwtr46B4E6NRHcA3CiBwp3TldLkkjGHezj7THJuGZZHXrn7DeSRj1xjroKIYPWsIM
         kP7qPYRaRwHRQR16ZK50/bY9jPOBh4c5GkCpeNEk8uJ4Bu1qbr0Rib47ITiMlOWT+sR6
         mJHw==
X-Gm-Message-State: AFq9FYJuwyFh28zhFEm94Z3WszwLdJGn3LUTpmkbY86g5HSyWD9xa7A7
	mVhGxyJYBC9ApWhDwRsbZkSo8XYGgo9EOVphtZvs3mw4YpRua9Hnf4I=
X-Gm-Gg: AYBFou3UNj+pQxGacm1QPrSvhoL0szqAU3e1EEXL4h37IRQfFbIbCa2fDHfHrNH2gez
	Ru1lWiT7n7TROG7yhn+BtQ1yoZyCHGKwz/LmAJ6fc/q26pRQBcCnPKh92ZKhFhVsfJvW2zR2/Hg
	LNMei7VmZXt4NHzzI1uq9QH3woL+03QvURe300uxu/BYH1sw0+YWsliSU/QqgXpDK0queZOiXeB
	3hySFAN+JuxLe/8uGJojolX+cLOZA9PelQFI/WrkkAB1yhdPxN1ojaE6ArIVZWNsBRlU7l5aqBu
	mx3wk6qJ20eaVo+6FUfrPixUd7FMu/T5peE2wknfKLcsoe/rOSojrz71n3CvxJIDY34UVu7kFt2
	NvZzW/9Dd5wWt9TBadMfgPThekG0oXYsSzupJxIVpY4B04oAM2trk1srCloJ4SmpQ5pNgGyQSA/
	amiR6OeVgnBKPcchHUDcFcA0INxiTXx3dkl5edkuv2cg88rwizwCrjUfAAMhhaxqQD6ErcYy65J
	94HnsVjoA4Y
X-Received: by 2002:a05:690c:7001:b0:8ab:43f7:f061 with SMTP id 00721157ae682-8b04f3ea47dmr5472587b3.34.1791291244734;
        Tue, 06 Oct 2026 05:54:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.142.232])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae334e967dsm51272547b3.38.2026.10.06.05.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:54:04 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yiming Qian <yimingqian591@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261006114409.117190-1-yimingqian591@gmail.com>
References: <20261006114409.117190-1-yimingqian591@gmail.com>
Subject: Re: [PATCH net] mptcp: pm: in-kernel: fix C-flag endpoint
 accounting on family mismatch
Message-ID: <b7459ed6-15dd-1b6a-106a-b9ad2f5295b6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 12:54:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Yiming,

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
et-next/actions/runs/37460664542

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/823f691bd2=
d3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1180261


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
