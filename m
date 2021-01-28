Content-Type: multipart/mixed; boundary="===============1655048123210051944=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2] net: mptcp: fix length of MP_PRIO
 sub-option
Date: Thu, 28 Jan 2021 14:07:39 +0100
Message-ID: <f675bf58efc120401bd776a63c3472455c3898d9.1611839010.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7501

--===============1655048123210051944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With version 0 of the protocol it was legal to encode the 'Subflow Id' in
the MP_PRIO suboption, to specify which subflow would change its 'Backup'
flag. This has been removed from v1 specification: thus, according to RFC
8684 =C2=A73.3.8, the resulting 'Length' for MP_PRIO changed from 4 to 3 by=
te.

Current Linux generates / parses MP_PRIO according to the old spec, using
'Length' equal to 4, and hardcoding 1 as 'Subflow Id'; RFC compliance can
improve if we change 'Length' in other to become 3, leaving a 'Nop' after
the MP_PRIO suboption. In this way the kernel will emit and accept *only*
MP_PRIO suboptions that are compliant to version 1 of the MPTCP protocol.

 unpatched 5.11-rc kernel:
 [root(a)bottarga ~]# tcpdump -tnnr unpatched.pcap | grep prio
 reading from file unpatched.pcap, link-type LINUX_SLL (Linux cooked v1)
 dropped privs to tcpdump
 IP 10.0.3.2.48433 > 10.0.1.1.10006: Flags [.], ack 1, win 502, options [no=
p,nop,TS val 4032325513 ecr 1876514270,mptcp prio non-backup id 1,mptcp dss=
 ack 14084896651682217737], length 0

 patched 5.11-rc kernel:
 [root(a)bottarga ~]# tcpdump -tnnr patched.pcap | grep prio
 reading from file patched.pcap, link-type LINUX_SLL (Linux cooked v1)
 dropped privs to tcpdump
 IP 10.0.3.2.49735 > 10.0.1.1.10006: Flags [.], ack 1, win 502, options [no=
p,nop,TS val 1276737699 ecr 2686399734,mptcp prio non-backup,nop,mptcp dss =
ack 18433038869082491686], length 0

Changes since v1:
 - refactor patch to avoid using 'TCPOLEN_MPTCP_PRIO' with its old value,
   thanks to Geliang Tang.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/options.c  | 5 +++--
 net/mptcp/protocol.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 775f0576592e..6e088c583992 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -699,10 +699,11 @@ static bool mptcp_established_options_mp_prio(struct =
sock *sk,
 	if (!subflow->send_mp_prio)
 		return false;
 =

-	if (remaining < TCPOLEN_MPTCP_PRIO)
+	/* account for the trailing 'nop' option */
+	if (remaining < TCPOLEN_MPTCP_PRIO + 1)
 		return false;
 =

-	*size =3D TCPOLEN_MPTCP_PRIO;
+	*size =3D TCPOLEN_MPTCP_PRIO + 1;
 	opts->suboptions |=3D OPTION_MPTCP_PRIO;
 	opts->backup =3D subflow->request_bkup;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 447ce4631b43..c61f5731eccd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -61,7 +61,7 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
 #define TCPOLEN_MPTCP_PORT_LEN		4
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
-#define TCPOLEN_MPTCP_PRIO		4
+#define TCPOLEN_MPTCP_PRIO		3
 #define TCPOLEN_MPTCP_FASTCLOSE		12
 =

 /* MPTCP MP_JOIN flags */
-- =

2.29.2

--===============1655048123210051944==--
