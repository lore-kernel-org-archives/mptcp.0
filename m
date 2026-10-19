Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02048F828
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408571; cv=none; b=luWKa6MP+/YW6r3GTr/RmL9Lw5Jn1PuyUaEWbKReNrfsvpJ4nzoEPEiyMt2jAb7wNbnFHfA4Ds/z6JOdwR1a+YKqW9+QCLt7pDpaEL/9IINgvYssRUY9iVTFoJ2dxzWz7EzP+3hFwy7PRHMp3CKvc4D3OMscmA/PwY2Y+dzyql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408571; c=relaxed/simple;
	bh=iz8BaEglKzNiDaqzpo32rmLdGATYVIwM2YXV38QpGII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1/GgRfkRGFmPRUC3MZXQguPNXRYyI1HIOArFC0je/AWYaYKEmm9MGIl3HXZHx1kNReocYrnQdUFWTahJwViMtryT7aA6x+Qa4NVC6zE/IqTTdnxvCzFyP6Q/VvmmBTfuoN3+I9cpH84Qqs9u247dAqUlQ/ReEmyntmMcwnx61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knzdREas; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knzdREas"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-353804b591eso3786388eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792408564; x=1793013364; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzzVad7uWaphIKub8ka4ND4kxhHIf8Bz0Lzltgz+Dmc=;
        b=knzdREasqe2pmt02IGA26ST13i7sO0aRmAzsgIYGZfzmMKBOw8+TCsNb5XJ13faFyq
         xRJSBAn21HCnfB6yufV13mViLFu7DWz1BTKI+rQDdd20e2DPuuwJvCjHSWPBQ1HcuyZW
         S4UjVHg8Ucqd883DW/ODLllWNBTOowIZlIFs3L/ljzz+QV66gVURfJy5ryQnm+J9X9Bt
         UFvJEgq7+sIvox2T+U8B03n/NoINONlPUZgX7YuZx8UYsNqBNlgMyq2HV947X+qGrlIK
         W7YKbpBGZ69m48di1gT42QiENdRNB3I0/W3oeI+nXuNSYzIHrdBELZMut1Vr1TPxId80
         cXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408564; x=1793013364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzzVad7uWaphIKub8ka4ND4kxhHIf8Bz0Lzltgz+Dmc=;
        b=x/bkmnvGwpj+9/3s1n+ogK8RPSVpnXuLSp0rOx+AzrX62h2oOi+8EwwLSNKjdgWqAs
         dmbWAKU+LBjkF4d4mD/M5s6zohhVOUhtaPl+B6dUK2hSw24Nn8qFB+0fidDFgDKulbi2
         oH2+Tgr6kxc7ysjUEuhdi3ZzIJ3N0g0HYw61Uv7Br2dlyDLACxDtPn9ff0Unzxv2xwMj
         EZ8smR9klhEtw6hdlrjGSOt9PchcHWK8T1J0e0r2VroyVcP7OFT9VfwBi9qwS5xI05qs
         skXg6uLEUuJSgA58PLcyzFSsXuxZD91cCHnboJR8QATar3yQn/9HXfitQ4lhLQPFWex3
         VJXw==
X-Gm-Message-State: AFq9FYL6czQ5gAS7lZ27V7g+ZsRCjQv0HJH6nxwr7vnGPCS0vjH0jEtM
	s7d9ngFi/1iwonsAwnt3zg0C2NltiFA8CoAXCy7l2aifAOuL9qhR1+An
X-Gm-Gg: AYBFou1nX4WjbcYF7hVUJrNIYv1Ok0h9ky2kFBaDM7mvQy4LrWCAyiKq0AwgxflJc/N
	Kf6FrYTuCTj6k4TEXj/0SWudgLG/jjO0E+CAmNKrKkEXDm1oVVKXgjqhPWvJIxo1na96q1NZE4+
	Ml26CQaYWMXrbk6D40kZYDn9CsTtxUGKpguRFOZW0ml7qsbt7o407CJyyioJZuNlgMnvreik9p/
	kO+2FebeJek2FieV+zWkyzXHywR8s4fkTGhQxe4RFmr9W6mwfCKCYrqf2uJNULFAjnyH0jDvZWj
	tkbIUn85DKZufRp5Vt8OCbxvb1iE2yrw77MvfvQTIf60iQ1WaQleT/WgMm3xdVw8HmNWfq/MYD/
	Pa7y+a9LgTrTAAtQT8sOogNFs0HS4scQmaOTf6e+KvOVN6aKh6yOBfs8YlGDA0iuJFmDYpiM1Pp
	Uiw4GnBEd0EQjpdsG9ZNcvSE8DG/sYBH0J2/O0gjCOclD22rDwo6VBChoQJ1GfiU20u4JmEoOZQ
	gLxYt8=
X-Received: by 2002:a05:7300:7aa1:b0:351:5cb5:53f7 with SMTP id 5a478bee46e88-3619e926244mr11216707eec.3.1792408564054;
        Mon, 19 Oct 2026 04:16:04 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082f7f6e0sm35689068eec.27.2026.10.19.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:16:03 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: stable@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] mptcp: move the OoO check back into __mptcp_try_fallback()
Date: Mon, 19 Oct 2026 11:15:59 +0000
Message-ID: <20261019111559.2063342-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.1.y backport of upstream commit 1bba3f219c5e ("mptcp: do not
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

Tested on 6.1.190 in netns: 6 connections (5 uploading) over two paths,
then a third endpoint added mid-transfer. Without this patch only the
idle connection gets a subflow on the new path and the other 5 joins
are reset. With it, all 6 join. Same result in 3 of 3 runs each.

Fixes: 9074732c1caf ("mptcp: do not fallback when OoO is present")
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/protocol.c | 7 -------
 net/mptcp/protocol.h | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 10be901f..cc0d8a19 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -932,13 +932,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
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
index 1de257b8..39c1d823 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1004,6 +1004,14 @@ static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
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

