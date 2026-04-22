Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D03ED5DD
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868778; cv=none; b=m38KhH6OYPrqtbh8V9jTght1TvQqsYV8m6nrZU5ex6PO9/vKpGP6/QXcJ4cfCKDpJ37p4Ez8RrrbCFi5nxI6cYPQXdXZd/AsxjQQcUqLDr+HWTin69or2PkmSrVmGMnIsVxZc1TWK9ZEyjjFrngVuQjaH/3wl1+YWnRWjDsJezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868778; c=relaxed/simple;
	bh=iZ9suLIuBUoCeCnetfnZ7mtmyUYxmiPfo0+beK82tOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tKX49tiO5eIDL7HFnyyyqZ0pggkWQ44E9PoSu15RxvnXGnEWz4WPwAasM6AkcxFthnLjsUrJk3EFTuxdN+9zRTbLN9mqn++9AbWUK0kxShTBMOudGzJoRuJtKUcH6pZI5W4E2z69D++UXegovRVUaRpyaiCQnxUubDgw1GyMxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXEIbcTy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXEIbcTy"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b461310af5so21847795ad.1
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776868777; x=1777473577; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1HO4kkoe4n1JrCENVUM3crOySJ+rOzuctiq2bNthFo=;
        b=TXEIbcTyWe69Xe38G02zUnW9aqULtWuxplR5c/TdZ57i9Fmr6OQoN3pFOqmu+EMPwU
         0qyQK1hyw5zkukKjQb49XsVvP9Q0CKigrA1LzVxYfsj4uwvFV2PzOLL0t6hYfe6gJI9X
         Ix+hjYLHfPcRDyqOLFi97C1cSNMDhBmuImPGIbP/uC10XYpSZztUMkSnD1BLi0tjfjJH
         XtaHL0Fe4CgwglmUov6Zfjbt3bDZrOn6lU/sQAFGLkxvJkIwPqDBzOAiyyeGUbJ+m7XS
         nIfnyzF6AWLlokROd8K8SMMuv3CatARbvwsgvd1T9IWbnQBnfYW1YrQypJLvb6Znd9hI
         LgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868777; x=1777473577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1HO4kkoe4n1JrCENVUM3crOySJ+rOzuctiq2bNthFo=;
        b=LrxyUbvD1e7XA48vcb+4AtfSlYbD14y8Clle8F2xAl7HlYWxLRcfOuWqrELSg00cHq
         NmGL1Qx4J+ZLdjJUcqb4Y6+Df5U/m2qXtF/vNJoHY7dOsn0IqxaTdF+nmEcGnL6oS3AE
         g7Pk8m5k8HkrTQ9KoyUtcDPwA/3x8m0DWSH9LoDtgU6OZb1BsuTxRc/ol3+bJBhdRxJA
         lAQO0dUywBN7L11F8MthvzOns+83AVJ+SA0PM8hLKDAYImsZz7WOkfpYa7u9saBUuT2u
         N9nCOMyhDYsm6BlV7eLMwEQnqo/HoZtqTHBPCxGPs2h8Z7jpSaz9zxP19Ep4Gwa+ibtr
         WXBA==
X-Forwarded-Encrypted: i=1; AFNElJ/pBJZ64gQ9o8NKOkHsTH06tYZpaJdPEJZNYk8S7hkl0C5C3JxFFXuUIIjp+EmfENEXYkoKEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxX16XeGy3JUe8hb2v2EMRuysSoPL5UXH6vvPjcJX4CIxrV8Nzq
	9pOxIG+O7woq+EyPTDY3poJyKxVstMgc329fTxr1rX+FkflMKS/5IOCl
X-Gm-Gg: AeBDieuYSXLmusrF/4Y4ChDCyPcsQO/vKNr2M4EPUkqZbWxA5JITxu0eMcjtjpz2BHU
	5Z57LDzWoqFiopuKWL/FZNstUIXEPi6jJBpcwiB1c0snlpPeddQL+T5UyjCICbXVr/UGK+3RWXa
	9sAC7NVrAUMdilaMrpfnjyed5v9telUdQiKaWXjZMJ/QshmGcg6LSAqKN+DXrRM/qWRbPK4ztYr
	crKi1Mr9vW38K5cuPkqJL2qDIrQZvzZoNpZpxmFrMoEZjZDqwdsFW8TW+3p8dtBBx5j0XHKqFBH
	vDMoVbvZmIhcZf/s0xyeNSrmkjkbNqCFkMW2H5XRjNmDtwHRX8z3ylBtT0jotClJkm2u//ttX7K
	SIFHVI9PrzPCy1z+5MsdrQ0Sy8JttEnlaJyQwQ7c28xmOmbnyKmo16FdIKr/35KgRGjS6SmN2hF
	X3DihV0SWHTaiHdg5Shp5toTMdoo0GB1Yre1Ej3EP/9w==
X-Received: by 2002:a17:902:ef10:b0:2b0:ac1e:9730 with SMTP id d9443c01a7336-2b5f9e931b5mr183257505ad.14.1776868776613;
        Wed, 22 Apr 2026 07:39:36 -0700 (PDT)
Received: from localhost ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa507cbsm173588135ad.37.2026.04.22.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:39:35 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: pabeni@redhat.com,
	matttbe@kernel.org,
	martineau@kernel.org
Cc: geliang@kernel.org,
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
Subject: [PATCH v2] mptcp: do not drop partial packets
Date: Wed, 22 Apr 2026 20:09:31 +0530
Message-Id: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
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
v2: Drop the mptcp_try_coalesce() attempt for partial packets, since
    non-zero offset always prevents coalescing (Paolo).

 net/mptcp/protocol.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 614c3f583ca0..73ec6563ab2b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -397,12 +397,24 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
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
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
-- 
2.34.1

