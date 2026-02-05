Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F612F3C3A
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314515; cv=none; b=spr5Bdwah7HDLJmjAd7uNocgnXs6rPz0+0sIKXe9Jb0QaeVptNRerxn9A8Sixawb5E6qSRLvqeqTAZ/onU2LiORXkTxdLbLmUaTguoP1hWMJl15rLunkjDomJ4uCY0X1ho638+5jdITQwdGGuErNycGlGh9lBf1sSqCBOq+5eCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314515; c=relaxed/simple;
	bh=gC3UebVG9ZAWpTZNsnZ+0wyfGMAB3v8/td2APecCYD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deJ5932VczJBQJCJs3vtmc2nw09JOQNEJiT6IAkQCQJQGKAIvz/whJCQeuaRJUTVe934LgP0NSsvj/W5Byo0NOo4kjkLnuuZ4ITk8tsO9780jwU4BbtYWEZZ6jubzuV6m0pnCozqOhA0MuTSdg8CI4kxgiNp69udg/S/BOicQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZqWQjpl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZqWQjpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55278C4CEF7;
	Thu,  5 Feb 2026 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770314514;
	bh=gC3UebVG9ZAWpTZNsnZ+0wyfGMAB3v8/td2APecCYD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gZqWQjplmdM6guFGuqQ34HBwK8VTfwc251wngzMaCNViXw4vR27gzD/x993FVXA45
	 Q6oAPPUvJUMcrTP2M0JOcuGbuNaE9O/uEobFGllouolitkoTxj0fyz+6v8+EEH9Ke6
	 B2CZ+BsIA5Itk4Jcx4yokNa4EdNwGybXnQvjov1Ybvoa6J9ejqLkrWmYS942DUvy8s
	 VRCBI15yuagiL9qrwBWbd3HWLyyKVpmumUkNqnpjWxCJ3wHsqogou/kzcH6FrTmg+d
	 Tono/Kmn58QxecSZuVkm6L/HJAAsih4Azz15YMt1gDo1CevJFqxkZ82cKZB6zXqg0Q
	 4HdvXMS528yvw==
Message-ID: <a57b0254-2e3d-4e5b-8f2d-4ce6d36f5af8@kernel.org>
Date: Thu, 5 Feb 2026 19:01:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [Patch mptcp-net 1/3] mptcp: add backlog_list bug reproducer test
Content-Language: en-GB, fr-BE
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev, pabeni@redhat.com
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1770273341.git.yangang@kylinos.cn>
 <500a8fe690cb8718ea32c33ae8cdcb2df203ecd0.1770273341.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <500a8fe690cb8718ea32c33ae8cdcb2df203ecd0.1770273341.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

Thank you for looking at this.

Small detail: I'm not sure what you are using to generate the patches
(b4 prep/send is great BTW), but it is strange to have 'Patch' instead
of PATCH in the subjects.

On 05/02/2026 07:41, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch introduces a test program to reproduce bugs related to the
> backlog_list in MPTCP. The test is derived from tls.c in the selftests
> suite, but adapted to work without TLS configuration specifically for
> MPTCP testing.
> 
> The program performs chunked sendfile operations with various payload
> sizes to exercise different code paths and trigger backlog_list-related
> issues.

I understood it was just a tmp patch just to show how to reproduce the
issue, but I think it is good to make sure such regression is not
reintroduced. So if this test is quick to run, it should be kept. No?

Except if the error could be reproduced with packetdrill? Or eventually
if mptcp_connect.(c|sh) could be easily adapted to reproduce the issue
instead?

> 
> It can be run in .virtme-exec-run:
>         run_loop run_selftest_one ./multi_chunk.sh

(That's specific to the MPTCP docker image, no need to specify this here
to avoid confusions)

> 
> '''
> selftest Test: ./multi_chunk.sh
> TAP version 13
> 1..1
> [stalls for a while]
> ^C
> 
> '''
> 
> Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/Makefile    |   1 +
>  .../testing/selftests/net/mptcp/multi_chunk.c | 148 ++++++++++++++++++
>  .../selftests/net/mptcp/multi_chunk.sh        |  37 +++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 tools/testing/selftests/net/mptcp/multi_chunk.c
>  create mode 100755 tools/testing/selftests/net/mptcp/multi_chunk.sh
> 
> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index 22ba0da2adb8..087e6ae6f0b8 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -24,6 +24,7 @@ TEST_GEN_FILES := \
>  	mptcp_diag \
>  	mptcp_inq \
>  	mptcp_sockopt \
> +	multi_chunk \
>  	pm_nl_ctl \
>  # end of TEST_GEN_FILES
>  
> diff --git a/tools/testing/selftests/net/mptcp/multi_chunk.c b/tools/testing/selftests/net/mptcp/multi_chunk.c
> new file mode 100644
> index 000000000000..8c97db58a6db
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/multi_chunk.c
> @@ -0,0 +1,148 @@
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <sys/sendfile.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <arpa/inet.h>
> +#include <sys/wait.h>

Please sort the headers, see:

https://lore.kernel.org/mptcp/20260130-mptcp-sft-sort-includes-v1-1-ab022fad9741@kernel.org/

