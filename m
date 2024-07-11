Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8028FF
	for <mptcp@lists.linux.dev>; Thu, 11 Jul 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712401; cv=none; b=AvncA41eD/Wx18TGwOVOIQCNWHf+Ycj5ocW31Gkk21Y3ZfYUDuWIXdSLORYHPhvXKHsQKiWhTjltxmLN4vzjpbof2WM4PEZHWCsx5oQTI0EptQ1iXMoiZEO+wwho9ivCViyDGNfkZPoK1wdWLEZ4b0Q2fJMANwW4zT9APSJCJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712401; c=relaxed/simple;
	bh=o6LlgxvdIEwLce8tmc9hgvLbwZq89r/BeJFILy0OplY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdXMLE7cPqJa4RzUtzrlIzecPYt7NOncRifPh9hT5TVPfouD7cSNfAqE7JGVF6SEJ4sYKU+QBhs9SkvQ7EBaInzhPpO9nfGoNk8Lw2GUqDuN5XRmpB31qicgDVgw2ve0peSC+2Hn18WToGkJ+4tYg7LsozwXeTwxe4XBdcUWeLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usL9ZWC7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usL9ZWC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9CEC116B1;
	Thu, 11 Jul 2024 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712401;
	bh=o6LlgxvdIEwLce8tmc9hgvLbwZq89r/BeJFILy0OplY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=usL9ZWC7KZuJ9ufWkyDxBxH7oE3Q6+5MYopQyMQEaLNHKkL7l5/u9yI5m+IHYBYlT
	 lNX4jFgTF2oWnAzHPcc6SWKxH+//FwK42lm10l8l/geaZHY3s378ZtGsoq1P57oUiK
	 OdCQfK8joAElETyFm7wLlhrW6U/CSZAeXAUYkuQ/sYLIHgyp9d55EBsJCcZfzBNWl4
	 uQi8GTMtftDxG5aQC5Uyf5rvY7g9viMn+X2axFG79fmxFp1iB9IziUOJvNQNlJ1XCw
	 QXQgpQ2FK2xXQaFHHbulJAe+yhwzcexPDPSterPt6CNEH1DF2wLqchOjhBl6IOI04y
	 QPQkYghgz/INg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 11 Jul 2024 17:39:02 +0200
Subject: [PATCH mptcp-net 5/6] Squash to "selftests/bpf: Add bpf_bkup
 scheduler & test"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mptcp-backup-mpj-v1-5-d45506182a9e@kernel.org>
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
In-Reply-To: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=o6LlgxvdIEwLce8tmc9hgvLbwZq89r/BeJFILy0OplY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmj/zJ4x3+18g2X5SUPE3XcamKluhRbAlosdtrN
 OOuQYYP3veJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZo/8yQAKCRD2t4JPQmmg
 czkYD/9eV1t/9jOHnf3Jqbj0RyIBBTfQN6TBNzG0WY3/dQvQTbie2PYgPyF+B9oNG7UhFlCgnab
 mzfJVbfNYyyV8ihy+9TjxIazL1+UdRDMhDTpKE4zGu7IoyjgZ9PKK5i9qY7cMs5z7SwcDBwK3CF
 4HFsQam2BQb1Ikon4VwCkdiZZpmDsbZwJr/bjxVHrxt6HPNz9yF9FU325cmvYI8T40Ep4JwCyeo
 4HOvUTxkQcqw5cSpZckxSj4g9WxDI3EAVuaSY7aB+wpcPo8Fcp8KLCYiZQbMVB+IEgpir0E55M/
 HPizUpN4/SXQtYJe/wDMVf0AtWE+4HR9dD2G+ORWZACDKSmz1hshQliatJPTgfr06jqkGAD8CWj
 n08QvCWjPdtp9M+hRc4UXcUCwzor/iEbIBADZoUlOBDh8dmIO8Y/BtOCLJDdT7FPEpQ8DWP/VPs
 2bQw3uOMrzzMBHjVy78ulZLAqDKigfbSy0EAhvZCg69ToxwEM8LRKGPOz6/tQTxaDoybWtu4GFy
 2nOxE+097eL0htvItrjiXq1fUx16nx+ridD7VHZMq3oIdnadY4IWr6DyQN6GVec/jfEI2W6bjnl
 PE/tyErkFb3H/vXtA5nttQcDNc7cWU8Kn5XsNYRB+t7YHNLbrdoUtJ888572oi8+IOh5uVhIQDn
 uHtKY91zNP3H+GA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to "mptcp: sched: check both directions for backup": it didn't
matter before because the two flags were very likely set by accident.
But that's no longer the case now.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 14091bcc4cde..296f0318d843 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -29,7 +29,8 @@ int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 		if (!subflow)
 			break;
 
-		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup)) {
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup) ||
+		    !BPF_CORE_READ_BITFIELD_PROBED(subflow, request_bkup)) {
 			nr = i;
 			break;
 		}

-- 
2.45.2

