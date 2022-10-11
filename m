Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8A3C32
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 17:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1665507906; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=QWEKpDBtT/KQ3hBIn+GmfZtj8lc17yRfMmMKCJb4U3cOTiOxs09tmAFgSOh8NjgoKSbKPvtvf6oQ6iQw0W5rZ9g9N+y8proCdzJZSHua34IGsYA03vBgTR9o3pPFtURnqqT4/bVyTm/nXB7dUXuWbvxg9M65J3IiLLppWyv8ScI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1665507906; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=CIJa/KfNQ60R40xoU76W/p+fRGQz3Tg7V4/7Z93GB28=; 
	b=PMKq80mACoPpvp+dpnWDaOyTlls7AvmTHo/csRYUku2IxVqZ5y0A0lreYJKxubrZJ+grpPqEpxeEdiVYun6b3Tu9v3saxoyQhvmzVKzIalAE9h7rWCl0gjKSGo1opUX3DbMlg4yPi0tx8fmJKfGubA4l1kgMDpSHEJeJ41jt+Qc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665507906;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CIJa/KfNQ60R40xoU76W/p+fRGQz3Tg7V4/7Z93GB28=;
	b=fY/2WOjEzdTT/0zyDRvlRQgwkCbpQmnAq20mvr2DlWhX64v77mHTqBX+qiEeJktr
	hkZgqYG4GDFUEEUtGMWDWLPeJ3Agkib+agVvwLL9O+UffPwVEZIJlxerqOTorr1xIbW
	xz62UjvbeSQ1F5TClLKjHJrzDrCFpMKwAfcmanwQ=
Received: from [10.8.0.6] (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1665507905544483.17923850323973; Tue, 11 Oct 2022 19:05:05 +0200 (CEST)
Message-ID: <767db7d9-b1ac-44e4-6f0c-b928ef1b5e36@shytyi.net>
Date: Tue, 11 Oct 2022 19:05:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH mptcp-next v14 5/5] selftests: mptcp: mptfo
 Initiator/Listener
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>
References: <20221010221809.1792-1-dmytro@shytyi.net>
 <20221010221809.1792-6-dmytro@shytyi.net>
 <a03a004fa4ca05ba20a42fe5e092368206af793f.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <a03a004fa4ca05ba20a42fe5e092368206af793f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Paolo,


