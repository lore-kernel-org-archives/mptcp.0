Content-Type: multipart/mixed; boundary="===============2450494179197354136=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: free acked data before waiting for
 more memory
Date: Fri, 21 Aug 2020 15:39:10 +0200
Message-ID: <20200821133910.6599-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 5591

--===============2450494179197354136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After subflow lock is dropped, more wmem might have been made available.

This fixes a deadlock in mptcp_connect.sh 'mmap' mode: wmem is exhausted.
But as the mptcp socket holds on to already-acked data (for retransmit)
no wakeup will occur.

Using 'goto restart' calls mptcp_clean_una(sk) which will free pages
that have been acked completely in the mean time.

Fixes: fb529e62d3f3 ("mptcp: break and restart in case mptcp sndbuf is full=
")
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 I suspect Paolos recent sndbuf tracking changes made this bug trigger more
 frequently. Afaics net-next is just more lucky so it might make sense to
 pass this via net-next.  Let me know.

 net/mptcp/protocol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bd02c568c4b9..ad91f4588216 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1178,7 +1178,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		goto out;
 	}
 =

-wait_for_sndbuf:
 	__mptcp_flush_join_list(msk);
 	ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
 	while (!sk_stream_memory_free(sk) ||
@@ -1282,7 +1281,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 				 */
 				mptcp_set_timeout(sk, ssk);
 				release_sock(ssk);
-				goto wait_for_sndbuf;
+				goto restart;
 			}
 		}
 	}
-- =

2.26.2

--===============2450494179197354136==--
