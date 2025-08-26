Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D728D8D1
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756182641; cv=none; b=isdjN66o72N60p+pq96W8Ztki4gF4cDRtMH6kNfTN4kqsQvE7X3g0QsmKokcL4DO9KYwIh0f3aPQWnqBQ1aNsbf5xnbFC5h1iFrilEx/t5Ah3hJhy5xhhKXP3spxZruro8tgKmV6P1HAQ0nxPyK+X4F/hxO0cnPb7tgutO4EtVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756182641; c=relaxed/simple;
	bh=pKlX/7E11pRLcJePdJRgCMajmPU1l2Iq9GcHRKQl8eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tp/vx4dDEqCIceMDfqqaTj8Cbtt/tue1numlYqfw4wDyK3WDXTtjpPMd+XfNSqR1KHnxk0FxUZ16IoyJfCTx4iVb7yVy3tFj3lHK16C3urwazcp2nXTZjdILamaCaWEBHfC1JPvjkQjKlPMALX94/kpf5hKWRLPDD99rT1Mot2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn3ZFmd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn3ZFmd7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22EA5C116D0;
	Tue, 26 Aug 2025 04:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756182641;
	bh=pKlX/7E11pRLcJePdJRgCMajmPU1l2Iq9GcHRKQl8eM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tn3ZFmd75yYvgE7A+RiGDs+kUjGWGe3hoKPNWplIyPNHCn81JJZNHGDg0ZrEmxPO6
	 3O+jw7udkzAy71nqviNg35azy4giUeTrlqpcR43EdKa5gLwzhNdSkGH/7dozEUxjb6
	 qaZc4TJx4ldfh8q8wHlFh76YKlIJCCXmG602HLC2A6qMhpy8/K2Rzvr1DzksenjiRP
	 wLybIGXw6iDWDzMe76WmJob5CsOXuGeJdEMd4IG7kVAVgs1jfWAhCxLfVn/1FFbCFY
	 akGzbHkfw+AomblWIrwmpljdXustswAuZwZkOvoBVq4dTz0qlQtUDyoY0Bz0ahlka3
	 g1iYoRJO/7IWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2CBCA0FF6;
	Tue, 26 Aug 2025 04:30:41 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Mon, 25 Aug 2025 21:30:36 -0700
Subject: [PATCH mptcp-next v2 2/2] mptcp: record subflows in RPS table
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-b4-mptcp_perf-v2-2-5d2d68dfa8af@openai.com>
References: <20250825-b4-mptcp_perf-v2-0-5d2d68dfa8af@openai.com>
In-Reply-To: <20250825-b4-mptcp_perf-v2-0-5d2d68dfa8af@openai.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756182640; l=2802;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=EJDbbksEFb3idphcuBVUNxNVnpEhd5gHKPEhq+R1c7o=;
 b=9mVN1MqwAAvWHrWjMkN2EyUuY1L99cQ29Kty3mn36f41cWguEOPANLKNW0dykVeD2mkcJN6Ic
 VR10yJgWlUeASXt9vcgc04Cx40QG2OzstGDX6hZMmYWtnGzICaDNw+M
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
for each subflow at the start of mptcp_sendmsg(), mptcp_recvmsg() and
mptcp_stream_accept(), by using the new helper
mptcp_rps_record_subflows().

It does not by itself improve throughput, but ensures that IRQ and RX
processing are directed to the right CPU, which is a
prerequisite for effective aRFS.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 net/mptcp/protocol.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4b510e04724f5c8be08a00a1cc03093bcd031905..543506b6a011af78208381857ab9c1962cbc6636 100644
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
@@ -1740,6 +1741,20 @@ static u32 mptcp_send_limit(const struct sock *sk)
 	return limit - not_sent;
 }
 
+static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (!rfs_is_needed())
+		return;
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
@@ -1753,6 +1768,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	lock_sock(sk);
 
+	mptcp_rps_record_subflows(msk);
+
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
 		     msg->msg_flags & MSG_FASTOPEN)) {
 		int copied_syn = 0;
@@ -2131,6 +2148,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out_err;
 	}
 
+	mptcp_rps_record_subflows(msk);
+
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
 	len = min_t(size_t, len, INT_MAX);
@@ -3921,6 +3940,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 				mptcp_sock_graft(ssk, newsock);
 		}
 
+		mptcp_rps_record_subflows(msk);
+
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.
 		 */

-- 
2.50.1