On 10/11/2022 5:33 PM, Paolo Abeni wrote:
> On Mon, 2022-10-10 at 22:18 +0000, Dmytro Shytyi wrote:
>> This patch adds the selftests support for mptfo in mptcp_connect.c,.sh
>> We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
>> We call sendto() instead of connect().
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   .../selftests/net/mptcp/mptcp_connect.c       | 140 +++++++++++++-----
>>   .../selftests/net/mptcp/mptcp_connect.sh      |  77 ++++++++++
>>   2 files changed, 184 insertions(+), 33 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> index e54653ea2ed4..fdb934eb97ec 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> @@ -83,6 +83,7 @@ struct cfg_cmsg_types {
>>   
>>   struct cfg_sockopt_types {
>>   	unsigned int transparent:1;
>> +	unsigned int mptfo:1;
>>   };
>>   
>>   struct tcp_inq_state {
>> @@ -90,6 +91,7 @@ struct tcp_inq_state {
>>   	bool expect_eof;
>>   };
>>   
>> +static size_t do_write(const int fd, char *buf, const size_t len);
> Additional forward declaration not needed?
I will double check this, I remember probably I needed this...
>>   static struct tcp_inq_state tcp_inq;
>>   
>>   static struct cfg_cmsg_types cfg_cmsg_types;
>> @@ -232,6 +234,22 @@ static void set_transparent(int fd, int pf)
>>   	}
>>   }
>>   
>> +static void set_mptfo(int fd, int pf)
>> +{
>> +	int qlen = 25;
>> +
>> +	switch (pf) {
>> +	case AF_INET:
>> +		if (-1 == setsockopt(fd, 6, TCP_FASTOPEN, &qlen, sizeof(qlen)))
> please, use SOL_TCP instead of '6', and don't use joda-style syntax -
> that is:
>
> 		if (setsockopt(...) == -1)


It was done similarly to set_transmapent() in the same file.

I will change this then.


>
>> +			perror("TCP_FASTOPEN");
>> +		break;
>> +	case AF_INET6:
>> +		if (-1 == setsockopt(fd, 6, TCP_FASTOPEN, &qlen, sizeof(qlen)))
>> +			perror("TCP_FASTOPEN");
>
> No need to check the pf at all? always run the same setsockopt...
Ok, I see. Will be fixed.
>> +		break;
>> +	}
>> +}
>> +
>>   static int do_ulp_so(int sock, const char *name)
>>   {
>>   	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
>> @@ -300,6 +318,9 @@ static int sock_listen_mptcp(const char * const listenaddr,
>>   		if (cfg_sockopt_types.transparent)
>>   			set_transparent(sock, pf);
>>   
>> +		if (cfg_sockopt_types.mptfo)
>> +			set_mptfo(sock, pf);
>> +
>>   		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
>>   			break; /* success */
>>   
>> @@ -330,13 +351,18 @@ static int sock_listen_mptcp(const char * const listenaddr,
>>   
>>   static int sock_connect_mptcp(const char * const remoteaddr,
>>   			      const char * const port, int proto,
>> -			      struct addrinfo **peer)
>> +			      struct addrinfo **peer,
>> +			      int infd,
>> +			      unsigned int *woff)
>>   {
>>   	struct addrinfo hints = {
>>   		.ai_protocol = IPPROTO_TCP,
>>   		.ai_socktype = SOCK_STREAM,
>>   	};
>>   	struct addrinfo *a, *addr;
>> +	unsigned int wlen = 0;
>> +	int syn_copied = 0;
>> +	char wbuf[8192];
>>   	int sock = -1;
>>   
>>   	hints.ai_family = pf;
>> @@ -354,14 +380,33 @@ static int sock_connect_mptcp(const char * const remoteaddr,
>>   		if (cfg_mark)
>>   			set_mark(sock, cfg_mark);
>>   
>> -		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0) {
>> -			*peer = a;
>> -			break; /* success */
>> -		}
>> +		if (cfg_sockopt_types.mptfo) {
>> +			if (wlen == 0)
>> +				wlen = read(infd, wbuf, sizeof(wbuf));
> Why is the above needed?!?

I am not sure I catch a question. You are asking this: "Why we do read() 
into wbuf and send wbuf data with sento?"

If yes, it is done similarly to "copyfd_io_poll()"

>>   
>> -		perror("connect()");
>> -		close(sock);
>> -		sock = -1;
>> +			syn_copied = sendto(sock, wbuf, wlen, MSG_FASTOPEN,
>> +					    a->ai_addr, a->ai_addrlen);
>> +			if (syn_copied) {
>> +				*woff = syn_copied;
>> +				*peer = a;
>> +				break; /* success */
>> +			}
>> +		} else {
>> +			if (connect(sock, a->ai_addr, a->ai_addrlen) == 0) {
>> +				*peer = a;
>> +				break; /* success */
>> +			}
>> +		}
>> +		if (cfg_sockopt_types.mptfo) {
>> +			perror("sendto()");
>> +			close(sock);
>> +			sock = -1;
>> +		} else {
>> +
>> +			perror("connect()");
>> +			close(sock);
>> +			sock = -1;
>> +		}
>>   	}
>>   
>>   	freeaddrinfo(addr);
>> @@ -571,13 +616,14 @@ static void shut_wr(int fd)
>>   	shutdown(fd, SHUT_WR);
>>   }
>>   
>> -static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after_out)
>> +static int copyfd_io_poll(int infd, int peerfd, int outfd,
>> +			  bool *in_closed_after_out, unsigned int woff)
>>   {
>>   	struct pollfd fds = {
>>   		.fd = peerfd,
>>   		.events = POLLIN | POLLOUT,
>>   	};
>> -	unsigned int woff = 0, wlen = 0, total_wlen = 0, total_rlen = 0;
>> +	unsigned int wlen = 0, total_wlen = 0, total_rlen = 0;
>>   	char wbuf[8192];
>>   
>>   	set_nonblock(peerfd, true);
>> @@ -717,9 +763,9 @@ static int do_recvfile(int infd, int outfd)
>>   	return (int)r;
>>   }
>>   
>> -static int do_mmap(int infd, int outfd, unsigned int size)
>> +static int do_mmap(int infd, int outfd, unsigned int size, unsigned int syn_off)
>>   {
>> -	char *inbuf = mmap(NULL, size, PROT_READ, MAP_SHARED, infd, 0);
>> +	char *inbuf = mmap(NULL, size, PROT_READ, MAP_SHARED, infd, syn_off);
>>   	ssize_t ret = 0, off = 0;
>>   	size_t rem;
>>   
>> @@ -790,7 +836,7 @@ static int do_sendfile(int infd, int outfd, unsigned int count)
>>   }
>>   
>>   static int copyfd_io_mmap(int infd, int peerfd, int outfd,
>> -			  unsigned int size, bool *in_closed_after_out)
>> +			  unsigned int size, bool *in_closed_after_out, unsigned int woff)
>>   {
>>   	int err;
>>   
>> @@ -799,9 +845,9 @@ static int copyfd_io_mmap(int infd, int peerfd, int outfd,
>>   		if (err)
>>   			return err;
>>   
>> -		err = do_mmap(infd, peerfd, size);
>> +		err = do_mmap(infd, peerfd, size, 0);
>>   	} else {
>> -		err = do_mmap(infd, peerfd, size);
>> +		err = do_mmap(infd, peerfd, size - woff, woff);
>>   		if (err)
>>   			return err;
>>
>>
> I think it's ok if you take care of fastopen only in the
> copyfd_io_poll() code-path. This patch will be smaller/easier to
> review.


I see. I'm Working on that to apply only to copyfd_io_poll().

>>   
>> @@ -839,7 +885,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
>>   	return err;
>>   }
>>   
>> -static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
>> +static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, unsigned int woff)
>>   {
>>   	bool in_closed_after_out = false;
>>   	struct timespec start, end;
>> @@ -851,14 +897,14 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
>>   
>>   	switch (cfg_mode) {
>>   	case CFG_MODE_POLL:
>> -		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out);
>> +		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, woff);
>>   		break;
>>   
>>   	case CFG_MODE_MMAP:
>>   		file_size = get_infd_size(infd);
>>   		if (file_size < 0)
>>   			return file_size;
>> -		ret = copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_after_out);
>> +		ret = copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_after_out, woff);
>>   		break;
>>   
>>   	case CFG_MODE_SENDFILE:
>> @@ -1033,7 +1079,7 @@ int main_loop_s(int listensock)
>>   
>>   		SOCK_TEST_TCPULP(remotesock, 0);
>>   
>> -		copyfd_io(fd, remotesock, 1, true);
>> +		copyfd_io(fd, remotesock, 1, true, 0);
>>   	} else {
>>   		perror("accept");
>>   		return 1;
>> @@ -1130,6 +1176,11 @@ static void parse_setsock_options(const char *name)
>>   		return;
>>   	}
>>   
>> +	if (strncmp(name, "MPTFO", len) == 0) {
>> +		cfg_sockopt_types.mptfo = 1;
>> +		return;
>> +	}
>> +
>>   	fprintf(stderr, "Unrecognized setsockopt option %s\n", name);
>>   	exit(1);
>>   }
>> @@ -1168,24 +1219,28 @@ int main_loop(void)
>>   {
>>   	int fd, ret, fd_in = 0;
>>   	struct addrinfo *peer;
>> +	unsigned int woff = 0;
>>   
>> -	/* listener is ready. */
>> -	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer);
>> -	if (fd < 0)
>> -		return 2;
>> +	if (!cfg_sockopt_types.mptfo) {
>> +		/* listener is ready. */
>> +		fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, NULL, NULL);
>> +		if (fd < 0)
>> +			return 2;
>> +	}
>>   
>>   again:
>> -	check_getpeername_connect(fd);
>> +	if (!cfg_sockopt_types.mptfo) {
>> +		check_getpeername_connect(fd);
>>   
>> -	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
>> -
>> -	if (cfg_rcvbuf)
>> -		set_rcvbuf(fd, cfg_rcvbuf);
>> -	if (cfg_sndbuf)
>> -		set_sndbuf(fd, cfg_sndbuf);
>> -	if (cfg_cmsg_types.cmsg_enabled)
>> -		apply_cmsg_types(fd, &cfg_cmsg_types);
>> +		SOCK_TEST_TCPULP(fd, cfg_sock_proto);
>>   
>> +		if (cfg_rcvbuf)
>> +			set_rcvbuf(fd, cfg_rcvbuf);
>> +		if (cfg_sndbuf)
>> +			set_sndbuf(fd, cfg_sndbuf);
>> +		if (cfg_cmsg_types.cmsg_enabled)
>> +			apply_cmsg_types(fd, &cfg_cmsg_types);
>> +	}
>
> Why do you need 2 separate code paths for fastopen and !fastopen?
>
> I *think* it should be possible all the
> 	if (!cfg_sockopt_types.mptfo)
> 		// ...
> 	if (cfg_sockopt_types.mptfo)
> 		// ...
>
> here...

