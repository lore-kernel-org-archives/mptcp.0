Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C201356768
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372991; cv=none; b=XocEulBjIGrjJjlC45eHzTaLoHDrAGfymk3+/tV3wA1kFFzTQ5HJmCqPzbPD+dO51DVv6lb/fGEG6BXh+aFdUQA99Ip9UBqByWRU7We+rQHqMzq4Q6PW8qI6B6BmEvdZSoSX25g24r6mFHdVKCP4R1gVN2cdNeaCebkSRY9hK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372991; c=relaxed/simple;
	bh=FmdZHFFiuR3RvBKt5JtNp+Z9LjNydxSrnWkXlAXT/v0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Vr56JL0kFt63vYFESElvCXCddUXLNiHOEesc56rtSKDyluDjBl+Cavc4QhXQi88+qbbjgg1ODPAmOJaQ2F2ApIKfVzf0x1jg2nkRHAVFt0R3h1BgNGtKDl8x1S0l3D/u/+spSX2t/tcU+jTJFsLLz5h39Q+WseuHPqzhwyj1+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFGNd8A0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFGNd8A0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517583cb07aso15267831cf.2
        for <mptcp@lists.linux.dev>; Mon, 01 Jun 2026 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780372989; x=1780977789; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEYc6nUQ0StSlNes2xagpP3Lxzz0YmtpC4x2PSQFZb8=;
        b=MFGNd8A03rvHnUYSFrK2RH8pPxSxyXsXKahn+Ln1PWKdSzXEwoZ7YuN/xsSmbD2w0q
         XzwSysuR4+gLgZ3UmFDEIlc7jv5iUSZN3Q7HNX266sasDL6gfs3wHpXdcwm15s5x4vvG
         neK2kKAGnAsgmCriY1aqYZ/wS3x1dCXg1JDsd1qUfWPcPvSdrhRCR7JKF/lC9aVH7+gH
         ff6jiyuHDLPlWDpnygyh1Jm8+viIj2RRnlIyIkAWojgofynETiwVuxB1oTnVZGCjgY5a
         ZGI4JJ7yRiIh9RaMXt4cw1atXHFg9GiAWWTGnUnlntZnrKVutVRQ7326rsOma4sHCTSV
         Ydjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780372989; x=1780977789;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEYc6nUQ0StSlNes2xagpP3Lxzz0YmtpC4x2PSQFZb8=;
        b=s9T/0gdPR/zcWGiyg1LIBKvGLRxy1GLhQ2EhLfl6rHC2P5LeRgB731A0gxZ/nk/HkZ
         GfNV9FFZplnwpzmi+VpoMH0mxFt1zWJGvHB+fPF/KS62v44Qf1d+85F6QjT9XKKf97To
         O1KZ5DMZtXNEMbtN2/pRwVaRwwYyJf3qDvrceTJs/8pzcJHOe0dsxXRIBT3wu3ofdAGT
         sGCIc1EhBVZeo6nX/3RybRkoo5PZg9d8ygtm01m+zsG+2E/AVdvHqP9nAH3NQD0+MNU8
         U7faOsY2ZXqALiOhEiAuCbyYOly8hifW4G5sXmhMxxJ/0/+XOBvd29BfzEU5pXhnksT/
         hYPQ==
X-Gm-Message-State: AOJu0Yx9zTzkVbfKHkG8Hp7tIdQbBfXDnyk7CaPDDFZMdoYy86tjXHsN
	AgpX3NEkkziEhfofLhqcnGRJzk2xWZZ1o5Zp/vv6e8Nb8kyl0xIFoGTSdyFS
X-Gm-Gg: Acq92OFwu979HB9wAdxGM2FV2Yq4U2DpQez1D6g3iREoC/ezbFYeNVu4AwluYBDrKXR
	SKPIEGqQWcMlvivGROaMPucrvq9HSD2/sdazT2IZgyksEdS5Q7UmayVpF7Cg9Y373TdYPBK0qhg
	30hbvg4eA2nVl3ap8oKIut6C8JfAo92MyQtLXAKHEgR0Hll8W+YPbDEngnqcMSPKw5bQnO9Qi1A
	u97XiEfKy9gZlOzraYjq1FIf0847TnBjakc7ZpHyK5/MRVjG95Q2byiEDi163c5Ew1aeR2b8e1S
	tUEcdheoVNrgOC0HJIBiHhMaIqFHn36J/k5yMpCSSAPwdjsM+7SNkmev9B/bLrrE6/PTZJsK/V7
	c6SinNjYnVubPmmjyN2cW4R1lTnOqQQSE+8DsfF8QzZzQbN4DXY3iSS1p8RUCztraS52UI+tI1w
	5vuprUXwrgrM7FJNlX+JHFNr1Vtdf8eR/di8k5JseSReKVtw==
X-Received: by 2002:a05:622a:1186:b0:50d:8389:c3f3 with SMTP id d75a77b69052e-5173a8dfd82mr196010361cf.54.1780372989182;
        Mon, 01 Jun 2026 21:03:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.60.16])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741d9986fsm70832331cf.21.2026.06.01.21.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:03:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780362942.git.tanggeliang@kylinos.cn>
References: <cover.1780362942.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v23 00/16] MPTCP KTLS support
Message-ID: <244dcefb-53d5-ff3a-fd9d-657ca10b147c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 04:03:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/267955=
03303

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5f8742efa540
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1104314


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
