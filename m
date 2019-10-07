Content-Type: multipart/mixed; boundary="===============1430072703115683863=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] move TCP-related commits to the beginning
Date: Mon, 07 Oct 2019 15:39:10 +0200
Message-ID: <5311ceae-841e-2204-0550-176453b39e82@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2030

--===============1430072703115683863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I just did a rebase to have these commits at the top:

  net: Make sock protocol value checks more specific
  sock: Make sk_protocol a 16-bit value
  tcp: Define IPPROTO_MPTCP
  # new # tcp: Add MPTCP option number
  tcp, ulp: Add clone operation to tcp_ulp_ops
  # new # mptcp: Add MPTCP to skb extensions
  tcp: Prevent coalesce/collapse when skb has MPTCP extensions (requires
MPTCP skb extensions)
  tcp: Export low-level TCP functions
  tcp: Check for filled TCP option space before SACK
  tcp: clean ext on tx recycle
  tcp: Expose tcp struct and routine for MPTCP

The work is visible in my repo, branch "rebase-net-tcp-first"

https://github.com/matttbe/mptcp_net-next/commits/rebase-net-tcp-first

Here is the new order:

ac0ee9246e87 net: Make sock protocol value checks more specific
62ea284edd7e sock: Make sk_protocol a 16-bit value
62f49d1713cd tcp: Define IPPROTO_MPTCP
4897684a3794 tcp: Add MPTCP option number
497c810b48ad tcp, ulp: Add clone operation to tcp_ulp_ops
8d38f78f68e0 mptcp: Add MPTCP to skb extensions
e71e2810b8de tcp: Prevent coalesce/collapse when skb has MPTCP extensions
a341f52a58d9 tcp: Export low-level TCP functions
f77bcc800d76 tcp: Check for filled TCP option space before SACK
20fe333f058b tcp: clean ext on tx recycle
6c20bbf7fd48 tcp: Expose tcp struct and routine for MPTCP
83f671162941 mptcp: Add MPTCP socket stubs
c51eb8f5898a mptcp: Handle MPTCP TCP options
4dc03ca8e947 mptcp: Associate MPTCP context with TCP socket
4c208a048fe1 mptcp: Handle MP_CAPABLE options for outgoing connections
c6a16a92d620 mptcp: add mptcp_poll
b4e7e8423e10 mptcp: Create SUBFLOW socket for incoming connections
7a392ff80b6e mptcp: Add key generation and token tree
df0d374fce8c mptcp: Add shutdown() socket operation
92ec7f781536 mptcp: Add setsockopt()/getsockopt() socket operations
dde2a56add38 mptcp: Write MPTCP DSS headers to outgoing data packets
50da2ff90d38 mptcp: Implement MPTCP receive path
2e5d9249a612 mptcp: use sk_page_frag() in sendmsg
71e3c5425dd5 mptcp: sendmsg() do spool all the provided data
17a875f7d2da mptcp: allow collapsing consecutive sendpages on the same
substream
03ebbf9b8b16 mptcp: Add path manager interface
a7960fdb3eee mptcp: Add ADD_ADDR handling
3518ae0b4f00 mptcp: Add handling of incoming MP_JOIN requests
3bf4d9b9fec6 mptcp: harmonize locking on all socket operations.
b9993fcfb4e2 mptcp: new sysctl to control the activation per NS
7c481ffdc7c9 mptcp: add basic kselftest for mptcp
268c2a3744c3 mptcp: Add handling of outgoing MP_JOIN requests
ae6f7b5628ed mptcp: Implement path manager interface commands
28b2727556c8 mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue
547e3d1e878d mptcp: update per unacked sequence on pkt reception
9a9abd186272 mptcp: queue data for mptcp level retransmission
c6c0172a3db5 mptcp: introduce MPTCP retransmission timer
79fd45ef6a7b mptcp: implement memory accounting for mptcp rtx queue
ebe996148315 mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
37e551284043 mptcp: implement and use MPTCP-level retransmission
ac97373b2fba mptcp: allow dumping subflow context to userspace
8f991f422f4c mptcp: add MIB counter infrastructure
966eb30045b9 mptcp: increment MIB counters in a few places

The biggest change is in:

    8d38f78f68e0 mptcp: Add MPTCP to skb extensions

This commit now introduces include/net/mptcp.h. The modifications in
net/mptcp/Kconfig file is now done in:

    83f671162941 mptcp: Add MPTCP socket stubs

(select SKB_EXTENSIONS)

At the end, everything is the same, with a small fix to have all exposed
functions related to "_options" together:


$ diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0f28bf05d7f5..8b0d062912d2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -71,13 +71,13 @@ bool mptcp_established_options(struct sock *sk,
struct sk_buff *skb,
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
                            struct tcp_options_received *opt_rx);

+void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
+
 static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
 {
        return skb_ext_exist(skb, SKB_EXT_MPTCP);
 }

-void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
-
 bool mptcp_sk_is_subflow(const struct sock *sk);

 void mptcp_seq_show(struct seq_file *seq);


Last thing to share: I checked that each commit can still compile with
and without CONFIG_MPTCP:

   git rebase -i --exec "./.compile.sh" net-next


Tell me if it is OK for you and if I can replace the current tree with
these commits.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1430072703115683863==--
