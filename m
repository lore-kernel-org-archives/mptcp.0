Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799B31D39A
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494634; cv=none; b=p8usoANMlro7RrZPZpiByykI0/JMOO5AvPp4Q9Zs+nuEz4UHQkXXvuz+eVVHFn/muVm+KuJ3zJI0btyu68qBwXDiMmY1RvQ7Ksg/D80Gw7oRg3nvfzpxiSUsdSKmeMg0krJYFpC3ASVHcNpgDUQFdsQfSgxI88VRVajmx1u4SuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494634; c=relaxed/simple;
	bh=YXQ+CwIoJ9h5qstPz2KMyddL8vl2xQ2lQH4Wjo+XiZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBL0ZqmTE9bkMKYaFyUlDCySg3B8YQvPXevYUKGxLoqtp1HNbkpB2uc9ZOnMqnAQZS89dGE4I6yKX1zpJDHFi8ugjBwy482XRiTTT911Akdy5LATdAGlAxsR3/RotJxm5GR3NPgbZ/zyZfPDBnqNN1Nbwb8+sl/y9L+bqJeJn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrXOwNwz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrXOwNwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19E6C4CEF5;
	Wed, 10 Sep 2025 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757494634;
	bh=YXQ+CwIoJ9h5qstPz2KMyddL8vl2xQ2lQH4Wjo+XiZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MrXOwNwziGJ1IUIXezcwVW38gVdPbNtRTqWbOsvC7SsNzjfXWNkLc2jbOL8eBaHy6
	 ZCBO5moV9ItQmLt8KHdy6QnyhXZu+WPiDaE6URE5hFPacjYDNsUCUwLGNs4B5sGLK1
	 q4RWyc2Tz4BoPce0UlRrXiKEMjTDk8BTpJFBT+bZiwi0R2HAbi6c6tVjefSSdmtLS4
	 icqna7Bj7sHUStyGsiuHfzAorwxEWSyfrMF8dSQkk4DmSoPniHJj/IoPBOAFCbxuDn
	 qfQMSseVTvTxZRDQoN3sxqr/tG36iEI4SgG39u1PcAGPWUITDP0FbOmno/KPd24KRO
	 VRhT6w8c/XriQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 10 Sep 2025 10:55:47 +0200
Subject: [PATCH mptcp-net v3 1/5] mptcp: propagate shutdown to subflows
 when possible
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-sft-mptcp-disc-err-v3-1-6799fa467d77@kernel.org>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2364; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YXQ+CwIoJ9h5qstPz2KMyddL8vl2xQ2lQH4Wjo+XiZc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIO2qZoBRjqvdN65nXroMhZhmX6P04UHzBoWBvtEK6z4
 DXXD69rHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZncjwPzbHMW5JhtWx1FLv
 S0r1IbPNLOIj/29+8Ga5pv/U/n+LTjIynN0WIHUs8FQ9X5353vofJrqV7gWd+VkWBkaTjgRPe1b
 ADAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the MPTCP DATA FIN have been ACKed, there is no more MPTCP related
metadata to exchange, and all subflows can be safely shutdown.

Before this patch, the subflows were actually terminated at 'close()'
time. That's certainly fine most of the time, but not when the userspace
'shutdown()' a connection, without close()ing it. When doing so, the
subflows were staying in LAST_ACK state on one side -- and consequently
in FIN_WAIT2 on the other side -- until the 'close()' of the MPTCP
socket.

Now, when the DATA FIN have been ACKed, all subflows are shutdown. A
consequence of this is that the TCP 'FIN' flag can be set earlier now,
but the end result is the same. This affects the packetdrill tests
looking at the end of the MPTCP connections, but for a good reason.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Fixes: 16a9a9da1723 ("mptcp: Add helper to process acks of DATA_FIN")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c26acf6c4145896ecbb5c7f7004121c66a20649..9feb9f437c2bdfff392249e7ad00edd09ba67ac3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -372,6 +372,20 @@ static void mptcp_close_wake_up(struct sock *sk)
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 }
 
+static void mptcp_shutdown_subflows(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 /* called under the msk socket lock */
 static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
@@ -396,6 +410,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
+			mptcp_shutdown_subflows(msk);
 			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		}
@@ -564,6 +579,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 			mptcp_set_state(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
+			mptcp_shutdown_subflows(msk);
 			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		default:

-- 
2.51.0

