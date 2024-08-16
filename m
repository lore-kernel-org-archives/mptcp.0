Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D29817
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806135; cv=none; b=D1qV1YAEBOHgIi/po2J6ECVCmzlpsjJ1JFOSzFRO5DvIK+wMMmVFuoc7Aul3xn34Ommww2BebyFbWbeizvWmOY9fGlOsJwsOKkDRUho/9zQkTvhMwcws4RzH99ZTBvnXORwgMPg3wBjbTkSHj0Q4K3fKa+wcHnkvtfmGUh774O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806135; c=relaxed/simple;
	bh=TC7chJwOcBTrnOT0qXNaq/v7DhIU3BJFVEsML5a1Aaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8LKW2O/gDY1K6s0XB2eeEXMDKxslFXLQ9kk7vXwCHfVfg9L9mEq498+8eYdyYDa/4Q6O/Nc0XPig+oty3hHbjhIw6snoeMIXxNfK9SOhW7xky7HBz1utdJondMbSyc3A2/0/1aRb2151R/DZYe5RCM3Y0JZ3D1cFBshJMxrbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4amJU6Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4amJU6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055F6C4AF09;
	Fri, 16 Aug 2024 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806134;
	bh=TC7chJwOcBTrnOT0qXNaq/v7DhIU3BJFVEsML5a1Aaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W4amJU6ZurdJUL1DSGNjcWYwO8yZ8uIZiqNL9S6OYgrXtIBU8QajOtJAiRf2ECBvJ
	 j3NWeBt4N6oKcb3IfbAsbO/Ultr1dDBif4Sr3yHgCvZtIMXoCk2Q7tCdNjR2OMTeoc
	 rLvSWNYoFokO/8/Y3ZnXar0pSlGXTf80gFPSyrSz7ipJOALG4FLYLLuMWRZI19rx+j
	 /9yOBqGouoVrCwIIihWPafYbKeF6GfnSirxpOrDYjGre/cSqyrVwpFWkTk3MKUkq6m
	 0Vadd4b+J7Vlo3hY94xw8mjQX38u5I0hqNNU+RJS5uCBANoAPUkUtUXYO4sRSJcWWf
	 UWshBXagVn6zg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:02:00 +0200
Subject: [PATCH mptcp-net v2 06/12] mptcp: pm: do not remove already closed
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-6-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TC7chJwOcBTrnOT0qXNaq/v7DhIU3BJFVEsML5a1Aaw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGumX7z+Rfj3BAoZSnHjysH1klV9rKn2ewTh
 c84asGlmUOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c+b1D/4407KVgyoVDqf820q3RZx1Znwy2OTA+iPTUaJrlhX2WRIutAK7Fqm7uSR+8gqZFYJsQZ6
 0pFN29q+rMQZmmTJI6zgNjYVopEpsVkmCEEXMvT2OnzEnSZsVaKKb5Jq9lLoL/y8l6eiEaxBb96
 4ia3NMepSYbdnRISd2kW9Oy/T22Yj+TWOms5ixeVNfVVaheElJnxwgm4dTWanBLYSyrLO+eLoWT
 ZhLefXAyAWosjyf2DUHz74Ys6XTeuerGDoWUKX8ZDuzY+OgQ1IbVlM9eYdXiE9jQgKV2eexlLZq
 bLQLojAD7/sOGMfJ9cCQd5UcARML5nw8XKStTCn1JXhLJqLUlyDfC74VbJ4CmNNMRPeYZ1zt5k6
 EOSi1uxNEHkuziaLcDIQvQ58wzCVQXcCha+2cUNKyofb4hIqbRGmeG3VHoO+VISv/8tP1BR4fVU
 OTG2+EwPca9vhLHdxHWbUa/4YnumqJzQYVLqdJIaw0ZvWGz8dD1PHA/XB8lgz5xBiWsMJR1N8re
 jDpoafEWuAs0GqWikMDZLXzQiJHGCBz2R8k4hhhLMHxRoqFCfE/ddLDCWtXRf5KDK6mOLlhFXtC
 l/94u0z6XAXOOIL2TcRij+a95bi8uIddhM5AlyE5ZF0CIomNdMiDumGylvIjnggmE/aA0p9SBLR
 ijY2oN1gOPruhRA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is possible to have in the list already closed subflows, e.g. the
initial subflow has been already closed, but still in the list. No need
to try to close it again, and increments the related counters again.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b7173163c238..952982ebac17 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -842,6 +842,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
+			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)

-- 
2.45.2

