Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBE129A67
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268753; cv=none; b=MGBp4z+vcHfeuKnOFb4vYRfdaLo/A7/qJ3n5B8yCmLoXsnhOVUtJx4WPpJcdxs5C2X5yBLr2bJJ5Gi6svQ03jHQKdACiqxVyHwaUQPtigSF3yfO5eFCB22Iy9M9yGHjCXbvrAzqaQn3cE4dVYXaC2EVV/lrOPjPiQ5LznFed4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268753; c=relaxed/simple;
	bh=50SSMN04CHzJc2HvxmYo+bEfZmrV/I5SE9dubmpjD1Q=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NNB3bSXAeEEeCWNNy1sRXoPvxPsytD/7legLNnJjbDHmGBrmQ2VNCF4/Vo5qy7KsngtK6vmAFDjyVlYgADXrxyfBpQ42zh291DXISvdZu9BpKTbcV2vZcK5O1TXkr0XK8Q7bH3zz+j6KvEwFdxLoz7VdyZ8sCNKI+r7WClSRliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFVuUkhI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFVuUkhI"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a475bdd4a6so2453186a91.2
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713268752; x=1713873552; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjrW7MFsHYXzLoi5VYVoojZbdrOEVxxT2B5FgW1J4qI=;
        b=YFVuUkhIcA53wo9xVgtYYqB+vRa706rZyH/SohYn1z0D+4cm9hwkSiOu2hdUDDAqiq
         gEGJMrbq9a7SVs2uY0WWglj9lfW/bI4FgbdetnDRixVjkQZfQ/d5dw+nWMIuhUI/fwKO
         7o0JpEWzy05nsJ0JZrnEZop2+JO0w+pCTksJpYO9+wxo5CsAs1DJ8ItifD+XmDp9Lnv5
         KjBdoa4VBt4ZXCobC5s8S9aufyLpGLYFQxURIXovL6PkRP+jKi8NZaIFLr2lg1gY3+oc
         RNHvnz+brS0Ofcxu2Ejm57sx527ZQajGkux/tdg9m8I+FixX8SquD320YrXy9f2XvVLq
         ljmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713268752; x=1713873552;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WjrW7MFsHYXzLoi5VYVoojZbdrOEVxxT2B5FgW1J4qI=;
        b=IIGtTta/QYERHs/d/vlvZZVRM9uajApe8YIR1IXaWAeKYW6bqJPGxJlM+zzXr9aU/k
         PF/sB5YI+ElVG9CJw4ZJ+DPMLeprEfavHQpyNX1kMndmjSkt/qafIUeJ3vwcHlre6z6k
         TdqebGPJF0E+JJu2gQfHosIr5mMVUA/NvMaYrjXfFMjrCVoSDXQcbtiNchDiwpaj/Pbj
         aI97UPk1kphFyDhN5OJ69BrxduDkxNu0FHbOeS2VGVG/Ex0AN1XW7I2gGOSiqki/c1XY
         YytysQZ/VF/kIGyo2w5NSIR2MnMHPIE89RCMh2IsV1khOja1LYHulGOttTRp6TBV1MDB
         vnmg==
X-Gm-Message-State: AOJu0YxZwiwd5lLpXmLjpmdkYWLHTMcLJrOgpPAz7KJzer48njfs3IUJ
	thgb1Ou72KWxhzF1sQ7OOXzbvW+y3tlVVhyCqaS7JqXq0ddSNqJ6VNG8
X-Google-Smtp-Source: AGHT+IEu1oNUiXVXqhH0QsfQcWOA3ffD8zIib0ZMxGGgtFNLVQjchJeoHS/JWxERusSVwv3n5sn/pQ==
X-Received: by 2002:a17:90a:38c3:b0:2a5:37cc:cc4e with SMTP id x61-20020a17090a38c300b002a537cccc4emr11136996pjb.32.1713268751634;
        Tue, 16 Apr 2024 04:59:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.25.64])
        by smtp.gmail.com with ESMTPSA id a22-20020a17090aa51600b002a2e6152f55sm10295736pjq.25.2024.04.16.04.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:59:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240416114003.62110-1-kerneljasonxing@gmail.com>
References: <20240416114003.62110-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v5 0/7] Implement reset reason mechanism to
 detect
Message-ID: <7de0d73d-f1d9-d429-6cf1-ad15a4890c9b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2024 11:59:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/8705084717

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/83=
268a9f6efd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D845019

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