> +
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +
> +#define TLS_PAYLOAD_MAX_LEN 16384
> +#define TEST_PORT 12345
> +
> +static void chunked_sendfile(int cfd, int sfd,
> +			     size_t chunk_size,
> +			     size_t extra_payload_size)
> +{
> +	char buf[TLS_PAYLOAD_MAX_LEN];
> +	uint16_t test_payload_size;
> +	size_t recved = 0;
> +	size_t sent = 0;
> +	int size = 0;
> +	int ret;
> +	char filename[] = "/tmp/mytemp.XXXXXX";
> +	int fd = mkstemp(filename);
> +	off_t offset = 0;

Ideally keep the reverse XMAS tree for the order.

> +
> +	unlink(filename);
> +	if (fd <= 0) {
> +		perror("tempfile");
> +		exit(1);
> +	}
> +	if (chunk_size < 1) {
> +		perror("chunksize");
> +		exit(1);
> +	}
> +
> +	test_payload_size = chunk_size + extra_payload_size;
> +	if (test_payload_size > TLS_PAYLOAD_MAX_LEN) {
> +		perror("payload_size");
> +		exit(1);
> +	}
> +	memset(buf, 1, test_payload_size);
> +	size = write(fd, buf, test_payload_size);
> +	if (size != test_payload_size) {
> +		perror("file write");
> +		exit(1);
> +	}
> +	fsync(fd);
> +
> +	while (size > 0) {
> +		ret = sendfile(sfd, fd, &offset, chunk_size);
> +		if (ret <= 0)

It would be good to print an error to stderr.

Also, maybe you will need to at least close(fd) to be sure the tmp file
will be removed, no?


> +			exit(1);
> +		size -= ret;
> +		sent += ret;
> +	}
> +	printf("[client] sent %zu bytes\n", sent);
> +
> +	recved = recv(cfd, buf, test_payload_size, MSG_WAITALL);
> +	printf("[server] receieved %zu bytes\n", recved);
> +
> +	if (recved != test_payload_size)

Same here.

> +		exit(1);
> +
> +	close(fd);
> +}
> +
> +int main()
> +{
> +	int sfd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> +	int cfd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> +	struct sockaddr_in addr = {0};
> +	socklen_t addrlen = sizeof(addr);
> +
> +	printf("==== multi_chunk_sendfile MPTCP test ====\n");

Maybe these printf() here and at the bottom are not really needed?

> +
> +	if (sfd < 0 || cfd < 0) {
> +		perror("socket");
> +		exit(1);
> +	}
> +
> +	addr.sin_family = AF_INET;
> +	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +	addr.sin_port = htons(TEST_PORT);
> +
> +	if (bind(sfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> +		perror("bind");
> +		exit(1);
> +	}
> +
> +	if (listen(sfd, 1) < 0) {
> +		perror("listen");
> +		exit(1);
> +	}
> +
> +	if (getsockname(sfd, (struct sockaddr *)&addr, &addrlen) < 0) {
> +		perror("getsockname");
> +		exit(1);
> +	}
> +
> +	if (connect(cfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> +		perror("connect");
> +		exit(1);
> +	}
> +
> +	int nfd = accept(sfd, NULL, NULL);
> +	if (nfd < 0) {
> +		perror("accept");
> +		exit(1);
> +	}
> +
> +	chunked_sendfile(cfd, nfd, 4096, 4096);
> +	chunked_sendfile(cfd, nfd, 4096, 0);
> +	chunked_sendfile(cfd, nfd, 4096, 1);
> +	chunked_sendfile(cfd, nfd, 4096, 2048);
> +	chunked_sendfile(cfd, nfd, 8192, 2048);
> +	chunked_sendfile(cfd, nfd, 4096, 8192);
> +	chunked_sendfile(cfd, nfd, 8192, 4096);
> +	chunked_sendfile(cfd, nfd, 12288, 1024);
> +	chunked_sendfile(cfd, nfd, 12288, 2000);
> +	chunked_sendfile(cfd, nfd, 15360, 100);
> +	chunked_sendfile(cfd, nfd, 15360, 300);
> +	chunked_sendfile(cfd, nfd, 1, 4096);
> +	chunked_sendfile(cfd, nfd, 2048, 4096);
> +	chunked_sendfile(cfd, nfd, 2048, 8192);
> +	chunked_sendfile(cfd, nfd, 4096, 8192);
> +	chunked_sendfile(cfd, nfd, 1024, 12288);
> +	chunked_sendfile(cfd, nfd, 2000, 12288);
> +	chunked_sendfile(cfd, nfd, 100, 15360);
> +	chunked_sendfile(cfd, nfd, 300, 15360);
> +
> +	close(cfd);
> +	close(nfd);
> +	close(sfd);
> +
> +	printf("==== test ends ====\n");
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/net/mptcp/multi_chunk.sh b/tools/testing/selftests/net/mptcp/multi_chunk.sh
> new file mode 100755
> index 000000000000..c0352c89087f
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/multi_chunk.sh
> @@ -0,0 +1,37 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(dirname "${0}")/mptcp_lib.sh"
> +
> +cleanup()
> +{
> +	if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
> +		kill "$pid" 2>/dev/null
> +		wait "$pid" 2>/dev/null
> +	fi
> +
> +	mptcp_lib_ns_exit "${ns1}"
> +}
> +
> +init()
> +{
> +	mptcp_lib_ns_init ns1
> +
> +	local i
> +	for i in $(seq 1 4); do
> +		mptcp_lib_pm_nl_add_endpoint "${ns1}" "127.0.0.1" flags signal port 1000$i
> +	done
> +
> +	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
> +
> +	ip netns exec ${ns1} ip mptcp endpoint show
> +	ip netns exec ${ns1} ip mptcp limits

These two lines are not needed.

> +}
> +
> +init
> +trap cleanup EXIT
> +
> +ip netns exec $ns1 ./multi_chunk &
> +
> +pid=$!
> +wait $pid

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

