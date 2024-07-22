Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC021171640
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676978; cv=none; b=blXuog9TRGSnGPO4I8RddxYxyowr58Y2bTrojL3WgyDfVDU6NDMZ4rkRJSe5QkEvZWSZWcMifhquiSktt6+ipPqUQBYUJHJKYeml+Kchi5TqtkWIk7lj/Hjgz0Il2thN3cPbyTFlOSo0h8/aiP0V6B/ceK2gdL54RsNXBNgT9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676978; c=relaxed/simple;
	bh=X8bl3fhBszP9BOCL47xtWzAYFgdUJpGalnzJDNqrsyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6mNbiCUelOggt25DYPOTPUwV16Lh0BdnYmqw6xiskjwZG8xz1UCHZyTfL3A0Ysw+psZDgF+PKNcKPZ/ou2nwp5X8NM1Fv14O/ayaG+bBjH+Mq5qvFqbBHHjuepG5en2Wnk1SyTtTp6K3+PANTCTCDfd8I9czZGy9cfQin5SfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzociE6P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzociE6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A7BC4AF0B;
	Mon, 22 Jul 2024 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676977;
	bh=X8bl3fhBszP9BOCL47xtWzAYFgdUJpGalnzJDNqrsyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gzociE6PosLT9hxu0VlKCtxKzk4UkVj0aN4yvKJBqRhH1UU+tQZfs96XJ3wcFPo77
	 tbRcD/UoTcMCSU+XoUluBZyfTiL38fW/jMArCDJZ4j2Yrsq49/DqJww54EWjMS+FJV
	 m6uMdmzKbKJYr4H8UJXcsHZkJWYw7Ha041hS1LI8xDu+IoQrb/H+h94w4kZQqglOIg
	 0JppuPDxg7p4ifdME95ADrQdirX56qIludtCNBAjSLjTq+KVIkwkMYxIrnuhkR8b4V
	 vDHPu7VLAhGIh0TkK0gEB2pBbXJzLeHlCup/tZB1m0+dPiFn1udIIgKwo8+bnlyQST
	 SDvNAasMhiypA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:36:00 +0200
Subject: [PATCH mptcp-net v4 22/23] mptcp: pm: reuse ID 0 after delete and
 re-add
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-22-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=X8bl3fhBszP9BOCL47xtWzAYFgdUJpGalnzJDNqrsyI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSXLEdxbovDX62BdiQgLO7DMCEykJu0AD+dT
 Wq8b6m0dneJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lwAKCRD2t4JPQmmg
 c0o5EADJnA2xmMYb3vIdqFgH9jHRm1clIhlXCxWvLgE2uBMY+jwKIBtiiFFId4LO9V0g9ox3LSt
 GN1uyxXWg5X0TG70yfRdhwwHDqzbnlt1WEr3MRxlLyEbahyPSwPTsFnXCGkrOcAA58BDl6Q6z1v
 Q/q8UiAHuxzfi9cVB5SOJUCEMkClZQIKTuur1Pjstu/ceufPtssf95QbpG+SsYZd7UcT9QAQOtY
 gQ5iL3VENtRmKEK06SB2jvYVqJ0u6cHLzIa36ErDhGRNZF98Z+XpdP2qKbA6PMDygk1Jf669rM4
 b/9Nr83e2ZL4GhQD9Mf7+qx3Nc0ykJrNawRscovsdAPQHLKO3SEkFF9a5tq+RHO4/zLrV73Y3TR
 crkSskZy1J01a+CBsGuWVuN4PivEMMWA4QdGLuMwMgaiAQDTgljAp0uSuL4Z1WecLiJMm/4LiSa
 oTjMhePvMT3RiGSgza1MVJIU7Mqr3Wzv0Uh/2SAhRujKIV0hKeGy6CL0d/FjBplABwQkNpMMwhr
 ZCkua7LgHz3CdBQtynwpYJQx8tx3KqYjIFgDTTS9OKe4JAfjG/zUoldIe1Irl+LBhwjiLchaenu
 os30/GBbX+jpgBdbPzBXTQ8ibkGuswhRCNOXJahgG+5MEgCRH5i+luue3WJ0TpO8peJ+YVARB97
 kl37+FIGYkwGpmQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the endpoint used by the initial subflow is removed and re-added
later, the PM has to force the ID 0, it is a special case imposed by the
MPTCP specs.

Note that the endpoint should then need to be re-added reusing the same
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8f25690a5edc..45a1aa0a40bf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -586,6 +586,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
+
+		/* Special case for ID0: set the correct */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
@@ -614,6 +619,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (nr == 0)
 			continue;
 
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
 			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);

-- 
2.45.2

