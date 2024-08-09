Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B361DFF5
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207087; cv=none; b=e7N83wJbPqxzzYJJr6jbgNS2v76fG0BfTUxUKQ3wAqsB9RGvg5/j5ztDTY/IvAsBsiYxK48r7QtPX8OhDXU5H2RJet2i92f6saRuaBgVCI2eXf5pbobqW/wFJcKhRbg2oeI7plmjpAnitH53+EgBzUGzrqr/OG6/ltdxMfcrFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207087; c=relaxed/simple;
	bh=yp/Q21clBvVf3+sFMcwbOZwek33y3rt9IXlTHmsPK5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDekrjjvU41Tzc8C5ykl21q7t/chUrcxkcZp9/+BARFixFT2RfElRHHLz0quUSpPjOvJnUcH0Uxr+q70fulpjgweyVb98Fns/CJTqesL3H9tRt5KYe7xLVxBcxWwJmZuTbYetZBwpPR9jS+k53l6DXxZMG7cN500FNJWzKy/nCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM8EfDi5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM8EfDi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DACCC32782;
	Fri,  9 Aug 2024 12:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723207087;
	bh=yp/Q21clBvVf3+sFMcwbOZwek33y3rt9IXlTHmsPK5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cM8EfDi5hCFtyWwNUWgS4dnnV8U+WLcIq2vMv52hua9yDfFrT0hk9HHJvGmEoM3Oq
	 WwI+heruwxrtW2Jo8fkDIUpgFb7X79769rmMeMYh8oMdxdllDxqolw9fpTdKIncfLQ
	 XufIhy3PseVyMY35IDqnKq4vrc0zfPncmCaS0Df+r7w+7ny1Av1sA4wrHgN4XFqw7U
	 x5oIOBzKIQjHncussbn2Xzm/JmUi2w1TE6V/GSUFlRN7s9O1Qb1amseBBhvW5Yiaj2
	 onbX2R+BNY6wM3g8nlGl6WSSMZmA9HYEMxs4+NV4nJTulxPY60HiRvJ7V2bRHTU78o
	 uUTGPKJJBy9ag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 14:37:51 +0200
Subject: [PATCH mptcp-net v7 3/3] mptcp: pm: send ACK on non stale subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-pm-avail-v7-3-3d0916ba39b4@kernel.org>
References: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
In-Reply-To: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yp/Q21clBvVf3+sFMcwbOZwek33y3rt9IXlTHmsPK5Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtg2qSdL8C17k2bfOgnPhAFtTRvEJhzMzT6lvL
 t6fY6hb+8yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYNqgAKCRD2t4JPQmmg
 cxTjEAClp8WRvn2PI31tC0Aeq7XIIFk/OOIOaxeZziJy8Hi02t0viDgSyyXfMIBCaMHWOtOe2ex
 LSg3+6YZ14LEK5fbnsfkblpPHWsrKDUrGO/z6EcdUUJF9aiUGzbreD6AWWvIi/hYT7Ts6JQdJvK
 rTO1CAA6BGGkt2ZycdhnFL/GYjZBRBrilWnQwebm0tDsXt1L0i0sQ8JAqes7Yxgiu6BtdO7B2if
 3gtDyBYG65eo4PH39i/hvVoQ8kzgJJdEykJfWmLxsBwHGLhHBc2Y+EFfMSOls8C0Fu3OpQ3GXGx
 BTmkH2lKKpaktg8mG3gvMw2MTVr/0EKJnzN/5W9fI6eM4dnbB7Em+Oo0q9+bvHWlELpLQxT3v4E
 lyuu8ZPgPaYRAzaP+24kWM9HbIQnrNDJKXdMBwPG8+UAr4tPADk0Z+FKXYVYb18v/vc53WkimC8
 Gj9VHuZ8MrwoK3wiYXNdsFvB8iwfPObT35FYKdMMjd2lKrbbc9JCPOVmA2y9JtdHDyhfyNENqt1
 ADWkmX/IJXv1zQNMZcEULZX+E6WfGDJWkCxvB8+lE7q0kv06JYvK+wL5RKOR/Lq5It7qkjqwRyh
 8hk41Yoa4Hr7OEBrAVTNIJoFlJzvxWsLqh6dOmsQreCWGlpaKzE0UwwddnUt2r5H8nEO17ibF1F
 jAIsP55kYl2s/ww==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If the subflow is considered as "staled", it is better to avoid it to
send an ACK carrying an ADD_ADDR or RM_ADDR. Another subflow, if any,
will then be selected.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - It sounds safer to do this modification in -next. I also wonder if
    we should not add more check, e.g. not on backup flow except if
    there are no other non-backup ones, or still pick a staled one if
    there are no others, etc. But maybe we don't need to care for an
    ACK? And we can always improve that later!
  - v7:
    - Include the Squash-to patch. (Mat)
---
 net/mptcp/pm_netlink.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d3b1b459e6f3..3bdb0219188f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -762,7 +762,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *alt = NULL;
 
 	msk_owned_by_me(msk);
 	lockdep_assert_held(&msk->pm.lock);
@@ -773,10 +773,18 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (__mptcp_subflow_active(subflow)) {
-			mptcp_pm_send_ack(msk, subflow, false, false);
-			break;
+			if (!subflow->stale) {
+				mptcp_pm_send_ack(msk, subflow, false, false);
+				return;
+			}
+
+			if (!alt)
+				alt = subflow;
 		}
 	}
+
+	if (alt)
+		mptcp_pm_send_ack(msk, alt, false, false);
 }
 
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,

-- 
2.45.2

