Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5924414
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296716; cv=none; b=YSyZBBjj3z+9nnuZC2A4aIfgl3Bs3H9PvfLK3FuDNdzDjTCBM+X6K53+CrI/RozuylDGzfUS6j+JR8C8KXpUB2NrSIaRoQ4hobiQpr8V1yEF5Z57/EIUPb0jv01dgQ2uf6p9bYdxWoRSxBB+fHMcbIwoDSBhdAvgoOAN47x27n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296716; c=relaxed/simple;
	bh=tgxW0+QtIFT9hQAXtNZzoz4enPFO9NNISFwn0USKYrE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=asPA89rrNlAYWxLkrKF+4Hv41yPLB73ShSAE6SisxnsA13lJPkn/PqFkteNVa+sHkFFAat81hXK7y5oUSsbbfpw/+DrMzHkNHWxydLxT4uAMQvdjjOYhxVvn0vnHlDQWzmS7WnF5vK1iPe6tSCVScPLxN+cLxEzPe7JnSw7nSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tVOpp+ah; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tVOpp+ah"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770296713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzLnjfVVKkSiV/FevzhEYr1WwORii41oqkbfBb3RSlY=;
	b=tVOpp+ah91w0MPsBiRxTT/b5g8qd5PuH0gUYB3sDbb1YLQYdo8+rvAfc0Sltsns4uDmr2u
	rZ/GyrEcIA4UTtLYPsx4mtNiQ/9LPYeAjkr06LRVsBLiiWY8WdRFV69yh1BOUNqlUkP1G3
	JOI7gW1gIpxAlbFYwNLXdUV6hhABGAw=
Date: Thu, 05 Feb 2026 13:05:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <8e2151925594cdb075fa75486645e2e2c07415d4@linux.dev>
TLS-Required: No
Subject: Re: [Patch mptcp-net 1/3] mptcp: add backlog_list bug reproducer
 test
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
In-Reply-To: <aa6f6618-d89c-4804-95ef-745b449a71d8@redhat.com>
References: <cover.1770273341.git.yangang@kylinos.cn>
 <500a8fe690cb8718ea32c33ae8cdcb2df203ecd0.1770273341.git.yangang@kylinos.cn>
 <aa6f6618-d89c-4804-95ef-745b449a71d8@redhat.com>
X-Migadu-Flow: FLOW_OUT

>February 5, 2026 at 5:20 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pab=
eni@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wro=
te:
Hi, Paolo:

Thanks for your detailed review comments.

This patch is for temporary testing purposes only to reproduce the
backlog_list-related issues, and it's not meant for merging. In the upcom=
ing
v2 version, I'll incorporate all your suggestions and add the appropriate
"do-not-merge" tag.

Best regards,
Gang

