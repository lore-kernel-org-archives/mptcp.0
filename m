Content-Type: multipart/mixed; boundary="===============0938698142178107768=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Fwd: [PATCH net-next 0/13] sk_buff: add extension
 infrastructure
Date: Tue, 18 Dec 2018 18:47:01 +0100
Message-ID: <CAKuKrBkfiw6OEYCMd2rQfKCegoq5Uf6Nw8KwX7EsWc8aw=mH5Q@mail.gmail.com>
In-Reply-To: 20181218161527.2760-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 934

--===============0938698142178107768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

FYI, Florian sent a new version of his patch-set on Netdev:
- https://lwn.net/ml/netdev/20181218161527.2760-1-fw(a)strlen.de/
- https://git.breakpoint.cc/cgit/fw/net-next.git/log/?h=3Dskb_ext_both_07
- @Mat: you might be interested in:
https://review.gerrithub.io/q/topic:%22fwestphal-skb_ext_both_07%22+(status=
:open%20OR%20status:merged)

Thanks Florian for this very good job! :)

Cheers,
Matt

---------- Forwarded message ---------
From: Florian Westphal <fw(a)strlen.de>
Date: Tue, Dec 18, 2018 at 5:13 PM
Subject: [PATCH net-next 0/13] sk_buff: add extension infrastructure
To: <netdev(a)vger.kernel.org>


TL;DR:
 - objdiff shows no change if CONFIG_XFRM=3Dn && BR_NETFILTER=3Dn
 - small size reduction when one or both options are set
 - no changes in ipsec performance

 Changes since v1:
 - Allocate entire extension space from a kmem_cache.
 - Avoid atomic_dec_and_test operation on skb_ext_put() for refcnt =3D=3D 1=
 case.
   (similar to kfree_skbmem() fclone_ref use).

This adds an optional extension infrastructure, with ispec (xfrm) and
bridge netfilter as first users.

The third (future) user is Multipath TCP which is still out-of-tree.
MPTCP needs to map logical mptcp sequence numbers to the tcp sequence
numbers used by individual subflows.

This DSS mapping is read/written from tcp option space on receive and
written to tcp option space on transmitted tcp packets that are part of
and MPTCP connection.

Extending skb_shared_info or adding a private data field to skb fclones
doesn't work for incoming skb, so a different DSS propagation method would
be required for the receive side.

mptcp has same requirements as secpath/bridge netfilter:

1. extension memory is released when the sk_buff is free'd.
2. data is shared after cloning an skb (clone inherits extension)
3. adding extension to an skb will COW the extension buffer if needed.

Two new members are added to sk_buff:
1. 'active_extensions' byte (filling a hole), telling which extensions
   are available for this skb.
   This has two purposes.
   a) avoids the need to initialize the pointer.
   b) allows to "delete" an extension by clearing its bit
   value in ->active_extensions.

   While it would be possible to store the active_extensions byte
   in the extension struct instead of sk_buff, there is one problem
   with this:
    When an extension has to be disabled, we can always clear the
    bit in skb->active_extensions.  But in case it would be stored in the
    extension buffer itself, we might have to COW it first, if
    we are dealing with a cloned skb.  On kmalloc failure we would
    be unable to turn an extension off.
2. extension pointer, located at the end of the sk_buff.
   If the active_extensions byte is 0, the pointer is undefined,
   it is not initialized on skb allocation.

This adds extra code to skb clone and free paths (to deal with
refcount/free of extension area) but this replaces similar code that
manages skb->nf_bridge and skb->sp structs in the followup patches of
the series.

It is possible to add support for extensions that are not preseved on
clones/copies:

1. define a bitmask of all extensions that need copy/cow on clone
2. change __skb_ext_copy() to check
   ->active_extensions & SKB_EXT_PRESERVE_ON_CLONE
3. set clone->active_extensions to 0 if test is false.

This isn't done here because all extensions that get added here
need the copy/cow semantics.

