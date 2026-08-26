Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E90476056
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766634; cv=none; b=W+JKO/kYs8zHT/1hVrOkziCUoxI9343+HrIPSR6K6ghfMlwbCPOnB4v2PyR48CGIOzQj9dA7QX0zhrBgi5oeEsWyC/vZdMU+fF4RwUCo4EL3iNpMveqzZ4nzI0h++BlRtvRa1PVx9XdHE4FWdEvVeJOh9fHU8kTAM48gyApO37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766634; c=relaxed/simple;
	bh=kc+/dwiX2eNqfl0tKWy2jJQ3j4HdLfjgzicLz88ytEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=DVrHMnWlCfa1NDQ647GAtp2DI98ACseDaLOIucqAlZvF7W19XMCadWRHPLxqMyJ5CrJOOuBvK3reXNxyXkmIXlKflxs74r9i4Jda107YgjkT5COvANojWHLVg8ge5nEpm6lzaObe6bEaDTZ11AkH0vAoLQNmmF7wLTU+xUCAsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQUNPGwF; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQUNPGwF"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso804915a34.1
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787766611; x=1788371411; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=emEWOk6dq6DQR95PTtslkRiHMgxzNOYUWOSbmCXWO0s=;
        b=VQUNPGwFF48jlb4+jNDG4yFMLEGSG24CK6/QVv9kJ+2qcOov0/a6LZ8hyIIBb06+k6
         Iz0l9oNV91pA6NXfrwy1QeMKXPKfpy1P3ynhiTjukybD9yIvQp7UaxiuFw22gVeBO+ke
         t/CqD/dQOTfe4MaWHixixWqTOZPKJ+o5p5sjUIV7WQRU/Mv9Wb4vv+EPCbcsZQuTsdNA
         vTUfyFdGG7RfGBnsc7PdkBXSJ+iiiU5qzOkPJQRl38S+flosRVzra9XSmoo30mSoX/CW
         asAZ82VoEE9KtvBJ5n2dbfRgQ5WU2Wc1j725u9n7CG5Y1SyeSiM2yJ1uUOTbBOiC3ve3
         Pmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766611; x=1788371411;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=emEWOk6dq6DQR95PTtslkRiHMgxzNOYUWOSbmCXWO0s=;
        b=nLXGnksAjZB6TOj26IwYvWU9g/Dvlvs0G9NGsaFCKjqaxG4Rb3olVycnZfMFgofAhw
         lnhKI1sUMT2IV/p/APiL1DKAjjAjT7nfHp1rdS9a97m36zq4sR4WUC4PXH19rbxKedXf
         rShDswE/+/tNtixm5iqrRsxwpdRePcRSRbjMCLkCoNzMFEJZbo0LYs0CJezU1oHObONK
         1qTY6mvK6WHcOmd0Upzpl0uWzO9pdZHKDYNr49uVsTAzCi0rwY6tHoUs2Um1GPH8FQ7R
         WsXuWdB+Dgeixuyi7OCWFKE7DvzLj+Sz0X3vOeco67/EEPlLPzKsTrm3mZn0F06TuKEP
         SPTw==
X-Gm-Message-State: AFuF++lM9xrAnFPeSjsiXXNJaHW2YhBlHuaNgpwSW5b0zg9EGwZOpgfx
	O+cIuB43LhnWZ45JIqPVXLjojO3oSpMoqMCU+5QNDLXmB2FA/GsMy4U=
X-Gm-Gg: AR+sD11g4lcWnyPv7X5WSR3JLp8wALaBSr3koTORd9uQTJXykvrbtarTuotCFAsPmXI
	lP0yoJhhjjLDY2JsjcA/4PBsdCEelyRdojRRgcN3rFYkayBSgyFwQGY0exhTjFehEiz6eb5G0ny
	gtADR0y5qIGxUHU/s2SrlgVvXpij8zEekrDlUVhAdYAGHxkTewcX5XMXMpuU+Qq90kJ3mhEO8wt
	wYxqEIhDBs46EZbKLhbnnKJhJZXU9JhKL9BWO63Vms5NAn2rDC8z1RgFi0zZwUM729OFh63nl7S
	1gJ5y+ANXFjnwtjzVtY37hXmEPe0/+07vYXitp4i/OM/T6ZhSSFRuffwvHrqvCn/97P54qz0oQl
	xxvJDPSzh71X2H9d+/rmOZsuTirjFIVX2jKpYF6rTFEsSvYG2C/BPA5o1rxE2QGycyP4MWicUU+
	bphhymqaDgnm1vHERBMIENu7A06VogA0fvGiw3n28r6empgqywCAzDPB+klV3j+XHWNrunY0q1d
	6mo6ix4kixrnQ==
X-Received: by 2002:a05:6830:4411:b0:7e6:f083:130e with SMTP id 46e09a7af769-7f4c4fdeef7mr8834117a34.4.1787766611037;
        Wed, 26 Aug 2026 10:50:11 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.124.177])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4c842ac28sm2143172a34.21.2026.08.26.10.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:50:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cen Zhang <blbllhy@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260826171344.4133-1-blbllhy@gmail.com>
References: <20260826171344.4133-1-blbllhy@gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp: fix use-after-free in
 do_tcp_getsockopt()
Message-ID: <022399e1-16bf-3a85-52db-1e3cc0195f2b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:50:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Cen,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/32995824879

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/05=
4504491348
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1152216

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
