Content-Type: multipart/mixed; boundary="===============3075454776118173911=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 2/4] options: ignore mptcp-level ack that is
 ahead of write_seq
Date: Tue, 05 Nov 2019 18:05:29 +0100
Message-ID: <20191105170531.30407-3-fw@strlen.de>
In-Reply-To: 20191105170531.30407-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2395

--===============3075454776118173911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We should not allow a peer to ack data that we haven't even sent yet,
so test incoming una vs. write_seq.

squashto:  mptcp: update per unacked sequence on pkt reception

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1b08e1193991..80dbe7662cea 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -566,12 +566,18 @@ static void update_una(struct mptcp_sock *msk,
 		       struct mptcp_options_received *mp_opt)
 {
 	u64 new_snd_una, snd_una, old_snd_una =3D atomic64_read(&msk->snd_una);
+	u64 write_seq =3D READ_ONCE(msk->write_seq);
 =

 	/* avoid ack expansion on update conflict, to reduce the risk of
 	 * wrongly expanding to a future ack sequence number, which is way
 	 * more dangerous than missing an ack
 	 */
 	new_snd_una =3D expand_ack(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
+
+	/* ACK for data not even sent yet? Ignore. */
+	if (after64(new_snd_una, write_seq))
+		new_snd_una =3D old_snd_una;
+
 	while (after64(new_snd_una, old_snd_una)) {
 		snd_una =3D old_snd_una;
 		old_snd_una =3D atomic64_cmpxchg(&msk->snd_una, snd_una,
-- =

2.23.0

--===============3075454776118173911==--
