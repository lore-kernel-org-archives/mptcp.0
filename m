Received: from mail-oi2-f16.google.com (mail-oi2-f16.google.com [74.125.231.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439634B662
	for <mptcp@lists.linux.dev>; Sun, 20 Sep 2026 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889277; cv=none; b=hNvNGX0Pc0Pdxol+PDonqSSyaC/KoKkRTvcTpp5qcdIcK8HlM+jK1wV6vrv0A3iT2gJMtoPs4JY3ZdiQQvRTPOGhOaEkSIMWEBBkdu21r634T5MTKVJT7HsqlOjl4sXt4V6So73lNodMI3n7cw6yVaW1Vqo8YpAQoB5YvU0g04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889277; c=relaxed/simple;
	bh=+UwPxEx4Nyt72HxZMC/hpu35ygWekQUK4dEVS2T7BHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=AT3Do2DIIY5XjAOeHETx06WK/B5/YQiZh5KRO2MydjXGbnIwzDkzeDJRpvm4t1d3I+M3gIjnIInTt5XmVd0vgkSud73RZ+2J2LnIzvkEcwctX2rkc4ZiiwZyw5voDBIEIQXQ6A+Q1U3NVMNO3HzGPLckVn3z+yjNU926f5+KjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrGj0QEb; arc=none smtp.client-ip=74.125.231.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrGj0QEb"
Received: by mail-oi2-f16.google.com with SMTP id 46e09a7af769-7f4f0c89e35so1418529a34.2
        for <mptcp@lists.linux.dev>; Sun, 20 Sep 2026 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889274; x=1790494074; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AbrZD0Gg4QDuMu0Vetu9RdzLZz4BQ268G5Nj77B8+vg=;
        b=DrGj0QEbJyKeUA/LipegF0/y4lmQOi8QZlc2UPgTSUmkjsyN5CewUoi+020s/mjX7K
         UAZtKVK5Bt2/v6XtskNIi1Lioucek/rPO/zlCrAfZI4UwMrzNGjw5+5SMdV0o40D76UB
         tiqmrC4EY/tC9TaotvbmmLNApILtayRpMaxG8vUTJ57kjPdCfOUrhrayY4bcRgWheJ2V
         zcr6pduV8CDoJkv+dPblx00bOYDirBq6RHrxLP2MZlD9oVDnSJiUL5K0XaFxh4cEwUWv
         ORjnx/dj6t7uKPEu7cnt+LFGf5GfI/lXLC08nBl4ge4J1ko2NGcRd4NJFbdNMsO/Qll5
         uxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889274; x=1790494074;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AbrZD0Gg4QDuMu0Vetu9RdzLZz4BQ268G5Nj77B8+vg=;
        b=thHZeU3LM/oNjhr2MEFbtEjZJ38a4mlu34mxv0VEa7a6qK8xFVXL7YW208MpOnkLuM
         vPPyOyVs0MQuok+V0qwSBhwVZ+VKWMAL8txgDxVd+ptbl4IH9IWyTRlv8b2VBOoD6aHH
         zPaAYd0sxQmWecKTdCZ3/bd4Q3jd+P+osCbxqyjmtoJSB0vHw/2KRtf9Srk6+VC4FReY
         zE0DVOh621X0EQrPvBJN1c5UldF/mTAwq4yCcjN7QP9jDiXHXBDZ5wBMFFW4gWJ7Go6a
         73S8AaNomKP8dFVXGykFvrNFXw6OME5P3YRmPxg3XvYJcj5/r6NoRKJ4eKB3W8n6VDJ+
         zSsQ==
X-Gm-Message-State: AFuF++lk1HZctixQNsfoNS+8wCOomRlaNRBKDiY6ZPBIOKApiCaLF8Hu
	FoGFKWTTuCkMj7HAiSU1rvym0UhsydW/+lq3ZLtYoisktuIdyKJwOTXSdCxO
X-Gm-Gg: AYBFou3904m12iIm4f80GcgRA36UAjNV+eOGPiTOdbKSRcleerAETlEiE0dq2otlyDK
	kqYipPbxG30I+SiQ79xGzVxRNobwn9zqg+TG5YNarEsI7OhV9IZu8EiHrPAj+OGngeyPGMn6u3W
	cyEGtXa/SomZmmESy1wLRgoyNYPTZb9uOnvZywWxcDRnY/ZrWm1KmehIk1VWOO81rjYBp304IHn
	NANYytWKv6pFhoMqAkPH5FNY/bro1meewAR8995revfTrcC4hBL4SPZGcAImxO9ep9PWvwIj4R8
	eg80MXbwsIxkgwNtze8EVmMaKJZvs312H1spauGIiiU5rX7KdbFMsvCWCOQTLswNAOhP5EE0JrI
	z6ER5FH1leZSzkMkSYWOPsHmp//2CFObxmimwqTAtPzL8MikzEcqrbZwYyd9Do/eQ1uCMjADZBU
	vP/cjRHySyTFHUhhEwv37zexM9mC85oUajPNSGu6i3KShxDO8dimkNpoLYX2ElHtfvISBFbUUMl
	9uccYmLkl6SQSI=
X-Received: by 2002:a05:6820:4b8e:b0:6bd:bf80:9796 with SMTP id 006d021491bc7-6ca9be50072mr8069781eaf.41.1789889274408;
        Sun, 20 Sep 2026 00:27:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.101.241])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6cd34b3101esm5251619eaf.6.2026.09.20.00.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:27:53 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260920061755.3575063-1-yilinzhang@moonshot.ai>
References: <20260920061755.3575063-1-yilinzhang@moonshot.ai>
Subject: Re: [PATCH v3] mptcp: do not use Fast Open on MP_JOIN subflows
Message-ID: <ff2d6aeb-77c5-9b9f-75e5-907b5a4511f1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 07:27:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Yilin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35494752388

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7a943777d9=
86
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1169617


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
