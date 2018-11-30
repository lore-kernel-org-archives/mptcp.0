Content-Type: multipart/mixed; boundary="===============2859085525552062717=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v4 00/17] MPTCP architecture proposal
Date: Fri, 30 Nov 2018 12:10:55 -0800
Message-ID: <20181130201112.21806-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 853

--===============2859085525552062717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Peter and I have been working on this patch set to show how how MPTCP
can fit in to the Linux networking stack using these design ideas:

 * Applications opt-in to MPTCP using IPPROTO_MPTCP, regular TCP sockets
   are still the default. A socket created with
   socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP) will attempt to form a
   MPTCP connection. IPPROTO_MPTCP =3D=3D 99 as a placeholder.

 * Subflows exist within the kernel as separate sockets, owned by a
   MPTCP connection-level socket that is visible to userspace.

 * Adds private pointers to struct sk_buff to store MPTCP metadata.

 * Adds the CONFIG_MPTCP option to Kconfig.

Note that this does not yet make use of Florian's CONFIG_SKB_EXTENSIONS,
but I plan to drop patch 12 of this series and use CONFIG_SKB_EXTENSIONS
instead (since they are designed for multiple uses and will hopefully
be merged upstream). Refer to =

https://marc.info/?l=3Dlinux-netdev&m=3D154323251731893&w=3D2

The following patches can form an MPTCP connection with the
multipath-tcp.org kernel (tested with v0.94), and send DSS mappings that
are accepted for the initial data packet. It is an early implementation,
and I don't represent it as being upstreamable as-is or being everyone's
idea of what an eventual upstream implementation will necessarily look
like. It has significant limitations:

 * Only one subflow is supported, no joins, and only ipv4. =


 * Does not support DSS checksums. Checksums must be disabled on the
   remote stack (for multipath-tcp.org, 'sudo sysctl -w
   net.mptcp.mptcp_checksum=3D0')

 * Lots of debug statements (although they use dynamic debug and are
   disabled by default) and TODOs.

 * It's only been tested sending small amounts of data for each send

Hopefully there are are some interesting concepts to discuss, and this
code helps us assess how workable the above design principles
are. Thanks in advance for your feedback on the benefits or drawbacks of
this code, how it might be improved, or how other approaches might
compare.


The patch set applies to net-next (as of commit 1464193107da). I have also
pushed it to:

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
(mptcp-proposal branch)

v4 changes: Refine skb extension (remove copy hook), change rx path to
use skb extension instead of error queue, =


v3 changes: Change skb extension technique, change rx path to use error
queue, add foundational code for multiple subflows, and many bug fixes.

v2 changes: Added receive path implementation (last two patches).
Reworked TCP option writing. Miscellaneous bug fixes including
header dependency cleanup.


Mat Martineau (7):
  tcp: Add MPTCP option number
  tcp: Define IPPROTO_MPTCP
  skbuff: Add private data pointer
  tcp: Prevent coalesce and collapse when skb->priv is used
  tcp: Export low-level TCP functions
  mptcp: Write MPTCP DSS headers to outgoing data packets
  mptcp: Implement MPTCP receive path

Peter Krystad (10):
  mptcp: Add MPTCP socket stubs
  mptcp: Handle MPTCP TCP options
  tcp: Add IPPROTO_SUBFLOW
  tcp: expose tcp routines and structs for MPTCP
  mptcp: Create SUBFLOW socket for outgoing connections
  mptcp: Create SUBFLOW socket for incoming connections
  mptcp: Add key generation and token tree
  mptcp: Add shutdown() socket operation
  mptcp: Add setsockopt()/getsockopt() socket operations
  mptcp: Make connection_list a real list of subflows

 include/linux/skbuff.h    |  13 +-
 include/linux/tcp.h       |  26 ++
 include/net/inet_common.h |   3 +
 include/net/mptcp.h       | 234 ++++++++++
 include/net/tcp.h         |  15 +
 include/uapi/linux/in.h   |   4 +
 net/Kconfig               |   1 +
 net/Makefile              |   1 +
 net/core/skbuff.c         |   5 +
 net/ipv4/af_inet.c        |   2 +-
 net/ipv4/tcp.c            |  12 +-
 net/ipv4/tcp_input.c      |  23 +-
 net/ipv4/tcp_ipv4.c       |   4 +-
 net/ipv4/tcp_output.c     | 249 +++++++++-
 net/mptcp/Kconfig         |  10 +
 net/mptcp/Makefile        |   3 +
 net/mptcp/crypto.c        | 215 +++++++++
 net/mptcp/options.c       | 302 ++++++++++++
 net/mptcp/protocol.c      | 939 ++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c       | 377 +++++++++++++++
 net/mptcp/token.c         | 256 +++++++++++
 21 files changed, 2663 insertions(+), 31 deletions(-)
 create mode 100644 include/net/mptcp.h
 create mode 100644 net/mptcp/Kconfig
 create mode 100644 net/mptcp/Makefile
 create mode 100644 net/mptcp/crypto.c
 create mode 100644 net/mptcp/options.c
 create mode 100644 net/mptcp/protocol.c
 create mode 100644 net/mptcp/subflow.c
 create mode 100644 net/mptcp/token.c

-- =

2.19.1


--===============2859085525552062717==--
