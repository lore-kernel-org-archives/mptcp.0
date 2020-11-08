Content-Type: multipart/mixed; boundary="===============0535572394250286588=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: provide rmem[0] limit
Date: Sun, 08 Nov 2020 19:49:59 +0100
Message-ID: <37af798bd46f402fb7c79f57ebbdd00614f5d7fa.1604861097.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6585

--===============0535572394250286588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mptcp proto struct currently does not provide the
required limit for forward memory scheduling. Under
pressure sk_rmem_schedule() will unconditionally try
to use such field and will oops.

Address the issue inheriting the tcp limit, as we already
do for the wmem one.

Fixes: ("mptcp: add missing memory scheduling in the rx path")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e7419fd15d84..88f2a7a0ccb8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2467,6 +2467,7 @@ static struct proto mptcp_prot =3D {
 	.memory_pressure	=3D &tcp_memory_pressure,
 	.stream_memory_free	=3D mptcp_memory_free,
 	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
+	.sysctl_rmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_rmem),
 	.sysctl_mem	=3D sysctl_tcp_mem,
 	.obj_size	=3D sizeof(struct mptcp_sock),
 	.slab_flags	=3D SLAB_TYPESAFE_BY_RCU,
-- =

2.26.2

--===============0535572394250286588==--
