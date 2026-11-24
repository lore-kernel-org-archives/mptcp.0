Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557678;
	b=l/FyFlhA5Ap5Zk7pKK0b9sr7Z2y3gijcAVsgP6cXuVMlqWWCu9RUcoS3Ad8ioBhEEYtz
	 VxyOiZTwv9EsyJQ/i92lFVNIc8pex/kS9xHuGF9R0iSxAzq2uyieor8G7RLHQS6jdQDGk
	 OpOy1mZVjKKHxlFZhE0Ia+svRp2PKvFjglneqfSSYH8gl2b+BF1tiofCPOtqLCLPz9P+U
	 HI908pypyWjiJIP8zgNRJfs5Hb8ZMPQFZiF0Lt8kyh7WM5QqH704pu96bEcamlMEG3UU6
	 /v69Hblxo+P38VNTN+x+NRMLInCFCFTukbdogby1vH8D7MLQPQknpa5B9bYbBY+7X0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557678;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=A2WKkWuXfehR+p/MU356k3jOwQIB5NV8XuJQ+feAN78=;
	b=tonjaaUjmEyKFcmQGCIRgx9ojkmfh+aoSAKb9o9/pr+qnJnWCa9FWnjWaOWgpgo5DilG
	 Wecx/hwrrdn1FjGBsVd7Oan7tO43W00m5XRfq1eOg3x/D1Skc1vmBxxb2hrbMmMVLSLOx
	 6fW7CCZm3maSH9IJAAJAYB6Ac+Ag4HrIpwPMtW5pZH+wnv2/LnHamm92cGj2P1acEsXjb
	 yjFUse532ky3pg5M7P8feh58Z8r+59uIhzbcir24jpxitgCZ8+VsYE5YNuHrGqCUFmBOU
	 VH9OXxexALGVaZh4F9GPtgKZzeD58EFJj0N2G/WJshYes3mClGxk+/QRQ3OZh5toQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlwaH7zD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A0606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlwaH7zD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129051F000D4;
	Tue, 24 Nov 2026 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557677;
	bh=A2WKkWuXfehR+p/MU356k3jOwQIB5NV8XuJQ+feAN78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hlwaH7zDzC6uzT0wJNjQuPRqpKFD7oiwQsR8I40PMt+JlosAJaj7XbCVZ+aYc0tHB
	 j97tXPhAgyTUYkp7V88P8Ze36xjscekUjnPTIWxnxOYlhiJZJ7VodEMOXibJYFko2e
	 4fS5Q2ECBccgyLlgf42tB7BFoaoxwuusMDbaHWyN29IZffjBIIKp7GBRVRxn7st9Rr
	 MoiUyoPw/U5cTmsucaHyUL6mAXenszQHLfac5ofLK8sk7hm+96QJhEGKvqNdOvzYT7
	 dDg+tBgBl/SCLSOb8+mOn3XWbBlfRlPd3B0HcC5Aic7FqsQOmURVzZ/gtm5GK/CX5C
	 UoBACJGzxT43Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:33 +0100
Subject: [PATCH mptcp-net v3 16/50] mptcp: clear DEFER_CONNECT on
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-16-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5uaPhZ7sansISqHTJ2wvo/7sy4bspCLfVkYMZRBTRdA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOBneazz4fbPD4uVy5isfJq410P4gI5dxt6Cvr7V7N
 YvdHXXLjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlU/GZk+Kmdwbh8FS//9/0f
 AjLUyjv2Js1vU5UtXRF81PZNzZFbkYwMU/WrlyofKOmLq8u666CzuZp9pcWlbsVt2SztTzU/t6b
 xAwA=
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
index 6328815ad273..257c851c8a76 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3828,6 +3828,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	mptcp_check_listen_stop(sk);
 	mptcp_set_state(sk, TCP_CLOSE);
+	inet_clear_bit(DEFER_CONNECT, sk);
 
 	/* The later subflow close can not kick again the tout timer,
 	 * as the msk is already in closed status.

-- 
2.55.0

