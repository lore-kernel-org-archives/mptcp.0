Content-Type: multipart/mixed; boundary="===============8545520248684177387=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] Squash-to: "mptcp: Implement MPTCP receive path"
Date: Wed, 18 Dec 2019 13:33:53 +0100
Message-ID: <4064496cd54175b7a40684389e6437604cd7142c.1576671711.git.pabeni@redhat.com>
In-Reply-To: 22048bea67adf1cece50cb6aac1c736e3ce9d0dd.1576671427.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3136

--===============8545520248684177387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

drop C++ style comment, we have explicit checks in place
for supported flags

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 545632ce8cb9..9a9aed94e4d0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -246,8 +246,6 @@ int mptcp_read_actor(read_descriptor_t *desc, struct sk=
_buff *skb,
 		pr_debug("Flushing skb payload");
 	}
 =

-	// MSG_PEEK support? Other flags? MSG_TRUNC?
-
 	desc->count -=3D copy_len;
 =

 	pr_debug("consumed %zu bytes, %zu left", copy_len, desc->count);
-- =

2.21.0

--===============8545520248684177387==--
