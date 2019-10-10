Content-Type: multipart/mixed; boundary="===============7560532431048155359=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix warnings reported by checkpatch
Date: Thu, 10 Oct 2019 16:27:45 +0200
Message-ID: <20191010142745.6436-5-matthieu.baerts@tessares.net>
In-Reply-To: 20191010142745.6436-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2089

--===============7560532431048155359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

WARNING: line over 80 characters
#60: FILE: net/mptcp/protocol.c:1010:
+               MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEFAL=
LBACK);

WARNING: line over 80 characters
#69: FILE: net/mptcp/protocol.c:1163:
+               MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEFALL=
BACK);

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: increment MIB counters in a few places"

 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e6ffab07d6ab..47f4c0aa37f8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1007,7 +1007,8 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		new_sock->sk =3D NULL;
 		sock_release(new_sock);
 =

-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
+		MPTCP_INC_STATS(sock_net(sk),
+				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 =

 	return newsk;
@@ -1160,7 +1161,8 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
 		bh_unlock_sock(sk);
 		local_bh_enable();
 	} else {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
+		MPTCP_INC_STATS(sock_net(sk),
+				MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 	}
 	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
-- =

2.20.1

--===============7560532431048155359==--
