Content-Type: multipart/mixed; boundary="===============0653661158118172144=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 3/7] mptcp: avoid blocking in
 tcp_sendpages due to skb alloc
Date: Thu, 07 May 2020 16:33:48 +0200
Message-ID: <20200507143348.GO32392@breakpoint.cc>
In-Reply-To: ded361991210fd296fdd471d2a5dafa2da785163.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4340

--===============0653661158118172144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Ok, I missed/forgot that the retransmission must be non blocking.
> =

> I now see that retransmissions are fine as is!
> =

> Still on this, don't we need to check mptcp_sendmsg_alloc_skb() inside
> the sendmsg() loop, too? Elsewhere we could fail on large send if we
> complete the first skb, keep looping in sendmsg() and the next
> iteration would block. Am I missing something?

You mean:

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 780d873b6c19..66a67b11d01b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -814,6 +814,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
                if (!tx_ok)
                        break;
                if (!sk_stream_memory_free(ssk) ||
+                   !mptcp_sendmsg_alloc_skb(ssk) ||
                    !mptcp_page_frag_refill(ssk, pfrag) ||
                    !mptcp_ext_cache_refill(msk)) {
                        tcp_push(ssk, msg->msg_flags, mss_now,

?

Yes, that could be added.  Its not a huge deal since mptcp_sendmsg_frag() w=
ould
yield -EAGAIN if do_tcp_sendpages would block, and that will then re-start =
for
the 'blocking io' case (i.e., ssk is released and 'goto restart' fetches ne=
xt
ssk with posssible wait_for_memory).
--===============0653661158118172144==--
