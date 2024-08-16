Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E357817
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806141; cv=none; b=kyE8QHi0QBH9CrkNkA/YnlUNRIjk5o64lITIucTR/HX0dTbDK4AV0c4JgBdkih2veVluVDCHa9ujuIvflSIFfNF++KZ3b71HZa9IQzmZ36+aa4YRLFsUNrlhyECIrM9g2sxb3t5hNDwVBlTdI+SqDVfB7kTWTJpiPDGXi7w/NfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806141; c=relaxed/simple;
	bh=w0gVgtS0irM/m9XnfGrohdvca5g3Ze/cnTABI3q6STs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FDfV8hIriPc9iYpE83K+n8fjIEcczOoj5NuNK7Xcc6IYoxcKdYW4Szamj4q9iiJk//ZNy6HTtL/L62NcteED2qSceGjmNF5zpQnXG3jphAvzv7OaB/IVrSIJOh9/R/459EILWspiYEVFN8OAJp1c9AxQ2UXAKjL9toktLh5FPb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P56xSdzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P56xSdzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EBDC32782;
	Fri, 16 Aug 2024 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806140;
	bh=w0gVgtS0irM/m9XnfGrohdvca5g3Ze/cnTABI3q6STs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P56xSdzc7Q8yFvSbvo9igOXBVXvHswrNOq0FJnnF1KLrOOOlhtI/u9J88Ydf3K1v5
	 3XqT+ssrj8V3eOjIp1u6L6GrNovonUC+KQmGMTZElGSrGk9WozR7e1LWgA6xP077t3
	 6rkUeFOce5nJAZTxN92rHm0qm4NHh+vVim1nz/Qwd4shOqU70o0NVvizVSXUq+JURb
	 xS5hL8hIV/5lt47SILilJiLckBNQkIBaIrcosilDpuUsOTp7rB8r/nhTdZKQk7eqpO
	 utEKmnBEliRgps0dBQmEfwNYqrv5S7fWbrB/wAo/+7vi9JB/+x0GFENmrC6CZmbbH5
	 FkYnQ/GtYKhRg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:02:05 +0200
Subject: [PATCH mptcp-net v2 11/12] mptcp: pm: ADD_ADDR 0 is not a new
 address
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-11-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=w0gVgtS0irM/m9XnfGrohdvca5g3Ze/cnTABI3q6STs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGubrgcLw7qf9nxybP1aSYS63EMnziSR1KlH
 waEO+x31qeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 cyXvEACMbk8DZvr4LnKP80wHs52m1qRC8NPRpacMtqyVlY985Z8LWBpYDhmO1SxzS9+GMMhJzkB
 kKXTTt8kONaiBxmLanW69gfuuZs9ZhclnMlcHYiOiYQvdEzQsSGYT9kLCIijPDY7nDtRBKS1OeV
 WETiOSCVtP9OtMqyWvyYmzvgHb7FaftGXFQ+p00TkBk7WZUTiWLCSdv2MU5NmNgd17ZaTzPo/N7
 ra3NY5fQ6O5Ta+wEf0RRoijhDv8Qa1hbn9yAKpAeNu8hhFNgh8lgfOBMrp8T5QYUb3o6kC4gjII
 Uz8uJSk/iLTkQ9GT7OrzZOpnQ3j3MIDk1kJQaoza9Et5ajgTQ1zxk+T8FBougDdrsbaPOrkQ9Ec
 xU1xaz7GHRtcjoMGAObaKhHJsXyn6Im0kWoyVUoCzdo8NPkshfRfIXgNUKWzZE5XXJSvEzKhK6g
 3RNC3tIQM3dAfxzOSYYEfCaMzlZssEAad/rBkxstrNTLxpNutQ1aFbhR5cTZnI4ZutcIoVqbd6X
 sbl8l2CTokAkClflb9+sC5cuUH6pCMQmApmj8WP/ESyQ+0rbQemY3BOv2i0GLUzUPn2IGxMabtX
 e71g56oRBe0yCXjYkS/+tbSGM5obvtkquIaOvFldt0JHaMCb44DkQU0qO8fUFjFQhloOdZgtL28
 TZvSxJRoHHDY6+g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The ADD_ADDR 0 with the address from the initial subflow should not be
considered as a new address: this is not something new. If the host
receives it, it simply means that the address is available again.

When receiving an ADD_ADDR for the ID 0, the PM already doesn't consider
it as new by not incrementing the 'add_addr_accepted' counter. But the
'accept_addr' might not be set if the limit has already been reached:
this can be bypassed in this case. But before, it is important to check
that this ADD_ADDR for the ID 0 is for the same address as the initial
subflow. If not, it is not something that should happen, and the
ADD_ADDR can be ignored.

Note that if an ADD_ADDR is received while there is already a subflow
opened using the same address, this ADD_ADDR is ignored as well. It
means that if multiple ADD_ADDR for ID 0 are received, there will not be
any duplicated subflows created by the client.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 4 +++-
 net/mptcp/pm_netlink.c | 9 +++++++++
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 56c0a318e5df..da7b2b95d568 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,7 +226,9 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	} else if (!READ_ONCE(pm->accept_addr)) {
+	/* id0 should not have a different address */
+	} else if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6a05eacd59b3..8b9580b6d643 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -764,6 +764,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	}
 }
 
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote)
+{
+	struct mptcp_addr_info mpc_remote;
+
+	remote_address((struct sock_common *)msk, &mpc_remote);
+	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
+}
+
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ce15e7db464b..c05c5a3cb07e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1004,6 +1004,8 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote);
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);

-- 
2.45.2

