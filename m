Content-Type: multipart/mixed; boundary="===============6745415331684062984=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 12/12] mptcp: Safely store sequence number
 when sending data
Date: Tue, 28 Jul 2020 15:12:10 -0700
Message-ID: <20200728221210.92841-13-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200728221210.92841-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5355

--===============6745415331684062984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MPTCP socket's write_seq member can be read without the msk lock
held, so use WRITE_ONCE() to store it.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2455a68d231..687f0bea2b35 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -793,7 +793,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 out:
 	if (!retransmission)
 		pfrag->offset +=3D frag_truesize;
-	*write_seq +=3D ret;
+	WRITE_ONCE(*write_seq, *write_seq + ret);
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

 	return ret;
-- =

2.28.0

--===============6745415331684062984==--
