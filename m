Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259516;
	b=X0WRRFRABoOgx4uGOyd6mWpaLy6H8mj7esUNzID5J26LKsFglwP4getGJtU3Om1wQltJ
	 UZBqJqPHE4Hp5jwo5BCqOY4CD+ZvK1rM2+1smb8frWK57/0DXi87b/lMMgNURIOqV36mV
	 n3deTqXIX5FKZ2s6/WNQ4Izh1r7FTPbwKKLLEugd9FZh1YXSZn8BWFRNhXWoVwjzILWh6
	 8b7TebG3A9IJQfvkluHyM3SYIrVBhc9HtRygUi6aYrslv5iPG/zxuutEDRXZVQLFggWmh
	 5263BBatR1yEv/bH0zK8IKrE8Pfl9525nqhEk08cq1CTceoIYeDK+DKxeBzldYk0DwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259516;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=48aP8yultl2N1uAKM9qu4QFmyzBybo5hhc2Ox9jrj1Q=;
	b=SszT/MKDGSiUOU0l+X6bZBgwShtEnVBCUWLFP3OQ4BF/n159TVQMy0b4qhWoI63iyrTj
	 U81aXwwFeQljKoq/Fxv2AwqLTFm0LZbxUPsqbeoApLmh0bcR7qOR9gVpeK5FoLGPeybro
	 Elvl98i0aWSWgIF0Z12Ug8oDzL6acGqU8m2PEd80XfGeAALOqJhbgRmh/zL9pQ1Slkw1J
	 apJhllntnUarkYop0M+/4MVbppWZiY//vOZUQHDmGeb3BLB9DFkv24WbOSyMTNzUZCJ4a
	 um0WoPtTwMkM8r1t3qZ32AklNxPz/zShpICFu9QsJ5+xoidZs67A3BWPAtdHxbuewrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PooKzCE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270D606A31E
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PooKzCE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51931F01825;
	Thu, 29 Oct 2026 07:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259515;
	bh=48aP8yultl2N1uAKM9qu4QFmyzBybo5hhc2Ox9jrj1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PooKzCE1bZzc4UihqitudJDOvfJ0qz85dz4EPsQcKsBPQMuS+RKN/yMZxtkD/OLxC
	 /AgzQGC8fMNy+FsY4tj6tD0pSQyNvp1fhh3LeAg3gvaxf9oPU+izNMrPPZH9RvbrtI
	 uKhB2EkQ25YSZpklExhGo2bMjo3YvUYzjRgIZrdIKir6gxS5YtFh4kR/ttL9Lh6H0q
	 OBSVOuRVxSIIOlLdci41qhLlIe4ZFAUlXguy23TwjHnb9i4mMlTjQMZLDyAtVrR+Ta
	 R/OHbCy+ydQYPinl8L3B/EYv4sfXu6JOgQ40IB9v1gbC0OZmOb8EYS/pxp0kcr+wkH
	 khT3I3AoPPHHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/5] mptcp: track app-limited state in mptcp_sendmsg
Date: Thu, 29 Oct 2026 15:38:16 +0800
Message-ID: <2ff471fbc06c1c748865e61116b6f386310a4d00.1793258749.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793258749.git.tanggeliang@kylinos.cn>
References: <cover.1793258749.git.tanggeliang@kylinos.cn>
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

Add mptcp_rate_check_app_limited() that walks every subflow of the
mptcp_sock and runs tcp_rate_check_app_limited() under each subflow's
socket lock. The helper bails out early when MPTCP still has unsent data:

 - msk->write_seq != msk->snd_nxt: new data not yet pushed
 - mptcp_send_head(sk) != NULL: re-injected data from rtx queue during
   failover or stale-subflow recovery

In these cases the subflows may look idle only because data has not been
pushed down yet, and marking them app-limited would be wrong.

Invoke mptcp_rate_check_app_limited() from mptcp_sendmsg_locked() right
after the send-side setup, so the delivery-rate app_limited state stays
in sync with what the application actually has to send across each
subflow.

With this in place, subflow rate samples taken while the MPTCP connection
is genuinely application-limited are flagged as such, allowing congestion
controllers like BBR to ignore them when estimating bandwidth.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 63d83d4b188b..8289781a80e5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2038,6 +2038,24 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static void mptcp_rate_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk))
+		return;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast_nested(ssk);
+		tcp_rate_check_app_limited(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2068,6 +2086,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.55.0

