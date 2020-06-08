Content-Type: multipart/mixed; boundary="===============4642568336165147116=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2] mptcp: bugfix for RM_ADDR option parsing
Date: Mon, 08 Jun 2020 18:47:54 +0800
Message-ID: <5ec9759a19d4eba5f7f9006354da2cfeb39fa839.1591612830.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 4604

--===============4642568336165147116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In MPTCPOPT_RM_ADDR option parsing, the pointer "ptr" pointed to the
"Subtype" octet, the pointer "ptr+1" pointed to the "Address ID" octet:

  +-------+-------+---------------+
  |Subtype|(resvd)|   Address ID  |
  +-------+-------+---------------+
  |               |
 ptr            ptr+1

We should set mp_opt->rm_id to the value of "ptr+1", not "ptr". This patch
will fix this bug.

Fixes: 3df523ab582c ("mptcp: Add ADD_ADDR handling")
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 Changes in v2:
  - Add "-net" subject and "Fixes" tag as Matt suggested.
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 01f1f4cf4902..490b92534afc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -273,6 +273,8 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR_BASE)
 			break;
 =

+		ptr++;
+
 		mp_opt->rm_addr =3D 1;
 		mp_opt->rm_id =3D *ptr++;
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
-- =

2.17.1

--===============4642568336165147116==--
