Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2042900D
	for <mptcp@lists.linux.dev>; Thu, 23 Jul 2026 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800585; cv=none; b=EsDdOezhikw8RZ5e3rHyF7FkqtQvO0Zwu9t49+94fAPNUIeov8VJqUKImsfqWh8ZkjBZN8nrKMJj7JWCym3pHcFVaGx8Hg4PdlgOBehTQV5WMRxC0794ttwEvZh0gX6HU1jjKbN9wbP4+FxQ/kbcgGdn8BJU8MzmMdf0YgeAEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800585; c=relaxed/simple;
	bh=4dq+AfFJnc9i3T4d2D0Uu0GdHw2xgZF6Xk2tckSnQ0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4FdRATTeK+55SiFkc/H64ro/OSP0TQt5s8smG85COjoihF9dwT1bNg83I2Ij6c0+Z5zuNsPe30tDyOGvMNTAEfDiqJDlSmeUayJ9etrhf5FbrzpU/AyLv7rhNepI4DWHYrNR22hnvNlPEzYgVVnLR4MKFec6i2Gxks9y15Z9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNpBxbfK; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNpBxbfK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784800581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x07/KnxTps7j5nG2mCB2NLpZgVKtjzP6YnwyINvd4uA=;
	b=MNpBxbfKJ2EzjqEl01qUsJfxaKzpz60aDRdiBgaru3z5KJyvcsF0zHfo8DmACxexl6FOE+
	l7+5YfVv3moamxjkAgeZRa6pGSFSlSrgxE7/vGT9Gx9fhv9brSNHUQwmDvSagbXd/L70z5
	vUXxbxLfSjFPJWMdKSPvDZWLqWrBXPE=
From: Gang Yan <gang.yan@linux.dev>
Date: Thu, 23 Jul 2026 17:55:58 +0800
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: check local_addr_used in
 userspace PM
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-localaddr-v1-2-ce84b865594a@kylinos.cn>
References: <20260723-localaddr-v1-0-ce84b865594a@kylinos.cn>
In-Reply-To: <20260723-localaddr-v1-0-ce84b865594a@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch extends userspace_pm.sh to check the local_addr_used in
'test_announce'/'test_remove'. We need to make sure it should increase
after 'ann' and decline after 'rem'.

Assisted-by: Codex:GLM-5.2
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 30a809752d1b..eaf356b9e039 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -391,6 +391,17 @@ test_announce()
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
+
+	# Check local_addr_used was incremented after announces on server
+	local addr_used
+	addr_used=$(ss -N "$ns1" -inmHM "sport = :$app4_port" | \
+		   mptcp_lib_get_info_value "local_addr_used" "local_addr_used")
+	print_test "local_addr_used > 0 after announce"
+	if [ "$addr_used" = 2 ] 2>/dev/null; then
+		test_pass
+	else
+		test_fail "local_addr_used=${addr_used} (expected 2)"
+	fi
 }
 
 verify_remove_event()
@@ -495,6 +506,26 @@ test_remove()
 	print_test "RM_ADDR6 id:server-1 ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
+
+	# Check local_addr_used was decremented back to 0 after all removes
+	local addr_used
+	addr_used=$(ss -N "$ns1" -inmHM "sport = :$app4_port" | \
+		   mptcp_lib_get_info_value "local_addr_used" "local_addr_used")
+	print_test "local_addr_used=0 on server after remove"
+	if [ "$addr_used" = "0" ]; then
+		test_pass
+	else
+		test_fail "local_addr_used=${addr_used} (expected 0)"
+	fi
+
+	addr_used=$(ss -N "$ns2" -inmHM "sport = :$client4_port" | \
+		   mptcp_lib_get_info_value "local_addr_used" "local_addr_used")
+	print_test "local_addr_used=0 on client after remove"
+	if [ "$addr_used" = "0" ]; then
+		test_pass
+	else
+		test_fail "local_addr_used=${addr_used} (expected 0)"
+	fi
 }
 
 verify_subflow_events()

-- 
2.43.0

