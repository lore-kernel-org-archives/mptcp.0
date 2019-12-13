Content-Type: multipart/mixed; boundary="===============5715194989453607039=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] .topmsg: mptcp: parse and emit MP_CAPABLE option
 according to v1 spec
Date: Thu, 12 Dec 2019 16:58:21 -0800
Message-ID: <20191213005822.29791-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191213005822.29791-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2918

--===============5715194989453607039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use newly assigned RFC number, fix up line wrapping.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.topmsg b/.topmsg
index 74ccce6fb301..dfa69fc7582d 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,16 +1,16 @@
 From: Christoph Paasch <cpaasch(a)apple.com>
-Subject: [PATCH] mptcp: parse and emit MP_CAPABLE option according to v1 s=
pec.
+Subject: [PATCH] mptcp: parse and emit MP_CAPABLE option according to v1 s=
pec
 =

 This implements MP_CAPABLE options parsing and writing according
-to the RFC 6824 bis - MPTCP v1.
+to RFC 6824 bis / RFC 8684: MPTCP v1.
+
 Local key is sent on syn/ack, and both keys are sent on 3rd ack.
-MP_CAPABLE messages len are updated accordingly.
-We need the skbuff to emit correctly the above, so we push the skbuff
-struct as an argument all the way from tcp code to the relevant mptcp
-callbacks.
+MP_CAPABLE messages len are updated accordingly. We need the skbuff to
+correctly emit the above, so we push the skbuff struct as an argument
+all the way from tcp code to the relevant mptcp callbacks.
 =

 When processing incoming MP_CAPABLE + data, build a full blown DSS-like
-map info, to simplify later processing.
-On child socket creation, we need to record the remote key, if available.
+map info, to simplify later processing.  On child socket creation, we
+need to record the remote key, if available.
 =

 Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
-- =

2.24.1

--===============5715194989453607039==--
