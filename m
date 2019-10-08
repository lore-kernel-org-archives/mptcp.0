Content-Type: multipart/mixed; boundary="===============7342106721972976338=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Yet another rebase/squash/cleanup proposal
Date: Tue, 08 Oct 2019 16:48:27 +0200
Message-ID: <20191008144827.GA12731@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2050

--===============7342106721972976338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi.

Here is yet another rebase proposal, I've pushed it here:
https://git.breakpoint.cc/cgit/fw/mptcp-next.git/log/?h=3Dexport_sendmsg_re=
base_13

Its also accessible via
git fetch git://git.breakpoint.cc/fw/mptcp-next.git export_sendmsg_rebase_13

In short:
- folds two commits
- fixes the kbuild warnings we got with rfcv2
- gets rid of refcounting in mptcp_subflow_get_ref

A full diff between export and this new branch is below.

I have no more suggestions for rebases/squashes with the current patches
we have.

Here is a walkthrough of those patches that have been altered and
a changelog:

mptcp: Add MPTCP to skb extensions
  ... gains a #include linux/types.h
  I added this include because the header uses u16, u64 and so on.
  Without this, one can see

  include/net/mptcp.h:13:2: error: unknown type name 'u16'

  error when HEADER_TEST is enabled in .config.

tcp: Prevent coalesce/collapse when skb has MPTCP extensions

  adds skbuff.h include to avoid:
  include/net/mptcp.h:36:53: warning: 'struct sk_buff' declared inside para=
meter list will not be visible outside of this definition or declaration

mptcp: Add MPTCP socket stubs:

  adds ...
+       if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
+               return -EOPNOTSUPP;

 It makes sense to do it here as part of the boilerplate change.

 The current export branch did this check after lock_sock, so we also avoid
 the exta unlock if we test the flags first.

mptcp: Handle MPTCP TCP options

  adds linux/tcp.h include to avoid
 'struct tcp_options_received' declared inside parameter list... warning.

  While a forward declaration is enough, followup patches add more
  warnings such as

  struct sock' declared inside parameter list ..

  As we later use tcp_sk() helper here anyway, just add such include now.

mptcp: Handle MP_CAPABLE options for outgoing.
  In tcp_output.c, 'opt_size' is now inited to 0 to avoid changing
  this line in a followup patch, i.e. this change isn't visible in the
  final diff.

  The major change in this patch however is
  mptcp_subflow_get_ref -> mptcp_subflow_get.

  This helper will not increment sk reference count anymore.
  As Paolo pointed out, the mptcp socket lock is held in all cases (we even
  have an assertion inside the helper already) and we never keep the ssk
  around after we've released the ssk lock.  So, simplify this:

  no sock_hold, no more sock_put(ssk).

This results in several followup changes because of this, e.g.
in mptcp: Create SUBFLOW socket for incoming connections

... to account for the changed name and dropping sock_put(ssk).

mptcp: Write MPTCP DSS headers to outgoing data packets

  ... now folds both
  mptcp: use sk_page_frag() in sendmsg and
  mptcp: sendmsg() do spool all the provided data
  ... with only a *tiny* increase in patch size.

  Old was: 257 inserts, 12 deletions
  After:   267 inserts, 11 deletions

  I think thats a pretty good hint that the squashing is good
  and reduces code churn (addition of code in patch x only to remove
  it in y).  I've modified the commit message to mention this folding.

The only other change is a 'seq_file' forward declaration in the MIB
skeleton patch, again because of a kbuild robot report:

'warning: 'struct seq_file' declared inside parameter list will not be visi=
ble
outside of this definition or declaration'.

mib.c has the needed seq_file.h include, so adding a forward declaration is
enough to silence gcc for other .c files that include mptcp.h.

Full diff of current export (ab35f6c5d8e3ed7a3c9603028d3b67c931af51b0)
and this branch:

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b0d062912d2..eba39a881767 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -8,6 +8,12 @@
 #ifndef __NET_MPTCP_H
 #define __NET_MPTCP_H
 =

