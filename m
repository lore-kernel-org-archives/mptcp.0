Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C8182DF
	for <mptcp@lists.linux.dev>; Mon, 20 May 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215883; cv=none; b=rr3Z0kWi+TsIAqwJDxzYGk6fl1YB460dfswNcJR+r1B25kr+N87plhOoEluRskW+r/wiF1HTXyiRSmQyuTUbGJiILkKWfJz0GJVFhipkWvjwsS8MKIsRL20bz3rDXJF62Q+dOU7HdnhfoTbfz3NKC9sH1ahtU2foxpLEdWZ7hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215883; c=relaxed/simple;
	bh=TFZxzrQij2ugFZMJYuOcFKWqgjxQAMh7oMIejTm6wf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FFsiufelS5VHwV47mwzDwuF/PQDWi6W3uddQP/rZhbnMzZxBT8lW3McOcQTfKz+9Le4/WwRHRzfIZXscm/ddhOMRJ6fH6PEkmU+zeUno/39B4j0ZIDdbltXYi4bT82OKP+JV3m7pZlqSe5pI1rpWiJJjYBQPtbdoHlKVdmkvNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G23SyBav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G23SyBav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C9FC2BD10;
	Mon, 20 May 2024 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716215882;
	bh=TFZxzrQij2ugFZMJYuOcFKWqgjxQAMh7oMIejTm6wf0=;
	h=From:Subject:Date:To:Cc:From;
	b=G23SyBave1zkh4zQC8IFv06DNvQbpDcfO9GvmFL06es3lIpz1Q2zRf8oiQwba/y0e
	 P+uD2kyBhUzhcYvIX3U3UVgbRAPELKilqtkm0dKX6WqLzVaCw6ObTohozdxCSJ8s+V
	 Jvkc1/Ora/dVkpa5MXinpVPDo+DBCpX2+cGkMUxx5xYqqo2WbXTkNa9Xejs0PV7sCQ
	 wA/PuV9s3XMD6ZF1xDtPzt5R5lR79iIwA80kO4syE0xBHaT1wUWI8t+UMXQZD3dJck
	 wqyhkcZJlaiq+5ZsR7tNcDEpS+GDQOK8qKWhtQ13HgIWbc4O+03kteyTEz0ayYb7A1
	 IJ1dtHuaHj+tQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/4] selftests: mptcp: mark unstable subtests as
 flaky
Date: Mon, 20 May 2024 16:37:54 +0200
Message-Id: <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAENgS2YC/yXMTQ4CIQxA4atMurZJZcS/q0xcIBRtRCSUmDGTu
 btEl9/ivQWUq7DCeVig8ltUXrljuxnA312+MUroBkNmR9YQKqfYWJviszRfMIi6a2KMyT0+OB7
 pYE9hb2n00B+lcpT595/gH2SeG1zW9Qt55X2VewAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TFZxzrQij2ugFZMJYuOcFKWqgjxQAMh7oMIejTm6wf0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmS2BJMoJdVxZQHnWBTjs9kpDNPfUe3PmRoVOaU
 D1htdkU7eiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZktgSQAKCRD2t4JPQmmg
 c2Z+D/9cpQsDF9Dlr8ziTM6+UN4n9rT8/84d1iAZyZSA3TuiateX4Z1A47M2Jq/tZxGCyh4RgPt
 h4u74sudQhD0XykXOepSylTG+SOfAT3qo4nBaNh+4POEsXQvah57a5VX0U7JZ573/AAmQBu+ZCF
 IlbINdECg0NY4DH/s4kX3a9acEusRyQjJsLxBu2vBCGKyX2hbH3aQVJ/Dh94DWjKfPeVaD7AkAm
 d3HPOu3nF3GoG7OTS2S/17yh4HMb8rjyw9i9OdN4JoCdw/J7hoqZqDX8LG0CH2aHighXqjK/If3
 Ib7SFaV5b9gsabMzkp65Cyq9H6BaMPiU2Rdel5/UxXplChv+7UVZLAPV3hkcfQzj0qY12nh03UO
 goet9WDyn2LfNFnZEGP+3MeVHbr3UlGkhe7TOff/uagq3rielC6JfRY03mL4iFewIPukb9m8XVy
 buDdbrjqPIh7Fwrvlmf6h0j5LooGO2j71BHXvwr1FmLpjIjWdMB6xghyzhpMqS5GEDekUQYGPUp
 DENp/OvPtmD3/4jFPRclEKUx528qv+qFnOiBPI4QLi17AqF3RVFzpH+OdF0Ghvpw9n2cQZwwkHu
 01+nu5LHU6hrs3G1vYkTLIAAQtYu/+O8BbOR4RqibpWSf/sqfAPsHY3Zatqw9nBbl3Q46v9cp6b
 LqjQHhZgl3LpG8w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some subtests can be unstable, failing once every X runs. Fixing them
can take time: there could be an issue in the kernel or in the subtest,
and it is then important to do a proper analysis, not to hide real bugs.

To avoid creating noises on the different CIs, some subtests have been
marked as flaky. As a result, errors with these subtests (if any) are
ignored.

Note that the MPTCP CI will continue to track these flaky subtests. All
these unstable subtests are also tracked by our bug tracker.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      selftests: mptcp: lib: support flaky subtests
      selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
      selftests: mptcp: join: mark 'fastclose' tests as flaky
      selftests: mptcp: join: mark 'fail' tests as flaky

 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 10 +++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 38 +++++++++++++++++------
 tools/testing/selftests/net/mptcp/simult_flows.sh |  5 +--
 3 files changed, 41 insertions(+), 12 deletions(-)
---
base-commit: 6816c73b882ab90adec3eb18ff296b30bea570b8
change-id: 20240520-selftests-mptcp-disable-flaky-380759d6503c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

