Content-Type: multipart/mixed; boundary="===============5468921488254808904=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] fix for most poll selftest timeouts
Date: Sat, 29 Aug 2020 22:10:37 +0200
Message-ID: <20200829201037.GH7319@breakpoint.cc>
X-Status: 
X-Keywords:                  
X-UID: 5667

--===============5468921488254808904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Turns out that almost all of the 'poll timeout' test failures are related
to subflow->writable getting stale.  Its false even though the subflow is
writeable, i.e. userspace is not woken up after socket can accept new data.

Rather than fixing the race that leads to the information becoming stale
Paolo suggested to just remove the 'writable' caching.
I've done this by editing the commit that introduced it
("mptcp: rethink 'is writable' conditional").

While doing so I also squashed sk_stream_is_writeable() and removed
"mptcp: fix stale subflow->writeable caching" as its obsolete by the
removal of this struct member.

Only remaining occurence of poll timeouts seem to be related to
mptcp-level fin not being delivered/processed, investigation is ongoing.

I've pushed the resulting branch here:
https://git.breakpoint.cc/cgit/fw/mptcp_net-next.git/log/?h=3Dexport_rebase=
_5

which can also be pulled via
git://git.breakpoint.cc/fw/mptcp_net-next.git export_rebase_5

Alternatively, edit "mptcp: rethink 'is writable' conditional" and remove
"bool writable" from mptcp_subflow_ctx struct, then fix up the resulting
merge conflicts.

After this mmap tests still pass and it takes about 50 normal poll
self-test runs before the first timeout is seen, on average.
(before change, its less than 10).

Expected delta to current export branch is:

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -787,7 +787,7 @@ static bool mptcp_is_writeable(struct mptcp_sock *msk)
 		return false;
 =

 	mptcp_for_each_subflow(msk, subflow) {
-		if (READ_ONCE(subflow->writable))
+		if (sk_stream_is_writeable(subflow->tcp_sock))
 			return true;
 	}
 	return false;
@@ -1121,7 +1121,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 		if (next_backup || next_ssk)
 			continue;
 =

-		free =3D READ_ONCE(subflow->writable);
+		free =3D sk_stream_is_writeable(subflow->tcp_sock);
 		if (!free)
 			continue;
 =

@@ -1237,8 +1237,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	lock_sock(ssk);
 	tx_ok =3D msg_data_left(msg);
 	while (tx_ok) {
-		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
-
 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
 					 &size_goal);
 		if (ret < 0) {
@@ -1256,14 +1254,11 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 		msk->snd_burst -=3D ret;
 		copied +=3D ret;
 =

-		if (!sk_stream_is_writeable(ssk))
-			WRITE_ONCE(subflow->writable, false);
-
 		tx_ok =3D msg_data_left(msg);
 		if (!tx_ok)
 			break;
 =

-		if (!subflow->writable ||
+		if (!sk_stream_memory_free(ssk) ||
 		    !mptcp_page_frag_refill(ssk, pfrag) ||
 		    !mptcp_ext_cache_refill(msk)) {
 			tcp_push(ssk, msg->msg_flags, mss_now,
@@ -1311,9 +1306,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		/* start the timer, if it's not pending */
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
-
-		if (!sk_stream_is_writeable(ssk))
-			WRITE_ONCE(mptcp_subflow_ctx(ssk)->writable, false);
 	}
 =

 	release_sock(ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -311,7 +311,6 @@ struct mptcp_subflow_context {
 		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
 		can_ack : 1;	    /* only after processing the remote a key */
 	enum mptcp_data_avail data_avail;
-	bool	writable;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -977,7 +977,6 @@ static void subflow_write_space(struct sock *sk)
 	if (!sk_stream_is_writeable(sk))
 		return;
 =

-	WRITE_ONCE(subflow->writable, true);
 	if (sk_stream_is_writeable(parent)) {
 		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
 		smp_mb__after_atomic();
@@ -1206,7 +1205,6 @@ static struct mptcp_subflow_context *subflow_create_c=
tx(struct sock *sk,
 =

 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	INIT_LIST_HEAD(&ctx->node);
-	WRITE_ONCE(ctx->writable, true);
 =

 	pr_debug("subflow=3D%p", ctx);
 =

-- =

Florian Westphal <fw(a)strlen.de>
4096R/AD5FF600  2015-09-13
Key fingerprint =3D 80A9 20C5 B203 E069 F586  AE9F 7091 A8D9 AD5F F600
Phone: +49 151 11132303
--===============5468921488254808904==--
