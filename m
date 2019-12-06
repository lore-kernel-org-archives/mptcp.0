Content-Type: multipart/mixed; boundary="===============7342659098675347199=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove flags field from struct
 mptcp_options_received
Date: Fri, 06 Dec 2019 09:31:32 +0100
Message-ID: <2c5c11e0a9e8d465d9a64c38d61dd411ef2b2814.camel@redhat.com>
In-Reply-To: 20191205234344.27404-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2808

--===============7342659098675347199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-05 at 15:43 -0800, Peter Krystad wrote:
> This field is only used temporarily while parsing options,
> use a local variable instead.
> =

> Also move key fields to final position and fix indents.
> =

> Formatted to apply directly to Handle MPTCP TCP options.
> =

> squashto: Handle MPTCP TCP options
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  include/linux/tcp.h |  7 +++----
>  net/mptcp/options.c | 17 ++++++++---------
>  2 files changed, 11 insertions(+), 13 deletions(-)

LGTM,

Acked-by: Davide Caratti <dcaratti(a)redhat.com>


--===============7342659098675347199==--
