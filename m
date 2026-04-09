Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A033D6DD
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767936; cv=none; b=lZsogPkICjOBIjUS9aVCSYDLnvJGYwBOrvIBF23w0gBkeLT4vBc+YzZzGxp8nvYpB+rPWi1TExh5PW07nsd/q4Ddq1DvOpaNAHIXWkubLaO9bBubmO2B/hvOBxd4h8Cs0Ok/zUreuey2FO5Hug7OtZEqyzclzxfyOx1LP9+HNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767936; c=relaxed/simple;
	bh=cINc5UYgsEJ/hJ7zwgFjc3aPTT3u8hV8n0aQdsQMYXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ot3KeK82Fgsnklj35fJJi/EufUEZeko6qbz3Xd22LApEJ0YXkNLh6h4fl1O08QadFa2Hvq7jFiag6kuPzz/kJvprdHe73ncoBc0nxSJKgMlT5ogVJO/KqscBkyZwdslF0Z/WGwOtYXIypD5ZH5lnv9GakFuV8ngaMn3/oeQHEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNyvPlnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNyvPlnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6849C19424;
	Thu,  9 Apr 2026 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767936;
	bh=cINc5UYgsEJ/hJ7zwgFjc3aPTT3u8hV8n0aQdsQMYXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nNyvPlnQEaomHxBsorUmskzPTRMtUj8/Lp65yQhWFH5/+ujeLEpqoGd83frPFb7s2
	 BkY41h8gWxnfelISWZcrX28zH5kJ1uHF0x4LyJwU3Vd1mXs0rw0Yp91PSahaPNqdIY
	 Y8XGyBzhQQLTfSRSdhl1qPRE7UrSN7R7kFW0T++yDJfLYP0HEwIVIcw8Bno+9XwEsC
	 xQimkWGduV8gTditdh3ADGVBOQfcDszKBZRNRZKOEriM9n1dkHqKH7hE3U8oVZsmgO
	 6ilVjP2RbcHBdDNrcfbdxNzYORNZAI9W8Uw06tlRpsAjfjUJrlpphpErMpdcHffPAC
	 RC6ItnPsRSf5g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:45 +0200
Subject: [PATCH mptcp-next 05/16] mptcp: pm: retrans ADD_ADDR: skip
 inactive subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-5-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cINc5UYgsEJ/hJ7zwgFjc3aPTT3u8hV8n0aQdsQMYXw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCBY1LawNnWDxj7O2jydygtrLz3dMJe5IsUcap/odN
 FsuLn+ro5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCL33Rn+p+m/vnT29L5PMk9P
 mC5d8bLxguJbhyfv3r/lSe051pphu4zhf1hY08XGbfw7X2q6HjmzWW3q37L3rKIKxRcF5+y3Wpm
 9nQsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the maximum RTO amongst the subflows, inactive subflows
were taken into account: that includes stale ones, and the initial one
if it has been already been closed.

Unusable subflows are now simply skipped. Stale ones are used as an
alternative: if there are only stale ones, to take their maximum RTO and
avoid to eventually fallback to net.mptcp.add_addr_timeout, which is set
to 2 minutes by default.

Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout adaptive")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 78a2ad71700b..e954dc46e6bc 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -305,20 +305,27 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	const struct net *net = sock_net((struct sock *)msk);
 	unsigned int rto = mptcp_get_add_addr_timeout(net);
 	struct mptcp_subflow_context *subflow;
-	unsigned int max = 0;
+	unsigned int max = 0, max_stale = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);
 
-		if (icsk->icsk_rto > max)
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
+		if (unlikely(subflow->stale)) {
+			if (icsk->icsk_rto > max_stale)
+				max_stale = icsk->icsk_rto;
+		} else {
 			max = icsk->icsk_rto;
+		}
 	}
 
-	if (max && max < rto)
-		rto = max;
+	if (max)
+		return max < rto ? max : rto;
 
-	return rto;
+	return max_stale && max_stale < rto ? max_stale : rto;
 }
 
 static void mptcp_pm_add_timer(struct timer_list *timer)

-- 
2.53.0