It is trailling from previous attemps for patch creation with littre bit 
different logic.

yes, something like this, I suppose:

	if (!cfg_sockopt_types.mptfo)
		sock_connect_mptcp()
again:		
		// ...
	if (cfg_sockopt_types.mptfo)
		// ...

>>   	if (cfg_input) {
>>   		fd_in = open(cfg_input, O_RDONLY);
>>   		if (fd < 0)
>> @@ -1193,7 +1248,26 @@ int main_loop(void)
>>   	}
>>   
>>   	/* close the client socket open only if we are not going to reconnect */
>> -	ret = copyfd_io(fd_in, fd, 1, 0);
>> +
>> +	if (cfg_sockopt_types.mptfo) {
>> +		/* sendto() instead of connect */
>> +		fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, fd_in, &woff);
>> +		if (fd < 0)
>> +			return 2;
>> +	}
>> +	if (cfg_sockopt_types.mptfo) {
>> +		check_getpeername_connect(fd);
>> +
>> +		SOCK_TEST_TCPULP(fd, cfg_sock_proto);
>> +
>> +		if (cfg_rcvbuf)
>> +			set_rcvbuf(fd, cfg_rcvbuf);
>> +		if (cfg_sndbuf)
>> +			set_sndbuf(fd, cfg_sndbuf);
>> +		if (cfg_cmsg_types.cmsg_enabled)
>> +			apply_cmsg_types(fd, &cfg_cmsg_types);
>> +	}
>> +	ret = copyfd_io(fd_in, fd, 1, 0, woff);
>>   	if (ret)
>>   		return ret;
>>   
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> index 621af6895f4d..d2328f94d1df 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> @@ -677,6 +677,58 @@ run_tests()
>>   	run_tests_lo $1 $2 $3 0
>>   }
> I guess mptcp_join.sh would be a better location. @Mat[s]: wdyt?
> Thanks!
>
> Paolo
>
Thank you,

DS.

