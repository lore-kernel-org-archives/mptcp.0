Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588353;
	b=QERxZfNDn/gS/wPX6FGZ/dg5Jp8Ik9kTUFgZ6oJeVEDmh05wjkIQhGiSsfkrzDQmRUxJ
	 KtVIekhi+sLNiRr1VIIqgURYBM1JOqBDwxBt++UNdaVcW7OsmIU7BvUPkVD3ePMr9nwO7
	 bdx+HzQUrIq6Mhqy/tCTv92aP9Uv/Oh/jKumyadjoKQsNYYSE38HkRPpndGUi86+4vcmW
	 ZSvhT3BSJ5kZ+iC+gAXD8mg/Ze8TbyoJn9yaCROUGzWc6sE7LDUkpQRL6or/fdSRM7Ngp
	 qNv7E/m6idjHyOL9yb3iTC62MWzhmwKbwKSfmkmNpOOONOpeAPZyodme7EYCwKam24Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588353;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7+j85nzl2zC+6eFpOE4tO71tHI7dTH1G+8o1HEDJfMA=;
	b=Hq8DR20mkIZ2K842aEhFHS/vWNdAtBtoCWT87bs1Qj+QV+0MI7OOPcUcCQPJg/ib8WiL
	 w23VjFbEe7v7eW1xwfuyDhfKtT/9I/ARazs+TazhPqFGtG8N57TInSQhtYTAB+f0JYtIF
	 7a7CqVzB+7vGa/YjCxqT4U3fcwPDdMkcwTQPAhqUUmBHXRf/2g2kSok1bK8Fgjc4LsT4f
	 2dK1kVbrqQGR1XJgB/RSndyhm1HYZObL+pzp8ddcSWNS6mlJ1JTb1cImZxVzL8n6k+VSf
	 fzxl8fwSzkhWRI82ONr5O/20+3wGDE+TTkUaGwL226yTIKLPHr7x42BY1IZuxpRwUZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHLBM0VS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B0606A327
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHLBM0VS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CB11F000C1;
	Mon,  2 Nov 2026 02:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793588352;
	bh=7+j85nzl2zC+6eFpOE4tO71tHI7dTH1G+8o1HEDJfMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHLBM0VSzJ0KSleUonqf/yA+j/3cdrLPSULEuaSqwC7pMY2intCJqLyXaKqX0kIRi
	 WH+Ai0+rbFrHaIgHT6VrXOckn1ASnS8/0Xz+SHX6vggG19WDlpXDt0yblUKFqkxccC
	 7042RZEj1ts1IQgmx7OkpMyXrC+wI3TZa/SaIghv7SU+LViVSBnGzR5RRvlMC6Mc/j
	 bxNZlSstQHj1Fxcr7dk1VbLVenY2p+cnD96T0hjhZtLTzeDBKMNvHXTI2BWR6DVtmr
	 ks2ZAFOOYi+1EDjhjxJhzl8+1nroL+dClJyyw7FDyRWo3vFE/u1ViO5yYkLQRyofqe
	 GcPkGALKNvqBg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/5] selftests: mptcp: sockopt: check app_limited
Date: Mon,  2 Nov 2026 10:58:58 +0800
Message-ID: <fa310c64070f371407d349176127dcca21ba6d8f.1793588257.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793588257.git.tanggeliang@kylinos.cn>
References: <cover.1793588257.git.tanggeliang@kylinos.cn>
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

After a small data exchange, assert tcpi_delivery_rate_app_limited == 1.

rate_app_limited starts at 1 (tcp_init_sock) and is cleared only by
non-app-limited rate samples. The preceding commit makes
mptcp_rate_check_app_limited() set tp->app_limited on subflows when
MPTCP has no pending data, marking outgoing skbs as app-limited so rate
samples don't clear rate_app_limited.

This guards against regressions in subflow app-limited accounting.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b8158a1198eb..9517c530ba21 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, total, total);
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	/* app-limited accounting only checked under EXPECT_ALL_FEATURES */
+	if (expect_all_features())
+		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
+
 	close(fd);
 }
 
-- 
2.55.0

