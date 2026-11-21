Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254143;
	b=d2zl3oL4Z7auYy8qm3rI676ZUC98lXQJq7KrKV/1z3/ZJHFhdLRaSESCHxHclcHjSX7S
	 qyK9WOFxD8jqHdsg0pz10l6yQqYCAmJUfo6wGe8xR5qJJqex6M5cGl2wXynezIbJFnX+x
	 MH/+Q8HQSi8RPlIvNLa3msUimT1q9d+s12L46dmjB6DLpx11bEGPiVCGlVI01wV/6citE
	 Ao9QHBfECKOGo+fq8QlWYN2I5HHHeXZMHgM7Xo8OzVwaccrBM0canj3eRRzvW5hHZN0PT
	 Q0VOu9ADYY48kHm5wmNqOc9eJN3uDVNagE02P4vefvfQbPm+s51SvEKInQElifsQA0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254143;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hVd6hiqFUCnHcgLi3LbAmEYhmx6SH1ijyBmtPpgPEq0=;
	b=CDYasXWTwXOA43QhDGzT0Cw/fk5Ea+98tc2NEkw6upWxLgMJUQhqDgN7r/jPitOQBrRf
	 UWzTVzSym0fROO5kWiJKLuYvBDdeBj3wjHqypbS7MGqmut66CNHKKheIg1YG+zTdYBtPv
	 HaV4cUuavZbQJGMmN/pmGgItcPFPkFgFkic72QjRU2Z3rZyW8FnSbIazYYl5mvGo/1Qwy
	 NdU8G8o7NHxyUBX9FQ5HSmHfhaqSno/anYr3zEUPQxHWDbncmh0GlYJR4+6uCy9uJIZCi
	 H4YpLiq7LbqRNELXg5FRqBSmvdw/1AzftWH95YvuB3ZUlAypb8X04isKWFbvo6rUxvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5N1sZHE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42A606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5N1sZHE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854B61F000C0;
	Sat, 21 Nov 2026 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254143;
	bh=hVd6hiqFUCnHcgLi3LbAmEYhmx6SH1ijyBmtPpgPEq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j5N1sZHE4oxxIFn4u1zYbXOpwuyZ6Fqt4pbpoOSKPj96TBrlphGYWqPvt8MAz4iEd
	 iA2fwAec8a18dp8PcX3b/JiEvRDbrC7zywknCHzTWMYohWIP0TvrzAcCMzqn//0QRe
	 TLCtm3sPjdnvaWRyKb908qELMa5cx6OJMsLQIZs/sTdnMEAa8RaqPjfBPz25eH15Gd
	 iBhrquRVUCOMVmVfPkOxZFE7Kw6VrJdp6NLRu8ey/OJ4CytiPZAzAfgwn3WgXhtX5+
	 C0NRlNpmHHXdGSMam9LH5KLKQHnGyk6EuMEJgz7u1CNftZPD4d2ai361ooNBT+g5hD
	 S0HPkqmGnbqmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:02 +0100
Subject: [PATCH mptcp-net v2 04/62] mptcp: pm: work on a copy of the
 received RM_ADDR list
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-4-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=H2fyBuEiMX3mZSO0V08Z9k1BTg37/v93dXMYAiWsMx8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0731VLuMH4Ru4n6zx4yR85yF/94Ve7c9/HZ7jvNhi
 dWfqz7v6ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIySWGn4yvira07VrG5TtF
 uYrT5mPVZje58MbXXq5/zryX3+F7vYSRoTOOwfvjTf9md8HEogtK0idfWeeyHfn95J0uX/cFsW/
 MLAA=
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

