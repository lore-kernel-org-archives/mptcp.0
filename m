Content-Type: multipart/mixed; boundary="===============7360306436141643493=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/2] Minor patches [Remaining two]
Date: Mon, 10 Jun 2019 10:02:10 +0200
Message-ID: <c642fa32373ab8753f88bc237a833228f0ec01c7.camel@redhat.com>
In-Reply-To: 20190608004040.3426-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1324

--===============7360306436141643493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2019-06-07 at 17:40 -0700, Peter Krystad wrote:
> Responding to comments and rebase.
> =

> Peter Krystad (2):
>   mptcp: reduce number of pr_debug() calls.
>   mptcp: Refactor mptcp_established_options() to single hook
> =

>  include/net/mptcp.h   | 21 ++++---------
>  net/ipv4/tcp_output.c | 20 +++---------
>  net/mptcp/options.c   | 73 ++++++++++++++++++++++++++++---------------
>  3 files changed, 59 insertions(+), 55 deletions(-)
> =

Thanks Peter for following up with this, LGTM! =


I think there are still a couple of checkpatch issues, but they could
be handled separatelly, as per Matthieu email.

Cheers,

Paolo


--===============7360306436141643493==--
