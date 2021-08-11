Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499B29D6
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628673965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asvcO0aMEGDXgbpD9+Nu+lDxBehXUnHPbs+zA8Axu8M=;
	b=FKujc0W3Nims15kn1Mk47grFnuTGvPuCvVoIaaNsYfQy40UDk1qdE1xJXXKP0PxGCwlI0v
	Kxl8FvLMqxNOF741TYP/AU1h8CpbrnGTb6x/aqupVkALrO/tqwyjl23DJq4or4osgU3za1
	XA99dWBA3FWq79Jl7DvS+2M1glSb5TY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-ISNwRBD3OsmDb2DGhfVepA-1; Wed, 11 Aug 2021 05:26:03 -0400
X-MC-Unique: ISNwRBD3OsmDb2DGhfVepA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2559D801AEB
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 09:26:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 907495C1B4
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 09:26:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] Squash-to: "selftests: mptcp: add testcase for active-back"
Date: Wed, 11 Aug 2021 11:25:51 +0200
Message-Id: <e22d8536321afe997d8cd39f742002b659b0a514.1628673891.git.pabeni@redhat.com>
In-Reply-To: <cover.1628673891.git.pabeni@redhat.com>
References: <cover.1628673891.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

we need to use big-enough client file on link failure test.

We compute the expected link usage assuming half of the client
data will be sent after the link failure. The link failure
happens after sending once the client file, and than the client
file is sent again. After the link failure, a whole cwin amount
of data can be re-inected: to be able to predict correctly
the link utilization the client file size must be much greater
then max cwin.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ae406b56c684..255793c5ac4f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -513,9 +513,13 @@ run_tests()
 	# create the input file for the failure test when
 	# the first failure test run
 	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
-		size=$((RANDOM%8))
+		# the client file must be considerably larger
+		# of the maximum expected cwin value, or the
+		# link utilization will be not predicable
+		size=$((RANDOM%2))
 		size=$((size+1))
-		size=$((size*2048))
+		size=$((size*8192))
+		size=$((size + ( $RANDOM % 8192) ))
 
 		cinfail=$(mktemp)
 		make_file "$cinfail" "client" $size
-- 
2.26.3

