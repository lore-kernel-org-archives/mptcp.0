Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000201;
	b=3xbQedcbx3owxwAcis5HeoLXc32Qyk8kV9A0fAO+r//s8p7MmbOusZFcWvnW91HqIFyc
	 wET5BaJtCrQUwdB+AJVWGz35tL2vPG6B1NeBXphGo5lHbJw35LJQMuhGMYJBLNyfrJd2s
	 BsigPdgU6xCCjeXdAVAoniclpOsRFkGS3Thtl6vblTaOSr4poYjQaxlQpWsCOXoPO9SmZ
	 H9RPT/RBuS4I12oYhoQ5qfc420FXMuKHJZENmoINiqaq+dIa7sp3DK78QKyeVB+o1LCqZ
	 +M+6p2hyjkpP1NH4mc1lX2/mUUxVIJgmccgfL9HneoW+ckrTpkI3oC2A+IUtd8yFpOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KmQGwESvjyYGFAEUCwtQdVEpNgzKzR5UPK/xoXK65Y4=;
	b=HBUSHv+Q9Tw+BDa0A8MyXsxp4B12uFscaLysBWIi9w0PyzXubu+avlykVEtGAOGXJF8m
	 iWJciveCFcYf68vJUYgt4U7AarTuv9tJbd9WDflh3/TeejeAqxBaRQzd0WWZ1Bb7GD7dO
	 mNvYk0VmRTFB0Or6k0HWFwNpzEsIC4KDEPqul5QAwkVXQX8RvSnqFrW7p922f7SrGk7b9
	 ZgOvg6EatcXga2sP/7+1PXJo6OKCv265ou8242L6XUBKaRC8xnOvpnTwNqT5ha7rUsyAm
	 7/fa00DuVZ+3sCTL2q1oZU02BsKccOrA/w0gY0HiZ/hNz28161Rza4ZiymvSbxgMRsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJCVMbtb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E7606A31B
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJCVMbtb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F061F01828;
	Mon, 26 Oct 2026 07:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000200;
	bh=KmQGwESvjyYGFAEUCwtQdVEpNgzKzR5UPK/xoXK65Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LJCVMbtbZR+PKVphVfl/pM4RZ6k/xmqyWa+BR0jY6cveN3qM0Qpb37rnDJ1Imd5Qn
	 3g1lEHAlIBi/9MTbBD3xGC7VKfH4Eow4vgbaL0jJT1466A1J/OCneeO1VPz4JcnbZ5
	 VhsyHpb7eKkFfEIKQAXjB4W2CxjnP+Se0NoSkrGR67Rhjiy0fN0LcETQLu4P3HgriB
	 vYmwlxIEGQ0B0c1BES20gd8zQ4WvDTViN2qZN/E+w1OJDeMdVn6zO3CpxUlWf+oDPg
	 JgkcT88u5NnENMUcC7BoyKMijD73sAVV46k6JIg/o8qGHUBpeUObvlzTrHbSViR3zQ
	 INFXGTQqYL4iQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/6] selftests: mptcp: sockopt: check app_limited
Date: Mon, 26 Oct 2026 15:36:22 +0800
Message-ID: <8e5aa0a0ec2790efe1e793cf88ab50e11ef6302c.1792999988.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792999988.git.tanggeliang@kylinos.cn>
References: <cover.1792999988.git.tanggeliang@kylinos.cn>
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

connect_one_server() in mptcp_sockopt exchanges only a few packets between
the client and server, then closes the socket. After such a small transfer
the application has nothing further to send, so the connection is, by
definition, application-limited.

Extend the TCP_INFO readback at the end of the function to assert
s.tcp_info.tcpi_delivery_rate_app_limited == 1.

The rate_app_limited field is initialized to 1 in tcp_init_sock() and is
cleared to 0 only by valid non-app-limited data samples. Without the
preceding commit, mptcp_sendmsg() never updates the per-subflow
app-limited state. In lossless veth environments, valid samples typically
clear the flag during data transfer, so the assertion would fail.

With the preceding commit, mptcp_rate_check_app_limited() re-sets
rate_app_limited to 1 when the MPTCP connection is application-limited,
so the assertion passes. This turns the test into a regression guard for
the subflow-side application-limited accounting.

Note: This assertion alone does not prove the new code is working, since
rate_app_limited starts at 1. However, in practice, valid samples clear
it during transfer, so seeing 1 afterward indicates our code re-set it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b8158a1198eb..f7a45b93cbe0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, total, total);
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	/* app-limited accounting requires a recent kernel */
+	if (expect_all_features())
+		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
+
 	close(fd);
 }
 
-- 
2.55.0

