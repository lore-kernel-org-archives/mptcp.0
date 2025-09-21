Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924B19F11E;
	Sun, 21 Sep 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475179; cv=none; b=bfClsN2GYM83ATNc4GJbKiTtg5c1HiezGiyyLOdsPpXg2pFckHtUvhshB1rEhZys+PluVw3Ub4AOpSchqIaTFSrUGBnicz55vd/WSMs9ZsnByu+l8bPtnd84Wa/N3qzl1bzJTNv/LuqThaFGViI1XitIQ0mWPUX6zm+g/FqihC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475179; c=relaxed/simple;
	bh=3Q6Oq5TjC9LaBtdS73aYcu0ty45eBPMlOs8OeRYX/LE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=h49J7Uy3aTqUT4AbcXhk3yAGF0AeKiO0qieELVwAWHUpwrFuEXIH0+CGflL/F8X4T6ijzvRENu7KQ82wUUoK/8goc0ylSwMvvzrEilNf7QkhafxBfrs7swJVBaLLmdtIXeL/MjXOa/FB4irHvGANavfUx6HaAVy2g5fOjll4aB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oV84iJMl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oV84iJMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42682C4CEE7;
	Sun, 21 Sep 2025 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758475178;
	bh=3Q6Oq5TjC9LaBtdS73aYcu0ty45eBPMlOs8OeRYX/LE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=oV84iJMlhNx4AjwhqS7/rn0cUIf/JGLjxT8Q5oYoewZA3NDVHylUkAhPAXr+SeiLZ
	 xwhTqMFLrw0ri7xptrVfTRrZ6p4Kr3Ve2Jn8wzk0GM283S+TiEhqB7hJjPxaPBOp0W
	 rIHUEMSyIj68aS6s3h0iCwoVrp1E0YnRgrGsI/wc=
Subject: Patch "selftests: mptcp: userspace pm: validate deny-join-id0 flag" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 19:19:21 +0200
In-Reply-To: <20250919223819.3679521-6-matttbe@kernel.org>
Message-ID: <2025092121-majestic-moneybags-3d06@gregkh>
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

    selftests: mptcp: userspace pm: validate deny-join-id0 flag

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-userspace-pm-validate-deny-join-id0-flag.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Sat Sep 20 00:38:39 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 20 Sep 2025 00:38:22 +0200
Subject: selftests: mptcp: userspace pm: validate deny-join-id0 flag
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250919223819.3679521-6-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 24733e193a0d68f20d220e86da0362460c9aa812 upstream.

The previous commit adds the MPTCP_PM_EV_FLAG_DENY_JOIN_ID0 flag. Make
sure it is correctly announced by the other peer when it has been
received.

pm_nl_ctl will now display 'deny_join_id0:1' when monitoring the events,
and when this flag was set by the other peer.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250912-net-mptcp-pm-uspace-deny_join_id0-v1-3-40171884ade8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in userspace_pm.sh, because of a difference in the context,
  introduced by commit c66fb480a330 ("selftests: userspace pm: avoid
  relaunching pm events"), which is not in this version. The same lines
  can still be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |    7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh |   14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -194,6 +194,13 @@ static int capture_events(int fd, int ev
 					fprintf(stderr, ",error:%u", *(__u8 *)RTA_DATA(attrs));
 				else if (attrs->rta_type == MPTCP_ATTR_SERVER_SIDE)
 					fprintf(stderr, ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
+				else if (attrs->rta_type == MPTCP_ATTR_FLAGS) {
+					__u16 flags = *(__u16 *)RTA_DATA(attrs);
+
+					/* only print when present, easier */
+					if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
+						fprintf(stderr, ",deny_join_id0:1");
+				}
 
 				attrs = RTA_NEXT(attrs, msg_len);
 			}
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -196,6 +196,9 @@ make_connection()
 		is_v6="v4"
 	fi
 
+	# set this on the client side only: will not affect the rest
+	ip netns exec "$ns2" sysctl -q net.mptcp.allow_join_initial_addr_port=0
+
 	# Capture netlink events over the two network namespaces running
 	# the MPTCP client and server
 	if [ -z "$client_evts" ]; then
@@ -227,23 +230,28 @@ make_connection()
 	local client_token
 	local client_port
 	local client_serverside
+	local client_nojoin
 	local server_token
 	local server_serverside
+	local server_nojoin
 
 	client_token=$(mptcp_lib_evts_get_info token "$client_evts")
 	client_port=$(mptcp_lib_evts_get_info sport "$client_evts")
 	client_serverside=$(mptcp_lib_evts_get_info server_side "$client_evts")
+	client_nojoin=$(mptcp_lib_evts_get_info deny_join_id0 "$client_evts")
 	server_token=$(mptcp_lib_evts_get_info token "$server_evts")
 	server_serverside=$(mptcp_lib_evts_get_info server_side "$server_evts")
+	server_nojoin=$(mptcp_lib_evts_get_info deny_join_id0 "$server_evts")
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
-	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-		   [ "$server_serverside" = 1 ]
+	if [ "${client_token}" != "" ] && [ "${server_token}" != "" ] &&
+	   [ "${client_serverside}" = 0 ] && [ "${server_serverside}" = 1 ] &&
+	   [ "${client_nojoin:-0}" = 0 ] && [ "${server_nojoin:-0}" = 1 ]
 	then
 		test_pass
 		print_title "Connection info: ${client_addr}:${client_port} -> ${connect_addr}:${app_port}"
 	else
-		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
+		test_fail "Expected tokens (c:${client_token} - s:${server_token}), server (c:${client_serverside} - s:${server_serverside}), nojoin (c:${client_nojoin} - s:${server_nojoin})"
 		mptcp_lib_result_print_all_tap
 		exit 1
 	fi


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-tfo-record-deny-join-id0-info.patch
queue-6.6/mptcp-pm-nl-announce-deny-join-id0-flag.patch
queue-6.6/selftests-mptcp-connect-catch-io-errors-on-listen-side.patch
queue-6.6/selftests-mptcp-avoid-spurious-errors-on-tcp-disconnect.patch
queue-6.6/mptcp-set-remote_deny_join_id0-on-syn-recv.patch
queue-6.6/selftests-mptcp-sockopt-fix-error-messages.patch
queue-6.6/selftests-mptcp-userspace-pm-validate-deny-join-id0-flag.patch
