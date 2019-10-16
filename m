Content-Type: multipart/mixed; boundary="===============3229921830672087530=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: fix compilation error without IPV6
Date: Wed, 16 Oct 2019 18:15:27 +0200
Message-ID: <20191016161528.4336-3-matthieu.baerts@tessares.net>
In-Reply-To: 20191016161528.4336-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2183

--===============3229921830672087530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

  net/mptcp/options.c: In function =E2=80=98mptcp_established_options_addr=
=E2=80=99:
  net/mptcp/options.c:478:9: error: =E2=80=98struct mptcp_out_options=E2=80=
=99 has no member named =E2=80=98addr6=E2=80=99; did you mean =E2=80=98addr=
=E2=80=99?
    478 |   opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
        |         ^~~~~
        |         addr

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: Add ADD_ADDR handling"

 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c948951509e1..6cfcf2ce44fe 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -470,6 +470,7 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 		opts->addr_id =3D id;
 		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
 		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
+#if IS_ENABLED(CONFIG_IPV6)
 	} else if (saddr.ss_family =3D=3D AF_INET6) {
 		if (remaining < TCPOLEN_MPTCP_ADD_ADDR6)
 			return false;
@@ -477,6 +478,7 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 		opts->addr_id =3D id;
 		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
 		*size =3D TCPOLEN_MPTCP_ADD_ADDR6;
+#endif
 	}
 =

 	msk->addr_signal =3D 0;
-- =

2.20.1

--===============3229921830672087530==--
