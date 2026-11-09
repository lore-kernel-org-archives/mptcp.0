Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794193928;
	b=pjrqhMZekCPK5annwZF4XSyMO6fCT1Js15xHpyYKE67rgjjXSUr4J3BDyAST85sn3VIr
	 uD38F3RYne1zr1STW3ENzYMcgD1YF001Nj7LjZ2tm9r0NV9Z6kMJ3gDDpGk6aOkVI0Yvx
	 QH2wonhTigwQKY2TF67wkuc0RnFwxQoTqJ28E8sd1KLP5Svq27DQs54BnmXSTS72AWFvU
	 92FqfYEIY/ahETcwkG2lvbEuecOw2wItWOsiawi0j/JXf6JtYogDKrx0EIg7AWj6qHjgR
	 mXJ+FtiAuTpsMuJTN6o4CdpChbCLujZBNzT7F8QWQRM5sWBCvhh0rCYLx82wU/Q8mJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
	b=Qz2KKaN7ltLR/NZA8Un1aChkachYs+WenYDNLKmfaRuOGbS4DM4L/4uKE3/TtgtDjvXt
	 fIo6goqd8w4XhbLuYuLjNomfDnYA3pjdyU2TUcCl0MJD9/wtCXpO14PRKZTY7P4aPsPF0
	 JYfc2TpFfihyG3jZK9a2b0qKqUv2FCiYE1CaqKkY66Jwk3XbINTEBFmefCJGtwqHDts4p
	 5aZJtMo4Z3RsHlI4mvhG8yjdNu3UBSyT0HrbJ/h1OTqFd0GJZ1bk1X3j60xWLjFd6nqoE
	 Ca185jvJg9yNyyhBGaX4f7B28qf3lviovcfsPcsLd2fKK+E8p0K4DrPATQ9KFbV4nJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXlulTjQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE1606A33F
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 03:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AFE1606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXlulTjQ
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso351292e87.3
        for <mptcp@lists.linux.dev>; Sun, 08 Nov 2026 19:12:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794193926; cv=none;
        d=google.com; s=arc-20260327;
        b=T/dyI7UzOGqQ/sr6VvxQB2+z2/abAHpVNvrKR+p/FMN2TKcg1qTdhocnkBIrTKMir/
         0KV0oTWCoAPwGQQDB7CMxiN71r/PfcTVA+WC8F09cVCed+e6MXMsczZCKTGI9+CMUdGQ
         66CuKAfIwBumQNksRaBp8tpmxU9E6do4f8gqi3/0bxZM8+RSgPXOov4GxWKP6m3GVuDK
         CIKAPxr0Hr0WYP9ELgvPfSZfBtlMWNbIr77R8Ev9Jve9n+GIsXRYYbEPg7rHVjlhLg+d
         SZaag4NdG3wbEAYOnQgop4unKaOI6IavDZG6yomxKWtWqg6Ix609vw1r2eAKeX3SmH1v
         oNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
        fh=oDvu261pNkFZkDH3DLKNlleC32u/k9g/F9DvWrC/SAw=;
        b=HaE041YRDu8b31r4XIo8MOy4ozhz1fVrbtXdSTTxa3HJ8RmJHDenvNvKSSTZkf3dG9
         yzdOlFRRTRtqAA6HjcdF+px//RwcyZPRIt7UrrUbPMlu48VULPwjEabn+XLJT4b1vqTZ
         Ar1xGUW++95dST0qk33TOUO65S+6Ua3Qt7NXKHDUuUsowJhe+wNsc2B8EmoYvGb2sUm1
         sstH7DCHIanIAhdar4Nrf2Tc/1Wzon+e6A7gb97Z66TIia1ndfH4HZjqYn3D5G05gP+P
         LNsDCYwZCngcw88ckyBrMDTWx40nr1jKtcFSt5Th+xYt89dL1h6tYKxbdS1vU5qmM0OD
         /xBQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794193926; x=1794798726; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
        b=uXlulTjQHf0BVG3qWDRchYtlBxB1kbQ73UhmZqJxBZDKB2rOmedzp/LCtTDBdEIuHq
         urKq9EpKhF1jyS/eli3pIyrzDEAty/AJoLnX0VTbiag9xxzhNqBP9jEZeTN9UEAorSL7
         36kR5MoMGrt5eN5yT1pFQDeL39w/ayfU8V/flfw/cecz0uNdPusjBnoshUdyn0VaiQ0y
         D9oR/aaWQFl1rIzOpK7HKMWy54tCOrUwKMHydJibstQRcZzBvqip3PYvw9AoLy/E0q8T
         MxxR8gIuo/2vWw/4jY+i9eCMpLklOSiKB1IMppx7XbeprG7yx0E3qCKD2Wg1tRDfVLzn
         yLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193926; x=1794798726;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
        b=yYGcBSFuEB5p/xeXdFAc2hRpqNhtyjLgD5ebyGCEP7BlI8zKiIXTHEZazHe3FUnMh3
         wKMuFguXvipZP0Vw+lbD7+UEp6QHNVD+6zSQ5CIScaUjpweRC05NCGa0ZSJhLWt9Z6H7
         WwjMHtM87plAzeWn2v37QtSoHv2oirYqi9CTw657KQvv2MqTr8ECrtS1MY9tHmPE9msR
         xIP3elldnXBlcr4XP+RdzNXjaFtBDdEPMdkb9wo5wLXqSMb8IMqmlrmxSYvlS9iMHdTg
         OprqHsZ1TX8G19xuntCCpSBFSAaohn11vmwrZb6VpTd8Txnpduh0d2VG8WPaUzwawIy9
         a1OA==
