Content-Type: multipart/mixed; boundary="===============8220102662537360149=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: fix compilation error without IPv6
Date: Mon, 02 Mar 2020 10:09:10 +0100
Message-ID: <20200302090911.1442823-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3835

--===============8220102662537360149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

net/mptcp/subflow.c: In function =E2=80=98mptcp_info2sockaddr=E2=80=99:
net/mptcp/subflow.c:810:31: error: =E2=80=98const struct mptcp_addr_info=E2=
=80=99 has no member named =E2=80=98addr6=E2=80=99; did you mean =E2=80=98a=
ddr=E2=80=99?
  810 |   in6_addr->sin6_addr =3D info->addr6;
      |                               ^~~~~
      |                               addr

Fixes: f88ff34735b9 (Squash-to: "mptcp: Add handling of outgoing MP_JOIN re=
quests")
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Add handling of outgoing MP_JOIN requests"

 net/mptcp/subflow.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 663e963995e1..68e0023422d6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -804,12 +804,15 @@ static void mptcp_info2sockaddr(const struct mptcp_ad=
dr_info *info,
 =

 		in_addr->sin_addr =3D info->addr;
 		in_addr->sin_port =3D info->port;
-	} else if (addr->ss_family =3D=3D AF_INET6) {
+	}
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (addr->ss_family =3D=3D AF_INET6) {
 		struct sockaddr_in6 *in6_addr =3D (struct sockaddr_in6 *)addr;
 =

 		in6_addr->sin6_addr =3D info->addr6;
 		in6_addr->sin6_port =3D info->port;
 	}
+#endif
 }
 =

 int __mptcp_subflow_connect(struct sock *sk, int ifindex,
-- =

2.25.0

--===============8220102662537360149==--
