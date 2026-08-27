Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D81344031
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874644; cv=none; b=s018ftykAr0Rr8AOeFF+jjJifQEtH/B96lTlqKJPIe6krC6KW9iw0eUflw+d9ky1wYeapi2byXd4F1HGNzPyBrwfautkQl8sdPBmaPtkGo3jpmMjiR+orxpnzBND1V25pWi/fD6JsenFQ9sCWF5eAvFgQTTXIjeZEtwJ/j+LjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874644; c=relaxed/simple;
	bh=I0w28eDwn55wNUcSFkFqUL0WZNi+JsnEzbOiyxoDOZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1SC4LLYvfbaV/XqcHsHmZCy6BOW7DZOR9sTX23t3AhXb92agkxP8cTODcWlXiZJ68fcPlDtkp03xXVmkQL+siVZxkumx37UL1iwxlbRdm8cMprDWpLy4378Yd1dkFs9EjMjEAdphGsr0Fe2/Bd2rYTSFMJ7K4CcqknyUA1RPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiQDoOFz; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiQDoOFz"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66d1663c00dso842878d50.2
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874642; x=1788479442; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDf2cFz2MJ91PpGfYzlKTBbzHYxayWBZgz3Ltr8pzsg=;
        b=PiQDoOFzirS3VGKiyOnC5mYMJbFRV5jlp/ituZ3GIzK2KI2002CBAJWkVisCceOdAM
         lhl8CG9y7/7890V16tVgY+ljbkUJdeyQXLKXQzE2euAH/kDFXLtxyy7KA6khh+qGq0X2
         mpOMeuQGZSotWAQev7hjgE6W4sgKgzKsPY/69V7yJUJ+KRZYMh2kUii6QywPO/Cd5n4S
         t5fedwWnuH0SUXtALA4Nq00avFQGuGnZLrjCWrxVteO0DzRzWwg9TpddT+J+iMidVFou
         WtrEm7D3s9xYS7sII0V0JBEuCxTRK130u7+HMNvkAlJVBlYdX0tZY0Zzf9yH7HD9eRXn
         d8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874642; x=1788479442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oDf2cFz2MJ91PpGfYzlKTBbzHYxayWBZgz3Ltr8pzsg=;
        b=Hx2ygAcpeoPq9QTCU+/jPoKnDRDiv8ibumF6LFi5bFWPsQULO3DRT4m3wNIaFCLt+I
         swtGxxl1taD4Cg1GL13zdvD5YrAHRUI5Si4eVxQPKSkFSigcO0XxC1nTAX55nV36cOuU
         qXuH6OnkLQBrJVFosA8P+dLNYPU5Auw4HZVeC1bXKjNESaYX6MxqyfBtcH1LSzl7/k2e
         PQkYT6noFIyH8iMYjLM1pGYmTnDJReZOxr41pt0AH50R/NF6cUBSmyC/TBAcwuo+VofG
         /LKABQKKVl2u7l/cL1VzGQfLzvO77tUvxBrl8eCfjTYT+b+VTB1FcXBEOpcUqhca6xlM
         tokA==
X-Forwarded-Encrypted: i=1; AHgh+RpMbj8OqssGeMD4g5+lxpBWNTBsvEW876XaB5P0NOaIrT813HHLgQ8riBNfhogXcADnWhDq2A==@lists.linux.dev
X-Gm-Message-State: AFuF++nGOpuYH0uj6+5267q5ZDUCBQCe+F65nApxDPJgIr0eMAjjFYS7
	RrSmxyEU64cZC5yziWx6cApSMqxjzVw6fkjgpB5Z7/feY2T6ae0Bnb/x
X-Gm-Gg: AR+sD13qDS4NyiInLgYhWMq+sAXTIah0DpIv7I0VoifjKBMIS2HWLXebgcLwVKcyGKE
	fb+NonXLxrzLspsA4jSmww6wBYnjCiRzByELjNwSq0lh/aZ3PvyPvzUwG3/L05VCLfRhVEm9iKe
	ZhNQtnihib2gr6VidvzDsjwzTNSwpUnxamHFZCwtqjMk3BF+K2dRBkm5Sq69/w5689/uRaj3pb4
	i2Baq70pkix8Z9ii+Alkp7RYIqsf1e1Tj/qjBVTEHyJV5u6RPuHuGc1TpE6lPF2shAn8DFjEJE0
	gJff6LOmfqSkCVrrTLHjAUDAvPq47gtw6IP1NeEtBBhyo1BiHj/vA0A1EDnxBgDGt/ubCB8V/bd
	QKlzTIsryRwBGFxAKqZAKPS4j2wh4QnjmpbznrGEeugTNm0yO1pSlEm7slLreR9k53ld/vrwW66
	BG6363dX4izNRIuSz5Iz9s9qcHDktQJ5I5MvmOmj2guYZULJvpHzMZnBBuTyqdMWEC4iNofU478
	4jloQ==
X-Received: by 2002:a53:bb4f:0:b0:668:43a3:9db2 with SMTP id 956f58d0204a3-66e4c522f11mr741772d50.32.1787874642003;
        Thu, 27 Aug 2026 16:50:42 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3de54sm51533d50.1.2026.08.27.16.50.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:50:41 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: matttbe@kernel.org
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
	mptcp@lists.linux.dev,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net v2 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Thu, 27 Aug 2026 19:50:39 -0400
Message-ID: <20260827235039.82217-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <1db6cf46-c3cf-49e2-ad97-752afdd78c00@kernel.org>
References: <1db6cf46-c3cf-49e2-ad97-752afdd78c00@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 12:38:36PM +0200, Matthieu Baerts wrote:
> It looks like you (or your assistant) forgot to declare ca_ops:
>
>   const struct tcp_congestion_ops *ca_ops;
>
> Also, I *guess* a 'rcu_read_lock' is needed in mptcp_ca_reset() from
> net/mptcp/protocol.c, above the modification you did, to get the name, no?

Thanks for catching this. I messed up the local version and missed the
undeclared ca_ops. I will fix it in v3.

I also checked mptcp_ca_reset(). It is only called before the socket is
published (mptcp_init_sock) or with the socket lock held
(mptcp_disconnect). The ca_ops->name copy sits between
tcp_assign_congestion_control() and tcp_cleanup_congestion_control(), so
the ops object stays referenced and that read is already safe. The v2
WRITE_ONCE() on the subsequent NULL store is on the MPTCP meta socket,
not the TCP sockets these two UAFs race with, so I will drop it in v3.

Thanks,
Cen
