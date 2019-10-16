Content-Type: multipart/mixed; boundary="===============5322557505185485959=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 4/5] mptcp: Update path manager interface commands
 for IPv6
Date: Wed, 16 Oct 2019 17:36:30 +0200
Message-ID: <16418a26-81cc-8531-144c-cec7f765cbeb@tessares.net>
In-Reply-To: 20191015230613.16981-5-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2179

--===============5322557505185485959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 16/10/2019 01:06, Peter Krystad wrote:
> squashto: Implement path manager interface commands
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>   net/mptcp/pm.c | 75 ++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 64 insertions(+), 11 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index bc46a0ddd396..b14308ad11a3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

[...]

> @@ -151,7 +204,7 @@ void mptcp_pm_add_addr(struct mptcp_sock *msk, const =
struct in_addr *addr,
>   =

>   	pr_debug("msk=3D%p, addr=3D%x, remote_id=3D%d", msk, addr->s_addr, id);
>   =

> -	pm->remote_addr.s_addr =3D addr->s_addr;
> +	pm->remote_addr =3D *addr;
>   	pm->remote_id =3D id;
>   	pm->remote_family =3D AF_INET;

I guess this chunk should go in "mptcp: Add path manager interface".

I can do that if there is no objections.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5322557505185485959==--
