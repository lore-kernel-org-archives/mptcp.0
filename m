Content-Type: multipart/mixed; boundary="===============2503629941462552299=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] squashing of "subflow: place further subflows on new
 'join_list'"
Date: Fri, 20 Mar 2020 18:00:33 +0100
Message-ID: <5572aff38090b31c297aa943e24890b4eb317f64.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4022

--===============2503629941462552299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

A tree with the above patch squashed is available at:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_13

(It also contains the mib patches squashing)

Difference from current export is:
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 13767d0ba572..9870243acbcb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1071,7 +1071,6 @@ static void mptcp_worker(struct work_struct *work)
 	long timeo =3D 0;
 =

 	lock_sock(sk);
-	__mptcp_flush_join_list(msk);
 	mptcp_clean_una(sk);
 	__mptcp_move_skbs(msk);
 =

@@ -1085,6 +1084,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (!dfrag)
 		goto unlock;
 =

+	__mptcp_flush_join_list(msk);
 	ssk =3D mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		goto reset_unlock;
---

Which is intentional, we likely want to try fetching data from the
join_list subflows, too.

I can post a squash-to patches if that is preferable.

/P

--===============2503629941462552299==--
