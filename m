Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C953D3CE5
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882530; cv=none; b=RbdJzxXaWy5a6amne/+cjJ3S3fvD356lE8W58hQiXvg7ZpJ4UyHW3CtpmvG7PIsXJZBumKJGqMH3ZJ7Ti+44zdKueUyWF0JTijaLX4ZHxgnS+xQ7IiDC9YJdLpmt2NPYMvDnjC0cz+BYDvzwMCm0EKKQ80FCNVtHMdImmf8LRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882530; c=relaxed/simple;
	bh=MFtdfafd1IHCcVVLPN19r2p4gACYLaQ3275k9Py/WkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=kt12wIs3ux5wz19PrBZbZADn0Xi3iuTWlt1u/dRuK5ibM4mIU1hPql4B3MJBwLE56yhsmkm0OuVjVnimXEYuemL3riMyaF5eV69nbUkyE6eR2/gLcHfyC3I3fcvp6LOwnMD+79lraKD2GGzwqqM1eMlIJM4W4a06zVYEa5Mrh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLsOAUl1; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLsOAUl1"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4af173320f9so1533924b6e.2
        for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791882527; x=1792487327; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnh6nnAocwxNyS2RE0ISD6/5Cmbr1LLasuYXViOOqW8=;
        b=iLsOAUl1BqUqEOTM2TkF2UhkH93uj0wry+/kv7kUve9bj6rucG8+5j8Sm5+gF4hM2a
         6pSswgfzmv5s1r9jAV21ElTlIGQT3Ibe+bi6R5l093M5O8fXcEsA5qvuaufTptrqodq/
         qOdaTI34VDFBK0F0UAypBbuaeyIblQftEB/zBCa5GHgPG8VFI352bJByF79ogYROKKul
         y/ZydTbaQLnvG7d28Q+a2UFXGyOT4/zhH8CXKtRYdEWWwI+GmXZ5OMVMS6UZYUzYn4XW
         1lYTIWRLgsvYdxHKdr5p4IsiUA3pyEdNVU3gc2BxH7h01IOSiHwcbmPb6mEdoc1+2cKw
         6EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882527; x=1792487327;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnh6nnAocwxNyS2RE0ISD6/5Cmbr1LLasuYXViOOqW8=;
        b=SZAqKz6weg4TpoSt50ZRrGisaIxcvvakT3WDRU5uvnYTsXNA6IfmQjO0oYbHDmqmum
         JEFCWfi58wsk/V1d9moHE6TX+89T44FE5kDWCIJraRTCbZcxuM8VK8hpfsVo2BiyzETi
         0j9XT+aSawdeuZsxMeCFSM5LsBewUK/1fu2F+3q5eoIR0ukAn3n7jhf7tJfgcKOzASNI
         4ApfW1ZUdbH2KwFJKIwAHS+IgSLzqyEO6jy55IqWfPjxHfH36xRvDbEqJgxTyV/EWIPE
         2TaXZFN0ubD2trRtKjw2dMhqCreuaMRV4zq+jlLStb4rlwZEzUKsGAU5nuRKT2b2B21j
         A7Iw==
X-Gm-Message-State: AFq9FYL/DwEJIZkJCKgqOoT+CU/74PN11fACb7Fk27a77SQZ8hUrx+qu
	QE4hqw2ZVcIJQ5yYkNpinlEjJkvUfBB8ej7fidOgq5aenZJ8QBXI0Uw=
X-Gm-Gg: AYBFou2ygxv03ur/8gerwhMp7qO2l/x1K1MKQVQ0JvaUDrsSwOQNSfkwPdCCAwr1KI2
	ZSChD3PlHCpnzCgHHF7S5sQPrbaPdU8U/9WKJF1xdhlHvfQxmptRq9VCRatpr2VS+kmosP8s5FH
	Stcq8CNuBgNCvJHbtplBXn3eshOed/gRsFfS3M5mWwwcoG7x6RuY1RROlkZWW7vnZ+YrHQp+5ta
	Ukft3CC3psxHXPsBE0jDhCnDW1Vy1bZl4ZyNhHPaFkrpScs85XRPgnSpCTZN5xFY76UCZRhbEuC
	g7dCKz/9Ct07MGfwrIaGgZEs+C6lOiAjNT8ivDcWVXOo/iUecaneWdbHbOPNnx5bq0YUQ1Sg2Y2
	t1W1wuqv4qRZpu21UENEdSabd3u6oy6mqT5xfIE/kOz44XgXUAqDizFhlKqeeYlbcXiP1PanGei
	wqhrbb9mPNvq4K1FkQWRG5TtOaZvrJ7H9rbpjHfvtrzLZixY+JoIVB0qu4w7Hh983MwZ6zQnBIV
	JKt117mxSs7dw==
X-Received: by 2002:a05:6808:f04:b0:4e9:3412:14ac with SMTP id 5614622812f47-50c516f087amr13866096b6e.33.1791882527465;
        Tue, 13 Oct 2026 02:08:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.165.107.225])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c19f4c066sm13070470b6e.11.2026.10.13.02.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:08:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261013080254.83992-1-rameshkumar.t@phytecembedded.in>
References: <20261013080254.83992-1-rameshkumar.t@phytecembedded.in>
Subject: Re: [PATCH mptcp-net v3] mptcp: push queued data on passive TFO
 subflows becoming established
Message-ID: <f37bf668-ef42-bdd7-20aa-a3ba6e07141f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:08:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi T,

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
et-next/actions/runs/38368903325

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/9a32a17684=
02
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1184480


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
