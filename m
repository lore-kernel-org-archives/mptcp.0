Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BED33984B;
	Tue, 17 Feb 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331315; cv=none; b=EK/cs/L4A6TQw+ER7oUzag+sgGmko0R0juHgDyPW1hFdJKNLD0XyIF66/z7PoELGtMaDi0+0GJyz14pDtjU4KUtnfZFUq/UN5KWCNGkGJFyBUbW0QE9hu/L7AdzidHsa/XdbXsQKOwZazOWzFxTT1/oR4mY1zqbtMEJgImjqJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331315; c=relaxed/simple;
	bh=3zGMGM87LIHWus1BJ2CpeE36rEW5mA6DLWlZhpOZ/rE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=iFp6NTkKfbGujxd2TI6kGoZHQjf0Mix84iB/DnD/Ood4TOJZBD6ML74JFxBVOh0NxSsBMcU8OvZ/V3VepXlr2xRRdOl6GQBy8aoy7E0u8y7bFN8u3z833EORzliBwagSRUg2L32vsICU6sUbfEVD6SUfK6Oil2evyEe3kH3E3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=prCW5HpI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="prCW5HpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC64C4CEF7;
	Tue, 17 Feb 2026 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771331315;
	bh=3zGMGM87LIHWus1BJ2CpeE36rEW5mA6DLWlZhpOZ/rE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=prCW5HpIH4PgNSnzhxp8LC+Qxl/FSfHKic1Xt7BIuQ273y13Bv3bSbkTlTWS83Ylz
	 CCF6Fc/GlFi/ZR9BkqOWauz/eY2R+FOtPNBgLkF/nH4V9bZ+v7sPx6SX6Kmpcc9zx6
	 UMwv249xCzK7IAxtVuvwEXGdBt/rL5WfaoWrizHU=
Subject: Patch "selftests: mptcp: check subflow errors in close events" has been added to the 6.1-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:28:21 +0100
In-Reply-To: <20260211190617.77192-13-matttbe@kernel.org>
Message-ID: <2026021721-panda-both-7a00@gregkh>
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

    selftests: mptcp: check subflow errors in close events

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-check-subflow-errors-in-close-events.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-215872-greg=kroah.com@vger.kernel.org Wed Feb 11 20:07:07 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 11 Feb 2026 20:06:23 +0100
Subject: selftests: mptcp: check subflow errors in close events
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260211190617.77192-13-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 2ef9e3a3845d0a20b62b01f5b731debd0364688d upstream.

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
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260127-net-mptcp-dup-nl-events-v1-4-7f71e1bc4feb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because in this version, commit
  20ccc7c5f7a3 ("selftests: mptcp: join: validate event numbers") has
  been backported with adaptations to display results correctly, see
  commit 5dc9170eee96 ("selftests: mptcp: join: validate event numbers")
  for more details. The same type of adaptations had to be made here as
  well. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3212,21 +3212,28 @@ userspace_pm_add_sf()
 	sleep 1
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
 
-	printf "%-${nr_blank}s %s" " " "event ${ns} ${evt_name} (${exp})"
+	printf "%-${nr_blank}s %s" " " "event ${ns} ${evt_name} (${exp}${attr_name})"
 
 	count=$(grep -cw "type:${evt}" "${evts}")
 	if [ "${count}" != "${exp}" ]; then
@@ -3234,6 +3241,18 @@ chk_evt_nr()
 		fail_test
 		dump_stats
 		cat "${evts}"
+		return
+	elif [ -z "${attr}" ]; then
+		echo "[ ok ]"
+		return
+	fi
+
+	count=$(grep -w "type:${evt}" "${evts}" | grep -c ",${attr}:")
+	if [ "${count}" != "${attr_exp}" ]; then
+		echo "[fail] got ${count} event attributes, expected ${attr_exp}"
+		fail_test
+		dump_stats
+		grep -w "type:${evt}" "${evts}"
 	else
 		echo "[ ok ]"
 	fi
@@ -3375,7 +3394,7 @@ userspace_tests()
 			chk_subflow_nr "" "after reject" 1
 			userspace_pm_add_sf $ns2 10.0.1.2 0
 			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
-			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2
 		fi
 		kill_wait "${tests_pid}"
 		kill_events_pids


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-join-fix-local-endp-not-being-tracked.patch
queue-6.1/mptcp-schedule-rtx-timer-only-after-pushing-data.patch
queue-6.1/mptcp-ensure-context-reset-on-disconnect.patch
queue-6.1/selftests-mptcp-pm-ensure-unknown-flags-are-ignored.patch
queue-6.1/selftests-mptcp-check-no-dup-close-events-after-error.patch
queue-6.1/selftests-mptcp-check-subflow-errors-in-close-events.patch
