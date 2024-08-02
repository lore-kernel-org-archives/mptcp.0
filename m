Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BB1AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622681; cv=none; b=gJwuIhaQBcEHOvP5vDs4BGOfNQKtR1W+CSFyuPJIqVdFXJ2JjG4BRd69aflNbBqtGBnxBsy05S1k2LBRAkD5pSD95MB1vhuLlOHSRglxgUTWu2hvrfu+QEhpqXZFDtcu7KuKtKgwAbOjSrunWGCio3hZGVUeBvEJmJQ3IbJSHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622681; c=relaxed/simple;
	bh=uqVY8DJxuKMUGQ8qwOhYGldndoYxnBe7QFO3AYQEHtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyHZhm1D1x6HylTkmg56GaAWnx1vaP9Tgstj3YXB9dIITD/tIua3sYyZfFxhIMjmWi6lyPKHB6hRrmog002h3xLiew9/Ijpl8Cjx3mO/eTHg9pZvT+vLJNtwQZ8GmHCk830qcdvXVs4y+pc2IRehYCmByBOWy1gZDcP6C+NKS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBzaWzUP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBzaWzUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984E1C4AF09;
	Fri,  2 Aug 2024 18:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622681;
	bh=uqVY8DJxuKMUGQ8qwOhYGldndoYxnBe7QFO3AYQEHtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IBzaWzUPzP63uaqNh4E45+MY2G6BScCOMfyg5/j6d/LjNEVgVMXXm5PERu4oMG0vQ
	 QKAJSYL4IIoIYcCDjaeI4r3ISj+wMRZwwnPGWwPS7QWkeepDDV2vXB0PYBsCObfITb
	 a1AfGTgqr36ecZYO1wX237sz9qexV3PaivAWwKTzI0dJ9O1SW4aJA57gsTxXS1KbcN
	 NrFhKEgTDzk1oANJmvhqrV2/H4biQ1xAJQBkT0AfisNRZDOLD78JRAKI6svsWnHhJQ
	 5Xn66gaP9BDpTyk6E4GBu+NINYs55nNsShx7q0x1nmj6nCnZcrp8CmKo31HE9FFqbY
	 5oy3w7kh7E2Ug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:47 +0200
Subject: [PATCH mptcp-net v6 10/11] selftests: mptcp: join: cannot rm sf if
 closed
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-10-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2976; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uqVY8DJxuKMUGQ8qwOhYGldndoYxnBe7QFO3AYQEHtM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLLw7qFeLyun9p0oFHuvYQSuE2yCk8UTjB7u
 0TAbsNufiyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iywAKCRD2t4JPQmmg
 cx82D/oCmYXHkorbPDfuwxajmGU9OC6bMjtCLhD1oVshCOhxJFVJHpGuQDDQorgNsB9zKnpxrpt
 pe5ZUjiyAr90o/+tciidAqsVxA8ZJNdqGggbDWa8A8FV0M+TMjdtz9t/cECeEcdsfqHVbHnAzRc
 yh9MdTMtRpYUgGk1JuZ4kiswTz1mqJhTqjOSGF1oVktTqN8Z2udh2pb0lJNBCvUx8vhkba3PXXa
 HwT2E4AWUQUylKARdmwV7JIldXx0C0QXNIFzflKMA6S2/4n4WC3fwA9+5sGzy+qiEWO/DLMDP5U
 TqapA8HTCSRLHt4Dq+MQOCowYD38sOGcowW7cxFGp4ztZOd+oLcIhppJznDTs46G48C1H2oBT1f
 Uk53Jj7zQ14tL6RjK4CdCUhMW2+3TAWrszD33L2ein/w7JNHajZ0BJ+SsshEIAtFYymuBh5k8nb
 Cc4yoQ88BVRz0JhaLTt/BLghsWrJwqD+646+jw3lESjmMbz0S6lJHizg3WxAUYJptGYN8iXDPzm
 zSMuL2QaxLn7tWxLnLni70hT8sGKlP6fNnT8BVo86BNldZLZi8xMz/Vy5g1x7eBkglUQSEvhGQW
 /WleFAy6DKhRoCTx+zFpCGsMONWKyd0qy/yfo/hblh0QAUWcP7U1f/xj33uZF0cmD2ePzaTOaGN
 kRE6RHFSSE95pJQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Thanks to the previous commit, the MPTCP subflows are now closed on both
directions even when only the MPTCP path-manager of one peer asks for
their closure.

In the two tests modified here -- "userspace pm add & remove address"
and "userspace pm create destroy subflow" -- one peer is controlled by
the userspace PM, and the other one by in-kernel PM. When the userspace
PM sends a RM_ADDR notification, the in-kernel PM will automatically
react by closing all subflows using this address. Now that the subflows
are properly closed on both direction, the userspace PM can no longer
closes the same subflows if they are already closed. In this case, an
error will be returned to the userspace. So no need to run this command,
which mean that the linked counters will then not be incremented.

These tests are then no longer sending both a RM_ADDR, then closing the
linked subflow just after. The test with the userspace PM on the server
side is now removing one subflow linked to one address, then sending
a RM_ADDR for another address. The test with the userspace PM on the
client side is now only removing the subflow that was previously
created.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ea954ba85969..4129952fd9ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3408,14 +3408,12 @@ userspace_tests()
 			"signal"
 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
-		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
-			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
+			"id 20 flags signal 10.0.3.1" "after rm_sf 10"
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_rm_sf $ns1 10.0.3.1 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
-		chk_rm_nr 2 2 invert
+		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
@@ -3439,12 +3437,11 @@ userspace_tests()
 			"id 20 flags subflow 10.0.3.2" \
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
-		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
-			"after rm_addr 20"
-		chk_rm_nr 1 1
+			"after rm_sf 20"
+		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids

-- 
2.45.2

