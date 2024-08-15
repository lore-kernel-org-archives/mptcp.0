Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE2BA53
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754774; cv=none; b=kndqoamlbU1zQpsuGbC2ugYkpbdQKKJ+zpD1PrWxY2weApMChiyevFpbRX2nJ57IA+DnPY6utZlz/FgLe5r35z2CiKo17nJL6n+s30e4vWhkqP9QcToyBaFihnktjh/XWQ3eaOWuI2cF3QZ8Gvl9/SwfRBjv86EykeM8d7k6++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754774; c=relaxed/simple;
	bh=z57vK/npD85awZLCg7BAbTqJ+9Cm06pVvgq7mys/q4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGAhgdoRWGzpGwU9ebHWbo16yBQ5upsZDZFYpWLUyEEWQb2A9fMLXrW8dbGtUd5OYKp5nkPDAMU+SczRQz6VpTMyhvG6rpHbAhVAk3QtAKha30exYfwGIPo1QZZab4LBh7zRBJ63EdfKSMhiy/lCZjllaAjqHi9FWESGiazHJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv3jYWQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv3jYWQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63BFC4AF10;
	Thu, 15 Aug 2024 20:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754773;
	bh=z57vK/npD85awZLCg7BAbTqJ+9Cm06pVvgq7mys/q4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cv3jYWQ3UT2oHMoBy7PdSSk3JZBWLXRYUv/fuNkthuNva/BF21hagnLl6yPDneczp
	 3CkFvhqXxWkPBHJRs+za5TkBUYByydA7u1yEhXvOnKv8UMZt7qaLT/tNjpjLWReoPM
	 XmxHZz78NtSfokWw8KlhwR2lJ1QqIQFykFXvDbAyIMj7qqjt9fOrV9BVYUSc4lBZvN
	 5q37tAuBqJ74+361OaLJOfCrzIQoasw0bZ6NMadHfjyE1BjfbzsYoIrgPIB6X47/6L
	 GR+1PXGvBQPrW78VSJUhfPZYSAndGpNQPSl3LjkxPIrQlORGKeCmQ8QnrfJmbzjWHO
	 SVPCFUfNDXR8Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:50 +0200
Subject: [PATCH mptcp-net 09/10] mptcp: pm: ADD_ADDR 0 is not a new address
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-9-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=z57vK/npD85awZLCg7BAbTqJ+9Cm06pVvgq7mys/q4g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJ+eide7Z3KoSm7Yo1xaiKmllA0VW/bwnWn
 T4TbZTkM12JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c5HAEADVA+vh6hZbib7rVICONswZ+79Bq5zXcB9r3lJfaPNq66JSHA81Xn1r9vSouKLlMUjH8KL
 +tDbWMH6pbQbehkvtqKvpOdHAkG0Pm7f+yi765ZXsV4ees6SCtN9iNjdVqiv82v8Cwb3S30PId2
 sFefeCgRR4avpVvaK8RoU0X1P9y0BkZxmb7o6oHVZWrmYgmDPIiqydJ+Cm4dX6KV992wCaMDQeW
 n/k5egRz92OXx+EXwmOe0P58QQBdtLIB1+3PeG3ft9sAdniFPcr7eSijsAockpSTxfPJWPitukr
 XRb6nCSfuB7QQYKCwaGwQREJd6e6wSPKX4/pQidNZHSYAsvlcN3wIfPkEmzja1JdvnYje0Ib2Pj
 pLSaUsUM/UF5Uj0Hun8iQNs4vzD87mJKERc3tjl4D5Pjbmdqp6cpZ+2xN+k+Dc0N7zAj4LKYc00
 +8De9f7/ovQW+BuqMyOIewNPLOqSl5xlrXIHtKSOy/QPZgDVGA7Q3jQbHdo0IMpBHziqcPWGpDR
 prLMCaVpAu6cpYNB6JsEMhXzQg4Ejzuwl5M5A2armaw1jTXj/UfAXs/kehnSihWYUNl3ytR31ds
 S4gog7LVoBVQLIF2vh2KBXwcBRFqBz8zM/m5rXdm181qqI1Azxu6xTLAAOGpSfsC2d61ZuLiWGe
 zo6ORERmLeCESuA==
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
index e44f539e6a56..34af04685e26 100644
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

