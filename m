Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7996974297
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147082; cv=none; b=ojcfnYMWB4gy1RT+jp29wLw8t9UeZvfij+qhs0vMdbL0Uq5o5GHPqrJTfoKK4knf7JOE7EA18wLDtLbwfA1vEstZH1TkDOkFfXleQ4aTpGxwvB63brLqxTk8X4CsKLDqFdGLLIiKFtrXfs0672ehYAihREYdkw4h7V4/9vd9rKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147082; c=relaxed/simple;
	bh=8I/a30jZnTqfpfNPgkeeMDh2ALPauRl9rp3+2I9qbyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrhMLnFDCY1xFP8OAKAxnMDsHO6aNvg0dpoAFVSDs5ItFjUHMe/BAqxchQmKO36qkn68h2gLPLYx9Y0bTXWMBA2Qn325bzGVVWxda2FVXOegY3nT6KEfeuqqlP+qDRHQnyH0ebOKM9f9La2473XhO6OaaGbis2hRthg+ALkYD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epeyu0AY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epeyu0AY"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-702447766fdso611990b3a.1
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717147081; x=1717751881; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tOB66n+P1I9gWnR6juVMERuYmSl2Jj0Hp5nLCvT/H0=;
        b=epeyu0AYB6q2mb/PlCtvHjIsMH8j2a/sZwRtP5OgRbxmpyNEX2T6BB1/bq4WOpi6II
         NeO0PaOUTkHufjxEXNpUW8t227ULLcnY5BNB7hBSNskUQk5T1hA+hxeh1LmxbR3DGSFe
         Hz/3H64bqCxbpsHKHZGQZVYh28A98VwnGUrXCiDrJ34Q7+B5Jse1tWUb0Mor14jH7efQ
         fTgW3ygUG0BVRjHOhZcC/crfzRwssX15ZfjsvDKnsUfAOl/gjd3U4oFfHYAceQvs5135
         Pyx4YGSshruAEwrJxyFXJ/N/DrDOlYHGC0jyvbAYSGrmgV2Pe0ky6INayb7OZlxe0GG0
         0eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147081; x=1717751881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tOB66n+P1I9gWnR6juVMERuYmSl2Jj0Hp5nLCvT/H0=;
        b=EMfJrd4WdZVPeXLR6mQWidP450GahxYWnLo6ZpziPxL3TOuEoKirmsxoNFKxkEVZaU
         Oz5w1EYjbcaKnPwjU3C+xBfN6VH4U9y5zXFzpePCJsqYgZPPE5B2jX749gGgqn6zatOq
         1501/BJ9NikUXPWkgwrAHDHqQkbhF1ESO4DJQyxnGrc9pwatKipZnJ47C3h2E9hINi5Q
         FQn3s2eIuM7Eh9RGi2eEmHcRN6SKC+O1JkwUIGPYyErx2/RnxMEf++JJtAEYWxdTqetg
         mTMFdb3/utj/fRG+Yp+fNnJTBY/cVXvzVIcD+eGCIyTyJ5WGGeGHzVnvHn1m/FX4Fstu
         jwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3BuqBLGJ7feNejVUKYEGnx/EI8esJcsTew4oeR6i21FsXnnJz+87vUb5BIV/ecc7fe1NKiaY9c73fsjgx4vYwA5waRoE=
X-Gm-Message-State: AOJu0YzNOgoQIfUeZVktKqJvUL8Kp1dNGs9Ecug+SIgTd8RlESMV98wm
	HDSdu/uYWJwsnISUOtle0ze0xQFlQeSrbmtRaL83pojoBZ+vZQpP
X-Google-Smtp-Source: AGHT+IGgEjX+CGeHGmFCGqmbKCLITKC2cQybiJvDG1yufPXs2ulzjW/ax1tp9KNasHN8tn8YI1hupQ==
X-Received: by 2002:a05:6a20:72a2:b0:1b2:663a:968f with SMTP id adf61e73a8af0-1b26f1f725amr1670814637.31.1717147080592;
        Fri, 31 May 2024 02:18:00 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632356c84sm11950015ad.76.2024.05.31.02.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:17:59 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Date: Fri, 31 May 2024 17:17:51 +0800
Message-Id: <20240531091753.75930-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Taking CLOSE-WAIT sockets into CurrEstab counters is in accordance with RFC
1213, as suggested by Eric and Neal.

v4
Link: https://lore.kernel.org/all/20240530131308.59737-1-kerneljasonxing@gmail.com/
1. correct the Fixes: tag in patch [2/2]. (Eric)

Previous discussion
Link: https://lore.kernel.org/all/20240529033104.33882-1-kerneljasonxing@gmail.com/

Jason Xing (2):
  tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
  mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB

 net/ipv4/tcp.c       | 6 +++++-
 net/mptcp/protocol.c | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.37.3

