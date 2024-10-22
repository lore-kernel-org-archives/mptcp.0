Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB99145B24
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591953; cv=none; b=ap586vJJdgTs/zQDKj1T1dpHfP7rXadH+ICpn2qavp69bm5MmCtfxaUqgyazUG2b764+50KM6B3JRm+h9FI8sC4z5XlOUUDsMiZ8jf1yTW6sRZD5zSeBWQwZv2aBO5Jtg2JPUg3j08hoCcP2nT2v+C4osXkcMrevMvc+dSUAgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591953; c=relaxed/simple;
	bh=jvJCeaLzB1VBanMh8S09bUXfqLyAJwE09uzkkh6RCE0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tv/Xp8yrscYvwhlIP3pKuLmXGv5udvKy5S+/DE3fk6qiXe/mwjgM2EGcXMeonbngK0VT+CyHJ1uaNTivY8rMWPAi19cjaBc5oQctJx+l0OXxJKT7kthqE7ZX1qbFh+6SkutnnDSKYFaEvVwB6o2cdihXaio4sWMZn9OW/IZpwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+qcl5Os; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+qcl5Os"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cbcd71012so48790515ad.3
        for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729591951; x=1730196751; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjtE6ly4WQKDH+ULXGBVrhY7boc1B35rCtBCvQx5ag0=;
        b=m+qcl5OsP8W3ouYveDCh8cGNuuAL2dIoiMImaXMXc7rGScX/NyLsaJYi7izlqhT19s
         10V4m/S9YLbNnzuwuSu/AYXqKzDCOW5OgFHFSdMvnmlpcLmPBPry5DK+YRyP0nccUk8Y
         /bwGBXCuwr3/ZEUpJBr+qPF6U0TkMIiUYD5O5D2W0D5KPNAUshSEy6Yh+Uj5iT39rocu
         u12UpprNnWCmB0NzBUl3xgy7Y6laXeW/8IPf6YhKgsxivLS19ZwMl+IBn/ytaE1++1KZ
         absWf+pbqQJmIdIQf/MsUuOexvXk5rC4H5yAj3His57vbeTGgFXl3CRvXgh91U1ibKCC
         rR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729591951; x=1730196751;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tjtE6ly4WQKDH+ULXGBVrhY7boc1B35rCtBCvQx5ag0=;
        b=xGtbCIK9Apuv11OLnrQjRm2RlnyNE6HdaTHbHaU1UgBiOR3r7VIgTGyAh2WJ6/lZz+
         EYg+tNR1iBjhinF+7hPeFoQAvxqW/hSe52UCplmedc37tkRuJ4D8ki4mrv59EdMbPYS+
         h+I2jTT3zlPw2Oglh6Mp4lKGFZndxyEghbNc7KTsqEn006xmVonj5FZB4qSNM69EYgut
         PjjlWIegG1TXG4XjQUkayThvk75fZUIBoJ89Qhp90XP4bBhF+EqO/KiqwYTnGK+DkWlT
         Ggs8fkNBvlYwlRY/A3w/6p2hzQ1GHlauJQHKN3IfediXEtkMwDXdmMWgUpSQphOXcnp/
         VMfg==
X-Gm-Message-State: AOJu0YxCyyk8wIhy7iDnrTgxFaJnL9Po7/LegBQcxTAfNypZ6AL6/6Lb
	6ZKsMqqBicp3SBhL9WqbWzbl1VEYj3fvHS/S3jFwqgn/WdoSjwQij1L1
X-Google-Smtp-Source: AGHT+IG9T7MF40SCWs7N5y5PL6NwzQTbLMEff9rQ7u++MyZCYmWtnL5DtE8+EYhTYjV3aSN3JVvImw==
X-Received: by 2002:a17:903:244e:b0:20c:9da6:65b0 with SMTP id d9443c01a7336-20e5a8d64fdmr196580655ad.35.1729591950978;
        Tue, 22 Oct 2024 03:12:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.25.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee65e9sm39769215ad.42.2024.10.22.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:12:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 00/36] BPF path manager
Message-ID: <c3f79064-ae6c-1e07-4806-68fcbc8fbe14@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2024 10:12:29 +0000
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
net-next/actions/runs/11457329322

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/9d=
ef5a043f12
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D901761

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
