Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF8EC08
	for <mptcp@lists.linux.dev>; Wed,  9 Nov 2022 18:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1668017737; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RUGd96cOxUnAEyv/y+EhRItBY+zMewqdRblxFP9GjM4bclNnHNxu1H+yMctd8oZzSRZ5ls1IDIIMblbR/UVd9F6X6oH/aPYpGf5IoiR+QWzVoaUYazJit/4YKeE/2r32tvFUuGjtQ5Gs74J6D8ePjVvGC6kqolSHKd4sdVLvbPY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1668017737; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=wkqZtS8uWfTMOxk7j2V7reL8yWtHHjFioycBKdsSFU4=; 
	b=WqQirgBuc6f5unMUsjw0XVGnJEJBw15qs4VinpxQF8aV9NJmyoDIcXNsX1ygWChkAa0ncaIGgbNlgQY4CNM9iYjwNqS1UIPZHbec2ISmfjF/9z+ahZeBMNk77oQHxPLFfKegYE/lZVr+ymshnxUzlKLf4C91LEer/0Y8qj98Eg4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1668017737;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=wkqZtS8uWfTMOxk7j2V7reL8yWtHHjFioycBKdsSFU4=;
	b=L1bD4fgEcx1GreJXbQcch+x467xgpinHDe4oiljuePsZwokv3z9s8Pi46ONyNrbO
	095jU2I8OH+e/bIWXtxuQxbSRwmYfywegOUdlNfhDsc8V/cxqiJImWImnXkIwttlpg1
	olvvSa1tuSEYLGP2KLlKc1Yf2RZFNnF4xkTy7qvo=
Received: from [10.8.0.6] (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1668017734850239.94213499619173; Wed, 9 Nov 2022 19:15:34 +0100 (CET)
Date: Wed, 9 Nov 2022 19:15:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH net-next] Squash-to: "selftests: mptcp: mptfo
 Initiator/Listener"
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <4edc02c8a8e040d0ac212ff61d9256c8148f2429.1667993416.git.pabeni@redhat.com>
 <41b40e837c47147ce713ae0d35a916471d36f82d.1667993466.git.pabeni@redhat.com>
Content-Language: fr
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <9c47d201-e38e-b0e2-6397-c612e679f16e@shytyi.net>
In-Reply-To: <41b40e837c47147ce713ae0d35a916471d36f82d.1667993466.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello Paolo,

Thank you very much for investing a time to improve the patch (including=20
the selftests)!

I'm very happy to see these commits. I'm glad to see that you pursued=20
the method of adding the sendto in the selftest.

Comments are in-line.

 =C2=A0Best,

Dmytro.

On 11/9/2022 3:52 PM, Paolo Abeni wrote:
> The TFO is allowed to send less data than the provided one,
> we need to track more status info to properly allow the next sendmsg()
> starting from the next to send byte.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   .../selftests/net/mptcp/mptcp_connect.c       | 118 ++++++++----------
>   1 file changed, 55 insertions(+), 63 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 4bc855159c52..134e569cd75a 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -26,13 +26,11 @@
>  =20
>   #include <netdb.h>
>   #include <netinet/in.h>
> -#include <netinet/tcp.h>
>  =20
> +#include <linux/tcp.h>
>   #include <linux/time_types.h>
>   #include <linux/sockios.h>
>  =20
> -
> -
>   extern int optind;
>  =20
>   #ifndef IPPROTO_MPTCP
> @@ -93,6 +91,12 @@ struct tcp_inq_state {
>   =09bool expect_eof;
>   };
>  =20
> +struct wstate {
> +=09char buf[8192];
> +=09unsigned int len;
> +=09unsigned int off;
> +};
> +
>   static struct tcp_inq_state tcp_inq;
>  =20
>   static struct cfg_cmsg_types cfg_cmsg_types;
> @@ -239,7 +243,7 @@ static void set_mptfo(int fd, int pf)
>   {
>   =09int qlen =3D 25;
>  =20
This is a nice replacement. No need modify the "include" anymore :)
> -=09if (setsockopt(fd, SOL_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) =3D=3D=
 -1)
