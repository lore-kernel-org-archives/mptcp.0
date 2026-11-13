Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599667;
	b=hBLJvXPKUHtkPXgQu44ij6VOUglwRxb3VELmWi8pqtyk4Mf9EGO+lUqpLknQRROzWZA2
	 seUoPUwO1rIErUfAlPKrNJUlor5wKRIfZspKNaRmvq+y67Xn8LLFB8afUc7vqCbw5XrUo
	 1UFBIUhnHBsN8jfoubiMXn+nHTf29RvKoae2W0nBfR/WiShk9sfwDvRoKn+6GP+02JZfR
	 se1WDeE4Ca63o/ctX/3uJdwLnr/uOcIbIuPwUx9kubKDdcUshWQyq9emzjqecpPRxyW8s
	 e7w8G1B5/Ho04Df/IK4tOEje9ago9DYKYmUhm6ms+p0NZ8dWDTJQqrwXrEDi7EVuACw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599667;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hVd6hiqFUCnHcgLi3LbAmEYhmx6SH1ijyBmtPpgPEq0=;
	b=O9lAvPiBFCOH3v17CAWSfcsvBkY2FqYtwTf66DX7pNS3/4niw9IU4/QvJEtw7DcYWYLN
	 4itiY3Um2T23lZf/Q8HvHlh2ll6op217gOtGMLEZ/reeJOPNX0rDUzv75tke8ic+sYn7N
	 nI0VU4cmCIxPH521U/N8C5uaVwkv5XZpliO1FuBJYhURHD8Kq5dHQ9gB9OBKST24wQwE2
	 JrSE/OxcSapEZekfsTovk+ilN+n88WgyxZgAE2KbhWDlo5FO944sNpGUiPKLNVT3cilob
	 8TnYtk/X9MYN41uMG1injhAQxOWWX8F+shadDiRVq2a7XUIInJ30zw1VUXX6+AYtBMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS1+5VkN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C860A2627
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS1+5VkN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766B01F000C6;
	Fri, 13 Nov 2026 19:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599667;
	bh=hVd6hiqFUCnHcgLi3LbAmEYhmx6SH1ijyBmtPpgPEq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fS1+5VkNbhHVEBybPw4PcaAa1tvQ+wvh7cEU6bDFltCDj2DMb6j9RBHRSfaQGEy+a
	 Lw3Jcd+8KGEgxvy07SstS6kUBQkcdbh61kg9N72Db5XRcdqwXSymZXMMEcSjvY2HZr
	 7i5732POw0I54SuZK1OImx4iCiZ+uIUuPCYT75pUenUY+BDcsYvBc9rvkOvvJYsyPQ
	 oh7wKhXAmNkMAMixNN8Da3eC1IF98tOzp6EyuBXRR7JOwvfjO6xXy5ao/ybDJxrZDU
	 jtBF+keRygieI92gwUctcYmS574V5Y057LMa/6QdCQqUKQ21yNsSQ0fpSv7REolZRF
	 /9rsCtZXqXFiQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:42 +0100
Subject: [PATCH mptcp-net 04/34] mptcp: pm: work on a copy of the received
 RM_ADDR list
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-4-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=H2fyBuEiMX3mZSO0V08Z9k1BTg37/v93dXMYAiWsMx8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z12RMTuYs0Qub96PY95uU7XD7/26HsH/7PlBKY5d7
 yuXPvNS7ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIQVuG/xFvhX2OZMyctTGB
 v0Lkigjv98r6Ow0rumQDQ1KLQv+2BDAyHDX5PefxguxvJ0TsZKbe5lt510gwTeewk/00nS6m2MP
 dbAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Josef Bacik <josef@toxicpanda.com>

The worker clears MPTCP_PM_RM_ADDR_RECEIVED and walks pm.rm_list_rx in
place.  For every subflow it closes, mptcp_pm_rm_addr_or_subflow() drops
pm.lock.  If the peer's next RM_ADDR arrives then, the flag is clear and
mptcp_pm_rm_addr_received() overwrites the list.  The walk goes on at
its index in the new list: the ids of the first list that were still to
come are never handled, and their subflows stay.

Hand a copy of the list to the walk.

This issue has been found with the help of an LLM. It has not been
reproduced: the next RM_ADDR has to be processed while the worker has
dropped pm.lock to close a subflow, a window that a Packetdrill script
cannot target. This fix is based on code inspection only, which is
acceptable here: it is simple, and the issue is clear from the code.

Fixes: d0b698ca9a27 ("mptcp: remove multi addresses in PM")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ Commit message: how the issue was found, and why it is fine without
  a reproducer. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7c5b50b34cc..cdc8bab0eaf8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -827,7 +827,10 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
 {
-	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
+	/* pm.lock is dropped on the way: the next RM_ADDR may come in */
+	struct mptcp_rm_list rm_list = msk->pm.rm_list_rx;
+
+	mptcp_pm_rm_addr_or_subflow(msk, &rm_list, MPTCP_MIB_RMADDR);
 }
 
 void mptcp_pm_rm_subflow(struct mptcp_sock *msk,

-- 
2.55.0

