Content-Type: multipart/mixed; boundary="===============4779175874895492347=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 01/13] selftest: add mmap-write support
Date: Tue, 19 Nov 2019 14:58:27 -0800
Message-ID: <alpine.OSX.2.21.1911191452540.15309@gpmelz-mobl1.amr.corp.intel.com>
In-Reply-To: 20191118214538.21931-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2604

--===============4779175874895492347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 18 Nov 2019, Florian Westphal wrote:

> No changes on default options.  New option -b allows to set a lower
> send buffer size.
>
> New option "-m mmap" allows to use a mode where the sender transmits the
> entire file in very large chunks (using mmap + write) instead of the
> default poll+read/write.
>
> This is mainly useful to make sure we cope with large writes.
> I also added sendfile() support (as its easy), but it won't work yet
> for mptcp sockets.
>
> should be squashed into mptcp: add basic kselftest for mptcp
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> .../selftests/net/mptcp/mptcp_connect.c       | 257 +++++++++++++++++-
> .../selftests/net/mptcp/mptcp_connect.sh      |  36 ++-
> 2 files changed, 284 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index ddfd85b31808..ea8e08b1f481 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
...
> @@ -352,6 +375,168 @@ static int copyfd_io(int infd, int peerfd, int outf=
d)
> 	return 0;
> }
>
> +static int do_recvfile(int infd, int outfd)
> +{
> +	ssize_t r;
> +
> +	do {
> +		char buf[16536];

The array size makes me think you intended 2^14 (16384) but changed only =

the first two digits of 2^16 (65536). It doesn't make a real difference to =

the test, though.

Mat


> +
> +		r =3D do_rnd_read(infd, buf, sizeof(buf));
> +		if (r > 0) {
> +			if (write(outfd, buf, r) !=3D r)
> +				break;
> +		} else if (r < 0) {
> +			perror("read");
> +		}
> +	} while (r > 0);
> +
> +	return (int)r;
> +}


--
Mat Martineau
Intel
--===============4779175874895492347==--
