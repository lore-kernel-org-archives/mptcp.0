Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCB13B2AC
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943148; cv=none; b=VsS1paYDvHOcUiqXQDLZ0wyjw/MZEPFdY/+6+MdGnI3qMJB1iEGSWIxkGSs050+agGxBzdiuBspb7avPNJspMyRZ8f/QKM5Xi7e7byURgJcATNAWHFPTv5B2hVt0BiUsR1Dpc/1TPqMwIc5V8sDP98m9hXTukxFEJbsJQ7kz30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943148; c=relaxed/simple;
	bh=4LS7mEH8SCX/ybuWunoK7nr36GkF/sL9fRCxtKE/smo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7fv+eu+5Nv8ETZ00vRYgaOq/X3jVPZbe792X7vR9VjdU/b1k9GfkLnpMR37gi0IHpEr/4qBOs2kxQ1L7SzRW2gMc5inOQGMsLBTHRIJpby/b4Iwop6SLtb8x+pigbTutCZpvz7APhFBhmr83Zxjnalkcjuim/vkJ92L4xGv9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0rm3/du; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0rm3/du"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0529C4AF0F;
	Tue,  6 Aug 2024 11:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943147;
	bh=4LS7mEH8SCX/ybuWunoK7nr36GkF/sL9fRCxtKE/smo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D0rm3/du5tmLGwvUDqC9377KSnbk+G5Dw8HTtC2Wsp6NYMvLcjHv8YH2RuzU4zODj
	 Y8e9PBcIadJmaubHVRIyx+ZlC29U3CgoQ8PQD5mrE+OEmx3+ltYx8268RS23MQVGeo
	 CeKa7jMdFkFvw4Xgz9oZcMCQ6YHpbXBsBc8oru6GLf+rcoGLDqQK6RsMSeD4AYSzJd
	 7ErYsUHPGmMWwpxsawS0Ay6nz98fMKDeG4fs8g8JBsZ3I32/T9dZecBKrh3+IAdgkN
	 QCTFZGEZANFnu430Zy7QgFfbCGzmQJfZiBGfQOjF8CwSqHU6geiGnOr/SjG9hVgaPo
	 FwFOeletcVDNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 06 Aug 2024 13:18:50 +0200
Subject: [PATCH mptcp-next v3 2/8] mptcp: MIB counters for sent MP_JOIN
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-mptcp-join-tx-mib-v3-2-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4799; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4LS7mEH8SCX/ybuWunoK7nr36GkF/sL9fRCxtKE/smo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsgaoZ0nlYodt+04sXgsz61Q1zr0kIsi3QdJwY
 a2ByVORIl2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrIGqAAKCRD2t4JPQmmg
 c3r+EACufPVeVe7KA+81tyIdYRDxcjni0Z59Gm96XqY2XHlBBSHR0ibc8V6uVKEaG3Z36asMnf3
 393jOqAIfyYx/l7XaZJ4WtKIEUqqxQSRoq3X4ycMlbnqlPq28ArsHw7K0lGKEKuLtjCMmmYNeAG
 /ATC3GWnvgAKUUZJMsa3cM/NLrfH5S5FsyaRt/e1LjYYAfSZpEXY7QUoynEYNEE1s3mAPtWLX4g
 DvO2cLx4VYfDGMYbFjxf5bfk5QqhY0gv5day6ceCTOOMT/Qx2f1aFj52y1NzOh2tLm5WP5Oaraj
 zeDkYEQ4KdZij5R6/XMSN2NNanGOfBekTL5keH/6mfnn+FCLIMukiFA7QHaA89My2KSZ2Bdk8UN
 GMBYY7W+jPQS2hrLtxx2P8t72sU5yW90A3xHGRTZwy0ZPOm9MEm9k9a1pHejYINwWlvbwdKqcVh
 I9h5uEatPYtvYWBb0wcMPLW9ygILsZCrESI/1mOa38QN7nk5KLPr8/HW/cNNoAAFtV27R5h6+kP
 CHibDdISWLR9Y7XA9wRTu0a0i35H5HN0HAcc5dygivi7FntV3WYc54ouFetCc3daXpKtM5XgOHz
 uygLCrO6q/YCm/yUmiCx1vZbvvRSPW9S9ruS0/qlRjCaFrDJCNXwZU0yejcurCmL7vplZqP0SeB
 KoS5AS0T2yVHtgg==
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
Notes:
  - v2:
    - Add "ERR" suffix in variable names. (Geliang)
  - v3:
    - removed Fully Established Error counter: should only happen with
      the userspace PM, which will propagate the error in this case
      (ENOTCONN). (Geliang)
---
 net/mptcp/mib.c     |  4 ++++
 net/mptcp/mib.h     |  4 ++++
 net/mptcp/subflow.c | 21 ++++++++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7884217f33eb..ec0d461cb921 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,6 +25,10 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
+	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr", MPTCP_MIB_JOINSYNTXCREATSKERR),
+	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBINDERR),
+	SNMP_MIB_ITEM("MPJoinSynTxConnectErr", MPTCP_MIB_JOINSYNTXCONNECTERR),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 66aa67f49d03..d68136f93dac 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -20,6 +20,10 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a socket when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXCONNECTERR,	/* Not able to connect() when sending a SYN + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
 	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a7fb4d46e024..fdeb7df8b095 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1575,12 +1575,17 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	u32 remote_token;
 	int addrlen;
 
+	/* The userspace PM sent the request too early? */
 	if (!mptcp_is_fully_established(sk))
 		goto err_out;
 
 	err = mptcp_subflow_create_socket(sk, local->addr.family, &sf);
-	if (err)
+	if (err) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXCREATSKERR);
+		pr_debug("msk=%p local=%d remote:%d create sock error: %d\n",
+			 msk, local_id, remote_id, err);
 		goto err_out;
+	}
 
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
@@ -1615,8 +1620,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 #endif
 	ssk->sk_bound_dev_if = local->ifindex;
 	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
-	if (err)
+	if (err) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXBINDERR);
+		pr_debug("msk=%p local=%d remote:%d bind error: %d\n",
+			 msk, local_id, remote_id, err);
 		goto failed;
+	}
 
 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
@@ -1631,8 +1640,14 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	sock_hold(ssk);
 	list_add_tail(&subflow->node, &msk->conn_list);
 	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
-	if (err && err != -EINPROGRESS)
+	if (err && err != -EINPROGRESS) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXCONNECTERR);
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

