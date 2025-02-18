Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C2233136
	for <mptcp@lists.linux.dev>; Tue, 18 Feb 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877895; cv=none; b=hmH6w5TZhO6WarMG50VrJTv88ej+R7jLEBriY1075bq5VIG+xWix4BQh0nN7uAMkn3N0NbEIodMmFCII/b03yeWdDnKLjLe5fZqsJd6Babu0Y6k9YW/Sxy5qS6auSoBnGGyYTPd0aBlm1+wvY62MwHdlqUxAwRJDY7TMXo2iEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877895; c=relaxed/simple;
	bh=fT0ooaJYfXeHEMXhEgjuYp/NTHst9SZ1yQMcqElzf5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJxGBeRkxyamA3By5nrcnlkF5sgfDNpLqGjHo6x97+qAsmMJmK1/6sISYaEfa1NUg0h5U9RRsS+C57r1Yg5K/HeJtJBWk6NVRTHcky8w/4AbhQ7Pg5RjGGhrDnT19KqcPHI1ZyaXTw7B4lwHnHDjKSoLgkSJKvqoZAvZcqoo0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQce9Lg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQce9Lg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B786C4CEE6;
	Tue, 18 Feb 2025 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739877895;
	bh=fT0ooaJYfXeHEMXhEgjuYp/NTHst9SZ1yQMcqElzf5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JQce9Lg5gFMhcFtmMnTkIteWFMQpxX5PgM7CILAGZYF1sMWpUsEFjb9y19TSNxfXj
	 cLp5TGjfYYzyvadaYpSFZQiBAhcgnEgD1/25x/cj8nlJzXQ6IAaFeqKcGYQQ0TKnnx
	 vfepIjvJonsskcvBG3dbgHVicBXKmtyl5R8ehZGDbYKled2D9EO1zbTz9xbEVAl69X
	 T3P5NC3AYJdKEteeZ7v37P1Q2kviI9JvWwfxhT2JemjeytgBzl6HXkguX7KNiMD2ib
	 hYXLJVLZxeA2m7G1Z9u6EaSrquKLB+S7jbjFzKZ6Hwb3azOqGXzbjDfl+GxtRK6dK3
	 kh4csWgKnkMnQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Feb 2025 12:24:46 +0100
Subject: [PATCH mptcp-net v2 1/2] mptcp: reset when MPTCP opts are dropped
 after join
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-mptcp-dss-drop-mpj-v2-1-0c6caa10ec52@kernel.org>
References: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
In-Reply-To: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3658; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fT0ooaJYfXeHEMXhEgjuYp/NTHst9SZ1yQMcqElzf5k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntG4EIsp/UO1QtIsjI3CMSaJwTSUBG7E3aQv0l
 4iOEl3zeVqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7RuBAAKCRD2t4JPQmmg
 c7BwEACZLC0dp8TLve3QjLQM6eQQH18ybO2pknP3arBul3vQXS7nVH33tbdWLh3W3q3cYbd25HS
 SAXeSDtYWSG0xDu+/6oKerpzCBkcng0OkBZQ9VbedXvqeoysioBkyPydtSg6o//mc8860RnpcX9
 9LjDWrD8q3/hKostdEE4FvsrFwnkv6EUB4royPmWAmht1l44usXecZ/2nHUHTjKm08mFbZZ9U/B
 OQD7p7e8goWlT4FFQfc23LvTYnER6CYNJova/4Hu81JCjQmyaIxMRY2IMGifLZfebkH2tjllfu2
 n6HS9chDwmGI3hNxVvMLwfPhpj0kKHZFnRcAbb0IFRYhGEozsFjIFT5iH9R7GT7QrMu4hr108rz
 o0vh1QjtpAO6zvPrJ37rP2GSQJ/n7NVgPH5YrgdYONe53h8ZyeoGb9YnjSguOOsheYM61C8/P1J
 p9F4027puIfFduB7BUoqFOLUwGU5lIT8Knhuv3HRFgLUT3mVd3S3PsZOdRa6JJrE7eKgP4BEgWX
 ve11LBbHE/MVoA0cMdYbpeG0cxIvw826ibAZSOD0L7r72DxZOXWkMy59Oh2Cy8PS8PbsZpSLEfA
 icxVoB023XHifeEBxUUOunHweEBEMVnXvPhgnA3Z6KBUhxFX67zNR+LfbLyBnHUHJAO0dm0acKm
 QQ7Ize8EfqygnsQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, if the checksum was not used, the subflow was only
reset if map_data_len was != 0. If there were no MPTCP options or an
invalid mapping, map_data_len was not set to the data len, and then the
subflow was not reset as it should have been, leaving the MPTCP
connection in a wrong fallback mode.

This map_data_len condition has been introduced to handle the reception
of the infinite mapping. Instead, a new dedicated mapping error could
have been returned and treated as a special case. However, the commit
31bf11de146c ("mptcp: introduce MAPPING_BAD_CSUM") has been introduced
by Paolo Abeni soon after, and backported later on to stable. It better
handle the csum case, and it means the exception for valid_csum_seen in
subflow_can_fallback(), plus this one for the infinite mapping in
subflow_check_data_avail(), are no longer needed.

In other words, the code can be simplified there: a fallback should only
be done if msk->allow_infinite_fallback is set. This boolean is set to
false once MPTCP-specific operations acting on the whole MPTCP
connection vs the initial path have been done, e.g. a second path has
been created, or an MPTCP re-injection -- yes, possible even with a
single subflow. The subflow_can_fallback() helper can then be dropped,
and replaced by this single condition.

This also makes the code clearer: a fallback should only be done if it
is possible to do so.

While at it, no need to set map_data_len to 0 in get_mapping_status()
for the infinite mapping case: it will be set to skb->len just after, at
the end of subflow_check_data_avail(), and not read in between.

Fixes: f8d4bcacff3b ("mptcp: infinite mapping receiving")
Reported-by: Chester A. Unal <chester.a.unal@xpedite-tech.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2:
   - Squash previous patches 1 and 2, and drop csum case from
     subflow_can_fallback (Paolo).
   - v2 is quite different, Chester's Tested-by tag has not been added.
---
 net/mptcp/subflow.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d2caffa56bdd98f5fd9ef07fdcb3610ea186b848..5255e0cc409437ab1abb66fc8557d18aa4244af7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1139,7 +1139,6 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (data_len == 0) {
 		pr_debug("infinite mapping received\n");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		subflow->map_data_len = 0;
 		return MAPPING_INVALID;
 	}
 
@@ -1298,18 +1297,6 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		mptcp_schedule_work(sk);
 }
 
-static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
-{
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-
-	if (subflow->mp_join)
-		return false;
-	else if (READ_ONCE(msk->csum_enabled))
-		return !subflow->valid_csum_seen;
-	else
-		return READ_ONCE(msk->allow_infinite_fallback);
-}
-
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -1405,7 +1392,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!subflow_can_fallback(subflow) && subflow->map_data_len) {
+		if (!READ_ONCE(msk->allow_infinite_fallback)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */

-- 
2.47.1

