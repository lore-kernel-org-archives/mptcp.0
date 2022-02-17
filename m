Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A214625
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645134298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDxtmpkjdaEaEPOBBZxTL283xP61OodFJWQs9REG3b8=;
	b=HhPyLC1YGw+JsYXRUZivV/GdjO8hZ4S1MXRn6SOoEd9fun3OCp/UZ1VxtKyQRG+f+0GTr5
	BHM7TawLYKb2+bQpP2i8NtBYoDZQiGgT7KFFlMyNnLZPN6llX2f5r9zo5l0a70bUq4yzI6
	UEWIUvhe2LxMb8H1fqBsX+YTZ3dS/Yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-LkQWin9RM3C77-8NLGaddw-1; Thu, 17 Feb 2022 16:44:56 -0500
X-MC-Unique: LkQWin9RM3C77-8NLGaddw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C0FF18C8C00
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6FEF95E26B
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 4/4] selftests: mptcp: add implicit endpoint test case
Date: Thu, 17 Feb 2022 22:44:14 +0100
Message-Id: <25749985f541eff90e537d56abeff5c289639384.1645134065.git.pabeni@redhat.com>
In-Reply-To: <cover.1645134065.git.pabeni@redhat.com>
References: <cover.1645134065.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Ensure implicit endpoint are created when expected and
that the user-space can update them

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 111 +++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   7 ++
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 913866d5d570..9414a1c62fe0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -413,6 +413,76 @@ pm_nl_change_endpoint()
 	fi
 }
 
+pm_nl_check_endpoint()
+{
+	local line expected_line
+	local msg="$1"
+	local addr=$3
+	local ns=$2
+	local _flags=""
+	local flags
+	local _port
+	local port
+	local dev
+	local _id
+	local id
+
+	TEST_COUNT=$((TEST_COUNT + 1))
+	printf "%03u %-40s" "$TEST_COUNT" "$msg"
+
+	shift 3
+	while [ -n "$1" ]; do
+		if [ $1 = "flags" ]; then
+			_flags=$2
+			[ ! -z $_flags ]; flags="flags $_flags"
+			shift
+		elif [ $1 = "dev" ]; then
+			[ ! -z $2 ]; dev="dev $1"
+			shift
+		elif [ $1 = "id" ]; then
+			_id=$2
+			[ ! -z $_id ]; id="id $_id"
+			shift
+		elif [ $1 = "port" ]; then
+			_port=$2
+			[ ! -z $_port ]; port=" port $_port"
+			shift
+		fi
+
+		shift
+	done
+
+	if [ -z "$id" ]; then
+		echo "[skip] bad test - missing endpoint id"
+		return
+	fi
+
+	if [ $ip_mptcp -eq 1 ]; then
+		line=$(ip -n $ns mptcp endpoint show $id)
+		# the dump order is: address id flags port dev
+		expected_line="$addr"
+		[ -n "$addr" ] && expected_line="$expected_line $addr"
+		expected_line="$expected_line $id"
+		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
+		[ -n "$dev" ] && expected_line="$expected_line $dev"
+		[ -n "$port" ] && expected_line="$expected_line $port"
+	else
+		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
+		# the dump order is: id flags dev address port
+		expected_line="$id"
+		[ -n "$flags" ] && expected_line="$expected_line $flags"
+		[ -n "$dev" ] && expected_line="$expected_line $dev"
+		[ -n "$addr" ] && expected_line="$expected_line $addr"
+		[ -n "$_port" ] && expected_line="$expected_line $_port"
+	fi
+	if [ "$line" = "$expected_line" ]; then
+		echo "[ ok ]"
+	else
+		echo "[fail] expected '$expected_line' found '$line'"
+		ret=1
+	fi
+}
+
 do_transfer()
 {
 	listener_ns="$1"
@@ -2203,6 +2273,41 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
 
+wait_mpj()
+{
+	local ns="${1}"
+	local old_cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+
+	for i in $(seq 10); do
+		cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+		[ "$cnt" = "${old_cnt}" ] || break
+		sleep 0.1
+	done
+}
+
+implicit_tests()
+{
+	# userspace pm type prevents add_addr
+	reset
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_set_limits $ns2 2 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+
+	wait_mpj $ns1
+	pm_nl_check_endpoint "implicit EP creation" \
+		$ns2 10.0.2.2 id 1 flags implicit
+
+	pm_nl_add_endpoint $ns2 10.0.2.2 id 33
+	pm_nl_check_endpoint "implicit EP ID change is prevented" \
+		$ns2 10.0.2.2 id 1 flags implicit
+
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
+	pm_nl_check_endpoint "implicit EP modification is allowed" \
+		$ns2 10.0.2.2 id 1 flags signal
+	wait
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2221,6 +2326,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	implicit_tests
 }
 
 # [$1: error message]
@@ -2279,7 +2385,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchCSiI' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2335,6 +2441,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
 			;;
 		i)
 			;;
+		I)
+			implicit_tests
+			;;
 		h)
 			usage
 			;;
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 22a5ec1e128e..a75a68ad652e 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -436,6 +436,13 @@ static void print_addr(struct rtattr *attrs, int len)
 					printf(",");
 			}
 
+			if (flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
+				printf("implicit");
+				flags &= ~MPTCP_PM_ADDR_FLAG_IMPLICIT;
+				if (flags)
+					printf(",");
+			}
+
 			/* bump unknown flags, if any */
 			if (flags)
 				printf("0x%x", flags);
-- 
2.34.1

