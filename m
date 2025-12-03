Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB02F5A10
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790849; cv=none; b=ueq2YRJJxch9pVmipmk/Oe1Das4HYVnlZgwdQZPP6qvJHoZ/3YQUipoDA3HAmB8CoOWIn/fp/tCLZqQ9rZwcfVHAboR2nzqqW/zx6jvVfmReRRDTo+1xSFDfZznigHGPF/Dk3KeJnKE6u4AmLmWUOeM3W7geC1ExHRAb51x9WLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790849; c=relaxed/simple;
	bh=omyDSy0Ee74tikzc7i2OjmE3JEchnoa0CoFmo9Oe9Yw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UuMq2CNyn9CgFxHyuUoqPNxcSG1puJzVxx8Xj147k9LBhqqujZBDZkLo5RrxMKSmrmw8gbLuLiNAZrZZtsRLSzHts3RP0YqvD+jLv1xmTSZM9ZYypzP+AqBB5HnKCoBtaM5FRN32qSXEII11GzDZrmPmmEjtsf9Qr+t07j+lg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzMBflUQ; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzMBflUQ"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-4ed82e82f0fso1294061cf.1
        for <mptcp@lists.linux.dev>; Wed, 03 Dec 2025 11:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764790845; x=1765395645; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCwUprFomN2s5vIdjufKSSZVMaCgWoCkAfU02etS3ZU=;
        b=UzMBflUQcEcqay96KiajGPN2WQMvr4RLP9W/Z2VGqQ277Wr5UBzUe4PA7Zedpsm12n
         bLTHz/PHqfnSFHd9vR040okqugpfahXQYTOIxR2sPPHlmJMul6F9V1R4CyL1GQhOPXeg
         apQf8PRO4nBAx659NqhsSAn/aomi+I1M8ZN+iRAI6auPDtQzxYJoxkH/3UtrA5YGBPNW
         OhztHuwXdSYug/6cV1C5L/FYEZBcud2Vs9pmSTfncM2HNqbShpMc64A73jjDc2JKXyhl
         vLkTER+siuo28GHZAoegqgR0/x9wCDI/iiwd2Y8oOppCZe/ppH+M8xjbYL2LE9yZwV8N
         4Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764790845; x=1765395645;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCwUprFomN2s5vIdjufKSSZVMaCgWoCkAfU02etS3ZU=;
        b=M0sSPMt/ymxspx6lRwKENxyXbAJvnm/6wz55kPEPW9Gf+Qtv/c4m7i1WKF8b0ngtE3
         5+f0isK7jXHQiae2X7VO6cSws1n1f4qDDKOuR+F9jZy64iLudImXx2z+dGCWlDt7L/Ta
         9fb0xsDGYBV0egdsdWR9icZ3kaJ1wRAaGP2vVMPrO7fipm/Zw/6TVMT0Yl8zx1ktlN5b
         iH99sTuyi3FDx7XLLl4kh0AaaejKnw/V4A7H4+UQ6RIUdRiQXSAk++SZRq+w8phtJY9Y
         uB+u/K1jL2JbsUZTse0gjj0PCX0iwEtsR3GtCsbiqRaAGl5rY8KztEJoDGG14C5KE96x
         SAIg==
X-Gm-Message-State: AOJu0YzC+8ODDJsvSPRD88r9ypwls7Uh+DkOJLsU2R/34rN0npFsTPnd
	08GJeIRMA2yNhexlCl3MXE7PRFl4+kMKZRQ6NrPlOg8LE0+8Tz281qk=
X-Gm-Gg: ASbGnctBnobGm8SmDEX0ugVRISlfF99BmoV/kaTr/UUf9CT/tP2HsbS79ZiISJFavKb
	Aw1y43JiyVDFai67vXPFtvkVttRsMGN3z1jPguBbemvPhl/iHIUDBLl1EVzIdczdneSx/tmpBCy
	OR4gQBRMuKBHMUeuKUQsaEEHjG1HBxfOAJd/P2L9CbZXdbt0Yn3yEGlOjKgUBUHG7aKMWXawsga
	yTaLhudWT0blGjjacUYtoyAz2XzSl7XmdMoX8Kys0Hz/oy8bh6MS7GiR+WXHjXWRRAAaSKLiJCW
	+oNI/e8nX8tquT1rTyjmBDRw260avTxqfMLkdHta7odhvwxRGheEuUr59lfVfZGcRnEbR5/eROS
	nNm69NpLrf5CDPqClPfoYIqx7bIMsOM4n/vBvIxGPVpr1OB7dqzYJ8oRxrlVonFx797Jb9+61Tn
	xxvI1FPufl02CKEGUC2z7iniSGQQ==
X-Google-Smtp-Source: AGHT+IFhMjYd9g06Ls6PBN+CrwIjdOfKxvJECB2ofSGo5RcV2A4Qvht6oHwCDqUBnhyB84O/x2YwBQ==
X-Received: by 2002:ac8:5716:0:b0:4ee:2508:3945 with SMTP id d75a77b69052e-4f017505eaamr47792891cf.9.1764790845057;
        Wed, 03 Dec 2025 11:40:45 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd341f0ecsm119108231cf.16.2025.12.03.11.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:40:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6d4733b0268246892cbbb8c2d3bcebce1714404a.1764786299.git.pabeni@redhat.com>
References:
 <6d4733b0268246892cbbb8c2d3bcebce1714404a.1764786299.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: cleanup duplicate ack suppression on
 fastclose.
Message-ID: <1066550e-1821-806a-aabb-68832a28d5f7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Dec 2025 19:40:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19904924250

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1f0e1c8a3ee8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1030202


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
