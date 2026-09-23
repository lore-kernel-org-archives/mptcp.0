Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA77400DFC
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160766; cv=none; b=OFst37tiBOZ00TriDVswRYUA5K9YshYUK9+R5Vw5an/HsUG2L5UBAmrnh3b2cP9qzITHfFj627mtO1SAW2e1XCg1vhlMWw9oO+Sala64BiZIKbjErXZe0XxbNGNiwpRN36w/2zbupEgIedurmD9hrREzbS6tyczuqYqyU3Zg81I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160766; c=relaxed/simple;
	bh=BL3QkBgL4yc5/datP2ogXghINs1mhbhVrXH8/ShI3Bk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=SHRJz4CqmoOoOoIH+Yl2OuNtisBMj36YYhNaXrP7HlD4MuhgvGp0R7YENKJnmD64Qh+E3L/Y3lswFqLJLBeTdTthevIwj1XMTyRspehqTZKseqZut7SoSlpSK03WydGLB3xPrJji9yp7gnThOE/rMcI/GCOSOKEH9bfz+BeZGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi7gCF9d; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi7gCF9d"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530e28a62abso10982431cf.1
        for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 03:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160757; x=1790765557; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HBuF+fbvX8nxm/iMNTceM0EmwT32WLP9uDOwENq/Qss=;
        b=hi7gCF9dlHspHlbev//0BzWSSL7cwgln0cdrQRIEdNzS2RMaDS97obW6V/wpeSVnuC
         ayUV/DN8XpaKwsKOKcyluHEe7MBq5sepSu64KnLPsjPP0UHjfcHjNTbAS02wL1gatZzS
         SRsr0pbcNeindBn3XR1l8hQjCow+ewx2O//fvC8X7ETWSpmetRpbNGAizFjdU17IYip0
         KkYZG0iYA03xp/KcPk6l4nVAeQdy2KgMTQOXncHkQqxaMpZeipFtrV/0pi/8lXJuFy8p
         Wpyelf+M9VOlu/WhudqvLmm0tOWxv7ctk6wwPBjP49/WHSYX0cKijoxW/U2rhkzYDwzx
         BPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160757; x=1790765557;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HBuF+fbvX8nxm/iMNTceM0EmwT32WLP9uDOwENq/Qss=;
        b=FSgDXuslDKax48QdvTt+pqrYcVJGpiPdR+DwUN+XXoaFrwx/QRxOQP7xS1nPDb00NJ
         MIgQ2ess1k7qT0v7FHd5+o4GtTeEwiv0msdXDwCVDhgKVbl3anfUHpF36Q8HNRusZ/Py
         OgwXyGyFUWw62ybNlhpkZ5MBw76+ITSUE9uq/LSmFF0ldx2wHuz33GhpSlVutwTOwGor
         StphKXyqbqICmbas+dAM8tCfSfitQjYJ3gJDoy2IgmhgB8cQlMYPGbao6+GKA9URdSmx
         aG1QQAm72fKpYAFHvMEtG+hsaBzECaLDOtfxAh3SnaPNnji+3tZ0l+ol6jGREBzH4qR0
         36qg==
X-Gm-Message-State: AFuF++kBgw/DkkkSZ95bQ/hyHlNbFj2OTR5G+wZ2m025iPU5d/se+1gA
	tnAabQHC1ofvggsoAi3Gc1YBHhKLXNMpUMXCrHIOaSjJeefIEjf0Gi5XE40P
X-Gm-Gg: AYBFou0Phy39g93SCdv3KK5E3m8TWIY/k4wj9ZR6HYjK+RSSmNrP1E4WrEd4Z7pQBrT
	0mJI+gudAcuWpGgJMjeAMMqmWPEpQaLnHOEbjPhvGcyiwgP1RoaQliITSB7jo1GlZcUv5FlfpVn
	LnuBmvzjb3NMz3cZq1x2K4U5zCoa7tSwiy/SUb2OrFTiGleuNvG9C8RsZMbBX2B+xkgAhSX/FCH
	/E1dwMtNA8jj1rBLRS+7b3eoAMWCgx7l9Y0PbFYjIeOyfzAKAiNtb1IUsMb57M0d50nEqlpihOh
	jsJ0K43d61l+pCoHbNsZHSvpWEglU9/OsCWgDphzLGj/eggjB0JzicIQHycR3fHIoO/Q85QmyI/
	beHcsJIEv8vNU8ogHFP1Q6rqFgO7+TD131ZA05yAs823T6xhO8C+BJ/WlhbZPgbFHoV5Sj/z8/K
	XmN4bcsZds/nEgT08ScEXK711bVLrjuhPesIdB1dvQVnvwjtMzacMmX7wr2U61aEtaZrdVLMUIw
	x/2LieuLF33P0kMaD91A4Q=
X-Received: by 2002:ac8:5d0c:0:b0:52f:9e5c:33ff with SMTP id d75a77b69052e-532eac93833mr33991731cf.13.1790160757070;
        Wed, 23 Sep 2026 03:52:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.44.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb210527sm16956501cf.12.2026.09.23.03.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:52:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1790147728.git.yangang@kylinos.cn>
References: <cover.1790147728.git.yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 0/6] mptcp: avoid data-races around the
 sysctls
Message-ID: <688afdec-17e8-314e-e0d3-21b054e6141c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 10:52:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35847364262

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b4ac359f0e=
dd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1172096


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
