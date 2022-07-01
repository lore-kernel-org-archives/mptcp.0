Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E270186D
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656669947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DFKaN8QVS/mKAoW3OQy6u47fqbLFxD26tTV/pZD5xY=;
	b=V/AaSLA1rQ9Jg8urdXEAiHQ7BMHRspGQVYp4meFsH+yTOXvvQYi3ShDkp9pVhUHakxV6kz
	E5pvK5hQ6UGOoQ/X7CSYCCqPsa+2K1ULGe7rmMLlSM9CdEQ1+kMlwPDlM0ewhwnKF1YVaT
	G4d/sZB4RL050FEyk6mIooDfJsW7wtg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-WNawn-H0NzWzTbTg3fq65g-1; Fri, 01 Jul 2022 06:05:43 -0400
X-MC-Unique: WNawn-H0NzWzTbTg3fq65g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82A68101A586
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 12E4240E7F28
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 6/6] selftests: mptcp: add MPC backup tests
Date: Fri,  1 Jul 2022 12:05:26 +0200
Message-Id: <212a50ec33651131416e0bc7c0533343d8135dfb.1656669391.git.pabeni@redhat.com>
In-Reply-To: <cover.1656669391.git.pabeni@redhat.com>
References: <cover.1656669391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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

