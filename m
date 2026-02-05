Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDE338F52
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283245; cv=none; b=a19V4alnl/YljDFPw7WzkWJNjkPtCy+sCvO/HgvIJadyA36QZosCgLcZq1wNHLfFj/t2y/xly+SBsdK3mf4Ha5x7DX9LvU/boD1LbfgsXV5oJq/riwOvVR3J2dOVO2jD+l+dOs8JeeiCCHN2I4R+bsoOUw6RDGd5jUH4AsKUXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283245; c=relaxed/simple;
	bh=Hclu7u3y+3Y1MhK9bCkWbxnjEdIB7NT/it1Yjy+jAmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AckSHONgy4Nuh4zwlfjOu3fjJN2lnSj5pafHVpqS9Fv4JXXPpBO8ZeLiAPYYYK15lthoYhueJb+Aiftb5QJPCPlvhwYh3BQsWBBbHkqPtWI3QyWacG1R8pns322I3SEZ9MlSZhSDEK8v5+aYbCYy4J/DBFS4qdvRlwL6qkQSC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwEcN8uz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwEcN8uz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770283244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfM94FbsFo230UdBs7WDirowrUKVjB4QDQvIfVGEDpw=;
	b=VwEcN8uzztLct2JwYl0VMwOYXdXczOlapANcfBHub3PW5IihhQeMbCm0Avi98fmS1pXsIR
	MbuHR3KjA0GvElhqa/Rsn86YDoaPJRj6aBA02Odn4J28gXNPJcmqmf18Q+gNg7wUv+CpKw
	pgwL0xI2djlP61bB2MhUoWRbU8DxRFc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-zkGZ1yN8NISUNtwBbvJ1Qw-1; Thu, 05 Feb 2026 04:20:42 -0500
X-MC-Unique: zkGZ1yN8NISUNtwBbvJ1Qw-1
X-Mimecast-MFC-AGG-ID: zkGZ1yN8NISUNtwBbvJ1Qw_1770283242
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee33324e8so4598745e9.1
        for <mptcp@lists.linux.dev>; Thu, 05 Feb 2026 01:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770283242; x=1770888042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfM94FbsFo230UdBs7WDirowrUKVjB4QDQvIfVGEDpw=;
        b=m8dMe9kVhhHQOktkcSBh3C86m+7lOcXemWPPx0Nt78uVry71ID6LYNXtJgwnajf1xL
         TaEMwWZLZBrne5D4ftK8hh9ehtvBBlMmlZtdWC/ybumOUm4e4djNYjeqkH24cztaaZS9
         j1auqxBF6CNaSZeymr6VB220SeueAlUQO1yGVPA9O77mcd/BJbeN7FdawKXv67G3Spkr
         OcrX04Pbod0feY4sEWWvVUXAwS4i2q9v4IsJQRcGmf79paU2b3SQlkk9Umq9l0rb1jde
         sNA2oQ6pNynk8t95+V8gBD1dA1/4X1zG3snHtTXLLZO1Lb6fXPGbrmhCFdukrXLx7VR1
         zcMg==
X-Forwarded-Encrypted: i=1; AJvYcCXphcWJRisQ184fP+sOPB2NtRsCdceDo1uF/D+XYq4MLbMpcV0wZQMwvFyTKTLHBvOsvThHdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOSz5EmgQnKIPQ1Al683uhYpgjBM3JDwlCJkTMmhhLmeFthw2b
	y4Cz553KT08SOJurRPrYDbo6kCgUpLoGSVM1A4osJ6tpyKqc/V9hYUVGVD6As1j+B1kpUcytntB
	XH8bVoxR5lm2L/qffNKhcVD/Bz6SpAmTZMKB3N5cDFHON2oi/IllXE3Tb
X-Gm-Gg: AZuq6aKi60FrniCCBfywI9SgXfSuBoAUQ3GVmMMRfv9+0bAujEd0QWyfGSkABEPwqex
	NBsNec72dho+40JHbhGU3GcZwogE1Z0b1ke0De8Gl0B8uVKlQzjo5ykPVjaRMcEfWxCv9WxmxUh
	eNh/otIliUEP0mpkgCuItrt2GDIKuARDbY89/jncAR7IOY77x/xWPp8yVmGGBFRuOWUukZE9rfu
	iMOChwDWJMkJoWYv/5krRp4Ja+t6eltVsYa7JOL0bq4+UvtItOZ/xc3YnEp1MVffICr++RHYHE6
	4Uhpzi8f40jV5lOZ7eJrKStwmsO7IiiQ8alv/m12CRpIIhcfcMrPQGvF35Ldxcf8LOMBrIhFNZz
	kK0w4DERimP0g
X-Received: by 2002:a05:600c:c3cd:20b0:482:ef72:5781 with SMTP id 5b1f17b1804b1-4830e992830mr57178475e9.25.1770283241608;
        Thu, 05 Feb 2026 01:20:41 -0800 (PST)
X-Received: by 2002:a05:600c:c3cd:20b0:482:ef72:5781 with SMTP id 5b1f17b1804b1-4830e992830mr57178125e9.25.1770283241095;
        Thu, 05 Feb 2026 01:20:41 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e250bdsm13206003f8f.2.2026.02.05.01.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 01:20:40 -0800 (PST)
Message-ID: <aa6f6618-d89c-4804-95ef-745b449a71d8@redhat.com>
Date: Thu, 5 Feb 2026 10:20:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch mptcp-net 1/3] mptcp: add backlog_list bug reproducer test
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1770273341.git.yangang@kylinos.cn>
 <500a8fe690cb8718ea32c33ae8cdcb2df203ecd0.1770273341.git.yangang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <500a8fe690cb8718ea32c33ae8cdcb2df203ecd0.1770273341.git.yangang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9F39JTtgieL_ZCEOgwntPTDj0E6wrp2E4QiywNoXrKA_1770283242
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 7:41 AM, Gang Yan wrote:
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
> 
> It can be run in .virtme-exec-run:
>         run_loop run_selftest_one ./multi_chunk.sh
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
> +
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif

Minor nit: I think we can avoid the compiler guards here; older test
program have them for historical reasons.

> +
> +#define TLS_PAYLOAD_MAX_LEN 16384

Possibly this macro should be renamed, i.e. to PAYLOAD_MAX_LEN and
likely the value increased to 64K


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
> +
> +	unlink(filename);
> +	if (fd <= 0) {
> +		perror("tempfile");
> +		exit(1);

Here and below you could use the error() libcall instead of the
perror/exit combo.

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
> +			exit(1);
> +		size -= ret;
> +		sent += ret;
> +	}
> +	printf("[client] sent %zu bytes\n", sent);
> +
> +	recved = recv(cfd, buf, test_payload_size, MSG_WAITALL);
> +	printf("[server] receieved %zu bytes\n", recved);

Possibly the above 2 print should be off by default and enabled via
command line switch.

> +
> +	if (recved != test_payload_size)
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
> +}
> +
> +init
> +trap cleanup EXIT
> +
> +ip netns exec $ns1 ./multi_chunk &
> +
> +pid=$!
> +wait $pid

I think it would be nice to emit an ok/fail message as other tests

/P

