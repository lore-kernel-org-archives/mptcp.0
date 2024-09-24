Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4D15382E
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170848; cv=none; b=euBFdTHWdW6yIG0rpVuiUnczVsxtlrYzoq9dluOATK7fjpfAb/k1wvwcuQOL0rLTd6oivKv/1iMULZSX4AB7NhyakN5lBT9Cp+nLi5et24YEtFyf0gW4Ox/33bx+HBwUFT+GF75ZHb3wD+ZLsadQ6kvMUfuR6bOjziignRyofks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170848; c=relaxed/simple;
	bh=BA+rPTyvKkwbP7ddNMLYMYy2NCLwuf9hqKbmiryxZDY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tvDKDD3iEqoFVplzFuQ32xGK5o/Xg+16GKOiIg4+fFsB0pPv6gfAqGEv6PRsvBVvPaEK9Hh0UNvqBjFrhQpvmhKqjApXcSX1pbjNonWgclESgD/fMga/YD7bcBdIvxL0V7vSeV3fIgyqqv8LpcCUIdPP3sh6IPYSQsA+2o6JW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuXTgKmd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuXTgKmd"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9ad15d11bso525678685a.0
        for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727170846; x=1727775646; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QJWt63lRXnudZ1blWG2ablc1sHdiV3tom3o9L1QILg=;
        b=iuXTgKmdsbDgm5l0p+uZoKryhcDdYWkLkVfjXQjtT4/ISS/Qq8Nna5aRzeMkKqm5wH
         O4PympM09VLQccI4rYVV3caA/sVy8l7MzvTHiIVNDQ6EAOzykdRGhcGt/ejCTfxRvIR9
         n3KRl3CFqrbdcJni47/B/Lznegy7YarIMeAmCSL1t4n5gFTjCGJ1YGbcsc2eXtBoIIJP
         9QYET5y7tgfELAKYitUGSVLUhSQMQQxjhQX3624BDWy8T3Ov2MmHKJKUQzY1alwO3H75
         x9fIh9LqOxxOvGN2DBRPfcclMP+CsK1UooNUDxOYl2EJrFPQtBzjvy9c9WENX7nlMcyX
         iQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170846; x=1727775646;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/QJWt63lRXnudZ1blWG2ablc1sHdiV3tom3o9L1QILg=;
        b=i4ZbFZH0oeRJN/60aAiqltSABMv3fbm6k7GTIV1Bn38SjcO4mhzy9E4mrJc832qUTO
         oihwDAcS64r1oKGLdEo24SeorXb3Zuf76b8PbeKa0CCCC92liu0gklEXiAqVPzD6gQmx
         4tw+hndrMbAc2NwwWDclXpI1GSsrCsX4uJf1sYY/yzhLKuJWMQlfoBlyMFti3WEij7A3
         8s623is9pRoMJfKnZO2KJ3mT1vUpEAcfZuFC+XTBNfIeFYpzRWT4kQWD7Hm1GxvMZqtE
         yJQ5PSzesZJk5X3zF+QB5PicMpcEzEKzH5SJWwShDE9H5wx6BzAZeBjgUMAr+H+O4ntb
         vaQA==
X-Gm-Message-State: AOJu0Yzar3mnJLal1C9dTyrAMTfr/RxgPwlMA8jMi1ZBHWjNXd315PFG
	8Y2vFIhFIHkdI25pC5pt6+2SfRDMSKlS3kMZmtUqg+Bx89tiB4sCkmoR
X-Google-Smtp-Source: AGHT+IFiZjWkLCdB1rzJ5FXbd2jkIqSuXupLk7fl+XOD5qEVDdzEGSFV4GftsuSQwcwj/sLVP0XDpg==
X-Received: by 2002:a05:620a:4105:b0:7a9:db7d:11f5 with SMTP id af79cd13be357-7acb8d8ae31mr2171518185a.25.1727170845762;
        Tue, 24 Sep 2024 02:40:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.155.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5cb946sm50843985a.98.2024.09.24.02.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:40:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 00/10] add mptcp_subflow bpf_iter
Message-ID: <b5922919-5548-d4a6-57d6-fecbb3df59fc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Sep 2024 09:40:42 +0000
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
net-next/actions/runs/11011018563

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/fe=
0ed2ed48f9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D892355

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
