Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D11380FD7
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250065; cv=none; b=RnjyEJJlbmUbr8KBvOgR0r7+SomwP0u/Oh3O1kWrdVYbn/6AuvJv9sc7Iv6QPw25Oir9QUTrNSg2dpGt705mOZPDKn2UXBkc+uVzFpA0DNEX/TzhF50TOEbAQ0mw9Ns3942e8W1U3k2KMjFfUQGnd/7RAyLKZOC37Z3+OtaSU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250065; c=relaxed/simple;
	bh=pD7cbNNfxKtNTgfSkolvlFWtAKbsZ2GRRjFENYpFCJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ULYLPsdava5xG6jpxWxzdYGil9dKWVC/umuLAxP1APNyFSoh/sKPkTv0bLGedRIRYWS8aDYZ3qLh5kSDdCy5u9229diD6L8oRORvmcEViImvdHm33zPBA6fjeO3bAAYCqRqN9JaMMWVecgc8TaZ5A5juy/Ffgqg4wPmSzh3g7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLlocsRz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLlocsRz"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90cc39e06bdso38527876d6.0
        for <mptcp@lists.linux.dev>; Tue, 01 Sep 2026 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788250060; x=1788854860; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=euUXDSeUUpQrhfx3YDU6jnZPtIpN2Q3vZopMKEQwYSg=;
        b=nLlocsRzSjXcfRmUCoxgfCHPL8ITp6yeD0/k+V6rg1nfghwSDm4jtS7u5Fr7FTSIbp
         H624VwA5//V46RyAugUeXTSZxuZCzUGeKF6neBZI3SDl9l2BF3eAnDAIL0uz2MvHjZ3L
         a8lm/abBRcv8D3okpDGvSCRAKphLQ7GoQuCSNsHaqM3M3WwH0giojbVpjniXEDKtHSyo
         wqaXXzhHzREveJ1QkTHecmdlDKHmsJwRkG0JhYAF/bNIJlcXpeapqHh2HcqGNLOFnLPa
         TTdA366iWfJNtfDn13qEzlveDyQgrF7GZ83AVIqizxQBdl+DiXYDtmwFyqQoSdq0RgBE
         qVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788250060; x=1788854860;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=euUXDSeUUpQrhfx3YDU6jnZPtIpN2Q3vZopMKEQwYSg=;
        b=PsLK/SuwvCo5b5o8U9gnBGTcUFFqVmTMblO31Cyl6iWrgvWIZo98cpzj5T42H1eB2o
         TJPid0z537vPNS59J4n0U0jQEbt0FWAN/MlHza+gUQU391bLacSPvQdvIfMVXlgKQ8WU
         pa3g6ugxtWExVhFBcoi6KfcmNAJla9StIxHpjPS4FZxCdOawRwG+UO7lwgd9Qin77BFj
         NI3ubdDXex2euBXO1ZSjaCEWrsBVP83g4vAKrF5TL7sYkVEf71Ox4jJY+PJlcXhE6LIN
         h91iNlnZZOZPrfzxEZx459M+e3pX42Lu+IjnwXtpIzms+IDSV4rfj/Bi885yQGQNzFRH
         IFQA==
X-Gm-Message-State: AFuF++kVTWLkJYD2XWIuTZIk5qoJQgNaa+PMT4OaUaNzvhn9GrArDpzi
	l4VOPXlirhCM844Gb7n79LwISSi+CnkgupKUUTHf6GDXbGSuCy2KrZ0=
X-Gm-Gg: AR+sD114Bb4hr51Fb6CUTvfSb0fWXr0E0DKx4Q2L6ZT4zHmknRcj7dR6rYpQHXY1E5w
	8PHLwgDrxmDKIaOvjonHfNDXDiDHbFEgObMPYqMytXXiPWZCAarKGb3lRz6cpnbg4Q7+nP3IwOv
	2mRyww57wLdX/lms5P/wnC6QMeqSClmZhRVdhRrI3fLu1a3dfoM3XBngbWpmCsD4XVwxUekMfaw
	a/+PpgrImcKGuS344O1zcKgxWUncU23mBpTRnLTekVXiAsSpwNcTmULONEbhzBKACPlSTdzYleK
	Ghh6r31tp2PUDqiy+moFsgK3hVjZoEySRoNLDoU8pPXNyVjtOeMXC1n+/BlaYGjRvhZhpPFFOWD
	QdHX3rNhZQyFoTa4Jv6TQbCKD7rPQGOoSFrSURjJ7KO8snXpIGXzpsr18JU45CeYqF64WskFxZs
	DrhjyTocQNwkYEOriYklD+ycNPMquR1opwwaCU0GHq/ZNr2hCdublf4TxibnuMxJIAc2NfLOGZ
X-Received: by 2002:a05:622a:551:b0:52f:b0f9:e4f2 with SMTP id d75a77b69052e-52fb93d5108mr382880281cf.1.1788250055209;
        Tue, 01 Sep 2026 01:07:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.106.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe82f3b7sm88653071cf.21.2026.09.01.01.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:07:34 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1788245079.git.tanggeliang@kylinos.cn>
References: <cover.1788245079.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v13 00/10] Reduce the differences between
 TCP and MPTCP for TLS usage
Message-ID: <31b60fae-bc75-6b41-cdf2-2fb3689f1572@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:07:33 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/334799=
21638

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/02653ba3cbf7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1155065


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
