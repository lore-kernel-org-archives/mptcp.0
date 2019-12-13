Content-Type: multipart/mixed; boundary="===============1391104821951749663=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] .topmsg: tcp: clean ext on tx recycle
Date: Thu, 12 Dec 2019 16:58:16 -0800
Message-ID: <20191213005822.29791-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2913

--===============1391104821951749663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reworded since the tree contains very little MPTCP code at this point
in the series.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/.topmsg b/.topmsg
index 7aae16c9c23d..a8bca95438b4 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,26 +1,21 @@
 From: Paolo Abeni <pabeni(a)redhat.com>
 Subject: [PATCH] tcp: clean ext on tx recycle
 =

-Otherwise we will find stray/unexpected/old extensions
-value on next iteration.
+Otherwise we will find stray/unexpected/old extensions value on next
+iteration.
 =

-On tcp_write_xmit() we can end-up splitting an already queued
-skb in two parts, via tso_fragment(). The newly created skb
-can be allocated via the tx cache and the mptcp stack will not
-be aware of it, so nobody set properly the MPTCP ext.
+On tcp_write_xmit() we can end-up splitting an already queued skb in two
+parts, via tso_fragment(). The newly created skb can be allocated via
+the tx cache and an upper layer will not be aware of it, so that upper
+layer cannot set the ext properly.
 =

-End result, we transmit the skb using an hold MPTCP DSS map
-and that confuses the rx side/corrupt the stream. It requires
-some concurrent conditions, so it's not deterministic.
+Resetting the ext on recycle ensures that stale data is not propagated
+in to packet headers or elsewhere.
 =

-Resetting the ext on recycle fixes all the current mptcp self tests
-issues.
-
-Apparently only MPTCP has issues with this kind of stray ext,
-so an alternative would be add an additional mptcp hook in
-tso_fragment() or in sk_stream_alloc_skb() to always init
-the ext.
+An alternative would be add an additional hook in tso_fragment() or in
+sk_stream_alloc_skb() to init the ext for upper layers that need it.
 =

 Co-developed-by: Florian Westphal <fw(a)strlen.de>
 Signed-off-by: Florian Westphal <fw(a)strlen.de>
+Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
 Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
-- =

2.24.1

--===============1391104821951749663==--
