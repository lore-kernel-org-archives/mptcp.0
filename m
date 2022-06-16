Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5928E4
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655387755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gWeBCyh4HWwcugZn1ikAE1myQGLo/gYWZyJva0YmXVs=;
	b=hxY3XFosFmFvgmwXQT+ZweuPd1To1aSTJJ3v/3a61kYOx+cKPWFgHWTEekWZDOqlR3PIRB
	kbeNOwmM2Xf+ekzRkuuJzFDvnsHEVE2D3rDbReBHZneuCsSkgztSWHNuODiZFb9J77RuXy
	VCqeoE67rY33ZmTcDfgkDwMJNVeLCb4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-GWjbrsggMCqp1pNHy2JuIg-1; Thu, 16 Jun 2022 09:55:54 -0400
X-MC-Unique: GWjbrsggMCqp1pNHy2JuIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5991585A580
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 13:55:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEA621415108
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 13:55:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] selftests: mptcp: tweak simult_flows for debug kernels.
Date: Thu, 16 Jun 2022 15:55:48 +0200
Message-Id: <d1745c1e08937164e34f0010369e8be5f4c2afb0.1655387728.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mentioned test measures the transfer run-time to verify
that the user-space program is able to use the full aggregate B/W.

Even on (virtual) link-speed-bound tests, debug kernel can slow
down the transfer enough to cause sporadic test failures.

Instead of unconditionally raising the maximum allowed run-time,
tweak when the running kernel is a debug one, and use some simple/
rough heuristic to guess such scenarios.

Note: this intentionally avoids looking for /boot/config-<version> as
the latter file is not always available in our reference CI
environments.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index f441ff7904fc..141fcf0d40d1 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -12,6 +12,7 @@ timeout_test=$((timeout_poll * 2 + 1))
 test_cnt=1
 ret=0
 bail=0
+slack=50
 
 usage() {
 	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
@@ -52,6 +53,7 @@ setup()
 	cout=$(mktemp)
 	capout=$(mktemp)
 	size=$((2 * 2048 * 4096))
+
 	dd if=/dev/zero of=$small bs=4096 count=20 >/dev/null 2>&1
 	dd if=/dev/zero of=$large bs=4096 count=$((size / 4096)) >/dev/null 2>&1
 
@@ -104,6 +106,13 @@ setup()
 	ip -net "$ns3" route add default via dead:beef:3::2
 
 	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
+
+	# debug build can slow down measurably the test program
+	# we use quite tight time limit on the run-time, to ensure
+	# maximum B/W usage.
+	# Use the kmemleak file presence as a rough estimate for this being
+	# a debug kernel and increase the maximum run-time accordingly
+	[ -f /sys/kernel/debug/kmemleak ] && slack=$((slack+200))
 }
 
 # $1: ns, $2: port
@@ -241,7 +250,7 @@ run_test()
 
 	# mptcp_connect will do some sleeps to allow the mp_join handshake
 	# completion (see mptcp_connect): 200ms on each side, add some slack
-	time=$((time + 450))
+	time=$((time + 400 + $slack))
 
 	printf "%-60s" "$msg"
 	do_transfer $small $large $time
-- 
2.35.3

