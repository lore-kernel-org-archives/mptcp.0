Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105D33F8A4
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876048; cv=none; b=Xxylvv8bTKM+wik/mfC2/bKFS5ZZM30xXaPJ+oJ8GzZF+RSC2418I1zAhuLd3IS8F6y9FLBXAT0I/Hme2u46qI6J35VQomUPG0BGM9a2cuV7NoiFOwhA99wkyD6rX41h/loNPB/+B3uf76wOCPaXAE3X5Rd73FL3d7j9kV653RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876048; c=relaxed/simple;
	bh=raxpXv46g7sbLlroVfKf6RTRy4aOVTAkmVXViKNSRJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cc+5Wyhe+g1GpQAyWb0vT+adetRZyOFLU/AkXroQK1svA1co81pjXmZ5BPmTWK69+C81Z11qPeqJEhOgirbb/M8AjvXuJVM36Ajy/c60TpfKy/s1F5ji1aHY9FvFhGBCxzoFUYUhLPYoc0OOrZrX9/YocAgf1/s3XeQSJUEWevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQlZ66bn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQlZ66bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E49AC2BCB7;
	Wed, 22 Apr 2026 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876047;
	bh=raxpXv46g7sbLlroVfKf6RTRy4aOVTAkmVXViKNSRJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jQlZ66bnvQTiNyipueB6BBQZVyzqRLcD0A2EtIFK6pYY+kBvKe+ovSM5SJ5hMFrhH
	 dmsJguVWHZ1Tk0JV07TDkt0h4ZzrEmR11ZMErSyL5LvLyMqSZZdI6ee5smBWfW0WGR
	 HJ4i2UyreGlX6TsuPlzF0XvL9oXtq7lUVwv8+0kW28419d6GR8d0FoZf1+j2uQlclU
	 oWnTBiOWp/MMQO0V83dbKRYvPtjA0xk4aS0Dlq0hmacrum+DG6ZXwEuKYqFaom+r6g
	 4AeQ7chuRI4pY3c1APzQeY1tBQihjPSKy1pyIoBFLQoufQ06Sn+X0Vikr2SDzQG8Wh
	 YzRgwB2g3XRgA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:22 +0200
Subject: [PATCH mptcp-net v6 08/19] mptcp: pm: retrans ADD_ADDR: return
 early if no retrans
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-8-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=raxpXv46g7sbLlroVfKf6RTRy4aOVTAkmVXViKNSRJM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/GLY1G4Y4yF5oUo4sMV7AcP5IxacLfNq9O7KHU6do
 7vCSj2+o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKS7xj+yr+e/Zp57j7bp9Uf
 0vod8iIPHLBfZVN98Jt3E/On+QaqXxn+17yblfLWsJp9cbXcFovupX3xFXa+PCFl5w64ftohJnq
 ZAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to iterate over all subflows if there is no retransmission
needed.

Exit early in this case then.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 94a8207e51e9..a75889f3dac7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -308,6 +308,9 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	unsigned int max = 0, max_stale = 0;
 
+	if (!rto)
+		return 0;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);

-- 
2.53.0

