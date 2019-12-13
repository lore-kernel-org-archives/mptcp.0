Content-Type: multipart/mixed; boundary="===============9004394527436642555=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] .topmsg: mptcp: Handle MPTCP TCP options
Date: Thu, 12 Dec 2019 16:58:17 -0800
Message-ID: <20191213005822.29791-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191213005822.29791-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2914

--===============9004394527436642555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make it clear that v1 changes come later in the series.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.topmsg b/.topmsg
index b600890bd60b..02c0016415ae 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,7 +1,9 @@
 From: Peter Krystad <peter.krystad(a)linux.intel.com>
 Subject: [PATCH] mptcp: Handle MPTCP TCP options
 =

-Currently only MPTCP v0 is supported so ignore v1 MP_CAPABLE option.
+These options are handled according to MPTCPv0 (RFC6824).
+RFC6824bis/RFC8684 MPTCPv1 MP_CAPABLE is added later in coordination
+with related code changes.
 =

 Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
 Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
@@ -9,4 +11,5 @@ Co-developed-by: Florian Westphal <fw(a)strlen.de>
 Signed-off-by: Florian Westphal <fw(a)strlen.de>
 Co-developed-by: Davide Caratti <dcaratti(a)redhat.com>
 Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
+Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
 Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
-- =

2.24.1

--===============9004394527436642555==--
