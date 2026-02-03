Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71336AB59;
	Tue,  3 Feb 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144163; cv=none; b=s+tuaIa3VPIqAW1nC/cp9Ms12qUENqLo84IXlqrbehOkPIN2e69bgkw+D5JYIDP7wI81hOdTerfpk01Gn1agNlrGmfwPDgObEoUkLHHfwzJf4KDW+AAumt5HD0QB67N3/fcqoBpxjrSc4cyQXVIkgo8pbPXz9jRoAU1bqCNwSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144163; c=relaxed/simple;
	bh=5rk4p7N27KpZKI2Df6hf4Y7ilo+Yl3DQi5ySBhN4/9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGtWQV1Zfn7VeEmMuBidOV9eG6urufyVWroqB3wAjtSITLAexbLeWn1/58p8JjJoERI2zzEZlCNpnYa7dyPUH4XTnehFXbxrPXM97c8c6RPiPCQqjibnnkHK9XsXb4dcLz91kN75s+VoilGe5jqf001EqYNyQyFZCwKbAA8MRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICcSjqQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICcSjqQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2587C16AAE;
	Tue,  3 Feb 2026 18:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144163;
	bh=5rk4p7N27KpZKI2Df6hf4Y7ilo+Yl3DQi5ySBhN4/9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ICcSjqQsxMtRp148yXibp16F7smrTxkZ/EkYEUbVxmfc7QPhCaXH9KM95pSu8xSqW
	 2EjUljHvhGzBivuZp4fSonalsG8I1x74cvJRiWR8We5HxrJfAnoIrCNeRcUQc3BWM8
	 82N7HL35henx9Sqd71Ie2SIxxtoKHvMhrxZnq/0BPfaFLWjQyNXd3B6m+3AOnr6QI2
	 kiS8dyIcIFKAGRvHow8tzB8URuK2mLUfkkYCIp2IMli5HDvJLgmvI65qEALFsNjRTY
	 GgqbzY3G+SuQSyJZ85Kt+cXuaXz15gFEk54UTqVm8Fy07aitenMzSjSUWHOuueXcA5
	 +0l1a2Wn4Yf8Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:22 +0100
Subject: [PATCH net-next 06/15] mptcp: Change some dubious min_t(int, ...)
 to min()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-6-31ec8bfc56d1@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Qmkp9k1CvYe+agnfherx4E5JSTV8Gttoiu93zepZAyQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHLvq+uxmzlLf3rmC4+TxDTyWT/d6+4pseLe2KcEzV
 2/GWu/9HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZl8HwP23ZnzmmrveW8Nzc
 v0W61Y0n2p+ZIeh4WNbvuQu4H77xcGRkuDz7rn/ubmeXEwqMmqxZXNveJwibXAud9n7b07n/sh5
 cZQQA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: David Laight <david.laight.linux@gmail.com>

There are two:

	min_t(int, xxx, mptcp_wnd_end(msk) - msk->snd_nxt);

Both mptcp_wnd_end(msk) and msk->snd_nxt are u64, their difference
(aka the window size) might be limited to 32 bits - but that isn't
knowable from this code.
So checks being added to min_t() detect the potential discard of
significant bits.

Provided the 'avail_size' and return of mptcp_check_allowed_size()
are changed to an unsigned type (size_t matches the type the caller
uses) both min_t() can be changed to min().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
[ wrapped too long lines when declaring mptcp_check_allowed_size() ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 197ee169c0bc..e0b4745bbaa9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1160,8 +1160,9 @@ struct mptcp_sendmsg_info {
 	bool data_lock_held;
 };
 
-static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
-				    u64 data_seq, int avail_size)
+static size_t mptcp_check_allowed_size(const struct mptcp_sock *msk,
+				       struct sock *ssk, u64 data_seq,
+				       size_t avail_size)
 {
 	u64 window_end = mptcp_wnd_end(msk);
 	u64 mptcp_snd_wnd;
@@ -1170,7 +1171,7 @@ static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *s
 		return avail_size;
 
 	mptcp_snd_wnd = window_end - data_seq;
-	avail_size = min_t(unsigned int, mptcp_snd_wnd, avail_size);
+	avail_size = min(mptcp_snd_wnd, avail_size);
 
 	if (unlikely(tcp_sk(ssk)->snd_wnd < mptcp_snd_wnd)) {
 		tcp_sk(ssk)->snd_wnd = min_t(u64, U32_MAX, mptcp_snd_wnd);
@@ -1514,7 +1515,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
-	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	if (!burst)
 		return ssk;

-- 
2.51.0

