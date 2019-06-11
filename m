Content-Type: multipart/mixed; boundary="===============9041198011259892144=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 0/2] Minor patches [Remaining two]
Date: Tue, 11 Jun 2019 21:52:01 +0200
Message-ID: <a8112ed1-d797-acc3-268c-fecb8e694128@tessares.net>
In-Reply-To: 20190611175148.11832-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1337

--===============9041198011259892144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 11/06/2019 19:51, Peter Krystad wrote:
> Responding to comments and rebase.
> =

> v2 - fix mp_opt usage and remove changes to mptcp_write_options logic.

Thank you for this new version!
Is the second patch the exact same one as the previous version I applied
in commit 98555b04a8d9?

https://github.com/multipath-tcp/mptcp_net-next/commit/98555b04a8d9

Best regards,
Matt

> Peter Krystad (2):
>   mptcp: reduce number of pr_debug() calls.
>   mptcp: Refactor mptcp_established_options() to single hook
> =

>  include/net/mptcp.h   | 21 ++++---------
>  net/ipv4/tcp_output.c | 20 ++++---------
>  net/mptcp/options.c   | 70 +++++++++++++++++++++++++++++--------------
>  3 files changed, 58 insertions(+), 53 deletions(-)
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============9041198011259892144==--
