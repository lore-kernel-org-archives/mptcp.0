Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3564
	for <mptcp@lists.linux.dev>; Mon, 16 Feb 2026 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771276868; cv=none; b=Vq1tjxr47t8YOja99WR5A30DTI4VrOC6A2oOsbIOkCrdBM7LKd15D3J4f4Dvy9gAH84xNj1gXFFrdtHCWTNE8Nf/7VQ9JB2t6iLgY5DVNWfJvigN5fA3JUGcFj1CyfSR9qtolmLrq4ONc6SzoQE3wtDyerc1qTDQ368G9BneSFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771276868; c=relaxed/simple;
	bh=GgpBBCE6PIrLG5gJrJGhoGzKSZWNw6k7F0bGN3oRc/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Rjdb1xffyE3KidrCKMKDoDFUDO7WaK1cS6ifwSoq9670n+zmOZXAZ7OQnskCrMzzdpgFmwgtbsIyHYVtZOtMBsqDkhKkddeOt5J3zyqninePgQWNDEbfbaNATE2m8jywBp7EH2RdLjokK9xJ+Bdc8Qrs6Usxc43rahmOsENU/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/3d0Gxv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/3d0Gxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771276865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XewVg84ybuY/OCh9eu8zAzPe7oeEFrYNVbZtEo4+FoA=;
	b=A/3d0GxvFdBVszyFRC6/pSspBax/rv9tq0rdoATiLK/DboNrqac7kOIiWVznhhBaK7OOFZ
	YsRtU4xiATiFnTjBuU2An6tM7MW0zr8FKXU7XeCrV3p7AC+tqYeqn068iQDX+xtg36569S
	r5hr4pjhsKinGkRUcUCOwjx+M4TlZVk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-mxmLhgqOMMW4q0EdeiH3og-1; Mon,
 16 Feb 2026 16:21:02 -0500
X-MC-Unique: mxmLhgqOMMW4q0EdeiH3og-1
X-Mimecast-MFC-AGG-ID: mxmLhgqOMMW4q0EdeiH3og_1771276861
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A1031955D8C;
	Mon, 16 Feb 2026 21:21:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.56])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 254E830001A5;
	Mon, 16 Feb 2026 21:20:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next] selftests: mptcp: more stable simult_flows tests
Date: Mon, 16 Feb 2026 22:20:55 +0100
Message-ID: <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lkh2W-79QDVy9H-_6_n9sXF3n_hrP6YqVaMKO8Neq-4_1771276861
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

By default, the netem qdisc can keep up to 1000 packets under its belly
to deal with the configured rate and delay. The simult flows test-case
simulates very low speed links, to avoid problems due to slow CPUs and
the TCP stack tend to transmit at a slightly higher rate than the
(virtual) link constraints.

All the above causes a relatively large amount of packets being enqueued
in the netem qdiscs - the longer the transfer, the longer the queue -
producing increasingly high TCP RTT samples and consequently increasingly
larger receive buffer size due to DRS.

When the receive buffer size becomes considerably larger than the needed
size, the tests results can flake, i.e. because minimal inaccuracy in the
pacing rate can lead to a single subflow usage towards the end of the
connection for a considerable amount of data.

Address the issue explicitly setting netem limits suitable for the
configured link speeds and unflake all the affected tests.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index a9c9927d6cbc..d11a8b949aab 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -237,10 +237,13 @@ run_test()
 	for dev in ns2eth1 ns2eth2; do
 		tc -n $ns2 qdisc del dev $dev root >/dev/null 2>&1
 	done
-	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1
-	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2
-	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1
-	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2
+
+	# keep the queued pkts number low, or the RTT estimator will see
+	# increasing latency over time.
+	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1 limit 50
+	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2 limit 50
+	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1 limit 50
+	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2 limit 50
 
 	# time is measured in ms, account for transfer size, aggregated link speed
 	# and header overhead (10%)
@@ -304,7 +307,7 @@ run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 # we still need some additional infrastructure to pass the following test-cases
 MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"
 run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
-MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
+run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.53.0

