Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40813C693
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211657; cv=none; b=bNh20+OF6u+9RsVRJZjMTBmkp9zO71eJnesvrQXtNJXsLYFms3p9NBuCk4ekd81J1G3lvD5BA7sEEGpDLq68iQwO+VXR2yhgBP7Z9GngLmLpRhm8gF00oUlmDcDYjRcAoQZ/5uVlFUIGjq/8xgh0jpFPWk7EUzzMahVgaIY6+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211657; c=relaxed/simple;
	bh=BBzw9lcdzw1FIe2gu7NLmSzgSVq9KasLMhRZOmUg6yU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILFY86bdYxvqxY/Hgyaz3NIW2WyZ5l640NkknkawfKNrcTu9m5/RYV6NiHfHkIwHFvZGX5FFtNLiVDjSmCN+mOIklwVCFtIxNg02SuhJSHdavd8X/rr7SUVjIt6CAH+eI0y6SNyjGH0hKpssHfRLHKn+b7Y3hb/8KYWR0uOBR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ux91lTxH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux91lTxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720211654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HF0Sflkj3oWQb2JuZOFuhSptlK/wmSIPInhrjJNzQkE=;
	b=Ux91lTxHsHLq/koW0cX0JyTHug41jI6foYA1wq/T7MMd3LI4HLea37VZSTpTPQlj3WYt9/
	FmZfqcF4YVPR49HaX4MInSQXrhRVPbjklnawtvMSBRDdQopZs569SAmBZZlSiH8mGxJ06h
	SiCRWv9e6icgOdvwTmonSMq48Rvl8Rc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-dZuWnSNYME6cr3Ld8UhC0Q-1; Fri,
 05 Jul 2024 16:34:09 -0400
X-MC-Unique: dZuWnSNYME6cr3Ld8UhC0Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88158195609E
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CCDF1955F3B
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 3/4] selftests: mptcp: add explicit test case for remove/readd
Date: Fri,  5 Jul 2024 22:33:49 +0200
Message-ID: <1b8edfa9c66d0feabd0a5999b5e8761c5f7491fc.1720211515.git.pabeni@redhat.com>
In-Reply-To: <cover.1720211515.git.pabeni@redhat.com>
References: <cover.1720211515.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Delete and re-create a signal endpoint and ensure that the PM
actually deletes and re-create the subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - depends on subflow_rebuild_header
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 108aeeb84ef1..9c091fc267c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3526,6 +3526,35 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		mptcp_lib_kill_wait $tests_pid
 	fi
+
+	# remove and re-add
+	if reset "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
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
2.45.2

