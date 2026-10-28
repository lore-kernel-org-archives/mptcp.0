Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793178652;
	b=H6c8kFQfl14gYzeCrU8+8n0cQe3c6VQDPt6x11F7UAtj7dDv/h6r1GFjidnRLcFJjHkr
	 SfvNKEDzXKpLNmOeJyBzA1G5n0G/MGnTg+1neiUNziOUrILI1XElpRk+JGQ/BNb3eTXXq
	 73oCYCUYS+UZ7EI4y1UujZimRWX21Dsu6xSZfkhkHjPKoVnIwn7K9M49DMeFYwbr/gmkk
	 GfiRDnT8u/6Prsy1smaWzJIXue4a1vomnG6faEePC8CHMP0CYTW1t+vYH0sTcE8Y9IZdV
	 M+D6azSUYK3ehMPZFl+Qsgz6Pv8IpcNL+PvNHUoX4xcb3ZCVNrQJqpTWzvIs64xKM7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178652;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yhHqNhSKL7bxU4tHGrXaO5JdZbZSD5e+AEeLcG4BnbU=;
	b=3hR3j7Azw72hkD6wwjAFI3MD76mSzd1mdXtQmk26Ipis6ak41lS98cfj21D7/mMPRkKU
	 fjkEh980JE9FU7g5wZfz+V1rt5KQAs30LjIDY5myUemrmsx3Y53Imcdpmmc64k/5V+Ick
	 +PyUm2sgN3x60hRFO3DGvZHV0mMxcpYdUAAl3dqLd+d3QJ+NDRcJ+Z37VHGEkJG/Jid+F
	 uR1xf38e7WPC0LMcyETCnjyx8vmfF6qS/MzwV5pR945pgC9HiX9tK1vc7y5jNfFtJuT8Y
	 wZ+IEZznDBiKwA9zeIJO3zXwRLoxTMa+Df3DvUnhQt45QXWHIeIE0UPwidN5Adx23CQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2PZfUYb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A363606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2PZfUYb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793178651;
	b=argA60ElkfMRYYXbUwRBoodAoOQhZkjcB1FNluKPA9R2GnlVoLTmlggJlQsyXEr44092
	 2o1/abYdCkMKm2py/z+3eFJp7LUT9/fNm9P99GztGKYsHUFPjO/kjYAyIHCUM+lbKm5qJ
	 /HVpTvb+p0JbsfL3+zQ8jApQfRBtgXzKaUePXRJmUlieq1hBySu7kRa4asRJ4JRMjvxEB
	 Li6ummHNEs4xp6xNh0U9Ag2LGihBeTFRSqvN1T1wyxX+h208zGhwtGqdsLy2sW/Ih3bbO
	 /WrbeC7b5pGVrpiNDk9a05w4Dl1JAd5Vus32XZl2jCLai/D7mEdcHrSpPRzs5DmF6Bg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793178651;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yhHqNhSKL7bxU4tHGrXaO5JdZbZSD5e+AEeLcG4BnbU=;
	b=NtfQiTHyWlK2B8wK20dimFR5GnD3uW7tlPK99ODyJ8OZzMmetWtQHwaVKvSebMURpuyP
	 72yaPjCbZodtC6v5rTiDIATFcdh0dOWfoXL/1Y5dmMHDNM1fllo+RYTrQE36++axzUrdP
	 rJShPcOyVJGvO1BVAkRcKfhQ/fmURxoAxTgFT7PqWHMHtccp4NuupeVJVUhQP9ydSR7tq
	 05a0Pjm4V3bqu0qoa6oxqzbV254AlpnuBlyt+LIpAmi1vz9GItg2jM+oTTqkYq3auXNo8
	 yxZK6l0mckyzFeDtgQP1ECZnnfXO4I/Gg1hwMyQVj+NMNWCtLMmwraO2OWSwwm1BF2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5B0A31F01825
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793178651;
	bh=yhHqNhSKL7bxU4tHGrXaO5JdZbZSD5e+AEeLcG4BnbU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Y2PZfUYb+6Y8VVoUrNq/bAU8cTUGsERvRtl1tyy/Ga6TqmSXYIlnBKtYCQOSK9xx8
	 DPilbnRHaref9X5az9PmAoFH+t3Jy/ddoimEwNLhLrTehBApupHarrP1L3FcnbluHr
	 Mi5bNp5U+UL5MprpyY9cQ3keCrPXg9w0G2sEFoLID6yBjj91RzmXz0w/Y7yxUY2Jkq
	 tCvDvD9jmzVRfRhiJul4zfS3kvhTF+CEUL+1IpkwSSJnLOF7iZrbaMKQacAIJigUlo
	 qelOF+S1i1n2/VJUwAAy45LLHCdzqLb3JFRmyrSK2wsxUbHnHrFZ12QxJjYAUuXABE
	 vPbXcbwa+eypg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF3C8453C8
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 09:10:50 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Wed, 28 Oct 2026 02:10:47 -0700
Subject: [PATCH mptcp-next] selftests: mptcp: connect: fix OOB read on
 read() error
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
Message-Id: <20261028-fix-mptcp-issue-636-v1-1-1f1e2ee07a1e@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7kAm1lB6ldJFTUYdoWnIxCKId
 zety8d//22gnIUV7s0Gmb+i8okV6NKAn15xZJRQGayxjoy94SArvlPxCUV1YXStQ+pMcFeiIbQ
 G6jNlrtq/+oBTjrwWeJ6bLv3MvvyysO8He/2o1IMAAAA=
