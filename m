Content-Type: multipart/mixed; boundary="===============4447688957115301477=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 1/2] mptcp: initialize
 mptcp_options_received's ahmac
Date: Mon, 19 Oct 2020 18:23:15 +0800
Message-ID: <3ae4089622f9933c18f474e6ee954f39a40bfec3.1603102503.git.geliangtang@gmail.com>
In-Reply-To: cover.1603102503.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6347

--===============4447688957115301477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch initialize mptcp_options_received's ahmac to zero, otherwise it
will be a random number when receiving ADD_ADDR suboption with echo-flag=3D=
1.

Fixes: 3df523ab582c5 ("mptcp: Add ADD_ADDR handling")
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 092a2d48bfd3..1ff3469938b6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -297,6 +297,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->mp_capable =3D 0;
 	mp_opt->mp_join =3D 0;
 	mp_opt->add_addr =3D 0;
+	mp_opt->ahmac =3D 0;
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
 =

-- =

2.26.2

--===============4447688957115301477==--
