Content-Type: multipart/mixed; boundary="===============2920335789373422190=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "bpf:selftests: add
 MPTCP test base"
Date: Wed, 17 Mar 2021 15:45:32 +0100
Message-ID: <5640c9c8-ec11-7706-44e3-14d4317f8235@tessares.net>
In-Reply-To: 70cec4a8462feb0ad4771dd1a0d75f3163800059.1615983074.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8189

--===============2920335789373422190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 17/03/2021 13:11, Geliang Tang wrote:
> When I ran the bpf mptcp test "./test_progs -n 67", I got a "fallback to
> TCP" error in kernel log:
> =

>   [   77.939497] MPTCP: msk=3D00000000e58fbe96
>   [   77.939534] IPv4: Attempt to release TCP socket in state 8 00000000e=
58fbe96
>   [   77.939807] MPTCP: subflow_req=3D0000000044a047b7
>   [   77.939818] MPTCP: check_fully_established:fallback to TCP (msk=3D00=
0000000719adf6)
>   [   77.940238] MPTCP: msk=3D000000004c748421
>   [  140.366959] MPTCP: msk=3D000000000719adf6 snd_data_fin_enable=3D1 pe=
nding=3D0 snd_nxt=3D8514713421947747320 write_seq=3D8514713421947747320
>   [  140.366984] MPTCP: msk=3D000000000719adf6
> =

> This patch fixed it.
> =

> send_byte() is copied from tools/testing/selftests/bpf/prog_tests/tcp_rtt=
.c.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Thank you for the patch!

> ---
>   tools/testing/selftests/bpf/prog_tests/mptcp.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> =

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index 0e65d64868e9..fc97131ca397 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -8,6 +8,14 @@ struct mptcp_storage {
>   	__u32 is_mptcp;
>   };
>   =

> +static void send_byte(int fd)
> +{
> +	char b =3D 0x55;
> +
> +	if (CHECK_FAIL(write(fd, &b, sizeof(b)) !=3D 1))
> +		perror("Failed to send single byte");
> +}
> +
>   static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 =
is_mptcp)
>   {
>   	int err =3D 0, cfd =3D client_fd;
> @@ -76,6 +84,8 @@ static int run_test(int cgroup_fd, int server_fd, bool =
is_mptcp)
>   		goto close_client_fd;
>   	}
>   =

> +	send_byte(client_fd);

I don't see the link with the error you have. Is this a workaround? :)

I tried to reproduce the issue with packetdrill but I might need a =

packet trace and maybe info from strace to understand why you have this =

warning.

I guess that sending a byte forces the MPTCP connection to be in "fully =

established" mode which is not the case without and somehow caused the =

warning, no? Then here we are going through another path not to have the =

warning but there is still something wrong somewhere we might want to =

fix, no?

Cheers,
Matt

> +
>   	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket=
", 1) :
>   			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
>   =

> =


-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2920335789373422190==--
