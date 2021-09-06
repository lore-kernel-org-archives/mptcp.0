Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DCB3FC1
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630922924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B/kzotHoFNWuvoZ03Sg8OG34D9s6fpEr+W0D+/i+HWI=;
	b=U1H+XufVE91k0ycrf0snitnojfNUbrqVy0PYhcJWIDrTKnClQ67YBleoiZT/yHBBevmNwQ
	1fwk74k3bect0wSBqQIbvP45yBQSHse/EVYPHBqT32gLx7AL45echOb8zrupsBiu+6m1nX
	ndiXwEq8H1LCWZSuV6I6ajfmSX9PWYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-Jilz5YVVMiukqAK55DciQg-1; Mon, 06 Sep 2021 06:08:41 -0400
X-MC-Unique: Jilz5YVVMiukqAK55DciQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EA03100A254;
	Mon,  6 Sep 2021 10:08:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2332660861;
	Mon,  6 Sep 2021 10:08:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [RFC PATCH] selftests: mptcp: tune timeout and delay for simult_flows cases
Date: Mon,  6 Sep 2021 12:08:34 +0200
Message-Id: <126a63a07de5709e2702abb5f431f9128146c60a.1630922799.git.pabeni@redhat.com>
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

We currently have some instabilities in the simult_flows tests-case.
The problem boils down to the unneeded large wait introduced by the
tests to allow for the MPJ handshake to complete, which can also
introduce a quite relevant variance.

Do wait on a single side of the connection, remove the delay at
shutdown time and tune the expected test time with the above.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/137
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Side note: the change in mptcp_connect.c may impact negativelly the
mp_join self-tests. In my local experiments they are still working
reliably, but it would be good have some spins in the slow CI/debug
env for more consistency
---
 .../selftests/net/mptcp/mptcp_connect.c       |  1 -
 .../selftests/net/mptcp/simult_flows.sh       | 21 +++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 89c4753c2760..8070e090688d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1010,7 +1010,6 @@ static void parse_opts(int argc, char **argv)
 		case 'j':
 			cfg_join = true;
 			cfg_mode = CFG_MODE_POLL;
-			cfg_wait = 400000;
 			break;
 		case 'r':
 			cfg_remove = true;
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 910d8126af8f..8af49014a604 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -51,7 +51,7 @@ setup()
 	sout=$(mktemp)
 	cout=$(mktemp)
 	capout=$(mktemp)
-	size=$((2048 * 4096))
+	size=$((2048 * 4096 * 4))
 	dd if=/dev/zero of=$small bs=4096 count=20 >/dev/null 2>&1
 	dd if=/dev/zero of=$large bs=4096 count=$((size / 4096)) >/dev/null 2>&1
 
@@ -128,7 +128,11 @@ do_transfer()
 	local cin=$1
 	local sin=$2
 	local max_time=$3
+	local reverse=$4
 	local port
+	local srv_args="-j"
+	local cl_args=""
+
 	port=$((10000+$test_cnt))
 	test_cnt=$((test_cnt+1))
 
@@ -159,9 +163,14 @@ do_transfer()
 		sleep 1
 	fi
 
+	if [ "$reverse" = true ]; then
+		srv_args=""
+		cl_args="-j"
+	fi
+
 	timeout ${timeout_test} \
 		ip netns exec ${ns3} \
-			./mptcp_connect -jt ${timeout_poll} -l -p $port \
+			./mptcp_connect $srv_args -t ${timeout_poll} -l -p $port \
 				0.0.0.0 < "$sin" > "$sout" &
 	local spid=$!
 
@@ -171,7 +180,7 @@ do_transfer()
 	start=$(date +%s%3N)
 	timeout ${timeout_test} \
 		ip netns exec ${ns1} \
-			./mptcp_connect -jt ${timeout_poll} -p $port \
+			./mptcp_connect $cl_args -t ${timeout_poll} -p $port \
 				10.0.3.3 < "$cin" > "$cout" &
 	local cpid=$!
 
@@ -244,12 +253,12 @@ run_test()
 	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1
 	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2
 
-	# time is measure in ms
-	local time=$((size * 8 * 1000 / (( $rate1 + $rate2) * 1024 *1024) ))
+	# time is measure in ms, account for headers overhead, with DSS+ACK64 presence
+	local time=$((size * 8 * 1000 * 1514 / (( $rate1 + $rate2) * 1024 * 1024 * 1424) ))
 
 	# mptcp_connect will do some sleeps to allow the mp_join handshake
 	# completion
-	time=$((time + 1350))
+	time=$((time + 350))
 
 	printf "%-50s" "$msg"
 	do_transfer $small $large $((time * 11 / 10))
-- 
2.26.3

