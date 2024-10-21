Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1141C36;
	Mon, 21 Oct 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500416; cv=none; b=C8Md3DpEAlWRF1cJPBQm7NiObFhJ8dB3nuMoAQmuu/J2UD5xLWVKTH8p8Glvd1RAKC+X65iYPldKo4WDXtZ0ClALGQPInjxWTJplzb+2Q8JEf4p5IMb3nf7Sz5gj+NDHqU1NwcRmz8rEdfxxiohioI/HJhfGmfYv4JmU41uOqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500416; c=relaxed/simple;
	bh=LLtZqZgLvFwPrfacOYvo6bFCPOOUSSeprBBzkbmCW1w=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=M6yMV/kYEPOA9XNm3f0PCGuxPV3uVxW8BEh6gZ/BOifyAkeeOfV7vKEGf2Ff3wJcLaK00SsGg8OcJG6pff/dsHY/7117/DWsHmPSazUV7a1aMQ0oBKIn6kmgMvH447ATpxxe1TsshaQIh6LDNaLmqXPLY3eGF3cRZ2yHvyJ4NxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2gxDwVul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2gxDwVul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EA9C4CEC3;
	Mon, 21 Oct 2024 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729500416;
	bh=LLtZqZgLvFwPrfacOYvo6bFCPOOUSSeprBBzkbmCW1w=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=2gxDwVuld+fQCgkHYF5bWWD11DNKvKPVF0gF/gPO+z5U7lKzbWR+upq1FJdRk5+hi
	 gNyCqRnENbVwFvsmIWdkrN+Gke4msqqH0ww4voJFmp+fuoc4mO6u/ziRGvTycpzUMZ
	 q9YnNQ7vUURARq7q2fNQE6lEBqsFsMFBFhnHSybY=
Subject: Patch "selftests: mptcp: join: change capture/checksum as bool" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 10:46:53 +0200
In-Reply-To: <20241018155734.2548697-8-matttbe@kernel.org>
Message-ID: <2024102152-pacify-rabid-e661@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    selftests: mptcp: join: change capture/checksum as bool

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-change-capture-checksum-as-bool.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-86858-greg=kroah.com@vger.kernel.org Fri Oct 18 17:57:56 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 18 Oct 2024 17:57:37 +0200
Subject: selftests: mptcp: join: change capture/checksum as bool
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241018155734.2548697-8-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 8c6f6b4bb53a904f922dfb90d566391d3feee32c upstream.

To maintain consistency with other scripts, this patch changes vars
'capture' and 'checksum' as bool vars in mptcp_join.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240223-upstream-net-next-20240223-misc-improvements-v1-7-b6c8a10396bd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 5afca7e996c4 ("selftests: mptcp: join: test for prohibited MPC to port-based endp")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -30,11 +30,11 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=0
-checksum=0
+capture=false
+checksum=false
 ip_mptcp=0
 check_invert=0
-validate_checksum=0
+validate_checksum=false
 init=0
 evts_ns1=""
 evts_ns2=""
@@ -99,7 +99,7 @@ init_partial()
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
-		if [ $checksum -eq 1 ]; then
+		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
 	done
@@ -386,7 +386,7 @@ reset_with_checksum()
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 
-	validate_checksum=1
+	validate_checksum=true
 }
 
 reset_with_allow_join_id0()
@@ -419,7 +419,7 @@ reset_with_allow_join_id0()
 setup_fail_rules()
 {
 	check_invert=1
-	validate_checksum=1
+	validate_checksum=true
 	local i="$1"
 	local ip="${2:-4}"
 	local tables
@@ -1024,7 +1024,7 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
@@ -1125,7 +1125,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    sleep 1
 	    kill $cappid
 	fi
@@ -1514,7 +1514,7 @@ chk_join_nr()
 	else
 		print_ok
 	fi
-	if [ $validate_checksum -eq 1 ]; then
+	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -3960,10 +3960,10 @@ while getopts "${all_tests_args}cCih" op
 			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
-			capture=1
+			capture=true
 			;;
 		C)
-			checksum=1
+			checksum=true
 			;;
 		i)
 			ip_mptcp=1


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/selftests-mptcp-join-change-capture-checksum-as-bool.patch
queue-6.6/selftests-mptcp-join-test-for-prohibited-mpc-to-port-based-endp.patch
queue-6.6/tcp-fix-mptcp-dss-corruption-due-to-large-pmtu-xmit.patch
queue-6.6/mptcp-pm-fix-uaf-read-in-mptcp_pm_nl_rm_addr_or_subflow.patch
queue-6.6/selftests-mptcp-remove-duplicated-variables.patch
queue-6.6/mptcp-prevent-mpc-handshake-on-port-based-signal-endpoints.patch
