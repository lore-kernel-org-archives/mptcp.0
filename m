Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1B1A61A
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 17:59:31 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id n12so6900603eja.11
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54tzzI8jDAZ+ybZrz0ncukn/xaU+MHBf4ofmdbpGsxI=;
        b=0/9L0XoQvairgSYehGtxmRzjBkYvqPYkiZC2OnUZP1mgo0VUpRp30yxjYeYWputOUG
         b3rxG+cVLWyJsjLhcbAAWzTG6N2OfBFR+gzJVJRJ8wlXHLId/ft7hTIdNKPUaRwC1qW3
         FwIFADtQwnWZ68lltesVg9YwT35xLkNnxWp0IPZCYvU0mkwXR8iOF6nXlLETR8Jf5e+d
         yyvpTRFK38XWrmQdNsqApM8DatnX0IxXNDYGgB227jVQCpGL2tTMyWyZibsmzV0wZs0m
         1xYdS3f6ODimxsCSxBZYXerjRTXzZaOmMO8hQdTqlX5w0lCP1A+WyeH6oGIK167q7eMC
         WXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54tzzI8jDAZ+ybZrz0ncukn/xaU+MHBf4ofmdbpGsxI=;
        b=fTKQRtyOIM84rgK4UtTQDbaj3nakw3S7WSMaU+1blELtwz9tO1xvxVhVoKVCSIVJBO
         Qk+KcwuodtUeATFdB8+nmjyLYHy5WklJ/zZRAQgGW19peDuEdCzzlFs4JSsXDIcNeLOM
         2f6RjNUqLPK93ZcPgFtccrKC7mD/VmSUs+5TIeaxkCKQA+muh+U9bcdzIRSWz8nsw1ey
         QdM7uSNG9DojZPnQtzp8k9rxPoeWu3b0lmPzlmvnY7lHj6aHltIIezg1MaK7c0UhizTu
         asvDwb4KA6EiOaFWcySaGVDV0FVk7KwW3ucW41eEHfKgDDRGR1U3fWGuuU+qflu8g5Fy
         rD9w==
X-Gm-Message-State: ACrzQf253E240O69OgKoyc3TyT9WJL3iN/uwU7cVs9FTiV1jCQeXs/q1
	fBzT1MJjeGwNPLOYgLXLswmRmUiyL34CDPoR+j8=
X-Google-Smtp-Source: AMsMyM4Hiy7VeAtZFhb8r5q762MZrRM0EIjCVYtdTl6GUYfxIH9GAJ3Qp2hXJcB1ePP0iWGIsiLzmA==
X-Received: by 2002:a17:906:9f20:b0:78d:946e:f65d with SMTP id fy32-20020a1709069f2000b0078d946ef65dmr3408379ejc.365.1668103169742;
        Thu, 10 Nov 2022 09:59:29 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id c8-20020a056402120800b0045726e8a22bsm100765edw.46.2022.11.10.09.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:59:29 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: declare var as local
Date: Thu, 10 Nov 2022 18:58:57 +0100
Message-Id: <20221110175857.3953994-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221110175857.3953994-1-matthieu.baerts@tessares.net>
References: <20221110175857.3953994-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=RLbtvUsH+3eTe8CBNKDy9fCkrlfjLTA1DDU18ffq/CY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjbTuua/tl4v/y6EzXUvhya74SjcB3KnZRxwktEg56
 ZDY+k+mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY207rgAKCRD2t4JPQmmgc3cREA
 CtdlkYJtT67p9MezLrDTz186xFP8EIEE1TSxXebvJBP0Gw1TmiHaEtMSqpKhn56LeLlY89gh/j8wXV
 3ZLgZ9YpckgEzxyduLITejcdfVE8uObx8Zmr86qhOYqLJc7mdiCpEv6jtlc6MXTlrPek54Sylv5aSc
 /Ovs/rvmth/wNCow3jCw/09R0FlCGGcyFBnXhaxlR3zY5HhuZ2dOurOYVORweXudXNuKL1Dy2Eqrux
 JcAy+wQjqrysm/fxCWTKIxsA7RxnO6fnLW0Gi/CCnyfxjMf55QZvp4sbWsPfM2Q7oQpd/db0soM53h
 7FgxBp06MrNWPNeayuX+2qv7trGqM+GYTvlnEI9qU0PaSwa4l3gyx905ZWaa3cBUUJ0w4YZ5KRdKeP
 v3K1orPpBZHiIR6/buvdgdsFz8shdsu688FIvwgES2caPXDWUKmwGiRbheAjK1jGqjsok8HBGVmw7e
 szNuHBFCd+bLQAUTOkf5qbr79NtoqK54cvfzr4L6pE8QTYUIQEWFhlxEfgLZbw51NhgoUtft2BwJmX
 FZj7mXoi66p0/5O65KHNJUgTF2Pre9usLSUnV7AFZrDCYnNQv6YPipWv8e8x7r5sgG4ih+XPPXZITo
 LTM0Uqa6TI7Z1AVh+2JU0KYGrmjwt/ByiMio15W9VV2vSCYcAabHnQLk408g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Just to avoid classical Bash pitfall where variables are accidentally
