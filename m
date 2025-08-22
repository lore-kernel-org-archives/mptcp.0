Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13132303C9F;
	Fri, 22 Aug 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870338; cv=none; b=Sd+tJs/d3q7LqqJ7tJ0Lt3PCT3yECK0D4Q9972Q4buCmN4lfxJuxvnw+bzBlnQSm+UCfcGaZj9pDfW5nhe2BhE9HIXihCQysHWIrNzWw1MGshCKp8AIOWE4dm48yJQ2QTx8SNfOrNhVAzT4KUTc1PmXCDqAvhP6nFk6I2Vu3kMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870338; c=relaxed/simple;
	bh=9ybqVg4oxEq397ZY1b4uJbXRBRd4RadRwVVh+S4Dh5k=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=jbNHClIrSqcXqXbHRkwffVgXIYkaUfoR3EWmx8/CkDXQ/J5okQw2iBudysdrOhFB1cvqPhnDjMNl16H4dMWcJR86OIpBuZDW1CmHh8+VovOY0ATkCkHFNNEBtQk2K62Q7faRIcbzqLedh9wGCvtbTjFS26d7baCIC33HLCnStKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dENqYfkC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dENqYfkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D70EC4CEED;
	Fri, 22 Aug 2025 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870337;
	bh=9ybqVg4oxEq397ZY1b4uJbXRBRd4RadRwVVh+S4Dh5k=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=dENqYfkCBEx9+yqxXZ/ImlzA6Q8pxrht63FCeiLahg40RQbt1O+00EzrbYDb36lmQ
	 F9aAuz4b4kI7yhTyrCN9d7GE/cjyw3hvCP8h2lLg1i9G788n1lTJqymNB1VRPznaAG
	 a1i0SenrDnJsG71vqJ6i5yRyo4BrHj5+rMPQOMgk=
Subject: Patch "selftests: mptcp: make sendfile selftest work" has been added to the 5.15-stable tree
To: davem@davemloft.net,fw@strlen.de,gregkh@linuxfoundation.org,mathew.j.martineau@linux.intel.com,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,xmu@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:44:35 +0200
In-Reply-To: <20250730102806.1405622-6-matttbe@kernel.org>
Message-ID: <2025082235-contempt-unleveled-5b8f@gregkh>
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

    selftests: mptcp: make sendfile selftest work

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-make-sendfile-selftest-work.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-165496-greg=kroah.com@vger.kernel.org Wed Jul 30 12:28:51 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 30 Jul 2025 12:28:08 +0200
Subject: selftests: mptcp: make sendfile selftest work
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Florian Westphal <fw@strlen.de>, sashal@kernel.org, Xiumei Mu <xmu@redhat.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20250730102806.1405622-6-matttbe@kernel.org>

From: Florian Westphal <fw@strlen.de>

commit df9e03aec3b14970df05b72d54f8ac9da3ab29e1 upstream.

When the selftest got added, sendfile() on mptcp sockets returned
-EOPNOTSUPP, so running 'mptcp_connect.sh -m sendfile' failed
immediately.

This is no longer the case, but the script fails anyway due to timeout.
Let the receiver know once the sender has sent all data, just like
with '-m mmap' mode.

v2: need to respect cfg_wait too, as pm_userspace.sh relied
on -m sendfile to keep the connection open (Mat Martineau)

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Reported-by: Xiumei Mu <xmu@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c |   26 ++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -451,6 +451,18 @@ static void set_nonblock(int fd)
 	fcntl(fd, F_SETFL, flags | O_NONBLOCK);
 }
 
+static void shut_wr(int fd)
+{
+	/* Close our write side, ev. give some time
+	 * for address notification and/or checking
+	 * the current status
+	 */
+	if (cfg_wait)
+		usleep(cfg_wait);
+
+	shutdown(fd, SHUT_WR);
+}
+
 static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after_out)
 {
 	struct pollfd fds = {
@@ -528,14 +540,7 @@ static int copyfd_io_poll(int infd, int
 					/* ... and peer also closed already */
 					break;
 
-				/* ... but we still receive.
-				 * Close our write side, ev. give some time
-				 * for address notification and/or checking
-				 * the current status
-				 */
-				if (cfg_wait)
-					usleep(cfg_wait);
-				shutdown(peerfd, SHUT_WR);
+				shut_wr(peerfd);
 			} else {
 				if (errno == EINTR)
 					continue;
@@ -666,7 +671,7 @@ static int copyfd_io_mmap(int infd, int
 		if (err)
 			return err;
 
-		shutdown(peerfd, SHUT_WR);
+		shut_wr(peerfd);
 
 		err = do_recvfile(peerfd, outfd);
 		*in_closed_after_out = true;
@@ -690,6 +695,9 @@ static int copyfd_io_sendfile(int infd,
 		err = do_sendfile(infd, peerfd, size);
 		if (err)
 			return err;
+
+		shut_wr(peerfd);
+
 		err = do_recvfile(peerfd, outfd);
 		*in_closed_after_out = true;
 	}


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
