Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254185;
	b=R/UoM9fIA3o3fLPAmaUN8KSVz2U4xtlTYfh4JNXpCBnmVJUjVoFGw/gSv5MgVEMswpaZ
	 6lXhCcY6YlbJuc7SXcc5lruRufbRLu1A25yASOICYmseXN7xAQlEOE1q8dlVQhasIFzEj
	 J8qhxt2vicpK2o5a79UrLk/rz6nPqMJa+rVMaQuI8AfaMvWqVxFoezjAIjq54r+cdn2WU
	 Jdku/zDB+vTfpm9O+TnIUlkcAfyELpDmIHkkVd0vraHISI7CSBrS28a9p0BO/KhnAifxy
	 7OMcf/WkbdvK2GtbC6xRGeBN6UFAa/UTp+TJdyVXKGk4AWvW3Ydgf6tUiZ7eWuyFSHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254185;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zpWZlPBVCiZU4Klq+EK3McXXNHdBJVntksVc1z32c/I=;
	b=eAnNqVT4s1Gy8YW8yV4qyGioG+gmlmLStSBsfpkvs2bXcHOxIIMlcWJ/8JzmnJLWtT2S
	 CvlbH3zPmeIUpaV1Pa/w2IrhpDl0w27j9JLRb1QiHGXr7zckt0kDrQ5zb/hcJ1ZYd6R8p
	 TquhBxDQ51MMJYk6YakMPNoXKfw1dU5W13yO1UbFdC50urrfNwqDVHf1lYcsFYrwxXXV4
	 zG6o94Ab5msoAekff2brvZFpYIMtNwlrUey2HApJxs6haP+jcAeDAd5ONG84JefduttDs
	 Ea70i3LTeKWhOPkmbMYcHCIYa29xeo6dnLnkolh1KosHv/OCy2dpCv6fcFK21z8aVzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcx3dbRy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12138606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcx3dbRy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4B11F000C0;
	Sat, 21 Nov 2026 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254184;
	bh=zpWZlPBVCiZU4Klq+EK3McXXNHdBJVntksVc1z32c/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hcx3dbRySmkCLPqNTbAfZP8SeEcc+Ojdh/z1CMCabamOWrgDMDzHs/vKzYFfX69Z5
	 hTIeA0ez2tKk0DlI0MNK5/HdBRwuKUWQUrxkO9u5Z6/aeytXfsozVCZ+HQgPp+1rLw
	 gXPcI4hn3Tknl8wzVjhKlxzUP2j70nw2EwMjhdMdtr7w6FHIWc90fP+q+rAALB3rvh
	 jnh8gsmphHS8HsJD4qn1BrZZ0mteCP4rQ3Lb9Ci1zVLa+5bBoHmHwg3Nqn66v6GtlC
	 r5okBSMNq3SyEJoRJgbZQrYy7Xg+xlcBlQFeB7wEtO0/WzW6fb5J5Tgvu12noHpBrg
	 +GbvD0cK/Z6nA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:50 +0100
Subject: [PATCH mptcp-net v2 52/62] mptcp: move to ESTABLISHED after a
 simult connect
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-52-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=iusAQCSS1866tArMKq+LjT4eCh7/WIKvzRA5dM8TJuQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0/N/TBQsnhSi78i39/+Ci9Zs3xR2C6Yvf2RzpOyu2
 9o9WVsFOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZixM3I8G5Bin1RIO+RLpNr
 ujO2VBpInjZ482VKqcHRINf560VCBRn+CqvalUfz7zh1jYOrZ1PXI8fQ71XR4Uo8jVnTVuRJ7t7
 MDAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a simultaneous connect, the subflow moves from SYN_RECV to
ESTABLISHED when it receives the peer's SYN-ACK. Since the commit
mentioned below, the MPTCP socket only follows when
subflow_finish_connect() is called, on the next received packet. Until
then, it stays in SYN_SENT: POLLOUT is not reported, write() returns
EAGAIN, and a blocking connect() waits, until the peer sends something.

As it was done before this commit, propagate the state from
subflow_state_change() in this case.

This issue has been found by an AI code review agent, while checking a
review from Sashiko, and confirmed with a new Packetdrill test: after a
simultaneous connect, poll() is called. Without this patch, POLLOUT was
not reported:

  simult_connect_write.pkt:18: runtime error in poll call: Expected result 1 but got 0 with errno 115 (Operation now in progress)

Fixes: 71154bbe4942 ("mptcp: fallback earlier on simult connection")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent, after a Sashiko review
---
 net/mptcp/subflow.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 439a11d92281..7dbad6debdf0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1988,6 +1988,16 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
+	/* simult connect: not finished by subflow_finish_connect() */
+	if (unlikely(!subflow->conn_finished &&
+		     sk->sk_state == TCP_ESTABLISHED &&
+		     inet_sk_state_load(parent) == TCP_SYN_SENT &&
+		     mptcp_check_fallback(sk))) {
+		subflow->rel_write_seq = 1;
+		subflow->conn_finished = 1;
+		mptcp_propagate_state(parent, sk, subflow, NULL);
+	}
+
 	/* Rx queue processing is unneeded, error reporting will take place at
 	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
 	 * fallback: subflow_sched_work_if_closed() would be a no-op.

-- 
2.55.0

