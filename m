Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE513793AC
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291963; cv=none; b=br+p3sBhMfos6LW/wCLb0yIUoBG5z/EmmLaayFADIDB7K/j88HXlcywONQvNDB6AjYxG+E2ALsoaaezH/Ve2u/nYPrSqIZoZ5thbOlUNEfP7eD6kcCI5oXtjeJuK1tKY5/kuLz+B+PRGtKD90PpqoNJ1R3E9L9GjPfgNR6Hqx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291963; c=relaxed/simple;
	bh=5YwyNDXM97e74t0+sJf+L8761UYKMKFr1hT/ohZ8ZWM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qTK6dqQFWocsjGZYiN4Isfz19tcQBzwaZVV9Xh5UK3ZLyl2Kxa7SJvmtw50VyC0Be24VvQPJQv9tT7zTSLBWMTDTpHEtvpjeMGOwLNhGqyG5UrhdMyxR6Ok8DCF62nkQ/yvaAQ4k/PAoVXMGF3n5VAs9op9HTvDx16r4qKV0nug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcTNHNMJ; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcTNHNMJ"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-45c60ecc0f8so356562b6e.3
        for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 00:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768291961; x=1768896761; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qugUF9M1760QYu1xvOeHfe2Fvs4OyHWDHlZpnf/H2mM=;
        b=LcTNHNMJTsEeEunXdLNLw5hK3+gIiGNDIfA0g/z7vMy6jr6ojRaPS0QLXyoUHOAOGr
         FfOOXce3OWSbB7yhx47mpT6kLk9CJDdMljLHyn7i0oMVMMKHoFFhc5edyylSNrBCuPRd
         QJnpD0gRP7uZzYZeyDEE0zuiSXt4XcWe/q9kQCUC9Fc5QT+7O9j2z90mM09LAJk75Qnp
         vET/JuHFVLig08dvfmd6Bjnev/RRWZY2f82Esj51lQ9CgSQIgkt5AVa518eU5C54sMmp
         hSjpgg4qoAnJzd7gmc3l1N6+8s4/z2dnXg/9a8Vdui3ATZAXuIQJji3bjLKywj+yJL9E
         9/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768291961; x=1768896761;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qugUF9M1760QYu1xvOeHfe2Fvs4OyHWDHlZpnf/H2mM=;
        b=c9PhA4zeVZ9Kani+8DDieDjquHJBULGftHkp9BKKwuffT+B+C2VM106JTRSQ9zO7jt
         t7mW1GHAb0KeR+nP9LYaScYSpo5VQ7DmXf/X9Nb97oq17wWl5Vcoh2X7EVZ2XAGHxvuX
         4L1LpGfc+eI+eT0E126WC9uAv097fW/VDTY5Fwf2xGW6+6auaTy4tScVV/cj0kqXVNxJ
         7Yyaw8m8WT+XZiqNIRsFt+b6Di/Oo14kvKlSYitCufrHAnHSALeyEQ4Z0m+y33YAk0DP
         luSm2+O1OMxYhOfmmvyWn0cmrb8H4zC+qtIXZbpyEhE33+SUD59O0CbUebs0mr4J/1wa
         x94g==
X-Gm-Message-State: AOJu0YxDUCITjb36pBymPD49xaGnringYfpzPNFr9mQgr/H1yTM7PDiU
	hK1h4Bo8X5Z+POCD2gJswnBta3kwWVSh4+bHWQmtny3x+IgnRQRdHUyhgj/9UcOOFA==
X-Gm-Gg: AY/fxX6l8V4r43VwhNEZYGMjgduBBL7Ac/GUwhuc7+pG6O87OezCHWjenfRA0hUq3ys
	7vcUxG+5sbQGvDBgd/scx6XaX//nFa+hIr3Lnois/MIFpB4k+a9L5uXMmfHBr/D5FyI0QoyPrme
	bcniFO6dZ/0/Ky0GLWlXpLJEY+ukH3K0wYin7/wNo5YrQDs+t2+/EfHOiAwegZZxEef91/Pam3K
	hvdmlebeKo8jHrmK6gv7a6eO2k2W6YR6HpXdevLu/4Lwktm26X4bqGqhXUphP0kYhhDbOOi0rUn
	Y+mtMQzonmXpU8vjDzGd2TbidGmTcFrM/EJza8j3EsrG7vsshSCd8GjMxi37XF0/cm5RrlRwEXr
	puh2u56r37DH/PNcD+L8nKDY27MFyqDeWjZrD32qIJSatHMMwoYnPd84EXJfuRM3oeChHm21o7l
	syjBiQC327e73cKSsW3sfsmkSw6mzLcxo/
X-Google-Smtp-Source: AGHT+IF+L3dLVJjVPh8vkOwibKiV2InpI+aI1ybBzRRm2wsZBc/XzRZ+7sZg/YOeZGKjFeosCiOynw==
X-Received: by 2002:a05:6808:1529:b0:45a:8cdc:cf7 with SMTP id 5614622812f47-45a8cdcf5acmr7772987b6e.37.1768291960701;
        Tue, 13 Jan 2026 00:12:40 -0800 (PST)
Received: from [127.0.0.1] ([52.154.20.52])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2894e0sm9140567b6e.13.2026.01.13.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:12:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <95151965c8e5b49c6246c8cbb5f543177c0737de.1768289171.git.tanggeliang@kylinos.cn>
References:
 <95151965c8e5b49c6246c8cbb5f543177c0737de.1768289171.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BRFC_mptcp-next=5D_Squash_to_=22?=
 =?UTF-8?Q?tls=3A_add_ops_in_tls=5Fcontext=22?=
Message-ID: <bd780195-012d-9f08-f24f-7bcbe55997ee@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 08:12:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/20948722197

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b2=
e4c337dc61
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1041596

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
