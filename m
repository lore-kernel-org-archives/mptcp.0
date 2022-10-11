Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DB3C14
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665502396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEobu8K9RkeRxJgAmsvGdJuc3TiFjOUPAvsuVcU3rvo=;
	b=TdJRRXgkOKLlo3g35Nl+U7AHlZ2ajpTEEfnAWOLv1bYlNtbasJp4nOOeLrRsXmOuk+UWqF
	FdnC4UGyGgNxia8FVRfRS1uMrG5WoYihPhfGqu2blMS6HAHl45g0CZL4BKdLXOMi5PaTm4
	ZaNYgcJJTYI9qLtRPYlJa3YJgP/QyFM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-ayYmpvBSNoC7CZUIETcdMg-1; Tue, 11 Oct 2022 11:33:08 -0400
X-MC-Unique: ayYmpvBSNoC7CZUIETcdMg-1
Received: by mail-qv1-f69.google.com with SMTP id mz8-20020a0562142d0800b004b18a95b180so8084569qvb.8
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 08:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEobu8K9RkeRxJgAmsvGdJuc3TiFjOUPAvsuVcU3rvo=;
        b=GqvqX5GXWwicN3ma2wAtM2GJGQBUe/I6r85hfjt/oFmnBBFsAX5q1WO0ti4NMyJnxY
         xeNQon2y2YHRNteoGbOOkK8QXqJ+K4MgNmt9wZjY0S5M0yZSmCuRrG1gWNoR4UtCzrxu
         dgWWlUVHkyOAuadsmS+KeKJJjh8urrsccWM4PSeGkHLHIyREMHaeD9J6yxbXZUah/Ag4
         FgI5Aue24QM8myXmL/27m9lHDaWc/S9WIy4a7VxIFOKXufM+p+JDEgt6SelVaCs3SILk
         e30xA2qAeVWXRyH8/rLoYnlzDZS9iGIZSe/ZmJqq64IIU6fcuP0tVsAdi7YM0ohmxBHH
         hueA==
X-Gm-Message-State: ACrzQf1+l3SrpgSDT+akciDmqvGWQt4kTNDjj0nTPe9Zjn/RPijEsCRh
	ucGbXJGjt9fYiZG4BG92PAADRf5nQDeSrQ0gr/yj3J8aQjDQokN/3xRTYmcYQxTVlrj1vPFCVx8
	zmMnC+7X+q3KLgZQ=
X-Received: by 2002:ac8:5888:0:b0:39a:c9ef:541a with SMTP id t8-20020ac85888000000b0039ac9ef541amr7370195qta.232.1665502386911;
        Tue, 11 Oct 2022 08:33:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6b0gSi0HG2VgU4HvTuSSB3ETpJ9yXcB8FMK+wEqXv70Z57zoTGtHBPtnGLf0utsvTYiO4few==
X-Received: by 2002:ac8:5888:0:b0:39a:c9ef:541a with SMTP id t8-20020ac85888000000b0039ac9ef541amr7370141qta.232.1665502386431;
        Tue, 11 Oct 2022 08:33:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id cc15-20020a05622a410f00b00342f05defd1sm10831594qtb.66.2022.10.11.08.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:33:05 -0700 (PDT)
Message-ID: <a03a004fa4ca05ba20a42fe5e092368206af793f.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v14 5/5] selftests: mptcp: mptfo
 Initiator/Listener
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Date: Tue, 11 Oct 2022 17:33:02 +0200
In-Reply-To: <20221010221809.1792-6-dmytro@shytyi.net>
References: <20221010221809.1792-1-dmytro@shytyi.net>
	 <20221010221809.1792-6-dmytro@shytyi.net>
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

