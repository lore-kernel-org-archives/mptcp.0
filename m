Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7033C5546
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424523; cv=none; b=u4KC/2bwoVtOS1/WwZdtqe5frOqnH3gMgCuVjVr3/8w5drRDelGZuFcwlaFaFnup4mUz0ZOCXnOFLvU2o2eX0XpYdAYJGrAs/De2W35aIIEtIUllg0NRsEMdK0ay6SH177TKGX8+83iZik46SdVKm0rojodeKcmT4oxpbYNB0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424523; c=relaxed/simple;
	bh=/al7R5lGyABC5BAdv2q6KsiylkPVrrOvcHfyvOD6jio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JratKkaJg309zSTwEByTzy95ofi+mCyRbBdUUMkDv6diycvQERIUxK3wRfv6CqDlJzLOdCxvHxSQLIhkF054MkEp+Z4kX0F2xn+/wU4TqDBkb578WBG5zrLY6t1/8Tre65B0eCw7WQ98kY9N5C4QIvJg4SJ1rSPsK9N+S0ZF4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKhBSfJa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKhBSfJa"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482f9309813so1963319f8f.1
        for <mptcp@lists.linux.dev>; Thu, 03 Sep 2026 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424520; x=1789029320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xk9CG0h6HWfqzzpvcIHPsx0W6k1L3yQKeOEbT++aQsw=;
        b=nKhBSfJaFIvjetQz+auuxzGMfvOXe+7lsdsJl7c+e5DyrmyYWBuKu55Kr9iiyUzr7f
         vpGfLdtUwW9YSDI1T7JhCChPMggRwAVPCo7YUF9quYd/G1Su++/oain3gKXdlWV+9NCh
         WCvxXHAt1HqelRqAL+7u5Ha0qzpJcclbjRLaWMb+ltKbb9AUxAYbJh4U1YkvKcvRuD+j
         pvf3WCrqS4ETgnA3FHOAUc37pDAx6rOuqB3ihEQ0TbzjYa/Z2bq6UBbfEfWq7gNJLK28
         W6xQSswqUTms7BDK9NFkaBIlK1EIgOmSxlWf2oE7NgkGMVs/gt87LpjgpooUSkw6Z/mJ
         nOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424520; x=1789029320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xk9CG0h6HWfqzzpvcIHPsx0W6k1L3yQKeOEbT++aQsw=;
        b=kIFB8naID1AF627JXttyZf8A6RXqM1fX6i1Zdue1leapELCAxDE6XAYXGxq68IajP7
         XqvfIrOXJ92uD96H5C6AxMvZUaJ8k/udXuHLpVRRse5VP1kcqh4ynt6FEsnEvTCJppv8
         +m2a5tGax+3Y0SNcxIiYjfZIxoJWLev9C3bBKwDazxYpx0C0KDc1K2TX3TSl3LxGRW1t
         Fy/Ay6YwFaft5WAIiF/sjlcB0M8SIxXTBoBPrmD1NoTJhFwCF6SOyalkgE4nkmgqxaPm
         lVBPopchdOMmb6nV/WpVFWOiE+BO/OQVVfGfD8QNCadNzLYLtpYGMa4eL5j14raTqbFs
         UzjA==
X-Forwarded-Encrypted: i=1; AKwUvBxpE7Vy02YtAFtIvuNXREKrrBYKa1f5yakU2lxRo9rL7TM3g1KpFIOKFHRobaBBnm/aiYUaGg==@lists.linux.dev
X-Gm-Message-State: AFuF++kT17R2J8Q53F1BPfPn0s8fw7FAvVkVGdaOih0tg8qc452TaVtt
	ENlkrvU+IxAc9V+BHMIFxIJPiGugia6XIxV2tIDQjCb0phaOEgDGNQnh
X-Gm-Gg: AYBFou3giV0xptIUiUI5ennQDF9+/fDcGvFoqierATXCxGyZ1KKcGwsZc7PogIRjTnE
	lqGb0rRLH8eEUXcHVD4mwUHDuYsSZriN6EMpiw4Ys/WKLfXCFwS3zzG6M4GpymXrp4rRYhpWEPX
	FscYEREiV7R4D27Vx2pAx16tttAwMZltRA2L6dbUXo9jrPRTbUzOAldePsLze/Ma/wZSLOQ5rC+
	fPwdYGAOIWUvY28CCZ6aocCsqB99ytR3RyUmWhrexRdkw/LNW37K2qCcYDysuT+6Lt1pSa4zkZF
	TXeJY2TIdGgdQPXC22T3GJolLNOi6gKUMmH/bznfwx4NfROKL/RsPweqMHSRpeBEGYrGLbSB0lH
	DcaLTiyKsm4krV3G2ekfqsIChpOBdyq8s+Mz858QdpQ2TiYlyvnPyF8FtB1Up6Z2vpBc9STfYV7
	XU6YcaS3XCcgesEz7Z69ciQ9NGx9x3GJVi9z/iEDcl9BuXkhjiDmrsplhktAW6dntqStoy256tq
	d8gIDfMASHUTBUJzSsj05rUBLAyRi4xuEQsWW+OwZrq9+rMqKD29xrZicyKH1Ukf1Zv8Kaar8kK
	Vf/q/9Efiwztz/IRObBI9SEd68IjBfuftmXcGtdu40ICjGuadqrGJTubAC2gMm5xyW94WaUqG0s
	2eLn2
X-Received: by 2002:a05:600c:8b10:b0:49b:12c2:104f with SMTP id 5b1f17b1804b1-49ce55ecddamr220293825e9.1.1788424519871;
        Thu, 03 Sep 2026 01:35:19 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm228357425e9.0.2026.09.03.01.35.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 01:35:19 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y 0/2] mptcp: fix ADD_ADDR retransmission socket leaks
Date: Thu,  3 Sep 2026 10:35:10 +0200
Message-Id: <20260903083512.99864-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport the two ordered ADD_ADDR retransmission timer fixes missing from
5.10.y. Patch 1 makes every terminal path release the socket reference
held by the timer. Patch 2 uses sock_put() so the last reference frees the
socket, while avoiding a timer self-deadlock during destruction.

Both fixes carry Cc: stable and are present in 5.15.y and every newer
supported LTS. The original 11-patch cover groups patches 3-5 as the
v5.10 ADD_ADDR timer data-race and leak fixes. Patch 3 is already present
as d9b272a85fe6 ("mptcp: pm: ADD_ADDR rtx: fix potential data-race");
this series supplies the missing ordered patches 4 and 5:
https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org

In v5.10 the timer code is in pm_netlink.c and uses fixed retransmission
delays; the adaptations retain those details. Patch 1 also routes v5.10's
unreachable ID 0 guard through the reference drop.

Tested on v5.10.269 with KASAN under QEMU. A targeted A/B forced the
tracked MPTCP socket to TCP_CLOSE at timer entry: the vulnerable kernel
ran the callback without destroying the socket, while the fixed kernel
destroyed it. Both completed an identical MPTCP transfer without a KASAN
report, Oops, or warning.

The fixed kernel also passed all 15 tests in pm_netlink.sh, a 16 MiB
bidirectional transfer with a real ADD_ADDR/MP_JOIN second subflow, and an
8 MiB curl --mptcp transfer. All payload comparisons were byte-exact.

Matthieu Baerts (NGI0) (2):
  mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
  mptcp: pm: ADD_ADDR rtx: free sk if last

 net/mptcp/pm_netlink.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
2.53.0
