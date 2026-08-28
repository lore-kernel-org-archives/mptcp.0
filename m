Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58779221DB6
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922136; cv=none; b=jxb07s6Jgr6fCH8fc/B6KFMxvAr2IqnPJ8+Qx06yXj4nztAc7VESeuUPuFTdBToUYPExdQ1uZfFYZshNQFKYflHwzvV+FxrBI4sNfR/514BAAZbG1dR5V28WskBpr76hvmPjOb0haOV+9+gPXCZr/OLwra9orgzUxyTJTIc8Hl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922136; c=relaxed/simple;
	bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0CEHacp5ZOLiw0Dq37ccDMSnmY17383OAh5Kn6hUgi2xmyMWCwd9yAvuofqLhG1ML1pzZxdJJvbON+szgJG2R3qjt3EEPgf0bRYrsuZ6osyM/NnoMxPrTGA/RrC1cWtP3js2kzhdJWHx23P1/qbffYEkHDHeWPj2IzfO2At2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYL/Fyb6; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYL/Fyb6"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c4e9769bdso1391681d50.0
        for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787922134; x=1788526934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
        b=iYL/Fyb65r9EGrPa28JoBo7bQ5OzGW16E2n8WqaPXvumKJlR3fh4SGblaRDlfmuSDk
         zKOgv3jswh44kAqretbD+O/EpdoUB/+xX6bCM+8ZGQozpX56cCS3oBsJ8jURSTu32NCh
         ioasSZg7HWDaKWu969ZhmwN+IXCOLKWO5lv2IdSHq+fNhcJFSMAaX3inpWj1LkHypZQx
         o2KROHFgj4dEC2shMIb2fQN7bra9Zne9E0tF03OuiCuTlBv4hyKF96vUOMSuxxl+WqHf
         8iM97AUkAn71LpPHMDiuiHmWUAekndagZTF9g5wJEEPP2EJFiw7CaCupw1/FQOX0/l3g
         E1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922134; x=1788526934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
        b=Cb1XqegBHU7Pzf9fRvKW5zxjEuAdMKYKfrH/urS1i5kMvqiwLcGCr1wp/M1dD23Biv
         w/c/iI9s4JqGsLaiRh2+YPT+fZOhf8Vw83JvFYQmYH05FI3CAcvVoSKaYQsUWbTA890N
         5SwxBrz1nY8p4RmbFkP036XxQCXyfpuP17sOia4VcMazBBWM/XKnyylGxFqzORzhjsNe
         pn9/GtgbTE6wH0zi9KK+N2RaFZkvoodqjuFzx8XwKanOGB7NFdyPZG38avfTRi+pg30z
         XgWNRDbjQitz+fc5GsnKn5mg+HE1HrXq8MR0H+yOmJyk/OO0Xrbg/YN5DWrJ+WC6uLyP
         jNlw==
X-Forwarded-Encrypted: i=1; AKwUvBzKOJXOguHQ/akA0Qc5M/sdxXRHEM3ulsFegI8lSnphqZsyUW8zGhS7i8V13qJtnEqkDGMWiw==@lists.linux.dev
X-Gm-Message-State: AFuF++louWQmT75ZhBmYqU47deq2/r3Y3sorsccQG3YOzdAeM3FP1vxp
	gao8jPhJmATsSZE5rrmaDmovoxbhl2mj6S8r6KL43tR5JOJHiRzcAxlX
X-Gm-Gg: AYBFou0ZEpswi9R88b9aQWIUcgKIc6faokF8fzv/i/VHW4mbeb9pV2jhU8QlEHtFjGX
	PNmMdEMOH1Z840IA+cIeqz5xXdQ5B9MHAXAGRF+Z7JqSVIStUNIxBTj2AINmi5lTmN19uhwlrm1
	NDn9sT8doSxBM/5LYfMWnHpngMejBcbspCJLpYxCD5FqRnwpmd0pUKyce3FZsAIs4MhbFRjvg7Q
	023HTAgOr0lNlMxvTUw5HBmMGZxEJEK5g2xbV3rne/nYbzUdV4SwzGooOGReudArxEurXysM5VO
	SenuHN05+EgfR2tVSw6l2n2oQTrv06fh/Fgr9ktK2blc2obmUUBPxXnfHXy6slW1nXfDv3YCVRa
	9dMN+pqcclZUCaHexhGQRE9qIHXy4ox74qzOCR58KelfNVq+3scOaHC6aS2nvQd7Vw/udLFvA4j
	NMK5OktJIKRYAJFS63BIPd0rvpbzOCmFGWmlHoDinrqrv81V1WTNO4xkNgOgNqYthK7iLWkZN5A
	+SBng==
X-Received: by 2002:a53:c550:0:b0:66d:264e:88f2 with SMTP id 956f58d0204a3-66e4c6eb8f4mr1512029d50.16.1787922134170;
        Fri, 28 Aug 2026 06:02:14 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed39d4csm770568d50.21.2026.08.28.06.02.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 06:02:13 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: leitao@debian.org
Cc: AutonomousCodeSecurity@microsoft.com,
	andriin@fb.com,
	ast@kernel.org,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	geliang@kernel.org,
	horms@kernel.org,
	kafai@fb.com,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net v3 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Fri, 28 Aug 2026 09:02:12 -0400
Message-ID: <20260828130212.32968-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apGBE3XHKeNohHF1@gmail.com>
References: <apGBE3XHKeNohHF1@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> nit: Do you need to zero this string? It will be safely overwritten
> below, no?

Thanks for catching this. That initialization is unnecessary. Would
you prefer a new version for this, or are you okay with keeping it
as-is? I may need a few days before I can send a new version due to an
ongoing email account approval process.

Cen
