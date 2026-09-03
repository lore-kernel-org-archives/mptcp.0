Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCE4908AF
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432637; cv=none; b=uw2a+O9lkfeVQAkDPKj64I6I+rm1D1zu1rf4RED/r4fFtzbyU5b8bI71YGfFk6Ob7IcKj3DpTulo9LuSV9J6gxCJiXbMllTyWjMUs350lcBK191CVTVbLP235n5WlrRUGjrTMsgMLBLJiSok2ljxzAJNL4NcK0OaIEiLzJQmpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432637; c=relaxed/simple;
	bh=dPL6QmKomksYM4KWQBLC3hGt0HJX3JrMtrD5QGgds8M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IoHLSRS7WQLtwA6RF8csIavL/gnrx+MSaNMuNWn+WN+Vp+OGFSAS0GMKaItUS2D6pMl+ZT3FGAg0HVIM9RVn4CTFTYHERfu0Ofc4aALeR06PCuV38wTVyKQs9wCdKCUpfqtOH3OecBmAvqzBTjPWZSFJhM6UgP7qkfRX6H8rKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXKs5SYi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXKs5SYi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d944747d41so25964745ad.0
        for <mptcp@lists.linux.dev>; Thu, 03 Sep 2026 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788432635; x=1789037435; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Yxfr44kXzNT1G6z/NKRRL7PfRTd5RFUVznsLbW5f5g=;
        b=qXKs5SYiBMNUkaQMZYoDEESoe/94gVCqM2/jjIYoFDsVEir8PRMc8ObpuA+EjLyi90
         /2h0rwCMbxZ81vHrgvHIQo8IE5MalUHU2hiE5DH4xY5NuclBZq5RhTAhSSu9goCjwc7m
         MKSTWCgLu8NFwk5ciSmthgtLe11syv0tavQ2VdVc6DIs6RKocnTU3tUCBHF+8CMPoYRa
         5qNxOFPAPB/BY6BCnw89S7nXBoIreVrtKDWFZQr4ORbL6U7YBQGmP5Gkrh+/dFUCT83/
         N5WflHBv/U+9uzLPEvt/WotVzrY3CQ1zheULjUQwyRldUV2lnYy7DAxFAOT/y+rtt87j
         jk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788432635; x=1789037435;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Yxfr44kXzNT1G6z/NKRRL7PfRTd5RFUVznsLbW5f5g=;
        b=IBAj+30NC7qb5JSfVSPqP9Nm+zJHQZALW+cwEvrLqH53Qyi9tkpDfOpsFJJwBP5wyz
         sOjBJOphIc/nd3dE+aegfQIO11x3Ta3gYolBCliBTxcGAe7h2fOjvKBRzKNWxXPkMUf/
         4A8wMt8QCC9IbGN8hBgSQsV9+6qrhRlgRcNk2igkmkxF7ZHKeX1p1kIDtAqm28xS3uTs
         PrNFsFHGQ/RB6IkCi2/2psZ+gky+FwT62r2uvki6g6/lcOmpZZrDOTKFxJERzTC9TkPZ
         M2i9FTqIyUCyrHm5zAlp1P6syTfeCYR25wz94Vy61efiBdHA7BUrUhaDdQgr30uI//tS
         JEhQ==
X-Gm-Message-State: AFuF++kYPUcriTSCq0nGQAC/L9kUD07DP4/u7hgKCljCEc/91K+XUY2D
	/OHTSY6lB3tlQTKpOOPNtOTBho0/8BXgHiynWbH4mrEaewsRxoHasnyTWqPO
X-Gm-Gg: AYBFou0GUDT9nKWug3fBN28an2FCy++NBZYL48YaCuuLRMyuZ1WweczsINhr9KUlAqw
	D2q869/48a60J/7j056j4oHD9Xn3rAzRwx+57ZvaTcangcwMIlL4TeR/l4NJo1nWdFUf7QpP1Y/
	yvFuw8BZyVfp1MigbpOo74SI80jTCmGbEKf+qeDuJ7yGQdSEkfvEXbREpT+jDthyAYQPA/t6ukp
	7htfRDhcogWNeUS6F9lKdgWTlfnjMDL0Qep91zPfE1KBN4DLYntbVJvSeCtCbeqb6C8j4LobO6U
	bfXk0mDGlGkFT1ctayIxfqtXCD43IfKMc2gf3162ImNMzXiT5ISxoUhWzroN/m39x0xiQWMIV85
	H4RxTRmSpVDrrBz2SLYh/c5WkJVa5H+TfRNUhk1y1kQq4dhjfjxIInHl3wS/2NAi8D3DLkD9Vqj
	9fscus2YL4cuBmwqxKbf6Jdy51nz4tS5M7YSftBLwmTh2XJBXDKvFBiTSteTR8LmglATfwP2rg
X-Received: by 2002:a17:90b:4b0f:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-39aee15920cmr15229661a91.13.1788432634798;
        Thu, 03 Sep 2026 03:50:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.119.26])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1431997dd07sm5314240c88.14.2026.09.03.03.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:50:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
Subject: Re: [PATCH v2] tcp: fastopen: check rsk_drop_req() in
 tcp_fastopen_create_child()
Message-ID: <4d301f5c-9dc7-f9c3-2dff-58773ae2ed82@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:50:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Yilin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33742176049

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a32ce1a16691
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1156939


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
