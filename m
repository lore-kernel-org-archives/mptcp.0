Content-Type: multipart/mixed; boundary="===============3096981202338745323=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] move TCP-related commits to the beginning
Date: Mon, 07 Oct 2019 16:11:53 +0200
Message-ID: <20191007141153.GK13866@breakpoint.cc>
In-Reply-To: 5311ceae-841e-2204-0550-176453b39e82@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2031

--===============3096981202338745323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> Hi,
> =

> I just did a rebase to have these commits at the top:
> =

>   net: Make sock protocol value checks more specific
>   sock: Make sk_protocol a 16-bit value
>   tcp: Define IPPROTO_MPTCP
>   # new # tcp: Add MPTCP option number
>   tcp, ulp: Add clone operation to tcp_ulp_ops
>   # new # mptcp: Add MPTCP to skb extensions
>   tcp: Prevent coalesce/collapse when skb has MPTCP extensions (requires
> MPTCP skb extensions)
>   tcp: Export low-level TCP functions
>   tcp: Check for filled TCP option space before SACK
>   tcp: clean ext on tx recycle
>   tcp: Expose tcp struct and routine for MPTCP
> =

> The work is visible in my repo, branch "rebase-net-tcp-first"

Thanks.  A few comments related to squashing and code-churn reduction
below:

> Here is the new order:
> =

> ac0ee9246e87 net: Make sock protocol value checks more specific
> 62ea284edd7e sock: Make sk_protocol a 16-bit value
> 62f49d1713cd tcp: Define IPPROTO_MPTCP
> 4897684a3794 tcp: Add MPTCP option number
> 497c810b48ad tcp, ulp: Add clone operation to tcp_ulp_ops
> 8d38f78f68e0 mptcp: Add MPTCP to skb extensions
> e71e2810b8de tcp: Prevent coalesce/collapse when skb has MPTCP extensions
> a341f52a58d9 tcp: Export low-level TCP functions
> f77bcc800d76 tcp: Check for filled TCP option space before SACK

LGTM, thanks!

> 20fe333f058b tcp: clean ext on tx recycle

Can you squash this small patch into this one?
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4099,14 +4099,6 @@ static inline void skb_ext_put(struct sk_buff *skb)
 		__skb_ext_put(skb->extensions);
 }
 =

-static inline void skb_ext_clear(struct sk_buff *skb)
-{
-	if (skb->active_extensions) {
-		__skb_ext_put(skb->extensions);
-		skb->active_extensions =3D 0;
-	}
-}
-
 static inline void __skb_ext_copy(struct sk_buff *dst,
 				  const struct sk_buff *src)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index 97ad8c62af1d..84ea0efe7952 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1470,7 +1470,7 @@ static inline void sk_wmem_free_skb(struct sock *sk, =
struct sk_buff *skb)
 	sk_mem_uncharge(sk, skb->truesize);
 	if (static_branch_unlikely(&tcp_tx_skb_cache_key) &&
 	    !sk->sk_tx_skb_cache && !skb_cloned(skb)) {
-		skb_ext_clear(skb);
+		skb_ext_reset(skb);
 		skb_zcopy_clear(skb, true);
 		sk->sk_tx_skb_cache =3D skb;
 		return;

... this turns 'tcp: clean ext on tx recycle' into a one-line change.

> dde2a56add38 mptcp: Write MPTCP DSS headers to outgoing data packets

This patch adds

#define MPTCP_DSS_DATA_FIN     BIT(4)

and others to include/net/mptcp.h

> 50da2ff90d38 mptcp: Implement MPTCP receive path

... then this patch moves them to net/mptcp/protocol.h.

it would be better to already place them in protocol.h in the
previous patch.

> 8f991f422f4c mptcp: add MIB counter infrastructure

If we place this early in the series, then

> 966eb30045b9 mptcp: increment MIB counters in a few places

... could be folded into the patches that add those code paths.

Perhaps right after 'mptcp: Add MPTCP socket stubs'?

Could also be squashed, I do not mind.  Just a suggestion.
--===============3096981202338745323==--
