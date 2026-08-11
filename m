Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D443B6C4
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786487027; cv=none; b=mcm4DGMt1A+4F5yUWuV4gfAlwFuACj8dT8BM/nwZNfrOvuYPd5zfiTLFAHX5yUkCJLkX30sL7gD2FwucxYubUefcGK63AGqO8O6JXkWREvydBBnb9vwXG5kUzzg8AVPbqjBD5ntj4dZataFRkBWSstZSqGiMzwWC86HHVx8yA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786487027; c=relaxed/simple;
	bh=lY641tFyHpBRQd0na4wBTsNmbvRy38ZNd54FPFLtTH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT6VBUoSA3qHKPHvxT4FpZUPm4YM+a2Hgr6AMhG2/LxoHBG+oBRG/wX+bnMLeupgrH6amsqOMAUmV06eeoLJNh5ku74Y296W5IRauT4caNKQ7HhRsvkLMXrkW9yYSEqWLQxlUz5S86ImQWKaHSmKghQtMhVSHEUw00tNY6Lx478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBNmyyCf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBNmyyCf"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a2c90e383so1209068b3a.0
        for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786487025; x=1787091825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MMwqR/LUP0gNSxcJeMskNNfCCj4bDOzY7cV13z/jryo=;
        b=IBNmyyCf6BT0I8j3u7ZdR8q8+djFEQN8Gx0fyaS//xM5NMJ+YsHQLJNGxjxp/kcFbt
         abfiajGBwGR/DVHjFJ4OESeF/hYYoASw+3T3fZgCjEzJ8FcJxpte/Jg10MXowFIOg0l+
         +MUEyyrxaj1yzw/CqW/s7CBnFe2UdPcY/O11ZBDJ0IrjpF3hg9NKFTvQNfd6I+iWQY7s
         jsTteYUGz569OndDLrAwNdcv8vc8VXOVRiHma+tFaooBAFaauMhLjDy5veA7MhkHxor+
         Kn3coY0o3zbEyzTYTQTOjjgvQ60jxRevUxC1KFRRI+gJxDgeAFMEuTd7eSNded8bJBCH
         oazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786487025; x=1787091825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MMwqR/LUP0gNSxcJeMskNNfCCj4bDOzY7cV13z/jryo=;
        b=K3+7fjpege3tbcVAhxHsswe3bjBhXx2IpKObDGP1gm/ObUviKBh3kkmmFhsaXMP+Tr
         WdXiPzyaTmajNGaXXtsIk5DQk9PVlx8vvZlFf/Kj1eRMN+RiPGgzKP5/5Um72eAxyjUt
         kq3nkdVa/mKfJ/2+qlS5YwvyhGW2aj8AjdrSnA45Cn7mwSdMgPtOGpCPGluQoQovexC2
         JOxfFLzuqWKseKRdO5NL4YmKiBkPE5u8crDeT21ZDm2Gec+zuNxJI6q0zjCyix70vd0G
         cVPOKrMBxD6eHAd6us8MCNFUbA6bv6nKsjGwmSRenPnpKa5hcvYaSE8zatR6rUA2jmLG
         JmXw==
X-Gm-Message-State: AOJu0YzH01JpT/Bqvfrxo1sOkd/aPZ6fQnDSKIrYyLSpqu6BadK7slZC
	EgrMYXtmersy56+7RA6GLg1p5n1xn/mjeBZ5BO/PzKY40a0BqQwVrsh9
