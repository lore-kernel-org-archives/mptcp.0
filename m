Content-Type: multipart/mixed; boundary="===============0443635228370621713=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] selftests: mptcp: support capture with
 other options
Date: Mon, 08 Mar 2021 11:11:24 -0800
Message-ID: <2cea1861-6798-da83-432c-7cc4868fec5@linux.intel.com>
In-Reply-To: 20210308135131.2517940-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8076

--===============0443635228370621713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 8 Mar 2021, Matthieu Baerts wrote:

> A capture was not started when multiple short options were combined,
> e.g.
>
>  ./mptcp_join.sh -fc
>
> A regex is now used to handle this case.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>
> Notes:
>    If we want to reduce the number of commits, we might want to squash th=
is
>    one in "selftests: mptcp: Restore packet capture option in join tests"
>    commit we have in our tree.
>    Either is fine for me.
>

Thanks for fixing that - would be best to squash it, please update tags =

for attribution!

Mat


> tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index ca5bf22ca204..abeb24b7f8ec 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1410,9 +1410,13 @@ make_file "$sin" "server" 1
> trap cleanup EXIT
>
> for arg in "$@"; do
> -	if [ "$arg" =3D "-c" ]; then
> +	# check for "capture" arg before launching tests
> +	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
> 		capture=3D1
> -	else
> +	fi
> +
> +	# exception for the capture option, the rest means: a part of the tests
> +	if [ "${arg}" !=3D "-c" ]; then
> 		do_all_tests=3D0
> 	fi
> done
> -- =

> 2.30.1
>
>

--
Mat Martineau
Intel
--===============0443635228370621713==--
