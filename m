Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C30156984
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590064; cv=none; b=URiiJiei/KdTMFGtTzHsWRlJ3Icvuspw129dL6l+WcqAW9/bzFRRttKM+bFyXJUwVm3e59dcvSuvRR9vNU/OV4U2e5G8wzcT/TtGPfq5gcWZL9N5v1g/xKKfD9b44kuFrMbEsrGIK7atIW0AYhKiKQt//KW1yPinHl9TIxIIKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590064; c=relaxed/simple;
	bh=doVW96hD6QiQIaRrsTzVL7Gi9HtDmsH3Wv13tDg1oA8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H29rs1P8wqFgd8PtCGjxaw26q4Y5e6Nfc+cBVVTT3g4vuezKz49WR0ZFf2Q55TJAuqoG/Wyl3YeaP2IQM910VyjSEflTl8/YCmRlXCic7ndEFj01rIBf5OoPJEY3wBeJpnLrLYnmtF1oP6OlgMBCJwo7fkLPy4IH3TxrtVfV3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sm3HThIa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sm3HThIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719590062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIBQh24d6vWdM7BJTL3zDjjnjdKv+1+tuG8Mew6FA98=;
	b=Sm3HThIah0FnvTM+T3CwiJgvfJidGVT06PWr6RWCA1L7Ad42sf9gfbjSltC8mlnKceREqW
	ueqjS+ftsJLQYe8uQrbV3Bmq1VJkH/uBoBZOKorVXMjEzxqytdv+/hbyd9vALl5u5xRhst
	WPwOT89eW8AHMMm0EZn3L0m2djCujZs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-zt90u0FUONypnCcIaJ1GpA-1; Fri,
 28 Jun 2024 11:54:20 -0400
X-MC-Unique: zt90u0FUONypnCcIaJ1GpA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCDDA1945110
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCE2B19560B2
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/3] selftests: mptcp: add explicit test case for remove/readd
Date: Fri, 28 Jun 2024 17:54:07 +0200
Message-ID: <1d4a6ebd0f843910f35a842673af55fca6962b8e.1719589916.git.pabeni@redhat.com>
In-Reply-To: <cover.1719589916.git.pabeni@redhat.com>
References: <cover.1719589916.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Delete and re-create a signal endpoint and ensure that the PM
actually deletes and re-create the subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 108aeeb84ef1..228fecee61f9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3526,6 +3526,34 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		mptcp_lib_kill_wait $tests_pid
 	fi
+
+	# remove and re-add
+	if reset "delete re-add signal"; then
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		pm_nl_check_endpoint "creation" \
+			$ns1 10.0.2.1 id 1 flags signal
+		chk_subflow_nr "before delete" 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		sleep 0.5
+		chk_subflow_nr "after delete" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add" 2
+		chk_mptcp_info subflows 1 subflows 1
+		mptcp_lib_kill_wait $tests_pid
+	fi
+
 }
 
 # [$1: error message]
-- 
2.45.1