X-Gm-Gg: AR+sD13wDwW0dTD4xDT3J+HmjWwQxmQeoXSJ/VK2MxsiY8EnZ8PjAz3eW4l6s5HU8ov
	oDvCjA6P00eb+Q/mhhkBjKoVA7FaKpxAlp9EwCqZNJGyeIpNlDKCHO4kPlf0OltiWG1wbvFuFe0
	dhWP0pOqKJxdabUeU5vcUmFbxpgghbLtOqLtf47OPEi0y9bGMQfqupOn7aGFbK5aEoCBmxm+DXd
	YDGAQ2U+8mMjKnUhKdK4HKCGoTRSDcoxrQx5EFtuKP+vosXJ3DtfDGXWO/2/Utue9UhGEXNGP/X
	H0ILL9nk/K5afJlKORqCCfj1jpmcjdTJQey1NM7IMzxsI+G9+MXclbnTvBgmLYNF1gcChQkhOKG
	KMtAVbTPZeGvTT5Rpa6QVwfVQLLVxOQR/uGvL+2Q0OvgI3fKep8fKeLQtbdCEt/jEfeqpMp7Xrc
	p6TJtTWHUAAUWlNLH/3HyR0D+dP0KARQNQ0ovvD1ZBufrvsuxVaMV5lg8XwFC2vwKC9LONGC8Hy
	AuYecM44YTKsPyGG+y70G6CNXwaCtC+pHcE7bOuTAw8Oz4vq77sT67fNg==
X-Received: by 2002:a05:6a20:488:b0:3bf:a517:cdcd with SMTP id adf61e73a8af0-3cc379514c4mr4582561637.12.1786487025287;
        Tue, 11 Aug 2026 15:23:45 -0700 (PDT)
Received: from LAPTOP-N5EO9J2L.localdomain ([106.202.115.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141244a9669sm3326808c88.8.2026.08.11.15.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 15:23:44 -0700 (PDT)
From: Harshit Varu <harshitvaru666@gmail.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	security@kernel.org,
	Harshit Varu <harshitvaru666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp v2] mptcp: restore full join state in syncookie MP_JOIN reconstruction
Date: Wed, 12 Aug 2026 03:53:25 +0530
Message-ID: <20260811222325.90426-1-harshitvaru666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811215135.87756-1-harshitvaru666@gmail.com>
References: <20260811215135.87756-1-harshitvaru666@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_token_join_cookie_init_state() rebuilds the request socket for a
MP_JOIN 4th-ACK that was handled under SYN cookies, but it only restores
remote_nonce, local_nonce, backup, join_id, token and msk from the saved
cookie entry. local_id, request_bkup and thmac are never restored, even
though the SYN path saves local_id and computes the other two.

subflow_ulp_clone() then reads those three fields and copies them into the
joined subflow context (local_id, request_bkup, thmac). Because the
request-sock slab is SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the
values are stale bytes of previously freed request sockets, which an
off-path peer can influence by sending concurrent MP_JOIN SYNs. A corrupted
local_id breaks id-based path-manager bookkeeping, and a corrupted
request_bkup misclassifies the subflow in the packet scheduler's
backup/active selection.

Save and restore request_bkup and thmac as well, completing the state
restore.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Assisted-by: opencode:deepseek-v4-flash
Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
---
 net/mptcp/syncookies.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index 7f2252634..3c25ff627 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -27,7 +27,9 @@ struct join_entry {
 	u8 join_id;
 	u8 local_id;
 	u8 backup;
+	u8 request_bkup;
 	u8 valid;
+	u64 thmac;
 };
 
 #define COOKIE_JOIN_SLOTS	1024
@@ -63,8 +65,10 @@ static void mptcp_join_store_state(struct join_entry *entry,
 	entry->remote_nonce = subflow_req->remote_nonce;
 	entry->local_nonce = subflow_req->local_nonce;
 	entry->backup = subflow_req->backup;
+	entry->request_bkup = subflow_req->request_bkup;
 	entry->join_id = subflow_req->remote_id;
 	entry->local_id = subflow_req->local_id;
+	entry->thmac = subflow_req->thmac;
 	entry->valid = 1;
 }
 
@@ -117,8 +121,11 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->remote_nonce = e->remote_nonce;
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
+	subflow_req->request_bkup = e->request_bkup;
 	subflow_req->remote_id = e->join_id;
+	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;
+	subflow_req->thmac = e->thmac;
 	subflow_req->msk = msk;
 	spin_unlock_bh(&join_entry_locks[i]);
 	return true;
-- 
2.53.0

