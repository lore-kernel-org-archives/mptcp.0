Content-Type: multipart/mixed; boundary="===============8769607387180816994=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] move TCP-related commits to the beginning
Date: Mon, 07 Oct 2019 16:45:55 +0200
Message-ID: <7a9e06aa-4078-7d3d-9c64-ecf231dad17d@tessares.net>
In-Reply-To: 20191007141153.GK13866@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2032

--===============8769607387180816994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thank you for the quick review!

On 07/10/2019 16:11, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Hi,
>>
>> I just did a rebase to have these commits at the top:
>>
>>    net: Make sock protocol value checks more specific
>>    sock: Make sk_protocol a 16-bit value
>>    tcp: Define IPPROTO_MPTCP
>>    # new # tcp: Add MPTCP option number
>>    tcp, ulp: Add clone operation to tcp_ulp_ops
>>    # new # mptcp: Add MPTCP to skb extensions
>>    tcp: Prevent coalesce/collapse when skb has MPTCP extensions (requires
>> MPTCP skb extensions)
>>    tcp: Export low-level TCP functions
>>    tcp: Check for filled TCP option space before SACK
>>    tcp: clean ext on tx recycle
>>    tcp: Expose tcp struct and routine for MPTCP
>>
>> The work is visible in my repo, branch "rebase-net-tcp-first"
> =

> Thanks.  A few comments related to squashing and code-churn reduction
> below:
> =

>> Here is the new order:
>>
>> ac0ee9246e87 net: Make sock protocol value checks more specific
>> 62ea284edd7e sock: Make sk_protocol a 16-bit value
>> 62f49d1713cd tcp: Define IPPROTO_MPTCP
>> 4897684a3794 tcp: Add MPTCP option number
>> 497c810b48ad tcp, ulp: Add clone operation to tcp_ulp_ops
>> 8d38f78f68e0 mptcp: Add MPTCP to skb extensions
>> e71e2810b8de tcp: Prevent coalesce/collapse when skb has MPTCP extensions
>> a341f52a58d9 tcp: Export low-level TCP functions
>> f77bcc800d76 tcp: Check for filled TCP option space before SACK
> =

> LGTM, thanks!
> =

>> 20fe333f058b tcp: clean ext on tx recycle
> =

> Can you squash this small patch into this one?
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4099,14 +4099,6 @@ static inline void skb_ext_put(struct sk_buff *skb)
>   		__skb_ext_put(skb->extensions);
>   }
>   =

