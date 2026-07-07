Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF603420879
	for <mptcp@lists.linux.dev>; Tue,  7 Jul 2026 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446710; cv=none; b=ncGYMEoUUQ+X7HzwZjcLz7P6cQ+RcDLC99YEV7qOaqWnOhCWdPJwwbXbsjN849qDOHakAXFPY+aZ1Ph/8b/y5FrvfELuVYRQZTDgyURsSnWdEgYCF4D8sUAFJj9vAOTrT49vSmZ/EIl9A6Lg8l34gdeotGWoQgqMLz8c40aH1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446710; c=relaxed/simple;
	bh=vfJ0x+UzZnIyTB8uSVaO1Yp8TggSEVOS1Q1+HSOubs4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WNcxgkM/WI0WnDOeNnG4Wo4I+z3rkyRCm+3USSvbXRDZxV2psw3rKkAjJ1SxzEcuDx0cb5y9od+vi2D4c4rt7C3RehlR9FDIk33KuamxlfVazuiMXeOajhhzpNysIPkLFVyY+3gXIf828ZsayauZuI0jVY8sfFEcJiRwvXVsrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7NKO8am; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7NKO8am"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc6ae3e7f1so20646805ad.0
        for <mptcp@lists.linux.dev>; Tue, 07 Jul 2026 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783446708; x=1784051508; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UipHnn9AAdGEmMJf3fcE23zQHR/bA3aDJDM24+IOIeM=;
        b=J7NKO8amdb+PVL+0T3t1ACUuWE1yhk9FYCV66kaiM1ev/KEAbC+NqhA3tB4cDQmIeg
         onk+dpsRvBmdBzrdbaVR5l8qcE/xO/jw9VJEW250MmjI++nZvdtIRQCMgSRKTHbWakdI
         CuySuoaIAuxMHbOevknwTacMna19Ehi/2SQ4CoZu3JP6Ak5ZRpjEgyc/ODE+4T2SWkFb
         mHGaCuGUzgsVPEdkQdFR+L6lnGYEaZce5diU7RcE+xb7acBX/6hAng3OHDet+QwH7aW8
         UxP2ZlK51OnDis+MtpocIEdyHUJTh30U+VUQstPZtY2FR3dUd18MFd+mAPlJliioypKv
         ry5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783446708; x=1784051508;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UipHnn9AAdGEmMJf3fcE23zQHR/bA3aDJDM24+IOIeM=;
        b=Qdu1P8BL03zsP7TPi7ivcypPLFatc2LUelpSzLdeTHlCJZpHVccx20BLw7GI5CrcNM
         FQUgx9vDDf9N6ggy5zWZMyxAE7j/nFzbyiz1p6G0Gbd99bRSdssIyL9qDbrBNBGSMLl/
         PBPK/bMHZGiQzxbixsP+5ecsJHdhzG3MkSdqS2xQeijkWb9Fn8+nBRmkpKDEdzoAbhxK
         2cQzdRwnvLpfbA9SWMSbDkY8WE0/hWuQaLfO5xVyNiSEz6viBU7AOywOxFqkOx/KwlIw
         l0yC1miS7ppPMnepumFgkBuny3+ASFZ1HdACfY/6jPh361VZdopSzV1d9WtFncWjUhiF
         luDw==
X-Gm-Message-State: AOJu0Yxl3U+VOT5XpR5MYDJxrc+lbaS6Rk58VS2oz6k2iOuLn1Ep83sT
	wY3wa87B+0WMMBovD0aBiYMeWF9b1fhX0LtKpX1zMtZl4MOeQNuuKTo=
X-Gm-Gg: AfdE7cl1GHIF+kZuJ+4BtIAO6Jp3+fuoosxtlTrH/PGl8S2UAtcZrnS6pVitNZ/ZRys
	4IO0/JxN4+0IiAEv9tNRI03bXdeSUPurFp3WMaujLvWuW7ETU123dmieayZh15ZvsgPi2UBSPLG
	p+m1XoO+RZUczJ68Lb2dJ+9a8DnTObLRQv1lah2yb1YlxI8VjXCgcPO7rtV6TgNGeg2Op9avHxV
	g8TsjHAThQNo9sr98ViDxXPYsfIg/+ilk4cc4OY4UMcK0igU5ebuTz2bzgIWShMJKVQcpGTScJ+
	bRga9vv01fPKOi4944Ws6pBs0OVqlVZ1/ItG8YEtH8f8GyrKj+o4yLxyoVrwKGRjB0l1U3zVTh/
	94t8dF8Wf/TeE9gVSTHcgfYaUsGJfakoejyK3upG/zIjQkYBmkP7+3poI0EqGHRsWSkV5RQPxGF
	a5x99wX3vNBcYiwai/F1BDE6OcPc4=
X-Received: by 2002:a17:902:e950:b0:2ca:660:b1d with SMTP id d9443c01a7336-2ccbe50a903mr57687045ad.11.1783446708020;
        Tue, 07 Jul 2026 10:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e5d0sm16124835ad.42.2026.07.07.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:51:47 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260707-mptcp-opt-fix-config_aeabi-v1-1-f428d0aa0318@kernel.org>
References:
 <20260707-mptcp-opt-fix-config_aeabi-v1-1-f428d0aa0318@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fix BUILD_BUG_ON on legacy ARM config
Message-ID: <cd70d063-eef8-03aa-4ec3-0067fe134631@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 17:51:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/288844=
95747

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b83e2c588655
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1123250


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
