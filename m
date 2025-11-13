Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6911A26B
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994124; cv=none; b=GnoSSMtXWlMNe91vrUzdhlxkFoLyiiPjEXVjzYfdHic4UDDOTnmE+mqaLL+43VIpvHkmHNu+Wdx6KjNvng55mk2TGcMOPPCLLnTAvOPlUcN9tPxYryQn4piPy7tKXGEV276vJ2wewf292HImHloteVn2MWczbchELxhpnYaAV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994124; c=relaxed/simple;
	bh=UJgSSHsdFB1ZXC3CyyLFtnn9U5Kvb1JIFRetVsR2G58=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KpWfPldfd2a1KZC7Zg5RTAjxMZjE8k9gkRsqRCGJgQUojzGMPlQJovOZj3u6mZdQpezmjkIsQgbSOfD7ipRQfWEk9f8zDnPPiOg9hss36iT7i4dAEL1BUMU9jpugyt1QFfhdo96C41z+fSlBx0XtWgj8WKBugRTqSmjHBqzwo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGjcucTu; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGjcucTu"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-9482931b14bso25823939f.1
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 16:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762994121; x=1763598921; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8VsFxu/qIIJORaUpeftbAR0PB5hIG5d1tWvM+gWLxI=;
        b=HGjcucTui1tKWubC2o41hEddqCWw79YImYd4PLybGQ2dos6hg3qEMdFcQBscqet80g
         qpdSjVuTtElvllHX8uO2t64QpZwtNJWbmDNgd57gQv5g+rhrMXbOVPsEWG8oM2ZlF7Ou
         pUD+LkEV4d3VYLqQZh2siQ/FPXjRAv2NgQTQH6YKWlRiqCa5sOTSzcT+34Tfn5ejfdNo
         TSNBCv183HBA4nT+u1IYar9NA7JZWSGQ5G4FqVJnsIRqDOZh7o9aejMoYZDfqbaaIneC
         8+9hIWj89jDtFUODjcQ+5wQbF9cQWSwB4Th0vPyTmV4uBwLnqUSTNbBgIEIQp+gAxzsM
         YAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762994121; x=1763598921;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8VsFxu/qIIJORaUpeftbAR0PB5hIG5d1tWvM+gWLxI=;
        b=SRcyFhP2kY7I5BK2UErzS59ss3yBdSB7RH8w2Hpnnf2dexmMOxUTuZou/JHj7NIh3E
         HNumrPdNuyLLAQzayQpPYXu+2M4BlVMZZzCUbSdL4A3ha/FC1V5kmLvSE/F4zPf5nNsJ
         8m464WVEdXuBamZmo522sBkjgAdZLje0vzLTJGGRPH3UFlvVv7osHls9v535WzaYs6Vn
         NhADCoaE8EzDymXHviMdHcMX2VhtQmA4TG6d2M7FFPsWWoKP028398RT8fubU1r12DmP
         k2KUyMQdXi8qtYDIJSatPJaCQD1tAjC8KgmW1EO59BgBzS9kX3HCkMxyEMqr2S2dRm3u
         AIVw==
X-Gm-Message-State: AOJu0YxTlFciFAP1WYEulTNaI6GjkxOJh1CG0C328Nluj/CzcGzCSZa8
	ndbJrDl26HwcjDKKfZINrNIFziTJyV7QNFjl2W30lMeynvTYhJU1fUU=
X-Gm-Gg: ASbGnctRq1YAWs9U0wy0P57ik5YJzv2zGFNNOXUDtbO0/aB5Ia1IrI2MScW5H/PoemU
	xF6nszqY0F0zxUiyDL/SdpTAU2C+d8nIxR+VV6hwyu9SLxRhXxdFr8yYSVgZ6VHU6nFH4IqRBg9
	bJDzO5NongN5o5jDqoEbc1wTsy8kkmUcXngKIFGtIlAibC+eTIW7ciCM7Sjc3+UMC/DkijuHuGc
	oSukC28Qhx/Z78IeoZGcKSgQqJ/vY8SxPsXmXe9HKRa7udT+gy/cnNDwBS+klCpiatc/qdvE0LN
	5/mBjNTkKIxYs/kHsaQq+W1XEWkbd6mIkFtRJh+kwr2pvXVs17VdhdWlqWf7hJ/lGALbnt7SyT3
	n6vUbDfMGWRgaG67hm2jTMEpUiMt8isBUFXSoc9mWZLF73HT5J/PzQ5fOTZwE9vJeil1s5SadSM
	o7lL9Sf1VlVwP7
X-Google-Smtp-Source: AGHT+IFFEipEPGz5rkJus29VDJALSSMshhQJ77knHtWLWXnAKa2JrL64l6OsYRaU1cMDtaSAL7FC3w==
X-Received: by 2002:a05:6602:158f:b0:906:c3ea:3fb7 with SMTP id ca18e2360f4ac-948c463b579mr689359139f.12.1762994121467;
        Wed, 12 Nov 2025 16:35:21 -0800 (PST)
Received: from [127.0.0.1] ([64.236.134.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd26dc49sm184952173.14.2025.11.12.16.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 16:35:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762992570.git.pabeni@redhat.com>
References: <cover.1762992570.git.pabeni@redhat.com>
Subject: Re: [PATCH v3 mptcp-net 0/3] mptcp: cg and backlog follow-up
Message-ID: <b52491dc-07fc-3055-d725-f2cc3a23441d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Nov 2025 00:35:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/19316383224

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/42=
d108656927
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1022713

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
