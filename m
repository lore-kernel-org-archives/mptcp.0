Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12D2F28
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644487445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9f9jsMD8ULk+6P2EooVon1q0L1RSMVamVbkPiQDRRes=;
	b=c4aBSlwOZ6FGyM1RwSTSMkqDec8e1dmF2vVtcNJvUYrt/E3sj1/2Ljhp3KIblMZCHDSRSG
	m2EkSTn2QNsqcWc7gp549Q72bAhuCO+HbVDSDagQjpwWsh3pLZl089IrsSSt7O9I6A4Dvb
	9AqDib7w3i+1TuEdgDwPflkI0WlUVZ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-92eLg3VGPPCbBgb24lXlvQ-1; Thu, 10 Feb 2022 05:04:04 -0500
X-MC-Unique: 92eLg3VGPPCbBgb24lXlvQ-1
Received: by mail-wr1-f71.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so2264004wrg.19
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 02:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9f9jsMD8ULk+6P2EooVon1q0L1RSMVamVbkPiQDRRes=;
        b=FJYyut4/SWuDNTny0U5mVMZWcZ5OlOQSopVMXA7DOy66XhU8zT1caK9BGemyyIB8Mc
         TGNRgdDVm8chY1ebqWnn8ZbzLZcTL4UFL9zGS9yTZO6NEObjbqp+XodHvRF9i/c3Thxm
         uXhTKMyTONPxPVkPtxXhZBwKi75SjBNtI+Jat3kSfsn7ezMRNIox3Quw+VOekiMa3Nd3
         bbwu33eNLN0loSRpk8tGCYfGjLuia0m2ShrJVFi2lX2DW8h7elOm/YPdJJHgBHiVmTHi
         Ec/TQgoojV08Jqm+2Vac71pzrl/2fMqaDF0Ujsnob1GYF1JByWPoGynGaKhCGI3UIiwW
         D33w==
X-Gm-Message-State: AOAM530GIPB1g1FuWrwa0tUR38U4TKYRLLH/HRSWODDR7B7L138vhuP/
	yInQHInLLQ+2CPzjxu324tMdroLtvQH3oTfSpQH0JO5uHWNaF6KMpoByky3fikUpnC9V56aLnoT
	d+/ssLu4q4qmi0zc=
X-Received: by 2002:a1c:a406:: with SMTP id n6mr1499647wme.113.1644487443160;
        Thu, 10 Feb 2022 02:04:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwE+/ed0g26PudGaWkJDY6D1Arbm7E1iHkV+LOrIuJCb5Dyrf5+3ACXq4yWdQ+yHNgUN57ng==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr1499632wme.113.1644487442872;
        Thu, 10 Feb 2022 02:04:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id l26sm990200wmp.31.2022.02.10.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:04:02 -0800 (PST)
Message-ID: <066bb7a33e8f2128968c4aec5ba57c38b2f2c4cd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/9] selftests: mptcp: join: option to
 execute specific tests
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Thu, 10 Feb 2022 11:04:01 +0100
In-Reply-To: <199e2a26-da9-e79f-53c-50498fda97c@linux.intel.com>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
	 <20220209212520.2989291-4-matthieu.baerts@tessares.net>
	 <199e2a26-da9-e79f-53c-50498fda97c@linux.intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2022-02-09 at 16:36 -0800, Mat Martineau wrote:
> On Wed, 9 Feb 2022, Matthieu Baerts wrote:
> 
> > Often, it is needed to run one specific test.
> > 
> > There are options to run subgroups of tests but when only one fails, no
> > need to run all the subgroup. So far, the solution was to edit the
> > script to comment the tests that are not needed but that's not ideal.
> > 
> > Now, it is possible to run one specific test by giving the ID of the
> > tests that are going to be validated, e.g.
> > 
> >  ./mptcp_join.sh 36 37
> > 
> > This is cleaner and saves time.
> > 
> > Technically, the reset* functions now return 0 if the test can be
> > executed. This naturally creates sections per test in the code which is
> > also helpful to understand what a test is exactly doing.
> > 
> 
> My sense is that this is primarily for development purposes since the test 
> numbers may shift as tests are added or modified. Is it worth the churn 
> when we have the subgroup functionality and could comment out chunks of 
> the test script that are not useful for running specific tests in a loop?
> 
> I'm not set against this change, but hoping to discuss it some more to 
> both understand the benefits (I assume for running CI in a loop?) and to 
> see if anyone has bright ideas for avoiding the whitespace churn.
> 
> ("Include a bash fork in our selftest code that implements 'goto'" seems 
> like overkill :) )

