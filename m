Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F72BB04
	for <mptcp@lists.linux.dev>; Mon,  1 Jul 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857811; cv=none; b=tS/4aAA292Osn8LfDdnexvVmMX/XBGEUFj5Otz1nbC5x3qjSigadPg2KuF1TYShgBciuwUGMq4X4Ndg+Y7avz7/jlVrRApbm9vspJL+/MIt+PD/7VpTP1BKZK0LKdOryN0H7wgBWqxjq3noDah1GL2MRRMc8X86B623cGtAT3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857811; c=relaxed/simple;
	bh=kbBuEmbOnT5f4urUj8+/YZFEfjq6x1AFIG616yzK/8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BofcvR9HEeQuq6A6gjroQCggR2I1pJeDqnRthB/c3cJl5b3xWesZPG+sc87+O730k63VWCzQRJN1WgX+zWBej/FY9ucO+UTBEl0N8HasLjyrYXcQeFqIrE9lcmUINGaacv8J5Bme6osn06m5JVM0zIROJcBQMVebA+sbJv1Fapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7aYm9gx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7aYm9gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DC4C116B1;
	Mon,  1 Jul 2024 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719857811;
	bh=kbBuEmbOnT5f4urUj8+/YZFEfjq6x1AFIG616yzK/8c=;
	h=From:To:Cc:Subject:Date:From;
	b=j7aYm9gxMTAtzv/0g8QOOgFYP5+MB5u3gbRPIPDQBbAiYJmhM6hfMMSAbIjE6lLrs
	 v4fkzfnQdzBcv5zC4i1EwU5mhZGO9Dn8HZ++xQ1xDkCIAuR9qTJWrNslTob8Rm3QRm
	 +RGHdnalxPzS8f1YnQ8tXm3WcvnlsCijAdfymGtt8dXL5rBIryrINEkvanKqt1sMQu
	 /Je3CCbJ9FjmevCe2YntFUIEJZsPLPPq8qxIV6yZYk56qIQH72dF0Rpfspj/F8Z/58
	 hWxEh8o8PpjRUXjqWyyRdSLTw6nPYyU9p6yDiTKJh71ToUIgve2UoDInMtE4yBM41s
	 tMf+2roLsTVpw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Liu Jing <liujing@cmss.chinamobile.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH] selftests: mptcp: add close function in main_loop_s function
Date: Mon,  1 Jul 2024 20:16:47 +0200
Message-ID: <20240701181646.252683-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=matttbe@kernel.org; h=from:subject; bh=SdDtajciaY7eKQYmP1pJznkMhsntjvHNH3UXxru5yDc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmgvKOupvTif3N6NHkVWoBiFEs5aDlCVb/+9t7K PaZXVzhi7uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZoLyjgAKCRD2t4JPQmmg cxjMEADubNAIpSkp702hVQlX5N9s5lWzpuZm61zm2KRzhlVXVsKZf4M7fo8ZTUiMbPrEsv1LLxs EIBEXE6qVN3JMLJYtxplK0DLjYa4haQCkkhVcDqeACABdtorK+jPu7SMUjTM5RlH2hte0rsyyZ1 3DegQ1nMySbsNMvUmea2jsi5qdhrAsQ/hVl45vUazuj/7KcYDhO1ZFloaTDqhB9CfkGIO3LcJkM 4wvD2fqi+9Wnve1iztuOB6wGn5jgyLm1pHk3JA2p/ZJGeJN6HXn7wYg8le4XHFRyCmI3dtW9XnR Uk5f9O0juPd138qZ8cGF3XRmhMkT1he88tJAPU1CZxTYf1ckm0MwMjWY6GMrzhmPnpoadJqa4Fp z+J/0R4QQLUwJ4VtzciJvnaPXaODU2WL6SP2bfkgruc5vxLPmz58WlRgi8gPAH3lJz3GaWJgkAG dhjWIOFb0b6zrPGcKUjciz5sC+RXDDSIgrjQXnaNQeJREoasw6Ve8Ca+ssNchxbYa8ItpK9oCyF 2uh7KoyRXrn8LsBaMRuUqB8pl2Wq+YAtdJmHYK1NkKl9wUG6gktxLQtjBWHmtKdX4kEWFo9KBsn Zsgpiy0AnO+BTLC7V01Bh1TTMKMUYHs5Hp2VCBb4ADCckZ0wv/Tyix6/6/vhqbabep4zhc8CW80 pZY7PmZFPVHjCcw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Liu Jing <liujing@cmss.chinamobile.com>

in main_loop_s function, when open(cfg_input, O_RDONLY),When the open(cfg_input, O_RDONLY) function is run,
the last fd file descriptor is not closed if the if (--cfg_repeat > 0) branch is not taken

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index d2043ec3bf6d..48b7389ae75b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1119,7 +1119,8 @@ int main_loop_s(int listensock)
 		if (cfg_input)
 			close(fd);
 		goto again;
-	}
+	} else
+		close(fd);
 
 	return 0;
 }
-- 
2.45.2