> +=09if (setsockopt(fd, IPPROTO_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) =
=3D=3D -1)
>   =09=09perror("TCP_FASTOPEN");
>   }
>  =20
> @@ -345,17 +349,14 @@ static int sock_listen_mptcp(const char * const lis=
tenaddr,
>   static int sock_connect_mptcp(const char * const remoteaddr,
>   =09=09=09      const char * const port, int proto,
>   =09=09=09      struct addrinfo **peer,
> -=09=09=09      int infd,
> -=09=09=09      unsigned int *woff)
> +=09=09=09      int infd, struct wstate *winfo)
>   {
>   =09struct addrinfo hints =3D {
>   =09=09.ai_protocol =3D IPPROTO_TCP,
>   =09=09.ai_socktype =3D SOCK_STREAM,
>   =09};
>   =09struct addrinfo *a, *addr;
> -=09unsigned int wlen =3D 0;
>   =09int syn_copied =3D 0;
> -=09char wbuf[8192];
>   =09int sock =3D -1;
>  =20
>   =09hints.ai_family =3D pf;
> @@ -374,13 +375,15 @@ static int sock_connect_mptcp(const char * const re=
moteaddr,
>   =09=09=09set_mark(sock, cfg_mark);
>  =20
>   =09=09if (cfg_sockopt_types.mptfo) {

Below I used=C2=A0 (wlen =3D=3D 0) check to avoid possible multiple times=
=20
execution in the loop of double/triple/..-time offset of read(infd,).

Example: 1st enterance of the loop will read() from infd and set offset=20
0+X in infd, thus 2nd enterance of the loop will start reading from X, so

we could loose the previous data=C2=A0 (data between 0 and X) by attempting=
=20
the sendto in a loop.

Should we drop this check or this assumption is not relevant in the=20
current context?

> -=09=09=09if (wlen =3D=3D 0)
> -=09=09=09=09wlen =3D read(infd, wbuf, sizeof(wbuf));
> +=09=09=09winfo->len =3D read(infd, winfo->buf, sizeof(winfo->buf));
>  =20
> -=09=09=09syn_copied =3D sendto(sock, wbuf, wlen, MSG_FASTOPEN,
> +=09=09=09syn_copied =3D sendto(sock, winfo->buf, winfo->len, MSG_FASTOPE=
N,
>   =09=09=09=09=09    a->ai_addr, a->ai_addrlen);
> +=09=09=09if (syn_copied < 0)
> +=09=09=09=09perror("sendto");
>   =09=09=09if (syn_copied) {
> -=09=09=09=09*woff =3D wlen;
> +=09=09=09=09winfo->off =3D syn_copied;
> +=09=09=09=09winfo->len -=3D syn_copied;
>   =09=09=09=09*peer =3D a;
>   =09=09=09=09break; /* success */
>   =09=09=09}
> @@ -610,14 +613,13 @@ static void shut_wr(int fd)
>   }
>  =20
>   static int copyfd_io_poll(int infd, int peerfd, int outfd,
> -=09=09=09  bool *in_closed_after_out, unsigned int woff)
> +=09=09=09  bool *in_closed_after_out, struct wstate *winfo)
>   {
>   =09struct pollfd fds =3D {
>   =09=09.fd =3D peerfd,
>   =09=09.events =3D POLLIN | POLLOUT,
>   =09};
> -=09unsigned int wlen =3D 0, total_wlen =3D 0, total_rlen =3D 0;
> -=09char wbuf[8192];
> +=09unsigned int total_wlen =3D 0, total_rlen =3D 0;
>  =20
>   =09set_nonblock(peerfd, true);
>  =20
> @@ -677,19 +679,19 @@ static int copyfd_io_poll(int infd, int peerfd, int=
 outfd,
>   =09=09}
>  =20
>   =09=09if (fds.revents & POLLOUT) {
> -=09=09=09if (wlen =3D=3D 0) {
> -=09=09=09=09woff =3D 0;
> -=09=09=09=09wlen =3D read(infd, wbuf, sizeof(wbuf));
> +=09=09=09if (winfo->len =3D=3D 0) {
> +=09=09=09=09winfo->off =3D 0;
> +=09=09=09=09winfo->len =3D read(infd, winfo->buf, sizeof(winfo->buf));
>   =09=09=09}
>  =20
> -=09=09=09if (wlen > 0) {
> +=09=09=09if (winfo->len > 0) {
>   =09=09=09=09ssize_t bw;
>  =20
>   =09=09=09=09/* limit the total amount of written data to the trunc valu=
e */
> -=09=09=09=09if (cfg_truncate > 0 && wlen + total_wlen > cfg_truncate)
> -=09=09=09=09=09wlen =3D cfg_truncate - total_wlen;
> +=09=09=09=09if (cfg_truncate > 0 && winfo->len + total_wlen > cfg_trunca=
te)
> +=09=09=09=09=09winfo->len =3D cfg_truncate - total_wlen;
>  =20
> -=09=09=09=09bw =3D do_rnd_write(peerfd, wbuf + woff, wlen);
I also attempted to modify like is presented here (below). But in my=20
case I observed negative impacting on other tests, so in conclusion, It=20
is nice to see that you did it like this :)
> +=09=09=09=09bw =3D do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->=
len);
>   =09=09=09=09if (bw < 0) {
>   =09=09=09=09=09if (cfg_rcv_trunc)
>   =09=09=09=09=09=09return 0;
> @@ -697,10 +699,10 @@ static int copyfd_io_poll(int infd, int peerfd, int=
 outfd,
>   =09=09=09=09=09return 111;
>   =09=09=09=09}
>  =20
> -=09=09=09=09woff +=3D bw;
> -=09=09=09=09wlen -=3D bw;
> +=09=09=09=09winfo->off +=3D bw;
> +=09=09=09=09winfo->len -=3D bw;
>   =09=09=09=09total_wlen +=3D bw;
> -=09=09=09} else if (wlen =3D=3D 0) {
> +=09=09=09} else if (winfo->len =3D=3D 0) {
>   =09=09=09=09/* We have no more data to send. */
>   =09=09=09=09fds.events &=3D ~POLLOUT;
>  =20
> @@ -878,7 +880,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, i=
nt outfd,
>   =09return err;
>   }
>  =20
> -static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd,=
 unsigned int woff)
> +static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd,=
 struct wstate *winfo)
>   {
>   =09bool in_closed_after_out =3D false;
>   =09struct timespec start, end;
> @@ -890,7 +892,7 @@ static int copyfd_io(int infd, int peerfd, int outfd,=
 bool close_peerfd, unsigne
>  =20
>   =09switch (cfg_mode) {
>   =09case CFG_MODE_POLL:
> -=09=09ret =3D copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, =
woff);
> +=09=09ret =3D copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, =
winfo);
>   =09=09break;
>  =20
>   =09case CFG_MODE_MMAP:
> @@ -1038,6 +1040,7 @@ static void maybe_close(int fd)
>   int main_loop_s(int listensock)
>   {
>   =09struct sockaddr_storage ss;
> +=09struct wstate winfo;
>   =09struct pollfd polls;
>   =09socklen_t salen;
>   =09int remotesock;
> @@ -1072,7 +1075,8 @@ int main_loop_s(int listensock)
>  =20
>   =09=09SOCK_TEST_TCPULP(remotesock, 0);
>  =20
> -=09=09copyfd_io(fd, remotesock, 1, true, 0);
> +=09=09memset(&winfo, 0, sizeof(winfo));
> +=09=09copyfd_io(fd, remotesock, 1, true, &winfo);
>   =09} else {
>   =09=09perror("accept");
>   =09=09return 1;
> @@ -1210,53 +1214,40 @@ void xdisconnect(int fd, int addrlen)
>  =20
>   int main_loop(void)
>   {
> -=09int fd, ret, fd_in =3D 0;
> +=09int fd =3D 0, ret, fd_in =3D 0;
>   =09struct addrinfo *peer;
> -=09unsigned int woff =3D 0;
> -
> -=09if (!cfg_sockopt_types.mptfo) {
> -=09=09/* listener is ready. */
> -=09=09fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &pee=
r, 0, 0);
> -=09=09if (fd < 0)
> -=09=09=09return 2;
> -again:
> -=09=09check_getpeername_connect(fd);
> +=09struct wstate winfo;
>  =20
> -=09=09SOCK_TEST_TCPULP(fd, cfg_sock_proto);
> -
> -=09=09if (cfg_rcvbuf)
> -=09=09=09set_rcvbuf(fd, cfg_rcvbuf);
> -=09=09if (cfg_sndbuf)
> -=09=09=09set_sndbuf(fd, cfg_sndbuf);
> -=09=09if (cfg_cmsg_types.cmsg_enabled)
> -=09=09=09apply_cmsg_types(fd, &cfg_cmsg_types);
> -=09}
> -
> -=09if (cfg_input) {
> +=09if (cfg_input && cfg_sockopt_types.mptfo) {
>   =09=09fd_in =3D open(cfg_input, O_RDONLY);
>   =09=09if (fd < 0)
>   =09=09=09xerror("can't open %s:%d", cfg_input, errno);
>   =09}
>  =20
> -=09if (cfg_sockopt_types.mptfo) {
> -=09=09/* sendto() instead of connect */
> -=09=09fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &pee=
r, fd_in, &woff);
> -=09=09if (fd < 0)
> -=09=09=09return 2;
> +=09memset(&winfo, 0, sizeof(winfo));
> +=09fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, =
fd_in, &winfo);
> +=09if (fd < 0)
> +=09=09return 2;
>  =20
> -=09=09check_getpeername_connect(fd);
> +again:
> +=09check_getpeername_connect(fd);
>  =20
> -=09=09SOCK_TEST_TCPULP(fd, cfg_sock_proto);
> +=09SOCK_TEST_TCPULP(fd, cfg_sock_proto);
>  =20
> -=09=09if (cfg_rcvbuf)
> -=09=09=09set_rcvbuf(fd, cfg_rcvbuf);
> -=09=09if (cfg_sndbuf)
> -=09=09=09set_sndbuf(fd, cfg_sndbuf);
> -=09=09if (cfg_cmsg_types.cmsg_enabled)
> -=09=09=09apply_cmsg_types(fd, &cfg_cmsg_types);
> +=09if (cfg_rcvbuf)
> +=09=09set_rcvbuf(fd, cfg_rcvbuf);
> +=09if (cfg_sndbuf)
> +=09=09set_sndbuf(fd, cfg_sndbuf);
> +=09if (cfg_cmsg_types.cmsg_enabled)
> +=09=09apply_cmsg_types(fd, &cfg_cmsg_types);
> +
> +=09if (cfg_input && !cfg_sockopt_types.mptfo) {
> +=09=09fd_in =3D open(cfg_input, O_RDONLY);
> +=09=09if (fd < 0)
> +=09=09=09xerror("can't open %s:%d", cfg_input, errno);
>   =09}
>  =20
> -=09ret =3D copyfd_io(fd_in, fd, 1, 0, 0);
> +=09ret =3D copyfd_io(fd_in, fd, 1, 0, &winfo);
>   =09if (ret)
>   =09=09return ret;
>  =20
> @@ -1273,6 +1264,7 @@ int main_loop(void)
>   =09=09=09xerror("can't reconnect: %d", errno);
>   =09=09if (cfg_input)
>   =09=09=09close(fd_in);
> +=09=09memset(&winfo, 0, sizeof(winfo));
>   =09=09goto again;
>   =09} else {
>   =09=09close(fd);

