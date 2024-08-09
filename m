Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50BD17A5AC
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204418; cv=none; b=sgGYTPFlND/bMCD8wJf3GckVR7fksTZjGyau4Hykl4HvzHBdbpo4OcxakUyk8oHT553/HuYzQlZeMB1NxaM8qzOjWnrKZThM9P+/jEK6rggA06TjxyXwoZXN8zvDxkOMCvwxApKYyx1+OQH+V7hxv9rZREPNKr31Y9pyHKljTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204418; c=relaxed/simple;
	bh=JV4e98MvcVbeKw2dLX39p0IafI6FZY3aJONWF4RkBEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spA9Gq2upkuLuMH2QHh7eE8wo7ACahrUsCLdjFBpJV0I03aZhYoKRMeCb48q5g44JZ+zoOJlCS29ShDwtzT8d4bTYig7atBgl9dRZY6/CWI5qsFbUY6OQuoVHuKVN8aM0GSt1hCHkBnQHdGzswjq55Rui/1LURvy0kdKQD94uEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScQ6Vk+r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScQ6Vk+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58D6C32782;
	Fri,  9 Aug 2024 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204418;
	bh=JV4e98MvcVbeKw2dLX39p0IafI6FZY3aJONWF4RkBEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ScQ6Vk+rIvFGxrAoc5bpnno9ChFd8HYJtyURglleu7DbNM2ATvnuyKCLYeGYyo8LE
	 nZqFYJlOPfBt1PyUWcKvTHT7Vl/hEgYDRqX3xZp24/qXo2BjQJjHDJNXbjOSRoS0kh
	 xZrWi+YBdZcqnQHa7ZEP+qh2/NBaqgfW9r+9TZD9oLNL0+R8QBg+HOcnmh+22WhD/k
	 GTypgIwuhIJFFVrI3LTXLpZkXoOuLz7Cg17CpT8vFOLMrbFEnDLWaKXZ1dVwZcG8uI
	 4XYhdjyjlW4imlpuIPQEAtWyBHmCjhluFO8yOpq6OVbQ028FSFCSmE5eXYr7O3M64W
	 xG02M5Oup05fw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 13:51:20 +0200
Subject: [PATCH mptcp-next v4 2/8] mptcp: MIB counters for sent MP_JOIN
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-join-tx-mib-v4-2-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4854; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JV4e98MvcVbeKw2dLX39p0IafI6FZY3aJONWF4RkBEs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtgM/S92f+d95yYmaG6l4S7EKEjanZr72bUT63
 a3YQxzum96JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYDPwAKCRD2t4JPQmmg
 c3+gD/9YLLj906mzz1Ozy4+ZQUNYBFXsYy8cLuFpBfxJCvzG6T5S3HUBPQ/5ZhQTiRik0vCpeoU
 3YyiabS+4YpbiW0IZcASigTMl3l5IC0JDobOCHjsTTbsIlEA8P4uYyonbaBzFpQydgHyF4HoBgw
 Y1xdX7eta+k3AYqxfi64zgL8AvCQp9nmlfkFYiLOxlwBQpq8wIz+UNn1f+13HgBbNkfx7mWUy4G
 2raaAzgVuwR8bGlKE5ZOhzBFsTo1ELt1SmddyCulhLSlViXioX9WjZg7uJlAzGF6W34c8FHA9/U
 4LBzmd3evU7OqIPBpizuQIR0UvBJtnG+QKqjrQXKSCtLp2sl3ssYF98ZY52c6h8vf6LvKCf8rJn
 AZvKZRYYKZjpSvznXEE5+vLC+xz+vBzqCPHLuGDjL37EkuT0Gqcdoinpt4WrJr5tmZT7AjCtW5z
 2lsB3Y+f7suNawmsh9wpz1occd9kzxdS1XKU2nEc/mQdJm7W8ewvF55mJc8ORP30IHHffaGnsgA
 USDgAWmqUcHVwGWDUEAdT98HTPZulj51FIiJ2/tajssUKvvPs+pYYKLdaFSHiMmpJLCtM+FTC1l
 W+YlQntytWnqAGANknMRH4Aa1vipYv6tcGj7XsRy/YytPQLcymedcg3J2fhhMLhwP/teET2D0Rs
 Agk9HkBifhzw8cw==
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
  - v4:
    - use remote=%d, not with ':'. (Geliang)
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
index a7fb4d46e024..6cd71061ef3e 100644
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
+		pr_debug("msk=%p local=%d remote=%d create sock error: %d\n",
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
+		pr_debug("msk=%p local=%d remote=%d bind error: %d\n",
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
+		pr_debug("msk=%p local=%d remote=%d connect error: %d\n",
+			 msk, local_id, remote_id, err);
 		goto failed_unlink;
+	}
+
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTX);
 
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);

-- 
2.45.2

