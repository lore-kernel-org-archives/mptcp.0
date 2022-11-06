Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8BEAD49
	for <mptcp@lists.linux.dev>; Sun,  6 Nov 2022 20:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1667767812; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jtk8gaZNiRDf7KS6z/HVxIavr3C9GXhBv9auWRIhePmHMngQAy9BTNiBXrt1CVK8hdi3pCvuxe3s6wYRhIABMZlNOq394HT0t7cuHiops3+Z8u9r4zCgA+fq0EMjq3E455mhw/iPr1wGJ2aHnzyYFPKUbxuKHqK2sPc4MKp5HmI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1667767812; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Bv+lgwFJ/QYDkMp0laLoFwjjElDMYqYnCSP+D22LyfQ=; 
	b=E4+lA9JAPh0EWZpLObapTb2TXoQ+jo5wsmJy1jivw0mTqzXkZPS13GFq6CeAd/AjaAC9inY90z26wKebctJXlkT3r1TnLXxaVDcZQzD0NVdVPbPNiXHvWugu9W4+jyfhG7RPAL1qqQZJNcLs9YYphgwhPtE6kp0l+9gAQH2mCfg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1667767812;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Bv+lgwFJ/QYDkMp0laLoFwjjElDMYqYnCSP+D22LyfQ=;
	b=DCzkeUbfRemGsYCT9Fdl3NKvwlUD5AvIrFzBp7xk0TjZZ2uSqMYsJ71+gkXlk8Hb
	20IZW/f4AJRq2hailNRACLTxF1KPGWiJUuka5p/zatTo6Y757zN3RpfGbtGn140tz80
	uZgckF2Alu5NTfCXPpsNVlRG3fuZLCET8aWae3vY=
Received: from [10.8.0.6] (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1667767810015952.5523577982879; Sun, 6 Nov 2022 21:50:10 +0100 (CET)
Message-ID: <5ea8631f-c975-35a9-d717-b6ea3991f952@shytyi.net>
Date: Sun, 6 Nov 2022 21:50:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH mptcp-next v15 5/5] selftests: mptcp: mptfo
 Initiator/Listener
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
References: <20221106152411.655-1-dmytro@shytyi.net>
 <20221106152411.655-6-dmytro@shytyi.net>
Content-Language: fr
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <20221106152411.655-6-dmytro@shytyi.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello all,

@Matthieu Baerts,

Please find the first packetdrill test in this github repo: 
https://github.com/dmytroshytyi/MPTFO

Precisely,

*.pkt:

https://github.com/dmytroshytyi/MPTFO/blob/main/client-MSG_FASTOPEN.pkt

and result of test execution:

https://github.com/dmytroshytyi/MPTFO/blob/main/packetdrill-sender-test-result.png


Also I created a pull request in multipath-tcp/packetdrill:

https://github.com/multipath-tcp/packetdrill/pull/99


Best regards,

Dmytro SHYTYI.



