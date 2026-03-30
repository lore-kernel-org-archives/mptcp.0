Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826E3A6B72
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865173; cv=none; b=gJNX5ZpvTuMDt2S/iQGJdC2SxnuXExHeHWnyX0P1JBpXbDmblh0YCvDHdXi3aP5huYgkQlnqAs/WfvbMIOWJDwvSqmlcam2DBujymst/UvPEXSNB2avaRAmd64Y6cSAd7G7S79ByekbEhW1uFAoGa+zUHc+LwvvRdE7TGCRebzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865173; c=relaxed/simple;
	bh=+1WicrAR18uioG3pVHRcEUG/wEkxYFc4KvdtUolFpi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mAEGTU+4FpuLdDr23U6xx/dV/NVKVatZPnNlFp6zIHOou+CDvAAZLohc0te1B96w9CUjqJeZoDjwGvbkKeeTHqyjwfAiqVmkk4DKw2j6Vll6Fc8WU7EFYJ8g51+e3OC7URrCH+LuDW8ZAoU32zPU2YDJGlBuh0coD3FJbVcwO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRu2C72G; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRu2C72G"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89cd8596724so49693146d6.0
        for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 03:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774865170; x=1775469970; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFlTnS5JYheaxhCD3/oqMlfX0wRff0G54vgXf7XHIKM=;
        b=kRu2C72GNsxypOY3prX/zJzq0gIKQFYzy0RhqQGxoKezVBJZ7KOJmcx9vzSLNjHgCG
         B9qKVaTBloZfWoylTGizLu20N6XA+VGbdBsJDsqxIzKli6K6qfSioVX0EpesRCcwCrhv
         406tW450gw6B273EaJBWzNSY7od6X7DAzEoEcXsYbTqj3sURtkDsFUP6Zq3n+Bx9KQJV
         39D1aKmmS+x/r6EoXBTu9CSOLoNyGbhflL1x8Yif4/bwDtM24tJTxvmZ3r9jjGjK9sC/
         FRuuW6lsro5ZLX8ARpg5EohC5D9i8BrcwGxzZc9r/W/w4m25/EFdcZ2Z66DSPnacXRaK
         rBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865170; x=1775469970;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFlTnS5JYheaxhCD3/oqMlfX0wRff0G54vgXf7XHIKM=;
        b=M4I/TTTTMgoXuWL2s9UughKMhhm6DyLKK5S4FtvVIpPiMSJXDyoA049xUJhpQ/psDo
         0Ouk/+WyhLp92YuUqxJblI9MvjO9szJFJtZATnTHTMBfv1+Quw7J6rPzKOkrou5unsRV
         3ZyTmdYlBPUK1ew3U1g7Vh/QIXFEcELADwsYQBWtwt7xX/LnSE6Hhl8aFHJyxLgKd5/j
         fbLaZG+tv6xQKMKUeoNk5Ls6o3emHKz9SLzB2BI75+FkTCiPVMCyDm5hhXPrMYmLpoCs
         6KusvkQNidQqU08u2D/0sFvOw34AL+xn9Tl1lfHm2r9qECxmk5UwHZnI5Nzh3bjg+67a
         ZUwQ==
X-Gm-Message-State: AOJu0YyBw1UaidI0Xt83XJeV1yINQgCHum9cgFsViJWon5n4FYjG/NRo
	0mOLhGD18ZiFiRvh6GVnRMWpaYtx2qfaS84+T2dUMDDvIzQaWK1idwSkVhYf
X-Gm-Gg: ATEYQzzmr0MHU+TzyP/OKcNxTqErqWcxKgpRWZlC1Iv8aTzjfaoEXYpxAYWQHnmgLea
	PjbI6AJeowKHgXng9NlPWe+DRqSwO9wdXavsRBf40soRcnjxbBnJGvMsEtPq+Ntqmcr3nQGf6eI
	+BVSE0qUbYkRAH2MTCW2XguM50ogWCLjvqGdVDMDo91kSUwkAw673feGb9uArLxq6Wt+Bk14u7H
	N4XT/JGmsrjhL7GJkZVPy+Q5ThtsElys1J/Pj3TilGvJCzSDqTitV2kf2Jo9Jlc44aOlPbW9F+N
	tmut3X2fu4sKHua+Zk0LJ876wwSEAejtpoxbQycUEBXpiYiandi5iJ5ZoFuMtA/bZpBIaLJN+5p
	YSSeDzv2XTUwnS79rwbVJ6D1BZh9uZ9qQXHt+Xz5dDPxuaFu+IH9mNPua/svUZNCQxJ1qJsfSW2
	w12Zb2HI3qkZz6B4T2dGtLh4i74Jc600TyZujf
X-Received: by 2002:a05:6214:4992:b0:89c:866d:15c9 with SMTP id 6a1803df08f44-89ce8f73b25mr177631186d6.56.1774865170517;
        Mon, 30 Mar 2026 03:06:10 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf2852dbsm59517706d6.27.2026.03.30.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:06:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1774862875.git.tanggeliang@kylinos.cn>
References: <cover.1774862875.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v6 0/7] NVME over MPTCP
Message-ID: <f2cf00b0-f646-be45-5ab6-75f6736b3cd0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Mar 2026 10:06:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/23738944865

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6c=
b584e4f7f0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1074466

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
