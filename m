Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F12D3725
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146361; cv=none; b=Shb8cjYcOYiay9VdGbaxJPh9fCT5jT5uJDPpKBNRxCI7Y3ZjGWZQUUT14vkt/+Chovoj88+N8hEL9kEKiYEII/NBUUDDfY8XgaDVJGWHfeQEHYMlWzkKlFxz6ix6uAUVEiBzzGD/USRL1emGTqNF0H+UqgLSDJwnL/72SeOLPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146361; c=relaxed/simple;
	bh=5hb12AbFbb2p8bKGSXtTGPmTyzbbGgYiqv/NcpuN9zg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mNJwLVAVPY0mRvqcii6CBjDpYhiDHu879QPswxaV0NKlVKnHm5GOp9Nqn0CQd3GmmMMyyqoDKBWw4iKXk+h439g7GA/PNzkzefjxi74Hr4R0lZJ39WJpGukKUX8G3buqP3H7Jc3swfX5igkL3rho972CVAgGBy8l7umqeCJ1pjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qOAsGTRn; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOAsGTRn"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-908a2ca5becso8779386d6.0
        for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787146356; x=1787751156; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HseaEHav5wqogqX7KRMdr2iwIKYsRusMoWi4SHeZQFg=;
        b=qOAsGTRns8GcdHQVOHuOYp5TWaeHWQ8OlvD3jiVaXoc+R54eMagF0TJ6or5SmIk4YS
         PC854e7XQVo78S/7HCWRZH0HgR87FygPI4/W+wYWEfYxNnoCcc1wrFsnKnshwXbsL1ox
         6W+qtzcj0Tb3SSSjoN9NF2THGISB2W4kHhWXl07CRYTbd0MukRM+f0gndF0l3EP6Ns+U
         8lWCkXH95d3Y2aZ8qsNlX1HgEVgn4sYeL5GPRIyKtWDg7ULEl8t5Wa5Meu2mGsRtSMg+
         wuzcUGI3Sb+/l3MK75igUNO9cEWGNvPFnM7SJDAcb/+8tbn5ATY2XZ8ZCVe6Z8scm/aU
         YeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787146356; x=1787751156;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HseaEHav5wqogqX7KRMdr2iwIKYsRusMoWi4SHeZQFg=;
        b=hS9vt3uyGP6ciZqvSt32nL7SfkLWhZwclcXXFY84i9mAwKLKygRhWITbBdTZxSru1X
         MxOnsQqlF2M73Pdf/YPYbRexmFSFeosrySlUFu8wJShPEYRMKZzEc0cov6V6v5ONmWD3
         KdGXdJRKwLXJUXAcSlwaSsb6KvRXtoXosmYWMR7PGQoxfV5TQeX54XpuZy+0MKJ5s145
         nEBlZlzupaLR+4FXRg3qWq1sUUR2caP0nZ0Rwc/7gtmAiUA0MbVmy50/3KTtGIcCwqlQ
         Y3neywY494srM4CHqaTEv6M5TtOHhrWbrWTqdItqS5MhusPKewPMlQVnNuJzQOUcemIy
         Hztg==
X-Gm-Message-State: AFuF++lJyPb26qgH9RgtKdKSZ8mOf6kx58Z2rSdWnHlez7voekwvzFN8
	BVSl+4zR45eLJTNNKf3yPDZ0Cm8CB1CMRz+w1k8VCiIVw0Y4vk5Y7ljPpS6U
X-Gm-Gg: AR+sD10QVg/JbnTTl1J9F1fdQa2qoEdqLIG/x4cjoIKDlEQ8ICCH+FTXF+49cRRDNin
	6bhVbJYzckqSELAI0I5TTvol9ETXZK34uA0xHH7gqM5QXpvU4oK2yGeptLWA5b+iImwC/J+QpJs
	MMJLWJpuBYiKqD4FjFVFf2DUrRZZxMBe/L/sEu1PsgrXdRag2xCOg4vjS1N4skm8DvZpuNRFREk
	qqi3nhXOysrUD+sj7M7D6V+mbtOM8I3bojQGdwGmFbBwgh0KpPz//Q4+p2DoAbchhaFRPcNUlcn
	CGJwuCUJUFkW4zP3JJxC91gGI3ckOTJW/qAY+FA9wKsUQjz3MhNOHlBVnWghH8AmYveYvnAaE93
	VPueF0vloIXYY3sCiUgqtYi+S008HcFjtxKl51Xy4i9LIP25l2+nTBBXAYuNvXD4eYvXyTwX/rk
	laxXekv0Tt89EFu5oBLQ9Vrxhw2vvrGCpfkBW3ajZmXhBeo6lPJ8tuiZFWUUWCx5q3XfIt/s0f8
	w==
X-Received: by 2002:a05:6214:248b:b0:8dd:d13a:8c84 with SMTP id 6a1803df08f44-90c5e967bc0mr39895796d6.8.1787146356129;
        Wed, 19 Aug 2026 06:32:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.87.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f290961sm14287506d6.26.2026.08.19.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:32:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
References: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
Subject: Re: [PATCH mptcp-next RFC v5 0/3] mptcp: fallback to TCP on
 MP_FAIL with a single subflow
Message-ID: <756a6f26-fe33-e484-005d-3c7b7ca6bf37@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 13:32:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Chenguang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Critical: Global =
Timeout - Notice: Call Traces at boot time, rebooted and continued =
=E2=9D=8C
- KVM Validation: normal (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/32248415369

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b728684acecf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1148433


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
