Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3870
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622733003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=myCW9F9ln5/3luVY3lmSNmdk4W22B/sNFJwUXKGs2Hg=;
	b=LA9mCVe+9fAlFGJx6p8QoChEniR9Un7ZvzfsLdcRMWq8jrkii8Pc5+UOd4ZofpO+nXIHxl
	NUBQmxoEInv5z3E75A0YLVOX/xGy023IIXEym/wPZYHIgAp4sZNQMwoHF8N1d7cW5vYT0b
	2wk1+u1zUaxjJl4cLrtWbY2CzMSfZZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-ix7nxIC8NHegczI6qQw2-A-1; Thu, 03 Jun 2021 11:10:00 -0400
X-MC-Unique: ix7nxIC8NHegczI6qQw2-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 465A1818703
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 15:09:59 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-52.ams2.redhat.com [10.36.115.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CA7B5D74B;
	Thu,  3 Jun 2021 15:09:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [PATCH v2 mptcp-net] selftests: mptcp: enable syncookie only in absence of reorders
Date: Thu,  3 Jun 2021 17:09:19 +0200
Message-Id: <1a2b1cda55fc38e2143aae3ebab3d9b4e5e5d53f.1622731728.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Syncookie validation may fail for OoO packets, causing spurious
resets and self-tests failures, so let's force syncookie only
for tests iteration with no OoO.

Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/198
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 69351c3eb68c..2484fb6a9a8d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -202,9 +202,6 @@ ip -net "$ns4" link set ns4eth3 up
 ip -net "$ns4" route add default via 10.0.3.2
 ip -net "$ns4" route add default via dead:beef:3::2
 
-# use TCP syn cookies, even if no flooding was detected.
-ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
-
 if $checksum; then
 	for i in "$ns1" "$ns2" "$ns3" "$ns4";do
 		ip netns exec $i sysctl -q net.mptcp.checksum_enabled=1
@@ -748,6 +745,14 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
 		exit $ret
 	fi
 
+	# ns1<->ns2 is not subject to reordering/tc delays. Use it to test
+	# mptcp syncookie support.
+	if [ $sender = $ns1 ]; then
+		ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
+	else
+		ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=1
+	fi
+
 	run_tests "$ns2" $sender 10.0.1.2
 	run_tests "$ns2" $sender dead:beef:1::2
 	run_tests "$ns2" $sender 10.0.2.1
-- 
2.26.3

