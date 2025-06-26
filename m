Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012B269806
	for <mptcp@lists.linux.dev>; Thu, 26 Jun 2025 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927331; cv=none; b=ipDrhx6RoMGpmJO6wel63qNrKGOmU1T+lq2IqJfz1/nn25MCj0bJWCPadRkaLIcNBTSwKP9fL9P62+t/I30IsfqRgCoWe2vMDn1f33659RMGAoJLlEN5OPgYKvuJAz/mFeip/fa1Tflzax3+TX4cWMmDTPDn/tRGaTKFD5jpBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927331; c=relaxed/simple;
	bh=qVqQvD+UaH+KTP7CqniiLub9SMXG21jxVg3IPxcftPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZ7iNVoFCtpDh4MHC86xneWWdVVUsV0hjvkCjQWJIZPCBJyBfTPY4vtkxPioU6bu3MMU+p4JLS6J0mrStwerCAvtVTyonOUTou2ncOE/7pFoaa3ff+WBoOvYNj2UPeBMsmrEA0cNupFgKHp95ukHW/G4GwhZq5Uu8HjxOFheedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryjL4RWD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryjL4RWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AC2C4CEEB;
	Thu, 26 Jun 2025 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750927331;
	bh=qVqQvD+UaH+KTP7CqniiLub9SMXG21jxVg3IPxcftPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryjL4RWDZwLCclNp8PluL7nVCP/me0Z7LyJnknpdlGtMF52gR3tKsIrG3qKyOzkcn
	 eLMTWb93+WjwgGLJu57at2z4Dn52PqYChZE5zSfUx4AGzslsBE37iwn06eXy44dswo
	 ZV+N97YktS1xiIiDFb5MxThxYPW159/Arniot3w1nyKxtCJziB/HrR1aSgGknqUxRQ
	 uwK5ABPXml8mwc4frU9JcL+zxKloXjbVsaIeHVpWb73QZjyJXRyu4AElN/NIQOTKRy
	 bdXw7pklGGDmzn9EuvokOeXbpFePCbFgJ19fB/EdzXmscwv1xSSBdTdy2/0Cb3msEQ
	 WpuTAZoXoOPAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/4] mptcp: set .splice_read
Date: Thu, 26 Jun 2025 16:41:52 +0800
Message-ID: <315a992a34bf8959af51ee20e64c57983a11310e.1750926916.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1750926916.git.geliang@kernel.org>
References: <cover.1750926916.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch sets .splice_read interface of mptcp struct proto_ops as
tcp_splice_read. And invoke .read_sock in __tcp_splice_read().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp.c       | 6 ++++++
 net/mptcp/protocol.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c18682c3fa33..98ce7a624b33 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -779,6 +779,12 @@ static int __tcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
 		.arg.data = tss,
 		.count	  = tss->len,
 	};
+	const struct proto_ops *ops;
+
+	ops = READ_ONCE(sk->sk_socket->ops);
+
+	if (likely(ops->read_sock))
+		return ops->read_sock(sk, &rd_desc, tcp_splice_data_recv);
 
 	return tcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 488a673f4da3..45db44700e64 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4036,6 +4036,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = tcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4141,6 +4142,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = tcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

