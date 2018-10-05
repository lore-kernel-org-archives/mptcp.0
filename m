Content-Type: multipart/mixed; boundary="===============0196685852955665512=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v3 00/16] MPTCP architecture proposal for
 discussion
Date: Fri, 05 Oct 2018 15:59:02 -0700
Message-ID: <20181005225918.9786-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 764

--===============0196685852955665512==
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


The patch set applies to net-next (as of commit 2ad0d5269970). I have also
pushed it to:

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
(mptcp-proposal branch)

v3 changes: Change skb extension technique, change rx path to use error
queue, add foundational code for multiple subflows, and many bug fixes.

v2 changes: Added receive path implementation (last two patches).
Reworked TCP option writing. Miscellaneous bug fixes including
header dependency cleanup.


Mat Martineau (6):
  tcp: Add MPTCP option number
  tcp: Define IPPROTO_MPTCP
  skbuff: Add private data pointer
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

 include/linux/skbuff.h        |  16 +-
 include/linux/tcp.h           |  26 +
 include/net/inet_common.h     |   3 +
 include/net/mptcp.h           | 205 ++++++++
 include/net/tcp.h             |   8 +
 include/uapi/linux/errqueue.h |   1 +
 include/uapi/linux/in.h       |   4 +
 net/Kconfig                   |   1 +
 net/Makefile                  |   1 +
 net/core/skbuff.c             |   5 +
 net/ipv4/af_inet.c            |   2 +-
 net/ipv4/tcp.c                |  12 +-
 net/ipv4/tcp_input.c          |  18 +
 net/ipv4/tcp_ipv4.c           |   4 +-
 net/ipv4/tcp_output.c         | 239 ++++++++-
 net/mptcp/Kconfig             |  10 +
 net/mptcp/Makefile            |   3 +
 net/mptcp/crypto.c            | 215 ++++++++
 net/mptcp/options.c           | 263 ++++++++++
 net/mptcp/protocol.c          | 891 ++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c           | 377 ++++++++++++++
 net/mptcp/token.c             | 265 ++++++++++
 22 files changed, 2544 insertions(+), 25 deletions(-)
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


--===============0196685852955665512==--
