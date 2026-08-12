Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51330FF30
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517854; cv=none; b=FQv9g5i9yv0bESnMuGVE0jzd8u9PTxeTKrlg9LhqRUHrPKp9+U97Ov2tInUjU0uuV3VlwdPQljVRc1/JaWkPAC53lw82GUZetTpfqRzqjGRcaBCxTide4l4BjjN4UILSUoFVJ77K4uuNOv9ZAqNgWbDdpZ/7MoCPQtC2Vdb8kUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517854; c=relaxed/simple;
	bh=GCH7pZpUR5NW0qpQqYOT0IlqPsr83fb7BxNr3IMriCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ujWUP9Lu71jlfTjULNYP2hlGh3wZEQn4xT/DKMRZl4yopezt6/b4jH4gA+DNmCFLLTq3vKrLP20RPkrUvYmWJI9TKEsDhRxpYevruZpHdOVBB8A0YDaZj2jmh9iCglJHdb2OjRbAsNVxjQZXuH0uuGuuIb5uQPy8RXPPCCMAU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXUQ3E3M; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXUQ3E3M"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caea3f742bso7989475ad.0
        for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 23:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786517853; x=1787122653; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FSRyEp3bDnxiyNE9d3jeAO9GKRK/6Veuh/yjuDA9uoY=;
        b=cXUQ3E3MsO9ZzqxrHd9sHWR/hhq+EN4w5kPnUsySgkE9gatJrmd7cWuLNAdTXOljWi
         FzKvfM37tx56Znptc0o1382OglMTeCuujycTaSO8hY8LRTtYO2yK1xP+kBciRvhDXyAd
         GuKsu68hJ+m6TMFYnGPcTsYqmy55bEMfeJMvJAB2znxUkC7gRKPOLhbQw/a3pSOZQxFQ
         bcrSpBuznUV71GrT/qJ0sjsrhq8SQftMOtmM/hyTPVyvPPhahEWI0ZtHTrLaow5U/QH8
         xxboF34Pgd+JYNR/sCx4ikn9dJJzAOhiFPL8gfsuCH6gv4xdrd6XMVAFAtMAYbeNW8uz
         xwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517853; x=1787122653;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSRyEp3bDnxiyNE9d3jeAO9GKRK/6Veuh/yjuDA9uoY=;
        b=M6UC2glIOf4wWfgfWT9+GTo+AM7SmeANn37A/uAPo46pG7KmfdtJIMVWkseD43r1AX
         vN6JpSEZ65r703PQLpFS6pesEBqAvqJx7zH622bU4hyGHcy3YNt7qjh54QMWjd3D8rIa
         m8BgAHp/5cBUFd10Tc/d5xnq4fn+Ocyhv1dE1E3gcAEgpN0mcA2ZeAVEvxAHEhsWjyjl
         2lwBTgPWl19xt0wHlQ2BwX+aWxZ9m53upLMolIFL9HuMM751NaLTKwVpnrHqNMg8MF4J
         EP5C4ujLOjefUCXc1kcGLddMBiKidqjZwbYEb+2eLV7RMvjtghbeEQzqAwRDezeLbc6q
         ioUA==
X-Gm-Message-State: AOJu0YwrdCHlShaaUFhhdvn30NoKbW42PK3o2UWF9Ny7VHEYhoyTssF3
	hEbuJrZWuDuIB505DJQ63vYAg9/tHYIhWXTM2MQ4RZ3DTzqEV9hwbJEYeyyl
X-Gm-Gg: AR+sD11gnPvJtxcpgJNVGFu9ZFNtmxptKyKMXLfSyyYpHEiQiXJpBXOQ/Y49IFFYJ0O
	1v3kkJAbbBYDXnGwnmznIzC1Q/29IEfzqSSSKCW4UJLK2wqfdVT6I/ty+duXcf5EzjSNEml+yPv
	qwgrk0nNWHx7Pevaj1KQj/Hu2llNl/nqcUKY88l8bU3HprvXVXSFJaXWgGEdZrzV4t4FhPtpZgY
	7D8eWIV1QSYX5E+PBPlbrF5Ar0DtnJGgZgfb1h8bePzpvblOIps7vxE0J9uANHi7zaByDNvbf96
	f3pNMpYvJ0BuUwALk5vF9lLYm+l/O1W/VLF5UsAIWm0wabi1L+QGheStJjJSRhvyT+KDdYaSf+H
	+SLXiz3bAp8a39MId2UFekkXVGZPAd5quIxDDTsHs46Fs6NTRolpm+Yk4OvUYyla53R2UzHJxVr
	8I3miT1QVfM2Huinrm1lsHGs+CHWlyFhgvapG333ZJNwJd4xg9gNTWiYALDksYADJbjyPncBAKN
	zA=
X-Received: by 2002:a17:903:2cb:b0:2ca:d658:d874 with SMTP id d9443c01a7336-2d345713af3mr36107675ad.23.1786517852713;
        Tue, 11 Aug 2026 23:57:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.220.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d352208773sm2223675ad.61.2026.08.11.23.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:57:32 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260812054653.43799-1-chenguang.zhao@linux.dev>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
Subject: Re: [PATCH export v3 0/4] mptcp: fix TCP fallback on
 single-subflow MP_FAIL
Message-ID: <73363c3a-e1f9-9af9-90f8-99fbe4d67ca9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:57:31 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/315688=
08826

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/185641831778
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1144463


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
