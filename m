Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC81B661
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736482434; cv=none; b=OrGi2MFtABU/XF6jg9ywCGNDqV6cu4Ojy9xMaBafZ6ibB9Pdb8bKmK6SyHAgWy5gbU44D8LCA+H77u0u2wN+P+7qdycHWP6655sSFiY1uq9VU/Ms1lx6cNORSRgdg8/eHRXIb1pDNonCaIW6uSK+UPExfGokdytTkiajcLQj2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736482434; c=relaxed/simple;
	bh=Nq6gT7Zt8XK1Awivjh4LiIw4qZ/4TSE09aVJV89bId8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=JTVJ12gnFPtACeA43Z0yb6WuDUArVtCScPMtlZkzP90eIS2sfOg6udfFiPGHkU9XtKpwx+Wr+Thr6rLq6yLY5KXVqyB5hQdCbObimLlYfcvZc2piku1xMdaQxn9IkHRGiZ5+KUwLQVhfQv3jWi4L11iEIey8W8pMha28GCE12C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCTgssHK; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCTgssHK"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46901d01355so14774931cf.0
        for <mptcp@lists.linux.dev>; Thu, 09 Jan 2025 20:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736482432; x=1737087232; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3eKSv9Id5tDZbrtXrAZyxKQFe4xtvQtLbZeG3X7ytw=;
        b=UCTgssHK/O+hAxkObv3mgz8LaBL7Y6R/MBBM+wL6YtlVsC5IFoyCcWOgyiiyvAWWE+
         AlNYSTv1b5hIlyv/Gyco0JHX1NDV9WUEGaOPD/1teNFA9v4eib59P06NAidoU1Kk077e
         Aq4kFxI5zgsgX+cibSPHKQGiX/t1ae/+PfSyrY1B6t2XmQXS6VzX0XMx5Y/QisSW4yb2
         zv4IZdQbi3C2eJjnaOxjJgdutYjytr9CbbMoibIW9hwHUKFCA5XAz8XAapWYEYyv07QW
         UHW38b1YqM0/vQ4UeSgYCry9FfP7W37V11CR9lCrrZJjKrw94zK7tja7Y57wzcSJb+RE
         16+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736482432; x=1737087232;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k3eKSv9Id5tDZbrtXrAZyxKQFe4xtvQtLbZeG3X7ytw=;
        b=Ox3/BrEZiLUcp/6rHZIq9c863mxhczYAQ71aUAAdY12KdO7nJBTmeUIVxSSx4uo6l6
         ErnKgssjcj9IY/zwF+kWaWr/jgpArq7cbeCugzaSfhu0MNickW98eKVb919WxmAPTUEp
         3IloF90MVThLjJN/4IbmtfPknn/Qh7p72cJr8DW0OV04Fp8ReShbk4guw71Viu7XK3Uo
         320A0ZVAreFw4/PPYr3FFfRTziPDiTezIgQq8mHX6j0uGVq3CmR4b7hcWjEQDi9msT6Z
         Z6OwFrv44uxkVd95kiY/3dwVIVL7D0Umfz8XgJ/nst72YYmjAFro+HmC2U8iG5D3xXhf
         ALng==
X-Gm-Message-State: AOJu0Yzn1Sq2Z55XlD5j5tICl2FGMRmGdB2P65jPLiVWU6GO2Kc2BnQJ
	xT5aT8jYtSS4LYTJLSW/+/ZsdM0DwR+5iNVOutr3piRP8wzzwoyxiLpo
X-Gm-Gg: ASbGnctBTaFFNiFom/u6+Ect+z+IK89fSOPrWCS+2ksGbjMzircq6C9iUv6mQD1KaCP
	GsCcnLXva4PYlS4bI5YDnbhlsIWMWs+1NqbmtRpcpyJXUCxKyzhyWcmKgXZvQYSv+gEag8dbikY
	bd2PX8/OmGokr288Tgr6aEO6Mi4gQ1M7PVkugMUlO7G7KTww4P1Vo3m+0uYvN+kGaJdBeax9ilf
	aBIal3hLat1bRZfXTluo/uKdVpsSJlYSaAit1iTWb+u7ydD6kOLrcGXkP7dmoQCIMCO
X-Google-Smtp-Source: AGHT+IHtPw5TjUD0GQqRwPAT7RlF5v7S1BAy6huUIhbqawanWYey1Xv2sei1YnC28nh8lf1LwH1gqQ==
X-Received: by 2002:ac8:5fd1:0:b0:467:6742:5633 with SMTP id d75a77b69052e-46c7102bae6mr149336321cf.23.1736482432055;
        Thu, 09 Jan 2025 20:13:52 -0800 (PST)
Received: from [127.0.0.1] ([20.55.126.66])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8732f9e8sm5453421cf.19.2025.01.09.20.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 20:13:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5ff48cd1eed9a8b4c51a9ba5d7f9e0d0e8b0389b.1736477880.git.tanggeliang@kylinos.cn>
References:
 <5ff48cd1eed9a8b4c51a9ba5d7f9e0d0e8b0389b.1736477880.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: sockopt: save nstat infos
Message-ID: <8828ac61-38cf-55cf-3239-f84610325de1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 04:13:50 +0000
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
uns/12702674379

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4faf7127e219
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D923992


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
