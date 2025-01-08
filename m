Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AE14B95A
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326866; cv=none; b=eIFPDkoTE1ZN5B1BOod99NycgsBIa9Q/rAM/646+/gBnEZ5p2BZMf98iAi7vkiUmQwD+3gCEZswrJQ5FOMd4QMLQMeR7jy7Q1HL5yo0Pen3urVLJmF1hXe8OtgNaTknf7wEpt9wMG3Us2ZPZbJbYFKxWpWYErxN9zobsyC8cLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326866; c=relaxed/simple;
	bh=WqZGTKmzeDgu318Y55OR3O/byUCwRna7u/k2YbIAm1g=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PuqP3yBTazGw5syDnSqsl9/5e3LGF8rGRvuLDjw+HqPgbOALqQxyEk/6c3bQ2A9zw5Pzfqt3zqS5n5J5bnvAyC4mVA2Jp0e9TQYFxRDCjAQIXWijOOwl9AGFArpCOR763nE+Spu6vFfJm6bB2OTpSEllP3KN0WxoPPWxFB82Xag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWgMiggb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWgMiggb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so19596096a91.2
        for <mptcp@lists.linux.dev>; Wed, 08 Jan 2025 01:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736326865; x=1736931665; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPAgBrH3ZtdOrAUHHMfrRPRgG7ALk7vaotLULD3a/Dw=;
        b=aWgMiggbgUHeiFoXZiWurD3QZ0qoE1tX4elqxLY/axMcwGmP0Svys2T1dKfdGc8XHG
         0sY6b2P9HZfDKGMZqNryFtI1NR710pCByCePUUBvnMZOb6t8MxTeBX+oWOd/TF6bGco1
         da9105YNo85jUmHl0uD98v6sRXnG05hQ0dhM3B7NUNo2EYUFBEwyQMXPC2FdMSrzXdlt
         hYnOehN5E5SrKzN8f3bneUF/6rej745JDItChdtr5/YXQbS92kpAwnNRP31zSPtnxNna
         +ZELW1UEa4q4PtnCmWZRHLyEYh1u5A2LFlSZ62zCJXOsszJkYcowDBwAUsJ1qcQ5Rle8
         FcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736326865; x=1736931665;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UPAgBrH3ZtdOrAUHHMfrRPRgG7ALk7vaotLULD3a/Dw=;
        b=fkryKSY9wFLZBNVlBwmOh4JHY3Si6fkx4lHqUpzuGrZ+muVvMow/KjC1NCRjjGw7v7
         0WenTKhiA02KDzDl4RYS8M8cNhsIC1k4KDkpR++sCxlcxX5J2CIAb3S5zQQR1K44D/ti
         p28l36vSvskmh9Burc48jnfGcJKN8PGc8S1VUcp0EXdm+s1CMCjxpQMwnCBNQZSMpDw6
         arqIraDKQlK8umggrfE8sAJJHdwPW7Bb/3ZyMXxdB0mh80xpuU0S5c0DV6NbV9McHKaH
         fyCv8yrEjl9eX7P7FZ3IAA5pr43wTFXvqijpvLCgnP2Hi4bud0YNZ/1C+98I3sisQhIh
         OCgA==
X-Gm-Message-State: AOJu0YxjJcNqSXrPt6irRzCFELu39Bze2RwLJF648+QvoZUo/O7tEg2F
	hNv9weTYTGaOR8L6cLB+TwpZVQ+c+0fcEldkDrEtQ8NtERnxobKyRBGt
X-Gm-Gg: ASbGncv9eQvIGQtGquzxVWXkKcBETMzSFhgkMieiOij/VUImmsOJQ19lfIOgyxMgS37
	pbd4y5piiOZWVd+nbYfc/PZvCsOBqjiT+cHvqe/E/ajumBajEvMIJzPYAeYvzF4OiQ+xUJoWzeQ
	hdoLpHSCrpfk5kQsWjYTPEsB3oxt1KejChPWvdYXgwcc+S8IKxGbTy+a3aSPkoCmB9eMniDNVcJ
	JSENVsA8L3mVzl7zz9SfgafhWeS4nXdpk52FUFKQRR850dTx8F9/cXDzLHnm7yfRAMxsA==
X-Google-Smtp-Source: AGHT+IECNkaF3BK6h8NtAdtREpqhgDDE1TgLhwP5tzv3bksmbq+sxGBBLtbokQNdCQT72LGC3hn8fQ==
X-Received: by 2002:a17:90b:3bc4:b0:2ee:e158:125b with SMTP id 98e67ed59e1d1-2f548f1d71amr2816563a91.26.1736326864643;
        Wed, 08 Jan 2025 01:01:04 -0800 (PST)
Received: from [127.0.0.1] ([13.83.123.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a36a085sm944090a91.47.2025.01.08.01.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:01:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736325184.git.tanggeliang@kylinos.cn>
References: <cover.1736325184.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/5] add mptcp_address bpf_iter
Message-ID: <bf9e71e4-da86-070f-eb8c-5e8a7d416eb2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jan 2025 09:01:03 +0000
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
net-next/actions/runs/12667197780

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/c0=
4bc714ff88
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D923265

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
