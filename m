Content-Type: multipart/mixed; boundary="===============1384808397753525223=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3] mptcp: fix option length of mp_capable syn/ack
Date: Mon, 02 Dec 2019 11:04:26 +0100
Message-ID: <6941c970fd9ce038972887af590fc685746f4427.1575279172.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2726

--===============1384808397753525223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

in current MPTCP, the server sends the client's key back in the syn/ack
packet. Because of that, both tcpdump and packetdrill refuse to parse
the mp_capable option in the syn/ack. Both RFC6824 and RFC6824bis don't
require this in section 3.1, only the server's key should be sent in
the syn/ack.

- change TCPOLEN_MPTCP_MPC_SYNACK from 20 (4+8+8) to 12 (4+8)
- don't write the client's key in mp_capable syn/ack
- adjust tests in mptcp_parse_option() to cope with the changed
  value of TCPOLEN_MPTCP_MPC_SYNACK

3-way handshakes obtained with

 # ./mptcp_connect.sh -4 -c -e tx
 [...]
 # tcpdump -c3 -tnnr ns1-5de04ec0-TGs4tf-ns1-5de04ec0-TGs4tf-MPTCP-MPTCP-10=
.0.1.1.pcap tcp

unpatched kernel:

 IP 10.0.1.1.49752 > 10.0.1.1.10000: Flags [S], seq 2594718977, win 65535, =
options [mss 65495,sackOK,TS val 3944347269 ecr 0,nop,wscale 8,mptcp capabl=
e {0xf931b304deb39a42}], length 0
 IP 10.0.1.1.10000 > 10.0.1.1.49752: Flags [S.], seq 3996234497, ack 259471=
8978, win 65535, options [mss 65495,sackOK,TS val 3944347270 ecr 3944347269=
,nop,wscale 8,mptcp capable[bad opt]>
^^^ bad option
 IP 10.0.1.1.49752 > 10.0.1.1.10000: Flags [.], ack 1, win 256, options [no=
p,nop,TS val 3944347270 ecr 3944347270,mptcp capable {0xf931b304deb39a42,0x=
96614f185e633ce}], length 0

patched kernel:

 IP 10.0.1.1.50850 > 10.0.1.1.10000: Flags [S], seq 626898452, win 65495, o=
ptions [mss 65495,sackOK,TS val 2266878231 ecr 0,nop,wscale 7,mptcp capable=
 {0x7fe37bfd872b9f9f}], length 0
 IP 10.0.1.1.10000 > 10.0.1.1.50850: Flags [S.], seq 3966041155, ack 626898=
453, win 65483, options [mss 65495,sackOK,TS val 2266878232 ecr 2266878231,=
nop,wscale 7,mptcp capable {0x8a167e3af39b5fc1}], length 0
^^^ no more bad option
 IP 10.0.1.1.50850 > 10.0.1.1.10000: Flags [.], ack 1, win 512, options [no=
p,nop,TS val 2266878232 ecr 2266878232,mptcp capable {0x7fe37bfd872b9f9f,0x=
8a167e3af39b5fc1}], length 0

v2: more conservative behavior when parsing received options
v3: adjust tests in mptcp_parse_option() to catch all possible
    values of MP_CAPABLE option length specified by v0 protocol,
    thanks Matthieu Baerts.

Fixes: 8fa520f034ed ("mptcp: Handle MPTCP TCP options")
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/options.c  | 7 +++----
 net/mptcp/protocol.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 98eb0281d196..eb29da31c7bd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -25,7 +25,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 	 */
 	case MPTCPOPT_MP_CAPABLE:
 		if (opsize !=3D TCPOLEN_MPTCP_MPC_SYN &&
-		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
+		    opsize !=3D TCPOLEN_MPTCP_MPC_ACK)
 			break;
 =

 		mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
@@ -57,7 +57,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
 		ptr +=3D 8;
 =

-		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
+		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK) {
 			mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 			ptr +=3D 8;
 			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rcvr=3D%llu",
@@ -650,8 +650,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 				      MPTCP_CAP_HMAC_SHA1);
 		put_unaligned_be64(opts->sndr_key, ptr);
 		ptr +=3D 2;
-		if ((OPTION_MPTCP_MPC_SYNACK |
-		     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
+		if (OPTION_MPTCP_MPC_ACK & opts->suboptions) {
 			put_unaligned_be64(opts->rcvr_key, ptr);
 			ptr +=3D 2;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index acad61c70de9..10347c9b4dff 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -34,7 +34,7 @@
 =

 /* MPTCP suboption lengths */
 #define TCPOLEN_MPTCP_MPC_SYN		12
-#define TCPOLEN_MPTCP_MPC_SYNACK	20
+#define TCPOLEN_MPTCP_MPC_SYNACK	12
 #define TCPOLEN_MPTCP_MPC_ACK		20
 #define TCPOLEN_MPTCP_MPJ_SYN		12
 #define TCPOLEN_MPTCP_MPJ_SYNACK	16
-- =

2.23.0

--===============1384808397753525223==--
