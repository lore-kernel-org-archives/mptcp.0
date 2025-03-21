Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875EB7E107
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523620; cv=none; b=MNfR8OclfcClpeADMYervxg5pt/04FG4MG59dyXWwHkFq/BUhBZ5pkkTd5Quc+uGvZ5CmcJoDOfvjsLJE2UEcbg7L+0lfX1YMc+2OkRHQJA4+/qzt2lY039xTYKV0NQP1V+LOoviUMak3p5ymlqkvp+32YXV5S6Su0G9jwPf1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523620; c=relaxed/simple;
	bh=NnaytecQmeUw5Ie6JqXMqD9paO3G0vgGdL9MlrAg8DA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nT0vLduHif+1D9uUQy1WWRMvqbMub20WZ+9FS6leESCtu+k6CugD5la8bHVwRIneDecaKYAYJIclYuGcntsg3n52mx+govf4jgmHb/RbRF3jlKQxfbYLCWK8fLDa38axJ4YwGIYszMcu+IwUdWBXgWMSxascKY8nlEfj4HJ8gDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpQIZCUN; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpQIZCUN"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso22343716d6.0
        for <mptcp@lists.linux.dev>; Thu, 20 Mar 2025 19:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742523617; x=1743128417; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZhgCm/Z+DHmk67I24DHs8MoyIQVbgQ/0cIPmTc2Nns=;
        b=NpQIZCUNBKTSrL7tWzvHQ7KCmkxET8O9RW3RySyA7dNnzwhIJcFErJL2/WpXuA9slu
         l2LBJ1Oc8NI+xhc0Nb0Rw0651CjUq8wBsBCc+nMTeQQSlXyEksrxL4Qgt7Gq9E+4A+H+
         e7ulDze2GnImmGxmvmsdNHkLHdVFu4MiBYM0GZ1TabBBElSibicpHCOSQxCtf2bv+tyC
         EKM95pmUPCbdHW9cKt5r7T9bxf0XJxGeswxdGCtX2jNeHKT5FDPOys49MIUflTUElP3i
         CQ84N/6WY/g4aYKl0Ho2K5VzqP2k30mDu5pMe6QyNW1Bp5DnKM2JONctIL8FCrborAYN
         IZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742523617; x=1743128417;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZhgCm/Z+DHmk67I24DHs8MoyIQVbgQ/0cIPmTc2Nns=;
        b=OFCnznxPqt0AY0O6JJKinueoRBo6qlyGylolWlOimzM60VQ7woR2QajtQexzKJlk4h
         tcWHxKjogIHE3VDVM9lg6tFcIlCOtz36asJl3kwnz+/pbLomeJDVcmyBHm8W4PLNsePs
         gGCtlqkFlczFZvLNIr7CTLNhqv2CWp9s2uNGmpJT7HhEBJnhJ8YKnXlKgBuMgBJyf+oD
         2OKYn6ynmftjC3JiIutyKQ8odjNVd4O3ss95MalkNwme6HSFKm2NASz7pjm3A+4quh/s
         YQrTx/5jlEWrzj0KmYLgM5bP5CTLyBYF88TlG/FZRxbTeBbbDI4xS1EQP+0t8P5VALLB
         uuXQ==
X-Gm-Message-State: AOJu0Yx0ZniF7Xd2kdbZXNDYaL5dayc421JDC5U2nZhvA0T1VDdzd0zU
	p59GZJAtSx7/XRreaKItIE2pmWcIKRYUFYmv4mRNRQkZjICL9Q+1Tpcp
X-Gm-Gg: ASbGncsZncjp5fexAqqagxhzP+eskcFPJ/e0sKSZbWnVqXBA02Do22OWBBfaIff3Mnv
	TKfFnTQ8KZwQtb16Ui+9KoaXR1kvTcENOQsczP8YTiTAYRpqqDlrCwuYd2irjB6CTHEqtfSU6t9
	ENrBxel9WYBIxSwaxaIJp2b+U6QnSJQQTSJrgF74jFSiTm3ctQWeHPH69dew0PM9cNonh8laYIH
	OU4ZgdZQNvJUzfntiN5aKDtsIeMhwJGAjmU87MTnPlQ66GxWq5mn66ako2Em7F01pKmC7+qhUyn
	HQ5HD2+LvPY5V8rF8jqBh9JNgJyKVcpY7/MT3ujR+sQtfBuNhpgQjeyza+nuD8RUG56xb/I=
X-Google-Smtp-Source: AGHT+IFHXIMbhC53eRl7kYWinEkzEKdbOyMPMhoEP93F6INArYW0qOxRAl2Kp1wwvTZPOaBa8ELqfw==
X-Received: by 2002:a05:6214:766:b0:6ea:d629:f492 with SMTP id 6a1803df08f44-6eb3f36c371mr19988376d6.29.1742523617319;
        Thu, 20 Mar 2025 19:20:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.180.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f5e3sm5442496d6.43.2025.03.20.19.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:20:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1742521587.git.tanggeliang@kylinos.cn>
References: <cover.1742521587.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/4] BPF path manager, part 7
Message-ID: <bbb4151a-871c-b137-ca82-36ff60575b12@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Mar 2025 02:20:16 +0000
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
net-next/actions/runs/13983028068

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0d=
2604c2d943
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D946095

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
