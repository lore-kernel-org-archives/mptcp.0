Content-Type: multipart/mixed; boundary="===============7371550403023286978=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/6] mptcp: add and use
 mptcp_subflow_get_retrans
Date: Thu, 17 Oct 2019 16:40:13 +0200
Message-ID: <20191017144013.GX25052@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1910161621460.4400@jodiswax-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2216

--===============7371550403023286978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> =

> On Tue, 15 Oct 2019, Paolo Abeni wrote:
> =

> > On Tue, 2019-10-15 at 14:13 +0200, Florian Westphal wrote:
> > > Rationale for the approach done in patch 5 was that MPTCP-Level retra=
nsmits
> > > are useless in virtually all cases.
> > > =

> > > The retransmit would only be needed in case we sent data on ssk x
> > > but peer went dead after xmit started.
> > =

> > uhmm... I think that it will suffice if peer goes dead after we
> > create/enqueue the skb (mptcp_sendmsg() completes). Could/should happen
> > quite consistently e.g. when the client switches from wifi to 4G, and
> > the flow is almost unidirectional from the server.

Yes, but how often do you expect clients to bounce back and forth
between two paths?

> > > I wanted to make sure we only retransmit on ssks that have no
> > > inflight packets, under the assumption that the dfrag has been acked
> > > by the next time the retransmit timer kicks in.
> =

> That might make it a good idea to not push more new data in to the ssks o=
nce
> MPTCP-level retransmission kicks in? We don't want the subflow buffers
> filled up with new data when the MPTCP socket is trying to retransmit.

What about this?

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -567,6 +567,8 @@ static void update_una(struct mptcp_sock *msk,
 		if (old_snd_una =3D=3D snd_una) {
 			mptcp_reset_timer((struct sock *)msk);
 			break;
+		} else if (test_bit(MPTCP_RETRANS, &msk->flags)) {
+			sk_stream_write_space((struct sock *)msk);
 		}
 	}
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -210,7 +142,7 @@ static void dfrag_clear(struct sock *sk, struct mptcp_d=
ata_frag *dfrag)
 	put_page(dfrag->page);
 }
 =

-static void mptcp_clean_una(struct sock *sk)
+static bool mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
@@ -223,6 +155,8 @@ static void mptcp_clean_una(struct sock *sk)
 		dfrag_clear(sk, dfrag);
 	}
 	sk_mem_reclaim_partial(sk);
+
+	return list_empty(&msk->rtx_queue);
 }
 =

 /* ensure we get enough memory for the frag hdr, beyond some minimal amoun=
t of
@@ -413,6 +347,80 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	return ret;
 }
 =

+/* returns < 0 if a should be preferred to b */
+static int sock_compare(const struct sock *a, const struct sock *b)
+{
+	int cmp =3D inet_csk(a)->icsk_ca_state - inet_csk(b)->icsk_ca_state;
+
+	if (cmp)
+		return cmp;
+
+	cmp =3D tcp_packets_in_flight(tcp_sk(a)) - tcp_packets_in_flight(tcp_sk(b=
));
+	if (cmp)
+		return cmp;
+
+	return 0;
+}
+
+static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	bool non_backup_present =3D false;
+	struct sock *best, *backup;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	backup =3D NULL;
+	best =3D NULL;
+
+	/* don't send new data with ongoing MPTCP retransmit */
+	if (unlikely(test_bit(MPTCP_RETRANS, &msk->flags))) {
+		if (!mptcp_clean_una((void *)msk))
+			return NULL;
+		clear_bit(MPTCP_RETRANS, &msk->flags);
+	}

 [ remaining unchanged ]

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
@@ -687,6 +695,7 @@ static void mptcp_retransmit_handler(struct sock *sk)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	if (atomic64_read(&msk->snd_una) =3D=3D msk->write_seq) {
+		clear_bit(MPTCP_RETRANS, &msk->flags);
 		mptcp_stop_timer(sk);
 	} else {
 		if (schedule_work(&msk->rtx_work))
@@ -783,9 +792,11 @@ static void mptcp_retransmit(struct work_struct *work)
 		dfrag->data_len -=3D ret;
 		dfrag->offset +=3D ret;
 	}
