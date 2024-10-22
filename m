Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084413BAC6
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584973; cv=none; b=cEoDoT3gM3r9Rm1OxLnlN9ZC8SMxSv+Z1TQ+0IbxmwNrdoT/Iv64sR8x7ekjFf6K9JUOgnvD+QREjEjDkBGPmomJR7bG6vb5NvLsifIQLHYNcHl9B8Hyp+IFsPhbzrg27kbJ8t1b4S8RsqrQVKXmAB5Z3VYFxMGBmbNaXU5NazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584973; c=relaxed/simple;
	bh=5Hmiyt+6iLp22GSIVwCZmiYUPtv+QQKKnZEr2J+9SWw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DZOJrEfl/CdI5nyiSOma33AMghgJ2nP+ss+9McmEoPmTdHhEtZB4D5qujp98i4k0N83iK3sfCqoyCd1KiTGkSK8ysA3QYFu7au/q+ppcsGApDS89U9+d/l9fXInE2ynu3/KhzLQ1OBu4wMLxxYkn+nQg7KjVZTBPWIu9UYB3gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDNl15bl; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDNl15bl"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbce9e4598so31437586d6.2
        for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729584970; x=1730189770; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeK9VzcW7hFzR5zI9IcQizfyDr9Ji1yZ/AZpt745InM=;
        b=WDNl15blmM2ZPAhhYMEfiUju12X9fZEuTLtI+x++1pbJ0BDGF9iqoxTHTHrtDBKIK2
         6cnxt7VJvGF1KXisLUQhXVBcCBvJ8nwKz9j03zINeEAhXruPk4/dSmqYlBYqN0dA2WJK
         rZ19Th7icnl9+VmMO6Dg2HzjLsVMBWDWV0W//nWcvUhImsoUge+WGrd6c4cUaKirMjWQ
         6g0MsOFOtbiYQ86Tti0UecGb+VwbCCervpbXAMFi7TwLH3OKXdEpm4rVO6MfJkoXDtF+
         jXEhQntRGTeoc4PDEonBp9g4NFPNx6tC8N51Mx+kXfGkcu9EMMqPShUKZS9q+gd1QSXY
         9a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729584970; x=1730189770;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DeK9VzcW7hFzR5zI9IcQizfyDr9Ji1yZ/AZpt745InM=;
        b=V9FKA9L65udY4s4xctsm5zBR96tR6lzFVtfiQeJ4MAjJ62+M41zJmcZQLaqw83HsFQ
         EgMCgC/lzlDbNYupAggvwYKwBANsMVkGYBhWnscv8Y6MfSYWE6LP8bGD+JTOs5ChL+Go
         hSrYSZn+0CShGvRnrQB+BZgElL3B5is9+u9zEyabZe92nXGwYEO44injFb80RH2CVCZY
         ppvoYM1kLpdQw1CN2VN1Ntb0/wUGPyAOYY2kwSLYQgTgcbS9skdwHVuj3WWzIKe1m1kf
         0S7tcc9NOvVBby1I3q+yC0LeCpS62qPnKSIsnDMk/N3mt2NTPcWcxYgfNemLFiAejszv
         0gPQ==
X-Gm-Message-State: AOJu0YzwAYPHp9m3sZRIpj1oLXpxVmQRLw2foUSZ/0MTTSyBS1DJTYmv
	fYPHsxE4G2WIZzqnkKr/lOYE/RIVNCfP3C0ug91ATh9scIEH5KOqexds
X-Google-Smtp-Source: AGHT+IGbD48G+Cct4uWMDG3UTsoAUFOIqGmX8b0LrcOAmo2lGaWaEEAVZjmQbAeqMU6la7PmiOp6VA==
X-Received: by 2002:a05:6214:5b10:b0:6cb:9359:1e90 with SMTP id 6a1803df08f44-6cde16616bbmr249741996d6.43.1729584970416;
        Tue, 22 Oct 2024 01:16:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.155.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008acc2asm26530796d6.19.2024.10.22.01.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 01:16:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729582332.git.tanggeliang@kylinos.cn>
References: <cover.1729582332.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/5] add mptcp_address bpf_iter
Message-ID: <17a6b6c5-6c46-8349-9309-71014217722d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2024 08:16:08 +0000
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
net-next/actions/runs/11455981022

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/d3=
d814a163c5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D901713

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
