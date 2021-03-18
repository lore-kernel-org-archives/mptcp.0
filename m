Content-Type: multipart/mixed; boundary="===============2353952638170775604=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "bpf:selftests: add
 MPTCP test base"
Date: Thu, 18 Mar 2021 12:31:21 +0800
Message-ID: <CA+WQbwu9+5Wr=R5q=UNrO0-0ARoEhOiRsMKMOBqA1VzWDr9=hA@mail.gmail.com>
In-Reply-To: 5640c9c8-ec11-7706-44e3-14d4317f8235@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8207

--===============2353952638170775604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for your review.

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:45=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang,
>
> On 17/03/2021 13:11, Geliang Tang wrote:
> > When I ran the bpf mptcp test "./test_progs -n 67", I got a "fallback to
> > TCP" error in kernel log:
> >
> >   [   77.939497] MPTCP: msk=3D00000000e58fbe96
> >   [   77.939534] IPv4: Attempt to release TCP socket in state 8 0000000=
0e58fbe96
> >   [   77.939807] MPTCP: subflow_req=3D0000000044a047b7
> >   [   77.939818] MPTCP: check_fully_established:fallback to TCP (msk=3D=
000000000719adf6)
> >   [   77.940238] MPTCP: msk=3D000000004c748421
> >   [  140.366959] MPTCP: msk=3D000000000719adf6 snd_data_fin_enable=3D1 =
pending=3D0 snd_nxt=3D8514713421947747320 write_seq=3D8514713421947747320
> >   [  140.366984] MPTCP: msk=3D000000000719adf6
> >
> > This patch fixed it.
> >
> > send_byte() is copied from tools/testing/selftests/bpf/prog_tests/tcp_r=
tt.c.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>
> Thank you for the patch!
>
> > ---
> >   tools/testing/selftests/bpf/prog_tests/mptcp.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/tes=
ting/selftests/bpf/prog_tests/mptcp.c
> > index 0e65d64868e9..fc97131ca397 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -8,6 +8,14 @@ struct mptcp_storage {
> >       __u32 is_mptcp;
> >   };
> >
> > +static void send_byte(int fd)
> > +{
> > +     char b =3D 0x55;
> > +
> > +     if (CHECK_FAIL(write(fd, &b, sizeof(b)) !=3D 1))
> > +             perror("Failed to send single byte");
> > +}
> > +
> >   static int verify_sk(int map_fd, int client_fd, const char *msg, __u3=
2 is_mptcp)
> >   {
> >       int err =3D 0, cfd =3D client_fd;
> > @@ -76,6 +84,8 @@ static int run_test(int cgroup_fd, int server_fd, boo=
l is_mptcp)
> >               goto close_client_fd;
> >       }
> >
> > +     send_byte(client_fd);
>
> I don't see the link with the error you have. Is this a workaround? :)

It's not a workaround, this "send_byte" is somehow missing in this test.
The send_byte is in the file (tools/testing/selftests/bpf/prog_tests/
tcp_rtt.c), and our test (tools/testing/selftests/bpf/prog_tests/mptcp.c)
is somehow derived from tcp_rtt.c.

>
> I tried to reproduce the issue with packetdrill but I might need a
> packet trace and maybe info from strace to understand why you have this
> warning.

It's easy to reproduce this issue:

1. Enable CONFIG_DEBUG_INFO_BTF and build the kernel.
2. build the bpf test_progs:
cd tools/testing/selftests/bpf
make
3. run the mptcp test:
sudo ./test_progs -n 67
4. get the kernel log:
dmesg

Anyway, I added the full kernel log in v2.

>
> I guess that sending a byte forces the MPTCP connection to be in "fully
> established" mode which is not the case without and somehow caused the
> warning, no? Then here we are going through another path not to have the
> warning but there is still something wrong somewhere we might want to
> fix, no?

No, I think there's no anything wrong somewhere, just this use-space test
is a little problematic. This fix is enough.

In v2, I fixed the "Attempt to release TCP socket in state 8" error too.

-Geliang


>
> Cheers,
> Matt
>
> > +
> >       err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow s=
ocket", 1) :
> >                         verify_sk(map_fd, client_fd, "plain TCP socket"=
, 0);
> >
> >
>
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============2353952638170775604==--
