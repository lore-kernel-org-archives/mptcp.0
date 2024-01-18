Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2132D603
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602478; cv=none; b=KwkKvBTpHh/jDn0LonQ1Vk0OpUNN5iH8ViPAoMtrYCe9j48xI3E7LITV0dR2eL0Fgz0yFJIyHIdv5hxoNpOYHS/J4iN025Xi5tOqL32noGLmuBTytSJV5VqEezAI2g9y3TFhhogrX+MVaCYuvVgwj6K4tohn9Xzspkfes/R0tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602478; c=relaxed/simple;
	bh=rEc/vMG0kPWnlPR2IEYPbxgDRACprv3BruKwqZ3xHl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TP/Fb1kiBjew2+Xc9+rWJXcrl3aG/PfTBPLyCWbNPBe55MYRmjROiPBc4z67x0OWVVtUHT619lOhEtSCjuQcNCiDA0TK+5H3J37ZvnmQQghbJmX8GB4OR1iXyRJ3RIx+52pgcAyfhWdVy8tWEUYyshB/ukUobZcvLA7ZA+NJGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9Ka34Q8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9Ka34Q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A65C433F1;
	Thu, 18 Jan 2024 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602478;
	bh=rEc/vMG0kPWnlPR2IEYPbxgDRACprv3BruKwqZ3xHl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P9Ka34Q8joy9stCB8gTz0TIRbj4BbikSOPSLzHpjl+H6dY+7YpsspQlOHxqEtbYcU
	 aABd54iXkLcUBheMFsdwbAHY8U2906C+PHMl8M3lgIOMSnLIjrdRDqL9vKsNSQKxii
	 ETFAD61EYWXG8WaqdmvZl1AcDEXMIYOUHfkAe70tP7tlY5+13alWMdpk6a78CsFwme
	 shWJhhRbVM42YAcg/FPtL9olI52IkrjDbFzkSUeSy7HEJnxjJkKQpaAQsQD2wn18v1
	 mM9Jwk+v3HkPxkU3dNzdQ3WMfYotRzwWfiJVJR9bbHtJbODu0P4BK8F/Pnht32/FzA
	 owyOgFaai+/wA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jan 2024 19:27:34 +0100
Subject: [PATCH mptcp-next 4/7] selftests: mptcp: increase timeout to 30
 min
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-4-f3a4db41c3be@kernel.org>
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rEc/vMG0kPWnlPR2IEYPbxgDRACprv3BruKwqZ3xHl4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlqW2pPCuEbIM9K8oFuHCFcKZOQUf+dkHKYr8hB
 uIdq+oqUfGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZaltqQAKCRD2t4JPQmmg
 c/8bD/9T+GgT1GQ5EBq5SGcoX7bF/f7cgruIMtL3JK6cKPAiKFxtdHWiSKQ7TAb8HN+QqajFFYz
 h6yLCB8zHNINmLyEbsRX3dwIcy0fiNvJbD0law9jkqtZekVMdHiFhNi4LFrur3k0ENOrytPcP90
 Ox86q9ZHGGj+SrMNxmND8b6l9EGqqAyhD4g+GMJmcc2hJ+mp7xRXeTz6ueDLDwQr8wO33kMcWCc
 I7GVo7EngTWO9I9O4vzZQ9YltAFo2WZTU6/Xm62kA5mMKxto+FgdoDeeQoB4JC8ry8ODxwAWXwv
 TqBmm+W+h7mUeRAQdlZSQCiPeLyewWHVLVkx9D2XDuMSMwfAx69nFw6hU6wtPxUrsbvrXUSo9Ii
 gpecN4TDMXIRH4hXvkFLdssCg6IOPyZXaxzuwJ9UszGRlItB1BZ6ab/2NFI8hTw9mZWyvJpyTCA
 yXpIPoxhOQr/hzw4IN91GT+teYElVvgie0cb42928Y/rKfyOgn92NtF8krF1OgfkbnFwPv8lDFW
 RB/ulOfMUssQpxOU1C4f9JCpq5asZTZSAMw923lGUGL8XyhiP2Y03Gh9i+sCiYC+w4efMOhZ2Dl
 F2VkNVn2GkOJQEq6ctltE4wysKaiAHPuVxy55GoFSfpRfep5IonG63Qx9HZYAC09H8s4zUdXvR8
 HR4sH1TvsATe+NA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On very slow environments -- e.g. when QEmu is used without KVM --,
mptcp_join.sh selftest can take a bit more than 20 minutes. Bump the
default timeout by 50% as it seems normal to take that long on some
environments.

When a debug kernel config is used, this selftest will take even longer,
but that's certainly not a common test env to consider for the timeout.

The Fixes tag that has been picked here is there simply to help having
this patch backported to older stable versions. It is difficult to point
to the exact commit that made some env reaching the timeout from time to
time.

Fixes: d17b968b9876 ("selftests: mptcp: increase timeout to 20 minutes")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/selftests/net/mptcp/settings
index 79b65bdf05db..abc5648b59ab 100644
--- a/tools/testing/selftests/net/mptcp/settings
+++ b/tools/testing/selftests/net/mptcp/settings
@@ -1 +1 @@
-timeout=1200
+timeout=1800

-- 
2.43.0

