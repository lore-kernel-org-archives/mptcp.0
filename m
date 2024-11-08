Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0C1D356C
	for <mptcp@lists.linux.dev>; Fri,  8 Nov 2024 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057281; cv=none; b=dMAMgr/QzD1QzpztKwotR/iCniu0kpKC2Wc5qakm6qWbuOtlI5h4z9k02Z2VKrR0vWzdKYX0c55BP6fDYagc19SR19ZJxnUZdwqsLqFuko0pTl7m7/njp/eHlpjFognTp/Q7cmRDczh8W0Y7VC6TaNyzXHzNzo8dPvoYr2LAzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057281; c=relaxed/simple;
	bh=GdsYdAEQWPKXDus2RapCEdEfSkE7DFKJ2zpA/cgTzVg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=A/CDjgyjK+/hSMHVYECF3Y79IG76uNUFJCovYRF1AN+cJtmexm8L4QnRVc+U9Efz4yOG//okur6XiKY1VMoTbOUF1ECvWaMeNaN2G6+n8MJ6kSPxQE3436R7BBjFwCbv1TILCnbFQxCqJAvarJ4vGVIxud763MEnKuwW6C+2IUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdw0y0Bq; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdw0y0Bq"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50e08caccaaso624301e0c.3
        for <mptcp@lists.linux.dev>; Fri, 08 Nov 2024 01:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731057279; x=1731662079; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k0rHqDocX/TnE/o4hGDLbtsPoGaH4gIhQflLbxJn0M=;
        b=Zdw0y0BqVeeeVuokL+GcA0wd5ItRu4hZatCThEJMveotuQf3vKeQb1yO5oVrl+HFzm
         tRLMw86HoCSBB//ikqYEY7qHfNmApIWu53oUmS6/tnGmIFolPazo1V+Ra6eqodqIgyE/
         Jsfbdm5KYgZ0LXA7LaOB9dEtjDXNI1ukIuOpf6HmoAVelaTIsJyZfTmBARhbCvrfHy5m
         6O+Qqq/AufAXXqG225GbvG16gAfIa6oxPr7y8C2nQNt+JB2c3WXsNomTVN0xpHO8VYKV
         hvVKrAqBjgDGlqxMEOWpUzLvP1Qh3ItrmBLw/50CY271gW2YLqNoCDISEhpB6AnxPJHA
         0SHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731057279; x=1731662079;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/k0rHqDocX/TnE/o4hGDLbtsPoGaH4gIhQflLbxJn0M=;
        b=IDChYkAu4052sB+E8AvwV3WP8b1EjY2IvqaFKNR6UoRKcSTFzrWwC6Xj7qN7MOwZbW
         DbCaqYDJh3f/EKf5nXD6gc33QqmuXLuMjpNLFWsO6uLdMVgjhgxUHFml3pC86Xp5PIb3
         LD1kvE79jTE2352JPoBvWlmFOgMqs+tLseA8rNGi97dUHVUup8xZiemdmRXaISYPvW7T
         oD1ah3JNb85lnWluN8rBS0/pZKLG9NZA6uQH4/C7pSipV8GKKuQFOXO/Z+EA6R/pE0HI
         e14Fg1SFImY4UUDmIip78eRp2bZ089L+LgTvsT2by/Culnxmrvny3DTVyAIMCMxEbjS/
         pVaw==
X-Gm-Message-State: AOJu0Yz3Q6N9fsS1fjv0yD6ox2RGykKJN57aNg4u0NlY5DxyjeCiJ4GO
	ECbxSRTauAR8wwMNlh5rw7Hdsc4RSuhAWURpt0bDnZVvc1AIfFCoNAsq
X-Google-Smtp-Source: AGHT+IEgSQsDOTCB7aiRBFMtsUYr/fsQzyoEYnKwdErm/Yx6WBsOIS8NcotdI/gDyjzF9f8eNL/GYg==
X-Received: by 2002:a05:6122:2504:b0:510:185:5d9c with SMTP id 71dfb90a1353d-51401ec14d8mr2009874e0c.11.1731057278598;
        Fri, 08 Nov 2024 01:14:38 -0800 (PST)
Received: from [127.0.0.1] ([172.183.130.195])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df53fsm18187161cf.8.2024.11.08.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:14:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <aeca45ea8522298327715230f45d718338906732.1731055793.git.tanggeliang@kylinos.cn>
References:
 <aeca45ea8522298327715230f45d718338906732.1731055793.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_mptcp=5Fuserspac?=
 =?UTF-8?Q?e=5Fpm=5Faddr_bpf=5Fiter_subtest=22?=
Message-ID: <f7a19098-11a8-7e83-f050-860482dcc94f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Nov 2024 09:14:36 +0000
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
net-next/actions/runs/11739236566

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/19=
c0bb79ad1d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D907691

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
