Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D333F8A4
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876047; cv=none; b=Fl+zVgTJ9AG5VZ3Spd+ryrHgCVsuB/0ueVT75NnFWUhFfPQANyn+hZ7bryOfK74CnnlRZAgnKOijeFN7CYcWDFbb872oqGssLAzqWFpggZPDjf/jjxDsImrtcNvVeWQx/rMR/q89917sqosnnYkji1QocXnWB9Vy0eXqvjY1pkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876047; c=relaxed/simple;
	bh=yS+WHxqbP/ZUNVAFxnK75Z9fZRdTlzuHRSWo9CdKbsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V8gEWwYaZRsqSkqhZRItnEXJyzGv6EEsFqi9kYf+zPbWTWfm1hQnzBTR92GMXfaoDwg+pof25qJrQF/4RNQx+o2dRRvzatma3hzkdEME30IIrAc/0CJPLzMOAymMuH0vn2zGsaxE9iRu3E3X9+EGKkxAgdho7/KEaAkyZdfIWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn3QTPBz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn3QTPBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D2EC19425;
	Wed, 22 Apr 2026 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876047;
	bh=yS+WHxqbP/ZUNVAFxnK75Z9fZRdTlzuHRSWo9CdKbsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mn3QTPBz1Nul5ukfzBMKivb8IBd++eYZ8UaAnyB8u7RZs5pZwkUdpTV6Rv3KTQvy7
	 AAe9ZkEqUTjfywSmVM70HLM/MIcbZDl7aPcpilNiJ/6+br+Y4DQRgjrrJ585IKFEBo
	 +8N2VUSHGQ0nOFGSNAhspFzb55KAuozIbXNHZBMNe6rMqAOAG9cxox0A36P+79wzTg
	 +mMmzJGlXMlzfjPxwvlI0tp1f0i/pkO3n1/l6RHla/y5khvkhOV6/U/r+tqo5WHVyP
	 vCrLjoXDRoHZn9w0sW+HEyFmK+7rPXI90OfFOn+y7c7UFd5IPt4BqlQEcRVUikuZ2E
	 8JaLwoYM05eTA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:21 +0200
Subject: [PATCH mptcp-net v6 07/19] mptcp: pm: ADD_ADDR rtx: skip inactive
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-7-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yS+WHxqbP/ZUNVAFxnK75Z9fZRdTlzuHRSWo9CdKbsI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/PzP+H2n4arHT15+KH2SeG/GeuXDG6dt8dz0/+Gps
 jilF4l+gh2lLAxiXAyyYoos0m2R+TOfV/GWePlZwMxhZQIZwsDFKQATaUlk+MP/dlEUa3DYgzyD
 ol+r+6w1T2+IeXz/8cHriu/U9GeyWF9jZFj9MrvO5vCKN90Rv6SemVzv6o5YOa/WVd5xn9vXWp2
 zVlwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the maximum RTO amongst the subflows, inactive subflows
were taken into account: that includes stale ones, and the initial one
if it has been already been closed.

Unusable subflows are now simply skipped. Stale ones are used as an
alternative: if there are only stale ones, to take their maximum RTO and
avoid to eventually fallback to net.mptcp.add_addr_timeout, which is set
to 2 minutes by default.

Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout adaptive")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: restore accidentally deleted icsk->icsk_rto > max check
v6: use min() (Mat)
---
 net/mptcp/pm.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bc5168831085..94a8207e51e9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -306,18 +306,28 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	const struct net *net = sock_net((struct sock *)msk);
 	unsigned int rto = mptcp_get_add_addr_timeout(net);
 	struct mptcp_subflow_context *subflow;
-	unsigned int max = 0;
+	unsigned int max = 0, max_stale = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);
 
-		if (icsk->icsk_rto > max)
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
+		if (unlikely(subflow->stale)) {
+			if (icsk->icsk_rto > max_stale)
+				max_stale = icsk->icsk_rto;
+		} else if (icsk->icsk_rto > max) {
 			max = icsk->icsk_rto;
+		}
 	}
 
-	if (max && max < rto)
-		rto = max;
+	if (max)
+		return min(max, rto);
+
+	if (max_stale)
+		return min(max_stale, rto);
 
 	return rto;
 }

-- 
2.53.0