>=20
>=20On 2/5/26 7:41 AM, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  This patch introduces a test program to reproduce bugs related to =
the
> >  backlog_list in MPTCP. The test is derived from tls.c in the selftes=
ts
> >  suite, but adapted to work without TLS configuration specifically fo=
r
> >  MPTCP testing.
> >=20=20
>=20>  The program performs chunked sendfile operations with various payl=
oad
> >  sizes to exercise different code paths and trigger backlog_list-rela=
ted
> >  issues.
> >=20=20
>=20>  It can be run in .virtme-exec-run:
> >  run_loop run_selftest_one ./multi_chunk.sh
> >=20=20
>=20>  '''
> >  selftest Test: ./multi_chunk.sh
> >  TAP version 13
> >  1..1
> >  [stalls for a while]
> >  ^C
> >=20=20
>=20>  '''
> >=20=20
>=20>  Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
> >  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >  Signed-off-by: Gang Yan <yangang@kylinos.cn>
> >  ---
> >  tools/testing/selftests/net/mptcp/Makefile | 1 +
> >  .../testing/selftests/net/mptcp/multi_chunk.c | 148 ++++++++++++++++=
++
> >  .../selftests/net/mptcp/multi_chunk.sh | 37 +++++
> >  3 files changed, 186 insertions(+)
> >  create mode 100644 tools/testing/selftests/net/mptcp/multi_chunk.c
> >  create mode 100755 tools/testing/selftests/net/mptcp/multi_chunk.sh
> >=20=20
>=20>  diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/te=
sting/selftests/net/mptcp/Makefile
> >  index 22ba0da2adb8..087e6ae6f0b8 100644
> >  --- a/tools/testing/selftests/net/mptcp/Makefile
> >  +++ b/tools/testing/selftests/net/mptcp/Makefile
> >  @@ -24,6 +24,7 @@ TEST_GEN_FILES :=3D \
> >  mptcp_diag \
> >  mptcp_inq \
> >  mptcp_sockopt \
> >  + multi_chunk \
> >  pm_nl_ctl \
> >  # end of TEST_GEN_FILES
> >=20=20
>=20>  diff --git a/tools/testing/selftests/net/mptcp/multi_chunk.c b/too=
ls/testing/selftests/net/mptcp/multi_chunk.c
> >  new file mode 100644
> >  index 000000000000..8c97db58a6db
> >  --- /dev/null
> >  +++ b/tools/testing/selftests/net/mptcp/multi_chunk.c
> >  @@ -0,0 +1,148 @@
> >  +#define _GNU_SOURCE
> >  +#include <stdio.h>
> >  +#include <stdlib.h>
> >  +#include <string.h>
> >  +#include <unistd.h>
> >  +#include <fcntl.h>
> >  +#include <sys/socket.h>
> >  +#include <netinet/in.h>
> >  +#include <sys/sendfile.h>
> >  +#include <sys/types.h>
> >  +#include <sys/stat.h>
> >  +#include <errno.h>
> >  +#include <arpa/inet.h>
> >  +#include <sys/wait.h>
> >  +
> >  +#ifndef IPPROTO_MPTCP
> >  +#define IPPROTO_MPTCP 262
> >  +#endif
> >=20
>=20Minor nit: I think we can avoid the compiler guards here; older test
> program have them for historical reasons.
>=20
>=20>=20
>=20> +
> >  +#define TLS_PAYLOAD_MAX_LEN 16384
> >=20
>=20Possibly this macro should be renamed, i.e. to PAYLOAD_MAX_LEN and
> likely the value increased to 64K
>=20
>=20>=20
>=20> +#define TEST_PORT 12345
> >  +
> >  +static void chunked_sendfile(int cfd, int sfd,
> >  + size_t chunk_size,
> >  + size_t extra_payload_size)
> >  +{
> >  + char buf[TLS_PAYLOAD_MAX_LEN];
> >  + uint16_t test_payload_size;
> >  + size_t recved =3D 0;
> >  + size_t sent =3D 0;
> >  + int size =3D 0;
> >  + int ret;
> >  + char filename[] =3D "/tmp/mytemp.XXXXXX";
> >  + int fd =3D mkstemp(filename);
> >  + off_t offset =3D 0;
> >  +
> >  + unlink(filename);
> >  + if (fd <=3D 0) {
> >  + perror("tempfile");
> >  + exit(1);
> >=20
>=20Here and below you could use the error() libcall instead of the
> perror/exit combo.
>=20
>=20>=20
>=20> + }
> >  + if (chunk_size < 1) {
> >  + perror("chunksize");
> >  + exit(1);
> >  + }
> >  +
> >  + test_payload_size =3D chunk_size + extra_payload_size;
> >  + if (test_payload_size > TLS_PAYLOAD_MAX_LEN) {
> >  + perror("payload_size");
> >  + exit(1);
> >  + }
> >  + memset(buf, 1, test_payload_size);
> >  + size =3D write(fd, buf, test_payload_size);
> >  + if (size !=3D test_payload_size) {
> >  + perror("file write");
> >  + exit(1);
> >  + }
> >  + fsync(fd);
> >  +
> >  + while (size > 0) {
> >  + ret =3D sendfile(sfd, fd, &offset, chunk_size);
> >  + if (ret <=3D 0)
> >  + exit(1);
> >  + size -=3D ret;
> >  + sent +=3D ret;
> >  + }
> >  + printf("[client] sent %zu bytes\n", sent);
> >  +
> >  + recved =3D recv(cfd, buf, test_payload_size, MSG_WAITALL);
> >  + printf("[server] receieved %zu bytes\n", recved);
> >=20
>=20Possibly the above 2 print should be off by default and enabled via
> command line switch.
>=20
>=20>=20
>=20> +
> >  + if (recved !=3D test_payload_size)
> >  + exit(1);
> >  +
> >  + close(fd);
> >  +}
> >  +
> >  +int main()
> >  +{
> >  + int sfd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> >  + int cfd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> >  + struct sockaddr_in addr =3D {0};
> >  + socklen_t addrlen =3D sizeof(addr);
> >  +
> >  + printf("=3D=3D=3D=3D multi_chunk_sendfile MPTCP test =3D=3D=3D=3D\=
n");
> >  +
> >  + if (sfd < 0 || cfd < 0) {
> >  + perror("socket");
> >  + exit(1);
> >  + }
> >  +
> >  + addr.sin_family =3D AF_INET;
> >  + addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> >  + addr.sin_port =3D htons(TEST_PORT);
> >  +
> >  + if (bind(sfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> >  + perror("bind");
> >  + exit(1);
> >  + }
> >  +
> >  + if (listen(sfd, 1) < 0) {
> >  + perror("listen");
> >  + exit(1);
> >  + }
> >  +
> >  + if (getsockname(sfd, (struct sockaddr *)&addr, &addrlen) < 0) {
> >  + perror("getsockname");
> >  + exit(1);
> >  + }
> >  +
> >  + if (connect(cfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> >  + perror("connect");
> >  + exit(1);
> >  + }
> >  +
> >  + int nfd =3D accept(sfd, NULL, NULL);
> >  + if (nfd < 0) {
> >  + perror("accept");
> >  + exit(1);
> >  + }
> >  +
> >  + chunked_sendfile(cfd, nfd, 4096, 4096);
> >  + chunked_sendfile(cfd, nfd, 4096, 0);
> >  + chunked_sendfile(cfd, nfd, 4096, 1);
> >  + chunked_sendfile(cfd, nfd, 4096, 2048);
> >  + chunked_sendfile(cfd, nfd, 8192, 2048);
> >  + chunked_sendfile(cfd, nfd, 4096, 8192);
> >  + chunked_sendfile(cfd, nfd, 8192, 4096);
> >  + chunked_sendfile(cfd, nfd, 12288, 1024);
> >  + chunked_sendfile(cfd, nfd, 12288, 2000);
> >  + chunked_sendfile(cfd, nfd, 15360, 100);
> >  + chunked_sendfile(cfd, nfd, 15360, 300);
> >  + chunked_sendfile(cfd, nfd, 1, 4096);
> >  + chunked_sendfile(cfd, nfd, 2048, 4096);
> >  + chunked_sendfile(cfd, nfd, 2048, 8192);
> >  + chunked_sendfile(cfd, nfd, 4096, 8192);
> >  + chunked_sendfile(cfd, nfd, 1024, 12288);
> >  + chunked_sendfile(cfd, nfd, 2000, 12288);
> >  + chunked_sendfile(cfd, nfd, 100, 15360);
> >  + chunked_sendfile(cfd, nfd, 300, 15360);
> >  +
> >  + close(cfd);
> >  + close(nfd);
> >  + close(sfd);
> >  +
> >  + printf("=3D=3D=3D=3D test ends =3D=3D=3D=3D\n");
> >  + return 0;
> >  +}
> >  diff --git a/tools/testing/selftests/net/mptcp/multi_chunk.sh b/tool=
s/testing/selftests/net/mptcp/multi_chunk.sh
> >  new file mode 100755
> >  index 000000000000..c0352c89087f
> >  --- /dev/null
> >  +++ b/tools/testing/selftests/net/mptcp/multi_chunk.sh
> >  @@ -0,0 +1,37 @@
> >  +#!/bin/bash
> >  +# SPDX-License-Identifier: GPL-2.0
> >  +
> >  +. "$(dirname "${0}")/mptcp_lib.sh"
> >  +
> >  +cleanup()
> >  +{
> >  + if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
> >  + kill "$pid" 2>/dev/null
> >  + wait "$pid" 2>/dev/null
> >  + fi
> >  +
> >  + mptcp_lib_ns_exit "${ns1}"
> >  +}
> >  +
> >  +init()
> >  +{
> >  + mptcp_lib_ns_init ns1
> >  +
> >  + local i
> >  + for i in $(seq 1 4); do
> >  + mptcp_lib_pm_nl_add_endpoint "${ns1}" "127.0.0.1" flags signal por=
t 1000$i
> >  + done
> >  +
> >  + mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
> >  +
> >  + ip netns exec ${ns1} ip=20mptcp endpoint show
> >  + ip netns exec ${ns1} ip mptcp limits
> >  +}
> >  +
> >  +init
> >  +trap cleanup EXIT
> >  +
> >  +ip netns exec $ns1 ./multi_chunk &
> >  +
> >  +pid=3D$!
> >  +wait $pid
> >=20
>=20I think it would be nice to emit an ok/fail message as other tests
>=20
> /P
>
