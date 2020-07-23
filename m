Content-Type: multipart/mixed; boundary="===============8414792325332207060=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/8] mptcp: avoid data corruption on reinsert
Date: Thu, 23 Jul 2020 13:02:30 +0200
Message-ID: <4fe02ca627f96087f521a2015d63d8f0c92a4440.1595431326.git.pabeni@redhat.com>
In-Reply-To: cover.1595431326.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5232

--===============8414792325332207060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When updating a partially acked data fragment, we
actually corrupt it. This is irrelevant till we send
data on a single subflow, as retransmitted data, if
any are discarded by the peer as duplicate, but it
will cause data corruption as soon as we will start
creating non backup subflows.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Tested-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 59c0eef807b3..254e6ef2b4e0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -460,15 +460,20 @@ static void mptcp_clean_una(struct sock *sk)
 =

 	dfrag =3D mptcp_rtx_head(sk);
 	if (dfrag && after64(snd_una, dfrag->data_seq)) {
-		u64 delta =3D dfrag->data_seq + dfrag->data_len - snd_una;
+		u64 delta =3D snd_una - dfrag->data_seq;
+
+		if (WARN_ON_ONCE(delta > dfrag->data_len))
+			goto out;
 =

 		dfrag->data_seq +=3D delta;
+		dfrag->offset +=3D delta;
 		dfrag->data_len -=3D delta;
 =

 		dfrag_uncharge(sk, delta);
 		cleaned =3D true;
 	}
 =

+out:
 	if (cleaned) {
 		sk_mem_reclaim_partial(sk);
 =

-- =

2.26.2

--===============8414792325332207060==--
