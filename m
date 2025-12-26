Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3D1DFDB8
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731241; cv=none; b=GohLRFdhofQ4g+e+01dSkVxAUtMRptB4eZ6zKfSAYOOGTRfq+saoS+qdEAm3A0w+/0NsAOEQ7dzRpAQFGzk73wIKF2DxGkB+r2Nm/hlSt8+05KZv50z8MgGSW3SCOk/C+lVY3AfEbcGnJ2lssdiFNzmSXsx5NwXxndycaORIcss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731241; c=relaxed/simple;
	bh=7lwBXaaiytSrnOb4A9lX8uKFtCJoHPSb0Y+OFgVYFyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekef1AN7+n+plVYvGi1CSXsWvgxj94a5a57Z9ov/SMSd8LpCbm9UNORxSrtt19V/OKXHDgab5mnpkTzpRvtWZ1fCQ6WNBPkdc0lRrf2rKPaN01K/V9EBKrgwMm/cfjLbZZcRtnC9VQMTtBme9/pDwRphjg31FVNW0bvSiEGOG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/JXNVqw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/JXNVqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8086DC113D0;
	Fri, 26 Dec 2025 06:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731240;
	bh=7lwBXaaiytSrnOb4A9lX8uKFtCJoHPSb0Y+OFgVYFyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V/JXNVqwc49d1qhgTOmO0TLDcz2+y5crTOl2EHOAVnpd6K4J+iuT2DA4OYDInxybl
	 Y4Sh0RgOjD0BScxkd/wNYh6/PNaucC3Q/SPdT38E/o2JXml69YpyWqgUe7mYFdCuvX
	 +C6K3US/6+NEfOVN5lTv+WtLNyeRcWLk4AWyuscTYK1k2EFxL/7mgSrcSWxzzNYmS7
	 5ptoxgJ5SCMA3Jafs3auCZiBSkkkrEZVdZxsecCK045spFp35NFOAQ/0tidgnojRPt
	 lna/vj3hNGFfJgjNZUTxKj1/eRAmAKhbh2Am0tDAVxtAxQ3CE9hKfz1w0RqRM3LKqo
	 7ri7IlVkyuz/A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:18 +0100
Subject: [PATCH mptcp-next 04/11] selftests: mptcp: check subflow errors in
 close events
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-4-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2684; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7lwBXaaiytSrnOb4A9lX8uKFtCJoHPSb0Y+OFgVYFyQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dO9ueeT/eKlsg/iR18JrPh4O3CVkvuS89cZXdZfvF
 0TPa7Aq7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIw2hGhicBH594ZH2Ufzr/
 lk90yY1k67uX5HcfbTuyY3tp18ywaGOG//X/fBR0P6i47bxVrjtF/vzRY519osunpuvmJEqXXqp
 +ygsA
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
index 468ffb97293b..bf0cc59b5210 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3847,21 +3847,28 @@ userspace_pm_chk_get_addr()
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
@@ -3873,6 +3880,16 @@ chk_evt_nr()
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
@@ -4129,7 +4146,7 @@ userspace_tests()
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

