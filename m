Content-Type: multipart/mixed; boundary="===============7401585540653320132=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 7/0007] Squash-to: "mptcp: add MIB counter
 infrastructure"
Date: Wed, 04 Mar 2020 16:02:06 +0100
Message-ID: <e97883c06981964521cd2b78dc8e9a986771741e.1583334095.git.pabeni@redhat.com>
In-Reply-To: cover.1583334095.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3855

--===============7401585540653320132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add more MP JOIN related counters, will help self-tests

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/mib.c | 3 +++
 net/mptcp/mib.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 4ab627e877d1..365bd574940c 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -16,6 +16,9 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
 	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
+	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index d50b53e8209b..d7de340fc997 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -9,6 +9,9 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
 	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the p=
revious one */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
-- =

2.21.1

--===============7401585540653320132==--
