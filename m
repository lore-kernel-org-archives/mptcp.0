Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F24219EB;
	Fri,  1 May 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664182; cv=none; b=ovII98ODTMG8sdX+367YzuCrWx8St1EFOBONLnFqHEkxr2VUK3tdltcKRKPFn1hWX08LswLihVfMor/8vf6eej4AzFuNSseHrU1SosMyA+P7uvcaGMn7YTPo/h2pDAqZmw4OvK2FOo8vo+8D6rAhnLwEcPy+/FauUYiWi6SFvJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664182; c=relaxed/simple;
	bh=YH7r1TqDwBvSYseUZJ6Hz6O11d1VtypwRVryXcDfqxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPvptolaVCZHmSYqXXkrSvrnRykBgTnkuF42ICQh1iyDDQx8ktI6axkE089Y4fFXcdskmWU+aAdShUAYKjG9k5hOb6eI8gIeYkViIKukhLIvcWOjrLXMT7G2ew+KVo2LdWFCTWBXEu6piP8MchjyEcllf6TBmwSwoPF6Oal56Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvGlhk2A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvGlhk2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BA7C2BCC6;
	Fri,  1 May 2026 19:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777664182;
	bh=YH7r1TqDwBvSYseUZJ6Hz6O11d1VtypwRVryXcDfqxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BvGlhk2A7v1NrdA/ly4N2ArUC26zOsrnF9oD8LZv7QIG85CQjFKPbJfbgJAtTdctG
	 wkL1E2q5zvmmvCGzoh9OOuK1+zcTIylDkVQCXLLvMdbNURtpfI4xsPSc0NesAcD/n4
	 J1bgV9HFHVauSGIv6YzURK1/Mo1PvJE1UqKMw/rEMxpT6aBezVa2bF9/hw7Dkwfwke
	 PvbKnxUCsI5nRkFUOphwKeg4SVsnCvuSmgLSB4QoGQ35Z7aqUWqqG34OcHDoT2CnVR
	 6XGxj//6LbiUMj036RRxpYcLuoX9JEWXMqQQgFcxwYBMuQS/T4D1ADYZG3FMxVqaM4
	 LY0auJIwhBZQQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 May 2026 21:35:37 +0200
Subject: [PATCH net 4/4] mptcp: sockopt: increase seq in
 mptcp_setsockopt_all_sf
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-4-b70118df778e@kernel.org>
References: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
In-Reply-To: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Gang Yan <yangang@kylinos.cn>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YH7r1TqDwBvSYseUZJ6Hz6O11d1VtypwRVryXcDfqxA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/Mqw47dMt4V6VUuPmEBG+ZdencNcmabattx98Xqnqc
 Lz59tvFHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNRV2X4n/uFMd34zorfzUe0
 +E98q+JQ0BB/LPxe+hP35e3m6ayCRxj+l6ROs/myLsgoL+3qzi0VFnwiC1fr1f9bs2xm3dO+V/H
 9vAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_setsockopt_all_sf() was missing a call to sockopt_seq_inc(). This
is required not to cause missing synchronization for newer subflows
created later on.

This helper is called each time a socket option is set on subflows, and
future ones will need to inherit this option after their creation.

Fixes: 51c5fd09e1b4 ("mptcp: add TCP_MAXSEG sockopt support")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 0efe40be2fde..1cf608e7357b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -812,6 +812,10 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 		if (ret)
 			break;
 	}
+
+	if (!ret)
+		sockopt_seq_inc(msk);
+
 	return ret;
 }
 

-- 
2.53.0

