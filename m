Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C643164
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499631; cv=none; b=hB/2k8YllqNozrIPv5sKNui+SuxorODAu0uwJdObzPea/wMUnVRl3vyWAyHdk785vLegMTgWCh/JUGQi27BXPWKU1CPGCDMNE17s3hMi0mHIJmXteuXjIuiRmAR2DEcshLTp/9HugmqSLAh3k7U1MtOAJMGRiF5vKONEffPFiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499631; c=relaxed/simple;
	bh=/ocqZ1pnYr49wkaa5Q/pxuf32eXYH9m6DoyE7plu6mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VnOLeCOCahTBgZ1++qgQpcbdEZstFVWlFObGaaeHGR+fYEElNN/KKCWQLVI828fvzcVkEWUUEzn5djWNanW4GpHTl5o8Wc9OtcOnCcqIXaWznzTxSOCRckrIesvgMvTFTS7e98uxrxJzyt13j4Uhncy/fiTP6GWTusclaH21MUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzA2ZlMk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzA2ZlMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FA4C4CEF6;
	Fri, 29 Aug 2025 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499631;
	bh=/ocqZ1pnYr49wkaa5Q/pxuf32eXYH9m6DoyE7plu6mM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jzA2ZlMkbHMxf9nkzL14YCVyiW82fxOc0XG+tMbgKGPdgskIT0PeHB8QOdexUvO2Z
	 XTaSY3KAtcQGJcsUz3LBVCQScmO6WjpAFm4+RCnWBw3ToE4AbVqjdwZSO/CtjNjnc9
	 hU7/Fk529sudxKG6jZqb6A0aQz6OjhP8KqKLbFnC+DXkDjB0PzxHwM5ku/FRgoG7ws
	 l83x1tbDJnU+MN8KgKMfeWkhtJ5yidiegYbSERwRSZqY0Mulht940QA+9OzXDeAQXy
	 FUHOlrbnwxGs00etB4t+IXOi/wEMUpmCXKEPpGpkWxTJbKu2A8Pb0fv5YiG4366KS1
	 ILFSByBJCijmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 Aug 2025 22:33:33 +0200
Subject: [PATCH mptcp-net 1/7] mptcp: set remote_deny_join_id0 on SYN recv
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-mptcp-pm-user-c-flag-v1-1-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/ocqZ1pnYr49wkaa5Q/pxuf32eXYH9m6DoyE7plu6mM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI28S2XV3JqvByjf6VyfbO7p5ph7fODvVsmLtngf+HQn
 MvhVxiWd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkIz/Dfw/lu/93RV5Qbde2
 twl4toVlxw15ucNtqo2RbS/PrWv58oaR4fn9u07zLqZd+XpmqlqqimKK2zWOHs0KJqPVDg3GOfy
 1DAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a SYN containing the 'C' flag (deny join id0) was received, this
piece of information was not propagated to the path-manager.

Even if this flag is mainly set on the server side, a client can also
tell the server it cannot try to establish new subflows to the client's
initial IP address and port. The server's PM should then record such
info when received, and before sending events about the new connection.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c8a7e4b59db1150610f99d6e599a9d4cf7e137bc..e8325890a32238bd1fd558b955137a2fa32f66c2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -883,6 +883,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			ctx->subflow_id = 1;
 			owner = mptcp_sk(ctx->conn);
+
+			if (mp_opt.deny_join_id0)
+				WRITE_ONCE(owner->pm.remote_deny_join_id0, true);
+
 			mptcp_pm_new_connection(owner, child, 1);
 
 			/* with OoO packets we can reach here without ingress

-- 
2.50.1

