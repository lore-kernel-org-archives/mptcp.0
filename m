Content-Type: multipart/mixed; boundary="===============0885318899451315736=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squash-to: selftests: add PM netlink functional
 tests
Date: Thu, 26 Mar 2020 10:32:09 +0100
Message-ID: <52dc8380f188a099ce85d32d3ce878e7853c2484.camel@redhat.com>
In-Reply-To: 20200325231937.28080-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4067

--===============0885318899451315736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-03-25 at 16:19 -0700, Mat Martineau wrote:
> Add pm_nl_ctl to .gitignore
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  tools/testing/selftests/net/mptcp/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing=
/selftests/net/mptcp/.gitignore
> index d72f07642738..ea13b255a99d 100644
> --- a/tools/testing/selftests/net/mptcp/.gitignore
> +++ b/tools/testing/selftests/net/mptcp/.gitignore
> @@ -1,2 +1,3 @@
>  mptcp_connect
> +pm_nl_ctl
>  *.pcap

LGTM, thanks!




--===============0885318899451315736==--
