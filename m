Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99E2BB1D;
	Sun, 21 Sep 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475467; cv=none; b=c4ZhgCGjtDtQuH/3UpT+FLNi2KpH/AHltK9KqM19Kul074v+WymA+Vq+o2bkv6ZuLLUxLooMOv2fHC+uGO7S6KqtHoF6bayDGBMZiwQ8dNnU9YkB7GLmWWp5FJnUJB6HXQfXn59isCEprcQ6J7in6xaMcNeYFv+cqyRPr1yByQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475467; c=relaxed/simple;
	bh=eOr0myjei/2Vq+bk/Zro5WUIWi78eobDdVPHY+AoQsk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=p0nT009nWT7KWxqr0iZZIUn06x1dkFohcrvLWCuGAFq9y+wDQTkQq3TpOH6SfCSst9635sSZ7/QySrU1S7M41bxinYd10CP/+2QfQJekO+0gs9Ddvjrc5PMvmzm0JHaG8my5mrkkZEdL5rT7Zq2YsOuH6Hpxat3qZo6CD1XZRo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZEqQoJb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZEqQoJb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC16C4CEE7;
	Sun, 21 Sep 2025 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758475467;
	bh=eOr0myjei/2Vq+bk/Zro5WUIWi78eobDdVPHY+AoQsk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=ZEqQoJb8DS8O+Kl5qVa20sbzU1a9wmQFVyQW4RnAS9qxeS3er/5IY5L4/jSwt8TcJ
	 MuBzdZWAduApdnHa5cTJX8lXxD3YGirlTydT/if/T/5xhg+Lz8rxWEdzGWeP2mpQol
	 L21ztdy53p2p6ONsarWy6c4asAHFT6fipjsyArDc=
Subject: Patch "selftests: mptcp: userspace pm: validate deny-join-id0 flag" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 19:24:09 +0200
In-Reply-To: <20250919225118.3781035-6-matttbe@kernel.org>
Message-ID: <2025092109-refreeze-debating-5430@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-userspace-pm-validate-deny-join-id0-flag.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-180716-greg=kroah.com@vger.kernel.org Sat Sep 20 00:52:39 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 20 Sep 2025 00:51:21 +0200
Subject: selftests: mptcp: userspace pm: validate deny-join-id0 flag
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250919225118.3781035-6-matttbe@kernel.org>

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
  can still be added at the same place.
  Conflicts in userspace_pm.sh, because of different refactoring, like
  with commit ae1fa39da991 ("selftests: mptcp: add evts_get_info
  helper"), and commit e198ad759273 ("selftests: mptcp: userspace_pm:
  uniform results printing"). The modifications have been adapted to the
  old version, without the new helpers. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |    7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh |   14 ++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -188,6 +188,13 @@ static int capture_events(int fd, int ev
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
@@ -139,6 +139,9 @@ make_connection()
 		is_v6="v4"
 	fi
 
+	# set this on the client side only: will not affect the rest
+	ip netns exec "$ns2" sysctl -q net.mptcp.allow_join_initial_addr_port=0
+
 	# Capture netlink events over the two network namespaces running
 	# the MPTCP client and server
 	local client_evts
@@ -173,21 +176,28 @@ make_connection()
 	local client_token
 	local client_port
 	local client_serverside
+	local client_nojoin
 	local server_token
 	local server_serverside
+	local server_nojoin
 
 	client_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
 	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$client_evts")
+	client_nojoin=$(sed --unbuffered -n 's/.*\(deny_join_id0:\)\([[:digit:]]*\).*$/\2/p;q'\
+				      "$client_evts")
 	kill_wait $server_evts_pid
 	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$server_evts")
+	server_nojoin=$(sed --unbuffered -n 's/.*\(deny_join_id0:\)\([[:digit:]]*\).*$/\2/p;q'\
+				      "$server_evts")
 	rm -f "$client_evts" "$server_evts" "$file"
 
-	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-		   [ "$server_serverside" = 1 ]
+	if [ "${client_token}" != "" ] && [ "${server_token}" != "" ] &&
+	   [ "${client_serverside}" = 0 ] && [ "${server_serverside}" = 1 ] &&
+	   [ "${client_nojoin:-0}" = 0 ] && [ "${server_nojoin:-0}" = 1 ]
 	then
 		stdbuf -o0 -e0 printf "Established IP%s MPTCP Connection ns2 => ns1    \t\t[OK]\n" $is_v6
 	else


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-nl-announce-deny-join-id0-flag.patch
queue-6.1/selftests-mptcp-avoid-spurious-errors-on-tcp-disconnect.patch
queue-6.1/mptcp-set-remote_deny_join_id0-on-syn-recv.patch
queue-6.1/selftests-mptcp-userspace-pm-validate-deny-join-id0-flag.patch
