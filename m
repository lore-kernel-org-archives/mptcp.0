Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599680;
	b=d+juJpo3Dx5siizQ+Q0IXwKqu9HiZSfjuvygwmvu0cnKjKV8OZnn8gW70Ute0XcBCoER
	 kakCgiWjG1y+R0YVoT2sDxsR7agCLOb8CgA2XTfq0Zs/TLnBNJx33g03b9Gc/W+Pbhs2Z
	 Od3W8So7EksziMzLbUSG9GZ2VhJxdxAADgACmmT3UpFTixWKQ2vcEZSAhCRfCAiZRZ0oY
	 wyQbMMhT0ywJ9t9Errtw2jEelkdcafKG8D7Km8VENjtyIChrHT5zSUblNLBXJI6dgeYxC
	 T4vIipuvM+pfa6k376oSzS7/Qy5cNHf+qYhG1HyFPaIlP27N16YTSe+TeCXsLr7T0bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599680;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BELkbp4ExWP6/lcL/Ev8fJQI696janFQwLCyGJlE480=;
	b=K+dL/3Yl+ljNeTVhWtBJOuFVl/78huowi8hp3jaa1LyU/l2L3sRFDeKIOhVTamygkID1
	 cBCPmZNN08M9rKYcF7DWZ34wwnsCNYgA2TO1Ite6UJO/aIRx0s5c+Hzr8bQDyvjBymW++
	 ZHuzeH+6aE0U+GRXqq6kibnjJXE0mGeIx/6O0gtvGKiAtGR3TvCzmrySdMz8NChN/DTVb
	 z7yxtkjwd0Vo+AtFNawTt8wYzUck/oMve+8YMOoKTtZW34X3ssa1gc9eE0wXDO9RY8N/i
	 Ff60MoGWKlzlOrZDiKiQ9BqZVtzVbxsFjg4pzgF58lyKrDh6YMaHqsPKWMqPXFfcLgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blL4BwCE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82192606AE8F
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blL4BwCE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7819F1F000C5;
	Fri, 13 Nov 2026 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599680;
	bh=BELkbp4ExWP6/lcL/Ev8fJQI696janFQwLCyGJlE480=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=blL4BwCEyTiP5iw5GnfbHnZTX//gdSaxKrkACMgeHTdU/7W/yIi4rSP9DfN4MSP9s
	 TDrGpoNe2/rBKpR5LW89VsxKEuhK60TQqwtXdhQTgSAcx85aIDp2i1OPOivUyv/rGp
	 2n/gd9KKUe94ARJtS6p7gOjhi8p00wdiS+o8xJ2oFdJODEH/wOOXZSUfpXq4qOpvAI
	 yC3zZV1i7knUJp6FTl4fSxiosrBAMaT5VNrwTL1fVR+OMcycsyX0bZGmquLjCuKPwD
	 KxIei8+thHPn6f7OkW9DD09B1Gz5I+J741aPQGwiq8HrhIfdjk7jWxspPgU2WMlfH0
	 gf0op102qYsjw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:53 +0100
Subject: [PATCH mptcp-net 15/34] mptcp: close a subflow reset for a bad
 mapping
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-mptcp-cmason-fixes-v1-15-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2798; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=X7DMfxvUXFr2YBk4zqnV1sIrcYWLMnTUGu/oUF1i1RI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z91hYbN74XxN+vxU3pufLSa8DE7KCjNWOiaSJfkjR
 bPzYx13RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERSBBn+Wepb5dod35dw4vP/
 4xanBfk8Piw8mnEnaYZDnIFB82TdpYwMkxacalyjaqU1+bbGtqUiR8JmBb/J8b/2S/Xnytaf/1W
 ucQAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

An MPTCP socket can stay in the ESTABLISHED state after MPTCP has reset
its only subflow because of data with no valid mapping, and recv() and
send() then block with no error.

If data arrives with no valid mapping and a fallback to TCP is not
possible, subflow_check_data_avail() resets the subflow: it moves the
TCP socket to TCP_CLOSE with tcp_set_state() and sends a RST. The MPTCP
worker then has to close the subflow in __mptcp_close_subflow(), and
closing the last subflow starts a timer that moves the MPTCP socket to
TCP_CLOSE. But the worker only calls that function if the bit
MPTCP_WORK_CLOSE_SUBFLOW is set, and this reset neither sets the bit nor
schedules the worker.

The fix used here is to call subflow_sched_work_if_closed() after the
reset, which sets the bit and schedules the worker.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
and with a new Packetdrill test: data without DSS while the fallback is
not possible, here because of out-of-order data at the MPTCP level.
Without this patch, the subflow was reset, but the MPTCP socket stayed
established, with no subflow: read() returned EAGAIN and send() timed
out, for good:

  dss_drop_ooo_reset_server.pkt:30: runtime error in read call: Expected errno 107 (Transport endpoint is not connected) but got 11 (Resource temporarily unavailable)

Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Add a Fixes tag. Moved before "mptcp: continue the last mapping after
  a fallback", which makes this reset path reachable in more cases.
  Commit message: how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d23da4ac1968..7b8183b6a13e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1499,8 +1499,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		}
 
 		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
-			/* fatal protocol error, close the socket.
-			 * subflow_error_report() will introduce the appropriate barriers
+			/* fatal protocol error, reset the subflow and let the
+			 * worker close it
 			 */
 			subflow->reset_transient = 0;
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
@@ -1515,6 +1515,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				sk_eat_skb(ssk, skb);
 			mptcp_send_active_reset_reason(ssk);
 			WRITE_ONCE(subflow->data_avail, false);
+			subflow_sched_work_if_closed(msk, ssk);
 			return false;
 		}
 	}

-- 
2.55.0

