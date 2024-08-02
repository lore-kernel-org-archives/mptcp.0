Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4931AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622676; cv=none; b=IpfF/pkglQehGovmL0Jfb82cQ4WFgxPNgQlJbC9bSpF0dMH9jrXGzXTSCqdCyuj7y2FNJCHx6NYtNTsUweYJei6iLn0uIk4t3eP0yyTP91g3AKMXobwC4jSz3CSEkTJE7bGw0lsnzooXkhSu83E3r05+2vkrwEUkHlWg1mr82Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622676; c=relaxed/simple;
	bh=N/NPnhcQPnAPZfoOqFH6c6mKbbgnh+lc7bsdqmg8gZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NhiYOeiAS9S5p8MDkNJgjPWpR0DoF1veGHT2vJiC+pSnxYTp2gNRIWQ8t5W21Pfb1ABzdX16OujlWuEvZC3QWw30cvO0FyoD1Jj7w56f/a6bIz7FK1vPzgrh9Qllyz1n639CeEiCORSraS6wzLL9GG5fHCrIg0CH7q011LiglyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNkm8Ap8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNkm8Ap8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AC2C4AF09;
	Fri,  2 Aug 2024 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622676;
	bh=N/NPnhcQPnAPZfoOqFH6c6mKbbgnh+lc7bsdqmg8gZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MNkm8Ap8GWjTpj6fh7EStVfL3nBJfmF52AFM312JBFNUicxxSSwZf2B9BhLZ27mAN
	 7b+8V5K6jQv7L/HXeStZVa36woa7DnigBjtD5NVJTbs9NxVI3dmE1sRyHb+tmnt8jK
	 W5EfpzYBWGsMwKh3V3Mnhruo3kMyWv7lZjwod6q6D6vnOGQqmHrouDt2NWaQZ4qiag
	 p74ATzk7qXw6w6lQcRGRw2vkKpBB8kiFDwbtPhaga4HSn6GZFwGrY8QNOuIdc4juJR
	 71NI5Pp6S++O6gFvISqM+dCMPsEGjRj44ntAb259hLpZ3SCDXwS2BfmGs8amNCOOx1
	 lX2XAjRnNL4RQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:43 +0200
Subject: [PATCH mptcp-net v6 06/11] mptcp: pm: skip connecting to already
 established sf
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-6-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N/NPnhcQPnAPZfoOqFH6c6mKbbgnh+lc7bsdqmg8gZ0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLLyU5r6LBzNUjVelJFxVsKyRjvj+6cFIyO1
 kqXJ1jJuF6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iywAKCRD2t4JPQmmg
 c0yPD/9HI6nTkZmMuF0MXrJCQzQBYC1F8+Zl4R3h1xqY0OJv5QPOi0AadsA3A7f4C650jgLrtEc
 Wy959a9M+yDtLdOzQbXVkDUZBS+E/OPpgc20wYyj5rKs1veRTiK5uuNm81mezHPaUR4CvbFvk25
 zmoT/fZUUqjvrLmJibPk6cGYcKUsVsmRs4d93w6X++A0eJgdyRPzUIsw1YyeUXTsypG5PvwVcGu
 L43oKaVr6Bs9fHJ/tYU4vaiSBOkaGzQ6yk3d37StOOjLY81xPGgDG05xtbvVFfqFngNvsT2mgVX
 rEAdv85XZ3j+8qV3tV3xT5BNh6twIaQeyxs9hr8CCvhESXM+eBc35UhWXUyb4/fa8JgOcSJfTLz
 QOFhnEJF6t15cM6iIgfOO3JW9yi1xohujieWT/j4HohB3eTq3kFC3bTEAImh17Hc4McBl+10LDt
 r/TXZWdGqxt7XwlpGMn4wNfBb/OL3C9GqqWrOvFRDeq9StBmM/u9Q+RG1+c+FDYfVUEtxGUyQ/B
 xAkfTb9ib7hebp13LgMPThaCLBXouj4HbDy5ySemrpAF0Duqt5MMSADpb1bChFSC80V/bIohLn/
 km/mWWfqwfoQc6jmRJvcscpNOCimtBJxNgHnL/+0H99y5GcYjzEIzognaJzVTzKwM2qrt7AUFl+
 41EGPV7LGhO3FfQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The lookup_subflow_by_daddr() helper checks if there is already a
subflow connected to this address. But there could be a subflow that is
closing, but taking time due to some reasons: latency, losses, data to
process, etc.

If an ADD_ADDR is received while the endpoint is being closed, it is
better to try connecting to it, instead of rejecting it: the peer which
has sent the ADD_ADDR will not be notified that the ADD_ADDR has been
rejected for this reason, and the expected subflow will not be created
at the end.

This helper should then only look for subflows that are established, or
going to be, but not the ones being closed.

Fixes: d84ad04941c3 ("mptcp: skip connecting the connected address")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e25cda3909fa..5d66f6b1d58c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -130,12 +130,15 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
-	struct sock_common *skc;
 
 	list_for_each_entry(subflow, list, node) {
-		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		remote_address(skc, &cur);
+		if (!((1 << inet_sk_state_load(ssk)) &
+		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
+			continue;
+
+		remote_address((struct sock_common *)ssk, &cur);
 		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}

-- 
2.45.2

