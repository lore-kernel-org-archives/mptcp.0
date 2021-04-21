Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E0C2F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsj4EB1vvobd0NOHpJMyD0suT4rRTRRnGVOkhJhW4wE=;
	b=as0wSGbZN8xjXCC8EYmC+AjMnhdaKnF4Le4dOSjPlUbtw3zkoG1fjGwRi4/9/J5pk9KSex
	eLRkIq5zTo9JN0+Xe/CJ8Ax/U3PNW7vTcZCGwTqv7Urg71fCQdQMJWSudUtZrPyQAgu0Uy
	bNxb928V76HZdqee3dEkDuvu8yOz0XE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-GIz8TfY2Or-7Z-d94KNdLg-1; Wed, 21 Apr 2021 16:21:05 -0400
X-MC-Unique: GIz8TfY2Or-7Z-d94KNdLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EF2E1898299;
	Wed, 21 Apr 2021 20:21:04 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 952FC6085A;
	Wed, 21 Apr 2021 20:21:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 20/21] selftests: mptcp: enable checksum in mptcp_connect.sh
Date: Wed, 21 Apr 2021 22:18:09 +0200
Message-Id: <31df6a05f387277426677c92e6ed7266526f32e1.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
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

