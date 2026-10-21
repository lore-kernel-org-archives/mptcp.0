Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587749;
	b=kVYn/ledBcU3HKPW7nSzA1cgzOwQMdE1h07+Ku0klPd2RtnUs7vH82JBGoJvyNfPo6vJ
	 2Oso5+wIDMy1KF8mQLPKQ00MEdkD9wN2dxCFNc8JMwgbFslIzRSQxI8vfb3wfLDkAE4Sc
	 wEpzFfjnN85PP5ay5HUaWdzVpo6cwhxCRqLFCiElHP517nr+sNrXQrBkQcVmMlab63WC8
	 FU4p/LS7cU6qIWr54YZvOBA8rGZq2kZQQvZvncrfRAoCqYfKF7wXK2ReF3PlHaG+vvjWe
	 4NOlXv0O5ZsIT4xWthZHvSpdmIg5dyScl2jbyIuRXywecL8PvmeQ6mjKs7VHPN8gUJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=lFfOmELiMyPz0GNsklsXUdwHQ5tRQNY7tBpiYqFnDT4=;
	b=gkl6ptVSzbGSEeFmpnaHtyCEb4HWMgFneW8YRVG6lcyB6CsLuBNcOIdH7MGFDznZ4NZC
	 NIve1Hy+hkxw0gm8EtWzzJ5ScmEBeAw0Cus2p9+7rvSoDBsCC84SMNPIRn5Co0DjJEAuU
	 3KGLtPC/xTY6r+oqxYBj559re7wNaJSlbeL2pLPsxtfuffGDAWgfnACm3YZxLytmyICk1
	 7h7sZJTkTwHd9VqWtOF50JQkeX09AwMBbKSVYvrVVT2ZuRmik1kGqT9kM+ZYRssQPn9P3
	 3+/jU/5piWVBWhGj1LfkFCFC/HSO7DJ0xxXVJuf1d4c3fmtPF1AA78/8+A0zFEMM9Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YokxW5DL;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769C606A31A
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 13:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7769C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YokxW5DL
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so587423a91.0
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587749; x=1793192549; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lFfOmELiMyPz0GNsklsXUdwHQ5tRQNY7tBpiYqFnDT4=;
        b=YokxW5DL8LIe9yK5R4w0jmxCshCSkD00mM5E1ATR29reoGzMTHOu19r+wnBl+jGj9Y
         Rp5gRZjsDZJE96/lAaCLBY7/wPP/eJIJz3CPZ9BCQzqTujLIqRZztqu2tPXdTlV1LtE5
         /5tjhTAVNcz/YnlszUEEBCe1QVWRPCyH03Yy1FmDq+Algt477XygSQDcrDqkf1tRKunv
         v0CNKq8eEu9l+NRsd0F1okco6L27pk8mnU1A2GBGeoGmqY1QXwc4zk281zL1G9wEfRhw
         kQSkpP0ILsg1lvs8J6CpFE5TrNHAw+AF4e1sajt+pS8EIdI1kqkDMP2+Qg41xZLYGcV/
         efJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587749; x=1793192549;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lFfOmELiMyPz0GNsklsXUdwHQ5tRQNY7tBpiYqFnDT4=;
        b=S/wTH0nAyArv0k82GFXd+GuOa9dP46ZFyvDC0vkv7Cwg3ERXhL80YiRmEUVXKWaYQm
         egTffhJSKdHk0R54hTZ1xScmzvHGM8gZVNWv8BwvfEGbR4VwDhqmMdraKjL8LBIA3sWk
         nSd3yhIxpZkF7oU3oYd/vFmGvf1tXkMCbd+rUpaDMXBeN4zb0yLRAVTqMJ3efNUZKZjy
         VLG57IUvOgqtrw5c5BqAofCHUuYrx1D4NrsGp3c7Z5SJiFhk+zJOUtd207//WpOPGFRT
         AnqchgSHc36RhwALJ/A/4LWc1kljHCn3IgEypj+VpkbLq5Uaz+shEEQjVwFss/Nm2QyY
         BQ7g==
X-Gm-Message-State: AFq9FYJqufB9WPhVtSKRStfVAcxB6m7WXzGrASXhAiHbIaRtTQRPDLru
	aIYZ4VjrZi86c5Pw07JXVE+cIk69koV/7qnF4uhL1mzcdOl8VgT+4TU=
X-Gm-Gg: AYBFou1niEABTCtud9cuA22m18VDDJRXNOGhHKPWxo3kjHAzVp0j1ZZqTBHl4rZwYQN
	MtIAf+PMtqZjT9Bh9MZbjI2FTLA1+Q92of1C3jGA7imQ8u7lKwe9HEniS/SS4B/aYa4H9ErsBAE
	9DXBb1DghTThEB7JKJ1Bcnd3VrFf/2PGVytw3MzX0pIQWXsxaRd4oBJCi/Qg/+dcoTsg8OMIVGg
	zYGHbVaQ41rW+6vJk9d7rGouZcNy6wB19gE3zQTneZRrjcbWYwi4x8naN0VJfN60lavpXHESp4M
	udy7Y26qSPz/ZJl+Yb8ovOjZAu0bdp2MjnpxvS//UBFWYq7Sq/YMuwDhH1JEpKtqYiboFpUZLam
	Mfta0YvqzpiuN++MKpEiY6cOxsBQ4bO9iHwrQqki5FffVfGG1AR8a5xAP0pYl6nDDFAzFHFQfmM
	nbFa4KYDTjh21qg+0GeSsiXeZ23ZSwU1f3P3mzLUzDh/lXqmRPc7s31tBwq1lfrrZ7nsBD9OrBJ
	6q6+4Viyg4i7OrOkLOg07z9AM4hlW0aQh5WF4gMd7mN7v7Gjla2baJfT8H+ZC0Tms2i
X-Received: by 2002:a17:90b:5825:b0:3aa:6b5d:a018 with SMTP id 98e67ed59e1d1-3ad870ba46dmr1582665a91.67.1792587748615;
        Wed, 21 Oct 2026 06:02:28 -0700 (PDT)
Received: from github.com ([52.159.140.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad803035a1sm4429197a91.13.2026.10.21.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:02:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261019180306.382039-1-w453y.me@gmail.com>
References: <20261019180306.382039-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: pm: in-kernel: fullmesh:
 re-add of the initial subflow endp
Message-ID: <55e36e35-885a-a450-5fd8-3ac62ef4f15c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:02:27 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39579941636

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b33fca322222
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1189166


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
