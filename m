Content-Type: multipart/mixed; boundary="===============0548236082720883799=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/4] mptcp: msk diag support
Date: Thu, 02 Jul 2020 15:06:10 -0700
Message-ID: <alpine.OSX.2.23.453.2007021501270.56922@pranalij-mobl.amr.corp.intel.com>
In-Reply-To: cover.1593689328.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4905

--===============0548236082720883799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 2 Jul 2020, Paolo Abeni wrote:

> This introduces basic mptcp sockets diag support.
> As IPPROTO_MPTCP excedes 8 bits, we need some changes at the inet_diag le=
vel:
> a new attribute is introduced to allow user-space providing u32 protocol
> values.
>
> Patch 2 introduces new token APIs to allow traversing the existing msks, =
while
> patch 3 bring in the actual diag implementation.
>
> Patch 4 includes some basic functional tests
>
> v2 -> v3:
> - changed token iterator APIs: use RCU && get_sock
> - tests cleanup

Thanks for the v3 fixes Paolo, my concerns in v2 are addressed. There is =

the proto range checking issue Christoph noted in patch 1 to fix before =

merging.


Mat


>
> v1 -> v2
> - fixed dump issue on large dump
> - use flags for fallback, etc
> - patch 4
>
> Paolo Abeni (4):
>  inet_diag: support for wider protocol numbers
>  mptcp: add msk interations helper
>  mptcp: add MPTCP socket diag interface
>  selftests/mptcp: add diag interface tests
>
> include/uapi/linux/inet_diag.h                |   1 +
> include/uapi/linux/mptcp.h                    |  17 ++
> net/core/sock.c                               |   1 +
> net/ipv4/inet_diag.c                          |  63 +++++--
> net/mptcp/Kconfig                             |   4 +
> net/mptcp/Makefile                            |   2 +
> net/mptcp/mptcp_diag.c                        | 169 ++++++++++++++++++
> net/mptcp/protocol.h                          |   2 +
> net/mptcp/token.c                             |  59 ++++++
> tools/testing/selftests/net/mptcp/Makefile    |   2 +-
> tools/testing/selftests/net/mptcp/diag.sh     | 122 +++++++++++++
> .../selftests/net/mptcp/mptcp_connect.c       |  22 ++-
> 12 files changed, 442 insertions(+), 22 deletions(-)
> create mode 100644 net/mptcp/mptcp_diag.c
> create mode 100755 tools/testing/selftests/net/mptcp/diag.sh
>
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============0548236082720883799==--
