Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A61353F7
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015430; cv=none; b=ns0+H1X/sDWoL9Z2FvaNorETMd5/hQt0YdceIANL4tXkXDB6mYxFaTSUjZWhaV+I8KlHM2IYH45VRSSFGSpTAj0jMCwjHDupAU58pmGgh5Re307avpX+gQzdaQ/TsUcUPwS11I6QBVNsdaOS0P9/Lxdzbxf6mhXKoVvBXh/Nnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015430; c=relaxed/simple;
	bh=rdfL3JqQI/+1drVyMBYpdCbfxni67C4MxmUSW7clZQY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HZP6TUikVnn+EQ/ZdMqMNMDt5gg4gTx399Hgph1J6zOWaHXj6By1Iu0ez9+4NbwCbCZdJD//IsjbqYOI3wyUg9NHhsQ27ghmuKfFg72aXiqVR/b76k8Ke/+yy53VPv3cLtBE+qpeDSCgibPPzPMxFZVgOxYQEumm4+hQl6XKtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYqUTRdw; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYqUTRdw"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21922481a2fso723133fac.0
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 08:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708015428; x=1708620228; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wj+yn+XaF8Ddz6Elv6ONm/GlPsTrKNppNTo4r3ct00=;
        b=SYqUTRdwKu44sjUSJDgttaLgi99Waez4Gf6R9yFtArDskeCeSEg0Wy3JB8K5Drx9Bo
         XpaHfXivQW5QXDKWweskig3Uwd0yPbsXAGfMliRk8wN2xaMZDK+3LEPCGeNEnkeGgLmO
         Y1Y/Ymdmv7puYJ4flQ7kK1PS49WjxkMqrEAa3Sw6BUwWhX4NXrB02rpTD3GsksvjQuJJ
         rWYvjsBR0fY4Kruzvg0CbsRgjaj5Z3RnkIXRDXYaq0byBjbeAot+uR9ccb4TbZbEIP0E
         hFjNm5yNIVpbvuj3UUCfuMPyQPhSW10aDGISNRqtznOqhi7wbUfg1MihXO93EzjjHZih
         tHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015428; x=1708620228;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wj+yn+XaF8Ddz6Elv6ONm/GlPsTrKNppNTo4r3ct00=;
        b=cIaP8rmMdq8ibmlS7ZfFDKuiFU5Cz+pchAr1lPFa+P5ihLJd45B5JKg1ve/lSkpePZ
         hYPCnapVgbOdPByZfteyAMy7E/ZTQ/luPA20fM1JFsdXuAA2Xz3SPHLbr5IhWBKqk1Zg
         GlVIJSywTSAjJcdm6PSPlVqMC6+JM15b84ACgroQqOcN6c1iAdTLi2ejBw+YTuwnnunu
         BQ9KyrwQgXxidDjvqxU2+kOry+xNLfEG66gShoASohc5cN6S6pviTlU+zJABM8NdOwtb
         xhsrwbzGY7yYmbxxD6sR0CI2cbl4dzrZyVnHtMhQsvuDMeM13LQNH7Zo0wT47AdKZ+8z
         AbyQ==
X-Gm-Message-State: AOJu0YzWHEDut47Z6XLFEkutCgjzf2+AnEVGBE6VKaVm38F6BRUtWWPU
	2LTIJkWBr4qLaurneWDCPZ3KoddwjpnpexH8tDSL9vCmNuXIAGbP7Lethz8=
X-Google-Smtp-Source: AGHT+IG3Zzlc5xhgjzf8F2gQtFcQReEBOUY5cF5Heln1c9BGAj7h7rNXV86sqjXDtxIcdLX0A7u4Cg==
X-Received: by 2002:a05:6871:452:b0:21c:c64e:e18 with SMTP id e18-20020a056871045200b0021cc64e0e18mr2281407oag.15.1708015428046;
        Thu, 15 Feb 2024 08:43:48 -0800 (PST)
Received: from [127.0.0.1] ([20.57.14.31])
        by smtp.gmail.com with ESMTPSA id vr20-20020a05620a55b400b00787161b2ee3sm743744qkn.44.2024.02.15.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 08:43:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
References: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
Subject: Re: mptcp: avoid printing warning once on client side: Tests
 Results
Message-ID: <bc2691f3-52e8-a0d3-74ef-157b6f98518a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Feb 2024 16:43:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7918253003

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/39cb90ad6cf5


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
