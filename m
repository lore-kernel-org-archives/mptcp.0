Content-Type: multipart/mixed; boundary="===============5665501080920440051=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v5 00/17] MPTCP architecture proposal
Date: Mon, 17 Dec 2018 18:20:30 +0100
Message-ID: <CAKuKrB=GJ2BdFn=KOr4ZWJSN0iyPD-fYQ4cx5enYJvhf4R=yxA@mail.gmail.com>
In-Reply-To: 20181214222715.23766-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 920

--===============5665501080920440051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Here is a short notification to say that, as discussed with Mat, we
decided to put this patch-set on Gerrit to help reviewers.

The v4 has first been uploaded (on Gerrit: v1), followed by a rebase
(on Gerrit: v2) and then this v5 (on Gerrit: v3). Feel free to then
compare Gerrit versions 2 and 3 to see the differences between the v4
and this v5, e.g.
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437388/2..3

If you want to see all opened Changes for this project, please have a
look there:
https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+stat=
us:open

Cheers,
Matt

On Fri, Dec 14, 2018 at 11:27 PM Mat Martineau
<mathew.j.martineau(a)linux.intel.com> wrote:
>
> Hello everyone,
>
> Peter and I have been working on this patch set to show how how MPTCP
> can fit in to the Linux networking stack using these design ideas:
>
>  * Applications opt-in to MPTCP using IPPROTO_MPTCP, regular TCP sockets
>    are still the default. A socket created with
>    socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP) will attempt to form a
>    MPTCP connection. IPPROTO_MPTCP =3D=3D 99 as a placeholder.
>
>  * Subflows exist within the kernel as separate sockets, owned by a
>    MPTCP connection-level socket that is visible to userspace.
>
>  * Adds private pointers to struct sk_buff to store MPTCP metadata.
>
>  * Adds the CONFIG_MPTCP option to Kconfig.
>
> This now makes use of Florian's skb extensions, as posted to netdev.
>
> The following patches can form an MPTCP connection with the
> multipath-tcp.org kernel (tested with v0.94), and send DSS mappings that
> are accepted for the initial data packet. It is an early implementation,
> and I don't represent it as being upstreamable as-is or being everyone's
> idea of what an eventual upstream implementation will necessarily look
> like. It has significant limitations:
>
>  * Only one subflow is supported, no joins, and only ipv4.
>
>  * Does not support DSS checksums. Checksums must be disabled on the
>    remote stack (for multipath-tcp.org, 'sudo sysctl -w
>    net.mptcp.mptcp_checksum=3D0')
>
>  * Lots of debug statements (although they use dynamic debug and are
>    disabled by default) and TODOs.
>
>  * It's only been tested sending small amounts of data for each send
>
> Hopefully there are are some interesting concepts to discuss, and this
> code helps us assess how workable the above design principles
> are. Thanks in advance for your feedback on the benefits or drawbacks of
> this code, how it might be improved, or how other approaches might
> compare.
>
>
> The patch set applies to Florian Westphal's skb_ext_both_03 branch
> (https://git.breakpoint.cc/cgit/fw/net-next.git/log/?h=3Dskb_ext_both_03),
> commit id b363a92ec92a7af53e254f1ac0555567fbf790d1.
>
> I have also pushed the commits to:
> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
> (mptcp-proposal branch)
>
> v5 changes: Rebase on Florian's skb extensions. Fix !CONFIG_MPTCP build.
>
> v4 changes: Refine skb extension (remove copy hook), change rx path to
> use skb extension instead of error queue,
>
> v3 changes: Change skb extension technique, change rx path to use error
> queue, add foundational code for multiple subflows, and many bug fixes.
>
> v2 changes: Added receive path implementation (last two patches).
> Reworked TCP option writing. Miscellaneous bug fixes including
> header dependency cleanup.
>
>
> Mat Martineau (7):
>   tcp: Add MPTCP option number
>   tcp: Define IPPROTO_MPTCP
>   mptcp: Add MPTCP to skb extensions
>   tcp: Prevent coalesce and collapse when skb->priv is used
>   tcp: Export low-level TCP functions
>   mptcp: Write MPTCP DSS headers to outgoing data packets
>   mptcp: Implement MPTCP receive path
>
> Peter Krystad (10):
>   mptcp: Add MPTCP socket stubs
>   mptcp: Handle MPTCP TCP options
>   tcp: Add IPPROTO_SUBFLOW
>   tcp: expose tcp routines and structs for MPTCP
>   mptcp: Create SUBFLOW socket for outgoing connections
>   mptcp: Create SUBFLOW socket for incoming connections
>   mptcp: Add key generation and token tree
>   mptcp: Add shutdown() socket operation
>   mptcp: Add setsockopt()/getsockopt() socket operations
>   mptcp: Make connection_list a real list of subflows
>
>  include/linux/skbuff.h    |   3 +
>  include/linux/tcp.h       |  26 ++
>  include/net/inet_common.h |   3 +
>  include/net/mptcp.h       | 235 ++++++++++
>  include/net/tcp.h         |  17 +
>  include/uapi/linux/in.h   |   4 +
>  net/Kconfig               |   1 +
>  net/Makefile              |   1 +
>  net/core/skbuff.c         |   7 +
>  net/ipv4/af_inet.c        |   2 +-
>  net/ipv4/tcp.c            |  12 +-
>  net/ipv4/tcp_input.c      |  23 +-
>  net/ipv4/tcp_ipv4.c       |   4 +-
>  net/ipv4/tcp_output.c     | 243 ++++++++++-
>  net/mptcp/Kconfig         |  11 +
>  net/mptcp/Makefile        |   3 +
>  net/mptcp/crypto.c        | 215 +++++++++
>  net/mptcp/options.c       | 301 +++++++++++++
>  net/mptcp/protocol.c      | 895 ++++++++++++++++++++++++++++++++++++++
>  net/mptcp/subflow.c       | 377 ++++++++++++++++
>  net/mptcp/token.c         | 256 +++++++++++
>  21 files changed, 2612 insertions(+), 27 deletions(-)
>  create mode 100644 include/net/mptcp.h
>  create mode 100644 net/mptcp/Kconfig
>  create mode 100644 net/mptcp/Makefile
>  create mode 100644 net/mptcp/crypto.c
>  create mode 100644 net/mptcp/options.c
>  create mode 100644 net/mptcp/protocol.c
>  create mode 100644 net/mptcp/subflow.c
>  create mode 100644 net/mptcp/token.c
>
> --
> 2.20.0
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp



-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

Disclaimer: https://www.tessares.net/mail-disclaimer/

--===============5665501080920440051==--