X-Forwarded-Encrypted: i=1; AL+hErFGNG6eHfhdW2DQ6dcnXRUnLtHvdg4442qMCMP9fPVix8YL0/Hnd1mi5PlPt0lRq7G+LZsZXw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8+j/lLHjMQvABmf2EGgOnSNMyJ00S5YkqGdGsdGLVLzNShuPoO
	wJELi27YcMTUwPavrRThqIe4SqeCwq7FfZb7l7QilG731/9u+GlN7tmc/BYznZhxeYtj9CM1j8z
	LOW5zFqifZFE1LdMFUAPfPtxn5gQpKdg=
X-Gm-Gg: AYBFou2hX/jzxHU4z2ud1ZnbCVhcY+zSch3JQ6Q9KaBCEFmHlTs93oI+9XVmMV01eYE
	ThWGgRMgYhfOmLqAURLZ6N/fDgqrUwu4+z3MoMcxIttp+YabKhwIdakKJqrHA+/aTGhLLNfkNTc
	6mq4OlbMxs+bkmwaxx2QRNpgWb021OhwqQ7RNRGKQhiGYTlOt0hwFBEgI5b/Pkic7eRelqNSd06
	/lDBEa0aEEsMzH8u8dvuQyZReqspk5o+n4M7se9Aacv6aj7HX27ejgS1qfMwTPwgvRIWLOBdP57
	jb6d4FHH5pXMClK1GO0RK2dNLpDOn8EWA44kchznmmqUWm8OlyZBxL5x/3X4jl33omVvGZLV/hy
	gFhh6ndYlE4ETsKt1i4mAUpARYFimaoHH0EiQmRDk3fQpeOofoeNiJq0EdwO3dsfmalzYifUvvD
	E/KJGtgVhL5jweXmjfiOgb4rAol4v1KVf545PSCIpXPDqwzaTXkjpm
X-Received: by 2002:a05:6512:3088:b0:5c0:471:f028 with SMTP id
 2adb3069b0e04-5c14bfedffcmr703341e87.22.1794193925282; Sun, 08 Nov 2026
 19:12:05 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261109025425.328445-1-jiayuan.chen@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Nov 2026 11:11:26 +0800
X-Gm-Features: AclHuK-8zzYe5mJdMRhvHJ2iaIG2lKRoeKrY7lhKeXbLBk5rPZ5G9f2uOL9YkTM
Message-ID: <CAL+tcoDvFNAZubOjw9+Z1eyaVeiBzt_Xg3KMNucY879bg-ZLow@mail.gmail.com>
Subject: Re: [PATCH net-next 00/14] net: annotate data-races around sysctl knobs
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, Paul Moore <paul@paul-moore.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>, Allison Henderson <achender@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev, 
	linux-security-module@vger.kernel.org, mptcp@lists.linux.dev, 
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> While testing the recent sysctl range fixes I noticed that a lot of our
> sysctl knobs are read with plain loads while the handlers update them
> with WRITE_ONCE() and no lock, so KCSAN reports them as data races. I
> then used an LLM to go through every ctl_table under net/ and list the
> readers that were left behind. This series annotates them with
> READ_ONCE(), and adds WRITE_ONCE() to a few custom handlers and netlink
> paths that store to the same fields with plain writes. Most of it is a
> plain READ_ONCE() at each read; where a function reads the same knob
> twice to make one decision, it now reads it once into a local, so the
> comparison and the value it acts on cannot come from two different
> writes.
>
> There are no Fixes tags. Done one knob per patch this would be well over
> a hundred commits, so I grouped them by subsystem and feature instead to
> keep the review manageable. If maintainers prefer, I can split it up
> further with a Fixes tag on each one, as several smaller series.

Over the last year, I've been thinking about the annotation stuff
especially around sysctls, which, I suppose, shouldn't actually affect
the real workload but does affect the outcome of the syzbot.

Out of sheer curiosity, my question would be what is the point of
trying to change all of them? Or what kind of benefits can we get from
the big series?

Thanks,
Jason

