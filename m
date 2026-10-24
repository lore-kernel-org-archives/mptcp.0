Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840731;
	b=cNiFwtXMrBhNxvIbWB+dm0gXjb8sThgz6iO7MWCBmkSSAldK3OyoxkrCB38vA3d4I7Tw
	 rcXYcEFLlC0b12ws1atlbO7qtcBJ5ebCiA/fdjqwmmG8Ozft6UaC2xsEFK7+g990nAF5I
	 UJuUti/1GKmT+7P34sfwfWFFlQDMPL2Z3hfteYZ+2d8dz+BRjxVrM6F/sEKxIXtD3pY1o
	 1RV+MQzEMfNcm2EFMT4Xd8i5vGJCVQ4RDen+EEqhS9SD8pYKoIiIl8hvVB2LChdEzUjPj
	 +binYgRF8zpwC+6UzD/3mT6/eVjapbChpXPZ80AWX6F2/+D25nKf5hAS4bjWPNfVmBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BVxBaOD08DfGYfH9jEwqVQmzZ6pV+ioii7FTsj+LKiE=;
	b=qgozo38BvA8OTvxiUJ2uxMXUmIU+xJkJChJljBFBSQouOgb5gXoY6G9jt4EcrWxDCb9l
	 fXgxIXgX3EDUioysBuPIsmraxpkD/Qkv9Yal7Ga2SLCmLEdFLsuaNGAjlmBy60rl9qoZ/
	 iSS4ALSR1bC9fWOHkyjVgdUF8nRTO/nNGJOovCC8sbrEhk3EicL93A9pM0uK06/QrfyBq
	 LQ/JYEcHN+hSba1/WTWgdju9zlpzPZX1ANg1yklcUq6FUvoX2CYSJmIz0uyiPQMZ9WY5r
	 EHqWl9lpS5c2uGDMqEm6y8jnZAebtmRVF8iQp0PAEE0Mc1wtpCX14qmPL2W/5WI04gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XfssIkxG;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6E606A31D
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 11:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31D6E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XfssIkxG
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2936173eec.1
        for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792840730; x=1793445530; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BVxBaOD08DfGYfH9jEwqVQmzZ6pV+ioii7FTsj+LKiE=;
        b=XfssIkxGu8vp4K3F9k5l3Un6NTIF36kRpBRBewHSMw9T02s3ZtwwTcoMRdeqG7gjoR
         ImidhSf66yEabyzy1ZYNj1DQqjjbMzQ1dh3OkorJAKFVPEMGXeu8qDC457t9lh3SBDHV
         nzOjbNOhucTmWW9LEFYCmtxPk7zJwk2IVyz0e1R1HxN5dSnOk6u9tuWv8rYP72lrqNtF
         CrNIgVhSV96h0FEEoDxGVai7BMkSqOr6RdQ/bl3y1eeAkYBJmr/PE2+N6gQtNSz7Yipc
         pGVjSQPHs2Rw0Psaw5WV5Y4kUTpJIb4jB5fdmFDEvk9wOaaDCxPjS2bHQy5abCkqQAay
         b7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792840730; x=1793445530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVxBaOD08DfGYfH9jEwqVQmzZ6pV+ioii7FTsj+LKiE=;
        b=RGEE1Wcx0aCL6teSaZI7RRaZQP4afBvHJe6MWdpgR/fygdOoMAopnzjrUxdn+po84x
         VZpuUwtnP+Plt3MYIYIbYHHCzcN18Ch22c5NaHlZd9ig3CXhTtrXO5jfBieQdEXOtgpS
         YiAH920Ub8CNuYcQxYn8EYz0oGYXrvXkrNKjA/kfJiGGjBEownFK3K2Ed3TCp3rZPlXf
         vjrfJfE1/xgZcCQ1XlKn00EPmUeq0FR81ywwyN97ASXVmnXPfPoHCO/R9BquGuklSpIB
         LMuh50rXERj/tN0KItTp95rGX/AQq1RP+UcDPgLMDoY7zwA21ryU6Ps9caJELEpE63tA
         eUJg==
X-Gm-Message-State: AFq9FYLv15PksopDrY9HE/pDIxTYZJHnyNPK4drplwPHLQWhw0P4D+YS
	asSfgQZBdvq9rU56dLUa8F6Hx+lVXWD/J+mGrW1c5dR9EEcsYQS7uRKfVP1e8g==