> -static inline void skb_ext_clear(struct sk_buff *skb)
> -{
> -	if (skb->active_extensions) {
> -		__skb_ext_put(skb->extensions);
> -		skb->active_extensions =3D 0;
> -	}
> -}
> -
>   static inline void __skb_ext_copy(struct sk_buff *dst,
>   				  const struct sk_buff *src)
>   {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 97ad8c62af1d..84ea0efe7952 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1470,7 +1470,7 @@ static inline void sk_wmem_free_skb(struct sock *sk=
, struct sk_buff *skb)
>   	sk_mem_uncharge(sk, skb->truesize);
>   	if (static_branch_unlikely(&tcp_tx_skb_cache_key) &&
>   	    !sk->sk_tx_skb_cache && !skb_cloned(skb)) {
> -		skb_ext_clear(skb);
> +		skb_ext_reset(skb);
>   		skb_zcopy_clear(skb, true);
>   		sk->sk_tx_skb_cache =3D skb;
>   		return;
> =

> ... this turns 'tcp: clean ext on tx recycle' into a one-line change.

Good idea! Just applied this diff and added your signed-off to the patch.

>> dde2a56add38 mptcp: Write MPTCP DSS headers to outgoing data packets
> =

> This patch adds
> =

> #define MPTCP_DSS_DATA_FIN     BIT(4)
> =

> and others to include/net/mptcp.h
> =

>> 50da2ff90d38 mptcp: Implement MPTCP receive path
> =

> ... then this patch moves them to net/mptcp/protocol.h.
> =

> it would be better to already place them in protocol.h in the
> previous patch.

Good catch! Just moved them to net/mptcp/protocol.h

Here is the new refs (pushed in rebase-net-tcp-first-v2 branch) just in =

case someone wants to comment with the new commits.

ac0ee9246e87 net: Make sock protocol value checks more specific
62ea284edd7e sock: Make sk_protocol a 16-bit value
62f49d1713cd tcp: Define IPPROTO_MPTCP
4897684a3794 tcp: Add MPTCP option number
497c810b48ad tcp, ulp: Add clone operation to tcp_ulp_ops
8d38f78f68e0 mptcp: Add MPTCP to skb extensions
e71e2810b8de tcp: Prevent coalesce/collapse when skb has MPTCP extensions
a341f52a58d9 tcp: Export low-level TCP functions
f77bcc800d76 tcp: Check for filled TCP option space before SACK
fb53381dd218 tcp: clean ext on tx recycle
81fd95a12fd0 tcp: Expose tcp struct and routine for MPTCP
56a8a7d8cf27 mptcp: Add MPTCP socket stubs
85b4bf829962 mptcp: Handle MPTCP TCP options
3d9f941e1975 mptcp: Associate MPTCP context with TCP socket
699c0cd5beaa mptcp: Handle MP_CAPABLE options for outgoing connections
ff728beb1bb3 mptcp: add mptcp_poll
f54ef1eb9739 mptcp: Create SUBFLOW socket for incoming connections
7a2be03cc042 mptcp: Add key generation and token tree
56358e799f22 mptcp: Add shutdown() socket operation
46c5a6978ae9 mptcp: Add setsockopt()/getsockopt() socket operations
c1856853e204 mptcp: Write MPTCP DSS headers to outgoing data packets
8ff4c1c4c391 mptcp: Implement MPTCP receive path
7f71a708c8e0 mptcp: use sk_page_frag() in sendmsg
ef698e744e61 mptcp: sendmsg() do spool all the provided data
4d32f2cd8a35 mptcp: allow collapsing consecutive sendpages on the same =

substream
fe20b87caca3 mptcp: Add path manager interface
1b33b4ec3277 mptcp: Add ADD_ADDR handling
0cf4a2738861 mptcp: Add handling of incoming MP_JOIN requests
d4a2a2111fe9 mptcp: harmonize locking on all socket operations.
fe4b85f96742 mptcp: new sysctl to control the activation per NS
133ad374c072 mptcp: add basic kselftest for mptcp
7ad456eb359d mptcp: Add handling of outgoing MP_JOIN requests
64335e3bdcbd mptcp: Implement path manager interface commands
170077363215 mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue
c08ddcfa7b50 mptcp: update per unacked sequence on pkt reception
a0dcd3524ad2 mptcp: queue data for mptcp level retransmission
4d5ed3b0e7ad mptcp: introduce MPTCP retransmission timer
1032786bd03e mptcp: implement memory accounting for mptcp rtx queue
179d8e49880d mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
ca1f24e19a1e mptcp: implement and use MPTCP-level retransmission
ac8935fe70e4 mptcp: allow dumping subflow context to userspace
d88ddbcddcd5 mptcp: add MIB counter infrastructure
c5716a92dc7e mptcp: increment MIB counters in a few places

>> 8f991f422f4c mptcp: add MIB counter infrastructure
> =

> If we place this early in the series, then
> =

>> 966eb30045b9 mptcp: increment MIB counters in a few places
> =

> ... could be folded into the patches that add those code paths.
> =

> Perhaps right after 'mptcp: Add MPTCP socket stubs'?
> =

> Could also be squashed, I do not mind.  Just a suggestion.

For me it is clearer to have dedicated patches for the introduction of =

the MIBs: it might help reviewers to easily point out "strategic places" =

or because spending less time on that because it only modifies MPTCP code :)
But if we have to limit the number of patches, we can of course do that.

It is just that I guess the reviewers will not like having too big =

patches neither. I understand that 40 patches is too big but as a =

reviewer, I would prefer having a very few more patches and split per =

features / refactoring. I mean: if we send the same modifications in =

less patches, I don't know if it will help reviewers. But of course, =

better squashing patches that fix bugs introduced in other patches of =

the series.
So for me, I understood that it is better not to squash too much but =

send our modifications by smaller sets.

But I understand your point and incrementing MIBs counters could be done =

directly when we introduce the action.

Just let me know if you think it will be required by upstream to squash =

them and I can work on that. :-)

(but this is less urgent if we only want to send the 11th patches we =

listed last week, right?)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8769607387180816994==--
