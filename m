Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4A4400
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 09:56:02 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1oHMis-0001kZ-NP; Fri, 29 Jul 2022 11:55:58 +0200
From: Florian Westphal <fw@strlen.de>
To: mptcp@lists.linux.dev
Cc: matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Xiumei Mu <xmu@redhat.com>
Subject: [PATCH v2 mptcp] selftests: mptcp: make sendfile selftest work
Date: Fri, 29 Jul 2022 11:55:50 +0200
Message-Id: <20220729095550.3040-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index e2ea6c126c99..24d4e9cb617e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -553,6 +553,18 @@ static void set_nonblock(int fd, bool nonblock)
 		fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
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
@@ -630,14 +642,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
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
@@ -767,7 +772,7 @@ static int copyfd_io_mmap(int infd, int peerfd, int outfd,
 		if (err)
 			return err;
 
-		shutdown(peerfd, SHUT_WR);
+		shut_wr(peerfd);
 
 		err = do_recvfile(peerfd, outfd);
 		*in_closed_after_out = true;
@@ -791,6 +796,9 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 		err = do_sendfile(infd, peerfd, size);
 		if (err)
 			return err;
+
+		shut_wr(peerfd);
+
 		err = do_recvfile(peerfd, outfd);
 		*in_closed_after_out = true;
 	}
-- 
2.35.1

