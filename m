Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC11371899
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786176111; cv=none; b=ZHUBb4MNCbmlrCWCgWmQFFNgTQ0pCWOvOmQ8kCnK+uZWNQZp2e4h3PMj0UPQBruS2hSfBFb1I+whgmjUJQ/7HHFiwjKwuBPzVZPScEOk7JesWKzBd+SRunDhFsxNnTPpU2gfULmFiRZWF35wuAL80tNGctlRMG5Sp56ZK2biikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786176111; c=relaxed/simple;
	bh=HU+bIogILTp7DfFfzNfWsg2BYGYqRsaZ1ZgDLYdEyjo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=q4Fo7Yx1erElom8zj4ViloO79//SN8r2CEFdGu00ii2L/HNYEw9ilhi7WBCXD58F3Eu5BSsG+tTSbtkk3bPhFI638YjVPwMBVJIml7dh96CIt4vGmXjBsEErbC4IDxVofPkx1tLvYIDMxC4MYsXmSzJ/5HeAQoYu6ZalJzQAiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFA0pA/D; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFA0pA/D"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-934944f2d22so15196285a.0
        for <mptcp@lists.linux.dev>; Sat, 08 Aug 2026 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786176109; x=1786780909; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fHbskql2r4MhFkTui3/1zkvRw1eKhAXBEdb5aY4yIts=;
        b=GFA0pA/DKhkg8B4LXm2ZjyUyKO8bWMqf4uFUtMZw35rtbhQP/fjf1RfhB5JptozEc2
         TAimDfomDNwdD/2zw7M0H5OVxuhRuJ/J1NfsovjjL3dEqWRu/UpAm9HtoFLk86bImMkS
         /IKKifSvID+r+goiAT0J7I35dqN+mZTOd4jGQhyWY3ly64N3bsZ0cSjkj0JSZ4HuP9La
         HqLnIoDDpHzwPR9xVK1Xe7oeuH/LTKOH2x84munZ2OsSDAhY8k2l0ERiCSIdCIZ7sMVy
         03gumNBnFDDH4LG826HwbmALRJqxxjCjvz5VrqNVvvaWLc2Zwr8somTgK8c8yjEb5bFz
         YumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786176109; x=1786780909;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fHbskql2r4MhFkTui3/1zkvRw1eKhAXBEdb5aY4yIts=;
        b=PXYHRGR6eA5zacxJESl5M5P9bClYc9zeVRjTpDD2Z6iPtC9Yubs1aBKJ3LKunJgeAv
         9bZ1NakQWb5sLPcq9Xu8HU6gmDDLEPoqPKxHtvV3CwDQv+oRiNk3+0U+yUDdJIM1MH+m
         ffeVsxVkwMRN9UmsCrUOHTizN/KXPfYgIRz3imPisSsnOxYvBoLnT2SxE2b/DTSnsvoL
         H42B0x/BM3Ik14BAsZ6TIUDqC1EW6NIjIHPMo4fjMBrpaUx/nSSGx9sltWQKegLISsie
         FOpA0d8JDAiJ47e2bQHWuXOzIijXgf0qXARbt2wFr3XNmDXn76AbvsL70yf/l/ZcU6XT
         ECOA==
X-Gm-Message-State: AOJu0Yw53Kd7ZdH8BDJ2bHAQzD2d01uloJxbcNI/Js+LA8boZgxqAdaJ
	V8RdEOcG/fm1fTy24JbPbAaLv///Mf5238e0NtSOYHc9/llNNleMYFJjrgNE6KM=
X-Gm-Gg: AR+sD10YzjLC+9KtROIuDW+BKTdAi+mjYFxr80OGoZW+NDkdk09Z7puIf9A66VmPeld
	f7PB2u2cTGyum0r9Jv1yRwmQW7XPCERL44fjkZp1VXJwlQzBfN7qm2UB70V6j4B54a7BTVc6mNF
	90CU+ZxdDYqV6MkBYgr5nTfDPMxY4Za/MNPbaNVBAGDv0/Xrf7EqhEzJX1/84COCjz/g9R5N/+z
	UxWpI0TFv++5oXDkXAU9bC/Xyn7xMjhwJvxTEW+z/HdyPtmSobx7c5xn6WOuSKNfoaybtxjAeYC
	596k1MZHe0S5bAUaounCTJ4f3Z7DWYoyFao9e2QKQ7C1QZm2+CD6vkA9v6jTehgSSIz9fIArKrW
	EL3Wcd9genQLwfNkQVKcS70mkWiSr407FoA9Y5lZoQ7SMaDFALjw8stNBHP5TF4S/b/WIP5OJd8
	3rDiqGrrcLGdPUpL5o2AKTNIylyHA6UrnqpjJELqznKebNfUMwMbiLGq0oycE29Sqtm1jKeIhya
	O33rzC1I1w=
X-Received: by 2002:a05:620a:12e3:b0:92e:7733:e3ac with SMTP id af79cd13be357-9364917157fmr2418508885a.20.1786176108492;
        Sat, 08 Aug 2026 01:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.95.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03ed23sm326723985a.7.2026.08.08.01.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:01:47 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786171863.git.tanggeliang@kylinos.cn>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH v2 0/3] nvme-tcp: add IPv6 traffic class support
Message-ID: <cf164fff-5751-41d5-955a-a67bcf826745@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 08:01:47 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/312456=
11809

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/61eb4ed8fb16
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1142555


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
