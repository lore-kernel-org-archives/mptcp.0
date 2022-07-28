Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC507A
	for <mptcp@lists.linux.dev>; Thu, 28 Jul 2022 18:53:31 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1oH8Ck-0005MX-Kg; Thu, 28 Jul 2022 20:25:50 +0200
From: Florian Westphal <fw@strlen.de>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp] selftests: mptcp: make sendfile selftest work
Date: Thu, 28 Jul 2022 20:25:44 +0200
Message-Id: <20220728182544.4128-1-fw@strlen.de>
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

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index e2ea6c126c99..6e429b88f911 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -791,6 +791,9 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 		err = do_sendfile(infd, peerfd, size);
 		if (err)
 			return err;
+
+		shutdown(peerfd, SHUT_WR);
+
 		err = do_recvfile(peerfd, outfd);
 		*in_closed_after_out = true;
 	}
-- 
2.35.1

