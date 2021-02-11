Content-Type: multipart/mixed; boundary="===============5112973133802755083=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: reset last_snd on subflow close
Date: Fri, 12 Feb 2021 00:42:44 +0100
Message-ID: <20210211234245.31961-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 7766

--===============5112973133802755083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Send logic caches last active subflow in the msk, so it needs to be
cleared when the cached subflow is closed.

Fixes: d5f49190def61c ("mptcp: allow picking different xmit subflows")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/155
Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d49e0efbdd50..fdd6b3cb0bf5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2145,6 +2145,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct=
 sock *ssk,
 	release_sock(ssk);
 =

 	sock_put(ssk);
+
+	if (ssk =3D=3D msk->last_snd)
+		msk->last_snd =3D NULL;
 }
 =

 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-- =

2.26.2

--===============5112973133802755083==--
