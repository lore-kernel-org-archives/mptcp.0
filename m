Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254161;
	b=vYMat2nS1n0BgzCOUecp45LV7EwHNADtVkr9Dr1R5a781cD4VvMZP6FSHrIDhwBDlHbv
	 vOaN9IFYAqjejFVIePlZNi3BkqqNv81Zv5NTsrEFSjqS7Yjpxxnn3sbpkThO9XN8Mx+VG
	 lf2iORC/5IGBbYIYs5dDrdPdN3GDImKb9Ou1VkNVNbXhmO9H1KsrosY668eq4OAvOUC6N
	 kkZ+zocjD0IO+0lBO8KfPZCqveVQ2NpHG1S+N0HR/1xdpzZzJfOWbo/yWOOI8fBwiFqiv
	 eYzoGqeTp7jJzuYdD3aPTxQAXajkrJkAvANv5aGGpuwrA9k6b5pyB64bT2pG9T00Zzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254161;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=diPMj3YCrIOTW2Nh3saxSrDzK9Kwqprzsc9mQjIy0o8=;
	b=CFiokhv44yN1gNJ3HILbtTf0UuHDWACt+Zurnk1Dm4jkgfYOzMTMnxNtCsTvEnVWs7sQ
	 3AjCa9DbaEeOhd6gBg5BOWWGvXlaT/WHz91Jb/nuNq93y5N0GmiVefVo1XORySt2AI7Ru
	 PfSEhnj5hluUAl5cPCb/gMq5LmoXTngxBEGd7QBWtKTdrAYo2IRkkjB5azi1mHiKv8Npn
	 5lKZ2/pg3WwqW4t3WXMXQplouRe+SrA8OjlTximJ2K6wrhipP4kz6E+MEjEDSa9+l5+Tn
	 j2e73iOyJx3K6oQNejqT0I2YmCjL7Pmab2aDRraECDN4pvIv3iGkhyw50CeW5yPD+Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEIMzbVt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCAE606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEIMzbVt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CBF1F000C0;
	Sat, 21 Nov 2026 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254161;
	bh=diPMj3YCrIOTW2Nh3saxSrDzK9Kwqprzsc9mQjIy0o8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aEIMzbVt9SMMbLOt93htAX3N9vSE8QRrzMsRkijHJgxZQ/q9bl91OtzvvVc/S+Wgs
	 4eJgkez905QskjrhNhhm0QluQijvXZIiA96/RrmP7N1jEORDVUvzJ91PTSlRsFeTka
	 xUBziYLGQEuzPODyP1gimfZjmbp4Pq2V8eei2emE+uDCUswAGYyZXXJZ0S3gaH18ad
	 F0c8i/zlMH6775NFiE0sBH3UMag2RTL7s+uId4rdb9AvMYmkQTroNJFDVlOr+liXPy
	 Bq9V3IJtaRfuNsUOAvo5PlLRF4UpdS4cdkIVjeXQgSuSbojBqwrpmwNedfj4QB5zGq
	 pdmAvdV3MZvfw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:23 +0100
Subject: [PATCH mptcp-net v2 25/62] mptcp: clear sk_err on connect(), as
 TCP does
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-25-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N3uB6wPzh5xVoUSi7P3stUX93lKm4vXC1l9psyDwGqg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ06OConN4l78Jjmp/KHf6HdcObb13ThPXLQwWFzxo8
 KDmR0pMRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQOHmX4p++cMEUuYPrMedOe
 ejnlCvIafLQS82LJOq3Ks+6Afa7gN0aGl25W26o67Wss91WafpqcatgnU5Ga0pOoWhDifJr9Izs
 bAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a disconnect with connect(AF_UNSPEC), an error from the previous
connection, e.g. a reset not reported yet to the application, was still
reported for the next connection, by poll(), SO_ERROR, and the first
send() or recv(). TCP clears it in tcp_connect_init(): do the same,
once the subflow connect() succeeded, so an early failure keeps it.

This issue has been found by an AI code review agent, while reviewing
other fixes, and confirmed with a reproducer: the peer resets the
connection, the error is not read, then the socket is disconnected and
connected again. SO_ERROR then reported ECONNRESET each time, while TCP
reported no error, as MPTCP now does.

Fixes: 3d1d6d66e156 ("mptcp: implement support for user-space disconnect")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7700265a13ce..9a61317853a0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4428,6 +4428,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (err < 0)
 		goto out;
 
+	/* as tcp_connect_init(): drop an error from a previous connection */
+	WRITE_ONCE(sk->sk_err, 0);
 	inet_assign_bit(DEFER_CONNECT, sk, inet_test_bit(DEFER_CONNECT, ssk));
 
 out:

-- 
2.55.0

