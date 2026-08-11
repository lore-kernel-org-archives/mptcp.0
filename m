Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5D3F4DDC
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430137; cv=none; b=tzYNyCjl8OndugWv+TMyGRGFANnuV+W+143W02VVBTq+ImZKdpw+sIQgwl6772EllVT1aQG5AA9MkXyoIe9v5SW66s2X7Sz0tpx2YKkE4JB4+gz7dt1AewfkdlrFCQr98cC/4ZO0CojaqovW8nNa3x0nD8iOd4J4e4crpgO4pkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430137; c=relaxed/simple;
	bh=PpEHJtrFHfbU/+PgZYzFlxYWzipOkqfIP1zHMJp2Uq4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Wcg8q+1QlZXlN/5FNAqwXxt1VA/mWH8lSRKuTRdBqoBIINCzSH6qQ4oYBZFdx6d/1lG84PsvK1mV9XfbS8JBRiOJxfHkTHU1aUslPQtxFM9cr/RFP0/+OtQWNEelocWMSQJMR8KZPxyGYfOAfFzRanrG3z/X+NdUb0TRZtU18JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZOquxPI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZOquxPI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceaf8a1265so42021475ad.2
        for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786430135; x=1787034935; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=su7198ISkh8yrteixI8MewGlXFdo6Qp2ft3Bwwph9Z8=;
        b=YZOquxPIPWPl4U2ORWAsEi7a8CExTvU3JVxvkBYsVG7xjcGyLu1tmbTxZy2+acARQw
         F8qiIRfmQK7qE8MMJShM+CD04l/qLu+Hnu5VrW9QD9fVUibfX4KviweE1zOQZisjLnJM
         QSg1YqBSvlYg3fctQESrsJL7XqFGbJQT+QeBVlF89fksOjdbQUU8kTT9aAVWLZ2gARQh
         8W0lNRcmdvnzgQpaFPioBYm1k44TWgHgteUr/zDmf8LtlZeieg9CW5EbR89hilz8QwNu
         V9Kwg+VdD41ZNxSmpvbuhPYYj75PbB21igIe4vG9ruNpyRjC1mnJt4mX8QpEmcR0xoSA
         3JbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430135; x=1787034935;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=su7198ISkh8yrteixI8MewGlXFdo6Qp2ft3Bwwph9Z8=;
        b=n4DrsEiQJGDvNlFrKUHLbFLX8h5JoQl0dPZD116KZsnmizPxHMmz4uwcvXzeKGCyzJ
         wAviJnuuw64i0dlnIq5TnR1SGTJ1b7rBO2nyVW7RdoKRHz04Wl8wDRoIQ+LnDu8T2x91
         cnj+pMw5p7t03SHpIuR2ObaPfx6YfGJtwBN/l06IgNBFp1i0sITVfMyV+0giBN3/3YAM
         JpcvAlWwCR1Wu5TkDL7n3SJbJHhS6fOPAZt0yJVIRSm/3qtXZT5RDL+NomfSbGFVpylG
         F5H8jT8pkcUlY9YnAodiY1uq520jI9WnlG1mcY7el7m1y6errAaltjZaRUkDB7kE/v8q
         I10Q==
X-Gm-Message-State: AOJu0YziQiW11X0n4uv6QhrqCNczp4mNy33UqmJ+mmY4/6e3rAFmwihu
	yIHkGccAbIqtrePnuKqpEpz4ox5ykgDVm6mLx4Y5/BUywNIMZOPsDEs=
X-Gm-Gg: AR+sD12enQgfh8+NwFF3NW67UuCW8ELF3p/B1iBu1i4LAIjKfQpnRCr74ZQgrDbHTsf
	lQO1x2qYiYUIfuW5Dl5GZ8DEg+20UP8RFMHM+4ZTgl/S2XZmSS8l0iXgJ4uNhtMpjpx0jfVHJfm
	F5HPSj5FKyisofIf1DVFOxcKzfOgPJAAjMWEKMcs080NfRhlK2IRWW8vU7QW3qyN7ZEFUi6iZ5x
	j6MYHzsP3ybFwd7bwf593sCukgxmHIjJklBbd9sClUWS+vzI+9M09sY6jht4FiU2Ic/aX+wKGQU
	an0/LNYvzIxannqLAfNevB68hiTJ6t8GpPpxiQv9RP28OdB54y2pjJvZtbAWsaJ0lDBL7lVHUhD
	CN9IEefan8/0rfVMzpYPFKFyy4aobV13Frg5oY9/ucolBk3fOtphAhv/zcE1IjSUYxDx1431z4o
	w7Q7VVHRDTx6MZ4sjHWRmEv5xf7+y1t8wOyHxI16OraJLHbZxkyVp0f2UO7+r78jfCzW7yQfWSA
	A==
X-Received: by 2002:a17:903:350c:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2d3177f6e83mr14239665ad.7.1786430135157;
        Mon, 10 Aug 2026 23:35:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.166.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef0a79sm2397855ad.9.2026.08.10.23.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 23:35:34 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260811053507.354166-1-runyu.xiao@seu.edu.cn>
References: <20260811053507.354166-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH net v2] mptcp: upgrade network refcount before socket
 lock
Message-ID: <6923b434-ac27-2c0c-461a-75790faae51f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 06:35:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Runyu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/314629=
46357

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8a7e80dbd3b6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1143841


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
