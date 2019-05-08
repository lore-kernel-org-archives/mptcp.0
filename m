Content-Type: multipart/mixed; boundary="===============0377061823704536452=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3] mptcp: mptcp option len must be skb independent
Date: Wed, 08 May 2019 18:41:43 +0200
Message-ID: <901b8cdf-d7c3-3fb2-68a3-14c6e702feba@tessares.net>
In-Reply-To: 48a87bc31720fb0c305c22c520048b64047d1fb7.1557328856.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1130

--===============0377061823704536452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for this v3!

On 08/05/2019 17:23, Paolo Abeni wrote:
> Otherwise the TCP stack can't compute correctly the mss and
> that will break segmentation.
> =

> Fix the issue reserving space for map if skb is NULL, too.
> The map is effectively added according to skb extensions,
> if available.
> Overall we underestimate the MSS (always accounting for the map), but
> we emit the map only if needed.
> =

> v2 -> v3:
>  - reserve the map space if skb is NULL, as per Mat suggestion
> =

> v1 -> v2:
>  - rebased on top of current git
>  - use slightly different way to compute the opt len
> =

> Fixes: 9aaf99d52fc1 ("mptcp: Write MPTCP DSS headers to outgoing data pac=
kets")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> Notes:
> - this can be squashed into the fixes commit

Just did! And I added your signed-off.

- Squash: 3016ea80e4535a954bbde473ffdc0104dbea5592
- Signed-off: 13b0a7adcea1addb067113c479ae412b183e0611
- Merge conflict resolution: e4ae2a109fc294263bae24ca1d6f8933112d55ad
- export: 189b53eeae7d4adec0e2f13b6eb8c67b3d13165c

> - the self-test still fails, there are more, unrelated, issues pending
Thank you for the notice!

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0377061823704536452==--
