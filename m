Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE990221737
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590484; cv=none; b=u5kXLwF+1MS6KNU+My6e6SQF8pVkbF0hsz9kf/Eer6IZ+urKiOHlu3eKNijKTrR2lXaFl1JhbyPL1e08WAFr0ifXuOimHwyEY3HjtZVxlv5PALhGiiX12YI45tL3wWld/i6ciB/SOOqtsujrZaLOcByb094RgyFlQpaY93XUMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590484; c=relaxed/simple;
	bh=oLYSZLIl7NLmwtnxstROfILYip6EfKpPrkuWApfMS9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YmGWY97HHckfXd9vIsI5bUMLRwD1nJvP+luZR8LWPBWA1dAEieg2Yfe6rSUt38KWO9cqRnLrnJ75pC1/N0wPBoT+K6t/7CkEYciui0PVRjp8+XX73kZCnNDDiGVEGyq5AMM/gPoeXIChmxJPeFlqULKMWrddtStBS130vbbQOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSAgs+2b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSAgs+2b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 726F8C4CEEB;
	Thu,  7 Aug 2025 18:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754590483;
	bh=oLYSZLIl7NLmwtnxstROfILYip6EfKpPrkuWApfMS9Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=gSAgs+2boUDtve/PCcvT+5TryZc+zEK51gdIGvq3sICQ7lrOmUUmSay9L7m12U8bP
	 vCbOPklx//cB8e+aEJDDpktCIn/IeXIgBLuVGAEN8v653prEbEeZ/zcmA0SXXU1QNh
	 1xYCYbrNpOJgZvbSV1Cf9pdu2+xdJEPyohyMGjoTenDVVnNM0vkvBgHFIW1Kt/SFWS
	 bNjBF7wRn3MlevPJhLia6URRJjM465+g4U/VVmIuagQ69rqRnTBMpBpqSgx5u40uiS
	 +HxzEOM16tfXQpZNQx71pCNahY5Fp1iqlEmsjYOKzt0lSOpOFGwycXxj7bxJYgVJ/3
	 ZUPHI5GyudglQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB9DC87FCF;
	Thu,  7 Aug 2025 18:14:43 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Thu, 07 Aug 2025 11:14:37 -0700
Subject: [PATCH mptcp-next] mptcp: record subflows in RPS table
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-mptcp_perf-v1-1-e89cc14179cc@openai.com>
X-B4-Tracking: v=1; b=H4sIAAztlGgC/x2MWwqAIBAArxL73YLai7pKRFSutR+ZaEQg3T3xc
 2BmIgTyTAGGIoKnhwNfNoEsC9iOxe6ErBODEqoRXSVxrfF09+ZmR96gUL1UWtembVZIjfNk+M2
 /EbKHlt4bpu/7AQZ4m2lrAAAA
X-Change-ID: 20250731-b4-mptcp_perf-02912dd4f65b
To: MPTCP Upstream <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754590482; l=2520;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=FJ3ox47iJ4biHGad51VRAfWRAzrLGfltGE4gslXghQ8=;
 b=wv+rXLZfbxXWuVn+Z5RG6Yr5X/2CwyFJGbOm3Q7T21GnBH1dRLaklEBCbSjLsgVY2Swr0uRaE
 eQKOZewkOAcAeyjdgOxJC3xROIGezplcDt2blATh4r/DK1xZwT5GO3q
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

Accelerated Receive Flow Steering (aRFS) relies on sockets recording
their RX flow hash into the rps_sock_flow_table so that incoming packets
are steered to the CPU where the application runs.

With MPTCP, the application interacts with the parent MPTCP socket while
data is carried over per-subflow TCP sockets. Without recording these
subflows, aRFS cannot steer interrupts and RX processing for the flows
to the desired CPU.

Record all subflows in the RPS table by calling sock_rps_record_flow()
for each subflow at the start of mptcp_sendmsg() and mptcp_recvmsg().

It does not by itself improve throughput, but ensures that IRQ and RX
processing are directed to the right CPU, which is a
prerequisite for effective aRFS.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 net/mptcp/protocol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4b510e04724f5c8be08a00a1cc03093bcd031905..86f1fc5be47bd5f6dc8bf40a488de32f253c1beb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -12,6 +12,7 @@
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
 #include <net/aligned_data.h>
+#include <net/rps.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -1740,6 +1741,17 @@ static u32 mptcp_send_limit(const struct sock *sk)
 	return limit - not_sent;
 }
 
+static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		sock_rps_record_flow(ssk);
+	}
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1753,6 +1765,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	lock_sock(sk);
 
+	mptcp_rps_record_subflows(msk);
+
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
 		     msg->msg_flags & MSG_FASTOPEN)) {
 		int copied_syn = 0;
@@ -2131,6 +2145,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out_err;
 	}
 
+	mptcp_rps_record_subflows(msk);
+
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
 	len = min_t(size_t, len, INT_MAX);

---
base-commit: f756e5bb29fa59378c111a2401fc64e44cd53442
change-id: 20250731-b4-mptcp_perf-02912dd4f65b

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>


