Content-Type: multipart/mixed; boundary="===============8275956181320992465=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: switch to netns+veth based tests
Date: Mon, 29 Apr 2019 16:29:53 -0700
Message-ID: <alpine.OSX.2.21.1904291626020.5723@mjmartin-mac01.local>
In-Reply-To: 20190429145218.20686-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1102

--===============8275956181320992465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2019, Florian Westphal wrote:

> ... so we can exercise PMTU and MSS handling.
> MTU on lo is 64k, so we never had to deal with segmentation either.
>
> This also avoids problems with timewait state in inet_ns,
> all net namespaces are torn down before script exits.
>
> This uncovers several bugs:
> 1. mptcp_init_sock() passes init_net instead of sock_net(sk), i.e.
>   network namespaces are not supported
> 2. We corrupt tcp option space, I can see invalid tcp headers (too
>   short) in tcpdump, and receiver process hangs without getting the
>   data (poll timeout).
>   Seems to be gone after adding
>
>    if (size =3D=3D MAX_TCP_OPTION_SPACE)
>          return size;
>
>    BUG(size > MAX_TCP_OPTION_SPACE);
>
>    in tcp_established_options() after writing mptcp options.
>    SACK writing doesn't handle 'no option space left' case.
> 3. Several WARN_ON from networking core are triggered, e.g. due
>   to mem accouting being off.  Maybe fixed already with pending
>   locking fix in mptcp_recv.
> 4. "Replaced mapping before it was done" in dmesg.
> 5. receiver blocking in read(), while TCP socket is in CLOSE-WAIT.
>   wait_woken+0xd6/0x170
>   sk_wait_data+0x248/0x270
>   mptcp_recvmsg+0x5c0/0xd50
> 6. kmemleak gets noisy, we probably leak a refcount somewhere (iirc
>   Davide is already working on this).
> 7. crash on connect completion, probably same bug that Paolo reported
>   already.
>
> As the script did not yet turn up any problem when using only
> tcp, it appears these are MPTCP related bugs rather than with script
> or mptcp_connect.c .
>
> Once above issues are fixed, this will be extended again to
> set different/varying MTU in ns1 and ns4.

Florian -

Thanks for the selftest update and looking in to the errors and warnings. =

I didn't include this in RFCv10 but I can append it to the patch series =

tomorrow and see what I can reproduce with RFCv10.

Regards,

Mat


