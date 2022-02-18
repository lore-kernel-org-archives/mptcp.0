Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6192919
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645197454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UO8s63RSLtN3B5q4r6cHmPTKfgeKrEnM4eV41MMdVfc=;
	b=WtxL1+IvBHXDrt24xTqWQKp/qFT9e9iX0kGgnerBcEoWgL5Ui4JN6KLl8YCmx9kQidqG0B
	RBDPR8eZ9pRiCaoYefW62DWEjmDOErh4o4u8039fuXiMoIjteM8qRwlyyXqVwlf68WhZv3
	2vEcwpRktxlqibinv1nTOPORusfZksA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-qbDI8CruNTeMYcqS_VEgVQ-1; Fri, 18 Feb 2022 10:17:33 -0500
X-MC-Unique: qbDI8CruNTeMYcqS_VEgVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90193814243
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:17:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 048D07CAD7
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:17:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: do complete cleanup at exit
Date: Fri, 18 Feb 2022 16:17:21 +0100
Message-Id: <3242f7901090b007a6c491cb971f99c530182d6d.1645196974.git.pabeni@redhat.com>
In-Reply-To: <cover.1645196974.git.pabeni@redhat.com>
References: <cover.1645196974.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

After commit 05be5e273c84 ("selftests: mptcp: add disconnect tests")
the mptcp selftests leave behind a couple of tmp files after
each run. run_tests_disconnect() misnames a few fariables used to
track them. Address the issue setting the appropriate global variables

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5b7a40d73253..621af6895f4d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -782,8 +782,8 @@ run_tests_disconnect()
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
 	# restore previous status
-	cout=$old_cout
-	cout_disconnect="$cout".disconnect
+	sin=$old_sin
+	sin_disconnect="$cout".disconnect
 	cin=$old_cin
 	cin_disconnect="$cin".disconnect
 	connect_per_transfer=1
-- 
2.34.1

