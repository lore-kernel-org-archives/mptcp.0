Content-Type: multipart/mixed; boundary="===============1885225291658992299=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 11/12] mptcp: add the mib for
 ADD_ADDR with port
Date: Thu, 05 Nov 2020 16:01:11 +0800
Message-ID: <2447fed3519d7acdbbc1376529bdb36505eb6301.1604562475.git.geliangtang@gmail.com>
In-Reply-To: ea1142d64829c236413519dd57a64cbf269f3e3b.1604562475.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6555

--===============1885225291658992299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the mib for ADD_ADDR with port, named MPTCP_MIB_PORTADD,
for receiving of the ADD_ADDR suboption with a port number.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c     | 1 +
 net/mptcp/mib.h     | 1 +
 net/mptcp/options.c | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 84d119436b22..a8744ad62087 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -29,6 +29,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
+	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_SENTINEL
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 47bcecce1106..1b07fc1ad1a0 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -22,6 +22,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=3D0 */
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=3D1 */
+	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with port */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	__MPTCP_MIB_MAX
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 73d594b1e53c..f611fbcbd6d0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -955,6 +955,10 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb)
 			mptcp_pm_del_add_timer(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
+
+		if (mp_opt.port)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
+
 		mp_opt.add_addr =3D 0;
 	}
 =

-- =

2.26.2

--===============1885225291658992299==--
