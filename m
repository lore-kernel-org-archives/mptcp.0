Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7135F60F
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859800; cv=none; b=myQowwvKcltnslhbEHOW+TIISGw2Sv7hLgSE/4KrGkF/Or6n6SubE/Z9PAB9LfdqPebX9GpYPmZTZDoiXERhZ0LrviEmz1YzpcVvx8ATrWIHbDxITSMRZvb1py/NvM+HxCdWfBLcrGIv7KJScgOYbkhILgcI0zJDy/lbEGm89eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859800; c=relaxed/simple;
	bh=hjsvYy51l4+d68+Ky+C/JI2f1kTJUYN+qBMx0/prB8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DUlFHRE+LIqFbPbv4Vy6C5bRr2lCqwDh4w7nyJIlFQ4mMNDfkJ/TV/P4sCT8vQIARzgSLr1+HR+yd5brYkk4gFgt74pGolVIFm+h/Q/PfwnS64Od8sT0rYC/wgqD1NfQiCyUbQonrEZKo8eWGhvYVuvzfkGLqRNBo73dPYBMaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVAgZlaL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVAgZlaL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296dabef74so4595600b3a.1
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776859799; x=1777464599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NebLMnO65OtCJ9kTmTFrhiV9D6tfIFz2CrdNbRxmY7A=;
        b=cVAgZlaL64DEWHYdtNkAON6Et4OjkW3rsHcHQQRPFN1dCqJrE90VSnaNi6tIEafvqm
         WUhlwPHdvnWFHzJVFIyNYtorHZeuNfWxqeU8mHLZVZynQxXK8YoY1ICQYX2Rsn4mWMu2
         fG4hlhXqkPHZDG+66CK2hwshOLLJqzzhQhy+Tov8dtmV9sXce1JQ6wPdPhk0ZtVwBj1o
         4TR6Pk5k0FRTOr6fZoMkabvm9NSuzoj7ClpoSCWr3otLHEbflx9CawzH4uUZ2nF7ergZ
         BHzgWTT1vbNwg630vA3kLuFEkmkhBOo1gaZI2PDwT+0MUWrlluh/92Hs++znqnZ+XVsy
         GTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776859799; x=1777464599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NebLMnO65OtCJ9kTmTFrhiV9D6tfIFz2CrdNbRxmY7A=;
        b=NigKSpLG29lMfDdbtXTR033sTlz1/2hvj7rb3JR19kZAAz/SPUteNBGq6cyHOIq6sm
         O9MsNkwMHfji0zewMJ3pofNsBRfUDcTnXVz3M9DHtOaQKJj3U9R+yMZHL6RqNNU8Uxjz
         oT6UYp/bnRt94C49XUu4u35sLBUlQ5zLjn9OsmZCJe43MHPl6AMQNFAxGjqcV/CPlzew
         09YHaS63LCPM0m6tVh+EK6yclPzayRcRRmfN90uhHYWFyXKDBvh/h1q2F/mqbq8L88c3
         0K3361+d9SQWoGOhurW9EN+AvqwnBU4f7gIqZ6gmTVAmeHo+w3+Z230FM2rYiBtQVrCT
         aoCw==
X-Forwarded-Encrypted: i=1; AFNElJ/r8i0BPd5viLvYcboOqbENNz2qKtKQJgNki8u3FGYAYc3JTGACG60ojpSyRPMwVGAg2SsJBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4SnXVTUe3jRsMP5txFsE75pfu/DnKS1ErTOL0PgKl4YVijogP
	rM7L9uM8ICjUIdjXjVK3GPV4tCSwUpDc5A5/FuLULcjHjW9LtNhvw2P2
X-Gm-Gg: AeBDiesPwtWJFmji9BV55eMvn+jNOYLB8w2URwYqyLwQcWwRxP0kgJUmyJvwx/v8ojH
	inwzeXATyn6gLHyLue7F82pUgNnGtVSHOKCbYflqT4oryDTLiQbRroizxXkB+TNTD3LI7eaFV0/
	1ttI/PT7wRBKhvg7fstgtRzfRmJgpNh3PCMOMVpl0OfOXjU8nFfew4/cATL2dsXrCDCdzCtHd2w
	DoSzF/7aa67CWzswnJ+sIeiHiGsbTqT6LHPiHrljtzpeRgpGlBzO1ja38KCE8diYH1/8dKWbhyA
	eCc4MAHUgPeCnCDl+az6l9wVdbtB/l07WQNmLGPLUSu+z613NlBWYP41Mc9h3xj+d2ooAZdGsJY
	XdQaeJC5FKbBmm7173KUjFnkfAEGY5sTvC4Fteg2PEtmHpZyevaYHBE9FqlFnEjT0oRGr4Ez5Rd
	Kd5vn/UnSIhgmcSnuT1tAr6vEG4y1ayjw=
X-Received: by 2002:a05:6a00:3e16:b0:82f:5571:1a8d with SMTP id d2e1a72fcca58-82f8c8308e0mr23715240b3a.2.1776859798571;
        Wed, 22 Apr 2026 05:09:58 -0700 (PDT)
Received: from localhost ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9fcea9sm21196745b3a.23.2026.04.22.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:09:58 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: matttbe@kernel.org,
	martineau@kernel.org
Cc: geliang@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH] mptcp: do not drop partial packets
Date: Wed, 22 Apr 2026 17:39:54 +0530
Message-Id: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a packet arrives with map_seq < ack_seq < end_seq, the beginning
of the packet has already been acknowledged but the end contains new
data.  Currently the entire packet is dropped as "old data," forcing
the sender to retransmit.

Instead, skip the already-acked bytes by adjusting the skb offset and
enqueue only the new portion.  Update bytes_received and ack_seq to
reflect the new data consumed.

A previous attempt at this fix (commit 1d2ce718811a ("mptcp: do not
drop partial packets"), reverted in commit bf39160c4218 ("Revert
"mptcp: do not drop partial packets"")) also added a zero-window
check and changed rcv_wnd_sent initialization, which caused test
regressions.  This version addresses only the partial packet handling
without modifying receive window accounting.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 614c3f583ca0..6858e6e283e3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -397,12 +397,27 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-	mptcp_drop(sk, skb);
-	return false;
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	msk->bytes_received += copy_len;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+	tail = skb_peek_tail(&sk->sk_receive_queue);
+	if (tail && mptcp_try_coalesce(sk, tail, skb))
+		return true;
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
-- 
2.34.1

