Content-Type: multipart/mixed; boundary="===============8910912109412970815=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix compilation warning without IPV6
Date: Tue, 21 Jan 2020 23:59:33 +0100
Message-ID: <20200121225933.3038131-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3464

--===============8910912109412970815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Spot by Mat:

    net/mptcp/protocol.c: In function =E2=80=98mptcp_copy_inaddrs=E2=80=99:
    net/mptcp/protocol.c:672:21: warning: unused variable =E2=80=98msk6=E2=
=80=99 [-Wunused-variable]
      672 |  struct ipv6_pinfo *msk6 =3D inet6_sk(msk);
          |                     ^~~~
    net/mptcp/protocol.c:671:27: warning: unused variable =E2=80=98ssk6=E2=
=80=99 [-Wunused-variable]
      671 |  const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
          |                           ^~~~

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Create SUBFLOW socket for incoming connection=
s"

 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84799a5212a2..41e83270c984 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -217,8 +217,10 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 {
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
 	struct ipv6_pinfo *msk6 =3D inet6_sk(msk);
+#endif
 =

 	inet_sk(msk)->inet_num =3D inet_sk(ssk)->inet_num;
 	inet_sk(msk)->inet_dport =3D inet_sk(ssk)->inet_dport;
-- =

2.24.0

--===============8910912109412970815==--
