Content-Type: multipart/mixed; boundary="===============0976127503901895080=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 0/9] Changes for implementing MPTCP
Date: Tue, 27 Mar 2018 12:37:25 +0200
Message-ID: <20180327103725.GF71178@MacBook-Pro-6.lan>
In-Reply-To: 1519343401-19027-1-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 429

--===============0976127503901895080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 22/02/18 - 15:49:52, rao.shoaib(a)oracle.com wrote:
> From: Rao Shoaib <rao.shoaib(a)oracle.com>
> =

> Following patches modify TCP code to enable implementation of MPTCP. MPTC=
P implementation requires sharing of TCP code with minor modification here =
and there. In order to keep the TCP code clean and easy to maintain, common=
 code has been moved to new functions for use by both TCP and MPTCP. struct=
 tcp_sock now has function pointers and based on the socket type (TCP/MPTCP=
) appropriate function is called.
> =

> A basic implementation of MPTCP that works with IPv4/IPv6 and supports jo=
in has been tested based on these changes.
> =

> The changes are being submitted as an RFC to get feedback from the commun=
ity and to start a discussion on how to move forward.

I did a full review of the patches.

Besides the details I commented on in the individual patches, I have a few
higher-level comments:

* The patchset introduces function-pointers to reduce the impact of MPTCP on
  the TCP-stack. Ignoring potential performance costs for a moment:

  The patchset should show why these function-pointers are needed for an
  MPTCP implementation. While reviewing the patches, it wasn't clear to me
  Although, I can guess it because I know the MPTCP-code. However, someone
  not familiar with MPTCP will have an even harder time to understand the
  reason for these function pointers.

* Another question that should be answered in the patchset is how these
  function pointers can be used by other TCP extensions (I am assuming that=
 is
  the intention). The question that arises then is how could MPTCP be shared
  with these other TCP extensions?

* It should also be explained in the patchset how one switches the function
  pointers. It was unclear to me how MPTCP gets enabled.

  In tcp_init_sock() tp->op_ops is currently set to tcp_default_op_ops.
  Thus, would that mean that MPTCP would get enabled on a system-level by
  changing tcp_default_op_ops?

* The patches are holding the meta-lock when processing incoming packets or
  timer-events. This will trigger a lot of RCU-warnings. Adressing this is
  not trivial and will require significant architectural changes.


Cheers,
Christoph

> =

> Rao Shoaib (9):
>   Modify tcp structures to support function pointers
>   Introduce MPTCP specific elements that will co-exist with TCP even
>     when MPTCP is not compiled
>   Introduce MPTCP specific elements that can be under #ifdef
>     MPTCP_CONFIG
>   Populate function pointers -- few (5) will be populated later
>   Switch code to use function pointers
>   Make TCP options processing abstract
>   Restructure syncookie code to use pointers
>   Restructure TCP code so that it can be shared primarily with MPTCP
>   Add MPTCP specific code to core TCP code
> =

>  crypto/md5.c                    |   3 -
>  include/crypto/md5.h            |   2 +
>  include/linux/tcp.h             |  91 ++++++++++++
>  include/net/inet_common.h       |   2 +
>  include/net/inet_sock.h         |   6 +-
>  include/net/net_namespace.h     |   6 +
>  include/net/secure_seq.h        |   9 +-
>  include/net/sock.h              |   1 +
>  include/net/tcp.h               | 321 ++++++++++++++++++++++++++++++++++=
++++--
>  include/net/tcp_states.h        |   4 +-
>  include/net/transp_v6.h         |   3 -
>  include/uapi/linux/bpf.h        |   4 +-
>  include/uapi/linux/if.h         |   5 +
>  include/uapi/linux/tcp.h        |   1 +
>  net/core/secure_seq.c           |  70 +++++++++
>  net/ipv4/af_inet.c              |  16 +-
>  net/ipv4/inet_connection_sock.c |  17 ++-
>  net/ipv4/ip_sockglue.c          |  20 +++
>  net/ipv4/syncookies.c           | 112 ++++++++++----
>  net/ipv4/tcp.c                  | 221 +++++++++++++++++++++------
>  net/ipv4/tcp_input.c            | 195 ++++++++++++++----------
>  net/ipv4/tcp_ipv4.c             | 112 ++++++++++----
>  net/ipv4/tcp_minisocks.c        |  56 ++++++-
>  net/ipv4/tcp_output.c           | 206 +++++++++++++++-----------
>  net/ipv4/tcp_timer.c            |  55 +++++--
>  net/ipv6/af_inet6.c             |   4 +-
>  net/ipv6/ipv6_sockglue.c        |  14 ++
>  net/ipv6/syncookies.c           |  40 +----
>  net/ipv6/tcp_ipv6.c             | 163 +++++++++++++-------
>  29 files changed, 1360 insertions(+), 399 deletions(-)
> =

> -- =

> 2.7.4
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============0976127503901895080==--
