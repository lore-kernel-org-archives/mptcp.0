Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16322F80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsj4EB1vvobd0NOHpJMyD0suT4rRTRRnGVOkhJhW4wE=;
	b=jU+wgABL0p/fnX4j15aHBouKjO3jvBS1L/LIR8/RP2gU93Px1gcrkOnUflMSnEdBzLjm/U
	y6Mtq5+q+f2lGqifxq5IMZFZxceEdg8sTVOmoonNu72QP2PhxEwhN/m730slZqS28zCUcM
	n11/Qx4M49wJS9Ze42M106BwL8hir0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-NKVoWCwIPiisW5bsp_JmkA-1; Tue, 04 May 2021 17:42:51 -0400
X-MC-Unique: NKVoWCwIPiisW5bsp_JmkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEDB41006C80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:50 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C38195C22A
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 21/22] selftests: mptcp: enable checksum in mptcp_connect.sh
Date: Tue,  4 May 2021 23:42:09 +0200
Message-Id: <da4d4412aaae341d512f9e5bad1e452457e1178d.1620163861.git.pabeni@redhat.com>
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
References: <cover.1620163861.git.pabeni@redhat.com>
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

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new argument "-C" for the mptcp_connect.sh script to
set the sysctl checksum_enabled to 1 in ns1, ns2, ns3 and ns4 to enable
the data checksum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 9236609731b1..96cec8c2d975 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -3,7 +3,7 @@
 
 time_start=$(date +%s)
 
-optstring="S:R:d:e:l:r:h4cm:f:t"
+optstring="S:R:d:e:l:r:h4cm:f:tC"
 ret=0
 sin=""
 sout=""
@@ -22,6 +22,7 @@ sndbuf=0
 rcvbuf=0
 options_log=true
 do_tcp=0
+checksum=false
 filesize=0
 
 if [ $tc_loss -eq 100 ];then
@@ -47,6 +48,7 @@ usage() {
 	echo -e "\t-R: set rcvbuf value (default: use kernel default)"
 	echo -e "\t-m: test mode (poll, sendfile; default: poll)"
 	echo -e "\t-t: also run tests with TCP (use twice to non-fallback tcp)"
+	echo -e "\t-C: enable the MPTCP data checksum"
 }
 
 while getopts "$optstring" option;do
@@ -104,6 +106,9 @@ while getopts "$optstring" option;do
 	"t")
 		do_tcp=$((do_tcp+1))
 		;;
+	"C")
+		checksum=true
+		;;
 	"?")
 		usage $0
 		exit 1
@@ -200,6 +205,12 @@ ip -net "$ns4" route add default via dead:beef:3::2
 # use TCP syn cookies, even if no flooding was detected.
 ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
 
+if $checksum; then
+	for i in "$ns1" "$ns2" "$ns3" "$ns4";do
+		ip netns exec $i sysctl -q net.mptcp.checksum_enabled=1
+	done
+fi
+
 set_ethtool_flags() {
 	local ns="$1"
 	local dev="$2"
-- 
2.26.2

