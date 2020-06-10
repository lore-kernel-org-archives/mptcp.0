Content-Type: multipart/mixed; boundary="===============3904219720101943004=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 1/2] selftests: mptcp: add option to
 specify size of file to transfer
Date: Wed, 10 Jun 2020 14:24:30 +0200
Message-ID: <74ce44b3-c625-2840-e54d-ed9a3004cbde@tessares.net>
In-Reply-To: 20200610115534.17417-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4637

--===============3904219720101943004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 10/06/2020 13:55, Florian Westphal wrote:
> The script generates two random files that are then sent via tcp and
> mptcp connections.
> =

> In order to compare throughput over consecutive runs add an option
> to provide the file size on the command line: "-f 128000".
> =

> Also add an option, -t, to enable tcp tests. This is useful to
> compare throughput of mptcp connections and tcp connections.
> =

> Example: run tests with a 4mb file size, 300ms delay 0.01% loss,
> default gso/tso/gro settings and with large write/blocking io:
> =

> mptcp_connect.sh -t -f $((4 * 1024 * 1024)) -d 300 -l 0.01%  -r 0 -e "" -=
m mmap

Thank you for the patch! Good idea!

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index acf02e156d20..d9e83efd438b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh

(...)

> @@ -40,9 +42,11 @@ usage() {
>   	echo -e "\t-e: ethtool features to disable, e.g.: \"-e tso -e gso\" (d=
efault: randomly disable any of tso/gso/gro)"
>   	echo -e "\t-4: IPv4 only: disable IPv6 tests (default: test both IPv4 =
and IPv6)"
>   	echo -e "\t-c: capture packets for each test using tcpdump (default: n=
o capture)"
> +	echo -e "\t-s: size of file to transfer in bytes (default random)"

Small detail: it should be "-f" instead of "-s". I can fix this when =

applying the patch in mptcp-next.

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3904219720101943004==--
