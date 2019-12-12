Content-Type: multipart/mixed; boundary="===============0162444235347019038=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] mptcp: Remove version field from
 mptcp_options_received
Date: Thu, 12 Dec 2019 23:58:26 +0100
Message-ID: <52005db2-c05d-7e3b-b15c-4636d80ea06b@tessares.net>
In-Reply-To: 20191212050820.29792-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2901

--===============0162444235347019038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 12/12/2019 06:08, Peter Krystad wrote:
> This field is not necessary, all version logic is performed
> in mptcp_parse_options().
> =

> squashto: Handle MPTCP TCP options
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>   include/linux/tcp.h  | 3 +--
>   net/mptcp/options.c  | 7 ++++---
>   net/mptcp/protocol.h | 2 ++
>   3 files changed, 7 insertions(+), 5 deletions(-)
> =

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 36f5d8e53e25..e5859d671111 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -84,8 +84,7 @@ struct mptcp_options_received {
>   	u64	rcvr_key;
>   	u8	mp_capable : 1,
>   		mp_join : 1,
> -		dss : 1,
> -		version : 4;
> +		dss : 1;

I am finishing the application of this patch but now I am wondering: do =

we really need to remove "version" field from there?

I understand that we only set and read it in mptcp_parse_option() but we =

now have a hole of 4 bits :)

Potentially later, we might want to keep the version we got to act =

differently. But this should not happen before years.

Anyway I am going to finish the application of this patch and we can see =

tomorrow if we have to put it back but I guess we don't.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0162444235347019038==--
