Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7E17C91
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004141; cv=none; b=dvrXMcdy/gXZEOeJI/SPlyOBsJA+VUnOOSXRW2yRLn58WEz0Fse/GHe8E9iwZOpJOG8Rb6bmNSvWKQXGN6KwzGPUTciNarAQ0r9s8l2DJLvlhJuC5IB3q2gP5ndWLddxUReDZbiYc6zIoZrJLisqYO/qBYLhq2TUJsTPQSuUKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004141; c=relaxed/simple;
	bh=53JW3RoFcd4yDZHUyulcX/HSTib4DOjuXZ2Hoe7xl0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+TrKZ71j8/Z4gYYidZgTg6znWYGdHFii/FjCZi5tGxFduH8HZZwoG9IQWPZs8bAgPY3V4DAoXS3bBxvlgXav9EIRyKK8YcouPjLnxfq+DA7oP8wy+LDNpkqd7FE8PaxbGUCZA0qZ0Cf3IWbiUo44buWnqJrBrFIhGADsPi33CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyA6zxlx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyA6zxlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F97C4AF09;
	Fri, 26 Jul 2024 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004140;
	bh=53JW3RoFcd4yDZHUyulcX/HSTib4DOjuXZ2Hoe7xl0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AyA6zxlxxr/SMe/CSHzurSL+nTSmy22zi4weHUZVtVbpkziw2+CdR4I/eogJPp6Wa
	 QrXNeF6ZccsUv6I5PYoOIKdpSVmglxRjxcuSm230Bnj73WEmXnlkZtZ7s8kkT8aIFN
	 PQpLjazqNlgrqCvl1SATIvtPVmhT+DwFnWoalL/oJu5M/DaPg+Dm1jIoyWA/+uN+1d
	 BCJ3OzxPRIqc9TVYgDh9Xg/jxMU5WvuE22MaMt3K05QFejxbO/ohV9k67ic8IBNPWC
	 vzdwLI5q7mBpXC/0rR0QBBiCL49iDkoJafq5UjKPre6ZYEslBtqPuLlcGRRM2hBIVJ
	 1wB4FRlpMVNzA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:37 +0200
Subject: [PATCH mptcp-net v5 11/13] mptcp: pm: reuse ID 0 after delete and
 re-add
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-11-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=53JW3RoFcd4yDZHUyulcX/HSTib4DOjuXZ2Hoe7xl0A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KcIMoh/rpn8k0MwK2Ap2KvK8oPDs62ngOVU
 Dzp448L7dyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 cwXiEADm0qfbV7tRv+8HNDAWPmgY5VURHsaDvh0pz/waKpCzEgIDpu3/8MBpd5rPLDqXYqqnNzA
 PCZRdAYgpEpuywqQK0qui7D43Bw3h6i6zXbihlObpbZAmVh4LTjQw9NhTMXg6UqJqJ2RWIsXC9Q
 7cB7f+zppB3qoyP1Hf3EPHzAp5NZud1leoNXBW4IVP6Katx543PmWXF4qZUYPbd1d37cYQgau20
 j7H0axDziUtK/smJ5/iJDrFwML43cSrH44BFxfgqZSGzqXFrCi06K9hgi/rHIurGtf544HN++/v
 4mVt5n6NZkuAMR4zkBH5qjvKs3T5g0Kc1HyimI2R1wQRIoXAFcXmHvajHIhck78izVaGBilWmg+
 UaLcDDDDCZDnfVhoBw23BdpGbNQV1onOgymiDvVK+zrMdYfbYkyEQyV3wQInYdukiycotkkB+mo
 73pPUOrPRu14oYvNGzUDNz4EPjqnOcmfLtMhrCf5gq2Wpt3Wfq4ASlb8KAzAN5l1fAo8vaCPjqR
 yPVBcyq45rgCM5oy5LZNnCGcczoaZhJgNmwnskPhcUYMbeaKUPEuIwDtST9M0qZr18D0xCUxs1R
 Xpj39rgSf+wPwQCej1Omv+vzFaOl7poHiSZidTJ81oxxWxCFcN+7ff86+1vd1aOHh/Tw6XcYzXs
 XkxdjPg34CYXoxA==
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
Notes:
  - v5:
    - Add missing 'ID' in comment (Mat)
---
 net/mptcp/pm_netlink.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0dacf16a4b53..36e179f1f888 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -585,6 +585,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
@@ -613,6 +618,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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

