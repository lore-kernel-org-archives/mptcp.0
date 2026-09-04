Received: from mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCD3CB8FF
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507214; cv=none; b=To/SO0pts/Tn+wMvKKIz/BichToKG9oqky/PRM7EY91Yw7O8TBJtfomnREmEcFyFrTDLsxVJj/jQypMjGmbOcWTIQZG1TXr1pmN1f5k+WYDqVYDE4Lt4j3QxepphibcyUiw0XzF3w1xwrATr0yI9dgh1OrjGQLxYfGzwVxHyLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507214; c=relaxed/simple;
	bh=pEG/wICMl9/iT2LdUUNv96Hz0CipBeTxCjAF58sN6cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDetpGIDWBqo8azp9BMqV0LBiwL1oizg1i9RJrAVC23bSvTBTAnEDD1JhPP3FXRxAFxQP0qVf/iLkudFL/qfz4NdG9YJUYCrusN0NW26zanNGqs+NsW2ZnQ2JkA5j67E0skJ83pnlHCOW7ory+LT3ZFfn5++5q6vGbOtHHuRFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VcGjPxEq; arc=none smtp.client-ip=91.218.175.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VcGjPxEq"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=pEG/wICMl9/iT2LdUUNv96Hz0CipBeTxCjAF58sN6cA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788507210; v=1; x=1789112010;
 b=VcGjPxEqmMG9Apu28k0TdL5rmToo5USwJ3kjHBPPdjbCcVQFxgIafpHWm7QISeyemfp15ChA
 ebQWKc6seRY3KAgT+JPv21geWYKmR1cJ7Dlf0QvEgtLqbaR4R0yurE5VegMfWcR1iOLQSUoK1bg
 twpy/mNnSuUO1zhiXcsUhzJA=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 45dcc77496b38a04;
	Fri, 04 Sep 2026 07:33:30 +0000
X-Mizu-Trace-ID: 45dcc77496b38a04
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next 1/2] mptcp: keep pending join list flush across disconnect
Date: Fri,  4 Sep 2026 15:33:10 +0800
Message-ID: <20260904073311.1285024-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904073311.1285024-1-cui.tao@linux.dev>
References: <20260904073311.1285024-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

mptcp_disconnect() clears msk->cb_flags with a plain write, dropping
any pending MPTCP_FLUSH_JOIN_LIST. When an MP_JOIN is processed while
the parent socket is being disconnected, the subflow is queued in
msk->join_list and the flag is set under the data lock, but the plain
write can erase it: mptcp_release_cb() then skips the flush, and as
mptcp_destroy_common() only iterates conn_list, the subflow sockets
queued in the join list are leaked. Flags that were already pending
before the disconnect are dropped the same way.

Only clear the other flags and keep MPTCP_FLUSH_JOIN_LIST, so the
join list is flushed from mptcp_release_cb() at sock lock release
time as originally intended. Do the masking under the data lock, as
mptcp_finish_join() sets the flag while queuing the subflow.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/protocol.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e1f08f71cdb16..7445de5a80ff4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3615,7 +3615,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->flags, 0);
 	spin_unlock_bh(&msk->fallback_lock);
 
-	msk->cb_flags = 0;
+	/* keep a pending join list flush: mptcp_destroy_common()
+	 * leaves the list to mptcp_release_cb(), the data lock
+	 * matches the flag setter in mptcp_finish_join()
+	 */
+	mptcp_data_lock(sk);
+	msk->cb_flags &= BIT(MPTCP_FLUSH_JOIN_LIST);
+	mptcp_data_unlock(sk);
 	msk->recovery = false;
 	WRITE_ONCE(msk->can_ack, false);
 	WRITE_ONCE(msk->fully_established, false);
-- 
2.43.0

