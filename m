Content-Type: multipart/mixed; boundary="===============8748323704895630347=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] topmsg: mptcp: update per unacked sequence on pkt
 reception
Date: Thu, 19 Mar 2020 17:23:05 -0700
Message-ID: <20200320002307.89947-3-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4003

--===============8748323704895630347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.topmsg b/.topmsg
index cdac48fde2f1..7c66c41e6919 100644
--- a/.topmsg
+++ b/.topmsg
@@ -2,7 +2,7 @@ From: Paolo Abeni <pabeni(a)redhat.com>
 Subject: [PATCH] mptcp: update per unacked sequence on pkt reception
 =

 So that we keep per unacked sequence number consistent; since
-we update per msk data, use an atomic64 cmpxcgh() to protect
+we update per msk data, use an atomic64 cmpxchg() to protect
 against concurrent updates from multiple subflows.
 =

 Initialize the snd_una at connect()/accept() time.
-- =

2.25.2

--===============8748323704895630347==--