-	if (copied)
+	if (copied) {
+		set_bit(MPTCP_RETRANS, &msk->flags);
 		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
+	}
 =

 	dfrag->data_seq =3D orig_write_seq;
 	dfrag->offset =3D orig_offset;
@@ -1164,6 +1175,12 @@ static bool mptcp_memory_free(const struct sock *sk,=
 int wake)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

+	if (unlikely(test_bit(MPTCP_RETRANS, &msk->flags))) {
+		/* can't clear una here, sk is const */
+		if (atomic64_read(&msk->snd_una) =3D=3D READ_ONCE(msk->write_seq))
+			return true;
+	}
+
 	return test_bit(MPTCP_SEND_SPACE, &msk->flags);
 }
 =

@@ -1348,10 +1365,15 @@ static __poll_t mptcp_poll(struct file *file, struc=
t socket *sock,
 	const struct mptcp_sock *msk;
 	struct sock *sk =3D sock->sk;
 	struct socket *ssock;
+	bool retrans =3D false;
 	__poll_t ret =3D 0;
 =

 	msk =3D mptcp_sk(sk);
 	lock_sock(sk);
+
+	if (test_bit(MPTCP_RETRANS, &msk->flags) && !mptcp_clean_una(sk))
+		retrans =3D true;
+
 	ssock =3D __mptcp_fallback_get_ref(msk);
 	if (ssock) {
 		release_sock(sk);
@@ -1364,9 +1386,14 @@ static __poll_t mptcp_poll(struct file *file, struct=
 socket *sock,
 =

 	mptcp_for_each_subflow(msk, subflow) {
 		struct socket *tcp_sock;
+		int r;
 =

 		tcp_sock =3D mptcp_subflow_tcp_socket(subflow);
-		ret |=3D __tcp_poll(tcp_sock->sk);
+		r =3D __tcp_poll(tcp_sock->sk);
+		if (retrans && (r & (EPOLLOUT|EPOLLWRNORM)))
+			r &=3D ~(EPOLLOUT|EPOLLWRNORM);
+		ret |=3D r;
+
 	}
 	release_sock(sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index db3007ca50a7..768fad073b07 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -77,6 +77,7 @@
 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	BIT(0)
 #define MPTCP_SEND_SPACE	BIT(1)
+#define MPTCP_RETRANS		BIT(2)
 =



------

Main problem is that when MPTCP-level retransmission kicks in, this
blocks writes until snd_una has caught up with mptcp write_seq again.

The use of the MPTCP_RETRANS flag prevents this from occuring
for normal write operations while retrans timer is pending but hasn't
done any actual resends yet.

Might be good enough for now. If not, we will need to track more state,
e.g. the last/highest retransmitted mptcp-sequence number.  It would
allow us to signal a wakeup from mptcp_memory_free() earlier, when the
last 'retransmitted' sequence was acked, rather than the all outstanding
data.

> In the LPC presentation and paper we proposed keeping the scheduler
> extremely simple, with the focus being on the server use case with a limi=
ted
> number of subflows (maybe even just two, allowing for a primary and backu=
p).
> The idea for the first patch set was to focus on MPTCP for failover rather
> than aggregating multiple subflows to maximize throughput.

I agree.

> That could mean simply transmitting on the first available non-backup
> subflow, leaving others on the list idle.

Yes, I can alter the patch accordingly.

> As this email thread shows, there are a lot of potential inputs for makin=
g a
> scheduling decision and there isn't a one-size-fits all scheduling
> algorithm. The multipath-tcp.org kernel handles this with different
> scheduler modules, and we do have configurable schedulers later in the
> roadmap.

I know.  It wasn't my intention do make a scheduler, I wanted to get
the infra ready to block at mptcp level rather than relying on tcp
blocking on first ssk.
--===============7371550403023286978==--
