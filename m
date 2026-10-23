Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720760;
	b=fK0H1hZwIThInhpQoDs+bJzmo0dSVnuqW4VQGGd8k/gMlfJXyE1548eald4qvRkzrRIV
	 p2Jjs3UBpZe8/tCsPimXPBKnqbVticoH3+ldiJU5d6F44Hg3QB5WMJ1FSdrGAkKfaO9RU
	 3weoqt1ZkFuT8SL0sRrn2apg+sGniI9aMIHBoAtqHfZ8MH296oMYYRo+pDmKiP/ncUPWW
	 Y2Y0GYrPbqj3MX0mP2Q8To1Fn8UACWapV3VZOm0K3HwBTFZyY1D6LVD2sXsvY+pdADoVY
	 nN+ykJBJxas1WlduHW1N4kwDM0CCqbH4gSbAN4Q3n0/RW0djdHI3ptO73EopITZF7cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720760;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+gOLQ02/NTNKZ+XxapkuoZpLo3esQRw2sPS8XUF0ZO4=;
	b=b5YOIZt+CtXVn+ON6o09FVpWXnjo+opLoBWX089oapWpXD/wOXhPFHScHbn91wK2IWjB
	 0E+5ItxGKMoYoLl3RHtpUcWjM1yRC3+iSXJI++zIUnZPiLrfJhvuCY0h1tK6L9IKh0pmR
	 DTsWh+GH/zb7/MU1UIppVSRzaPHIzpm0Ycnyx+za3b8jdw3aHGiTLDOa9ekzm1M0byokq
	 fiuEK9ZXJETY0V5WhApmSpOnVGuuNGcrVsy1Mp1z+abg3UC5U4pV2xvuysWipeOpdjECX
	 eHPHlm0rY1PEoi2H0+xd5aD5IIqIv9UvfYye1V95CFa5s4XtQMStcvbgH5kmEn2VmSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NF1A93X5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683C606A319
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NF1A93X5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55C81F01829;
	Fri, 23 Oct 2026 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720759;
	bh=+gOLQ02/NTNKZ+XxapkuoZpLo3esQRw2sPS8XUF0ZO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NF1A93X5Tkh5jOT6vRfpvx3NK62RFx2sAH3d5H/Sc71xNaBhVNcV/goZyhm8FdMxR
	 gv9eAo47s1bkDXeSONWLq+KPIzlRGIYFRMDyDs4i4ApxtcW5/nKcc5KgV0F5eAJnlD
	 gW10O/oQw0fgq+sR4WfaV5jjAmwL8iXEXtU1NXHpWIOLp4jN1zMQXAbaifHXEied23
	 RxCea9vFDoHYfFFg3Jr00iJN89w4OjKq8+kW1titzzwDDIUFs/hG0YquutY75Gm0EB
	 QfPr/sPuafkJZhyUcCX084c6RecBkW8EhSfwnUkWhG9DQIWEVo74V5I9NLOdh9y9U5
	 wHGEAWMZ3kHhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 10/11] selftests: mptcp: sockopt: check app_limited
Date: Fri, 23 Oct 2026 09:58:51 +0800
Message-ID: <24897c9e72a3f0a2d489dcd7f1c2413eef88c85a.1792718041.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
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

Without the preceding commit, mptcp_sendmsg() never updates the per-subflow
app-limited state, and this field stays at 0 - the assertion would fail.
With it in place, the value is forced to 1, turning this into a regression
guard for the subflow-side application-limited accounting.

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

