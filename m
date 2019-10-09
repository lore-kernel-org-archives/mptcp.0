Content-Type: multipart/mixed; boundary="===============3106397835533064668=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH kbuild] mptcp: mptcp_page_frag_refill() can be static
Date: Wed, 09 Oct 2019 11:07:13 -0700
Message-ID: <alpine.OSX.2.21.1910091106470.48251@crpeter1-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2080

--===============3106397835533064668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Fixes: c5a81c3da8f6 ("mptcp: queue data for mptcp level retransmission")
Signed-off-by: kbuild test robot <lkp(a)intel.com>
---

Forwarding additional kbuild suggestions that were not sent to everyone.

  protocol.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b49316178994c..986fc441dbbb7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -96,7 +96,7 @@ static void mptcp_clean_una(struct sock *sk)
  /* ensure we get enough memory for the frag hdr, beyond some minimal amou=
nt of
   * data
   */
-bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
+static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfra=
g)
  {
  	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
  					pfrag, sk->sk_allocation)))
--===============3106397835533064668==--
