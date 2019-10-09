Content-Type: multipart/mixed; boundary="===============1256655501445927631=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp] mptcp: mib: fix sparse warnings
Date: Wed, 09 Oct 2019 16:47:03 +0200
Message-ID: <20191009144703.30196-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2071

--===============1256655501445927631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: add MIB counter infrastructure

get rid of:
mib.c:31:33: sparse: warning: incorrect type in initializer (different addr=
ess spaces)
mib.c:31:33: sparse:    expected struct mptcp_mib *mib
mib.c:31:33: sparse:    got struct mptcp_mib [noderef] <asn:3> *
mib.c:36:13: sparse: warning: incorrect type in initializer (different addr=
ess spaces)
mib.c:36:13: sparse:    expected struct mptcp_mib [noderef] <asn:3> *__new
mib.c:36:13: sparse:    got struct mptcp_mib *mib
mib.c:37:29: sparse: warning: incorrect type in argument 1 (different addre=
ss spaces)
mib.c:37:29: sparse:    expected void [noderef] <asn:3> *__pdata
mib.c:37:29: sparse:    got struct mptcp_mib *mib
mib.c:42:6: sparse: warning: symbol 'mptcp_seq_show' was not declared. Shou=
ld it be static?

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/mib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 38f6e63335bf..4ab627e877d1 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -2,6 +2,7 @@
 =

 #include <linux/seq_file.h>
 #include <net/ip.h>
+#include <net/mptcp.h>
 #include <net/snmp.h>
 #include <net/net_namespace.h>
 =

@@ -28,7 +29,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
  */
 bool mptcp_mib_alloc(struct net *net)
 {
-	struct mptcp_mib *mib =3D alloc_percpu(struct mptcp_mib);
+	struct mptcp_mib __percpu *mib =3D alloc_percpu(struct mptcp_mib);
 =

 	if (!mib)
 		return false;
-- =

2.21.0

--===============1256655501445927631==--
