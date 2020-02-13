Content-Type: multipart/mixed; boundary="===============5563560029563605208=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 1/5] mptcp: perform mptcp ack update during read
 operations
Date: Thu, 13 Feb 2020 11:27:38 +0100
Message-ID: <20200213102742.18937-2-fw@strlen.de>
In-Reply-To: 20200213102742.18937-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3644

--===============5563560029563605208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tcp_read_sock() will drain the receive queue, i.e. it frees memory.
Therefore, at the end of the function it can generate ACKs to open
up the tcp receive window.

Unfortunately, the MPTCP ack sequence was updated later, i.e. those
ACKs carry an outdated mptcp ack sequence.

This isn't a bug per se, but we can improve this and update the
mptcp ack in the read actor callback, thus allowing the acks sent
by tcp_read_sock() to include the most recent mptcp ack sequence.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/protocol.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1f405b812243..f68ee86376f0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -608,6 +608,8 @@ int mptcp_read_actor(read_descriptor_t *desc, struct sk=
_buff *skb,
 			desc->error =3D err;
 			return err;
 		}
+
+		arg->msk->ack_seq +=3D copy_len;
 	} else {
 		pr_debug("Flushing skb payload");
 	}
@@ -664,6 +666,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	}
 =

 	arg.msg =3D msg;
+	arg.msk =3D msk;
 	desc.arg.data =3D &arg;
 	desc.error =3D 0;
 =

@@ -704,7 +707,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 =

 			pr_debug("msk ack_seq=3D%llx -> %llx", msk->ack_seq,
 				 msk->ack_seq + bytes_read);
-			msk->ack_seq +=3D bytes_read;
 			copied +=3D bytes_read;
 			if (copied >=3D len) {
 				done =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3fbb33deb764..06a57bf6d5f0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -305,6 +305,7 @@ int mptcp_proto_v6_init(void);
 =

 struct mptcp_read_arg {
 	struct msghdr *msg;
+	struct mptcp_sock *msk;
 };
 =

 int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
-- =

2.24.1

--===============5563560029563605208==--
