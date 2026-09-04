Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031F29898F
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525122; cv=none; b=bnC/0xraTpdZk2qHWKL9ZGmJXir+RKINPYW98TItNkclD9bpfjJwa9c+Xwa6xNBKo6wBd+m5OXEOMInq+10YrzmAdbe3F4NeumNsn02MSWFKQ+IeRIEJOvC00Wz10U8pDwd0XOsWSWwt8Deajb1i1EZfV/MRB79vbEXGl3Ih5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525122; c=relaxed/simple;
	bh=p/emxKxtj8VOWZgLvdPIgAsAYorEDRu0iOMqJIvOjIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=gn83kMcLeq1koon7m7hYonhal57aQbxb0btXsAz4IM+aZrIwUt2f23vl3yz/6ujOVSiJeCB06ctJ2ErApUYi/Zc1KenJGGF+dYAwBfgiXOdUzAhZCfMnYLzvrgw/jcwC1Oz6nrkeA6hg72nLUNh8kezB5uYafIWTxp/Cy8EaLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM4vOMTt; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM4vOMTt"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a451915d8aso951978b6e.2
        for <mptcp@lists.linux.dev>; Fri, 04 Sep 2026 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525120; x=1789129920; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O7BcwgGHdB4ohRKrnBri/fERESUFpnLveDZjwAtTyDE=;
        b=eM4vOMTtVTEW1c71OhMLb6h+GPdz/cf7643Zzmww3bg2BY7WKYvVD69uq+70EtXMMG
         MG2PyDgLW/MdquF9S45RlsWRf5H2rQKa6GaeNdcAUvFG1X+79CfpYDA7y5KxgQXZx9aR
         diVWLg5z/ObOouf73pJP9v6EIJ3p/zuVw5+KLx7/281R/QIZ9C1OkkGrN6LtqqkF9MH7
         HF2Kh6XZRdPURWMmjBibS2wPtMpZrl83lK2aMgXuIx3FA7B2nlbsR6rly9soSSbEg+jM
         4b2bqXIbQ71GVtmTKFEfEDvEQKykXeqqw78d3oaiCczpdLBwE8jmyq7BNglRjqhWM1Gt
         MdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525120; x=1789129920;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7BcwgGHdB4ohRKrnBri/fERESUFpnLveDZjwAtTyDE=;
        b=jZQ3NoyykKRmG1ZpXoHocJoIP3xvLNUWPrvLTmxGZA8M4Az5cqrgjM8AaBj2GNm0R2
         QupCfEBFJYDo/Txat9CewkhJ1kKvwMj74D0XyMFDD6afjV37BxNQyJZPcdd41kWTa7sp
         8od3f8ot8SdrbZAsJMW35Ab6NY2S/wqmelrS/qRUQOu4iH8BcsTTE2kJva7iNO2ecPCw
         NJHCGQ/y8lVNGT8RSqpGnYhBKSRQ+OL3JuF5QHl8hCc261w+64qbibroE98LvYLU4t1Y
         BfG9K9ML58qRLc6+s6SNGHzP0/DXLMBvLjw5U+jm6S7DsTD1dfcmX+9uLKw/ucyKWqmL
         ycZg==
X-Gm-Message-State: AFuF++lh/h3HF1HqByfAShJNPlFLIaQnL2SSIUltfGqXqjqP72m5bbtQ
	3duIwp7QJZ/BCP3wq9hq68a8onJTjTdx54tGTWPVCK9LV5JTDpArZEY=
X-Gm-Gg: AYBFou14ayouz9tm64VcmMHRUyp19O9NSHJ9QcQo9MDj2yXzsAPAIdrQaYXAzc+gvvc
	N7Btwten3q1CTI2BTJpVk/Rw4TSwsl9K1y7Gzlsh6RFAENg0qdTJH4I3sbJoy8XQ9pxEeXxV/FM
	oTlT5UzEgx/pmqCWYFKByeqGND+C7k+gYB87qo4PAV0DXT4Z1plamOUffN+naP5zOalyREyRGtF
	t+foJc6fUHuBnnz6HVjXxTx4Csh+mQ+BwfX9Ud/X+tXYJNZDaWOvW7QeszRUpkHeH9eP/VhVsWA
	PdHTT4ijsr42mz9l2phHgEa0bKogb3kpT8oUAvFTjnfWFuxDPLQpTbKKPURvh9+GP/KdivaZxgi
	F4yq1MLzJlu7lHDw/jfUUulKH49PRGyLt/F4auaKGuy0+6PV630RSiJe0SkleI72y60y6BpxDm3
	BZJpij79WwHtU8yipI/Ep9beEEduUEkW8bUu1Jv1Y2b7QbaYYf76cp7kDyHcqoJ0Snsml+0NGq7
	Q==
X-Received: by 2002:a05:6820:211:b0:6b7:83c5:fdf2 with SMTP id 006d021491bc7-6b783c60319mr1635921eaf.51.1788525119819;
        Fri, 04 Sep 2026 05:31:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm6253006c88.14.2026.09.04.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:31:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260904-mptcp-shrink-opt-rx-v2-v2-1-d8662bb18ef2@proton.me>
References: <20260904-mptcp-shrink-opt-rx-v2-v2-1-d8662bb18ef2@proton.me>
Subject: Re: [PATCH mptcp-next v2] mptcp: shrink struct
 mptcp_options_received
Message-ID: <08ed4a80-2afe-6205-ff45-d1193efcea21@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 12:31:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33869151432

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a98754ba79b7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1157920


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
