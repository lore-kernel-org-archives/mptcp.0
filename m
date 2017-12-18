Content-Type: multipart/mixed; boundary="===============4696750873410983199=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC final 03/14] tcp: Allow tcp_fast_parse_options to drop
 segments
Date: Sun, 17 Dec 2017 22:42:34 -0800
Message-ID: <20171218064245.94150-4-cpaasch@apple.com>
In-Reply-To: 20171218064245.94150-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 280

--===============4696750873410983199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After parsing the TCP-options, some option-kinds might trigger a drop of
the segment (e.g., as is the case for TCP_MD5). As we are moving to
consolidate the TCP_MD5-code in follow-up patches, we need to add the
capability to drop a segment right after parsing the options in
tcp_fast_parse_options().

Originally, tcp_fast_parse_options() returned false, when there is no
timestamp option, except in the case of the slow-path processing through
tcp_parse_options() where it always returns true.

So, the return-value of tcp_fast_parse_options() was kind of
inconsistent. With this patch, we make it return true when the segment
should get dropped based on the parsed options, and false otherwise.

In tcp_validate_incoming, we will then just check for
tp->rx_opt.saw_tstamp to see if we should verify PAWS.

The goto will be used in a follow-up patch to check whether one of the
options triggers a drop of the segment.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/ipv4/tcp_input.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4d55c4b338ee..eb97ee24c601 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3827,6 +3827,8 @@ static bool tcp_parse_aligned_timestamp(struct tcp_so=
ck *tp, const struct tcphdr
 =

 /* Fast parse options. This hopes to only see timestamps.
  * If it is wrong it falls back on tcp_parse_options().
+ *
+ * Returns true if we should drop this packet based on present TCP-options.
  */
 static bool tcp_fast_parse_options(const struct net *net,
 				   const struct sk_buff *skb,
@@ -3837,18 +3839,19 @@ static bool tcp_fast_parse_options(const struct net=
 *net,
 	 */
 	if (th->doff =3D=3D (sizeof(*th) / 4)) {
 		tp->rx_opt.saw_tstamp =3D 0;
-		return false;
+		goto extra_opt_check;
 	} else if (tp->rx_opt.tstamp_ok &&
 		   th->doff =3D=3D ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4)) {
 		if (tcp_parse_aligned_timestamp(tp, th))
-			return true;
+			goto extra_opt_check;
 	}
 =

 	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
 =

-	return true;
+extra_opt_check:
+	return false;
 }
 =

 #ifdef CONFIG_TCP_MD5SIG
@@ -5168,9 +5171,11 @@ static bool tcp_validate_incoming(struct sock *sk, s=
truct sk_buff *skb,
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	bool rst_seq_match =3D false;
 =

+	if (tcp_fast_parse_options(sock_net(sk), skb, th, tp))
+		goto discard;
+
 	/* RFC1323: H1. Apply PAWS check first. */
-	if (tcp_fast_parse_options(sock_net(sk), skb, th, tp) &&
-	    tp->rx_opt.saw_tstamp &&
+	if (tp->rx_opt.saw_tstamp &&
 	    tcp_paws_discard(sk, skb)) {
 		if (!th->rst) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
-- =

2.15.0


--===============4696750873410983199==--