overridden by other functions because the proper scope has not been
defined.

That's also what is done in other MPTCP selftests scripts where all non
local variables are defined at the beginning of the script and the
others are defined with the "local" keyword.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 51 +++++++++++--------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f74b237bcb32..1b70c0a304ce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -22,6 +22,7 @@ add_mark_rules()
 	local ns=$1
 	local m=$2
 
+	local t
 	for t in iptables ip6tables; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
@@ -36,6 +37,7 @@ add_mark_rules()
 
 init()
 {
+	local netns
 	for netns in "$ns1" "$ns2" "$ns_sbox";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
@@ -44,6 +46,7 @@ init()
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 
+	local i
 	for i in `seq 1 4`; do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
@@ -73,6 +76,7 @@ init()
 
 cleanup()
 {
+	local netns
 	for netns in "$ns1" "$ns2" "$ns_sbox"; do
 		ip netns del $netns
 	done
@@ -103,15 +107,17 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	tables=iptables
+	local tables=iptables
 
 	if [ $af -eq 6 ];then
 		tables=ip6tables
 	fi
 
+	local counters values
 	counters=$(ip netns exec $ns $tables -v -L OUTPUT | grep DROP)
 	values=${counters%DROP*}
 
+	local v
 	for v in $values; do
 		if [ $v -ne 0 ]; then
 			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
@@ -131,9 +137,9 @@ print_file_err()
 
 check_transfer()
 {
-	in=$1
-	out=$2
-	what=$3
+	local in=$1
+	local out=$2
+	local what=$3
 
 	cmp "$in" "$out" > /dev/null 2>&1
 	if [ $? -ne 0 ] ;then
@@ -156,18 +162,18 @@ is_v6()
 
 do_transfer()
 {
-	listener_ns="$1"
-	connector_ns="$2"
-	cl_proto="$3"
-	srv_proto="$4"
-	connect_addr="$5"
+	local listener_ns="$1"
+	local connector_ns="$2"
+	local cl_proto="$3"
+	local srv_proto="$4"
+	local connect_addr="$5"
 
-	port=12001
+	local port=12001
 
 	:> "$cout"
 	:> "$sout"
 
-	mptcp_connect="./mptcp_connect -r 20"
+	local mptcp_connect="./mptcp_connect -r 20"
 
 	local local_addr
 	if is_v6 "${connect_addr}"; then
@@ -180,7 +186,7 @@ do_transfer()
 		ip netns exec ${listener_ns} \
 			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
 				${local_addr} < "$sin" > "$sout" &
-	spid=$!
+	local spid=$!
 
 	sleep 1
 
@@ -189,12 +195,12 @@ do_transfer()
 			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
 				$connect_addr < "$cin" > "$cout" &
 
-	cpid=$!
+	local cpid=$!
 
 	wait $cpid
-	retc=$?
+	local retc=$?
 	wait $spid
-	rets=$?
+	local rets=$?
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
@@ -229,9 +235,9 @@ do_transfer()
 
 make_file()
 {
-	name=$1
-	who=$2
-	size=$3
+	local name=$1
+	local who=$2
+	local size=$3
 
 	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
@@ -264,9 +270,9 @@ do_mptcp_sockopt_tests()
 
 run_tests()
 {
-	listener_ns="$1"
-	connector_ns="$2"
-	connect_addr="$3"
+	local listener_ns="$1"
+	local connector_ns="$2"
+	local connect_addr="$3"
 	local lret=0
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
@@ -282,7 +288,7 @@ run_tests()
 do_tcpinq_test()
 {
 	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
-	lret=$?
+	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
 		echo "FAIL: mptcp_inq $@" 1>&2
@@ -297,6 +303,7 @@ do_tcpinq_tests()
 {
 	local lret=0
 
+	local args
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args
 		lret=$?
-- 
2.37.2

