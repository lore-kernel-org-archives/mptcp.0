Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC93B78F
	for <mptcp@lists.linux.dev>; Fri, 10 Nov 2023 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cavWxfIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699647882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jdmJ9b7RsmqsMruglvss8aVa42vN2w9jicZyzhv4pes=;
	b=cavWxfItU2OwmAusZgoJtJeFZsNZZ74xRc9eZeSxx2O+cp0nRT7swjzNkmLxeMjbNtOHG5
	HXgzKyOPgf+UQ3QCOcYEiO7vNFkppdAIc+Qft7whbgPWx1dECQUjya9hudRZC0JJXPPw0+
	wHbFQT4tTKDJCDiLMK2gJcixqDMXtis=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-nQtSP3KAORq8b7WwKL3f_A-1; Fri, 10 Nov 2023 15:24:41 -0500
X-MC-Unique: nQtSP3KAORq8b7WwKL3f_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47E5485A58A
	for <mptcp@lists.linux.dev>; Fri, 10 Nov 2023 20:24:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C7ABB40C6EB9
	for <mptcp@lists.linux.dev>; Fri, 10 Nov 2023 20:24:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] selftests: mptcp: fix fastclose with csum failure
Date: Fri, 10 Nov 2023 21:24:36 +0100
Message-ID: <720d67a275179d96aba05cccd56a98f10da47aa1.1699647725.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Running the mp_join selftest manually with the following command line:

  ./mptcp_join.sh -z -C

lead to some failures:

  002 fastclose server test
  # ...
  rtx                                 [fail] got 1 MP_RST[s] TX expected 0
  # ...
  rstrx                               [fail] got 1 MP_RST[s] RX expected 0

the problem is really in the wrong expectations for the RST checks
implied by the csum validation. Note that the same check is repeated
explicitly in the same test-case, with the correct expectation and
pass successfully.

Address the issue explicitly setting the correct expectation for
the failing checks.

Reported-by: Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: ("6bf41020b72b selftests: mptcp: update and extend fastclose test-cases")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 995280882428..1606474232f6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3220,7 +3220,7 @@ fastclose_tests()
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
+		chk_join_nr 0 0 0 0 0 0 1
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
 	fi
-- 
2.41.0

