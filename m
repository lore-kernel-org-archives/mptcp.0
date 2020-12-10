Content-Type: multipart/mixed; boundary="===============7663991625336943267=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash-to: "mptcp: push pending frames
 when subflow has free space"
Date: Thu, 10 Dec 2020 23:32:15 +0100
Message-ID: <c389f95f768ed57163765418c1f1670e08bba8e1.1607639386.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7137

--===============7663991625336943267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

whoops, checking the free space on the wrong sock

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f4e6808691ed..973867f73952 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -881,7 +881,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 =

 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
 	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)) &&
-	    sk_stream_memory_free(sk))
+	    sk_stream_memory_free(ssk))
 		__mptcp_check_push(sk, ssk);
 =

 	if (after64(new_snd_una, old_snd_una)) {
-- =

2.26.2

--===============7663991625336943267==--
