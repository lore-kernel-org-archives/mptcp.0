Content-Type: multipart/mixed; boundary="===============0466546304002446097=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] move TCP-related commits to the beginning
Date: Mon, 07 Oct 2019 17:03:24 +0200
Message-ID: <abce8b79-58f1-461c-f2e8-e9ebc4a7a1ec@tessares.net>
In-Reply-To: 20191007150059.GL13866@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2034

--===============0466546304002446097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/10/2019 17:00, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> ... this turns 'tcp: clean ext on tx recycle' into a one-line change.
>>
>> Good idea! Just applied this diff and added your signed-off to the patch.
> =

> Thanks!

Just in case you want to check, here is the diff between my two branches:

$ git diff rebase-net-tcp-first..rebase-net-tcp-first-v2
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c6748a4eb51b..71ffca02cb61 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4102,14 +4102,6 @@ static inline void skb_ext_put(struct sk_buff *skb)
                 __skb_ext_put(skb->extensions);
  }

-static inline void skb_ext_clear(struct sk_buff *skb)
-{
-       if (skb->active_extensions) {
-               __skb_ext_put(skb->extensions);
-               skb->active_extensions =3D 0;
-       }
-}
-
  static inline void __skb_ext_copy(struct sk_buff *dst,
                                   const struct sk_buff *src)
  {
diff --git a/include/net/sock.h b/include/net/sock.h
index 97ad8c62af1d..84ea0efe7952 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1470,7 +1470,7 @@ static inline void sk_wmem_free_skb(struct sock =

*sk, struct sk_buff *skb)
         sk_mem_uncharge(sk, skb->truesize);
         if (static_branch_unlikely(&tcp_tx_skb_cache_key) &&
             !sk->sk_tx_skb_cache && !skb_cloned(skb)) {
-               skb_ext_clear(skb);
+               skb_ext_reset(skb);
                 skb_zcopy_clear(skb, true);
                 sk->sk_tx_skb_cache =3D skb;
                 return;


If there is no objection, I am going to re-create the TopGit tree with =

this new branch then!

>>> If we place this early in the series, then
>>>
>>>> 966eb30045b9 mptcp: increment MIB counters in a few places
>>>
>>> ... could be folded into the patches that add those code paths.
>>>
>>> Perhaps right after 'mptcp: Add MPTCP socket stubs'?
>>>
>>> Could also be squashed, I do not mind.  Just a suggestion.
>>
>> For me it is clearer to have dedicated patches for the introduction of t=
he
>> MIBs: it might help reviewers to easily point out "strategic places" or
>> because spending less time on that because it only modifies MPTCP code :)
> =

> Right, we can do this as a followup so it doesn't influence the initial
> batch sizes in any way.
> =

> In light of this I agree its better to keep it as-is.
> =

>> It is just that I guess the reviewers will not like having too big patch=
es
>> neither. I understand that 40 patches is too big but as a reviewer, I wo=
uld
>> prefer having a very few more patches and split per features / refactori=
ng.
> =

> Same here.
> =

>> I mean: if we send the same modifications in less patches, I don't know =
if
>> it will help reviewers.
> =

> Right.  Lets keep it separate.

Great!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0466546304002446097==--
