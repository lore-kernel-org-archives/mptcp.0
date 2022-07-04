Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301523CE
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656926095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DFKaN8QVS/mKAoW3OQy6u47fqbLFxD26tTV/pZD5xY=;
	b=CGfrcEoiDoW/s/Ep+n/mAbwjuhmzRNvPnwCLTJJoIWRVx2cAny1J31DFlDJ7Rz1kvooI6/
	xKVRAaRjAOxi4I/5CZwpfAls1uPYy6L97IdFME3jeyU5q5y0a6l6Bg2yruVBuju6YkRVWo
	paMrAgCPJn8nntPpXWgXFPAG0q9poAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-orDEeygqPv6Tc-72U5dTXA-1; Mon, 04 Jul 2022 05:14:53 -0400
X-MC-Unique: orDEeygqPv6Tc-72U5dTXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFDFB1019DE1
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4503B2166B26
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 5/5] selftests: mptcp: add MPC backup tests
Date: Mon,  4 Jul 2022 11:14:36 +0200
Message-Id: <5d99d7ec0eb00d7fb2d5841586ff5825b36fca53.1656925387.git.pabeni@redhat.com>
In-Reply-To: <cover.1656925387.git.pabeni@redhat.com>
References: <cover.1656925387.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Add a couple of test-cases covering the newly introduced
features - priority update for the MPC subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55efe2aafb84..ff83ef426df5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2428,6 +2428,36 @@ backup_tests()
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
 	fi
+
+	if reset "mpc backup"; then
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		chk_join_nr 0 0 0
+		chk_prio_nr 0 1
+	fi
+
+	if reset "mpc backup both sides"; then
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		chk_join_nr 0 0 0
+		chk_prio_nr 1 1
+	fi
+
+	if reset "mpc switch to backup"; then
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		chk_join_nr 0 0 0
+		chk_prio_nr 0 1
+	fi
+
+	if reset "mpc switch to backup both sides"; then
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		chk_join_nr 0 0 0
+		chk_prio_nr 1 1
+	fi
 }
 
 add_addr_ports_tests()
-- 
2.35.3

