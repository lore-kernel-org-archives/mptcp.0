Content-Type: multipart/mixed; boundary="===============2358983935626443862=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix kbuild warning
Date: Wed, 09 Oct 2019 13:54:15 +0200
Message-ID: <20191009115415.13181-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2069

--===============2358983935626443862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The warning:

  net//mptcp/protocol.c:440:4: warning: format '%ld' expects argument of
                               type 'long int', but argument 4 has type
                               'size_t' [-Wformat=3D]

'%zu' should be used with size_t.

Reported-by: kbuild test robot <lkp(a)intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: Implement MPTCP receive path"

 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 508d5a83866b..8743b74dc1a1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -466,7 +466,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 			arg.msg =3D NULL;
 			desc.count =3D min_t(size_t, old_ack - ack_seq,
 					   map_remaining);
-			pr_debug("Dup data, map len=3D%d acked=3D%lld dropped=3D%ld",
+			pr_debug("Dup data, map len=3D%d acked=3D%lld dropped=3D%zu",
 				 map_remaining, old_ack - ack_seq, desc.count);
 		} else {
 			arg.msg =3D msg;
-- =

2.20.1

--===============2358983935626443862==--
