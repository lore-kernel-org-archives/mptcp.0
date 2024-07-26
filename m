Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A6B383BF
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016108; cv=none; b=p8ixzO9O7faBLiG1oPoYBbzNg/e97nwjuiVKMyIFOQCSxnPJRUsioAFZw0cWWawm1aygWyxxMrrBHu+RgDmImmCOIW5JMnNUjrRd2O17swtqJdftj2vXBVBRXx9KaK11vG9VFGo+8ztWRxYpAv8WwqbaJfuNiBH25S9erQg6ll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016108; c=relaxed/simple;
	bh=kVZzOf/BpqQynulgjG+PVFlgYIyugnFUYwJU1jYr+zE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pijge7jtYoyfCiNZsXC1mbwzReqE68frah/vXlR5VgvtwKjSuCg1H/eDxO88VxA4wKrzGd+/q8eo6ngK1zqKobG507SHdIJ0WcLbUn7Xro1qVTaJnqE85WL9zR4Mxj1hkMEMiNwJhRWnX8B87aI3JDzKlON0APWYEtxRRA0S4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjo5iEsG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjo5iEsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81C1C4AF07;
	Fri, 26 Jul 2024 17:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722016108;
	bh=kVZzOf/BpqQynulgjG+PVFlgYIyugnFUYwJU1jYr+zE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gjo5iEsGGXWuNNyBVw6ksLMt8Fse4c4v0G1atPPezx7bABoesBrTuZrwwTB4jnAKV
	 2c8upDaq6/iezdzFop/9mNt1hz+9lHiEujc+pXkFHxuPdvAFLaE62RHPUZeeAbS2UH
	 xrpGbb0N9RpUHh4ksYsHkH9CLHvP9CB3SpD+j++NGlqK/qAMhCIkirMgz8t6jlTZO8
	 3CmsGaCfvkWCm+roKnn5DUmgMoLZCq9JZCipbsT/bvsZWPe8RCbmGNH9BHLVuUXQLf
	 gKiuMaONQ4Gwkivs/dVHXWpHHXWZNlfD9FbWkDIuwoYwsUN5IJNjtkJqBu0VHJZCY9
	 VxwuGDAmX6pIA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 19:48:21 +0200
Subject: [PATCH mptcp-next 1/2] mptcp: MIB counters for sent MP_JOIN
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-join-tx-mib-v1-1-7f2149ba0dcf@kernel.org>
References: <20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org>
In-Reply-To: <20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4733; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kVZzOf/BpqQynulgjG+PVFlgYIyugnFUYwJU1jYr+zE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo+Fq9c79xYtJsNiiWZ8FAXLJoHbxZvxQSJmLc
 VAhprACJvqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqPhagAKCRD2t4JPQmmg
 cx1KD/983PA/p49X3qVVlih1/JQILqkzN9Zm+eAQJUWFj2+Yl+wjTMd2R4c07IlIpLOFNoaArSm
 gAHMzq/Y13ogaezbNWZYynKtkmEFV5iXCtK8Ob3Rp4ZQ+JJu6oyL9T9Y22dQd2dS71mzqLhlAL6
 AfqcFjQJHCLvCRGtjFS6zcxW4lxYcvdGzjJfIFQU27EEyzwOrchHnsFf1Sp3M9bF16A4aaQLBSe
 Yj02WZidJUOwyipEZ5tKP6NkC9P8hfFjMzQY4Wn74TKibaCpa/i0bmENYURgFrIr8eaiNfzmKRp
 YN3rSj7UJTU6zM4eBVLVeWGfnLA8J1CNNbLtIQ8I+VI/BNRJC5mF+R7CPC4DOV6lNng6+YjLPjS
 AZs6XGEr1mUqDzQifrSpx2ALFZdIYTsrK1CATh1/HTZCQbhzFDJqXg77fo8TdgtrFqvcQsmyw9+
 gJsYisbRQOlZBYviwAt6Gp0ryZE64IxLtn2IHpy1DPUEjrd+j2qZc3cAsCXek6C41DLtWoVw4iv
 D4WAg93aG0X8bQJnzcONC7x8Uo9x+aA1SNRQ7b7EjpR5OYx/5OOYz/7PO1/0LBaRu3jSTdzA8Xg
 JWTt/tsX4zx+EQAc4WhNFPFf6lLTyy9uqN22XInr7lkdR4lB63P7rcFrsI3l+f0eUr/84AJIqy9
 eR5jDq2wmLWKiHQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, a few issues have been discovered around the creation of
additional subflows. Without these counters, it was difficult to point
out the reason why some subflows were not created as expected.

These counters should have been added earlier, because there is no other
simple ways to extract such information from the kernel, and understand
why subflows have not been created.

While at it, some pr_debug() have been added, just in case the errno
needs to be printed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/509
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c     |  5 +++++
 net/mptcp/mib.h     |  5 +++++
 net/mptcp/subflow.c | 24 ++++++++++++++++++++----
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7884217f33eb..a0b1152c32f1 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,6 +25,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
+	SNMP_MIB_ITEM("MPJoinSynTxFEstabErr", MPTCP_MIB_JOINSYNTXFULLYESTAB),
+	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr", MPTCP_MIB_JOINSYNTXCREATESOCK),
+	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBIND),
+	SNMP_MIB_ITEM("MPJoinSynTxConnectErr", MPTCP_MIB_JOINSYNTXCONNECT),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 66aa67f49d03..ccb3a30e835a 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -20,6 +20,11 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXFULLYESTAB,	/* Not in fully established when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXCREATESOCK,	/* Not able to create a socket when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXBIND,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXCONNECT,	/* Not able to connect() when sending a SYN + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
 	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a21c712350c3..d305c0f53a09 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1577,12 +1577,18 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	int ifindex;
 	u8 flags;
 
-	if (!mptcp_is_fully_established(sk))
+	if (!mptcp_is_fully_established(sk)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXFULLYESTAB);
 		goto err_out;
+	}
 
 	err = mptcp_subflow_create_socket(sk, loc->family, &sf);
-	if (err)
+	if (err) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXCREATESOCK);
+		pr_debug("msk=%p local=%d remote:%d create sock error: %d\n",
+			 msk, local_id, remote_id, err);
 		goto err_out;
+	}
 
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
@@ -1608,8 +1614,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 #endif
 	ssk->sk_bound_dev_if = ifindex;
 	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
-	if (err)
+	if (err) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXBIND);
+		pr_debug("msk=%p local=%d remote:%d bind error: %d\n",
+			 msk, local_id, remote_id, err);
 		goto failed;
+	}
 
 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
@@ -1624,8 +1634,14 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	sock_hold(ssk);
 	list_add_tail(&subflow->node, &msk->conn_list);
 	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
-	if (err && err != -EINPROGRESS)
+	if (err && err != -EINPROGRESS) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXCONNECT);
+		pr_debug("msk=%p local=%d remote:%d connect error: %d\n",
+			 msk, local_id, remote_id, err);
 		goto failed_unlink;
+	}
+
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTX);
 
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);

-- 
2.45.2