+#include <linux/skbuff.h>
+#include <linux/tcp.h>
+#include <linux/types.h>
+
+struct seq_file;
+
 /* MPTCP sk_buff extension data */
 struct mptcp_ext {
 	u64		data_ack;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 14543aaa29bd..272fe90adfbb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -79,18 +79,14 @@ static struct socket *mptcp_fallback_get_ref(const stru=
ct mptcp_sock *msk)
 	return ssock;
 }
 =

-static struct sock *mptcp_subflow_get_ref(const struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get(const struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 =

 	sock_owned_by_me((const struct sock *)msk);
 =

 	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *sk;
-
-		sk =3D mptcp_subflow_tcp_socket(subflow)->sk;
-		sock_hold(sk);
-		return sk;
+		return mptcp_subflow_tcp_socket(subflow)->sk;
 	}
 =

 	return NULL;
@@ -336,7 +332,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	struct sock *ssk;
 	long timeo;
 =

-	pr_debug("msk=3D%p", msk);
+	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
+		return -EOPNOTSUPP;
+
 	lock_sock(sk);
 	ssock =3D __mptcp_fallback_get_ref(msk);
 	if (ssock) {
@@ -347,7 +345,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		return ret;
 	}
 =

-	ssk =3D mptcp_subflow_get_ref(msk);
+	ssk =3D mptcp_subflow_get(msk);
 	if (!ssk) {
 		release_sock(sk);
 		return -ENOTCONN;
@@ -356,16 +354,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	if (!msg_data_left(msg)) {
 		pr_debug("empty send");
 		ret =3D sock_sendmsg(ssk->sk_socket, msg);
-		goto put_out;
+		goto out;
 	}
 =

 	pr_debug("conn_list->subflow=3D%p", ssk);
 =

-	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL)) {
-		ret =3D -ENOTSUPP;
-		goto put_out;
-	}
-
 	lock_sock(ssk);
 	mptcp_clean_una(sk);
 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
@@ -391,9 +384,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 =

 	release_sock(ssk);
 =

-put_out:
+out:
 	release_sock(sk);
-	sock_put(ssk);
 	return ret;
 }
 =

@@ -588,7 +580,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		return copied;
 	}
 =

-	ssk =3D mptcp_subflow_get_ref(msk);
+	ssk =3D mptcp_subflow_get(msk);
 	if (!ssk) {
 		release_sock(sk);
 		return -ENOTCONN;
@@ -752,8 +744,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	release_sock(ssk);
 	release_sock(sk);
 =

-	sock_put(ssk);
-
 	return copied;
 }
 =

@@ -808,7 +798,7 @@ static void mptcp_retransmit(struct work_struct *work)
 	if (!dfrag)
 		goto unlock;
 =

-	ssk =3D mptcp_subflow_get_ref(msk);
+	ssk =3D mptcp_subflow_get(msk);
 	if (!ssk)
 		goto reset_unlock;
 =

@@ -838,7 +828,6 @@ static void mptcp_retransmit(struct work_struct *work)
 =

 	mptcp_set_timeout(sk, ssk);
 	release_sock(ssk);
-	sock_put(ssk);
 =

 reset_unlock:
 	if (!mptcp_timer_pending(sk))
@@ -1010,7 +999,6 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 =

 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
 		local_bh_enable();
-
 		inet_sk_state_store(newsk, TCP_ESTABLISHED);
 		release_sock(sk);
 	} else {
@@ -1326,7 +1314,7 @@ static int mptcp_getname(struct socket *sock, struct =
sockaddr *uaddr,
 	 * is connected and there are multiple subflows is not defined.
 	 * For now just use the first subflow on the list.
 	 */
-	ssk =3D mptcp_subflow_get_ref(msk);
+	ssk =3D mptcp_subflow_get(msk);
 	if (!ssk) {
 		release_sock(sock->sk);
 		return -ENOTCONN;
@@ -1334,7 +1322,6 @@ static int mptcp_getname(struct socket *sock, struct =
sockaddr *uaddr,
 =

 	ret =3D inet_getname(ssk->sk_socket, uaddr, peer);
 	release_sock(sock->sk);
-	sock_put(ssk);
 	return ret;
 }
=20
--===============7342106721972976338==--
