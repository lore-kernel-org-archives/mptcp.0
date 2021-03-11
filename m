Content-Type: multipart/mixed; boundary="===============3464246006971305762=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "mptcp: only admit
 explicitly supported sockopt"
Date: Thu, 11 Mar 2021 11:43:37 +0100
Message-ID: <246241bfed0aa8cc775699c530786ad813e10c97.camel@redhat.com>
In-Reply-To: 20210311101127.1774603-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8098

--===============3464246006971305762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-03-11 at 11:11 +0100, Matthieu Baerts wrote:
> SO_SNDTIMEO_{OLD,NEW} were missing in the list. They are considered as
> "quite common but need a better implementation".
> =

> Indeed, as mentioned by Paolo: these settings are applied only to the
> first subflow, while mptcp_recvmsg()/mptcp_sendmsg() will look for the
> timeout value in the msk socket.
> =

> At least with these patches, we can have MPTCP BPF selftest passing:
> =

>   ./test_progs -n 66
> =

> Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     to be squashed in "mptcp: only admit explicitly supported sockopt"
> =

>  net/mptcp/sockopt.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 3eda9127debb..fb98fab252df 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -110,6 +110,8 @@ static bool mptcp_supported_sockopt(int level, int op=
tname)
>  		case SO_RCVLOWAT:
>  		case SO_RCVTIMEO_OLD:
>  		case SO_RCVTIMEO_NEW:
> +		case SO_SNDTIMEO_OLD:
> +		case SO_SNDTIMEO_NEW:
>  		case SO_MARK:
>  		case SO_INCOMING_CPU:
>  		case SO_BINDTOIFINDEX:

LGTM! =


Thanks,

Paolo

--===============3464246006971305762==--
