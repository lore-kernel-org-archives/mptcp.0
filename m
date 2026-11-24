Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557684;
	b=WWyrisw8FWtzZ4GdEXnlD+0kCK3Qa+yNZDV+ebRLPMhXgXwMEhJAA2K9GKN1MtTb0brG
	 MrCTaAc7I58tt801JaD7jCxykmzJhggFGICkQybYp6f4cnhxj2WQ1ymjyoBjuZ6yLBE6m
	 C669KM4fGzK3oeK1IIEm2Droe4mU/tcj0durG4o91KGMTLNoKUkOa/HPEonGRV6JikM0b
	 hmn+QEYDD0TwWdqPi6CQTSlkhEPjkK3BgtA0RAY5/IZBcdqiM61MxRrLYCSN66VyGsZxJ
	 Ub1Kcp97y0oRPcOcplfMK045kU5YgAd5BWogkxgXwjxHXNEkpeDtqmC6ctFFzscGvRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557684;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ACdOpzli2hAJck7wLWoXpCFORkP8HXDrXOSuZKiRKb4=;
	b=a0e3aPHRvJVsSzxeYNp/cYlxMTa6DorA1gHfCs7VqOki8VHDzRTZc9FotJsxna1Oh/tI
	 CJwOB3RFKXCECuKCGm/JngfL7QX9ttbxoYiC0FowdOT3uzh6qcVkmzL9cH4lGIHTue5rD
	 3wDUtxOdeHdCiVfDFVKpj1dF+oA2m3/OAiRKtI9q4WyS7sDaT+U1+W9E/dWNrFQq2aqI7
	 JDFWQH8Yyxbdg8p40jSgO94CExzAP9aUk1DwHegiv8x7f5/ZkuZdR5QeyQKaHkZlnjXeb
	 RnniYjxUTMoos45iMMAktJb6U1uxtpr8ptLW9dE46PP6+W2Wdy7IvA8U0OTM4SZPOWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjO2VYgw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C3606A327
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjO2VYgw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BCA1F000CA;
	Tue, 24 Nov 2026 22:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557684;
	bh=ACdOpzli2hAJck7wLWoXpCFORkP8HXDrXOSuZKiRKb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NjO2VYgwUfnv636Q2w+F69b3OGUhN/pShWoTKqYk6xtti2Qn42/zp3Qhs20sauNZj
	 eEjxaLG/bMObaE4ecjcyqNgQFiKoUTKzzHmLHZCtu7rdSLAh4L/eOqclLEQjgjA0Qe
	 7dZMYVyEsXRcOrXLnWjzP3Ya0dlerxn1mP/CnydyImqwqO//iT1UrZPnvvjpTX98Se
	 duPbk8DRxR8NAyVjayeQHJRMbWdYddWcT/8tdAS6WrsZgoxgEQeQ49Xl8MBp3lGSrx
	 pqVWMbC+lFTfsISpLhXh4tgXMmCdAEF2U9v8dPhCHPDAINg3oxvxoKzNa6CJQ1WiG+
	 w/s9fRAEPRuUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:39 +0100
Subject: [PATCH mptcp-net v3 22/50] mptcp: close a subflow reset for a bad
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-22-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3LxmFeGM2amj88vfcrVoUccXI2tbsiD/vhieWyNYcKE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOFm2F1xzVrn5I5yNkX9tjanX7bNGwbKNCoyiRtOq/
 H7+aN7YUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJG3Pxn+GenHsvycbfvV/ffE
 4N32bZsqd8T/37rz42SLa+cOiDguE2f4xaTLzS/m8SN4xvdVmbcEJqqyXfy26gGritW1+EyhwMo
 yNgA=
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
reset, which sets the bit and schedules the worker. This also covers
the reset done after a bad checksum, when MP_FAIL cannot be used.

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
v2: commit msg: the reset after a bad checksum too (Sashiko)
---
 net/mptcp/subflow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 91698d154c40..a216d88d35ee 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1505,8 +1505,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		}
 
 		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
-			/* fatal protocol error, close the socket.
-			 * subflow_error_report() will introduce the appropriate barriers
+			/* fatal protocol error, reset the subflow and let the
+			 * worker close it
 			 */
 			subflow->reset_transient = 0;
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
@@ -1521,6 +1521,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				sk_eat_skb(ssk, skb);
 			mptcp_send_active_reset_reason(ssk);
 			WRITE_ONCE(subflow->data_avail, false);
+			subflow_sched_work_if_closed(msk, ssk);
 			return false;
 		}
 	}

-- 
2.55.0

