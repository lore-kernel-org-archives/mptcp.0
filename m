Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339535E92B
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738524; cv=pass; b=Iubyiap6/PKL1U8t3Naxrqw8dHWBIecZXlqNw/hjFySj5OBuUy5lpFnTq7rElS0UbFWv1R8V5mwD+AtWz8zxhtLEiokfzZiUu3azHn2evgV2fUp4pxq1F1by7NS5PLSY+c0UQHlmh3A4rPYathKJXffXOfOp+iSDVPQM/L5vzZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738524; c=relaxed/simple;
	bh=yKeQGAAfHDtOIHWcg1/J8uZzTVw33O0RXM1STyL8fhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GpM7daVzeIjl17G1sCrBn9q7Z8m0Ml81xIrmYiqwsNU1GZGNJbRydMzojGlS/qQJ1mJNEyMgL3EZ1eU2LTxLIiybKGc4FmRXCrXp3yotKfz+tpJsvOxUzPHySjCzQ5uR/+6ERQFqOHMn6K63sAFZ5jNAAYy8yWihBcZJJpUXZI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=iH7h58KV reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="iH7h58KV"
ARC-Seal: i=1; a=rsa-sha256; t=1779738518; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MYPpNzkf82DiM+zI5fENe8+etJ6yX3DphWpuMGiovoj0LqeKWmukOnZ0sqQ3ZrAKuACvNIs2mi0q6Oot5FPzdj9pkume2F7KzBAsCNbtY1oHDRamN5nbWhDt3nY78PLo0BDwfhDwB/77yN+bFv92WWmkWd1PplkVYm3FXJcpU+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779738518; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aKw3VwhN0Q2PcX0LOzAe+itVkLOnWeUrLq2D2s6Mlvw=; 
	b=UkenpX5vFmUkwJONltOHCMzTZxHnuHmKolXdiYd5ipZCdNX9qIxvtnsfFgNTaGZxDPtcpAx+QhJyNIVyxHgG2gd6QJdytjMQ6KJ1y5qMrMFT2xC7WhAtc3SO/U6ra+BDxh1svS+xaxbeXmt/nDm7fN5Laxvn5cww30TCaAGJaMg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779738518;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=aKw3VwhN0Q2PcX0LOzAe+itVkLOnWeUrLq2D2s6Mlvw=;
	b=iH7h58KVMOZH2pKtyY24XL1o2PQTJ/VuvqpxcwFweDO3re3ufGY9BN5UsaegtVnT
	SevS2bKuaokDn2iHK9egRRhXtxLeoZtlj/8JkSIoALlXcWXenK39uzHxrxQwp/uPSwH
	dChzvYO90qjI+O8uLx64hVKBamyPoQWG4hNnFftA=
Received: by mx.zohomail.com with SMTPS id 1779738515981936.7174035925694;
	Mon, 25 May 2026 12:48:35 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-net v3] mptcp: fix divide-by-zero in __mptcp_push_pending close path
Date: Tue, 26 May 2026 01:18:28 +0530
Message-Id: <20260525194828.1137119-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

A divide-by-zero in tcp_tso_segs() is reachable via __mptcp_close_ssk
-> __mptcp_push_pending -> mptcp_push_release(ssk, &info) with
info.mss_now == 0, triggered by MPTCP_PM_CMD_FLUSH_ADDRS.

__mptcp_close_ssk() leaves the ssk in a state where __tcp_can_send()
is false (FIN_WAIT1/2, CLOSING, LAST_ACK) and then unconditionally
calls __mptcp_push_pending(sk, 0).  For such an ssk,
mptcp_sendmsg_frag() returns -EAGAIN at its __tcp_can_send() guard
before reaching tcp_send_mss(), so info.mss_now stays 0 when the
trailing mptcp_push_release() feeds it into tcp_push() ->
tcp_tso_autosize().

Reorder mptcp_sendmsg_frag() so tcp_send_mss() runs before the
__tcp_can_send() guard.  info.mss_now is then valid for the trailing
mptcp_push_release() regardless of whether the call ultimately bailed
with -EAGAIN.  tcp_send_mss() is state-independent MSS arithmetic, so
calling it on a non-sendable ssk is safe.

Found by an MPTCP protocol-flow harness extending BRF
(arXiv:2305.08782) via the MPTCP_PM_CMD_FLUSH_ADDRS kernel-PM admin
path; the oops is reached on the first qualifying run.

Fixes: c886d70286bf ("mptcp: do not queue data on closed subflows")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v3:
- Move the fix from __mptcp_push_pending's ret<=0 branch (slow-path
  release-and-null suggested in v2 review) to mptcp_sendmsg_frag's
  entry: hoist tcp_send_mss() above the __tcp_can_send() guard so
  info.mss_now is always valid before any -EAGAIN exit.  This
  preserves the trailing mptcp_push_release() flush in the normal
  data path, which v2 was inadvertently skipping (7 data-path test
  regressions reported by CI on v2; Paolo: "the check I suggested
  is a bit too rough").
- Fixes tag updated to c886d70286bf (the commit that introduced the
  __tcp_can_send() guard above tcp_send_mss(), creating the bypass
  path this patch closes).
- Reverts v2's release_sock/ssk=NULL additions in
  __mptcp_push_pending; that change is no longer needed.

Link to v2: https://lore.kernel.org/all/20260525003233.857172-1-shardul.b@mpiricsoftware.com/
Link to v1: https://lore.kernel.org/all/20260523211800.2952905-1-shardul.b@mpiricsoftware.com/

 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a72a6ad6ee8b1..3aceb7b1f3214 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1332,13 +1332,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			 info->limit > dfrag->data_len))
 		return 0;
 
-	if (unlikely(!__tcp_can_send(ssk)))
-		return -EAGAIN;
-
 	/* compute send limit */
 	if (unlikely(ssk->sk_gso_max_size > MPTCP_MAX_GSO_SIZE))
 		ssk->sk_gso_max_size = MPTCP_MAX_GSO_SIZE;
 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
+	if (unlikely(!__tcp_can_send(ssk)))
+		return -EAGAIN;
+
 	copy = info->size_goal;
 
 	skb = tcp_write_queue_tail(ssk);
-- 
2.34.1

