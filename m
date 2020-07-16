Content-Type: multipart/mixed; boundary="===============0554577842788633560=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 12/12] mptcp: Safely store sequence number
 when sending data
Date: Wed, 15 Jul 2020 17:20:36 -0700
Message-ID: <20200716002036.705306-13-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200716002036.705306-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5036

--===============0554577842788633560==
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
index 30c5810771dd..ed3ca80d72f8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -797,7 +797,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
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

2.27.0

--===============0554577842788633560==--
