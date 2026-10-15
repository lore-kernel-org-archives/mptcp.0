Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1134383993
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078129; cv=none; b=l1eCRyqEPYiemqd1r8rO4AzYT1QIpmkI/Ioc5FFwXrXGQ8UZMgZDQeeIQBknU6Kl8FIy2rJLevyPxSLfn5ZBwmMMl6R1Io3MWRsUDDbVeZB0yUzuyGlRN2H/QUFzyY7XWhPsH307eeI6cXuyzMF02M4FIH5S1Un4HOxpqajiyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078129; c=relaxed/simple;
	bh=+B0hBVBqMAosIXD2i3UuKwhYjNL0TyZLjrTf8HDoJyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=L9/XPHq5pXiI6jTB6fTqFaeJ0ILHu6EtboEaqHFVcaO/7nHNvg14bjHlkYeFLpYTQl+A76rJPxrbx6Mo3u0wbwiQUKh6SXrS9OOFTaJVP+mRxOlh1G2c3kRj3gI/PjLAqttDpmdwGDtaqwPFNNdNOmEMkq0kwEO+XhQS3ravN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTkBSP0Y; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTkBSP0Y"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-917aca1aee5so18549906d6.2
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792078122; x=1792682922; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=anPPIvAtF27MYpBCPDW750XELhKp7A6avNvRXbftgXQ=;
        b=iTkBSP0YXyq5eSP1N4SlsYhR7TZXQ2DnCFWtPnrfZNqdVS0GcOY96+ENF3BHfuBjUE
         BVSqIW4DPR4voTllJF5nS3PyWkzCG7A4QowVmmKEtSOaEy6q4wvjnaOC4dp1HxXtvE4e
         NdWemJ9L7pTB7zIY/z9VYD1BgoLecVNrKia6fSse4O2L8P9D9ci1PsJqYHsIis1vZjDe
         J15WDoisyRODiSFCiE1IfQn3QnQBzNGdcAahU/Bvcx8l5J/INzT8n9xIh+rMYSleWk8e
         rLT5/TS1YS+JFFD9Gr+r4X0c/ea6XmPCDCFSiSO2filZyTvZrruvHfnAnyEdrmL9m9bg
         o/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078122; x=1792682922;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anPPIvAtF27MYpBCPDW750XELhKp7A6avNvRXbftgXQ=;
        b=nfHHuyn5vlroUW1e1GUyughqpkxRoK6sc3YD51F+XQoc+h9nVJQU6GYt21uD/AdyqC
         AWxlUyE7b7stPQlcHDgZjhMWWQtcbDEeLlL2DBC1s74BvE0q0l+quYPQaunNiweqWf4c
         fl5wjuz+o90RV086TEwepvNTfXm3VAHHi2GJqxuAhdn7AXJpNIIef2aaCbz0A86XGKTI
         exqUDkR+UM51iB4xQxyXKQlm5W9v+QsFYRNCVPJu8D9BCEJz3f++MYvgQci+dUZZI7Il
         NIB/CVIETbm72Si4O+NvNNwdNZkyDURDf6DRLUcSID1/EFlH9dMrUwGGgsD1slw++Lph
         ePRg==
X-Gm-Message-State: AFq9FYIwqWBknUdpHOWIKCF1IcyrdbqT4pHbnK/rJiQ5fpq7CUnHj+Fn
	v9/ri3tnbHEHx2EJ19VlhIx1KM9QbW0xZMyNFe5uqQ49Z/BPUAzd8lPCjdEG
X-Gm-Gg: AYBFou1fU5kFz7KXepGy7apTiVIe8dgZ8tbJq3MD6yjT8qSDmR5KF8VlALy91oCuavy
	2XryYomXOQXqaXAuc50xuSJlXZ3j3LETdaNdu50ZGtVXIn89Rw5rFtJU3mAv0U2HZO/bnip/4lg
	RQBOlFx8oIesLvbfGoR2PzxGOYbChi3JXKoTi7LAStrhbFTBUifCAubQzsjdTv8ekO2APdIzc5D
	+eSFmu6CuBa1/HznKDKZJPqL4D9BkBB6KPY28EFh1XCtn7/ELNOwwbflLcTpK60Wxvk4BTJBukA
	P1yvMKanjlPt53m+H0mgMqooMOdvrIKOGLmWNdvksmSXWVEXMHpAXBZDL7Ybhzo15sfILtw6cEh
	Y+HfSQWw2yk6Aj3ipWg9hsh3U354E5dmC2WJ81LDl0V8sfNjQaCbZ7BsB3nikn6tdrxjjfbxGJL
	am5zMC63HXu5DYuvdNqyhEFi+7zH4+EBJYXetAsMVIHzWV0CO23iNk6J9le/PcFDuAZ+/KVx3fp
	Z1u51oaQMP6Bg==
X-Received: by 2002:a05:6214:3484:b0:91b:bcad:116d with SMTP id 6a1803df08f44-91bbcad1207mr35194266d6.28.1792078121591;
        Thu, 15 Oct 2026 08:28:41 -0700 (PDT)
Received: from [127.0.0.1] ([48.216.234.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b92b86sm84618746d6.30.2026.10.15.08.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:28:40 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261015-mptcp-first-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org>
References:
 <20261015-mptcp-first-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: disconnect: reset first subflow's
 local_id
Message-ID: <4880576b-f65e-5a4a-6166-3acb44d2c6c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:28:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/387505=
00938

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a2037640a176
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1186511


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
