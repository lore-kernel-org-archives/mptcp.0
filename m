Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59071
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623849711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TWm7mKM1PrRr9uWRv+mKaPDXoMEjbG7k9lDHQj/VG4I=;
	b=aihd1dbwIQ/aS5kS89rrzt9ScztOru5c2DB/7haah1M8wHfIK6S9V7qvRPswcM23SYOVjw
	bmWlrKFPc7nM6MTPVPXFdolukyG4ehuDNjJVoUpxEBZdmTf9B3jgRfi0OLWzsFjN/9joIj
	DrtaqzVjZElHzAJ1dJTIuLzG8IGMXWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-KZBDlo_UO8mW9lpYXxv7EQ-1; Wed, 16 Jun 2021 09:21:47 -0400
X-MC-Unique: KZBDlo_UO8mW9lpYXxv7EQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E393FCB4;
	Wed, 16 Jun 2021 13:21:07 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-78.ams2.redhat.com [10.36.115.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE4D2100238C;
	Wed, 16 Jun 2021 13:21:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH mptcp-next] Squash-to: "selftests: mptcp: turn rp_filter off on each NIC"
Date: Wed, 16 Jun 2021 15:20:54 +0200
Message-Id: <69fc350d5e6b4faeb9cffbbd5d36723e236b2ca2.1623849517.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

"$1" is undefined in the setup loop context, $i should be used
instead, otherwise setup (and tests) will fail.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 6b6336d1c39d..fd63ebfe9a2b 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -60,8 +60,8 @@ setup()
 	for i in "$ns1" "$ns2" "$ns3";do
 		ip netns add $i || exit $ksft_skip
 		ip -net $i link set lo up
-		ip netns exec $1 sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $1 sysctl -q net.ipv4.conf.default.rp_filter=0
+		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
+		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 
 	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
-- 
2.26.3

