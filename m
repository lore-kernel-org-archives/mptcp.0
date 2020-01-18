Content-Type: multipart/mixed; boundary="===============7918300264723057085=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Update commit message for "mptcp: Implement MPTCP
 receive path"
Date: Fri, 17 Jan 2020 17:06:57 -0800
Message-ID: <20200118010657.22436-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3417

--===============7918300264723057085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix minor typos.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.topmsg b/.topmsg
index 75ae84b862ce..5a55ac729038 100644
--- a/.topmsg
+++ b/.topmsg
@@ -6,13 +6,13 @@ fields. MPTCP fields are parsed from the TCP option heade=
r and placed in
 an skb extension, allowing the upper MPTCP layer to access MPTCP
 options after the skb has gone through the TCP stack.
 =

-The subflow implements it's own data_ready() ops, which ensures that
-the pending data is in sequence - according to MPTCP seq number -
-dropping out-of-seq skbs.  The DATA_READY bit flag is set if this
-is the case.  This allows the MPTCP socket layer to determine if more
-data is available without having to consult the individual subflows.
+The subflow implements its own data_ready() ops, which ensures that the
+pending data is in sequence - according to MPTCP seq number - dropping
+out-of-seq skbs. The DATA_READY bit flag is set if this is the case.
+This allows the MPTCP socket layer to determine if more data is
+available without having to consult the individual subflows.
 =

-It additionally validates the current mapping and propagate EoF events
+It additionally validates the current mapping and propagates EoF events
 to the connection socket.
 =

 Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
-- =

2.25.0

--===============7918300264723057085==--
