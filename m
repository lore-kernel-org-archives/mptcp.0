Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1A22DA02;
	Fri, 22 Aug 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870325; cv=none; b=KQptLla2ze1H1LnKbFmgt1wpHi/OsmoGTi9a36sU4NSIkNHcbei6ijU5yDq84S9Tc0Bpp4Bk+Z4p4/+azVIOMGSXFrv0vt0448IaiYjRzCMCvJu1LrrEORxlb0vlrdV6FDtP041rWHGumtcMwniqKcsjHM245G9Ez6+WIk7XlbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870325; c=relaxed/simple;
	bh=xPoSbJmIIED60u4usz3FpvuUtHKLs8JXXnV8liZr0so=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ERrFZSaS8QOckMD8obrV2xdt6r4GlinZMprGstecNqZ/tQ/niFOeUFg8JU010ZVITSa9lSITB5uNHMJ3qfksvpEqwOncdHJbKnmnYht6BgruJh+2yw2Kr88TJKUQE9Dvz+KQam3VmxPllzzf/SPXYqB8Tgj0jKB9+6QJamb21FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gAc/ueKw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gAc/ueKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483EBC4CEED;
	Fri, 22 Aug 2025 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870324;
	bh=xPoSbJmIIED60u4usz3FpvuUtHKLs8JXXnV8liZr0so=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=gAc/ueKwHOTZIm4hBp1LlUZtEsgqdJg8eXSBpH2BKK9OeLaItk7BIWBY9sPnPYI2P
	 gV8ocuY7uqMmA37f8FEildDTUHVRXQOE0Yu/bnILzKdB277RQYwEUnyBpjehQem/be
	 QY5ATQ/XG2JgjL5b8KDW1Ab4wDxaIj00OQD0RJnI=
Subject: Patch "mptcp: drop unused sk in mptcp_push_release" has been added to the 5.15-stable tree
To: geliang.tang@suse.com,gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matthieu.baerts@tessares.net,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:44:34 +0200
In-Reply-To: <20250731112353.2638719-13-matttbe@kernel.org>
Message-ID: <2025082233-undead-proofing-1165@gregkh>
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

    mptcp: drop unused sk in mptcp_push_release

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-drop-unused-sk-in-mptcp_push_release.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-165650-greg=kroah.com@vger.kernel.org Thu Jul 31 13:24:29 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 31 Jul 2025 13:23:59 +0200
Subject: mptcp: drop unused sk in mptcp_push_release
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>, sashal@kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20250731112353.2638719-13-matttbe@kernel.org>

From: Geliang Tang <geliang.tang@suse.com>

commit b8e0def397d7753206b1290e32f73b299a59984c upstream.

Since mptcp_set_timeout() had removed from mptcp_push_release() in
commit 33d41c9cd74c5 ("mptcp: more accurate timeout"), the argument
sk in mptcp_push_release() became useless. Let's drop it.

Fixes: 33d41c9cd74c5 ("mptcp: more accurate timeout")
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c886d70286bf ("mptcp: do not queue data on closed subflows")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1568,8 +1568,7 @@ static struct sock *mptcp_subflow_get_se
 	return NULL;
 }
 
-static void mptcp_push_release(struct sock *sk, struct sock *ssk,
-			       struct mptcp_sendmsg_info *info)
+static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
 	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
 	release_sock(ssk);
@@ -1626,7 +1625,7 @@ void __mptcp_push_pending(struct sock *s
 			 * the last round, release prev_ssk
 			 */
 			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(sk, prev_ssk, &info);
+				mptcp_push_release(prev_ssk, &info);
 			if (!ssk)
 				goto out;
 
@@ -1639,7 +1638,7 @@ void __mptcp_push_pending(struct sock *s
 
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0) {
-				mptcp_push_release(sk, ssk, &info);
+				mptcp_push_release(ssk, &info);
 				goto out;
 			}
 
@@ -1654,7 +1653,7 @@ void __mptcp_push_pending(struct sock *s
 
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
-		mptcp_push_release(sk, ssk, &info);
+		mptcp_push_release(ssk, &info);
 
 out:
 	/* ensure the rtx timer is running */


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-drop-unused-sk-in-mptcp_push_release.patch
queue-5.15/selftests-mptcp-connect-also-cover-alt-modes.patch
queue-5.15/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-5.15/selftests-mptcp-connect-also-cover-checksum.patch
queue-5.15/selftests-mptcp-make-sendfile-selftest-work.patch
queue-5.15/selftests-mptcp-initialize-variables-to-quiet-gcc-12-warnings.patch
queue-5.15/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-5.15/mptcp-do-not-queue-data-on-closed-subflows.patch
queue-5.15/selftests-mptcp-add-missing-join-check.patch
queue-5.15/mptcp-fix-error-mibs-accounting.patch
queue-5.15/mptcp-introduce-mapping_bad_csum.patch
