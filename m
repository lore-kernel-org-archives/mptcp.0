Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D63D7D65
	for <mptcp@lists.linux.dev>; Fri,  9 Oct 2026 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534919; cv=none; b=diOr6BmVBOcxk+GEygmt0yLBAv8UG8i7CMSryAjBoUFp75Kkz17jpzY9kvmNfvlixo2VrOKdNi/+U2KBi3W4j5CA8OSqgOz3YDK1mgXIQIWdXkY+iIEiH44aZFFv7WWiiTxmLZRNR/kcYvmY+sEyqR1WIjSw5tDSp4tvGZ7NFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534919; c=relaxed/simple;
	bh=43GfGESAhqd+jhr1s3srl3exC7w3M+5VTxJrCUeqjaQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FvvF8fwBpInCJkvro82kAz1tXLLliP5/0NSAwWpWaV8NvXlI+bGeh6JoQ2ZlpkWQDrUG/066qTD4c834hmNrWnIsj0SybuSZ/kjlOG7zRUnHOftE1YW6vB6ewPk1i9DrZKXq2l5o/vVaQrLA4J8sCuiAdSvpQ9AgLe0034oupO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSFFvUqR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSFFvUqR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533797e72e8so36559581cf.2
        for <mptcp@lists.linux.dev>; Fri, 09 Oct 2026 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791534917; x=1792139717; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v5IR6hyzv9IYSv/vSCzNjP5TfYGWHzyVfA/4ARXqkJs=;
        b=kSFFvUqROhwMrtNylZq4ak/mBZSm1lf/aofD9JMJFjTlvgUAA/F+4GzcRy1yl1zBHb
         a4yZb6eI55jFPCXaUE0qidqFbFrm7ivjiRuyzz2op/tuq82GkSC3oA2LHTNMrG4Xnjpl
         lUohr3JVlUwogXcBKj9l0deE4xnDbqKP4It8B65dxfszsEOMnORppKOxeBj4hqS3A0H/
         jD/nhJO4nq0jsuz2c/WT6Wx87gEQiwq6RHZVmB7lB9GWwU5NPJX2wQoon3uy0hf0V3Ud
         rkrQ+o7zT5G1mLxExos+6tMn+9kk4h0lsJzaW3aFC73ifzA+ONcQB7VF3AQCkl+3qeti
         hxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534917; x=1792139717;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v5IR6hyzv9IYSv/vSCzNjP5TfYGWHzyVfA/4ARXqkJs=;
        b=Kqlq2/lbqj0D9GkMavpVVHEMpCGxVLXsS3OVAaEtmoRTGw07r+jpYjMyy+klb/UTGP
         Facuzwnfy5/KcoBIB/+AHkdkdrDOM8Z5yUBGaxwLbTpdQ72LQ7caL00x7oKBkyF75FRX
         bEcZOZg2W3ofy8CoybhSwmjPuBBrFaqnf0ySl/m2fTQQNmUS8EzchFH6hDhR9nGi7ykf
         5D9bpHhHTDbCSpg5f8czMSKGxg4kVr+zBT6KXHJssrsq+lyQg4/4e9ZTJNzfptfVEVd3
         gf1g8S7vcRWMzo/ld8mGPXTRk1Idzh27PU58XF608ygEIRziEdfg9w9jM6qeREj7PBX2
         Vjbg==
X-Gm-Message-State: AFuF++mCL0G8MkmvnHWpXP2HggtNs5Zsi+jLQ/uNZyXv2OCMrHWYDpUP
	Zs0r4WRA96LwOvuUKe3mvToL43ZxrBe0C2wzzEFYS202n5vfMgPbedo3Vy4Z
X-Gm-Gg: AYBFou0SBhjOf96VblAx1zNxDD38l2rY8tzHCSq4sTwjzLdyUUjZHgeRBwVTGaoDjv0
	sqSC9Pzacll7ANQ5TAj+7TBtKqeQf1vA7NpqNnumijheyx1JzdNTv9TTmqgO40QnVYNBBg5WFR6
	riS7JOEyiPvMebwLM412eoAGlYFZxD768c+tMvEYnxKLM3NSAtyl+r/yhMCO2qBBG6SdbmhU7Fg
	EiNLy4JaZXVqbBeYxohWgnRLx3ZdMGNLrNXJv3yXtwzfRt1CeRShTzQOk51CIJEd+Sq5cJ2l9aR
	XH75fobSF16BEnrh+tb438aEmg6Bgmrb5E0KLHya2pFfsfqvQmGzL8J8DqvqFum2MjJfoJiv2TY
	Wjdnzsj+xU0mM/xZP7PyFch9sPEbUNIIFODjcKF3jG9vQ1D1UK0hcKR7mY//j4fUyBDZ2HUsgCc
	2bCAUxQ36m/LfIvzxZUewVOMCg+VLMmCTBiMzECdWA9jg5zYDUQ50SRjnEwGc9wxCBdUXg817UH
	nHCl6HznA==
X-Received: by 2002:a05:622a:5809:b0:532:d773:99a3 with SMTP id d75a77b69052e-5359f46d526mr17646751cf.6.1791534917147;
        Fri, 09 Oct 2026 01:35:17 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.151.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7a34b5sm13180961cf.22.2026.10.09.01.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:35:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261009-mptcp_rm_debug-v1-1-a7b4fdbe1b5f@kylinos.cn>
References: <20261009-mptcp_rm_debug-v1-1-a7b4fdbe1b5f@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_convert_iptable?=
 =?UTF-8?Q?s_to_nftables_for_mptcp=5Fjoin=2Esh=22?=
Message-ID: <dd2f2c5e-3eae-b556-1ff8-0a9a1322d432@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 08:35:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_mmap =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/37900860669

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a09fd9597e=
cf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1182161


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
