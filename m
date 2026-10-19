Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB14E1C78
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408562; cv=none; b=gAUMzEShysMouf6c5TwBSQLMddHJ2jS/5YtGhcYMEBfwEFzspF3ENMQ1W3UZL974iHbA/odGKKhTUdMY2Pl/6hUVjLMFUwAhj5q/q7d6LcnJxxP7b5yPEwg8jaEF5MOVXbHulQhOXAiCC8q0q4q2iQhy4kliecn33xE/DtcGXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408562; c=relaxed/simple;
	bh=8lqV+LxgYl2m/EvykQxnIXKyz1/rsjJbLS81eRPpR7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g848LWtrbFLd78BXzzSmiF62Q0MCcaAG43HkV4SUsB8djDM4jbRtMFf/aZIajkCH4cQG4NbpYkJdJQxwCGssiQNJEhM1mSXAsI6IibBaqlfQuit+S4bNQTB658ulyvVpXZsvEkiU+Rs1svjVxPzHbtc1TDj7NOgqli1mxcfd7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4TeHF2D; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4TeHF2D"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso4924637eec.1
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792408557; x=1793013357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OBCsG2VdnjP+rQWjfgSi6c+QBBT287exYkN58FtX+/8=;
        b=j4TeHF2Dh3EtiSHK532JLUsuXrONCavk0ATHBkcKlsVT1LgCJ9GwYnBRWU6aa3tpIC
         VFhQ62q2LE6Ki5Z6GFmfX314mh0kdabYKdi8UUtPifLNQK0hLdF9BE5kVcV8+wQp9nLG
         6ViN7cfVAbAuWYK9pE5ywWKLsMe5AD2yUw4vdMuW6JifqHzDt5FQMALtkw3LGoRuGzUc
         bxVUyQKiNM4XQwaLKLo+dHAjG9QVXpXEBBPLoR2MHrp9hTFsY18zwuKfDbc9cDuI+YEC
         mOJf1Y3xm5wCLXLFxZz1eaS3BUlhtV6UYg7P2k0WeJ8Fem21cR4m7a9DeA4Y9aYJDk/r
         emYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408557; x=1793013357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBCsG2VdnjP+rQWjfgSi6c+QBBT287exYkN58FtX+/8=;
        b=z4p3NhGVMS1W3jsQNARzCbEDEI/KkkFEbu2RfaGFInTO+5oYlgtdW0bCjw6tK7T3A1
         NOTUDL7aiCP5Z5FDRG2C68jqKcsqrQNiY3NMmA+FhYfnkMA3nC3yu/N+9dSlg/FgC0KF
         ISHrIpqqBNLzomGBFbqx4C4Qwe4QYxaJNEZiKE/K+N0ZWbBUgoQXBUqiQ0+YA9BqCFvv
         YynVG1FkxsS2urFgoHK9riGRS2nQ6UWKGtjMDlw+qAUFYulous7DFgJ5XpBFOj+aDSgt
         IDGH1ROwUNtwjf5fHvfADTOavvzl9S4qcRZUNuon0mll+NPNAZnAsODEY/jVQ3QQh6R1
         KFHA==
X-Gm-Message-State: AFq9FYJ57BlT8dVa1o0CyzVLN7tK1ZQ15i0tSBt9MXTmD6wVdPFGVlnT
	MTPrNRZ42bVjoe3ivZJyoeY2XrXDm6pxzYQ0SbJx+aNOLU8nIzkJ6yKWbCzO3w==
X-Gm-Gg: AYBFou2a0CknTrpku3qps39yPSm9veC1KqlFstLnr26kzL6C4nkCPf0NGHTwA/oGJL1
	nHhWCa7f7nM3OP0Li3K2vV417t3OzIb2aMw/QRYa+HbD/E/QJa/2SPgE7T2HdN3vLBAb4VUTzf9
	/mgPW/WbpvHLwJvlGz9ma8mjnQWcxrdJ8/tpnYsxsHz2LFoul+WpjAeJWF6qSEFT1Vna6VXz/PJ
	GYMDtQAZ5SV3zqROQDupzbEFOqa1uG6lFwkiCrZjhpzLG0Se7tnrsbxGkQCDTCPiRcGXkl6PySP
	eBuL0cXVbjIL1dwgsfv8zi75se4nvHYRapA9OMlIqI+k0fWwwNuO+oIcoZx7783kjieu8rIGxpQ
	FGP6lWxSIK5WUgDokXhZxGBlqGJZ0ipJVDtwBe6jUuDZBw4ZNC2gNyrHstQQ5mDRF5sjv7r3MmP
	F2h6jG/v93UpSIkPVkb+9Ah2UOZ1Ou0ZlqUatDQbm+ZGKUMu24P2MWfFhT8YuCNkl6aUFz7AEx0
	fKmbJA=
X-Received: by 2002:a05:701b:291b:b0:160:90a3:ca8c with SMTP id a92af1059eb24-18511ad841amr9702532c88.7.1792408556680;
        Mon, 19 Oct 2026 04:15:56 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm31817337c88.4.2026.10.19.04.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:15:56 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: stable@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] mptcp: move the OoO check back into __mptcp_try_fallback()
Date: Mon, 19 Oct 2026 11:15:51 +0000
Message-ID: <20261019111551.2063200-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.6.y backport of upstream commit 1bba3f219c5e ("mptcp: do not
fallback when OoO is present") put the out-of-order queue check
in __mptcp_finish_join() instead of __mptcp_try_fallback().

So the fix itself is missing, as fallback still happens with OoO data
queued. Worse, the passive side now refuses every MP_JOIN while its
OoO queue is not empty, which is the normal state of a connection
already sending data over more than one subflow. The joining subflow
is reset, so such a connection can't add a new path, and a path that
comes back after an outage can't rejoin while data is in flight.

Move the check to __mptcp_try_fallback(), as upstream does. On this
branch that function is in protocol.h.

Tested on 6.6.159 in netns: 6 connections (5 uploading) over two paths,
then a third endpoint added mid-transfer. Without this patch only the
idle connection gets a subflow on the new path and the other 5 joins
are reset. With it, all 6 join. Same result in 3 of 3 runs each.

Fixes: 642561238c98 ("mptcp: do not fallback when OoO is present")
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/protocol.c | 7 -------
 net/mptcp/protocol.h | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48b6e9ed..c63ccb4a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -925,13 +925,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
-	/* The caller possibly is not holding the msk socket lock, but
-	 * in the fallback case only the current subflow is touching
-	 * the OoO queue.
-	 */
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
-		return false;
-
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 825f7701..d70c71ee 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1126,6 +1126,14 @@ static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return true;
 	}
+
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);
-- 
2.43.0

