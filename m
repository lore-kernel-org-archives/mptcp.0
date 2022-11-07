Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6CD531
	for <mptcp@lists.linux.dev>; Mon,  7 Nov 2022 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667836042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNaghIRrE2iEjhUHPta7IhjcWsgHB9U8kLpItSX+nHs=;
	b=DzwHKP5ZY0rzKWydMUs4RdxTpRniPfYw14D56EoN/i1x7RnWzrWX3l0P4ee2tVfn9oYDRE
	AdHti90HdpN0745Ob1W6wZWFmm2rvg4K+wGT0OYj5KfLTaQ2sKTRJcSKDvldQba351IZov
	pK2m3WhR0q8yL0Apyv48k6fo+Nwi+k4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-XRUakICKOhGyAJnCjLJRWg-1; Mon, 07 Nov 2022 10:47:21 -0500
X-MC-Unique: XRUakICKOhGyAJnCjLJRWg-1
Received: by mail-wr1-f71.google.com with SMTP id w23-20020adf8bd7000000b002358f733307so2931594wra.17
        for <mptcp@lists.linux.dev>; Mon, 07 Nov 2022 07:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNaghIRrE2iEjhUHPta7IhjcWsgHB9U8kLpItSX+nHs=;
        b=GOzkNBIxnxKaD4bTzDPVkwMwaXB4S9motuGDFyU1pS0sgjyWCPjEeIEzz8ykK7z6cQ
         pIa0UGvC+Pa0eTIzVaBo9nu05Z79xy553SeJCWZudl5321QJ2dPcLvMzO541NPTpe5tI
         FW/cpJJjYzy4QMFdHSHKNziCUV5Ti+npjcOHeQilLUoQZXi3VzQkeXKOSsRDRXMC4tLO
         GygEWnkun+wUhlARi/lV1/iGiyUOoeO6AzemHHTl8sUAVBGEgI3O1cchmDA72OyBs87i
         ZuTpHetWgtSx8VTGthzozN+gohaPYBEUoCRQ8TsuxSlHFNeEgVUcnMEa9/6UW2qDYdST
         iJ+g==
X-Gm-Message-State: ACrzQf31xMirKii9sYew+WKfixFY+JViN/UIbxTP93nhbR91SEvGwmAj
	/EcVZT8GetP1PWA+8ZmCCK+YHGfUrWa59flyiJ5Fj9uLQkPzJr+5HEG00rSAFx+pTxXSl0AgWId
	wN3a2yhlLLv/kPkw=
X-Received: by 2002:adf:f1c9:0:b0:236:49ee:8598 with SMTP id z9-20020adff1c9000000b0023649ee8598mr31368214wro.481.1667836040273;
        Mon, 07 Nov 2022 07:47:20 -0800 (PST)
X-Google-Smtp-Source: AMsMyM53SsMed20C5UKJ36nuOlX70wX6RsaDyOOu4e+QhheolHIi8Wp0wvnB3BYlclRArBUiQY4mAg==
X-Received: by 2002:adf:f1c9:0:b0:236:49ee:8598 with SMTP id z9-20020adff1c9000000b0023649ee8598mr31368202wro.481.1667836039963;
        Mon, 07 Nov 2022 07:47:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-124-216.dyn.eolo.it. [146.241.124.216])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003b49bd61b19sm12259724wmc.15.2022.11.07.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:47:19 -0800 (PST)
Message-ID: <45cfb077c68ef92fbea7c735959cbf8f8a98c414.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v15 5/5] selftests: mptcp: mptfo
 Initiator/Listener
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 07 Nov 2022 16:47:18 +0100
In-Reply-To: <20221106152411.655-6-dmytro@shytyi.net>
References: <20221106152411.655-1-dmytro@shytyi.net>
	 <20221106152411.655-6-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2022-11-06 at 15:24 +0000, Dmytro Shytyi wrote:
> This patch adds the selftests support for mptfo in mptcp_connect.c
> We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
> We call sendto() instead of connect().
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  .../selftests/net/mptcp/mptcp_connect.c       | 121 +++++++++++++-----
>  .../selftests/net/mptcp/mptcp_connect.sh      |  21 +++
>  2 files changed, 113 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index e54653ea2ed4..4bc855159c52 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -26,11 +26,13 @@
>  
>  #include <netdb.h>
>  #include <netinet/in.h>
> +#include <netinet/tcp.h>
>  
> -#include <linux/tcp.h>

Funnily enough, the above change breaks the build on my host. I see the
CI does not complain about it, but I still would avoid it

>  #include <linux/time_types.h>
>  #include <linux/sockios.h>
>  
> +
> +

Unneeded empty lines, do not add them

