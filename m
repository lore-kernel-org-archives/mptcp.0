Content-Type: multipart/mixed; boundary="===============1145988923697726768=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] .topmsg: mptcp: Write MPTCP DSS headers to outgoing
 data packets
Date: Thu, 12 Dec 2019 16:58:19 -0800
Message-ID: <20191213005822.29791-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191213005822.29791-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2916

--===============1145988923697726768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update information about DSS options appearing in segmented packets.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/.topmsg b/.topmsg
index bb759658a0ec..424db4f06d5f 100644
--- a/.topmsg
+++ b/.topmsg
@@ -3,11 +3,12 @@ Subject: [PATCH] mptcp: Write MPTCP DSS headers to outgoi=
ng data packets
 =

 Per-packet metadata required to write the MPTCP DSS option is written to
 the skb_ext area. One write to the socket may contain more than one
-packet of data, in which case the DSS option in the first packet will
-have a mapping covering all of the data in that write. Packets after the
-first do not have a DSS option. This is complicated to handle under
-memory pressure, since the first packet (with the DSS mapping) is pushed
-to the TCP core before the remaining skbs are allocated.
+packet of data, which is copied to page fragments and mapped in to MPTCP
+DSS segments with size determined by the available page fragments and
+the maximum mapping length allowed by the MPTCP specification. If
+do_tcp_sendpages() splits a DSS segment in to multiple skbs, that's ok -
+the later skbs can either have duplicated DSS mapping information or
+none at all, and the receiver can handle that.
 =

 The current implementation uses the subflow frag cache and tcp
 sendpages to avoid excessive code duplication. More work is required to
-- =

2.24.1

--===============1145988923697726768==--
