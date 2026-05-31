Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C938E5ED
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780243868; cv=none; b=epsnFg6bqIomA95scchitLOjZfS5IXcLzJ+C7J0vOSvv6psSLCfDYYnLgp72pmKU1W4pGIcxBHyufwoUzufvNmzQN2dyuyxTJuiqVoZ9wccMI67LAmmijx/tDDGKzsrnyYkznyi7hterTlKzWaMk1+03rZ2aBBKx1mFUKap3n+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780243868; c=relaxed/simple;
	bh=Y6pWleZFdKcT6VtnRHeDGbKVix0HSK0+zMGlyM4YFiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=eIwU7AFOxnDKzSc4pPbA4DTO9ksM3342LlyJSdW3nPy5m7wDLCN559lkZLJevIiKeZjuE/ckshmdHnZXq0g/7NkLaU2BXCI0595tO26WmaooDtVvOCv40mpq0BSpvj/2qntF+nYZqdzUotIxzgGgaUdA8QE9yog5SwCS1FtH45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2genGvL; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2genGvL"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ccd86df7d4so47523686d6.0
        for <mptcp@lists.linux.dev>; Sun, 31 May 2026 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780243866; x=1780848666; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjdp/jIIYcWW2oCpClAdy1f8XFfp/7nRao3pVG5+JYs=;
        b=K2genGvLgk72f7WB57nKfMGZTfVlPpFEpwWiiDFPfMtr5QzNOiTXMf66AL5DuP/0jO
         POEjW1/qICosNcwNmn5la5x8cwDUQPbmx3OMTR1JSBXxjBtSeGiOnJ3FA3/ZCjyOZv9P
         vHP2hEswz7f6CXeMQjN5B5TnB9jZIIve9OeMtDPk2i5HzCqumhbgNwPfrAKRyOugIvvA
         swJVJ/EPaIwKTyjTQEp3SmMqJr0EnDGiRukmfdISC12IcapnBrqpEPb/ZjGzwk25XsDw
         n7gCt58d9BtlJ4RTU9pg7eA+OmgM6r6HdYeDynS3Ozu8+Abg+XXbEB8KLDKop9f2loqd
         I0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780243866; x=1780848666;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjdp/jIIYcWW2oCpClAdy1f8XFfp/7nRao3pVG5+JYs=;
        b=mcNtHtBHhwcDvEsFb6+8vh97/4ARKhpgtgMzkz8+iZK+Vp49+2IJBagq9o7BM7ljWh
         G6eJaoqLfc44PhnEAv5uTkXzQ2WvdVIMwNA50oJh/fj5muPt6M3Nkgt6tijsMDGlSIDR
         wboYL/jiWEK+AMBMhnpnKqdOMavvrtevqOVJjFC1kytJ1S8zpXNy/CiKe3zSl/mcJvHB
         p9d9aRwZ8+TJ9NRshmHNE2dyoqWlgQclVKW1mj07sA/HQm1Y4AQl+tSojm7eKllmSb28
         shVBj8O2cn9cnlAjZaoL2+Nwk43dp+gLWXnh+BDfpEteB88J9KnoWt6e2OpoMRjX98Lw
         2GJw==
X-Gm-Message-State: AOJu0YxQbZAZSRMo3qJpmGbzQ2aFsdcT6GRb4nHQhBYSKwNgLG+EP0Yq
	/UbSm/QQV3DfhCXpg0up7uQli2T+kv0za0gfK8v8jdBVPZwDfTOcV50=
X-Gm-Gg: Acq92OE9OMj6q5YTYkZkiXHuZb2/0cPUqZhSP442mHk+Bm4cesqvsPhDfbqvl3uMMd9
	yTmu6Qe2kQeTWI9qYL0r4aMmvtyNJNp1pMDWJhHSV7z/mgs64oT0iR3fvEDYizIR2NNlxb/Z4o4
	rijUFGL0zz7zjB5OGfs/aBekpn83gjDUjRJETnp029o+y7iPYFhrFW0b6pV6kCbsT8jy+9tAz5e
	yUwybw2A6UiE4NJtaG4vlodNQ15Haxq5qLBRr6Az8uux7aPG2Joz7P+k7xcWVCgqXXbUUtNmRNI
	pwv5uRahFKzI3jIJKFQMvN/N0YEE+pfr8EdXCGqQrr+kpem1H5MtvLquP4VXo9ON2NWTcYTXnvS
	3n26fp5DJO31SM7O5zlB7+fjDUK/rwOTpHaZaV9NSZgmV15U4P5+jGgSa4esvNNX8vQdIvEigqk
	vlMTKzSUJNpYS8ipUpzWvrJe/NNCTyP71m5fF4e7bKq+T/1oxi/RN+9u2RCak=
X-Received: by 2002:a05:6214:4a86:b0:8cc:d4e2:d5f3 with SMTP id 6a1803df08f44-8ccefd5faccmr129085736d6.18.1780243866409;
        Sun, 31 May 2026 09:11:06 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.153.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea085db2sm71010336d6.18.2026.05.31.09.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 09:11:05 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260531145955.322337-1-devnexen@gmail.com>
References: <20260531145955.322337-1-devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v11 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <1508158e-fc4c-85af-e50d-0cff94ceaaf1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 16:11:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_checksum =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/267164=
94041

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5dd33dfffc0d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1103609


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