>
> No functional change. KCSAN does hit these, e.g. toggling
> net.ipv6.icmp.echo_ignore_all while receiving ICMPv6 echo requests:
>
>   BUG: KCSAN: data-race in icmpv6_rcv / proc_dou8vec_minmax
>
>   write (marked) to 0xffffffff8ee2940d of 1 bytes by task 504 on cpu 0:
>    proc_dou8vec_minmax+0x1ab/0x1f0
>    proc_sys_call_handler+0x282/0x3a0
>    proc_sys_write+0x13/0x20
>    ...
>
>   read to 0xffffffff8ee2940d of 1 bytes by interrupt on cpu 3:
>    icmpv6_rcv+0x99d/0xd40
>    ip6_protocol_deliver_rcu+0x787/0x9a0
>    ip6_input_finish+0xb0/0x1b0
>    ip6_input+0xa8/0x250
>    ipv6_rcv+0x14b/0x1c0
>    ...
>
>   value changed: 0x01 -> 0x00
>
> Jiayuan Chen (14):
>   ipv4: annotate data-races around ip_rt_* sysctls
>   inet: frags: annotate data-races around fqdir->timeout and
>     fqdir->max_dist
>   ipv6: annotate data-races around addrconf sysctls
>   ipv6: annotate data-races around icmpv6 reply sysctls
>   calipso: annotate data-races around cache sysctls
>   sctp: annotate data-races around sctp sysctls
>   mptcp: annotate data-races around pernet sysctls
>   rds: annotate data-races around core rds sysctls
>   netfilter: conntrack: annotate data-races around conntrack sysctls
>   netfilter: bridge: annotate data-races around br_netfilter and nf_log
>     sysctls
>   ipvs: annotate data-races around lblc_expiration and lblcr_expiration
>   net/smc: annotate data-races around smc sysctls
>   netfilter: conntrack: annotate data-races around timeout and tcp
>     sysctls
>   netfilter: cttimeout: annotate data-races around the default timeouts
>
>  include/net/ipv6.h                            |   2 +-
>  include/net/netfilter/nf_conntrack_acct.h     |   6 +-
>  .../net/netfilter/nf_conntrack_timestamp.h    |   2 +-
>  net/bridge/br_netfilter_hooks.c               |  20 ++--
>  net/bridge/netfilter/ebt_log.c                |   2 +-
>  net/ipv4/inet_fragment.c                      |   2 +-
>  net/ipv4/ip_fragment.c                        |   6 +-
>  net/ipv4/route.c                              |  34 +++---
>  net/ipv6/addrconf.c                           |  22 ++--
>  net/ipv6/calipso.c                            |   6 +-
>  net/ipv6/icmp.c                               |  10 +-
>  net/ipv6/ndisc.c                              |   2 +-
>  net/ipv6/route.c                              |   8 +-
>  net/mptcp/ctrl.c                              |  18 +--
>  net/netfilter/ipvs/ip_vs_lblc.c               |   2 +-
>  net/netfilter/ipvs/ip_vs_lblcr.c              |   2 +-
>  net/netfilter/nf_conntrack_core.c             |   8 +-
>  net/netfilter/nf_conntrack_ecache.c           |   2 +-
>  net/netfilter/nf_conntrack_expect.c           |   2 +-
>  net/netfilter/nf_conntrack_netlink.c          |   2 +-
>  net/netfilter/nf_conntrack_proto.c            |   6 +-
>  net/netfilter/nf_conntrack_proto_generic.c    |   8 +-
>  net/netfilter/nf_conntrack_proto_gre.c        |  20 ++--
>  net/netfilter/nf_conntrack_proto_icmp.c       |  12 +-
>  net/netfilter/nf_conntrack_proto_icmpv6.c     |  12 +-
>  net/netfilter/nf_conntrack_proto_sctp.c       |  13 ++-
>  net/netfilter/nf_conntrack_proto_tcp.c        | 110 +++++++++---------
>  net/netfilter/nf_conntrack_proto_udp.c        |  24 ++--
>  net/netfilter/nf_flow_table_core.c            |   4 +-
>  net/netfilter/nf_log_syslog.c                 |   2 +-
>  net/rds/recv.c                                |   2 +-
>  net/rds/send.c                                |   8 +-
>  net/rds/threads.c                             |   4 +-
>  net/sctp/associola.c                          |   2 +-
>  net/sctp/bind_addr.c                          |   2 +-
>  net/sctp/endpointola.c                        |  14 +--
>  net/sctp/input.c                              |   2 +-
>  net/sctp/sm_make_chunk.c                      |   6 +-
>  net/sctp/sm_sideeffect.c                      |   2 +-
>  net/sctp/sm_statefuns.c                       |   6 +-
>  net/sctp/socket.c                             |  46 ++++----
>  net/sctp/sysctl.c                             |  16 +--
>  net/sctp/transport.c                          |   6 +-
>  net/smc/af_smc.c                              |   8 +-
>  net/smc/smc_clc.c                             |   8 +-
>  net/smc/smc_core.c                            |   2 +-
>  net/smc/smc_tx.c                              |   2 +-
>  47 files changed, 259 insertions(+), 246 deletions(-)
>
> --
> 2.43.0
>
>
