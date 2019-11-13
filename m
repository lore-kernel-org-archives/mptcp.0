Content-Type: multipart/mixed; boundary="===============0889727391458933471=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/8] Add IPv6 Support
Date: Wed, 13 Nov 2019 19:36:06 +0100
Message-ID: <9256d3c468cb189953e30b8c0efe829e77ef4220.camel@redhat.com>
In-Reply-To: 20191113064518.4823-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2518

--===============0889727391458933471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-12 at 22:45 -0800, Peter Krystad wrote:
> This patchset is a replacement for the single "Add IPv6 Support"
> commit, with the chunks broken into seperate squash-able commits.
> =

> Peter Krystad (8):
>   mptcp: Add IPv6 support for MPTCP socket stubs
>   mptcp: Add IPv6 support for Associate MPTCP context
>   mptcp: Add IPV6 support for outgoing connections
>   mptcp: Add IPv6 support for mptcp_poll
>   mptcp: Add IPV6 support for incoming connections
>   mptcp: Add IPv6 support for key generation
>   mptcp: Add IPv6 support for shutdown()
>   mptcp: Add IPv6 support for new sysctl initialization
> =

>  include/net/mptcp.h  | 10 +++++++
>  net/ipv6/tcp_ipv6.c  |  7 +++++
>  net/mptcp/ctrl.c     | 11 ++++++++
>  net/mptcp/protocol.c | 62 +++++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |  6 +++++
>  net/mptcp/subflow.c  | 61 +++++++++++++++++++++++++++++++++++++++++--
>  6 files changed, 151 insertions(+), 6 deletions(-)

it's hard to verify it without doing the full squash exercise, but the
split LGTM.

Thanks!

Paolo

--===============0889727391458933471==--
