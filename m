Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871845;
	b=fw2LWM3nbyGU+oEyhd1b/N64fMxJnFwc6oEyOLQNHVdlgiocqw2DjqrhPdsIHeim6GmB
	 MGx5ESbTmk8wwxlxawZbolmGHbX6nkL9isbULOgQTMdshbbaS/rVUtC/WaARRyiO8bQZP
	 ca4Z051X2ZANf5Ew9y1S6tfbJWWKkyU1YoOEqku+/DLClwf0I6Brfe0M6o3qzT1s/M/hR
	 gUqhpSZ7QtFp0smLs/hS4qN1Coueu5aj1ujPSm5cm7ldjyoJEje+RlpoVev/KsVMVq9g1
	 3PAam9yHpj1rBxbzSeNhPCK7SAx1VyKU9HbIStHpMeZuCsrrGsvPUIaK/psvXrKnsRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CVR3HPFDTAux9250vea+j7gGNnDua/bbghWwUX+BJ40=;
	b=11OL6aTy0tlF/EhQu6d+2OxEBQugge59c73W1V8yuVBmkKdR8a+ZT5dM1VMMhYLZc3mb
	 ICAIHbYKdp8yuDaY+NpG24MVgWP/8oCxlZXaxacSed6rVr8vPMou0FI15yjwwN/MV1J/m
	 ya9c6DdtDGopm32LMI4yeVryR1yz4sMX5i2bzxSXOit+/lAwcfzPwJCOGUGQHUG7juBsC
	 r0cmjicyVH/edh2pCTDQeDv142DSckZ5/77dTkXpVinPIfHh7VvvAD9ghqykjqSnREkO/
	 +4xrzgpFVPcDp73WvORWle0YEbyryHdh4mOfFnsahqXJ7gZ3TTcl4mMiNrxP6/OXM6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nX/+QMow";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F003606A329
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nX/+QMow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB081F0093A;
	Thu,  5 Nov 2026 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871845;
	bh=CVR3HPFDTAux9250vea+j7gGNnDua/bbghWwUX+BJ40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nX/+QMoww61tpkCWckVFEJqWO5FrQtNmQQXXu8/8XARbrKI8X+FeFNmfhWeNaXTi2
	 n+Z/ZS420Cjz77wYFIQMZuGNhMAe1IVAqVmFIodXzidmI56fQPJpPX8UZ5MCd2IRXK
	 7rCScGzgS+PlZ1cjLiEiuNSplnmni0Jls3i//EGw11YmQNUZ5jt6vs966IHetO3fNQ
	 e5IHUWzRE3G8klzLiWZTW1ZZwvcohomEDBK0DrBZDeWTpTFPO6cJIKLcXZ3laZgsE/
	 nqJEzSX5KqtohD7YvwnwVaxuJOEKF+Xjrh4/xWCxMUkFtuZruoHm9GgI4pzjNEPIGy
	 XVn6huA+2ZD0Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v21 2/9] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Thu,  5 Nov 2026 17:43:45 +0800
Message-ID: <922016b6ad6c68e0ead315b54c6849e4e76ce2c7.1793870710.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793870710.git.tanggeliang@kylinos.cn>
References: <cover.1793870710.git.tanggeliang@kylinos.cn>
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

Add a SIOCINQ check in mptcp_connect's server mode when the MPTFO socket
option is enabled to detect TFO SIOCINQ overflow regressions.

When a TFO connection is accepted, the test waits 10ms for the third ACK
to be processed, then checks if SIOCINQ returns INT_MAX. This detects the
regression where mptcp_inq_hint() incorrectly returns INT_MAX for passive
TFO connections after the third ACK sets msk->ack_seq to subflow->iasn.

The check runs when the MPTFO sockopt is set and uses ioctl(SIOCINQ) to
verify the available byte count. If SIOCINQ returns INT_MAX, the test
fails.

This test verifies the fix in the preceding commit "mptcp: fix TFO SIOCINQ
overflow in mptcp_inq_hint".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..e30a6900d01f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1207,6 +1207,20 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
+		if (cfg_sockopt_types.mptfo) {
+			int avail;
+
+			/* Wait for third ACK to be processed */
+			usleep(10000);  /* 10ms */
+
+			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
+			    avail == INT_MAX) {
+				fprintf(stderr, "TFO SIOCINQ overflow\n");
+				close(remotesock);
+				return 1;
+			}
+		}
+
 		if (cfg_input) {
 			fd = open(cfg_input, O_RDONLY);
 			if (fd < 0)
-- 
2.55.0

