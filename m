Content-Type: multipart/mixed; boundary="===============4058503770168820182=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v4 12/12] mptcp: Safely store sequence
 number when sending data
Date: Thu, 23 Jul 2020 18:11:27 -0700
Message-ID: <20200724011127.363638-13-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200724011127.363638-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5287

--===============4058503770168820182==
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
index 65aa2b9df721..5d992f78e6bf 100644
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

2.27.0

--===============4058503770168820182==--
