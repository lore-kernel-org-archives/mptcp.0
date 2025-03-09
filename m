Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AC1DE8BF;
	Sun,  9 Mar 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531636; cv=none; b=sMc+jUlFKginwTR3BJqbrxT9IgVdkWvfelbmue5W9gJqgBu0UCThRVQBFeM8OfvkNQd8XeIcsnXjsnEe7PPsqEmpes9cCd1TemJWmkVemr6ZBJVgwuu2CvU6JU/8MqeDHhY17QziloUcSN/NUcO4uWleQOcAnQiRQAAAX46Nb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531636; c=relaxed/simple;
	bh=Bb8IvzyLfLIg1I4cBm71rQi2Ce85AhNcKqxsPd02EJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W539yxmXVwF4aRdL8BgT5QqCbl7vh1o8he/J+aR2d+UVU6jOidR5P5BE0ohZZRjYEoMU8EljGt3Emw6shJWgic9dYvWNEq3YWzVInA+qwrZRdhWvKyIfSvNc+DiYef/scJa4u+c/H8E2oaWa5C4wEEQmdM16tI1EA6ue32U12zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gmLhcoCk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NvJFCFGl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gmLhcoCk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NvJFCFGl"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVMF3UgOhS4U6RN9l5v430qS/smjyIcn6+mTv7rds4c=;
	b=gmLhcoCkZZjCFqceZdjRITs7C9jUk16kVHFROAXq73CA7OVMZNb82SPO0E2l2zlbMVqDnU
	Te4Jazq5SyIre8ZTn/wSMUn+1HQ+p91+Fu8MSkrAvN+2vsV2FmwTgEzXAajmxCe6R/WCPY
	RiwvPEu6/X4mj2adXYpxGrKECOEWZm2mRoHH32cBjaqILMTdEphhw24Gvq+xewSLZVYdmr
	g3Y2D9qESzpn4zOFGF8B9V/pqJwLzz/kjTO5M7jUCL+AVzcAQmxVTrzuwKs+y37TSoIT2T
	KgQoKG7qjjkTBf2oeDcIi3h4funSDvDaX9oPBd1wUcbuSGq0m7qFDPAl/vcqwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVMF3UgOhS4U6RN9l5v430qS/smjyIcn6+mTv7rds4c=;
	b=NvJFCFGlSkZdM0zda6kq2HtxpWVPZIr8TiWeIvW7rbXl/RMQn/kHGkzlgiOC4nK9WBDPG9
	XQEJnYsKDoIlBODg==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 15/18] mptcp: Use nested-BH locking for hmac_storage.
Date: Sun,  9 Mar 2025 15:46:50 +0100
Message-ID: <20250309144653.825351-16-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_delegated_actions is a per-CPU variable and relies on disabled BH for=
 its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT this d=
ata
structure requires explicit locking.

Add a local_lock_t to the data structure and use local_lock_nested_bh() for
locking. This change adds only lockdep coverage and does not alter the
functional behaviour for !PREEMPT_RT.

Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/protocol.h | 9 ++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6bd8190474706..922b5baf3372a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -46,7 +46,9 @@ static struct percpu_counter mptcp_sockets_allocated ____=
cacheline_aligned_in_sm
 static void __mptcp_destroy_sock(struct sock *sk);
 static void mptcp_check_send_data_fin(struct sock *sk);
=20
-DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
+DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions) =3D=
 {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
 static struct net_device *mptcp_napi_dev;
=20
 /* Returns end sequence number of the receiver's advertised window */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ad21925af0612..8705d699e9870 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -480,6 +480,7 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
=20
 struct mptcp_delegated_action {
 	struct napi_struct napi;
+	local_lock_t bh_lock;
 	struct list_head head;
 };
=20
@@ -671,9 +672,11 @@ static inline void mptcp_subflow_delegate(struct mptcp=
_subflow_context *subflow,
 		if (WARN_ON_ONCE(!list_empty(&subflow->delegated_node)))
 			return;
=20
+		local_lock_nested_bh(&mptcp_delegated_actions.bh_lock);
 		delegated =3D this_cpu_ptr(&mptcp_delegated_actions);
 		schedule =3D list_empty(&delegated->head);
 		list_add_tail(&subflow->delegated_node, &delegated->head);
+		local_unlock_nested_bh(&mptcp_delegated_actions.bh_lock);
 		sock_hold(mptcp_subflow_tcp_sock(subflow));
 		if (schedule)
 			napi_schedule(&delegated->napi);
@@ -685,11 +688,15 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_a=
ction *delegated)
 {
 	struct mptcp_subflow_context *ret;
=20
-	if (list_empty(&delegated->head))
+	local_lock_nested_bh(&mptcp_delegated_actions.bh_lock);
+	if (list_empty(&delegated->head)) {
+		local_unlock_nested_bh(&mptcp_delegated_actions.bh_lock);
 		return NULL;
+	}
=20
 	ret =3D list_first_entry(&delegated->head, struct mptcp_subflow_context, =
delegated_node);
 	list_del_init(&ret->delegated_node);
+	local_unlock_nested_bh(&mptcp_delegated_actions.bh_lock);
 	return ret;
 }
=20
--=20
2.47.2

