Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A135202D;
	Mon,  1 Jun 2026 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291526; cv=none; b=HPcc6BknAjUJ2uQbqBe5LOv8NGDfZV0ypEbLbx8Ldj/oVTfVK6/5w6Ib4JzLY7phmpy0Z/lFHHnIhUUjouwke3wovFxYd/HZdJi70frwc40IAK2tzAzZn0SC12Jm6MblhqAuIcGdkCzmBaBxmFwi5R088iNyzRWUT4zGkfcS234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291526; c=relaxed/simple;
	bh=cuNOESNy/WTkiZBwkZbo/pzBIRAdYpOMb4gpizZ/7Nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZHPSdsuagobHXeGQ5w7GLb5gFb3+nfm8RyklyTzxeIBU1D9tazmc944uQABWFzmxgmGE97/ndyVFYpDFqG461vTcnWmxalNL6f4rWQAxfQpJ6qTIxJWNKdqOxzgNp10jP3VNVT8F39PvSaxdw0ugtgkuiwfMrHFSWWS8fT3mzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/xXfN0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/xXfN0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2701F00898;
	Mon,  1 Jun 2026 05:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291525;
	bh=eDfXtKVcaOGNG9KazWljQpgi3UNwtob5VzSegX5vxac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i/xXfN0QZW51P9/jWCzxHO5YYmddHVaYqrvEffQOqlOxgATHdsgWH7Us27xyL/JmG
	 aNC6lLUR6SJuqK3q6qrEonNtc77balLCeT0Keq3ukEZD+stUo+uea66rzK8B3eqJFP
	 /gD706Ed59LHulfavqzI5WbwYZE2fhl23NrdEruQ7svx7x8zZzGrPwtlqIOK2kkGWx
	 EQ39wG2IPrtzMCUbUI3nZV1dfjCU/mC12Heeq1aYo8G9QcnLxkJoKfgqkYMcUitTQe
	 TX9fb3EvDxVUpIEYloKAYbKmScyIQ47Zww76LgUHBFoCjbl92OrZScXygWcQwCNc7P
	 PlnDR+TyqMCew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:17 +1000
Subject: [PATCH net-next 10/11] selftests: mptcp: simult_flow: test name in
 pcap file
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-10-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cuNOESNy/WTkiZBwkZbo/pzBIRAdYpOMb4gpizZ/7Nk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReTpg6jPp6zgPqjh7jz2LID1BFmmDDGNDbQX
 7HR/P8dip+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkwAKCRD2t4JPQmmg
 cx6kEACp3fKt+yFjjYNsEDK37/A+Y4ceJGYxI4zdOll0en6TDbkyD0LHFQsiaf3Rgec9jVvbAUA
 6sVFrbNsbYLFI8srv8ObZTYjkXD/AeYq4sq2vaaQcslx4Q8Cm1gtawvwQfoTUreL1kkz+1AQp5t
 BpGYqrdQ/rwQ/83Q7ukIiqRUYCQKI1E77z1jAyPu3eLZkyk/lrDTVhWfWPazDlqgRlLt84V3dos
 a7JXhTFanbYKhpKfFAxf2SY2iiOQ5bgJ6mv2Yur4A2z3hxPnWYYOEl6hVLSQR9s9y7pEzyxojm5
 6LoXuj4r6hPtLXoHnCcehg0DhBClPauVRwhQA+ZJLd9S0lUNxMdnPs20st70pInB15vrVagbBxX
 L3noSHq2/se1PLL/WJ74UGQPzq1QZcRQnhU3HaMKpbvm6Xz9GsV+5Yy961fcy3+HGI3TyJRoJIe
 BbV2eL3SHwYTgkAurSrM/7OWUOTUKGPXLdbp2oLunGr9idyPsuOzrpBgzgPK6ZmAXU1i1k12sx5
 OHEZjYHf8/SjhCiaxNNeU2CTp6kLEudfmeJHAvUkDoQmauV2yiKKwNG9LikoXl1Ijq/JI71SjY3
 OnUNzsm1QW5PgLrHCDYRj4+AprT4BFe0fIAZ2K6GPyZRHF5moPUxb9zhUfbvvnTPIlUG3hb9dMy
 r9vvzmpSzTYU9lg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To be able to easily find out which pcap was produced by which test, the
selftest name is now added to the pcap file, similar to the other tests.

While at it, print the prefix name to be able to find which capture
files have been produced by which test after several runs. This prefix
was not printed anywhere before.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 7b9aabe10170..d723261bdc62 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -24,6 +24,7 @@ small=""
 sout=""
 cout=""
 capout=""
+capprefix=""
 size=0
 
 usage() {
@@ -70,6 +71,11 @@ setup()
 
 	mptcp_lib_ns_init ns1 ns2 ns3
 
+	if $capture; then
+		capprefix="simult_flows-${ns1:4}"
+		mptcp_lib_pr_info "pcap will have this prefix: ${capprefix}-"
+	fi
+
 	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
 	ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth2 netns "$ns2"
 	ip link add ns2eth3 netns "$ns2" type veth peer name ns3eth1 netns "$ns3"
@@ -136,14 +142,13 @@ do_transfer()
 
 	if $capture; then
 		local capuser
-		local rndh="${ns1:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
 			capuser="-Z $SUDO_USER"
 		fi
 
-		local capfile="${rndh}-${port}"
+		local capfile="${capprefix}-${port}"
 		local capopt="-i any -s 65535 -B 32768 ${capuser}"
 
 		ip netns exec ${ns3}  tcpdump ${capopt} -w "${capfile}-listener.pcap"  >> "${capout}" 2>&1 &

-- 
2.53.0

