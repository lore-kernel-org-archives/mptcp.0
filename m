Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676629;
	b=n/IpGFVY2fR2TQPtw5ELJE3uMm4YSkb4DvnEpTUVpgIvJ0sVaXPWcaN7WzHFDGJg2101
	 ewSPToMK141nQ27lTJ42YpmB0sE+n3eixwi+VNEVXFS5x9wuLVmU7Re+gMCZ+UT4E/nHB
	 86vWEDQnko218kH7N5gosF/aFTK4KobSf0xHax0fRid8kcvIpY+T7s4WK/yJ8bxahHjpW
	 FuQx5YMiXxx54fSlSNyEsSVllurxTNIq7UNx6Ox5kYekYaddb5EO+JO8O/ZGTz0JXAqPs
	 v76vcO/0ljcdMZvToz1meq8RkDl2zYCaQE8uIqmCr2JVX7oq7li4EcOYZ3LBGDZ67gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LuZLAKAg0bvLrM7X8UV5lVXuZgaYJtROK65eNV+J8J8=;
	b=Qj+NsGRy0S8ztD8OgNzA8Jxpj0fXR1MmFWIis07XahiCVNJHGNOI2E4LBZV5gduZvOxy
	 ewz6qGYSuvqfdM/0tAB3olWlQsOZlPxmILGUkNRBE92Enf8qu9C5rVtM+w15qNvXk24+s
	 hmIuSG3fwpjdUfVd3ldus7sS9DsEI1cslAdJldmktGHSKHhsUbzEZ/8UxvkPFI050x0QM
	 TSZVv3YcnUKgAAnKWbGL7nIgapeYuRIy9/mm8EZvSgnKtHrhwtLAlxKdirGcjqZvSXIaF
	 eqilHBeHXQNa0R9NCzM/YaGgzR+II6gL2ZLxkMCGPlJNHszpojO3TvJD5MGbLlqtfGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFNd9qbh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C5606D815
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFNd9qbh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC141F00A18;
	Tue,  3 Nov 2026 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676628;
	bh=LuZLAKAg0bvLrM7X8UV5lVXuZgaYJtROK65eNV+J8J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NFNd9qbhuR09rxgZsXOjxQmRMBG6XFM6NOCE2wuZZqK8JyxA8YI6vz6/uHSVbkabg
	 HHn+Q1oMIEk9S1W5UC1HMVyt24DM5jb50utLTuq3WBoGx1BWIPwm6lSrEZ9jfxn7X1
	 40dVLLwlsUH+eT1GzYI71WG94EvpR9pZMUjT8kFUNSS+NuMKJWfZamQKpeXQnxjqXJ
	 wf3eRGmhl1IbDmFljvGuaFF9ORTIDCQlu54XxpdHOMKiC2mBxoYen55L9EFYkByLxy
	 R/U7Yh8ZYupFucYermKiQPiwQM7KB/CWE54S0kcV43XBCZGOK4Cbxfbw4I7fIyLkD8
	 xlyzbDQ8bZEeg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v5 4/7] mptcp: implement peek_len for proto_ops
Date: Tue,  3 Nov 2026 11:29:53 +0800
Message-ID: <52dd6aede4a899de3ab622bf7329a95521e9770f.1793676064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793676064.git.tanggeliang@kylinos.cn>
References: <cover.1793676064.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_inq() to compute readable bytes at the MPTCP level using
mptcp_data_avail() (bytes_received - bytes_consumed). Returns 0 during
handshake (TCPF_SYN_SENT/TCPF_SYN_RECV), INT_MAX when avail >= INT_MAX,
otherwise the actual byte count.

Wire into mptcp_peek_len() and assign .peek_len in both mptcp_stream_ops
and mptcp_v6_stream_ops.

This prepares for upcoming kTLS and sockmap support.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1704e689bc93..aed25c901e4b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4791,6 +4791,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 avail;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	avail = mptcp_data_avail(msk);
+	if (avail >= INT_MAX)
+		return INT_MAX;
+
+	return (unsigned int)avail;
+}
+
+static int mptcp_peek_len(struct socket *sock)
+{
+	return mptcp_inq(sock->sk);
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4813,6 +4833,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4925,6 +4946,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