On Mon, 2022-10-10 at 22:18 +0000, Dmytro Shytyi wrote:
> This patch adds the selftests support for mptfo in mptcp_connect.c,.sh
> We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
> We call sendto() instead of connect().
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  .../selftests/net/mptcp/mptcp_connect.c       | 140 +++++++++++++-----
>  .../selftests/net/mptcp/mptcp_connect.sh      |  77 ++++++++++
>  2 files changed, 184 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index e54653ea2ed4..fdb934eb97ec 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -83,6 +83,7 @@ struct cfg_cmsg_types {
>  
>  struct cfg_sockopt_types {
>  	unsigned int transparent:1;
> +	unsigned int mptfo:1;
>  };
>  
>  struct tcp_inq_state {
> @@ -90,6 +91,7 @@ struct tcp_inq_state {
>  	bool expect_eof;
>  };
>  
> +static size_t do_write(const int fd, char *buf, const size_t len);

Additional forward declaration not needed?

>  static struct tcp_inq_state tcp_inq;
>  
>  static struct cfg_cmsg_types cfg_cmsg_types;
> @@ -232,6 +234,22 @@ static void set_transparent(int fd, int pf)
>  	}
>  }
>  
> +static void set_mptfo(int fd, int pf)
> +{
> +	int qlen = 25;
> +
> +	switch (pf) {
> +	case AF_INET:
> +		if (-1 == setsockopt(fd, 6, TCP_FASTOPEN, &qlen, sizeof(qlen)))

please, use SOL_TCP instead of '6', and don't use joda-style syntax -
that is:

		if (setsockopt(...) == -1)



> +			perror("TCP_FASTOPEN");
> +		break;
> +	case AF_INET6:
> +		if (-1 == setsockopt(fd, 6, TCP_FASTOPEN, &qlen, sizeof(qlen)))
> +			perror("TCP_FASTOPEN");


No need to check the pf at all? always run the same setsockopt...
> +		break;
> +	}
> +}
> +
>  static int do_ulp_so(int sock, const char *name)
>  {
>  	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
> @@ -300,6 +318,9 @@ static int sock_listen_mptcp(const char * const listenaddr,
>  		if (cfg_sockopt_types.transparent)
>  			set_transparent(sock, pf);
>  
> +		if (cfg_sockopt_types.mptfo)
> +			set_mptfo(sock, pf);
> +
>  		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
>  			break; /* success */
>  
> @@ -330,13 +351,18 @@ static int sock_listen_mptcp(const char * const listenaddr,
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
> @@ -354,14 +380,33 @@ static int sock_connect_mptcp(const char * const remoteaddr,
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

Why is the above needed?!?

>  
> -		perror("connect()");
> -		close(sock);
> -		sock = -1;
> +			syn_copied = sendto(sock, wbuf, wlen, MSG_FASTOPEN,
> +					    a->ai_addr, a->ai_addrlen);
> +			if (syn_copied) {
> +				*woff = syn_copied;
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
> @@ -571,13 +616,14 @@ static void shut_wr(int fd)
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
> @@ -717,9 +763,9 @@ static int do_recvfile(int infd, int outfd)
>  	return (int)r;
>  }
>  
> -static int do_mmap(int infd, int outfd, unsigned int size)
> +static int do_mmap(int infd, int outfd, unsigned int size, unsigned int syn_off)
>  {
> -	char *inbuf = mmap(NULL, size, PROT_READ, MAP_SHARED, infd, 0);
> +	char *inbuf = mmap(NULL, size, PROT_READ, MAP_SHARED, infd, syn_off);
>  	ssize_t ret = 0, off = 0;
>  	size_t rem;
>  
> @@ -790,7 +836,7 @@ static int do_sendfile(int infd, int outfd, unsigned int count)
>  }
>  
>  static int copyfd_io_mmap(int infd, int peerfd, int outfd,
> -			  unsigned int size, bool *in_closed_after_out)
> +			  unsigned int size, bool *in_closed_after_out, unsigned int woff)
>  {
>  	int err;
>  
> @@ -799,9 +845,9 @@ static int copyfd_io_mmap(int infd, int peerfd, int outfd,
>  		if (err)
>  			return err;
>  
> -		err = do_mmap(infd, peerfd, size);
> +		err = do_mmap(infd, peerfd, size, 0);
>  	} else {
> -		err = do_mmap(infd, peerfd, size);
> +		err = do_mmap(infd, peerfd, size - woff, woff);
>  		if (err)
>  			return err;
> 
> 

I think it's ok if you take care of fastopen only in the
copyfd_io_poll() code-path. This patch will be smaller/easier to
review.

>  
> @@ -839,7 +885,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
>  	return err;
>  }
>  
> -static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
> +static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, unsigned int woff)
>  {
>  	bool in_closed_after_out = false;
>  	struct timespec start, end;
> @@ -851,14 +897,14 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
>  
>  	switch (cfg_mode) {
>  	case CFG_MODE_POLL:
> -		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out);
> +		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, woff);
>  		break;
>  
>  	case CFG_MODE_MMAP:
>  		file_size = get_infd_size(infd);
>  		if (file_size < 0)
>  			return file_size;
> -		ret = copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_after_out);
> +		ret = copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_after_out, woff);
>  		break;
>  
>  	case CFG_MODE_SENDFILE:
> @@ -1033,7 +1079,7 @@ int main_loop_s(int listensock)
>  
>  		SOCK_TEST_TCPULP(remotesock, 0);
>  
> -		copyfd_io(fd, remotesock, 1, true);
> +		copyfd_io(fd, remotesock, 1, true, 0);
>  	} else {
>  		perror("accept");
>  		return 1;
> @@ -1130,6 +1176,11 @@ static void parse_setsock_options(const char *name)
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
> @@ -1168,24 +1219,28 @@ int main_loop(void)
>  {
>  	int fd, ret, fd_in = 0;
>  	struct addrinfo *peer;
> +	unsigned int woff = 0;
>  
> -	/* listener is ready. */
> -	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer);
> -	if (fd < 0)
> -		return 2;
> +	if (!cfg_sockopt_types.mptfo) {
> +		/* listener is ready. */
> +		fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, NULL, NULL);
> +		if (fd < 0)
> +			return 2;
> +	}
>  
>  again:
> -	check_getpeername_connect(fd);
> +	if (!cfg_sockopt_types.mptfo) {
> +		check_getpeername_connect(fd);
>  
> -	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
> -
> -	if (cfg_rcvbuf)
> -		set_rcvbuf(fd, cfg_rcvbuf);
> -	if (cfg_sndbuf)
> -		set_sndbuf(fd, cfg_sndbuf);
> -	if (cfg_cmsg_types.cmsg_enabled)
> -		apply_cmsg_types(fd, &cfg_cmsg_types);
> +		SOCK_TEST_TCPULP(fd, cfg_sock_proto);
>  
> +		if (cfg_rcvbuf)
> +			set_rcvbuf(fd, cfg_rcvbuf);
> +		if (cfg_sndbuf)
> +			set_sndbuf(fd, cfg_sndbuf);
> +		if (cfg_cmsg_types.cmsg_enabled)
> +			apply_cmsg_types(fd, &cfg_cmsg_types);
> +	}


Why do you need 2 separate code paths for fastopen and !fastopen?

I *think* it should be possible all the
	if (!cfg_sockopt_types.mptfo)
		// ...
	if (cfg_sockopt_types.mptfo)
		// ...

here...

>  	if (cfg_input) {
>  		fd_in = open(cfg_input, O_RDONLY);
>  		if (fd < 0)
> @@ -1193,7 +1248,26 @@ int main_loop(void)
>  	}
>  
>  	/* close the client socket open only if we are not going to reconnect */
> -	ret = copyfd_io(fd_in, fd, 1, 0);
> +
> +	if (cfg_sockopt_types.mptfo) {
> +		/* sendto() instead of connect */
> +		fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, fd_in, &woff);
> +		if (fd < 0)
> +			return 2;
> +	}
> +	if (cfg_sockopt_types.mptfo) {
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
> +	ret = copyfd_io(fd_in, fd, 1, 0, woff);
>  	if (ret)
>  		return ret;
>  
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 621af6895f4d..d2328f94d1df 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -677,6 +677,58 @@ run_tests()
>  	run_tests_lo $1 $2 $3 0
>  }

I guess mptcp_join.sh would be a better location. @Mat[s]: wdyt?
> 
Thanks!

Paolo

