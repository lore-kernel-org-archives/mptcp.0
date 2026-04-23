Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD32F6904
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964377; cv=none; b=AOYFDNfvMj5z7M6/PTx0LkZUdxP/K5T8a3KfNofO31OfnP3ZEXvYp+QbsmrnGnP0KpWOInXPBvscio/feGMB6wSe4rKarTPZxZPAa+GfjAl6NOrt8QAVj91PwA1eg/lsU7QXLnKvqn8usIfIz2JeOrkr7h3GLTZgga9xi3L3WCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964377; c=relaxed/simple;
	bh=+A9S0Wf30ldE7xf6/a+40DwWxI596L2JyM4sZvLKIr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=bnT3k2lul73bCnUbFcB1W5DCDlVcSXLVgtO+qWdouVpllAJiESCM/whmVxt/IpV7mReC+WshMcWKSXcV3JkTRpbrq0oTe48D+iHmQOFrfAkOn1QbsfIuKg+4FfzQkg+K+J7dtZ3aCMU2Pxb4a47R3N15+BmCWBST8zSWzvPHKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN81MGQz; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN81MGQz"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a049a767c3so80766126d6.1
        for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776964374; x=1777569174; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLZ4HIKHolyWS0sOTUJVGno5c8gSk00DOA9yqac9Su8=;
        b=AN81MGQz5askqZ46jC3MUkLLJxym0cFCRST7LG/092VEgNj23r81PaM5HDsNLFqNpw
         9Wvp/fq/KW8Z8zbH+WygYb3uEijAWYncaDDSEAn7ZQEI0qsnEnn/xP7e0SRaHLyJpBQM
         bpo5u947bpByW+0j23GcfGD8iJe7ap10uaxzKjMK83rRzkdHeySGln6eO0PeJwn97OC8
         oMIm1gFSn0nQ8WYN8ed8na1WX7lo8H/0aM+HF3BFti31tkDDbicb3rgKPBCRS5N4/GzI
         JjPlLJQtCq5C4xOurCT7mFv64wflPWOwALY5XFAlgTxXW9zzqFS7U4/2OBiNBMSYBOga
         ugfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776964374; x=1777569174;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLZ4HIKHolyWS0sOTUJVGno5c8gSk00DOA9yqac9Su8=;
        b=KVfdMMlNBPuMxsoFkEa1LfxMzt4Ges/+OZ1QRx9Xh4gq9h0qvGERgQca0nRZNLI4dU
         lU3xve7w0V7c5GJ2OkCGm3XZ1Sq2sjH+G1m5n3kVPzno9iSwyFHN7JlFBS/Vs3uvnVn0
         1UsZm4GP6BF9giwPZknQSZnWMt65UcrV6qq//SdemlxbnlnJwsEZO7FWTYGq2GM9Pu4P
         S6J3ww9TbhEPM1WsJ9NLTmw3F926rBYQUuZ0iDorXOze03z9WOX/QOJQED1eFavMskIk
         xUcHLF3dYOkd81OCmzp39bvOiYO+8MzgGLCiunP2E5ranZgd109M8AE32WcogZqO+0p+
         bgQQ==
X-Gm-Message-State: AOJu0Yw6sX+TO1UaTWpL8VZiloAtfzQhJeqsqZGasTaimVV+tnn9/10B
	boQY3Uc1o0a4ZL2bfWeXqNk+2gE1Z2iT0s4CGIlxP7Ih4VTVs4L60Jo0pXf0
X-Gm-Gg: AeBDietUP3YXVEzN0YD7WD5ha+lgDMzeYUYgMxwI0tf5ATGceC9ZBQhyfU7EQG0BHlp
	KeA70ZhH6Oh8NoK3cHUtnTFpCuzQGenVHYafr8gKdObGnobohZYjtlB5lrEkO9Au4Qe51DsUL78
	TsHO3qu3Ws+84JTpRwoMjWZAwB11f+HV63Uk2i0WXAq2xyd/I1zIQGeUOTbVQZ99mk5DhaXG6np
	zRqrsTsDgQzNRdfR9MlwwySNsqN/d5dDTKdUVwVY099ykj/FCzKCOnoEozowJxwFBU+R91ip+eT
	VnxTQRaaIuOGEZuwGWcgpkBlabaz5fkcWiNFvz6+JQceKSNP7nymz2NixJl1WeGQOXTdZvA0APG
	ALMo0MbaL2dKsqFkgOdmkasW8Gvf56N3aU3OxOgm3h58WqzQymURrAMLM7cY2+ZZR4MD818MC+W
	1b28xNgSMEwveBLzuMp5VWPT8KluAUxRNIWCWUErpXOJUHqrQ1
X-Received: by 2002:a05:6214:4b0a:b0:8b0:33a2:2520 with SMTP id 6a1803df08f44-8b033a22aecmr326775706d6.10.1776964374472;
        Thu, 23 Apr 2026 10:12:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.62.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae7df88sm170729006d6.35.2026.04.23.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:12:54 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260423-mptcp-pm-reset-endp_fullmesh_max-v1-1-e43a46fc8d49@kernel.org>
References:
 <20260423-mptcp-pm-reset-endp_fullmesh_max-v1-1-e43a46fc8d49@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: pm: kernel: reset fullmesh counter
 after flush
Message-ID: <191fc2fa-5948-98e6-193f-9f07cf886d6c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 17:12:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/24846434526

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f3c6c03e4687
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1084790


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
