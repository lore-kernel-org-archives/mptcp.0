Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D02339B39;
	Tue, 17 Feb 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331325; cv=none; b=qJBtvd2uH24nzRchyRdmiPWj7e5wNUNW8DY2yW4etnCPg8BbDDHSn7/UajEqaN8GP+iQyeMfn/aEv5SoT+ibwuMbz4ELlkMw2o9ocMGBuQEQDB0bp7V9Vj+qanoK7ZCFMdnBs9tn8i5Cq+JElQhoSNEEJu6MoZfZkbd8WCtwrEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331325; c=relaxed/simple;
	bh=nP6Jnfpz5OXJnJE+oFsrEjnyDIvKY/istSs37fDo2Ms=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=oYL0zFnHi8i/KSFX8PYF5LitfBB5X4kupnUO9ci9gYujgPn5Zz5lTeqW6utV8SraS7jJz77yRToiAkJEVDR2eCrM61PmcJI0MdBg5juXmoaECKwEcwcb+pNrJ4BPkPTObX09XfuOaxogpllhUJfb3YRJGx66SWgqJ0mTpw8bqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=np2X3L54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="np2X3L54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7DDC4CEF7;
	Tue, 17 Feb 2026 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771331325;
	bh=nP6Jnfpz5OXJnJE+oFsrEjnyDIvKY/istSs37fDo2Ms=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=np2X3L54X2tQ85XHkONXmb177hrC0UKh8F+47dS45ZbzQLwR1GtDmBBxchUzCWu4B
	 Hw5QtzmfWS78aCe+R4ICrJ/xga4jbZz4JRhCUa8es9bolpgFazktys0p9tauSf2u28
	 DO5ZUhiCiPmZAJCQOtDSytPFK6vB1BWY8VH2t5qo=
Subject: Patch "selftests: mptcp: pm: ensure unknown flags are ignored" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:28:23 +0100
In-Reply-To: <20260211190617.77192-9-matttbe@kernel.org>
Message-ID: <2026021722-depravity-whacking-38b5@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-pm-ensure-unknown-flags-are-ignored.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Wed Feb 11 20:06:54 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 11 Feb 2026 20:06:19 +0100
Subject: selftests: mptcp: pm: ensure unknown flags are ignored
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260211190617.77192-9-matttbe@kernel.org>

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
  context which is not related to the modification here. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |    4 ++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   11 +++++++++++
 2 files changed, 15 insertions(+)

--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -124,6 +124,10 @@ id 8 flags signal 10.0.1.8" "id limit"
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags unknown
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1" "ignore unknown flags"
+ip netns exec $ns1 ./pm_nl_ctl flush
+
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -29,6 +29,8 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+#define MPTCP_PM_ADDR_FLAG_UNKNOWN _BITUL(7)
+
 static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
@@ -814,6 +816,8 @@ int add_addr(int fd, int pm_family, int
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
 				else if (!strcmp(tok, "fullmesh"))
 					flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (!strcmp(tok, "unknown"))
+					flags |= MPTCP_PM_ADDR_FLAG_UNKNOWN;
 				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
@@ -1018,6 +1022,13 @@ static void print_addr(struct rtattr *at
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

queue-6.1/selftests-mptcp-join-fix-local-endp-not-being-tracked.patch
queue-6.1/mptcp-schedule-rtx-timer-only-after-pushing-data.patch
queue-6.1/mptcp-ensure-context-reset-on-disconnect.patch
queue-6.1/selftests-mptcp-pm-ensure-unknown-flags-are-ignored.patch
queue-6.1/selftests-mptcp-check-no-dup-close-events-after-error.patch
queue-6.1/selftests-mptcp-check-subflow-errors-in-close-events.patch
