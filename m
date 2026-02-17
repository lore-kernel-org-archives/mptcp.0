Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731B2D641C;
	Tue, 17 Feb 2026 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332342; cv=none; b=a+zaVlFHmx5p2GRW3n8NsbtSGVa/TuzmPoqVWyEJwRIz8fQJlydFwr4kkLGwQCVFFHXZ3e1j4wubf+s+zNgk78dArFjtCal9fdD6GH2u5YgLiID5SbiyMlKWxxM12zhxwt0/WDSgTTXxGiRuzRuhAwbiohYz9TZGvqQscBT6NaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332342; c=relaxed/simple;
	bh=JVupBcZlGPhZ3fF7KmLQ9E3mR/O7Vw4QoKLcGl6sYgI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=OL4kDMII9AdQEuhOCRhtSaj6io1o3ysKb8gqQQ/UjGMSSjaWy0k/Yo7UVwiGkW1Y46mkF00kvz/aF3RgdCqjmEopkK5mxIwjilS86BM8Kd9f76AjORtN1gWxD3s9LDw3fXTxObwc9UdJF8aNk97078ekvBHmofNpp0BSvWf15uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTSF0kjX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTSF0kjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B3CC4CEF7;
	Tue, 17 Feb 2026 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771332342;
	bh=JVupBcZlGPhZ3fF7KmLQ9E3mR/O7Vw4QoKLcGl6sYgI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=JTSF0kjXk3eRfL2Q8YnrsTN7p6tjQx68K8dyogrODhpWXvN3VgO4npl1JdTwwOY+o
	 hFWjYW60ktuVlVNAYdc4Ii9cTfF8/LbSixNhDoQTdPDQ1+yWX9CHpL1TAg30jMQtfD
	 9p7YfuaEyyhmaL8I32ijp7cMpkEgBiYLvw8At/sY=
Subject: Patch "selftests: mptcp: pm: ensure unknown flags are ignored" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:45:20 +0100
In-Reply-To: <20260212115056.898313-2-matttbe@kernel.org>
Message-ID: <2026021719-heroism-encrust-8c7b@gregkh>
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

    selftests: mptcp: pm: ensure unknown flags are ignored

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-pm-ensure-unknown-flags-are-ignored.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-215944-greg=kroah.com@vger.kernel.org Thu Feb 12 12:51:11 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 12 Feb 2026 12:50:57 +0100
Subject: selftests: mptcp: pm: ensure unknown flags are ignored
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260212115056.898313-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 29f4801e9c8dfd12bdcb33b61a6ac479c7162bd7 upstream.

This validates the previous commit: the userspace can set unknown flags
-- the 7th bit is currently unused -- without errors, but only the
supported ones are printed in the endpoints dumps.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251205-net-mptcp-misc-fixes-6-19-rc1-v1-2-9e4781a6c1b8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.sh, because some refactoring have been done
  later on: commit 0d16ed0c2e74 ("selftests: mptcp: add
  {get,format}_endpoint(s) helpers") and commit c99d57d0007a
  ("selftests: mptcp: use pm_nl endpoint ops") are not in this version.
  The same operation can still be done at the same place, without using
  the new helpers.
  Also, commit 1dc88d241f92 ("selftests: mptcp: pm_nl_ctl: always look
  for errors") is not in this version, and create a conflict in the
  context which is not related to the modification here.
  In v5.10, endpoints couldn't be re-used directly, so the flag is
  tested before.
  Conflicts in pm_nl_ctl.c, because commit 69c6ce7b6eca ("selftests:
  mptcp: add implicit endpoint test case") and commit 371b90377e60
  ("selftests: mptcp: set and print the fullmesh flag") are not in this
  version, and caused a conflict in the context which is not related to
  the modification here. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |    2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -80,7 +80,7 @@ if mptcp_lib_expect_all_features; then
 subflows 0" "defaults limits"
 fi
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags unknown
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
 check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simple add/get addr"
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -22,6 +22,8 @@
 #define MPTCP_PM_NAME		"mptcp_pm"
 #endif
 
+#define MPTCP_PM_ADDR_FLAG_UNKNOWN _BITUL(7)
+
 static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|get|del|flush|dump|accept [<args>]\n", argv[0]);
@@ -236,6 +238,8 @@ int add_addr(int fd, int pm_family, int
 					flags |= MPTCP_PM_ADDR_FLAG_SIGNAL;
 				else if (!strcmp(tok, "backup"))
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+				else if (!strcmp(tok, "unknown"))
+					flags |= MPTCP_PM_ADDR_FLAG_UNKNOWN;
 				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
@@ -372,6 +376,13 @@ static void print_addr(struct rtattr *at
 				if (flags)
 					printf(",");
 			}
+
+			if (flags & MPTCP_PM_ADDR_FLAG_UNKNOWN) {
+				printf("unknown");
+				flags &= ~MPTCP_PM_ADDR_FLAG_UNKNOWN;
+				if (flags)
+					printf(",");
+			}
 
 			/* bump unknown flags, if any */
 			if (flags)


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/selftests-mptcp-pm-ensure-unknown-flags-are-ignored.patch
