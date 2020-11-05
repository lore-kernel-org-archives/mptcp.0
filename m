Content-Type: multipart/mixed; boundary="===============3537968429121420701=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC PATCH mptcp-next 5/6] mptcp: add the mib for
 MP_PRIO
Date: Thu, 05 Nov 2020 18:50:22 +0800
Message-ID: <97272e9a7c59c402dceec4a86ee96a1c6bac9b8c.1604572610.git.geliangtang@gmail.com>
In-Reply-To: 6af87960a4afd05da94429626d240c266c6bab23.1604572610.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6562

--===============3537968429121420701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the mib for MP_PRIO, named MPTCP_MIB_MPPRIO, for
receiving of the MP_PRIO suboption.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c     | 1 +
 net/mptcp/mib.h     | 1 +
 net/mptcp/options.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index a8744ad62087..3812c6417c00 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -32,6 +32,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
+	SNMP_MIB_ITEM("MPPrio", MPTCP_MIB_MPPRIO),
 	SNMP_MIB_SENTINEL
 };
 =

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1b07fc1ad1a0..522b3b191654 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -25,6 +25,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with port */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
+	MPTCP_MIB_MPPRIO,		/* Received MP_PRIO */
 	__MPTCP_MIB_MAX
 };
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index affbadb77faf..c09695dba1e1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1010,6 +1010,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 =

 	if (mp_opt.mp_prio) {
 		mptcp_pm_mp_prio_received(sk, mp_opt.prio_bkup);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIO);
 		mp_opt.mp_prio =3D 0;
 	}
 =

-- =

2.26.2

--===============3537968429121420701==--
