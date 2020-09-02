Content-Type: multipart/mixed; boundary="===============2442765348493080806=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] selftests: mptcp: fix typo in mptcp_connect
 usage
Date: Wed, 02 Sep 2020 13:44:24 +0200
Message-ID: <6c43e5404c41f91ed9324e20c35a4e4fdb0ed1de.1599046871.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5695

--===============2442765348493080806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

in mptcp_connect, 's' selects IPPROTO_MPTCP / IPPROTO_TCP as the value of
'protocol' in socket(), and 'm' switches between different send / receive
modes. Fix die_usage(): swap 'm' and 's' and add missing 'sendfile' mode.

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 090620c3e10c..a54966531a64 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -65,8 +65,8 @@ static void die_usage(void)
 	fprintf(stderr, "\t-S num -- set SO_SNDBUF to num\n");
 	fprintf(stderr, "\t-R num -- set SO_RCVBUF to num\n");
 	fprintf(stderr, "\t-p num -- use port num\n");
-	fprintf(stderr, "\t-m [MPTCP|TCP] -- use tcp or mptcp sockets\n");
-	fprintf(stderr, "\t-s [mmap|poll] -- use poll (default) or mmap\n");
+	fprintf(stderr, "\t-s [MPTCP|TCP] -- use mptcp(default) or tcp sockets\n"=
);
+	fprintf(stderr, "\t-m [poll|mmap|sendfile] -- use poll(default)/mmap+writ=
e/sendfile\n");
 	fprintf(stderr, "\t-u -- check mptcp ulp\n");
 	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
 	exit(1);
-- =

2.26.2

--===============2442765348493080806==--
