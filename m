Content-Type: multipart/mixed; boundary="===============0887637156248613368=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] Optimize struct mptcp_options_received
Date: Thu, 12 Dec 2019 16:31:47 +0100
Message-ID: <4a226bd78f9a7404c938c463ebda9a1f7bc88237.camel@redhat.com>
In-Reply-To: 20191212050820.29792-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2888

--===============0887637156248613368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2019-12-11 at 21:08 -0800, Peter Krystad wrote:
> Changes for part 1 commits. Conflicts are straightforward
> when squashed.
> =

> Peter Krystad (2):
>   mptcp: Move struct mptcp_options_received
>   mptcp: Remove version field from mptcp_options_received
> =

>  include/linux/tcp.h  | 19 +++++++++++--------
>  net/mptcp/options.c  |  7 ++++---
>  net/mptcp/protocol.h |  2 ++
>  3 files changed, 17 insertions(+), 11 deletions(-)

LGTM! =


I was just wondering if we should drop the version field ;)

Thanks,

Paolo

p.s. 'ack' applies to the all the 4 patches version-related.

--===============0887637156248613368==--
