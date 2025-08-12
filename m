Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F82F28E6
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014124; cv=none; b=rQRSyxQnDk7ncznFonICKGVavExARri0nGBecKdmE+f+KkmmFD4Ey1TPlibrVMty3E3uDHBew5GxKxlv++gq8zYownWUG8qh2M5QW5LFkQBnPUaCpEVouZ8PD9+nKd/6IV/aYs0ddDyUwxU3WvbU4mHnzT3iZYZtdJcENEP9I+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014124; c=relaxed/simple;
	bh=r0/yEUMM7JPqnefmK7vmUlZWOLUisa+zKgHd/TvVIaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgFRGo/AV9gCLqp1GvGf2yhzslJJtfDawNRroBuueYYNwqJkUsVGmrp4eYJKO5za917H9yPTYkJLfhCT9cGvUyREsGd0MBW/4GyN5/mNHgiOGTRnpJCUF0/hTCUU6wD64bUujn6CCM6U/hnPIWJSZKCp0TEvpJX1bx7nZalwZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JClmF0Vv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JClmF0Vv"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso4857283b3a.1
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755014123; x=1755618923; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mcv2bxyNpRc50Ynpw4pPqHAkM7Jzrp/2IvvGq7EcEI=;
        b=JClmF0VvYcS0KSUm9qxr6MTrWzfHAyFJh0HmT3dlyzRbvwdw8f1kvqWvOeQzMByjTX
         X8ZO5GIslzgp3DwKZhLZLoZRdgVxGYzNMLL96aEYG1j2I7ScPnmVppX5G8GFijk3vmjz
         OT+xMUdSNWV6R0CZEIvP9VPm4px2LBBDt0SE6IsqBNHLILLjBU5TdLdMJAxRZ8f6Uahn
         tFLMq8KtjJzysUXWLQOJD+bcBSTJBq5yN45HS4TcjcjiaQ+c6ImCyJGQNWPP+VPGeIuX
         Txs1uqFrnTEWdPW2Ngm2rpX5W5vLA2Gd1sFs9doMTZZ0eTJk36+iLRzQ+ULV8rgTNHwc
         gWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755014123; x=1755618923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mcv2bxyNpRc50Ynpw4pPqHAkM7Jzrp/2IvvGq7EcEI=;
        b=tUNRN8bhUp1CF2KriMoCYYNXl5ltKDPKyT7uLNO5eztZAhIYBEPrS1kAZf++YmupGP
         VvuGlSRmKoXbwG0pD5b3NOBk3ALbsffPVBqq/CRF7sLeaGMV9PoCi7T1aD6q8NEXKIQB
         Z1wLuaFtKPvqa0cJINGAEFufMMXFaQRFTYjabbA8pKnZ1C2q/MJqyJYFhW3htaq6////
         4ty/5SJTp3vMKqN1JQph/tsHImjeymDKsBun1kvG6BNnBsIVSixPt71KAOrLb1C7ccq0
         E/3vPXPBa5UTLrXAXlhNu4Xqy4vMcsij/NCpWtLUHzYSAzDWp4uT5pgs+cJIF1EVk7dg
         I0dw==
X-Forwarded-Encrypted: i=1; AJvYcCWPqFNucjk2pcbRs6G83VvJO2XI+fMpmhFEAyuFcwQV3ZcMIKzpO937CByYvHGmshpJ+uXuZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyN6z1m96ee0SIbjPTgkQgzGnSEUhs7MLX668+6VfJweETwM6bu
	qWxvH7HPz8EfR00maBHV8gC5JYbxPAVQKCkLZi5thy+f6Kz3r7ftVSYE4lStQxzfcVcLLZdXmOK
	ZfvkN2du9sQTFYFu+83Ntc0AqJ9CXRNqE3tc2lg74
X-Gm-Gg: ASbGnct1IBmebB5xUJNE4hyDmfFB9tlohbnhmrWgsSMcqjZv229GpRmThukEMedzPNY
	JNAyhtrbLhI5cQxfJuBnSYhU3KprfIPBia6UPHIxdJEtUiHX8Brldvi72FBCdq6adQ09N5fQNwC
	FiRRcl9O93lojOuxdOQos/UOP8ba3jsflqBh9s59CDVi/RjY3kSTtxKBDTiKOl0Tiq3ON2jc8OK
	PmlToY=
X-Google-Smtp-Source: AGHT+IFChq5GEq9GGfaAl4dOo1Sl+YOfAmncpR386ybj+7kBczFF1Z2UKtKOTxU5KLS0Amm9EkxnQU0RhLAZT1wXcRA=
X-Received: by 2002:a17:903:1968:b0:240:11cd:8502 with SMTP id
 d9443c01a7336-2430c008265mr2760005ad.13.1755014122559; Tue, 12 Aug 2025
 08:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250811173116.2829786-13-kuniyu@google.com> <202508122213.H31XXZsm-lkp@intel.com>
In-Reply-To: <202508122213.H31XXZsm-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 12 Aug 2025 08:55:11 -0700
X-Gm-Features: Ac12FXze_DG1t-NtmVQ64sQY1bC4hkt6geufHULb5hsjS94rK_uLgU0R6YoMjYE
Message-ID: <CAAVpQUDguV+qG9Aer=o2HS74OP2EdsWHbFx3J654hU3sBnHtRQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: kernel test robot <lkp@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:09=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
mptcp-Fix-up-subflow-s-memcg-when-CONFIG_SOCK_CGROUP_DATA-n/20250812-013522
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250811173116.2829786-13-kuniyu=
%40google.com
> patch subject: [PATCH v2 net-next 12/12] net-memcg: Decouple controlled m=
emcg from global protocol memory accounting.
> config: csky-randconfig-002-20250812 (https://download.01.org/0day-ci/arc=
hive/20250812/202508122213.H31XXZsm-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250812/202508122213.H31XXZsm-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508122213.H31XXZsm-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/cleanup.h:5,
>                     from include/linux/irqflags.h:17,
>                     from include/asm-generic/cmpxchg.h:15,
>                     from arch/csky/include/asm/cmpxchg.h:162,
>                     from include/asm-generic/atomic.h:12,
>                     from arch/csky/include/asm/atomic.h:199,
>                     from include/linux/atomic.h:7,
>                     from include/crypto/aead.h:11,
>                     from net/tls/tls_device.c:32:
>    net/tls/tls_device.c: In function 'tls_do_allocation':
> >> net/tls/tls_device.c:374:8: error: implicit declaration of function 's=
k_should_enter_memory_pressure'; did you mean 'tcp_enter_memory_pressure'? =
[-Werror=3Dimplicit-function-declaration]
>      374 |    if (sk_should_enter_memory_pressure(sk))
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Oops, forgot to enable kTLS and allmodconfig.
Will add #include <net/proto_memory.h> there in v3.