>  extern int optind;
>  
>  #ifndef IPPROTO_MPTCP
> @@ -83,6 +85,7 @@ struct cfg_cmsg_types {
>  
>  struct cfg_sockopt_types {
>  	unsigned int transparent:1;
> +	unsigned int mptfo:1;
>  };
>  
>  struct tcp_inq_state {
> @@ -232,6 +235,14 @@ static void set_transparent(int fd, int pf)
>  	}
>  }
>  
> +static void set_mptfo(int fd, int pf)
> +{
> +	int qlen = 25;
> +
> +	if (setsockopt(fd, SOL_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) == -1)

If you use IPPROTO_TCP here instead of SOL_TCP - yep, it's not what the
man page says - you can avoid the initial problematic chunck

> +		perror("TCP_FASTOPEN");
> +}
> +
>  static int do_ulp_so(int sock, const char *name)
>  {
>  	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
> @@ -300,6 +311,9 @@ static int sock_listen_mptcp(const char * const listenaddr,
>  		if (cfg_sockopt_types.transparent)
>  			set_transparent(sock, pf);
>  
> +		if (cfg_sockopt_types.mptfo)
> +			set_mptfo(sock, pf);
> +
>  		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
>  			break; /* success */
>  
> @@ -330,13 +344,18 @@ static int sock_listen_mptcp(const char * const listenaddr,
>  
>  static int sock_connect_mptcp(const char * const remoteaddr,
>  			      const char * const port, int proto,
> -			      struct addrinfo **peer)
> +			      struct addrinfo **peer,
> +			      int infd,
> +			      unsigned int *woff)
>  {
>  	struct addrinfo hints = {
>  		.ai_protocol = IPPROTO_TCP,
>  		.ai_socktype = SOCK_STREAM,
>  	};
>  	struct addrinfo *a, *addr;
> +	unsigned int wlen = 0;
> +	int syn_copied = 0;
> +	char wbuf[8192];
>  	int sock = -1;
>  
>  	hints.ai_family = pf;
> @@ -354,14 +373,33 @@ static int sock_connect_mptcp(const char * const remoteaddr,
>  		if (cfg_mark)
>  			set_mark(sock, cfg_mark);
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

This is likely causing the self-test failures. syn_copied can be lower
than wlen - or even negative. You must check for errors, and save the
exact amount of bytes copied. Additionally you need to preserve wbuf
contents, or read but unsent bytes will be lost.

I'll try to send an incremental patch asap.

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
>  	}
>  
>  	freeaddrinfo(addr);
> @@ -571,13 +609,14 @@ static void shut_wr(int fd)
>  	shutdown(fd, SHUT_WR);
>  }
>  
> -static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after_out)
> +static int copyfd_io_poll(int infd, int peerfd, int outfd,
> +			  bool *in_closed_after_out, unsigned int woff)
>  {
>  	struct pollfd fds = {
>  		.fd = peerfd,
>  		.events = POLLIN | POLLOUT,
>  	};
> -	unsigned int woff = 0, wlen = 0, total_wlen = 0, total_rlen = 0;
> +	unsigned int wlen = 0, total_wlen = 0, total_rlen = 0;
>  	char wbuf[8192];
>  
>  	set_nonblock(peerfd, true);
> @@ -839,7 +878,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
>  	return err;
>  }
>  
> -static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
> +static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, unsigned int woff)
>  {
>  	bool in_closed_after_out = false;
>  	struct timespec start, end;
> @@ -851,7 +890,7 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
>  
>  	switch (cfg_mode) {
>  	case CFG_MODE_POLL:
> -		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out);
> +		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, woff);
>  		break;
>  
>  	case CFG_MODE_MMAP:
> @@ -1033,7 +1072,7 @@ int main_loop_s(int listensock)
>  
>  		SOCK_TEST_TCPULP(remotesock, 0);
>  
> -		copyfd_io(fd, remotesock, 1, true);
> +		copyfd_io(fd, remotesock, 1, true, 0);
>  	} else {
>  		perror("accept");
>  		return 1;
> @@ -1130,6 +1169,11 @@ static void parse_setsock_options(const char *name)
>  		return;
>  	}
>  
> +	if (strncmp(name, "MPTFO", len) == 0) {
> +		cfg_sockopt_types.mptfo = 1;
> +		return;
> +	}
> +
>  	fprintf(stderr, "Unrecognized setsockopt option %s\n", name);
>  	exit(1);
>  }
> @@ -1168,23 +1212,25 @@ int main_loop(void)
>  {
>  	int fd, ret, fd_in = 0;
>  	struct addrinfo *peer;
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
>  again:
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
>  	if (cfg_input) {
>  		fd_in = open(cfg_input, O_RDONLY);
> @@ -1192,8 +1238,25 @@ int main_loop(void)
>  			xerror("can't open %s:%d", cfg_input, errno);
>  	}
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

Here GCC is reporting an uninitialized warning for fd. I think it's
better to avoid special case for TFO above, and let
sock_connect_mptcp() deal with that.


Cheers,

Paolo

