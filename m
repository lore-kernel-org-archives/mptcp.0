Content-Type: multipart/mixed; boundary="===============1041287654343822001=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: only wake parent if subflow is
 writable
Date: Fri, 21 Aug 2020 15:28:56 +0200
Message-ID: <20200821132856.867-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 5590

--===============1041287654343822001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_connect.sh -d 10 -l 0 -r 0 -e "" -f $((100 * 1024 * 1024)) -m poll

will result in frequent write errors:
ns1 MPTCP -> ns3 (10.0.2.2:10010      ) MPTCP   write: Resource temporarily=
 unavailable

We promised write() would not block but then no subflow was ready
to accept more data.

Changing the 'free' check to 'writeable' (which checks the available
space is above min thresh) makes those errors go away.

Note that there are still poll timeouts:
ns1 MPTCP -> ns2 (10.0.1.2:10006      ) MPTCP   copyfd_io_poll: poll timed =
out (events: POLLIN 1, POLLOUT 0)
copyfd_io_poll: poll timed out (events: POLLIN 0, POLLOUT 4)

This appears unrelated, they also appear without this change.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 82f6d2d9e39e..3585fd63c757 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -972,7 +972,7 @@ static void subflow_write_space(struct sock *sk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
 =

-	if (!sk_stream_memory_free(sk))
+	if (!sk_stream_is_writeable(sk))
 		return;
 =

 	WRITE_ONCE(subflow->writable, true);
-- =

2.26.2

--===============1041287654343822001==--
