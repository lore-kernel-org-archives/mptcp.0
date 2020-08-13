Content-Type: multipart/mixed; boundary="===============8399892444523289889=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 2/3] mptcp: add ADD_ADDR related
 mibs
Date: Thu, 13 Aug 2020 18:59:38 +0800
Message-ID: <986a142133c86aaaf1da6f10fb8ee4f047be0505.1597316052.git.geliangtang@gmail.com>
In-Reply-To: cover.1597316052.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5552

--===============8399892444523289889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added two mibs for ADD_ADDR, MPTCP_MIB_ADDADDR for receiving
of the ADD_ADDR suboption with echo-flag=3D0, and MPTCP_MIB_ECHOADD for
receiving the ADD_ADDR suboption with echo-flag=3D1.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index e71d3eebd924..376217405214 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -27,6 +27,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
 	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
+	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
+	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
 	SNMP_MIB_SENTINEL
 };
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 6d73818bbf7b..0b98a5e94c92 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -20,6 +20,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
 	MPTCP_MIB_NODSSWINDOW,		/* Segments not in MPTCP windows */
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
+	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=3D0 */
+	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=3D1 */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
 	__MPTCP_MIB_MAX
 };
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6aa9a48322d7..9372ccd4a687 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -893,6 +893,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 			WRITE_ONCE(msk->pm.add_addr_echo, true);
 			mptcp_pm_announce_addr(msk, &addr);
 			mptcp_pm_add_addr_received(msk, &addr);
+			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
+		} else {
+			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 		mp_opt.add_addr =3D 0;
 	}
-- =

2.17.1

--===============8399892444523289889==--
