Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B52EB87E
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759531; cv=none; b=UuPagqbVR93Mho2aQAvipQyLfkXkhDThDEQOubEjodkv3fao7r/6DR/G5NZ3XLnAuOtzrjsdKNwoly6l38DP/M0ByjcBfHd2q0TYdlcyEFDIfCojlsLxpFfCsd6Ma/suz6KElSRq9tCPPH9odSYxBT0FuJspBvjs/Vr0u7QH0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759531; c=relaxed/simple;
	bh=NeIq3HY0BQRs6MTZF719Hz6SDDZE95NyayDqhpvYgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jzY5VYo866lLTVzDdxwcV2iXKSDBxDe71R8WQ6HC/crsMTlJjIvEEjWG5i8xj5ssIC5tTblH2NJhA1Q0DhtJgL6PGkJDAHcAght4IFxnLM3+wrw7nIuTWOP5HbE4nNP/plbAQTbigJktowfu8H50wVENclW60LF//1k+9gwtNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2lwtV7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2lwtV7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D81C4CEF7;
	Fri, 30 Jan 2026 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769759531;
	bh=NeIq3HY0BQRs6MTZF719Hz6SDDZE95NyayDqhpvYgPs=;
	h=From:Date:Subject:To:Cc:From;
	b=A2lwtV7nUoNHpPlvI7JNSPjA26Es7NNRFtx72MXc/S39GQuVj+ctd2u6utzR+Ng6t
	 3Od0a4F9sK2x1JO39Bi/jAxU1RvSwDqVdHNbsWI1u0O+ai8CL9Vs1IXg8LGwIiAwel
	 ejKKccc8HbPnhf+Yc9XLd868FVBI7BhmXyXWHR1Lx7+1wIN9PxoIj1CEqIQrAvGTKo
	 wQqR8pmIzyr/oiCFbpWAkUzsX653hZdGe/M2MSLCEK+0FRQtSC2U70iPfXfBElopOy
	 fKZJpi0iOwod4HvFp9vuV4pqTyLwW1M9lPq3Vvve6yW6i9PXVDnq9eK9q4H7Dkouny
	 yzmKriW2Q4/dQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 08:52:04 +0100
Subject: [PATCH mptcp-next] mptcp: fix kdoc warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-mptcp-fix-kdoc-v1-1-a391da37f1ad@kernel.org>
X-B4-Tracking: v=1; b=H4sIACNjfGkC/yWMUQqAIBAFrxL73YIaVHSV6KNsrSUyUQkhvHtSn
 8ObNw8E8kwBhuoBTzcHvmwBWVeg99luhLwWBiVUK2Qj8HRROzSc8FgvjbSI3pjWyE7PUE7OU9m
 +4Ai/aylFmHJ+ARyo/GxsAAAA
X-Change-ID: 20260130-mptcp-fix-kdoc-eb08ff6f17ca
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3988; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NeIq3HY0BQRs6MTZF719Hz6SDDZE95NyayDqhpvYgPs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJrkrW+PVCQEFlR6H5PJazhINvffzqvN2zf2R5oaCEmb
 +cpfGFxRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwET+azIyTPvaemRn49pwdt2n
 uz0dpsU8P3B6scDhSJET8YkXZ36bF8jI8HlFkPDVqbF5uyv59lz/VHy7uXGDdV5Vhqlo/K2OrDf
 b+QA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The following warnings were visible:

  $ ./scripts/kernel-doc -Wall -none \
        net/mptcp/ include/net/mptcp.h include/uapi/linux/mptcp*.h \
        include/trace/events/mptcp.h
  Warning: net/mptcp/token.c:108 No description found for return value of 'mptcp_token_new_request'
  Warning: net/mptcp/token.c:151 No description found for return value of 'mptcp_token_new_connect'
  Warning: net/mptcp/token.c:246 No description found for return value of 'mptcp_token_get_sock'
  Warning: net/mptcp/token.c:298 No description found for return value of 'mptcp_token_iter_next'
  Warning: net/mptcp/protocol.c:4431 No description found for return value of 'mptcp_splice_read'
  Warning: include/uapi/linux/mptcp_pm.h:13 missing initial short description on line:
   * enum mptcp_event_type

Address all of them: either by using the 'Return:' keyword, or by adding
a missing initial short description.

The MPTCP CI will soon report issues with kdoc to avoid introducing new
issues and being flagged by the Netdev CI.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp_pm.h |  2 +-
 net/mptcp/token.c             | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index c97d060ee90b..fe9863d75350 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -11,7 +11,7 @@
 #define MPTCP_PM_VER	1
 
 /**
- * enum mptcp_event_type
+ * enum mptcp_event_type - Netlink MPTCP event types
  * @MPTCP_EVENT_UNSPEC: unused event
  * @MPTCP_EVENT_CREATED: A new MPTCP connection has been created. It is the
  *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 5bb924534387..f1a50f367add 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -103,7 +103,7 @@ static void mptcp_crypto_key_gen_sha(u64 *key, u32 *token, u64 *idsn)
  * It creates a unique token to identify the new mptcp connection,
  * a secret local key and the initial data sequence number (idsn).
  *
- * Returns 0 on success.
+ * Return: 0 on success.
  */
 int mptcp_token_new_request(struct request_sock *req)
 {
@@ -146,7 +146,7 @@ int mptcp_token_new_request(struct request_sock *req)
  * the computed token at a later time, this is needed to process
  * join requests.
  *
- * returns 0 on success.
+ * Return: 0 on success.
  */
 int mptcp_token_new_connect(struct sock *ssk)
 {
@@ -241,7 +241,7 @@ bool mptcp_token_exists(u32 token)
  * This function returns the mptcp connection structure with the given token.
  * A reference count on the mptcp socket returned is taken.
  *
- * returns NULL if no connection with the given token value exists.
+ * Return: NULL if no connection with the given token value exists.
  */
 struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
 {
@@ -288,11 +288,13 @@ EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
  * @s_slot: start slot number
  * @s_num: start number inside the given lock
  *
- * This function returns the first mptcp connection structure found inside the
- * token container starting from the specified position, or NULL.
+ * Description:
+ *   On successful iteration, the iterator is moved to the next position and a
+ *   reference to the returned socket is acquired.
  *
- * On successful iteration, the iterator is moved to the next position and
- * a reference to the returned socket is acquired.
+ * Return:
+ *   The first mptcp connection structure found inside the token container
+ *   starting from the specified position, or NULL.
  */
 struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 					 long *s_num)

---
base-commit: 9eafdb3251fecf25d365143d1a7da2dca70f181f
change-id: 20260130-mptcp-fix-kdoc-eb08ff6f17ca

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

