Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3502F23
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643977027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xo9qGmFEA/D5yzoREm3/quxLstqTqHba0dUCg/M2xhQ=;
	b=YcFZnewncJ7hyyv0w2gBJ/rjcrpu2+tUsidU7i+5mx2L6X4L2l2jxQBE6fK8YV9EPpPFLX
	33jTBUS3drNkJ5jM8s4+3B+NUxs6bwID9+034Ci9ltV2mJAd0ZYeOAqjIexPKjfj2F4tUf
	G7eMG33FAuwBob3a0vONIbW8wtq8Hhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-tMf6halWMDSyOYK-_HMMWQ-1; Fri, 04 Feb 2022 07:17:06 -0500
X-MC-Unique: tMf6halWMDSyOYK-_HMMWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD29C835B4B
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 12:17:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C4AD73153
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 12:17:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next] selftests: mptcp: fix diag instability
Date: Fri,  4 Feb 2022 13:17:00 +0100
Message-Id: <db50196c67b30e7b89d241faffc78e5ffbb04e83.1643976999.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Instead of waiting for an arbitrary amount of time for the MPTCP
MP_CAPABLE handshake to complete, explicitly wait for the relevant
socket to enter into the established status.

Additionally let the data transfer application use the slowest
transfer mode available (-r), to cope with very slow host, or
high jitter caused by hosting VMs.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - use wait_for_ instead larger sleep
 - hopefully better commit message
---
 tools/testing/selftests/net/mptcp/diag.sh | 44 +++++++++++++++++++----
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 2674ba20d524..ff821025d309 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -71,6 +71,36 @@ chk_msk_remote_key_nr()
 		__chk_nr "grep -c remote_key" $*
 }
 
+# $1: ns, $2: port
+wait_local_port_listen()
+{
+	local listener_ns="${1}"
+	local port="${2}"
+
+	local port_hex i
+
+	port_hex="$(printf "%04X" "${port}")"
+	for i in $(seq 10); do
+		ip netns exec "${listener_ns}" cat /proc/net/tcp | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
+
+wait_connected()
+{
+	local listener_ns="${1}"
+	local port="${2}"
+
+	local port_hex i
+
+	port_hex="$(printf "%04X" "${port}")"
+	for i in $(seq 10); do
+		ip netns exec ${listener_ns} grep -q " 0100007F:${port_hex} " /proc/net/tcp && break
+		sleep 0.1
+	done
+}
 
 trap cleanup EXIT
 ip netns add $ns
@@ -81,15 +111,15 @@ echo "a" | \
 		ip netns exec $ns \
 			./mptcp_connect -p 10000 -l -t ${timeout_poll} \
 				0.0.0.0 >/dev/null &
-sleep 0.1
+wait_local_port_listen $ns 10000
 chk_msk_nr 0 "no msk on netns creation"
 
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
-			./mptcp_connect -p 10000 -j -t ${timeout_poll} \
+			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} \
 				127.0.0.1 >/dev/null &
-sleep 0.1
+wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
@@ -101,13 +131,13 @@ echo "a" | \
 		ip netns exec $ns \
 			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} \
 				0.0.0.0 >/dev/null &
-sleep 0.1
+wait_local_port_listen $ns 10001
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
-			./mptcp_connect -p 10001 -j -t ${timeout_poll} \
+			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} \
 				127.0.0.1 >/dev/null &
-sleep 0.1
+wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
 flush_pids
 
@@ -119,7 +149,7 @@ for I in `seq 1 $NR_CLIENTS`; do
 				./mptcp_connect -p $((I+10001)) -l -w 10 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 done
-sleep 0.1
+wait_local_port_listen $ns $((NR_CLIENTS + 10001))
 
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "b" | \
-- 
2.34.1

