Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9D79C2
	for <mptcp@lists.linux.dev>; Wed, 20 Dec 2023 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rImyGfo5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703038153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LpL09mwuFyPdpkVkbo2KkfSfX+OHNFhvm1G+wdEAwE=;
	b=rImyGfo5r5TdTGmXSF/PbdL7ADVWMUHrtWU6VCK/ilEmyEXMPwjNZCzMwUwXCTloh4hepQ
	qg67zNKb8QHW1NVLE/Ol6Pi3qF2ls0iOh9+UhjhvxV8GdXfyZJJDzZ5eQI1wsrcRUC/fR3
	OQtswpQbtqz4mEJX6lFygA8xiRp0kxo=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v3 1/2] Squash to "mptcp: use mptcp_set_state"
Date: Wed, 20 Dec 2023 10:08:16 +0800
Message-Id: <e64c4d985eee49763c14b53c9ea30d3affec471e.1703036129.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703036129.git.geliang.tang@linux.dev>
References: <cover.1703036129.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Update the comment.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b93683b5e618..661c226dad18 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1048,8 +1048,10 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
-	/* avoid replacing inet_sk_state_store with mptcp_set_state here, as the
-	 * old status is known to be TCP_CLOSE, hence will not affect the count.
+	/* We don't use mptcp_set_state() here because it needs to be called
+	 * under the msk socket lock. For the moment, that will not bring
+	 * anything more than only calling inet_sk_state_store(), because the
+	 * old status is known (TCP_CLOSE).
 	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
 	lock_sock(ssk);
-- 
2.35.3

