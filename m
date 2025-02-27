Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11721B9CB
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639892; cv=none; b=QxBYn0apm8HbdIupQYzrnkMVJK+ttQVegzDXqICJa26fPZN4ACSTcTq4kjX+0nR/fYt27tpToM56/x4YUcsYJV/r28Z+buTgkKnwiVeCxjPjMpPGd6/OEYGdpaNgkECXEyVHqbSJNc+4hm3tmGFvjw7WMwMqaKXFogqWFwHRNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639892; c=relaxed/simple;
	bh=TWEycrQt7nuzx2bX/fMxstiN9DLT/y9tQFfxo63b0YM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KqDh3OGupa+mHPpQuF6c9UU0p3jAqEF11n8N1SyDW4h/8KqMJUlA+osqfkWRKxcJNbyS+A6GfhC+t71TKZXjLtrogUtKHCjjZvY993klDnGMmYDestuN4eiOL8BuCt219Sg/1Sgl35BkuEAVZwhwpG6dJ+2wM3gmb0rm84vzd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpuPexpR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpuPexpR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0a26b1c67so66222285a.3
        for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 23:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740639890; x=1741244690; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyFO/8GwAOFiuIcJ/FnIb3UIlPOuOfrKCAb1aE0lLcM=;
        b=JpuPexpRLwq6n5ROM1UmIMAtXtxaETu8sUQlV/FgbAossDuT2T2K2tTvWwgxo23/2p
         vi+JrkF2XefjR4SOL7TUtSTAiUfSepygHaBHCm91+387EQWy+AJkWXrDmYPVD5j5GED3
         Q3aNdamWHgf1M/y0xf1NuWwkcl4bsuoPJ+kcippOGgShVpOjV0ITyLcA5qHlV+DYZ5wA
         PyIpk6hi7Dy8SZakeZGaEknqcBwXrDVOwibELauwDtIFvSg7RCgH3FJLsi0BpQjjsBTc
         y72T2XkXcGI5uvvJP1EdrwkW4nAFeonWx6bDiImpngQDskwT7ZZwXdVlza+/+NCU7muI
         kD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639890; x=1741244690;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uyFO/8GwAOFiuIcJ/FnIb3UIlPOuOfrKCAb1aE0lLcM=;
        b=dUA+4cAUwkH2GRjDmQJlqVjjkttlp6WzT7kcsr+kCDAiZHScuR349NDNroslFduvFo
         2wDIOkt76lbqwR4tykAysY+HxJzFubQeiG0by0tDXpMQMf0WOR0jZQGFtYIUi6sMEimI
         XoN6LcckStQrjEcTQ2qrSYzXZUsLOWUCaO7Cyvgbj2T7NmKiJBiRouqNJqoA7FdFgEZA
         EtqUYyuGDRzt0NSEEixZrAxnvpRHK4k12Ai6Lvp10+3DVoXb+gipWAACpWQrwBxeFkSN
         W5NC4XDlcAD1qEyG46FyibADdnqj3Z3zwInQu+mgrOQxBtizf8Bsr7pDbbP6VxJlOVQJ
         +sgg==
X-Gm-Message-State: AOJu0Yz1KqppIAE75OGzthyrcTK2DLrpMPQtfXqcCDnoANWGSXStA3y2
	53+fhOiV701+wMIKNNlE0aTRNgCGK1Qas08qx8l16qQwVOzIG6FIS7r+
X-Gm-Gg: ASbGncu15g1wSQu3X/bXnKc3lPeqkVLS62llQxxMrMZvcHcFFEDsxaXaSWoYYahiyep
	VL6W2R9eR466uGMo5nDSm5oqMdMtz1mQmu7AhTrJRK4UMyjrM4fBubeNNrXeI61t3qlK1D1rnax
	vRR0k/ub2FLpyXEBVzSIT0wYtpMp3T2gF0311gT8yjXXebMSohUgxmNqJbakz05ltjaWrPc9ghg
	qT1PQ6gOrr6795HpW6v7yBlM+C5RlKbETWBkcHaMeu+KLiWkqNEJ+q+aj5oNdT2XD90MG8tnTA0
	okCgtn6THDfDxXWZRD23LRRPDaGCn7ldCLRBu6BWOA==
X-Google-Smtp-Source: AGHT+IGwJkLvaHfM1mHTymeZYrfrDIAm+nUUHH4EQ0QaowqxZJ2lU39oyZiC4N8JxoGZqeViKtkauw==
X-Received: by 2002:a05:620a:4512:b0:7c0:c0ea:dab7 with SMTP id af79cd13be357-7c23be4b36dmr1494473485a.46.1740639889880;
        Wed, 26 Feb 2025 23:04:49 -0800 (PST)
Received: from [127.0.0.1] ([172.200.199.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36feea6fbsm77601585a.22.2025.02.26.23.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 23:04:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740638334.git.tanggeliang@kylinos.cn>
References: <cover.1740638334.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/6] BPF path manager, part 5
Message-ID: <a96d4031-6be2-00cb-130d-e9cf9ab6f888@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2025 07:04:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/13560646576

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2f=
c0cce80faf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D938355

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