Perhapas something alike the following ?!? Not a complete solution:
- completely not tested
- we will first need to add some wrapper for iptables or even beffer
for ip netns exec, to be more generic
- possibly more 'skip_test && return' needed, but not many, I guess.

I hope should be enough demonstrate the idea...
---
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 29623d7ad415..4199d7404f10 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -113,6 +113,7 @@ reset()
 
 reset_with_cookies()
 {
+	skip_test && return
 	reset
 
 	for netns in "$ns1" "$ns2";do
@@ -125,6 +126,7 @@ reset_with_add_addr_timeout()
 	local ip="${1:-4}"
 	local tables
 
+	skip_test && return
 	tables="iptables"
 	if [ $ip -eq 6 ]; then
 		tables="ip6tables"
@@ -145,6 +147,7 @@ reset_with_checksum()
 	local ns1_enable=$1
 	local ns2_enable=$2
 
+	skip_test && return
 	reset
 
 	ip netns exec $ns1 sysctl -q
net.mptcp.checksum_enabled=$ns1_enable
@@ -156,6 +159,7 @@ reset_with_allow_join_id0()
 	local ns1_enable=$1
 	local ns2_enable=$2
 
+	skip_test && return
 	reset
 
 	ip netns exec $ns1 sysctl -q
net.mptcp.allow_join_initial_addr_port=$ns1_enable
@@ -295,6 +299,7 @@ pm_nl_set_limits()
 	local addrs=$2
 	local subflows=$3
 
+	skip_test && return
 	if [ $ip_mptcp -eq 1 ]; then
 		ip -n $ns mptcp limits set add_addr_accepted $addrs
subflows $subflows
 	else
@@ -312,6 +317,7 @@ pm_nl_add_endpoint()
 	local id
 	local nr=2
 
+	skip_test && return
 	for p in $@
 	do
 		if [ $p = "flags" ]; then
@@ -689,6 +695,7 @@ run_tests()
 	lret=0
 	oldin=""
 
+	skip_test && return
 	# create the input file for the failure test when
 	# the first failure test run
 	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
@@ -732,6 +739,7 @@ chk_csum_nr()
 	local count
 	local dump_stats
 
+	skip_test && return
 	if [ ! -z "$msg" ]; then
 		printf "%02u" "$TEST_COUNT"
 	else
@@ -767,6 +775,7 @@ chk_fail_nr()
 	local count
 	local dump_stats
 
+	skip_test && return
 	printf "%-39s %s" " " "ftx"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx |
awk '{print $2}'`
 	[ -z "$count" ] && count=0
@@ -801,6 +810,7 @@ chk_join_nr()
 	local count
 	local dump_stats
 
+	skip_test && return
 	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx
| awk '{print $2}'`
 	[ -z "$count" ] && count=0
@@ -855,6 +865,7 @@ chk_stale_nr()
 	local stale_nr
 	local recover_nr
 
+	skip_test && return
 	printf "%-39s %-18s" " " "stale"
 	stale_nr=`ip netns exec $ns nstat -as | grep
MPTcpExtSubflowStale | awk '{print $2}'`
 	[ -z "$stale_nr" ] && stale_nr=0
@@ -893,6 +904,7 @@ chk_add_nr()
 	local count
 	local dump_stats
 
+	skip_test && return
 	printf "%-39s %s" " " "add"
 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr |
awk '{print $2}'`
 	[ -z "$count" ] && count=0
@@ -1008,6 +1020,7 @@ chk_rm_nr()
 	local addr_ns
 	local subflow_ns
 
+	skip_test && return
 	if [ -z $invert ]; then
 		addr_ns=$ns1
 		subflow_ns=$ns2
@@ -1048,6 +1061,7 @@ chk_prio_nr()
 	local count
 	local dump_stats
 
+	skip_test && return
 	printf "%-39s %s" " " "ptx"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx |
awk '{print $2}'`
 	[ -z "$count" ] && count=0
@@ -1084,6 +1098,7 @@ chk_link_usage()
 	local tx_rate=$((tx_link * 100 / $tx_total))
 	local tolerance=5
 
+	skip_test && return
 	printf "%-39s %-18s" " " "link usage"
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then

