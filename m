Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254162;
	b=ZyXNTAxyMsO8y+QgGnlvvu5nLiTKxHO/pwnZLJvE6cA6GbyfI+fEH1IU+cay1YjlFmbO
	 k8jmg0hu6elOM+IQr5/B1IX1v0EiaCCplCv4eFjKW3X+tQQXhNPGVF0jkpyDypt6gaMtm
	 5k7pB9R4cqgQP5+bQTKSHJ/g5G1qQSm4ubnMY4ciQPvvQpfVgqQcXycF4hAkysnwjfBDB
	 P1fnIsHyKGQLwUBx+60oc70sGA7sm7vZWZge1aSUqqpJD/cjtRD2GcRfWcINnGipxMXmb
	 cKDa3X/gm90DDKUe3T+UFGnow8QzuC9Lgf0ThCkAmGQXHHU20sw/fSrnRgk5cwZyr3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254162;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HB2OHBvvzYbf8EwS79YRZiqj6o7oXeyxYII93t5xl9U=;
	b=vutNjkdyyvzTAo11v+Ah0NC2zOBS58t7w1m07JV8PFjs1VK//KJscqvuuDWxERFNbb6s
	 pfG/cFc9rWdVQrTJRF3Z28HHwyNP60tdGTSj0bAorBPHA96ZmkleVHnPUy2qUcZ8kShhG
	 65UW23RwGqcFac2ZEWsGUMWD6pg5McVXef3Zjzb/mCL+CG1ND36AUQaTRukQXJcMOHqL/
	 2pcdO6CVMBXA7BYXoBYh106DoCzAZaLVhrX811IWAPNqa3hYyBvW1Yp9twQ9ebnoxayn+
	 T3BV6SOv3JCR2FHhdtYbLmDRTIZ2Uwh3Let/ZscK2YEQVzLrJx3b3LjzJw9aM9/Cphw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=biWPZuto;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF10606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=biWPZuto
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593F01F000C0;
	Sat, 21 Nov 2026 09:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254161;
	bh=HB2OHBvvzYbf8EwS79YRZiqj6o7oXeyxYII93t5xl9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=biWPZutoSIKgL5Woioc+s7DGgQBLZP5f8ojHXbnIRZC2SYLbOz6ZHM7QRsQYKKjHb
	 mKU3vuzlZWnX+VvA+Oy/6jVnOaaiWTU+b4u+B9gzYDHAzdMdhd2SaE/fO984y4B9u0
	 MQeV9UmgA0MQNVHsKjl/2bI9ZKx01yOOjNRNLrk4Uw0tj2Y8I3nZmOr9YJJn+hUY3o
	 F5oqFrPpDXQlfogKhKTb3uOn9Unq4w39obSj5bjUyXN+u45Lt1zseWJYwigKYOOQiI
	 gK2C4V9U5LRB5XlOSJC/xpJ2ZB/+WjOsCR1PdPnjQmj2i7yCU3fwsTqNP64Dk7c2GT
	 IwFATHVIowwiA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:24 +0100
Subject: [PATCH mptcp-net v2 26/62] mptcp: clear DEFER_CONNECT on
 disconnect
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-26-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BRYXGZR7H+Ax4fERPJpuwBYcNU1ND+UHh7AH2yQJ/+4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ06PPirq+EdzA+/TlI+6g9QlfF3Fs+NEaNy1U7IRh6
 ZS/31+7dZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkRwIjw4Pfl3y1LsyojW7f
 5RK5KazAU0mpjK0nQlEv8ZdfXeqrNwx/ZXpYfkpF3HYTeKff1PlvQsES7wn9cjwvDZfZSFXJV7a
 wAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP_FASTOPEN_CONNECT, mptcp_connect() copies the DEFER_CONNECT bit
of the first subflow to the msk. This bit is cleared on the first
write(), but not when the msk is disconnected, e.g. with
connect(AF_UNSPEC) before any write().

tcp_disconnect() clears this bit on the subflow, but mptcp_disconnect()
leaves it set on the msk. The next write() then goes through
mptcp_sendmsg_fastopen(), and tries to connect the msk again with a NULL
address: mptcp_connect() moves the msk back to SYN_SENT, possibly
allocates a token and increments the MPCapableActive counter, before the
subflow connect() fails. -EINVAL is then returned, instead of -EPIPE.
The stale bit is also reported by the diag interface.

Clear DEFER_CONNECT in mptcp_disconnect(), like tcp_disconnect() does.

This issue has been found by an AI code review agent, while fixing a
similar issue, and confirmed with a new Packetdrill test: a deferred
connect, then connect(AF_UNSPEC), then send(). Without this patch,
send() failed with EINVAL:

  client-TCP_FASTOPEN_CONNECT-disconnect.pkt:35: runtime error in send call: Expected errno 32 (Broken pipe) but got 22 (Invalid argument)

Fixes: a42cf9d18278 ("mptcp: poll allow write call before actual connect")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a61317853a0..a9ce2b6317d3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3804,6 +3804,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	mptcp_check_listen_stop(sk);
 	mptcp_set_state(sk, TCP_CLOSE);
+	inet_clear_bit(DEFER_CONNECT, sk);
 
 	/* The later subflow close can not kick again the tout timer,
 	 * as the msk is already in closed status.

-- 
2.55.0