Last patch converts skb->sp, secpath information gets stored as
new SKB_EXT_SEC_PATH, so the 'sp' pointer is removed from skbuff.

Extra code added to skb clone and free paths (to deal with refcount/free
of extension area) replaces the existing code that does the same for
skb->nf_bridge and skb->secpath.

I don't see any other in-tree users that could benefit from this
infrastructure, it doesn't make sense to add an extension just for the sake
of a single flag bit (like skb->nf_trace).

Adding a new extension is a good fit if all of the following are true:

1. Data is related to the skb/packet aggregate
2. Data should be freed when the skb is free'd
3. Data is not going to be relevant/needed in normal case (udp, tcp,
   forwarding workloads, ...)
4. There are no fancy action(s) needed on clone/free, such as callbacks
   into kernel modules.

Florian Westphal (13):
      netfilter: avoid using skb->nf_bridge directly
      sk_buff: add skb extension infrastructure
      net: convert bridge_nf to use skb extension infrastructure
      xfrm: change secpath_set to return secpath struct, not error value
      net: move secpath_exist helper to sk_buff.h
      net: use skb_sec_path helper in more places
      drivers: net: intel: use secpath helpers in more places
      drivers: net: ethernet: mellanox: use skb_sec_path helper
      drivers: net: netdevsim: use skb_sec_path helper
      xfrm: use secpath_exist where applicable
      drivers: chelsio: use skb_sec_path helper
      xfrm: prefer secpath_set over secpath_dup
      net: switch secpath to use skb extension infrastructure

 Documentation/networking/xfrm_device.txt                      |    7
 drivers/crypto/chelsio/chcr_ipsec.c                           |    4
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c                |   15
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                 |    5
 drivers/net/ethernet/intel/ixgbevf/ipsec.c                    |   15
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c             |    2
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c |   19
 drivers/net/netdevsim/ipsec.c                                 |    7
 include/linux/netfilter_bridge.h                              |   33 +
 include/linux/skbuff.h                                        |  152 +++++=
+-
 include/net/netfilter/br_netfilter.h                          |   14
 include/net/xfrm.h                                            |   41 --
 net/Kconfig                                                   |    4
 net/bridge/br_netfilter_hooks.c                               |   39 -
 net/bridge/br_netfilter_ipv6.c                                |    4
 net/core/skbuff.c                                             |  201 +++++=
++++-
 net/ipv4/esp4.c                                               |    9
 net/ipv4/esp4_offload.c                                       |   15
 net/ipv4/ip_output.c                                          |    1
 net/ipv4/netfilter/nf_reject_ipv4.c                           |    6
 net/ipv6/esp6.c                                               |    9
 net/ipv6/esp6_offload.c                                       |   15
 net/ipv6/ip6_output.c                                         |    1
 net/ipv6/netfilter/nf_reject_ipv6.c                           |   10
 net/ipv6/xfrm6_input.c                                        |    8
 net/netfilter/nf_log_common.c                                 |   20
 net/netfilter/nf_queue.c                                      |   50 +-
 net/netfilter/nfnetlink_queue.c                               |   23 -
 net/netfilter/nft_meta.c                                      |    2
 net/netfilter/nft_xfrm.c                                      |    2
 net/netfilter/xt_physdev.c                                    |    2
 net/netfilter/xt_policy.c                                     |    2
 net/xfrm/Kconfig                                              |    1
 net/xfrm/xfrm_device.c                                        |    4
 net/xfrm/xfrm_input.c                                         |   76 +--
 net/xfrm/xfrm_interface.c                                     |    2
 net/xfrm/xfrm_output.c                                        |    7
 net/xfrm/xfrm_policy.c                                        |   19
 security/selinux/xfrm.c                                       |    4
 39 files changed, 564 insertions(+), 286 deletions(-)



-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

Disclaimer: https://www.tessares.net/mail-disclaimer/

--===============0938698142178107768==--
