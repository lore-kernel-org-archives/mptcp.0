Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309525;
	b=ZoS617FmaTSkWc6BS4lx13n1kwHSavfJzihAwUUC5OJtB3CqwRNtIUSXJ3EorV1zSrlo
	 VVlP63hxI3RgTJ1ph2WmdQ1PMY3Bpkvmn8za/K44BdrFX6aUkdrzKPVze3yUnOFIpZGvn
	 7AxQl1FPRPj7LnSEDVWwoNWkPwoUs0LiGowUJaSOxeyUgIUhtEhoHPk0dov5QVyncL4P+
	 sMUI9W7Zo/NcDX44yTHAtFAhlqGrfNaVFL7VsGx7sVfW3Ib8MyPbcgiCd5PLIfFJnqeXf
	 mLwos/iAbShOHBHDVK6vn2+abS9Dulla4GaWs2VJaDXIRwr7kHZOVMGGNsJm5ovpH+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309525;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=B4LbqVo3QeneFeEYmPSvr8gQGLicNhzg9OBydPl+Egk=;
	b=RYbmfDwbSyricibWPlMi5S5ZCSZmpYtH32B+20Hrl5+RoV0w2Mi+SEPGtInIDPj12biO
	 36Bb0ijKk98vZ6yfCAki/bwNpIrEoHrQZ55o41IVm9YmYQXTkkC93ShscE5mCu7f7WfL/
	 0J9kH2VotW7b3CLMyrISGH5Ud+x4RR8PpHNVFlPKnvexEnUz0hr2E34bxMlJsODqFWYV2
	 XrmtnVNGTVVjYAOuZqk1ZtUUNFEWtU7qPOPLERUC8xUHjZUkgzmaWGzaHucXJ3Ti2gH1d
	 W8vDnPp9EC8g6QvGxVFOpBY+qwP/w6b/CBX6//pR5BQcWDc/XQcZCxaNJcFmZtJGUPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wkto1Pd4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F4606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wkto1Pd4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CA91F01824;
	Thu, 29 Oct 2026 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309525;
	bh=B4LbqVo3QeneFeEYmPSvr8gQGLicNhzg9OBydPl+Egk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wkto1Pd4E4ntt1YPBM85AAxeEDZtMARLaPo5I+YE917MPeuFeOmyhg/rIqKOe3Jd0
	 kwTTQGAG/EMuCtWjlkeAQS5ERZqHjNO1psx52UGiGETKKrGFw4qXxV9BNrs5OkM9qE
	 T6Omd/iXXPFbXtoYhifej1F6HKHIq1Ya4gVr9OZdOaHcmr32E/i/T6qeCwbi4IlC0W
	 DpbWltgBmZMUKWYp7Ms7Hzk5aft6go82EKwYAUyoBD/RxzIDQdML7xqpIVKJ1IEejt
	 wvZoVJrP2sDL7ccjHuuMfjYoT9ziFE2QezZwkKQjis4e/LTtfKINo96v3DUyqDXOyM
	 qHn2wDTZ5mU6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:31:46 +0100
Subject: [PATCH mptcp-net v4 1/8] mptcp: pm: userspace: properly handle the
 ID0 case
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-mptcp-pm-userspace-id0-case-v4-1-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4374; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SRwTaM446K8mDGBD/UsF8m7DGDI+XPF8uQj62FHVKYQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIe7/ZTSpbKvPhm38O1n9adnMB7+eGLev9P/9O+qqWZa
 GtVpNiUdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEZwHD//Dmh0ev1epdviS/
 aJUb38u/B7atvuCq/1vs8AreS4nvODsZ/ruJyPB/ODXdUaSjoS76pE3lSfcyofAvst5KYiyx4WW
 FbAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In MPTCP, the local address and port used by the initial subflow has the
ID "0". It means that when this address and port are used for some
operations -- e.g. creating a new subflow -- they should be linked to
the ID0, and no other addresses and ports can get this special ID while
the initial IP address and port is used.

So far, the ID0 case was handled as an exception: each operation dealing
with the ID0 had to be handled differently. Except that this was done in
some places like removing the ID0, but not everywhere the list of local
addresses was iterated. This way of handling the ID0 is prone to bugs
and harder to maintain. Instead, the initial local address corresponding
to ID0 can be added to the list when a connection is created, and the
number of exceptions can be dramatically reduced, handling this case
like any others with existing local address. The existing exceptions are
going to be removed in the following patches.

The main downside of this is that each connection will now have one
allocated entry added the list, possibly one more than before. But that
seems OK to do that with the userspace PM where the path management is
done per connection, with many Netlink messages sent back and forth.
Adding a few more bytes per connections on such setup seems acceptable.

Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
sashiko: check the next patches before pointing at existing issues.
v2:
 - List new exceptions in the commit message.
 - Handle local_addr_used with the ID0 case properly. (Sashiko)
 - Handle needs_id where the addrs don't match, but the IDs (0) does. (S)
v3:
 - Split local_addr_used case: that's fixing another commit.
 - Set port to 0 (msk) instead of adding exceptions in lookups.
---
 net/mptcp/pm.c           |  4 ++++
 net/mptcp/pm_userspace.c | 20 ++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 25 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7c5b50b34cc..e9a538296200 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -551,6 +551,10 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 	pr_debug("msk=%p, token=%u side=%d\n", msk, READ_ONCE(msk->token), server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
+
+	if (mptcp_pm_is_userspace(msk))
+		mptcp_pm_userspace_created(msk, ssk);
+
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f723a134356f..45faee894ac3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -707,6 +707,26 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
 }
 
+/* Add the initial local address (ID0) to the local list: easier that way */
+void mptcp_pm_userspace_created(struct mptcp_sock *msk, const struct sock *ssk)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	entry = sock_kmalloc((struct sock *)msk, sizeof(*entry), GFP_ATOMIC);
+	/* Fine not to handle the ID0 case in memory pressure */
+	if (!entry)
+		return;
+
+	memset(entry, 0, sizeof(*entry));
+	mptcp_local_address((struct sock_common *)ssk, &entry->addr);
+	entry->addr.port = 0; /* msk port */
+
+	spin_lock_bh(&msk->pm.lock);
+	list_add_tail_rcu(&entry->list, &msk->pm.userspace_pm_local_addr_list);
+	/* The initial address ID doesn't increment local_addr_used */
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3be60da12924..8c219fabfc9f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1260,6 +1260,7 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
+void mptcp_pm_userspace_created(struct mptcp_sock *msk, const struct sock *ssk);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);

-- 
2.55.0

