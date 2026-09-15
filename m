Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B3266576
	for <mptcp@lists.linux.dev>; Tue, 15 Sep 2026 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789466628; cv=none; b=I+ZxTgDzGMJhwiYDAzWqMT6Qmjq/jxaNGSf6Owr8UMme9GdSYMaRYgd57GwDmkMhOS+0jOpDKcm2rEJLP2nsvfn4eoAauAFgpPDI3HH9NClL9ZMLRnIpVJ9wDfv/pDa4YRmFzjFlilBX/FYpD83ViZDmwFxQOQ/HdTvleQILOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789466628; c=relaxed/simple;
	bh=hmKeztkabllNBYMiojndyOBQsfd2rErwTkVq9mMP7NU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=rUgJ/pbJQf7hHOq650JvyaAjL1FyZxW4cdkfaI1669KNKj/8tMltlbSpl2ABVdhRW5lJD70CapFV3iFcaWKPE0as7Lzn2wG1f8ZG4mUKKw5/ndfF9I2UaXy7SM0f7tsNdomVc1+ISCUTjcv3oqXtXZ+LzKOrQC+c7Oi1OTCZEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6G+fFVp; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6G+fFVp"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6c72bd8a017so22417eaf.3
        for <mptcp@lists.linux.dev>; Tue, 15 Sep 2026 03:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789466626; x=1790071426; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mgnk070x7J+8UMMRnE6gjNo3TBhqUYqmL5SQyo271zE=;
        b=T6G+fFVp/g8QMvrk6/ih9XlFaeDdXUZkvpVz5nZoAznlK0mn4qN8ZAilmkg6P0egXq
         9B5uZi68GOV7HBb2t1mQiWMzzO6IfxRCujUz5PkI+RJeTfSaNe7e7n9k27ny2gTcuwQr
         IiQDLH/hzWg0Vg0SdcFalp0vZnS6Gc/gSvXM2uhw21H15BWTwZzcHYn1k/QixIm1uH+M
         yyl2UdrOjXwnr4Tm4yjjTE6ysY1cBahAniex5wXfqJ+V/XjAX2jBvuVQ8K/WJf4gy63n
         BlSG3OxkSC1YM1ttmcqYNj0weAGtUFdwdDGW6b9M0a4xLOqlZGeuymI26oSQmErywUsm
         HyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789466626; x=1790071426;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mgnk070x7J+8UMMRnE6gjNo3TBhqUYqmL5SQyo271zE=;
        b=qlWDRecAYISl2saZANbBMvFlV1Xct1/sOG/dV0A6CGzuepNaomfXeag255QqEBInpS
         qdUd6rI0sx+rCmkNoFfzzCa/IOT4u/jkFi1a6x9LTXv/46nJzGzP5jpj1T9NHetHOQda
         ntU7057PFuG/xHpuR/pqyH0/wVkrAGAk/3oJE7J0qI4Qwvwo+bKsuagn2Fz4QOjC0Ol+
         KxnJytRDDF/PY0aZ+QBS0wVPqMSyzfdACVlGd+RwhgJW23OW+DdbEh6CgKs4pLBlory2
         x1Tu9FTJdj5JYbzAF1YnPitG+MpvTnGxYUYYZ6RiNYJVe6IpixGIZOuR3uQ/X7Flqo6h
         uyEA==
X-Gm-Message-State: AFuF++lfFp9/EtkA6MNZrhqiizTcrX6+1P7dR7NnQPTfdQ9DpNGNJ18a
	mhzQhahqnzlc7G0xmCeATgaIxiiXdnLSgK/bnJgly2yZLDchfTCDfLVVnKV1
X-Gm-Gg: AYBFou0tFJzYNSRC6qynGDYTM4+b99IbcPK9xN/ZhBKKA5yxv3WmVEBrz+eAl1hllBU
	nGNpahhjguEDnrqkjCWG6Xhze9iwLg9hjnI+9VDA6nJGHkrZrIP/NgAzbA8fINDqvX3sMO/Iw9k
	lXu7t8P4XGVzgUcxuoI/dE8cuoOuGVafxXnRok8Kad2kM/W+uAOg3cOyOQ9BAt+CYSuHWq1DzXg
	jXSZTDvlxlk6+e1h5W03iFjN/My8MBxTAl/9VRFVkri771RQtj4EcamAKgvgHTv406l5j2+mpUq
	YVToATtanu0EVVBE6WoPHtNuKjeRZzLgm7dGpsqtkWGSMFU7Qi5fD3e66x18Q4rdNBtMEERpLXd
	iO4Ccr1rmmU7mDdu+/KDManxeA0SU3N8ZDvj25DY06Z9wkCVAbuLw/3QnZcssZ3CdvGRl/ZK0yp
	wmJnICfZR8Uk3DMSnZgBd1OKGESTG9YFZA6b+vcvxpwBt5U4oOQd8EMCNeB+yJb+nv/Dwc4aEtt
	rERAjXEigI=
X-Received: by 2002:a05:6820:1988:b0:6c2:f5bd:e968 with SMTP id 006d021491bc7-6c739c74fbbmr61993eaf.55.1789466626039;
        Tue, 15 Sep 2026 03:03:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.97.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1438d1381c2sm6208987c88.10.2026.09.15.03.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:03:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260915093506.465110-1-kalpan.jani@mpiricsoftware.com>
References: <20260915093506.465110-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v5 0/2] mptcp: sched: let schedulers mark a
 subflow to avoid
Message-ID: <4b783983-9395-07b2-e0b9-99b795eb5609@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 10:03:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/34955126200

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7a=
28b8cf9e61
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1165327

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
