Content-Type: multipart/mixed; boundary="===============6868578410211837528=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix warnings reported by checkpatch
Date: Thu, 10 Oct 2019 16:27:41 +0200
Message-ID: <20191010142745.6436-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2085

--===============6868578410211837528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

WARNING: line over 80 characters
#233: FILE: net/mptcp/options.c:47:
+                * negotiated, the receiver MUST close the subflow with a R=
ST as it is

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Handle MPTCP TCP options"

 net/mptcp/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cee4280647fe..adf65d3ff27b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -44,8 +44,8 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 		 *
 		 * Section 3.3.0:
 		 * "If a checksum is not present when its use has been
-		 * negotiated, the receiver MUST close the subflow with a RST as it is
-		 * considered broken."
+		 * negotiated, the receiver MUST close the subflow with a RST as
+		 * it is considered broken."
 		 *
 		 * We don't implement DSS checksum - fall back to TCP.
 		 */
-- =

2.20.1

--===============6868578410211837528==--
