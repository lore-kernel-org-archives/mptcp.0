Content-Type: multipart/mixed; boundary="===============5070195927027797510=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: fix compilation warning with i386
Date: Wed, 16 Oct 2019 18:34:49 +0200
Message-ID: <20191016163449.25895-3-matthieu.baerts@tessares.net>
In-Reply-To: 20191016163449.25895-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2189

--===============5070195927027797510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

  net/mptcp/subflow.c:528:26: note: format string is defined here
    528 |   pr_debug("discarding %ld bytes, current map len=3D%d", delta,
        |                        ~~^
        |                          |
        |                          long int
        |                        %d

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: Implement MPTCP receive path"

 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 01a15cc2c711..e2e76226eb72 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -525,7 +525,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			delta =3D min_t(size_t, ack_seq - old_ack, map_remaining);
 =

 		/* discard mapped data */
-		pr_debug("discarding %ld bytes, current map len=3D%d", delta,
+		pr_debug("discarding %zu bytes, current map len=3D%d", delta,
 			 map_remaining);
 		if (delta) {
 			struct mptcp_read_arg arg =3D {
-- =

2.20.1

--===============5070195927027797510==--
