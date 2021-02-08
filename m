Content-Type: multipart/mixed; boundary="===============3970920444563073073=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net 5/5] selftests: mptcp: dump more info on
 errors
Date: Mon, 08 Feb 2021 20:09:44 +0100
Message-ID: <f8e3a296-6029-b528-b7be-0cb9f6a8e177@tessares.net>
In-Reply-To: 1eda5017066883f1bd0f59598477b817313458c1.1612543972.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7687

--===============3970920444563073073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 05/02/2021 17:55, Paolo Abeni wrote:
> Even if that may sound completely unlikely, the mptcp implementation
> is not perfect, yet.
> =

> When the self-tests report an error we usually need more information
> of what the scripts currently report. iproute allow provides
> some additional goodies since a few releases, let's dump them.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>   tools/testing/selftests/net/mptcp/mptcp_connect.sh | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index 2cfd87d94db89..9dae77f3aa2a9 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -128,6 +128,7 @@ cleanup()
>   	local netns
>   	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
>   		ip netns del $netns
> +		rm -f /tmp/$netns.{nstat,out}
>   	done
>   }
>   =

> @@ -438,16 +439,20 @@ do_transfer()
>   		kill ${cappid_connector}
>   	fi
>   =

> +	NSTAT_HISTORY=3D/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} =
nstat |grep Tcp > /tmp/${listener_ns}.out
> +	[ ${listener_ns} !=3D ${connector_ns} ] && NSTAT_HISTORY=3D/tmp/${conne=
ctor_ns}.nstat ip netns exec ${connector_ns} nstat -s |grep Tcp > /tmp/${co=
nnector_ns}.out

When looking at applying it, "checkpatch" complained about the line =

length. It's not really an issue here with Bash but still I was thinking =

about going to the new line to improve the readability maybe.

But then I realised that the 2nd "nstat" is with "-s" but not the first =

one. Is it normal?

I suggest to apply it like that and fix it tomorrow if needed.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3970920444563073073==--
