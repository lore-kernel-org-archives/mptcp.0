Content-Type: multipart/mixed; boundary="===============8620254808114330466=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp: Use correct address family when
 creating subflows
Date: Tue, 22 Oct 2019 10:35:25 +0200
Message-ID: <f33db1bea7a54ffca10c58e3b552fd75e86b20e6.camel@redhat.com>
In-Reply-To: 20191021234152.3091-4-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2250

--===============8620254808114330466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2019-10-21 at 16:41 -0700, Peter Krystad wrote:
> Use the address family used when the initial MPTCP socket
> was created when making additional subflow sockets.
> =

> squashto: Implement basic path manager
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  net/mptcp/basic.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> =

> diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
> index d2fd0560c136..2557cb63fd61 100644
> --- a/net/mptcp/basic.c
> +++ b/net/mptcp/basic.c
> @@ -209,19 +209,23 @@ static void create_subflow_worker(struct work_struc=
t *work)
>  =

>  	pernet =3D net_generic(sock_net((struct sock *)msk), basic_pernet_id);
>  =

> -	if (pernet->has_announce_v4)
> -		mptcp_pm_create_subflow(pm->token, pm->remote_id,
> -					&pernet->announce_v4_addr);
> -#if IS_ENABLED(CONFIG_IPV6)
> -	else if (pernet->has_announce_v6)
> -		mptcp_pm_create_subflow6(pm->token, pm->remote_id,
> -					 &pernet->announce_v6_addr);
> -#endif
> -	else if (pm->local_family =3D=3D AF_INET)
> -		mptcp_pm_create_subflow(pm->token, pm->remote_id, NULL);
> +	if (msk->family =3D=3D AF_INET) {
> +		if (pernet->has_announce_v4)
> +			mptcp_pm_create_subflow(pm->token, pm->remote_id,
> +						&pernet->announce_v4_addr);
> +		else
> +			mptcp_pm_create_subflow(pm->token, pm->remote_id,
> +						NULL);
> +	}

Here I'm likely a bit lost, but what if the peer sends an ADD_ADDR v4,
and the local msk socket is a v6 (or vice versa)?

I think checking vs the msk family is possibly not required here (IIRC
the RFC code, it looks like an MPTCP client could manage correctly
subflows with different inet families - but we need to check/match the
local address family (has_announce_v4/has_announce_v6) vs the remote
address/ADD_ADDR family. Otherwise we could try to connect to a
corrupted/truncated/uncomplete address.

Additionally, I think we need to check/match the local additional =

address family (has_announce_v4/has_announce_v6) vs the msk family in
announce_addr_worker(), so that the sever always announce addresses
that is able to accept[1].

Thanks,

Paolo

[1] for IPv6 listener such check could be fairly more complex - unbound
listener could accept any ipv4 address, bound ones could check for
ipv4-mapped ipv6 address, etc... I think is better use to the simpler
approach here.

--===============8620254808114330466==--
