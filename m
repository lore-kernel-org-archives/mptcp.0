Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF61480952
	for <mptcp@lists.linux.dev>; Wed,  1 Jul 2026 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906804; cv=none; b=sVuDuNwTo0slJtLio3ezYxiWX1Q6ttf3b7pJVD5Ex2kaONhUShSjPJ2ZBkROCAAaYv/NoI1gy5iEjFhRFhz76H8PbWVcLLdVkGlbIscnSPnOH1Wi+FMale/j6W2Pq7tD1R5AdB9wS+7iSyqdXy2yNdMaGNR5kXDcSlkRFPaE5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906804; c=relaxed/simple;
	bh=2mCGWkbnvVH7Rtn3VQA9tMT2Kchqoy5BHas5BNMSPuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WPz2nVKbQFyDTV4xkhjJP292Jyb005LjGNY9ALLhqIkb18k2Zxx8hlIgXOfesjJR6A7qFytX04F44zs4xcVwkuG7yMRPPq1qBIg+KEMxICQfUzbHOVYsucINvjxlTh13pR7YOSajcb7H8hhdhkpzxKSiniiY0Vg6vfnlCnZo0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0dVATV6; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0dVATV6"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ea93125ad1so4241546d6.2
        for <mptcp@lists.linux.dev>; Wed, 01 Jul 2026 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906800; x=1783511600; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obBUgAjhUGZFw7oFw2jj4U8TPRs9JMW0IlrS5wj8fPc=;
        b=d0dVATV6h3AikuspnquhW5t0vG8Nc6D5vKwGP7uRQng5/VtrrUPRoH7exi9mRqtL5H
         m5jTlEx3lGWxLigQ5DMn5ZADAUIlFFEBSBBAorIM3HHyeqTI0rlx+YojL1asILkEpiWt
         pUJSEV6lhC4e3yDexHie9NIyEVG1b/voHYcqHbGB3PNFbnZgTmBLE9nu1qGhRH0RexEi
         rUEh3+mY7I+CGjYWxXrT2IpVCDl8fawqnJ7cvNSsqcTbrpc7NEM1dXExtkABRBVtEUPi
         A1P8Awmd+q2Ytr4PPPgqc6y2zQX5rlqcCJJtwVg7ep3CDsxy06Q+nLDG58+SJVRvzgj9
         Xzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906800; x=1783511600;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obBUgAjhUGZFw7oFw2jj4U8TPRs9JMW0IlrS5wj8fPc=;
        b=Nks539R4Kc7MIZAzY3TXh0ZZJy8Hu7EvUO4Vsla5VEdJUPg+3oZbKidpQ0wVckUN8e
         Ka1Bw7PF1+6/lVR1F4QqOddUyYuuCxvK05nornP4Ta3jCky38zeDBiKknIDRaMUaQpTJ
         Dlvf8GC4wIikS96QfZk2GaP/h8STErfpJDvhEz8Wfik7MZnIWCkUVco5NRgAISCCzeXJ
         9dLorxTHTWXyFV3Jv7BApW7C5w4J3XOYrnYdGE7o8bNgt16GN0HkXUBYu2GbVwMXUDxm
         8wo/cJOCJ7D6pZ850gT9bn6qkPjlrely7qaxDs5e4cW/Z2lV1slWhjouDvMDR5zAecsH
         y7RA==
X-Gm-Message-State: AOJu0YyoPR98UW21pc/BJkYATlolQdbEsHWvdTzZmTuIH5Jms3Bs2OV8
	B6XWGxCnJylwM7N672u9xzL9LtbTwDhgen8vrLqNCIlrEcZ5SQipb0cZUx4F
X-Gm-Gg: AfdE7cnaNJJ5H16G4orQnWSBcja9zOGX6I0QvxuepxPA7NzcOUMyO0Vjl1/gEIyBjq2
	Zrl1YupzR7BkorZa8SHOrnxkUDIXwcRI7/hYTiAs/mZ4loCBNFn4LGVf518icXQsugAH0P8+rjr
	sEjhocxDC6mufrqQ9tvTVFcm6gBpASOWHkUbto5x6ookcRn2PTSjT9m3xDpFg6B5EKDr+Aztbkh
	/pJ4a+XVdSQGjmojTpN4QZ/hYnTTXjAc+beAIauKYJADHgYKx/ropEYI0BWhHIdYfCu+AwlhoFx
	RwTJjAmIQAOVkax8fCOh5oWKmuYBoppqL5buGe01+qxq1DNO4E0F2k1fj8x/Wsr/d1KH4rbfp7Q
	paHuVpAted5IyfEQPrmiYffiDg7XMnDUdy2Hpn1U5B5HOuD6G24ynPyGPiDfWo/k/UPN/qAjcwm
	YsftgQCb1ZKb3qznWeuEz0X3IvSQ==
X-Received: by 2002:a05:6214:4349:b0:8f1:440c:7f81 with SMTP id 6a1803df08f44-8f3c64d5dabmr16019536d6.4.1782906800415;
        Wed, 01 Jul 2026 04:53:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.62.207.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35ee5b59fsm19477776d6.13.2026.07.01.04.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:53:19 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260701103809.4051377-1-yijiangshan@kylinos.cn>
References: <20260701103809.4051377-1-yijiangshan@kylinos.cn>
Subject: Re: [PATCH] selftests: mptcp: mptcp_diag: fix stack buffer
 overflow in get_subflow_info()
Message-ID: <f8466d7e-5b6c-98cf-c6ab-7a2d1140e6b7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:53:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Jiangshan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/285128=
99070

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d8b74a418073
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1119638


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
