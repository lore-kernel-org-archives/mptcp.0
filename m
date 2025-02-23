Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9CB2063F4
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740322758; cv=none; b=jShfD4cWNYshFm+ir3mca3nZ5+A2faVybiQj4InHBfWFcpRS49CDD07DibKeEvQZG1d9Mp2byF3cYyETPTRFz9BhqJYRs8rWUMZ6eR9MhlzkahVWEv8aQ2/x5/xggA7Oal7HPKfYz/c2ZLTwTLQVuCRXu96eAjDFaSeN9AE1ATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740322758; c=relaxed/simple;
	bh=2d67DWq5tnreZnlOGHcJqUZZdrfPdoChHQmpF0aWeXI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Ao/PXfsx5+4EoPTGXxxNaOI5HAcrep+r0oMK3bzpXfa1MaytSthaQ7xbRNDhOCShOg7XkY2LP03nEtgN0BUHUH2MZb7Vaa7cpp4J5m0V262byc5WMUhidPDUcBBiG6lB9nqEFc49pvojsGu2lKdS2lHvRWMHk3O6TPLqljXztzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJkJ18Tx; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJkJ18Tx"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e660740061so33073426d6.3
        for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 06:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740322756; x=1740927556; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/By4MEXdP+/wprs6mtkmTg7BWyVVuWcCIVaTLYoeI4=;
        b=KJkJ18TxUZZEhQCKgjaiuaWh2XL0sZKvC2bfGRs7w5kBV/YF56OK582FLuitfXR+/c
         PKfsnrWZoR14DcQNZHnm9PMUaZ4lpTTZwNJB1rXP3g+E+ivmok4C3MU/loYEllCR3xEc
         vghla6WwJ6E5mkY9Hfkv82ldpytJeQYGtMJlCkvzZXD7hMiRbmHjxQYM8pIGvz+ZDpfZ
         zrsSAkc8Kdt10Ct69Drx/0hpEPMAbfygs1dd4+cdkRC/GkdvPNuFemAm7FLi3xVQPXt0
         m9XX2TYCmXB0z1HIkGwyNwYlhiMF7dGNuOz16wswqVQCY90obRoZSIE+J26UIV0Db3d9
         6jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740322756; x=1740927556;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/By4MEXdP+/wprs6mtkmTg7BWyVVuWcCIVaTLYoeI4=;
        b=PE0QJGHyN+5wStWup2q12C8l2uFY/vS+rzRfUHAsgLUvMQP39XG0ExBGTKJcKQJizM
         VPbKwqs8rxyrxNNauxc6KA/RP0upBAEs898gI3uOKMNtd1kOs/9w65DEYE1UWRbN+OA/
         WR9KctIzN5G24PlaryZrq58fvfMr/jisLEzD1rBuLuyl1HXqILaN8Bs+gA389cp0PzTW
         y7rLvM0seCso3TTVuy2qlcgK1WQE5ZA0jymPC5ITvTVDq57RwXmKQGpKmAMv7/O3wQag
         qrO8qn8prtUWquvIJs5/3hN4Vc4zXQCSq61QSDYfEh4duN1uDTA6CEMWGP5vFeLu6fgH
         rQ1A==
X-Gm-Message-State: AOJu0YwIhD3iP629whvRFLC4y3M9MjNXXfXCgjyzk7pluqRCWIBG0l0N
	iUFhWaRutS9FMXk4OyPDQWTfMVKAvJJ7Dew/Tm50ZHbS/85d5CZj60Z4BlA=
X-Gm-Gg: ASbGnctDNmzUJYzAESGYgcqAk7wkrU61tth+fesPpRfuON6ZEC6rRMPCMoSlOhgkMbP
	pOi8rs7km5HzXkXZ41TdHds3rfavXrIs1MHDOOO+PVZLbYmaKNSguQWYOjeoZ/Q4ku41GyBE+vm
	mQKf2ufPGHR752yWETxIT3aCPyddXi2xMuXWbUDvAN0pjYCOkzURl+XAms2XPeERjyhYqTW8i0Y
	pG7ryY2YJIfnuI0VuVkSHBcuZe7ujIs2tmEBsEp4pb+eMzXM/XFEkSuWl0qgQJ3ucd0wsZSdUdv
	3jvlllBXqqGXBHGLFreWO8fyRRqYtnLIfgzV/udWTw==
X-Google-Smtp-Source: AGHT+IHeCEms9+ONyH1247FlcLJi5q5vs0frGzJkiPgDBcFFPJ//4XJ25ajSXw1E4Tl9/Tk8CpqnzA==
X-Received: by 2002:a05:6214:2465:b0:6e6:61f1:457f with SMTP id 6a1803df08f44-6e6ae824ecemr141026786d6.18.1740322756256;
        Sun, 23 Feb 2025 06:59:16 -0800 (PST)
Received: from [127.0.0.1] ([172.183.111.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65daff741sm121190946d6.102.2025.02.23.06.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 06:59:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 00/13] BPF path manager, part 4
Message-ID: <7bbb37a2-2785-d4e6-19e5-8895d1f52585@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Feb 2025 14:59:14 +0000
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
net-next/actions/runs/13484061885

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ba=
9a44169d90
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D936802

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
