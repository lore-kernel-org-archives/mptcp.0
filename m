Content-Type: multipart/mixed; boundary="===============5503031079254107950=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC] net: mptcp: improve fallback after successful
 3-way-handshake
Date: Tue, 21 Apr 2020 19:42:34 +0200
Message-ID: <8e5fcbd2e3c6fbf90f6d836fa82de2ceed3298e2.1587490709.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4214

--===============5503031079254107950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Davide Caratti <dcaratti(a)nst.lab.eng.brq.redhat.com>

a socket can receive data without a DSS option after MP_CAPABLE exchange
in the three way handshake. In this case, it must fall-back to normal
TCP in accordance to RFC8684 =C2=A73.7. In addition, fall-back to TCP must
occur if the peer sends data with a DSS option with zero DLL (so-called
"infinite mapping"). In case a server needs to fallback and msk->subflow
is NULL, msk->first can be used for send/receive operations.

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/protocol.c | 20 +++++++++++++++++++-
 net/mptcp/subflow.c  | 18 ++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 457655ea875b..045aacb68e13 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -736,6 +736,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 		pr_debug("fallback passthrough");
 		ret =3D sock_sendmsg(ssock, msg);
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
+	} else if (__mptcp_needs_tcp_fallback(msk)) {
+		ssk =3D msk->first;
+		release_sock((struct sock *)msk);
+		pr_debug("msk->first passthrough");
+		ret =3D ssk->sk_prot->sendmsg(ssk, msg, len);
+		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
 =

 	mptcp_clean_una(sk);
@@ -899,6 +905,14 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 			 mptcp_subflow_ctx(ssock->sk));
 		copied =3D sock_recvmsg(ssock, msg, flags);
 		return copied;
+	} else if (__mptcp_needs_tcp_fallback(msk)) {
+use_mskfirst:
+		pr_debug("fallback-read using msk->first");
+		sk =3D msk->first;
+		release_sock((struct sock *)msk);
+		copied =3D sk->sk_prot->recvmsg(sk, msg, len, nonblock, flags,
+					      addr_len);
+		return copied;
 	}
 =

 	timeo =3D sock_rcvtimeo(sk, nonblock);
@@ -963,8 +977,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 =

 		pr_debug("block timeout %ld", timeo);
 		mptcp_wait_data(sk, &timeo);
-		if (unlikely(__mptcp_tcp_fallback(msk)))
+		if (unlikely(__mptcp_tcp_fallback(msk))) {
+			ssock =3D __mptcp_tcp_fallback(msk);
+			if (!ssock)
+				goto use_mskfirst;
 			goto fallback;
+		}
 	}
 =

 	if (skb_queue_empty(&sk->sk_receive_queue)) {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 47f901b712f9..460288c1c8ff 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -460,7 +460,8 @@ enum mapping_status {
 	MAPPING_OK,
 	MAPPING_INVALID,
 	MAPPING_EMPTY,
-	MAPPING_DATA_FIN
+	MAPPING_DATA_FIN,
+	MAPPING_INFINITE
 };
 =

 static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
@@ -540,8 +541,14 @@ static enum mapping_status get_mapping_status(struct s=
ock *ssk)
 			return MAPPING_EMPTY;
 		}
 =

-		if (!subflow->map_valid)
+		if (!subflow->map_valid) {
+			if (!mpext && !subflow->local_id) {
+				pr_debug("no mpext and 0 local id");
+				skb_ext_del(skb, SKB_EXT_MPTCP);
+				return MAPPING_INFINITE;
+			}
 			return MAPPING_INVALID;
+		}
 =

 		goto validate_seq;
 	}
@@ -552,9 +559,8 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 =

 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
-		pr_err("Infinite mapping not handled");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		return MAPPING_INVALID;
+		return subflow->local_id ? MAPPING_INVALID : MAPPING_INFINITE;
 	}
 =

 	if (mpext->data_fin =3D=3D 1) {
@@ -663,6 +669,10 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			ssk->sk_err =3D EBADMSG;
 			goto fatal;
 		}
+		if (status =3D=3D MAPPING_INFINITE) {
+			tcp_sk(ssk)->is_mptcp =3D 0;
+			return false;
+		}
 =

 		if (status !=3D MAPPING_OK)
 			return false;
-- =

2.25.2

--===============5503031079254107950==--
