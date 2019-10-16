Content-Type: multipart/mixed; boundary="===============2019668235271190568=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: fix compilation warning with i386
Date: Wed, 16 Oct 2019 18:34:48 +0200
Message-ID: <20191016163449.25895-2-matthieu.baerts@tessares.net>
In-Reply-To: 20191016163449.25895-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2188

--===============2019668235271190568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

  net/mptcp/protocol.c:523:24: note: format string is defined here
      pr_debug("reading %ld bytes, copied %d", desc.count,
                        ~~^
                        %d

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: recvmsg() can drain data from multiple subflows"

 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4fdcbb0f4285..5e6a104e3b68 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -520,7 +520,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 			map_remaining =3D subflow->map_data_len -
 					mptcp_subflow_get_map_offset(subflow);
 			desc.count =3D min_t(size_t, len - copied, map_remaining);
-			pr_debug("reading %ld bytes, copied %d", desc.count,
+			pr_debug("reading %zu bytes, copied %d", desc.count,
 				 copied);
 			bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
 			if (bytes_read < 0) {
-- =

2.20.1

--===============2019668235271190568==--
