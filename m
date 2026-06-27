Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC71FBC8C
	for <mptcp@lists.linux.dev>; Sat, 27 Jun 2026 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782532672; cv=none; b=rU1u+QiRhu0WxBJpBWENHm9tUyQFOEeoNwG/ckiu2Vzgp+xUCSJhkTXDh2lzcG76NhztwsoBv49nx9varg29iCAmKl9+zDOdfT5hcFfT7SXQyKuh7aJ3DN2Aoku/UQOdLllPdXrJEvN+ypb+l1h29jIFuR/2n9CGDN1EnusLIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782532672; c=relaxed/simple;
	bh=rPRcgjuBXAm/tLkERNlt7FneNeTo2201DzMZ/ue7PQI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=aOt7BxuBU4d64LitL7Mz8JIQhjTlPzTUjaCa/m43yhuxIQa/U8nT7ykDm3EHFT6CwSQ29rf3nVMV5UV9fQP7KlEMLcRr/pCNmfvZpB/gAVLeESFQ9Vv4SzVk6Zzwg9wBrA5cleLA59kxRReqZMr1/BSjAWejduvCc5S5CxZ3yew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l66tVZb9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l66tVZb9"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-920d6e3963fso205992885a.3
        for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 20:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782532670; x=1783137470; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5XQkzOuisHLuGaMZ5Q7QPhdp/znqdDJ7Zuq+iaKUFs=;
        b=l66tVZb9JspdAQ48pf+1R1sb2ZJwtnABSbHmVP8XdXUk43dZJcgYpuKn3228ARI+/b
         FndEK7DRG0gN0n3wz/diVnxLUqgYFPw1NYZG/LLAmhQKroOgwtQ/i0BignEtvLSaB45D
         LMt/qduioQZ7yMr+QiJA0Vy7vwwMQbskT43llIYYi8HGHiZWmsittQ9mmOIj24A4D4IR
         O9sHYU2c8l/vFf7w7MswUi1mVAPs9joiaGIUXaFvQGTEDN4jM9IMMPx6sVkYt7QIcDt/
         4NQBwkFoHvADccTqUY08HXJ11mWs1D9ZGK3XQ1mQzF/OAbG0+xZle/61GOwgAzEduCN/
         PG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782532670; x=1783137470;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5XQkzOuisHLuGaMZ5Q7QPhdp/znqdDJ7Zuq+iaKUFs=;
        b=XgIoUINDkguuitlnhNWVrvZMX8LY2QoGlkwrFHA+ZKc9oCfvmNFFvoeeKgE6KFlU+X
         TabdeD+MtMG6SCxmdw3YRDyT6cb+z5bZeovo6+gXEVfYOCw2tdXRuHShXbaKU1/bxkpC
         +xHc45YoPvWwsiRNWKVcriqgN22x191p3ULLR14lmqb/6WqbO8uZe6KZ1j69qxd/rXf7
         SXDwiQezf2ULlf9u3GlHAXDmBwnZPGBeCUec5QjRexqZkGRtc8yez6J9CQ2l5znBdpkj
         g07wXdzo8SAFYW3pU0dN08zeMQCpSaCfosl5vpG22+lVZt+ZdAUQZWOmJyr0maAVhjwa
         9wkw==
X-Gm-Message-State: AOJu0YzdHXTTf97OsrkyQ+S/TplrTcAUX8RCkNuMOkKUmGp6o/0jPyx/
	Hw6qm2UBFX7R0M/i1QttyiC5pcKXExs8VPTluQ0QwaUc6hoz/lVwTWD+Lx0dhXI=
X-Gm-Gg: AfdE7ckQPHoHrz5LANgtysHFLb+4Zp2gA9bHEIrh+AL1hQJ3sZQ3j1uDxMAoeIkcJEY
	koFN1Ewd2UcIBv5p3UiuTCASkuI+HihPeZ7qHRmb9sD087a5T8xDJ+bTY/xyiUlwnwYnLUB8f4X
	lkiYOh++Vj3S3me7FhnAEuUzT60eRO4NJ2CgqDZIq+IyZlc6wiZlSZ2KD/zeiokMPScW17g8mIL
	SulQnCQ5iGv77HW5ALjkPjf6uBgNqnchyXUAf19bj51PDp8cEHeiHHHNWS3MZTXAU8vQkCqgRpc
	DieF3vjCCGLrRVSNGgpOatgRIOr/tZ7+gCCh10JMAH2VMKy0iYeXo3rHtVnVwgNqvleprlVGzt5
	XrWTeMnKoWDIOYFCJqN+UYiNwdZzC7K1rjHKqBI4yV42+6tu4TPV/ssa8YoQnKBdZ5bQBnVdf0y
	DZkGA27u0tpvXaxJcynabR+Q7xwzV4YtwzNyhd
X-Received: by 2002:a05:620a:4451:b0:915:956b:7912 with SMTP id af79cd13be357-9293ddb11b5mr1467169685a.45.1782532670399;
        Fri, 26 Jun 2026 20:57:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.247.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600d78c84sm1330043785a.47.2026.06.26.20.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 20:57:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9b443bafa57f40a51eb6a43f088ff37d71b39973.1782528088.git.tanggeliang@kylinos.cn>
References:
 <9b443bafa57f40a51eb6a43f088ff37d71b39973.1782528088.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] mptcp: pm: userspace: fix memory quota with
 RCU delayed free
Message-ID: <b42f8188-034a-568a-8215-cb29c929d06f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:57:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Critical: KMemLeak =
=E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/28276882965

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/efda26b4660e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1117332


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