On 11/6/2022 4:24 PM, Dmytro Shytyi wrote:
> This patch adds the selftests support for mptfo in mptcp_connect.c
> We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
> We call sendto() instead of connect().
>
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>   .../selftests/net/mptcp/mptcp_connect.c       | 121 +++++++++++++-----
>   .../selftests/net/mptcp/mptcp_connect.sh      |  21 +++
>   2 files changed, 113 insertions(+), 29 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index e54653ea2ed4..4bc855159c52 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -26,11 +26,13 @@
>   
>   #include <netdb.h>
>   #include <netinet/in.h>
> +#include <netinet/tcp.h>
>   
> -#include <linux/tcp.h>
>   #include <linux/time_types.h>
>   #include <linux/sockios.h>
>   
> +
> +
>   extern int optind;
>   
>   #ifndef IPPROTO_MPTCP
> @@ -83,6 +85,7 @@ struct cfg_cmsg_types {
>   
>   struct cfg_sockopt_types {
>   	unsigned int transparent:1;
> +	unsigned int mptfo:1;
>   };
>   
>   struct tcp_inq_state {
> @@ -232,6 +235,14 @@ static void set_transparent(int fd, int pf)
>   	}
>   }
>   
> +static void set_mptfo(int fd, int pf)
> +{
> +	int qlen = 25;
> +
> +	if (setsockopt(fd, SOL_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) == -1)
> +		perror("TCP_FASTOPEN");
> +}
> +
>   static int do_ulp_so(int sock, const char *name)
>   {
>   	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
> @@ -300,6 +311,9 @@ static int sock_listen_mptcp(const char * const listenaddr,
>   		if (cfg_sockopt_types.transparent)
>   			set_transparent(sock, pf);
>   
> +		if (cfg_sockopt_types.mptfo)
> +			set_mptfo(sock, pf);
> +
>   		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
>   			break; /* success */
>   
> @@ -330,13 +344,18 @@ static int sock_listen_mptcp(const char * const listenaddr,
>   
>   static int sock_connect_mptcp(const char * const remoteaddr,
>   			      const char * const port, int proto,
> -			      struct addrinfo **peer)
> +			      struct addrinfo **peer,
> +			      int infd,
> +			      unsigned int *woff)
>   {
>   	struct addrinfo hints = {
>   		.ai_protocol = IPPROTO_TCP,
>   		.ai_socktype = SOCK_STREAM,
>   	};
>   	struct addrinfo *a, *addr;
> +	unsigned int wlen = 0;
> +	int syn_copied = 0;
> +	char wbuf[8192];
>   	int sock = -1;
>   
>   	hints.ai_family = pf;
> @@ -354,14 +373,33 @@ static int sock_connect_mptcp(const char * const remoteaddr,
>   		if (cfg_mark)
>   			set_mark(sock, cfg_mark);
>   
> -		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0) {
> -			*peer = a;
> -			break; /* success */
> -		}
> +		if (cfg_sockopt_types.mptfo) {
> +			if (wlen == 0)
> +				wlen = read(infd, wbuf, sizeof(wbuf));
>   
> -		perror("connect()");
> -		close(sock);
> -		sock = -1;
> +			syn_copied = sendto(sock, wbuf, wlen, MSG_FASTOPEN,
> +					    a->ai_addr, a->ai_addrlen);
> +			if (syn_copied) {
> +				*woff = wlen;
> +				*peer = a;
> +				break; /* success */
> +			}
> +		} else {
> +			if (connect(sock, a->ai_addr, a->ai_addrlen) == 0) {
> +				*peer = a;
> +				break; /* success */
> +			}
> +		}
> +		if (cfg_sockopt_types.mptfo) {
> +			perror("sendto()");
> +			close(sock);
> +			sock = -1;
> +		} else {
> +
> +			perror("connect()");
> +			close(sock);
> +			sock = -1;
> +		}
>   	}
>   
>   	freeaddrinfo(addr);
> @@ -571,13 +609,14 @@ static void shut_wr(int fd)
>   	shutdown(fd, SHUT_WR);
>   }
>   
> -static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after_out)
> +static int copyfd_io_poll(int infd, int peerfd, int outfd,
> +			  bool *in_closed_after_out, unsigned int woff)
>   {
>   	struct pollfd fds = {
>   		.fd = peerfd,
>   		.events = POLLIN | POLLOUT,
>   	};
> -	unsigned int woff = 0, wlen = 0, total_wlen = 0, total_rlen = 0;
> +	unsigned int wlen = 0, total_wlen = 0, total_rlen = 0;
>   	char wbuf[8192];
>   
>   	set_nonblock(peerfd, true);
> @@ -839,7 +878,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
>   	return err;
>   }
>   
> -static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
> +static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, unsigned int woff)
>   {
>   	bool in_closed_after_out = false;
>   	struct timespec start, end;
> @@ -851,7 +890,7 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
>   
>   	switch (cfg_mode) {
>   	case CFG_MODE_POLL:
> -		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out);
> +		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, woff);
>   		break;
>   
>   	case CFG_MODE_MMAP:
> @@ -1033,7 +1072,7 @@ int main_loop_s(int listensock)
>   
>   		SOCK_TEST_TCPULP(remotesock, 0);
>   
> -		copyfd_io(fd, remotesock, 1, true);
> +		copyfd_io(fd, remotesock, 1, true, 0);
>   	} else {
>   		perror("accept");
>   		return 1;
> @@ -1130,6 +1169,11 @@ static void parse_setsock_options(const char *name)
>   		return;
>   	}
>   
> +	if (strncmp(name, "MPTFO", len) == 0) {
> +		cfg_sockopt_types.mptfo = 1;
> +		return;
> +	}
> +
>   	fprintf(stderr, "Unrecognized setsockopt option %s\n", name);
>   	exit(1);
>   }
> @@ -1168,23 +1212,25 @@ int main_loop(void)
>   {
>   	int fd, ret, fd_in = 0;
>   	struct addrinfo *peer;
> +	unsigned int woff = 0;
>   
> -	/* listener is ready. */
> -	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer);
> -	if (fd < 0)
> -		return 2;
> -
> +	if (!cfg_sockopt_types.mptfo) {
> +		/* listener is ready. */
> +		fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, 0, 0);
> +		if (fd < 0)
> +			return 2;
>   again:
> -	check_getpeername_connect(fd);
> +		check_getpeername_connect(fd);
>   
> -	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
> +		SOCK_TEST_TCPULP(fd, cfg_sock_proto);
>   
> -	if (cfg_rcvbuf)
> -		set_rcvbuf(fd, cfg_rcvbuf);
> -	if (cfg_sndbuf)
> -		set_sndbuf(fd, cfg_sndbuf);
> -	if (cfg_cmsg_types.cmsg_enabled)
> -		apply_cmsg_types(fd, &cfg_cmsg_types);
> +		if (cfg_rcvbuf)
> +			set_rcvbuf(fd, cfg_rcvbuf);
> +		if (cfg_sndbuf)
> +			set_sndbuf(fd, cfg_sndbuf);
> +		if (cfg_cmsg_types.cmsg_enabled)
> +			apply_cmsg_types(fd, &cfg_cmsg_types);
> +	}
>   
>   	if (cfg_input) {
>   		fd_in = open(cfg_input, O_RDONLY);
> @@ -1192,8 +1238,25 @@ int main_loop(void)
>   			xerror("can't open %s:%d", cfg_input, errno);
>   	}
>   
> -	/* close the client socket open only if we are not going to reconnect */
> -	ret = copyfd_io(fd_in, fd, 1, 0);
> +	if (cfg_sockopt_types.mptfo) {
> +		/* sendto() instead of connect */
> +		fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, fd_in, &woff);
> +		if (fd < 0)
> +			return 2;
> +
> +		check_getpeername_connect(fd);
> +
> +		SOCK_TEST_TCPULP(fd, cfg_sock_proto);
> +
> +		if (cfg_rcvbuf)
> +			set_rcvbuf(fd, cfg_rcvbuf);
> +		if (cfg_sndbuf)
> +			set_sndbuf(fd, cfg_sndbuf);
> +		if (cfg_cmsg_types.cmsg_enabled)
> +			apply_cmsg_types(fd, &cfg_cmsg_types);
> +	}
> +
> +	ret = copyfd_io(fd_in, fd, 1, 0, 0);
>   	if (ret)
>   		return ret;
>   
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 621af6895f4d..60198b91a530 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -762,6 +762,23 @@ run_tests_peekmode()
>   	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
>   }
>   
> +run_tests_mptfo()
> +{
> +	echo "INFO: with MPTFO start"
> +	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
> +	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1
> +
> +	run_tests_lo "$ns1" "$ns2" 10.0.1.1 0 "-o MPTFO"
> +	run_tests_lo "$ns1" "$ns2" 10.0.1.1 0 "-o MPTFO"
> +
> +	run_tests_lo "$ns1" "$ns2" dead:beef:1::1 0 "-o MPTFO"
> +	run_tests_lo "$ns1" "$ns2" dead:beef:1::1 0 "-o MPTFO"
> +
> +	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=0
> +	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=0
> +	echo "INFO: with MPTFO end"
> +}
> +
>   run_tests_disconnect()
>   {
>   	local peekmode="$1"
> @@ -901,6 +918,10 @@ run_tests_peekmode "saveWithPeek"
>   run_tests_peekmode "saveAfterPeek"
>   stop_if_error "Tests with peek mode have failed"
>   
> +# MPTFO (MultiPath TCP Fatopen tests)
> +run_tests_mptfo
> +stop_if_error "Tests with MPTFO have failed"
> +
>   # connect to ns4 ip address, ns2 should intercept/proxy
>   run_test_transparent 10.0.3.1 "tproxy ipv4"
>   run_test_transparent dead:beef:3::1 "tproxy ipv6"
