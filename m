Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E81351C2E
	for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786794745; cv=none; b=VnhzdcPaVc498KrEZZYsLIR0e7rxpPBNgX0z+K6ZBzjXRzCYAdPxm0MO4Q22iSiemTYV4Sz9lmYkw3qSUP+Khq7zIHOv7m6/ROWhRqR3vutbIdU5XptRbLx41iMgcj4a5y+UaLe+xnLiWxHy8JaoZTBbggtWj5aWNllZ4gFaz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786794745; c=relaxed/simple;
	bh=Azo2sCiZllD4H75gWaBzm5I3JqLlnW6xlX7nRXQnSss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+InlKri/wH44a4EUxk8sBsCX+SePTSGl1c0ZUV//OumdfDv4TSqnKR44ChsM1bndKGlTr5neujIsJCi6ICMjHmoWN2wZ8I8gnGEVpxqyITEif4QPDUZnavWoDlBvQeVPeKofnpUzyA4VDEIZjTIuYOy7aXkAt9sdqhLNqTURmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKzJgZkr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKzJgZkr"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbf0dc8c871so1122744a12.1
        for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 04:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786794743; x=1787399543; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=pKzJgZkrN6wFT1mWBg+u9eRYIbZsqrZdf+mNorg7npFkm0wNAIe4vCFxJZjZjOp0J4
         gVJNqrzH905LugITjnqftnHMfSE9jO8eL7thbwDhpsbQy6w90HlQ0DFom3w4VT2ojOt3
         IokhoflxTkoHG61FkJb+aceaZdEHP4ote+HambL6nuekartX9O/K8p7KZiOzr0Lebjnt
         xkM7eEv214pqS1Dm46UQxjYnQPldwVKnIcmxUzGm3dl5wpD9cVlJvh6th/jTAMZQ+AhF
         a77E4hZTaulryiBXWJ9inOrNszZVsIalhcmZR/qQJFKUpsvIZ8DZ90SfuL/tLO7H+Dyn
         nsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786794743; x=1787399543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=Vfp76Fy4ElVyw1I6uMuqz5D3KHCHBsP9WAnerKyt+Bc9FVzTCUmFwpU9ssCt9joulO
         q83wx6vc1FDlRWKe7I1c2+nA+v2R/gd88HnaNwjdBOoGPEWI54hO9HiDK39N0hDYZgA5
         8e2DPTTylcsRERhZV+qqAamVVVIAu/yq0kItoLgOhwaqQEtSJnCh4EcFNOzy/aSFANkY
         QcpDrTWDwzzXSuR883XeDUDi7PkDGgAew0l7XjIH6B8rNzFtwTwHAB9cF7rtQKw5R+1+
         1xASnm1c/bKEdQRMhY9Vb8X4gTlZAQWJdrV9JUBF7Mm350edk3IBEat8Ru0TfwvDyAC6
         GCkw==
X-Gm-Message-State: AOJu0Yy8wemY4Ip9/L+LyX5mC+orppU1g3is1oE6Zh5JINCAorjKWZJL
	BQdmMA5RODwYy6Iw+pD8u993Elq89cFY6/vTMWsF+2e/u9ywCEUK343l
X-Gm-Gg: AR+sD10Bfy1h7MIJK6Y2K61HNibk639dIsJdzI6ZdcwFuc5ZctyZFX5+Q26K+ZmY9IB
	AOfvG91dyVd3OcnvD4pvlZm0pa4VP9Jr2Vp3QJKRyQOifiymW9EjBk8wQ3vmWfbCOd6FKc5oPfL
	1dFGQwW+kTxU3Ql8Fn949WmWanxHOmwDF4tfn8L5wB3ypYVQLjo3YEetIUvFGZdDk7kzSXffGLA
	7vNSLWAlmAvfYykV44CecuXlsLRqDFt1fmEEjmg7KEsg22Wuiobj39FP44wERsQUXJTOvid7qyH
	1XCImq9B2AWqxshVpXVzanWcB1qlbY995tHwzP5q/fp8JxZcJiXOzyhmlKpXjBmXADReczMFTOY
	8Pv5wqADTWnXn6+d1xeM94cP0QmDB6AwG7fW5dO46VGVmZUS0IkFDb+RTf9UfV64TaHvMv1UZEj
	5rFXRDkHhp+dR9wZs0PBEAIt5ughtiD39mtKPQRnFAASWoMMnuIcw2jmVP5RE56ng+x1CKp6imi
	QF4WVc1Ge+GQvMULVEmASwxIsnZH7SXKc4IwR3dnyd40pr2
X-Received: by 2002:a05:6a20:7346:b0:3bf:6ac8:8d29 with SMTP id adf61e73a8af0-3cc71c95248mr13675074637.21.1786794743413;
        Sat, 15 Aug 2026 04:52:23 -0700 (PDT)
Received: from LAPTOP-N5EO9J2L.localdomain ([106.205.255.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd9fe0sm23884947eec.1.2026.08.15.04.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:52:22 -0700 (PDT)
From: Harshit Varu <harshitvaru666@gmail.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	Harshit Varu <harshitvaru666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction
Date: Sat, 15 Aug 2026 17:22:05 +0530
Message-ID: <20260815115205.197151-1-harshitvaru666@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_token_join_cookie_init_state() restores remote_nonce, local_nonce,
backup, join_id, token and msk from the saved cookie entry when rebuilding
the request socket for a MP_JOIN 4th-ACK handled under SYN cookies, but it
does not restore local_id, even though the SYN path saved it.
subflow_ulp_clone() then reads that uninitialized field and stores it as
the joined subflow's address-ID. Because the request-sock slab is
SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the value is the stale
byte of a previously freed request socket, which an off-path peer can
influence by sending concurrent MP_JOIN SYNs. This corrupts the path
manager's id-based subflow bookkeeping for the connection.

Restore subflow_req->local_id from the cookie entry, as done for the other
fields.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Assisted-by: opencode:deepseek-v4-flash
Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
---
 net/mptcp/syncookies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index 7f2252634..b5cac5701 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -118,6 +118,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
 	subflow_req->remote_id = e->join_id;
+	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;
 	subflow_req->msk = msk;
 	spin_unlock_bh(&join_entry_locks[i]);
-- 
2.53.0

