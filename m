Content-Type: multipart/mixed; boundary="===============4542721138277247455=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: use adding up
 size to get ADD_ADDR length"
Date: Wed, 02 Dec 2020 16:51:53 +0800
Message-ID: <e021e1924a8c0e6bd51c7a0253bba471fe3ee0a1.1606898909.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7005

--===============4542721138277247455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Drop the duplicate macro TCPOLEN_MPTCP_ADD_ADDR_HMAC, use MPTCPOPT_THMAC_LEN
instead.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
This patch will conflict with "mptcp: add the outgoing ADD_ADDR port
support", please fix the conflict like this:

static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool p=
ort)
{
        u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;

        if (family =3D=3D AF_INET6)
                len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
        if (!echo)
<<<<<<< HEAD
                len +=3D MPTCPOPT_THMAC_LEN;
=3D=3D=3D=3D=3D=3D=3D
                len +=3D TCPOLEN_MPTCP_ADD_ADDR_HMAC;
        if (port)
                len +=3D TCPOLEN_MPTCP_PORT_LEN;
>>>>>>> 95a78f5e7ac1... mptcp: add the outgoing ADD_ADDR port support

        return len;
}

->

static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool p=
ort)
{
        u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;

        if (family =3D=3D AF_INET6)
                len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
        if (!echo)
                len +=3D MPTCPOPT_THMAC_LEN;
        if (port)
                len +=3D TCPOLEN_MPTCP_PORT_LEN;

        return len;
}
---
 net/mptcp/protocol.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0ca633c0475a..9315f6a8343a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -57,7 +57,6 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
 #define TCPOLEN_MPTCP_PORT_LEN		4
-#define TCPOLEN_MPTCP_ADD_ADDR_HMAC	8
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
 =

 /* MPTCP MP_JOIN flags */
@@ -583,7 +582,7 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y, bool echo)
 	if (family =3D=3D AF_INET6)
 		len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 	if (!echo)
-		len +=3D TCPOLEN_MPTCP_ADD_ADDR_HMAC;
+		len +=3D MPTCPOPT_THMAC_LEN;
 =

 	return len;
 }
-- =

2.26.2

--===============4542721138277247455==--
