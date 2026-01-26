Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007727877D
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455492; cv=none; b=Au58XkgW+mzSI2cMH68QzYz3EK1reSWd0G3oKNnAmmZQqymyGFnnX+JUy14yctMYayA0n2RCuwg8L6wFKx1AXWLx6h9eF97w8ieQpI7IAEjYYfUtMWGeMg5+Q095BFG3DbnO+K9+R5rxj4dQx6+T94LnYLsGyF63ygnCuW6tksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455492; c=relaxed/simple;
	bh=s4TBAz8WcWznvgR11XYKwjYSG7NOK0Sxe4EBmgmiAEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0UlbtsRjTJ+CBalsy5jWjm3zMmeUoq8iwGQ//2A/4XugWOpb9gNLd4mi4MV0o1aSHS7bvvHtygSGHGMm0jEHCC6kIzDmbJM6j9Yl13AP9McVywjwPKdJ05evR6QlAp+Izcqzo3iWWSxeosGFqcLLLSZmpgU/1keVfYjUUWNhaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VylWyCan; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VylWyCan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D89C19422;
	Mon, 26 Jan 2026 19:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455492;
	bh=s4TBAz8WcWznvgR11XYKwjYSG7NOK0Sxe4EBmgmiAEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VylWyCanbQnoUk02NrjkpStN/bLYN96RDWed9zztiirhOrF8kRr1v8HPOnKufDKzf
	 SVMA4Z59cZjOoPlFcV4xIpl+A/MaWLJU9aE59nWBjKvkUeYPetra7zgx2Rme7ywoWY
	 kyIe6mkbWOH72w7obovky0R7IAIEp8CN3c0dijSUW5gi+l0+diiWHR6Rsk3vHglTNw
	 tJWPG0vaqaNDKkH98rSlPoXo1uV7g/iRE3knsg4q5FF7dLip/bdKzi1WBRAizVfEuP
	 ugoDNzKApAObKubTQvIiLgSbaluLnRLuuhrsaU7Dc34Od6crgjiUk9+4CtUNpOwHF/
	 eh6EezuoVXg2Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:41 +0100
Subject: [PATCH mptcp-net v2 04/11] selftests: mptcp: check subflow errors
 in close events
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-4-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2684; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=s4TBAz8WcWznvgR11XYKwjYSG7NOK0Sxe4EBmgmiAEY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL91dfebP+wrTibptHFRd+3RZ8dKLh9ENJG5Z7+Uv1/
 3Wcvn7sbEcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEDLYzMhx6ySPSYPx/4UPp
 K8uYthS83nlTZsPhw9cOP7J7dLF9drAiw3/Pyo1rtbasXxl03PP6etGdJ04rLM203BO+cdX/vKw
 NHLF8AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This validates the previous commit: subflow closed events should contain
an error field when a subflow got closed with an error, e.g. reset or
timeout.

For this test, the chk_evt_nr helper has been extended to check
attributes in the matched events.

In this test, the 2 subflow closed events should have an error.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 35ff769f440f..e70d3420954f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3846,21 +3846,28 @@ userspace_pm_chk_get_addr()
 	fi
 }
 
-# $1: ns ; $2: event type ; $3: count
+# $1: ns ; $2: event type ; $3: count ; [ $4: attr ; $5: attr count ]
 chk_evt_nr()
 {
 	local ns=${1}
 	local evt_name="${2}"
 	local exp="${3}"
+	local attr="${4}"
+	local attr_exp="${5}"
 
 	local evts="${evts_ns1}"
 	local evt="${!evt_name}"
+	local attr_name
 	local count
 
+	if [ -n "${attr}" ]; then
+		attr_name=", ${attr}: ${attr_exp}"
+	fi
+
 	evt_name="${evt_name:16}" # without MPTCP_LIB_EVENT_
 	[ "${ns}" == "ns2" ] && evts="${evts_ns2}"
 
-	print_check "event ${ns} ${evt_name} (${exp})"
+	print_check "event ${ns} ${evt_name} (${exp}${attr_name})"
 
 	if [[ "${evt_name}" = "LISTENER_"* ]] &&
 	   ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
@@ -3872,6 +3879,16 @@ chk_evt_nr()
 	if [ "${count}" != "${exp}" ]; then
 		fail_test "got ${count} events, expected ${exp}"
 		cat "${evts}"
+		return
+	elif [ -z "${attr}" ]; then
+		print_ok
+		return
+	fi
+
+	count=$(grep -w "type:${evt}" "${evts}" | grep -c ",${attr}:")
+	if [ "${count}" != "${attr_exp}" ]; then
+		fail_test "got ${count} event attributes, expected ${attr_exp}"
+		grep -w "type:${evt}" "${evts}"
 	else
 		print_ok
 	fi
@@ -4130,7 +4147,7 @@ userspace_tests()
 			chk_subflows_total 1 1
 			userspace_pm_add_sf $ns2 10.0.1.2 0
 			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
-			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2
 		fi
 		kill_events_pids
 		mptcp_lib_kill_group_wait $tests_pid

-- 
2.51.0

