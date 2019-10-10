Content-Type: multipart/mixed; boundary="===============0966286282841979609=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix warnings reported by checkpatch
Date: Thu, 10 Oct 2019 16:27:43 +0200
Message-ID: <20191010142745.6436-3-matthieu.baerts@tessares.net>
In-Reply-To: 20191010142745.6436-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2087

--===============0966286282841979609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

WARNING: 'regarless' may be misspelled - perhaps 'regardless'?
#13:
Note that now we need to call __mptcp_init_sock() regarless of mptcp

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: queue data for mptcp level retransmission"

 .topmsg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.topmsg b/.topmsg
index 7e583db6e3ab..ab57e824a32c 100644
--- a/.topmsg
+++ b/.topmsg
@@ -10,7 +10,7 @@ the current page fragment can always host an MPTCP rtx qu=
eue entry.
 =

 The MPTCP rtx queue is flushed at disconnect() and close() time
 =

-Note that now we need to call __mptcp_init_sock() regarless of mptcp
+Note that now we need to call __mptcp_init_sock() regardless of mptcp
 enable status, as the destructor will try to walk the rtx_queue.
 =

 Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
-- =

2.20.1

--===============0966286282841979609==--
