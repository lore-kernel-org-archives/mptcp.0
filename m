Content-Type: multipart/mixed; boundary="===============3319612172354507699=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: link MPC subflow into msk only
 after accept
Date: Fri, 04 Dec 2020 17:43:14 +0100
Message-ID: <fbd60118-9729-8880-84dd-b05567c865cd@tessares.net>
In-Reply-To: e699fd8e66e4d8b4080f92768ca41a85eacdda26.1606998810.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7050

--===============3319612172354507699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 03/12/2020 13:36, Paolo Abeni wrote:
> Christoph reported the following splat:

Thank you for the patch!
It looks good to me except a detail:

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index 2cfd87d94db8..63e522602b4c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -604,9 +604,9 @@ run_tests()
>   make_file "$cin" "client"
>   make_file "$sin" "server"
>   =

> -check_mptcp_disabled
> +# check_mptcp_disabled
>   =

> -check_mptcp_ulp_setsockopt
> +# check_mptcp_ulp_setsockopt
>   =

>   echo "INFO: validating network environment with pings"
>   for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
> =


I reverted the modification in this file, I guess you didn't want to do =

this :)

- 46712436b452: mptcp: link MPC subflow into msk only after accept
   - With my Reviewed-by tag
- Results: 7ca534d9bde5..8f87392aa646

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3319612172354507699==--
