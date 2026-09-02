Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234C30F92D
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333810; cv=none; b=eshTEnd52HSwWCVY1C3dffITiPLZSOtd8/jNJQPuM1yMaWZgD4efn41qk12SdUY7q01jz/L33reVjGXRo36m6RB8dIsPegJiaRkwAt3uJbvEoNu7MU7uKEw9RNM+xsoI+nQpK0CMumCP4ogahDpR9vX7HzSQnKDiX0BIQslNA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333810; c=relaxed/simple;
	bh=vbuxQl9swZzS3QH1OrE0hD3mFtSTTAtPo8ba2BkJZlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=uG4jADW6jBXAQfWDNot9E4ZwTmG7H+NXM0AFMng6NFqV+/vYaAfde7Oxmd6wQML9Ur4+E5yCDuCINxU5l7IBhcrX1w9i9B2nz+DV+TxYDxp1rBZnuesdhwRi2abc9nK/V3kcB2RopfYOFZh/+DL0kkKyHifvs6ysdrCLQziuvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHaC7y9l; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHaC7y9l"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d715f4a587so10736675ad.2
        for <mptcp@lists.linux.dev>; Wed, 02 Sep 2026 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788333808; x=1788938608; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yy5m3IZrnk8Oj+je1RvDQDpt1B3mBvOtHV4agL+snxg=;
        b=jHaC7y9l6otBCF5ssEsBYNOMbamHaTj7AxNTQ9rksOzmrEwVhzA8+qeXnXuSKzYYan
         lJjbMfmF3RgcBzp7/BqBTnrw+EspHHGwmPNRK50avk/rN9TkUNpW/cwOnxe2wjGgMmZA
         DdXFL3OgN+HHkhCYH7EVIcyZr1JneT98zr/pSOh2+mZcelBhwTkO3SUGCXxyrMH1KpyV
         hQJesl79kM4qKs7+RKMb5xdzl783QWNIaLhDKsYjseJ1we5E/aYyupzWkcm67vy09QHk
         3I/Ynsf6Mo3hgSTzpHCQgg+X9XnB4ge20og8/DBZDDqC4YHIkeBpqAtPA6viRTHmJI5j
         9IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788333808; x=1788938608;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yy5m3IZrnk8Oj+je1RvDQDpt1B3mBvOtHV4agL+snxg=;
        b=hAROOHKWAFTZhVFUrRH7uvBmih/rAa9+SmuB327WbkXiCStlbBx51+J9Kc/c2MDXhJ
         ot0FIkUbty5yxKVaDrkyhGPLDA22Tz3zVJNPVhPVHFqPtnod7hFnnSKJwm57ZJY21jv2
         ePA6YVdlKUmmEud8wX/oK+nfHeN/1vJfBv+aZUn59Rhl+pCTN8X8l0EO7MnPxVHMS6pP
         6v/yJgnA/sQ+TPWTmfLfRIN2OGMq1bXs/SfIQwcpX8t3RVGY8JZno0fIFQa9bQBNpbYl
         fL2+2c7sT5oZTyLHvFtLiJbHkxjXeIbPF+xK/OoRifCkGlpIQ+p1u3ht02RH92rmJLjC
         KwCg==
X-Gm-Message-State: AFuF++lzbueN9c6lyWYalCNiBpm3a9d5Hex5Dl2AcnmXi+WdPdwHsPnF
	ISXqhlgJBj5i/kn3VUWwSabqK9MsyC325SJwF6NfFDXUPaESUb5sSpxMfjVg
X-Gm-Gg: AYBFou17vdtrnM5z+3jVJpGiLJH+vUhjRSPEBJ8KGXaaf7Mw8xd/AbN9r7AEJ+xyK1h
	EdYG/RGfQ2Evc83ls9KIFa5j2WmEy9sfAUCH3tNAloqHxvahIWj4ZCimYrEaYzsr0rxUPzu6gGF
	zzYLFKOnk/fmO8oFd9iJluUEDodMufn/YntRnHWSF5nxRWXPqujeQFkez66K1GHxugiMU4YH4cr
	SWmQ2RHawUQBVrV4IVeJLwOKdjzetlHU3+et9gxNEbRvw6ZxKzL7gobnjFDL2m1kcDr7Yieq8/5
	qmylLOTxYuxy6c/QmmhpiZsAosffCTXiv8klXuX+gB04BFTRT40WHoqkMlQxjEunfcrReB7zt+o
	SBbPU01HXQpSp50YqcdbPpcarZD6hwwZLY/+sByJWfwR1QJeLASi7Z43HTFc2vnitWJNOus0CzY
	ZqheWJY0w3hdaV5EV8eN+f5KFrAqR2NdCoEjDthqjH37k8X3t54fMGQuJKoxeiKYskLKD6d9E8m
	04=
X-Received: by 2002:a17:903:390d:b0:2d7:1cee:3682 with SMTP id d9443c01a7336-2daec5dfea1mr46587885ad.5.1788333808469;
        Wed, 02 Sep 2026 00:23:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.242.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f0ca7sm4400891eec.8.2026.09.02.00.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:23:27 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] selftests: mptcp: convert iptables to
 nftables
Message-ID: <b16891e7-8c5f-7ba2-c280-31cbaccc94d9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:23:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/33602897785

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/72=
e85b05cb7b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1155871

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