X-Change-ID: 20261028-fix-mptcp-issue-636-150d6411fd30
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793178649; l=2933;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=5AkzoNWl9/i9Wmm1H6HE1sEtdhjRlQBNIjrUVgGp/uM=;
 b=/izKasSmI4b1Ey19uaSP6XVUothrGxwM6rdH+FcDKYdHRwVLuUl/eyfy25t6V+3zCSjInfV9m
 PejxSgd/PeLAIbIq/ijUSxuzB/5t5egbag8IxH4f6oWl/i4YhDDiQch
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me
Content-Transfer-Encoding: 7bit

From: Quanye Yang <quanyeyang@proton.me>

copyfd_io_poll() and sock_connect_mptcp() store the signed read()
return value in unsigned wstate.len. On failure, -1 becomes UINT_MAX,
so the later "len > 0" check is always true and the error path is
dead. do_rnd_write() / sendto() then copy past the 8192-byte stack
buffer.

Keep wstate.len unsigned, but capture read() in a ssize_t and only
store a non-negative length. Retry EINTR in the poll loop; abort the
TFO connect if the input file cannot be read.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Fixes: ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/636
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 32 ++++++++++++++++-------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..d124fb96db15 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -398,9 +398,17 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			set_mark(sock, cfg_mark);
 
 		if (cfg_sockopt_types.mptfo) {
-			if (!winfo->total_len)
-				winfo->total_len = winfo->len = read(infd, winfo->buf,
-								     sizeof(winfo->buf));
+			if (!winfo->total_len) {
+				ssize_t ret = read(infd, winfo->buf,
+						   sizeof(winfo->buf));
+
+				if (ret < 0) {
+					perror("read");
+					close(sock);
+					return -1;
+				}
+				winfo->total_len = winfo->len = ret;
+			}
 
 			syn_copied = sendto(sock, winfo->buf, winfo->len, MSG_FASTOPEN,
 					    a->ai_addr, a->ai_addrlen);
@@ -698,8 +706,17 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 		if (fds.revents & POLLOUT) {
 			if (winfo->len == 0) {
+				ssize_t ret;
+
 				winfo->off = 0;
-				winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
+				ret = read(infd, winfo->buf, sizeof(winfo->buf));
+				if (ret < 0) {
+					if (errno == EINTR)
+						continue;
+					perror("read");
+					return 4;
+				}
+				winfo->len = ret;
 			}
 
 			if (winfo->len > 0) {
@@ -726,7 +743,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 				winfo->off += bw;
 				winfo->len -= bw;
 				total_wlen += bw;
-			} else if (winfo->len == 0) {
+			} else {
 				/* We have no more data to send. */
 				fds.events &= ~POLLOUT;
 
@@ -735,11 +752,6 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 					break;
 
 				shut_wr(peerfd);
-			} else {
-				if (errno == EINTR)
-					continue;
-				perror("read");
-				return 4;
 			}
 		}
 

---
base-commit: f2f79e9af965c1c49decfe56312fa547095fbbee
change-id: 20261028-fix-mptcp-issue-636-150d6411fd30

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


