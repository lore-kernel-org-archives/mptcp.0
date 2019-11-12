Content-Type: multipart/mixed; boundary="===============2431878185073514734=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/4] mptcp: allow partial cleaning of rtx head dfrag
Date: Tue, 12 Nov 2019 15:10:36 +0100
Message-ID: <20191112141038.19213-3-fw@strlen.de>
In-Reply-To: 20191112141038.19213-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2485

--===============2431878185073514734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After adding wmem accouting for the mptcp socket we could get
into a situation where the mptcp socket can't transmit more data,
and mptcp_clean_una doesn't reduce wmem even if snd_una has advanced
because it currently will only remove entire dfrags.

Allow advancing the dfrag head sequence and reduce wmem,
even though this isn't correct (as we can't release the page).

Because we will soon block on mptcp sk in case wmem is too large,
call sk_stream_write_space() in case we reduced the backlog so
userspace task blocked in sendmsg or poll will be woken up.

This isn't an issue if the send buffer is large, but it is when
SO_SNDBUF is used to reduce it to a lower value.

Note we can still get a deadlock for low SO_SNDBUF values in
case both sides of the connection write to the socket: both could
be blocked due to wmem being too small -- and current mptcp stack
will only increment mptcp ack_seq on recv.

This doesn't happen with the selftest as it uses poll() and
will always call recv if there is data to read.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 65f10bb372aa..b93050056195 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -137,13 +137,18 @@ static inline bool mptcp_frag_can_collapse_to(const s=
truct mptcp_sock *msk,
 		df->data_seq + df->data_len =3D=3D msk->write_seq;
 }
 =

+static void dfrag_uncharge(struct sock *sk, int len)
+{
+	sk_mem_uncharge(sk, len);
+	sk_wmem_queued_add(sk, -len);
+}
+
 static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
 {
 	int len =3D dfrag->data_len + dfrag->overhead;
 =

 	list_del(&dfrag->list);
-	sk_mem_uncharge(sk, len);
-	sk_wmem_queued_add(sk, -len);
+	dfrag_uncharge(sk, len);
 	put_page(dfrag->page);
 }
 =

@@ -152,14 +157,31 @@ static void mptcp_clean_una(struct sock *sk)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
 	u64 snd_una =3D atomic64_read(&msk->snd_una);
+	bool cleaned =3D false;
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
 			break;
 =

 		dfrag_clear(sk, dfrag);
+		cleaned =3D true;
+	}
+
+	dfrag =3D mptcp_rtx_head(sk);
+	if (dfrag && after64(snd_una, dfrag->data_seq)) {
+		u64 delta =3D dfrag->data_seq + dfrag->data_len - snd_una;
+
+		dfrag->data_seq +=3D delta;
+		dfrag->data_len -=3D delta;
+
+		dfrag_uncharge(sk, delta);
+		cleaned =3D true;
+	}
+
+	if (cleaned) {
+		sk_mem_reclaim_partial(sk);
+		sk_stream_write_space(sk);
 	}
-	sk_mem_reclaim_partial(sk);
 }
 =

 /* ensure we get enough memory for the frag hdr, beyond some minimal amoun=
t of
-- =

2.23.0

--===============2431878185073514734==--
