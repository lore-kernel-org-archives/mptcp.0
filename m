Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77C1B87C4
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341394; cv=none; b=mDqAFzoVgQm9QjNlGF4RqNLT3yB/4Jgi0A0qgwGrxu0i5NmeE/02+irK/TBrV0sJY6cAp5kOrDvwF+ztSzUcFbSPGve5oZ3BG4wnt62Udxy40IZfU9x7CH/uhlkkG53e0MMIk2/eVaJdiIOtCJa2fe2O+uov0LAe4JRoTcCV+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341394; c=relaxed/simple;
	bh=4Bj4CrMxPWTwVWJwLE4GUEGA6oRHBBunGlv1uqJPO+0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TQLhh1th32hcACQxq5kFzeLqraZGzsBTHaxz1URpZuhXBSGj7/oPt9ePRm6MQh/fk0tn8EfnsgVLyzw8qdu7Wvuv3jf7eOTX6s5PnEQmNARYUDcpbNy1subXk3gKY6Oo6kMXU2k6Ga8ZAl2/YL0HfB8DQFElEX8E9jef/27TF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB6xNYY+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB6xNYY+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so3452959a91.1
        for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 01:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734341393; x=1734946193; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjECkHaRshun0yeMjjcef6x9hoYQt+B2Ji4mrxJk2yo=;
        b=YB6xNYY+mYv9EDMZGrScDe9ahZ4h70fb7feZ5Lpj5OaCWVLAoL4jc41GKiNZlGb4Xg
         gyTVuNiAUZmOM4TlM/RwTzInniKg7d6isVdqGvj9n/u4uIyHXn496YIZ3S/uenEc1jph
         dt/0A3clJ6e30dP2KyMD7KfrRPRD/zvDole05kXFdy8RylnczAbrCG3hL3K15bmArUq4
         7Uaua+yMMPcX1iW9llgD7iwxOhSEEtZnyy59jw9/SlmF/gexkztfaOn3BY4PVUXGYOcl
         pRv/qSdNo68mRrcFTpQ9sCrWAo3IyYU1QQWgRiVhTQvgS17MahnEHOxOSwa31FUYOBNd
         H+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734341393; x=1734946193;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjECkHaRshun0yeMjjcef6x9hoYQt+B2Ji4mrxJk2yo=;
        b=TkZnrUPiFo6Yo1784IApucv24YvuKDtSJfPq+aVJvOtII+V5K2B46TgaHHHqASNvwG
         aBnOvtjDdNEitGfT9a9mVaY8BjAOa8eSz/wyDH0A/Rm3zn7k0auuNAPsPTVvju8lms6C
         pZGGmDN5ZKJhV3dmNSDnKrybtO9LAgYUh7kxyO6cruUj6HNg0N/uZJiVFy3gQwprUWIg
         UrxaUHHFlZAA4mZ/9766PE5XvFRSGeSPDR/1wqYcqzbETR46gQdw1dllcqCs8NmhRJ+i
         Pp1calo9yfYWpJYZTiWfc7prxeqOoZjwhmyPuFsYe09475PdjEB/v5qjogY4CXoFOEQp
         s6nQ==
X-Gm-Message-State: AOJu0YwTDrtO7VX+mybuLtMiA3S0cmNircPYIxEZ0wNHUuuXxsBlXSVf
	jdoTP94gJIcfIGw2QPOl98aNe7/Y96Sxqp0Y2NdGAQDoIXiiN4Xdxt6I
X-Gm-Gg: ASbGncu52rb9mdaHVktjrmG/ObFGgNUeDR5HAOK/bAnSTeWYIUBNuBDjFuzfeUtaoFA
	JUJZ7pmj6C8hj//saTwwKfGRLbC69JEKnc6mCp001mTCflxxu9gU++uNzfFMcd3Hxh7LNE3lWk+
	R/02N+i1d4xwQGYm3HQQw7Eamt3xmMKhX0UttWTW1qTPz7gxTAk3S4d/m/XZMnayEYxuDjsL1Em
	/6dhNo6PpH1I5JyKNXQb/BUg1qOcsMarSr38CIQX5BVeoV4wiJyBqiepozV0p0bykfJ
X-Google-Smtp-Source: AGHT+IGELgA/iaPWb5ayh++Zd9BFbSP3Ww1VN0cFC+Xn7lF2nPJINQvnisIWd6kNSiIr53z9fIfcTw==
X-Received: by 2002:a17:90b:1a92:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f28fd6fc5bmr16414778a91.18.1734341392717;
        Mon, 16 Dec 2024 01:29:52 -0800 (PST)
Received: from [127.0.0.1] ([52.157.3.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434a17sm4787014a91.37.2024.12.16.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 01:29:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d9c76c6c008c770046f665a4a4e93735fd121399.1734337790.git.tanggeliang@kylinos.cn>
References:
 <d9c76c6c008c770046f665a4a4e93735fd121399.1734337790.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3] mptcp: use GENL_REQ_ATTR_CHECK for token
Message-ID: <e3589671-8443-3014-454a-21b0f102d134@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2024 09:29:51 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12348979008

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3a1e74facb64
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D918117


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
