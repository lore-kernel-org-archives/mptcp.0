Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFB3C1416
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032437; cv=none; b=p/0a8+CHgkL1msI+fooTVki2mdte8viEQJwuKg7dX//7dxY5AphDGPHfFQCoL2b4fyXwX6odvVAD7d8C7JnFE0BGfS8ArbYXRs0KyUC+UAF5M59SvG1KJhiSIl/rsfnieqlwOJgQ9fE02IkmooSzdXY0sbKfgHWyQFMhc5kuO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032437; c=relaxed/simple;
	bh=ALsw77QQRISPlYxAMeCUViXp7FN7i3fVy6H5YHBEHUc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=eVEIcwMqNgcs/D5vCKjEQgViOKBpuLkCOVerq8dsC8wPGA+1cdiV0bMZxmjii85Bvnwwt/EVh0DsIcI2NeeYVyXuBI+mNWg6oP4mGM290KfHJY5AQA6q4TQSi5Q0n8yOtuCIuK5Fqgp1AWnTztILSX+aj5TVP4Y+WZZXRbO3Zfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVOflux3; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVOflux3"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e5bea4045so48594321cf.3
        for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 05:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777032435; x=1777637235; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwN6Vxe9M3wGNsN28Yii1Dl6tdaSocXWA//qG/9Vzak=;
        b=UVOflux3vWXT8b9jdVkmaq+oXtvL+wOjfD84nci94LHybSV/fbbTvDE/Bng6X5QSD2
         dOUcEPhgKDufDmAlyWj7fI6YGS3yHPtLfTmwPCgJrYXIlTsnqwpNpzK7gJPcLfG9gd4s
         S6TYwLWXRIsQovJ3BnernTk1iOg5cR8adetxmEONi6PvRBGSbQ9/vXdh++oITY9VldU3
         jJ6ioeuYy4Ohuxp2l60+udI967A48gSz8WhWcEcG2AFFPdOtHIfXiTN7g8GsqHCYMe27
         b1qsUMbzgRavpdXDbnugpnJ7sH5eRuOqqLslLK+V32Ks7wPyBHLLUUjoh1pMnhEn1wbP
         upCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777032435; x=1777637235;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwN6Vxe9M3wGNsN28Yii1Dl6tdaSocXWA//qG/9Vzak=;
        b=KOKV9n1Bjd4ja0snxD8hMMma7c+Hmbe9/bRjmm33xbWPprPz3uEl2Fhj1La7R+1Kfn
         zK0dCfxkEKhAYHwiW3E5ER+8wym9LXUn/dpm74Kb5JrLJyciTBWpqXRfRFjqmEHxhMcE
         tNid+y7nR0YCrj6WD3hp7rPqHaQ3TEYRDZxS2QudxAFBFT3vTU1m5n/MquGD+f7Q31i+
         IbgyS11CKaOlEEkd6uEnZJHlEneAcpNG52nUqZNeahKbOpe3h0zAik5R3tcI0IwCnrCp
         eige/Cw07j1mZQNFk22XGLoJOOOy6pE31VJPATt317i94rbHdUaIgIQWdvV+9tRvwuO1
         GfOA==
X-Gm-Message-State: AOJu0YyL8YiTRtPBtynvEQKoLW6kIxRKrGFLK0KDaq3iSQVxxKO+CXP8
	YJipqQ62FuKPYVkwHfMkAjz9DMWbWs1+Yke10ciAMX3NaBnAKV3OJbAnqx5N
X-Gm-Gg: AeBDievqc6/OmyBMdVx4SrIMMaYnb+fw7L3XlQRdGHTSJVDNM36AkWynoNkjoiA2M3Q
	vF1ItuDzTMsmNMLrVSKHfc7rDVCBJuhu7SbOOc4MH1qSVklj0UhsOHr7TVIuxmsmlgjbLfMxEQs
	77NKmVkY/Q4rEvYHdkwNdiTR7KFXSHD2VeFb0G1nCxmKLqoXF22Sqn1+AYy5MxKbRhdxH0CFoqA
	JWaxQlArVGaArznAeaELD2UzlIZDlhThLpSsHWEJgwWtsodECOE7RcIPuEMsezTcABIgub8ZBv/
	h6Q1KbPVFlgoviSY9apzqjX4nAybTEfqtorlb3ZyW4+bJa5OzqumyP35ZdTeBqdU6TF0c4zsY3I
	lbDLdMYkEJQ34JUvSYrvNy3Ubrah+Fvx/s1EASHWfhfnzIN0aDcoDxyyGxgq3+skaSzYUQYacJ2
	BpCaRtT85V/KzX7iuY0Jkl1IpHe4hbA4vEkYPfPlAM1me6cFk=
X-Received: by 2002:a05:622a:212:b0:50e:ca38:e220 with SMTP id d75a77b69052e-50eca38f4f0mr296722531cf.45.1777032434583;
        Fri, 24 Apr 2026 05:07:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ebce6ef86dsm1223001385a.30.2026.04.24.05.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:07:14 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1777026753.git.tanggeliang@kylinos.cn>
References: <cover.1777026753.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v17 00/15] MPTCP KTLS support
Message-ID: <8730e5b4-28ed-f1f1-2b36-fd6b5aefa026@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 12:07:13 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/248858=
72335

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3dc18a1dc747
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1085149


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
