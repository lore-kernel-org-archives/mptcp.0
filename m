Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1942AA2
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506537; cv=none; b=GxKe7On4xmJBx4pJeH71cy5sIPShlwt11tSRS0X1a6cfN5mMypI5Uvgg8RYPCV+mFG0t4gZNlidQbz3r40MDkIIvjQ3wBqzsEWh+S6/TPfi7RJgors4goGFTaINM+7MsDlSaPRTxOlw281tNXzKfx/WKUZz13kDyOAqCneG6UJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506537; c=relaxed/simple;
	bh=Mb8KOrfmz0RrmnDjkcZLRQGuPniQ2+SpVpOiC+9zf8w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LS90Q9tTOC2BtRbq6bGLds3kd8s7D94Pu/Yd8ac7XOTiwS5QAUCnc2hqHSVeYD5FwqqjQW21Pp2Q/8NkyqGotlDkM5cwK67yS5LYOPFfktUV1TpbmvY6U65CXgv3m1En/v5Ut1uEANP1lF+kt2Vp9W2veOeyal9uSMMWdf9JSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSrSfKHv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSrSfKHv"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4568571de47so1642031cf.3
        for <mptcp@lists.linux.dev>; Wed, 04 Sep 2024 20:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725506534; x=1726111334; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bTrUfmkmZnlNghkrFO7a2Yp4XdaF8Rt72pbGzw+uxM=;
        b=GSrSfKHv+x4w63dmj6zz+EJgIKBQVQ5rrPzlWqJdGauondotAnX7FBPO58a/lXVI1I
         puCL9ViiOfaOwkZzHe2LK2g0rPYms19x2Ne83HNBxpYiG8E0kgeR7ujBmbodpICmL3ZO
         pnYInAWCCgs4q29aYxMM/bct6JkRtqRSPtH96CpIkvrffQ9+DGmOxtzSPoySCBpebnVT
         cJuLiBaedYDR1QdjzoV27VGIPrIs1xllixQDgGTfB1wBCP23Uy5eQBR64GL90aPKWanD
         vaqXvt32EzA68O0ss+JF8HvQ5q2IN8RjgqWGh5sHdIHrbpS6YIfIZlsgLXEYfKt7k9WA
         W3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506534; x=1726111334;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bTrUfmkmZnlNghkrFO7a2Yp4XdaF8Rt72pbGzw+uxM=;
        b=KB7gPmn07s1a3GfJiMYKYiktw9kTyUB2MBjGi8avY8MxhJyTClfag+abVSUh9SizDd
         E+FvQbHYHBfTCTwKR6nsqgD5q7IILvn+prQSAOdLbomR9ue7dFVXDZLc/JTxTcN/AhyP
         cYG7L9NXQ4BFjpK06VR4y1Q6IAWkC2ynOdloqb8J1FMJ+6NBV03GcoeRNaC4i0v/U9xI
         HlOVuKAjiXTPL1Y88yymxnUtx5OCbBAZVh/BorEq0hF5cNp50R0Ra93sFzoWiA1iyGaS
         H3loCh7GLqLuHL2+0k63QKokd7+lPYGuvI2sdb+kWonk5ElTmuN3UM+nU09gZBRCdj1p
         E6gA==
X-Gm-Message-State: AOJu0Yy6sMpKh2vpMxu3CEkXZR16h7SpMOlMzPjsP9U5PS+mt35PAHRC
	5kL1LNuQhNTXPbHrcoHl47o8EuyBMKWK1/Kt0tr2exdDJRduyY6xqvBH
X-Google-Smtp-Source: AGHT+IEEdB9OM54SOVYfyuWD3ed3NDhUUHiCpwLPNM/p52HxXQcPK5+QfzjroALPOXTEVhhFwgdoPg==
X-Received: by 2002:a05:622a:5e15:b0:454:f412:e08c with SMTP id d75a77b69052e-456fd7c3ec5mr213890751cf.24.1725506534349;
        Wed, 04 Sep 2024 20:22:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.159.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801dc378csm3803261cf.96.2024.09.04.20.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:22:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725502822.git.tanggeliang@kylinos.cn>
References: <cover.1725502822.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v8_0/4=5D_fixe?=
 =?UTF-8?Q?s_for_=22new_MPTCP_subflow_subtest_v4=22?=
Message-ID: <30d6c43b-949e-38a2-c0d9-976c7b2b61ea@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Sep 2024 03:22:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10712924117

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6b7dc077b311
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D887030


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
