Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B133AD9A
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964724; cv=none; b=VT+sKhXF8691fd9pEH/NQthSgAFBlbsUV9b88lbDml+Yv/PQEXx2Zz2S6Sd5yzOgJVT8xnmHi5plb23h42XUmSHEluWMfe+JbwXS/EF0qlNac4SjxYglnpQoOsDVvumUg3AxDpLvNlI28Cjos+wukwgLTfk5GpKp1f+cDcoBr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964724; c=relaxed/simple;
	bh=bOQsq2XrOhtU0EBb/p1+2MsayISWWKNP/oCn0/irc+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCfU3PQ8IdX7F44dIVKDFej44hgVWNd9tz6gNwUCHCrmAAfIIt43K3AKx/OOR/k1gn8FmmalbhrVLc52LMNWcawGDqEbAzh/tmz802HMwfOJztjUaV8H2NUXZHZ7EuXYqOCnh30QPbj2vxXQa1KuyWjgTrTzU9Iaec153v8kgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdiAEzit; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdiAEzit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA8CC19422;
	Wed, 12 Nov 2025 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964724;
	bh=bOQsq2XrOhtU0EBb/p1+2MsayISWWKNP/oCn0/irc+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FdiAEzit1vc4SEfPsRJhkuFalgcOU1gT38qJ9uSHDZn8eY5XRs0FErM256qDmrYX/
	 9PJBX/VpQP/NUwqAS8HoeqM8E344gfM71Pt6vueFlwmvIeQwGJ0QufxdCUdKnVxFAC
	 o/rOmdKUCMu1DFMthR66Dovr/789llY7Vcq7aAUqySht3QkIMKvdwvRBFqSiLpQc+A
	 5pjjVCMkZKGzFpzH3w4iZYOWmO2oqqxP+rJm/3SNSCkh5430B1RMYVICd/UKsDHrcj
	 vDE0MKfCCEp3Bk98bNV03hECzdBPbHPNcvQhqvWKet7hU4pegU2YIZyaNtK0w/DgTi
	 IzmiIbFy+0oHw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Nov 2025 17:24:48 +0100
Subject: [PATCH iproute-mptcp 5/6] mptcp: monitor: add 'deny join id0' info
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-laminar-v1-5-e23dbf584aa4@kernel.org>
References: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
In-Reply-To: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bOQsq2XrOhtU0EBb/p1+2MsayISWWKNP/oCn0/irc+4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJFtrw1mrq5tdziZ7Cq4rz1tVvnZryoPRs1M2RZX/irB
 35Hj2e+7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI5wyGvzK3Jba43BCLz/8c
 /3ZxrLTvqWunt+RN5z4/SyJxSjSjszcjwwf1lXvudWrsYo30cudJ/19oeeBCbuGMeSYfz0y5Nmv
 peXYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Until recently, the 'flags' attribute was not used. This has recently
been changed with the introduction of the 'deny_join_id0' flag [1].

This flag is set when a connection is created and the other peer set the
'C' flag in the MP_CAPABLE packets [2]. This flag can be set to tell the
other side that the peer will not accept extra subflows requests sent to
its initial IP address and port: typically set by a server behind a
legacy Layer 4 load balancer.

Now, when this flag is set, "deny_join_id0" will be printed instead of
"flags=1". Unknown remaining flags will be printed in hexadecimal at the
end, e.g. "flags=0x2".

Link: https://git.kernel.org/torvalds/c/2293c57484ae [1]
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-20.6 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index aaacc0a5..01f6906f 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -477,6 +477,7 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	const struct genlmsghdr *ghdr = NLMSG_DATA(n);
 	struct rtattr *tb[MPTCP_ATTR_MAX + 1];
 	int len = n->nlmsg_len;
+	__u16 flags = 0;
 
 	len -= NLMSG_LENGTH(GENL_HDRLEN);
 	if (len < 0)
@@ -526,8 +527,6 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 		printf(" backup=%u", rta_getattr_u8(tb[MPTCP_ATTR_BACKUP]));
 	if (tb[MPTCP_ATTR_ERROR])
 		printf(" error=%u", rta_getattr_u8(tb[MPTCP_ATTR_ERROR]));
-	if (tb[MPTCP_ATTR_FLAGS])
-		printf(" flags=%x", rta_getattr_u16(tb[MPTCP_ATTR_FLAGS]));
 	if (tb[MPTCP_ATTR_TIMEOUT])
 		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
 	if (tb[MPTCP_ATTR_IF_IDX])
@@ -539,6 +538,15 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	if (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))
 		printf(" server_side");
 
+	if (tb[MPTCP_ATTR_FLAGS])
+		flags = rta_getattr_u16(tb[MPTCP_ATTR_FLAGS]);
+	if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0) {
+		flags &= ~MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;
+		printf(" deny_join_id0");
+	}
+	if (flags) /* remaining bits */
+		printf(" flags=0x%x", flags);
+
 	puts("");
 out:
 	fflush(stdout);

-- 
2.51.0

