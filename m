Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531338DEC
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348170; cv=none; b=AwQYtJMjeDWTcTBuNhMXoZlHhDSPSrz6wgucud8TKkddBlq2Tf7JyHa5lcLE3FjchKZlLw4tcmcx+wYBonUkpcbHSXhuo52bY47HRSbdalJ4hVzRW4vHRbdmeqGTSPqi9pPPKAwF00ktshTE3DH0nYTyC6rTdpkzmdhP1vKrUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348170; c=relaxed/simple;
	bh=bXkNXvICBd8tmQ6issTC59djXsRMOrGovlzYsFUEUJA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=giNsauENBt1wHdxJ+ccQHnjaZ3ZfDBgZFup+Vp77THplH1YNd/C2Zmb6GEMnytsED75+kb2jk3q6aDM+VPraw7DWet2Iwe7LJy6cIBkZjpKWqzNBQp2U2Ocm2BRnKMDO5KRPZm5BY89PqRr/q6wD8yyqvAkwwW/f4R0W3ettknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZYWIyhp; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZYWIyhp"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3b4c4b409so297111285a.3
        for <mptcp@lists.linux.dev>; Fri, 07 Mar 2025 03:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741348168; x=1741952968; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BvAJxBfApNwUq7M6YtJziQ1fY1Crsnsn1UWAF8wGLI=;
        b=cZYWIyhpGi35Ps7vipKwkt6et1NoVKlNCUWZG4Qg6eTq/jnsZXCwZRMPOBaly7trTY
         0Xn2l2mC+To/TWKne1uHq7xSQ+Y020dQCdf+oT1m2zWhBEDx46Uyq4f7udSG7Bk4TfZt
         sS0krfaOOjWn58EnSiH9MYMSvIm0BDdrAboZm1YPXCxKMcrFt23CZxiHFZCb4ISXV3PY
         LmnyvF5TjaP5DF0MHVy7zR4L5wPhOavf0ae+GV2m7DvGRgMVjVbcTo4NxlyeqR2VcvYV
         gwq0P4mcsgdDAemH3n9kiuJjtxFOXT4aGqZJmwkVHjalcEinqaymbFEQYl1J8fk9N9mb
         nq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741348168; x=1741952968;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8BvAJxBfApNwUq7M6YtJziQ1fY1Crsnsn1UWAF8wGLI=;
        b=TesZnNYqHx/Ihp1+ul5D1QSdif/zFIaokANNXJcOS7OmRmi0Yvl29MByvDsfCrG/iE
         jCw6efIFYdOSrKxPYsfzKQ/OaqWbFTe5r1tfEJORxN37oEdsS0Ags6Fp1ddZ4yjNc7J/
         RAEeWDcxsHwa9ctAbjcl+ylSx6SdIQA4/m3maDMMe2pPmJkSVaKmYydgDKG1YUL4tDxU
         rgrMucbgAoBFmMd7RhBvcFxmOTnIbQ0vZNsSIjYiBknATu0/7jri8TNMyhSqBmZaE8rN
         30HjXi+DFKd0Vl1B2E1mT163Tg9uBOsxEQ40f7w1tZ94oXQkSPIskO5FrAhx0o+qK+tP
         4uEw==
X-Gm-Message-State: AOJu0YwHcCA0IGFPBqWCBUx/A4jp/QZTO4UbHnmrR2+KlRb4h7SZ8dCA
	C+2N1CzQs8cvKrBtV2jL+KQ7JJA8zD9p55UyQGsUHZEKkOLMSFlTLhqJ
X-Gm-Gg: ASbGncsn/AJTO2d3FYdkXcHZ1EpMzGnrF4ShjioRfcyoClh4uuWBhlmDS+Mmuv9ghwJ
	3mc+6FEYIVcqmzbTtUAczgil2rPBCyObQg042vzfptjPQ8oVzs0vwKh/HuQPMvI0bTT715p8bK2
	rhm5rXtnVcI3ICW6krD0hgN8jeycAeb1O5hcYVAxJ8exA7NO3BTYg7Nmqo0nCjGpIE5yvHoHM4m
	H50aIeLeDf77YFqofO8U/dyxK55x0GG/mibP+sbzq1qEQ3heYUKqoGl6lI1E4XfFOksZECb/Hpd
	enGh2bzqjJ3iOxKPC4t+OJmINbnIzeRG/HGl6fZCpiBJBn4LRI63pDPg
X-Google-Smtp-Source: AGHT+IFixTqEEEfudxivQno3aAmkgRYntbx1BJiyy5CVAB4Ea3poeLXfUH6OxWq1v+yKL1jI3qNvFg==
X-Received: by 2002:a05:620a:640b:b0:7c0:c447:6295 with SMTP id af79cd13be357-7c4e61138abmr389887585a.33.1741348167921;
        Fri, 07 Mar 2025 03:49:27 -0800 (PST)
Received: from [127.0.0.1] ([20.25.193.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534ea04sm233002785a.45.2025.03.07.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:49:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 00/11] add bpf_iter_task
Message-ID: <8818b2c9-9ac4-fa6d-0acb-83ff45ccdeb3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Mar 2025 11:49:26 +0000
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
net-next/actions/runs/13719922193

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/76=
b642669ea6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D941486

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