X-Gm-Gg: AYBFou1X50AQZbWzBwDLJoHGJwdQ0ocNJGfZp8hmsVDDItISbzCA65+6ggKMePf16/Q
	YNyPXJdVjCdVBhrDvqmr9dx+fHJccZOrD1uCMlJfjSgT1PasHf3tVKd/kvLj1ywhzfUezRB5oZe
	IGH0lmaKaDUEW3cIPe9BcXiv7/dOU0XqmaGRywZJdVFb/8jfcsnNXjfuDBuetJq3cmfsmhcyitF
	2ejLxJ9RMVKg8/rptKZHk/U5jQrmephVnUtfLhc5dyhp1kR8A0cSu2MG8+fYpRiIJL+/RfdX966
	qM0HOZmrL7o5O5Q9PizykDWapWBOu400q98r58omDWykxtJgUHTi1zPWI/b2sThLIqbfLMY6/qv
	pc3x9jxwoX6Cbrq3PPNhwiQzCQOiLjChT32JywzVrqyP1zgNojr1/STxgkg6yZai/JAoeB/WNTt
	8tAaT+4dvXM4oZj54dBXNqm7w/TY30L3UMMgAlXNQN5/pYBe1ZpYeLAmYO202aTWw4qkAWKeO0y
	jZDrMimPFPBWBvrfa9VC8LbdGaXqzsOv74hrrWZLPYg3eLOJjxaAsE97uPBwQ==
X-Received: by 2002:a05:7301:3d10:b0:35d:ea6f:b85e with SMTP id 5a478bee46e88-369e8358affmr3908622eec.1.1792840730104;
        Sat, 24 Oct 2026 04:18:50 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8afd64fsm7458774eec.0.2026.10.24.04.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:18:49 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v8 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Sat, 24 Oct 2026 11:18:41 +0000
Message-ID: <20261024111842.1069878-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024111842.1069878-1-w453y.me@gmail.com>
References: <20261024111842.1069878-1-w453y.me@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fullmesh endpoints, if the endpoint used by the initial subflow is
removed and then added back, no new subflow is created from it: the
connection never uses this local address again.

The initial subflow is kept in the conn_list once closed. If it was
still established when closed, it keeps the local ID 0, which is also
the ID used by the re-added endpoint, and
fill_remote_addresses_fullmesh() then marks its remote ID as
unavailable. If it was already in TCP_CLOSE, e.g. after a reset, it is
disconnected and its context is reset: the 'closing' flag and the remote
ID are cleared, and its destination port is zeroed. It is then picked as
a remote address, with the port 0 and the ID 0, which also marks the
remote ID 0 as unavailable. In both cases, when the peer has a single
address, all subflows use the remote ID 0, and no valid remote address
is left.

Skip the subflows being closed or in TCP_CLOSE state, both when looking
for the remote IDs already in use and when picking the remote addresses.
__mptcp_subflow_active() cannot be used here: subflows still being
established have to keep their remote ID marked as in use, to avoid
creating duplicated subflows.

When no subflow is left to take the remote ID 0 address from, e.g. when
the initial subflow was the only one, use the remote address of the MPTCP
socket, as fill_remote_addr() does for non-fullmesh endpoints. Before,
re-adding the initial endpoint created no subflow in this case either,
and another endpoint only worked by picking the closed initial subflow.

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a7750813235..c240c1056a59 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -199,6 +199,16 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 	return 1;
 }
 
+/* Closed subflows can stay in the conn_list, e.g. the initial one: their
+ * addresses and IDs are not reliable, possibly even reset.
+ */
+static bool mptcp_subflow_is_closed(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return subflow->closing || inet_sk_state_load(ssk) == TCP_CLOSE;
+}
+
 static unsigned int
 fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			       struct mptcp_addr_info *local,
@@ -216,11 +226,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 	 * already created by incoming ADD_ADDR
 	 */
 	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-	mptcp_for_each_subflow(msk, subflow)
+	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_is_closed(subflow))
+			continue;
+
 		if (READ_ONCE(subflow->local_id) == local->id)
 			__set_bit(subflow->remote_id, unavail_id);
+	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_is_closed(subflow))
+			continue;
+
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
 		addrs[i].id = READ_ONCE(subflow->remote_id);
@@ -243,6 +260,20 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			break;
 	}
 
+	/* The initial subflow can be closed: like fill_remote_addr(), use the
+	 * remote address of the MPTCP socket for the remote ID 0.
+	 */
+	if (!deny_id0 && !test_bit(0, unavail_id) && i < addrs_size &&
+	    msk->pm.extra_subflows < limit_extra_subflows) {
+		struct mptcp_addr_info remote = { 0 };
+
+		mptcp_remote_address((struct sock_common *)sk, &remote);
+		if (mptcp_pm_addr_families_match(sk, local, &remote)) {
+			addrs[i++] = remote;
+			msk->pm.extra_subflows++;
+		}
+	}
+
 	return i;
 }
 
-- 
2.43.0