>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> .../selftests/net/mptcp/mptcp_connect.c       | 303 +++++++++---------
> .../selftests/net/mptcp/mptcp_connect.sh      | 208 ++++++++++--
> 2 files changed, 336 insertions(+), 175 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 2830a63ce64e..360b698e5ddd 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -26,16 +26,19 @@ extern int optind;
> #define IPPROTO_MPTCP 99
> #endif
>
> +static bool listen_mode;
> +static int  poll_timeout;
> +
> static const char *cfg_host;
> static const char *cfg_port	=3D "12000";
> -static int cfg_server_proto	=3D IPPROTO_MPTCP;
> -static int cfg_client_proto	=3D IPPROTO_MPTCP;
> +static int cfg_sock_proto	=3D IPPROTO_MPTCP;
> +
>
> static void die_usage(void)
> {
> -	fprintf(stderr, "Usage: mptcp_connect [-c MPTCP|TCP] [-p port] "
> -	        "[-s MPTCP|TCP]\n");
> -	exit(-1);
> +	fprintf(stderr, "Usage: mptcp_connect [-s MPTCP|TCP] [-p port] "
> +		"[ -l ] [ -t timeout ] connect_address\n");
> +	exit(1);
> }
>
> static const char *getxinfo_strerr(int err)
> @@ -76,16 +79,13 @@ static int sock_listen_mptcp(const char * const liste=
naddr, const char * const p
> 	xgetaddrinfo(listenaddr, port, &hints, &addr);
>
> 	for (a =3D addr; a !=3D NULL ; a =3D a->ai_next) {
> -		sock =3D socket(a->ai_family, a->ai_socktype, cfg_server_proto);
> -		if (sock < 0) {
> -			perror("socket");
> +		sock =3D socket(a->ai_family, a->ai_socktype, cfg_sock_proto);
> +		if (sock < 0)
> 			continue;
> -		}
>
> 		if (-1 =3D=3D setsockopt(sock, SOL_SOCKET,SO_REUSEADDR,&one,sizeof one))
> 			perror("setsockopt");
>
> -
> 		if (bind(sock, a->ai_addr, a->ai_addrlen) =3D=3D 0)
> 			break; /* success */
>
> @@ -94,10 +94,19 @@ static int sock_listen_mptcp(const char * const liste=
naddr, const char * const p
> 		sock =3D -1;
> 	}
>
> -	if ((sock >=3D 0) && listen(sock ,20))
> +	freeaddrinfo(addr);
> +
> +	if (sock < 0) {
> +		fprintf(stderr, "Could not create listen socket\n");
> +		return sock;
> +	}
> +
> +	if (listen(sock, 20)) {
> 		perror("listen");
> +		close(sock);
> +		return -1;
> +	}
>
> -	freeaddrinfo(addr);
> 	return sock;
> }
>
> @@ -132,7 +141,7 @@ static int sock_connect_mptcp(const char * const remo=
teaddr, const char * const
> 	return sock;
> }
>
> -static size_t do_write(const int fd, char *buf, const size_t len)
> +static size_t do_rnd_write(const int fd, char *buf, const size_t len)
> {
> 	size_t offset =3D 0;
>
> @@ -157,62 +166,141 @@ static size_t do_write(const int fd, char *buf, co=
nst size_t len)
> 	return offset;
> }
>
> -static void copyfd_io(int peerfd)
> +static size_t do_write(const int fd, char *buf, const size_t len)
> +{
> +	size_t offset =3D 0;
> +
> +	while (offset < len) {
> +		size_t written;
> +		ssize_t bw;
> +
> +		bw =3D write(fd, buf+offset, len - offset);
> +		if (bw < 0 ) {
> +			perror("write");
> +			return 0;
> +		}
> +
> +		written =3D (size_t) bw;
> +		offset +=3D written;
> +	}
> +
> +	return offset;
> +}
> +
> +static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
> {
> -	struct pollfd fds =3D { .events =3D POLLIN };
> +	size_t cap =3D rand();
> +
> +	cap &=3D 0xffff;
>
> -	fds.fd =3D peerfd;
> +	if (cap =3D=3D 0)
> +		cap =3D 1;
> +	else if (cap > len)
> +		cap =3D len;
> +
> +	return read(fd, buf, cap);
> +}
> +
> +static int copyfd_io(int infd, int peerfd, int outfd)
> +{
> +	struct pollfd fds =3D {
> +		.fd =3D peerfd,
> +		.events =3D POLLIN | POLLOUT,
> +	};
>
> 	for (;;) {
> -		char buf[4096];
> +		char buf[8192];
> 		ssize_t len;
>
> -		switch(poll(&fds, 1, -1)) {
> +		if (fds.events =3D=3D 0)
> +			break;
> +
> +		switch (poll(&fds, 1, poll_timeout)) {
> 		case -1:
> 			if (errno =3D=3D EINTR)
> 				continue;
> 			perror("poll");
> -			return;
> +			return 1;
> 		case 0:
> -			/* should not happen, we requested infinite wait */
> -			fputs("Timed out?!", stderr);
> -			return;
> +			fprintf(stderr, "%s: poll timed out (events: POLLIN %u, POLLOUT %u)\n=
",
> +					__func__, fds.events & POLLIN, fds.events & POLLOUT);
> +			return 2;
> 		}
>
> -		if ((fds.revents & POLLIN) =3D=3D 0)
> -			return;
> +		if (fds.revents & POLLIN) {
> +			len =3D do_rnd_read(peerfd, buf, sizeof(buf));
> +			if (len =3D=3D 0) {
> +				/* no more data to receive: peer has closed its write side */
> +				fds.events &=3D ~POLLIN;
>
> -		len =3D read(peerfd, buf, sizeof(buf));
> -		if (!len)
> -			return;
> -		if (len < 0) {
> -			if (errno =3D=3D EINTR)
> -				continue;
> +				if ((fds.events & POLLOUT) =3D=3D 0)
> +					break; /* and nothing more to send */
>
> -			perror("read");
> -			return;
> -		}
> +				/* Else, still have data to transmit */
> +			} else if (len < 0) {
> +				perror("read");
> +				return 3;
> +			}
>
> -		if (!do_write(peerfd, buf, len))
> -			return;
> +			do_write(outfd, buf, len);
> +		}
>
> +		if (fds.revents & POLLOUT) {
> +			len =3D do_rnd_read(infd, buf, sizeof(buf));
> +			if (len > 0) {
> +				if (!do_rnd_write(peerfd, buf, len))
> +					return 111;
> +			} else if (len =3D=3D 0) {
> +				/* We have no more data to send. */
> +				fds.events &=3D ~POLLOUT;
> +
> +				if ((fds.events & POLLIN) =3D=3D 0)
> +					break; /* ... and peer also closed already */
> +
> +				/* ... but we still receive. Close our write side. */
> +				shutdown(peerfd, SHUT_WR);
> +			} else {
> +				if (errno =3D=3D EINTR)
> +					continue;
> +				perror("read");
> +				return 4;
> +			}
> +		}
> 	}
> +
> +	close(peerfd);
> +	return 0;
> }
>
> int main_loop_s(int listensock)
> {
> 	struct sockaddr_storage ss;
> +	struct pollfd polls;
> 	socklen_t salen;
>         int remotesock;
>
> -	salen =3D sizeof(ss);
> -	while ((remotesock =3D accept(listensock, (struct sockaddr *)&ss, &sale=
n)) < 0)
> -		perror("accept");
> +	polls.fd =3D listensock;
> +	polls.events =3D POLLIN;
>
> -	copyfd_io(remotesock);
> -	close(remotesock);
> +	switch (poll(&polls, 1, poll_timeout)) {
> +	case -1:
> +		perror("poll");
> +		return 1;
> +	case 0:
> +		fprintf(stderr, "%s: timed out\n", __func__);
> +		close(listensock);
> +		return 2;
> +	}
>
> -	return 0;
> +	salen =3D sizeof(ss);
> +	remotesock =3D accept(listensock, (struct sockaddr *)&ss, &salen);
> +	if (remotesock >=3D 0) {
> +		copyfd_io(0, remotesock, 1);
> +		return 0;
> +	} else {
> +		perror("accept");
> +		return 1;
> +	}
> }
>
> static void init_rng(void)
> @@ -221,7 +309,9 @@ static void init_rng(void)
> 	unsigned int foo;
>
> 	if (fd > 0) {
> -		read(fd, &foo, sizeof(foo));
> +		int ret =3D read(fd, &foo, sizeof(foo));
> +		if (ret < 0)
> +			srand(fd + foo);
> 		close(fd);
> 	}
>
> @@ -230,112 +320,14 @@ static void init_rng(void)
>
> int main_loop()
> {
> -	int pollfds =3D 2, timeout =3D -1;
> -	char start[32];
> -	int pipefd[2];
> -	ssize_t ret;
> 	int fd;
>
> -	if (pipe(pipefd)) {
> -		perror("pipe");
> -		exit(1);
> -	}
> -
> -	switch (fork()) {
> -	case 0:
> -		close(pipefd[0]);
> -
> -		init_rng();
> -
> -		fd =3D sock_listen_mptcp(NULL, cfg_port);
> -		if (fd < 0)
> -			return -1;
> -
> -		write(pipefd[1], "RDY\n", 4);
> -		main_loop_s(fd);
> -		exit(1);
> -	case -1:
> -		perror("fork");
> -		return -1;
> -	default:
> -		close(pipefd[1]);
> -		break;
> -	}
> -
> -	init_rng();
> -	ret =3D read(pipefd[0], start, (int)sizeof(start));
> -	if (ret < 0) {
> -		perror("read");
> -		return -1;
> -	}
> -
> -	if (ret !=3D 4 || strcmp(start, "RDY\n"))
> -		return -1;
> -
> 	/* listener is ready. */
> -	fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_client_proto);
> +	fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto);
> 	if (fd < 0)
> -		return -1;
> -
> -	for (;;) {
> -		struct pollfd fds[2];
> -		char buf[4096];
> -		ssize_t len;
> -
> -		fds[0].fd =3D fd;
> -		fds[0].events =3D POLLIN;
> -		fds[1].fd =3D 0;
> -		fds[1].events =3D POLLIN;
> -		fds[1].revents =3D 0;
> -
> -		switch (poll(fds, pollfds, timeout)) {
> -		case -1:
> -			if (errno =3D=3D EINTR)
> -				continue;
> -			perror("poll");
> -			return -1;
> -		case 0:
> -			close(fd);
> -			return 0;
> -		}
> -
> -		if (fds[0].revents & POLLIN) {
> -			unsigned int blen =3D rand();
> -
> -			blen %=3D sizeof(buf);
> -
> -			++blen;
> -			len =3D read(fd, buf, blen);
> -			if (len < 0) {
> -				perror("read");
> -				return -1;
> -			}
> -
> -			if (len > blen) {
> -				fprintf(stderr, "read returned more data than buffer length\n");
> -				len =3D blen;
> -			}
> -
> -			write(1, buf, len);
> -		}
> -		if (fds[1].revents & POLLIN) {
> -			len =3D read(0, buf, sizeof(buf));
> -			if (len =3D=3D 0) {
> -				pollfds =3D 1;
> -				timeout =3D 1000;
> -				continue;
> -			}
> -
> -			if (len < 0) {
> -				perror("read");
> -				break;
> -			}
> +		return 2;
>
> -			do_write(fd, buf, len);
> -		}
> -	}
> -
> -	return 1;
> +	return copyfd_io(0, fd, 1);
> }
>
> int parse_proto(const char *proto)
> @@ -344,6 +336,8 @@ int parse_proto(const char *proto)
> 		return IPPROTO_MPTCP;
> 	if (!strcasecmp(proto, "TCP"))
> 		return IPPROTO_TCP;
> +
> +	fprintf(stderr, "Unknown protocol: %s.", proto);
> 	die_usage();
>
> 	/* silence compiler warning */
> @@ -354,20 +348,25 @@ static void parse_opts(int argc, char **argv)
> {
> 	int c;
>
> -	while ((c =3D getopt(argc, argv, "c:p:s:h")) !=3D -1) {
> +	while ((c =3D getopt(argc, argv, "lp:s:ht:")) !=3D -1) {
> 		switch (c) {
> -		case 'c':
> -			cfg_client_proto =3D parse_proto(optarg);
> +		case 'l':
> +			listen_mode =3D true;
> 			break;
> 		case 'p':
> 			cfg_port =3D optarg;
> 			break;
> 		case 's':
> -			cfg_server_proto =3D parse_proto(optarg);
> +			cfg_sock_proto =3D parse_proto(optarg);
> 			break;
> 		case 'h':
> 			die_usage();
> 			break;
> +		case 't':
> +			poll_timeout=3Datoi(optarg) * 1000;
> +			if (poll_timeout <=3D 0)
> +				poll_timeout =3D -1;
> +			break;
> 		}
> 	}
>
> @@ -376,11 +375,19 @@ static void parse_opts(int argc, char **argv)
> 	cfg_host =3D argv[optind];
> }
>
> -
> int main(int argc, char *argv[])
> {
> 	init_rng();
>
> 	parse_opts(argc, argv);
> +
> +	if (listen_mode) {
> +		int fd =3D sock_listen_mptcp(cfg_host, cfg_port);
> +		if (fd < 0)
> +			return 1;
> +
> +		return main_loop_s(fd);
> +	}
> +
> 	return main_loop();
> }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index ec64e95a6d35..0f283cd37225 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -1,46 +1,200 @@
> #!/bin/bash
>
> -tmpin=3D$(mktemp)
> -tmpout=3D$(mktemp)
> +ret=3D0
> +sin=3D""
> +sout=3D""
> +cin=3D""
> +cout=3D""
> +ksft_skip=3D4
> +
> +TEST_COUNT=3D0
>
> cleanup()
> {
> -	rm -f "$tmpin" "$tmpout"
> +	rm -f "$cin" "$cout"
> +	rm -f "$sin" "$sout"
> +
> +	for i in 1 2 3 4; do
> +		ip netns del ns$i
> +	done
> +}
> +
> +ip -Version > /dev/null 2>&1
> +if [ $? -ne 0 ];then
> +	echo "SKIP: Could not run test without ip tool"
> +	exit $ksft_skip
> +fi
> +
> +sin=3D$(mktemp)
> +sout=3D$(mktemp)
> +cin=3D$(mktemp)
> +cout=3D$(mktemp)
> +trap cleanup EXIT
> +
> +for i in 1 2 3 4;do
> +	ip netns add ns$i || exit $ksft_skip
> +	ip -net ns$i link set lo up
> +done
> +
> +#  ns1            ns2                 ns3             ns4
> +# ns1eth2    ns2eth1 ns2eth3  ns3eth2   ns3eth4   ns4eth3
> +
> +ip link add ns1eth2 netns ns1 type veth peer name ns2eth1 netns ns2
> +ip link add ns2eth3 netns ns2 type veth peer name ns3eth2 netns ns3
> +ip link add ns3eth4 netns ns3 type veth peer name ns4eth3 netns ns4
> +
> +ip -net ns1 addr add 10.0.1.1/24 dev ns1eth2
> +ip -net ns1 link set ns1eth2 up
> +ip -net ns1 route add default via 10.0.1.2
> +
> +ip -net ns2 addr add 10.0.1.2/24 dev ns2eth1
> +ip -net ns2 link set ns2eth1 up
> +
> +ip -net ns2 addr add 10.0.2.1/24 dev ns2eth3
> +ip -net ns2 link set ns2eth3 up
> +ip -net ns2 route add default via 10.0.2.2
> +ip netns exec ns2 sysctl -q net.ipv4.ip_forward=3D1
> +
> +ip -net ns3 addr add 10.0.2.2/24 dev ns3eth2
> +ip -net ns3 link set ns3eth2 up
> +
> +ip -net ns3 addr add 10.0.3.2/24 dev ns3eth4
> +ip -net ns3 link set ns3eth4 up
> +ip -net ns3 route add default via 10.0.2.1
> +ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
> +
> +ip -net ns4 addr add 10.0.3.1/24 dev ns4eth3
> +ip -net ns4 link set ns4eth3 up
> +ip -net ns4 route add default via 10.0.3.2
> +
> +print_file_err()
> +{
> +	ls -l "$1" 1>&2
> +	echo "Trailing bytes are: "
> +	tail -c 27 "$1"
> }
>
> check_transfer()
> {
> -	cl_proto=3D${1}
> -	srv_proto=3D${2}
> +	in=3D$1
> +	out=3D$2
> +	what=3D$3
>
> -	printf "%-8s -> %-8s socket\t\t" ${cl_proto} ${srv_proto}
> +	cmp "$in" "$out" > /dev/null 2>&1
> +	if [ $? -ne 0 ] ;then
> +		echo "[ FAIL ] $what does not match (in, out):"
> +		print_file_err "$in"
> +		print_file_err "$out"
>
> -	./mptcp_connect -c ${cl_proto} -p 43212 -s ${srv_proto} 127.0.0.1  < "$=
tmpin" > "$tmpout" 2>/dev/null
> -	ret=3D$?
> -	if [ ${ret} -ne 0 ]; then
> -		echo "[ FAIL ]"
> -		return " exit code $ret"
> +		return 1
> 	fi
> -	cmp "$tmpin" "$tmpout" > /dev/null 2>&1
> -	if [ $? -ne 0 ] ;then
> -		echo "[ FAIL ]"
> -		ls -l "$tmpin" "$tmpout" 1>&2
> -	else
> -		echo "[  OK  ]"
> +
> +	return 0
> +}
> +
> +do_transfer()
> +{
> +	listener_ns=3D"$1"
> +	connector_ns=3D"$2"
> +	cl_proto=3D"$3"
> +	srv_proto=3D"$4"
> +	connect_addr=3D"$5"
> +
> +	port=3D$((10000+$TEST_COUNT))
> +	TEST_COUNT=3D$((TEST_COUNT+1))
> +
> +	:> "$cout"
> +	:> "$sout"
> +	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
> +	if [ $? -ne 0 ] ; then
> +		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
> +		return 1
> 	fi
> +
> +	printf "%-4s %-5s -> %-4s (%s:%d) %-5s\t" ${connector_ns} ${cl_proto} $=
{listener_ns} ${connect_addr} ${port} ${srv_proto}
> +
> +	ip netns exec ${listener_ns} ./mptcp_connect -t 10 -l -p $port -s ${srv=
_proto} 0.0.0.0 < "$sin" > "$sout" &
> +	spid=3D$!
> +
> +	sleep 1
> +
> +	ip netns exec ${connector_ns} ./mptcp_connect -t 10 -p $port -s ${cl_pr=
oto} $connect_addr < "$cin" > "$cout" &
> +	cpid=3D$!
> +
> +	wait $cpid
> +	retc=3D$?
> +	wait $spid
> +	rets=3D$?
> +
> +	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
> +		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
> +		echo "\nnetns ${listener_ns} socket stat for $port:" 1>&2
> +		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport =3D :$port"
> +		echo "\nnetns ${connector_ns} socket stat for $port:" 1>&2
> +		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
> +
> +		ret=3D$rets
> +		return 1
> +	fi
> +
> +	check_transfer $sin $cout "file received by client"
> +	retc=3D$?
> +	check_transfer $cin $sout "file received by server"
> +	rets=3D$?
> +
> +	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
> +		echo "[ OK ]"
> +		return 0
> +	fi
> +
> +	return 1
> }
>
> -trap cleanup EXIT
> +make_file()
> +{
> +	name=3D$1
> +	who=3D$2
>
> -SIZE=3D$((RANDOM % (1024 * 1024)))
> -if [ $SIZE -eq 0 ] ; then
> -	SIZE=3D1
> -fi
> +	SIZE=3D$((RANDOM % (1024 * 8)))
> +	TSIZE=3D$((SIZE * 1024))
> +
> +	dd if=3D/dev/urandom of=3D"$name" bs=3D1024 count=3D$SIZE 2> /dev/null
> +
> +	SIZE=3D$((RANDOM % 1024))
> +	SIZE=3D$((SIZE + 128))
> +	TSIZE=3D$((TSIZE + SIZE))
> +	dd if=3D/dev/urandom conf=3Dnotrunc of=3D"$name" bs=3D1 count=3D$SIZE 2=
> /dev/null
> +	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
> +
> +	echo "Created $name (size $TSIZE) containing data sent by $who"
> +}
> +
> +run_tests()
> +{
> +        listener_ns=3D"$1"
> +        connector_ns=3D"$2"
> +	connect_addr=3D"$3"
> +
> +	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
> +	[ $? -ne 0 ] && return
> +	do_transfer ${listener_ns} ${connector_ns} MPTCP TCP ${connect_addr}
> +	[ $? -ne 0 ] && return
> +	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP ${connect_addr}
> +}
> +
> +make_file "$cin" "client"
> +make_file "$sin" "server"
> +
> +for sender in 1 2 3 4;do
> +	run_tests ns1 ns$sender 10.0.1.1
> +
> +	run_tests ns2 ns$sender 10.0.1.2
> +	run_tests ns2 ns$sender 10.0.2.1
>
> -dd if=3D/dev/urandom of=3D"$tmpin" bs=3D1 count=3D$SIZE 2> /dev/null
> +	run_tests ns3 ns$sender 10.0.2.2
> +	run_tests ns3 ns$sender 10.0.3.2
>
> -check_transfer MPTCP MPTCP
> -check_transfer MPTCP TCP
> -check_transfer TCP MPTCP
> +	run_tests ns4 ns$sender 10.0.3.1
> +done
>
> -exit 0
> +exit $ret
> -- =

> 2.21.0
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============8275956181320992465==--
