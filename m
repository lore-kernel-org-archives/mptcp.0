Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86891143737
	for <mptcp@lists.linux.dev>; Mon, 29 Jul 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248333; cv=none; b=dfTXukFVwzxEDy80tOZskJl/nMhJd2LUrvm2e0803hQcIrJkImQCJqVc3uzeokdoU+wTAVyupSvu/1JvbEUSz2GutDPhzqDYHCfq4MHmFwgdm4f1fS2Xl1x78RZvu/8YTT2HiU27d4NyJTV50qPv5ogDp9Za7a/PhU4ZYrbTu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248333; c=relaxed/simple;
	bh=Q3+iiY7gXh8yHRuDuntbwDd4aIrm8TvSaXMs/OJ5nZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dccsanw0QoHPaM9+9fFmjVx45nJ34g44HodEWPQsDZyjHbCQ1h3MOkJKZZ2fw3YOQfyy/GGDIIBAlkbYi2kesYj/UYCu6WzYUAUtc2D2sqCeIeilbO/vlqsaOI/L0a3qsNpi12VaiatV4ZwBsLHf5JzClxrO1uMBmdv2RUXeYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm6tMuVC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm6tMuVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC39C32786;
	Mon, 29 Jul 2024 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722248333;
	bh=Q3+iiY7gXh8yHRuDuntbwDd4aIrm8TvSaXMs/OJ5nZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wm6tMuVCVKDwoDC+AKBho3vAZrAAMZhjbGFyFMewOyJX9Qe2ve6ZSSw2UlfUr4gIl
	 VzMOrxrRvZqW/zd/t3juLGc4kmurdSb1rRCGqcNxcVlHOb1zdDBT3fx76gBPSDkyIL
	 +pNRbqp21vKKg/PrcidP/ufSyle8Ov05dz8q0pTIngRJhm8aVzGGQTIfUKREHjLVWj
	 F1vjEUGLra7Q9NYL9WJVbBEcFyYXGfkxSJ6aGS1x6j8Gi59pISiFZ6EvFH+kDnFRYC
	 5tf4iEeqrKSq+OBrjNS2c5jUWpR/3WzmJBSWbqUyNG0eFvGQxW17Rh2eApD1SZBsMD
	 pmQBzRhEthY+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 29 Jul 2024 12:18:43 +0200
Subject: [PATCH mptcp-next v2 1/2] mptcp: MIB counters for sent MP_JOIN
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-mptcp-join-tx-mib-v2-1-8ace70fd407a@kernel.org>
References: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
In-Reply-To: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4823; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Q3+iiY7gXh8yHRuDuntbwDd4aIrm8TvSaXMs/OJ5nZE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmp2yLljNHp4rhrslW4dOZzMPqkQIzvOwSnhVmO
 Uhxi04ZQSuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqdsiwAKCRD2t4JPQmmg
 c3aZEADbqQrBf8pI/t74EptUiL5X/3QkhitFuvcjcbCH0ubbkxQlNCpnqABVuyanqFq+GImMdiz
 7Q6wYDy5hSLn5IpThzrjpxDoNmlUHtvsuRqh0pE9rgsqGCGf7QPPacBWbMR0HGbrYhjZLrZ0/rv
 ZM6q81epSHB1t4n26tm9bYlCQQWZsUrVPFs2/o2QpdgiPcx05SGtB2neN6/819boA4+1rYwuEO/
 B3cpTmDQSwHs+W6UUYq4uLmdpKSK1pJJ7kYotXu1VzjqhZlsZ5k5jsUOE4iFptKZrBJls5IMBUe
 kBNnuRbkfX0jp78A+dmfBRNzHKK9m0roR7rsj85tmUBcB3soUtKqUQyfsSps9d12rOE5LcQ6Qo7
 V+4t+82FW0uSZ9tBO1vl6KJd2FNz5nqrkM6ioMqCoxlPJWdHPC3CI4Yh2FDNJ7cq51WSH2d9iVm
 m/H81ZVDxVBpo9QMG+rN+whWEHW2BRGQI9SndQilQ4tMwxXB9IAIYD3EjVElofVrhGpubtJtR+5
 MkXFOn2W97EHpmsRsjPO8hljTFcAZv+lSGWu8p6/pXi6N09iGSdjFv+ip+1adGZyJVKZDYlR24w
 lJP5WbFVWopdBFDteF0jUdblcXCVGPeLMo+//fAN0XcsT7k1W7QVqcQW7iBsKyqha1+4K7Uf5EK
 0hTD8qWPe+5IpQA==
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
---
 net/mptcp/mib.c     |  5 +++++
 net/mptcp/mib.h     |  5 +++++
 net/mptcp/subflow.c | 24 ++++++++++++++++++++----
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7884217f33eb..36edef1e6861 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,6 +25,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
+	SNMP_MIB_ITEM("MPJoinSynTxFEstabErr", MPTCP_MIB_JOINSYNTXFESTABERR),
+	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr", MPTCP_MIB_JOINSYNTXCREATSKERR),
+	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBINDERR),
+	SNMP_MIB_ITEM("MPJoinSynTxConnectErr", MPTCP_MIB_JOINSYNTXCONNECTERR),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 66aa67f49d03..6f2e1ef1dce9 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -20,6 +20,11 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXFESTABERR,	/* Not in fully established when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a socket when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXCONNECTERR,	/* Not able to connect() when sending a SYN + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
 	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a21c712350c3..69568d928b35 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1577,12 +1577,18 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	int ifindex;
 	u8 flags;
 
-	if (!mptcp_is_fully_established(sk))
+	if (!mptcp_is_fully_established(sk)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXFESTABERR);
 		goto err_out;
+	}
 
 	err = mptcp_subflow_create_socket(sk, loc->family, &sf);
-	if (err)
+	if (err) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXCREATSKERR);
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
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXBINDERR);
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

