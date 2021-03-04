Content-Type: multipart/mixed; boundary="===============3395410573485353057=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2] mptcp: fix length of ADD_ADDR with port
 suboption
Date: Thu, 04 Mar 2021 17:23:23 +0100
Message-ID: <dfea8e080c5e8bbcbeefa64a4b8d7ff2becea639.1614874814.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 8025

--===============3395410573485353057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

in current Linux, MPTCP peers advertising endpoints with port numbers use
a sub-option length that wrongly accounts for the trailing TCP NOP. Also,
receivers will only process incoming ADD_ADDR with port having such wrong
sub-option length. Fix this, making ADD_ADDR compliant to RFC8684 =C2=A73.4=
.1.

this can be verified running tcpdump on the kselftests artifacts:

 unpatched kernel:
 [root(a)bottarga mptcp]# tcpdump -tnnr unpatched.pcap | grep add-addr
 reading from file unpatched.pcap, link-type LINUX_SLL (Linux cooked v1), s=
napshot length 65535
 IP 10.0.1.1.10000 > 10.0.1.2.53078: Flags [.], ack 101, win 509, options [=
nop,nop,TS val 214459678 ecr 521312851,mptcp add-addr v1 id 1 a00:201:2774:=
2d88:7436:85c3:17fd:101], length 0
 IP 10.0.1.2.53078 > 10.0.1.1.10000: Flags [.], ack 101, win 502, options [=
nop,nop,TS val 521312852 ecr 214459678,mptcp add-addr[bad opt]]

 patched kernel:
 [root(a)bottarga mptcp]# tcpdump -tnnr patched.pcap | grep add-addr
 reading from file patched.pcap, link-type LINUX_SLL (Linux cooked v1), sna=
pshot length 65535
 IP 10.0.1.1.10000 > 10.0.1.2.38178: Flags [.], ack 101, win 509, options [=
nop,nop,TS val 3728873902 ecr 2732713192,mptcp add-addr v1 id 1 10.0.2.1:10=
100 hmac 0xbccdfcbe59292a1f,nop,nop], length 0
 IP 10.0.1.2.38178 > 10.0.1.1.10000: Flags [.], ack 101, win 502, options [=
nop,nop,TS val 2732713195 ecr 3728873902,mptcp add-addr v1-echo id 1 10.0.2=
.1:10100,nop,nop], length 0

Fixes: 22fb85ffaefb ("mptcp: add port support for ADD_ADDR suboption writin=
g")
CC: stable(a)vger.kernel.org # 5.11+
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/protocol.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 91827d949766..e21a5bc36cf0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -52,14 +52,15 @@
 #define TCPOLEN_MPTCP_DSS_MAP64		14
 #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
 #define TCPOLEN_MPTCP_ADD_ADDR		16
-#define TCPOLEN_MPTCP_ADD_ADDR_PORT	20
+#define TCPOLEN_MPTCP_ADD_ADDR_PORT	18
 #define TCPOLEN_MPTCP_ADD_ADDR_BASE	8
-#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT	12
+#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT	10
 #define TCPOLEN_MPTCP_ADD_ADDR6		28
-#define TCPOLEN_MPTCP_ADD_ADDR6_PORT	32
+#define TCPOLEN_MPTCP_ADD_ADDR6_PORT	30
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
-#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
-#define TCPOLEN_MPTCP_PORT_LEN		4
+#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	22
+#define TCPOLEN_MPTCP_PORT_LEN		2
+#define TCPOLEN_MPTCP_PORT_ALIGN	2
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
 #define TCPOLEN_MPTCP_PRIO		3
 #define TCPOLEN_MPTCP_PRIO_ALIGN	4
@@ -701,8 +702,9 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y, bool echo, bool port)
 		len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 	if (!echo)
 		len +=3D MPTCPOPT_THMAC_LEN;
+	/* account for 2 trailing 'nop' options */
 	if (port)
-		len +=3D TCPOLEN_MPTCP_PORT_LEN;
+		len +=3D TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
 =

 	return len;
 }
-- =

2.29.2

--===============3395410573485353057==--
