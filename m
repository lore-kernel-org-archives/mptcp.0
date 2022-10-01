Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860F1FD2
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664594119; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=JA1UyrLWvRvbmP30SPyzTXAi1hukLn8sJ5R3Ctz22zRFSvNxIO7OBhLIDDsG3KQRlBumDL9LmXJoMUObkQQJQ/94IWza1C9wfUuetMeSLCBZ9GmTtk4FQ6YKKGX0K7VHm29XALaOn1W12yP9SQlrUOpVEDBG2SlW+RBMDZbvwsM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664594119; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=rDvKS/y4ifrmSjdukq6vsDamnf5X+7MrJcFBzZ0I/v4=; 
	b=UzgvKwOrifkCIRDajVQL3ZzQwbU1PzwXp8ar8ufl7B20CRVBPr3ZWDxTL0OrbURD1OMJiQMqA5CIh/8goNmtWcSRdjiZ7dqEY/+mrAwgCfjzrfRz+1jHQkULfJ5s5z+GdCQ3ORwI6KVykGuP85p3bu7CF6tc4WQk6nX7/owrpiU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664594119;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=rDvKS/y4ifrmSjdukq6vsDamnf5X+7MrJcFBzZ0I/v4=;
	b=d0RQhgs0QhcM8MpbyZ3yh1HUWelDfvTbyCqJEr8RsubScUbXp2hKkQNk76neOqlR
	2lu3/7DNuCz3CH/KO5in50zlXKGtve8jLYhH1mcnVbMXVto+BKuF4cCAKOy6jN+/jKI
	/yPtLbmd/0UlCQYokCqCdPmHDUUq0Vpk4vr4QkSk=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664594117468646.7969425783506; Sat, 1 Oct 2022 05:15:17 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221001031502.29152-8-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v13 7/7] selftests: mptfo initiator/listener
Date: Sat,  1 Oct 2022 03:15:02 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221001031502.29152-1-dmytro@shytyi.net>
References: <20221001031502.29152-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

MPTFO tests: these are examples of initiator (sendto) and listener,
probably are going to be integrated to the mptcp_connect.* selftests

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 tools/testing/selftests/net/mptcp/mptfo.sh    |  13 +++
 .../selftests/net/mptcp/mptfo_initiator.c     |  43 ++++++++
 .../selftests/net/mptcp/mptfo_listener.c      | 100 ++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo.sh
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_initiator.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_listener.c

diff --git a/tools/testing/selftests/net/mptcp/mptfo.sh b/tools/testing/sel=
ftests/net/mptcp/mptfo.sh
new file mode 100644
index 000000000000..9ed0cb281094
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptfo.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+#This is an example of environmen that was used to generate wireshark
+sudo ip netns add server
+sudo ip netns add client
+sudo ip link add veth0 type veth peer name veth1
+sudo ip link set veth1 netns server
+sudo ip link set veth0 netns client
+sudo ip netns exec client ip a a 10.10.0.1/24 dev veth0
+sudo ip netns exec server ip a a 10.10.0.2/24 dev veth1
+sudo ip netns exec client ip link set dev  veth0 up
+sudo ip netns exec server ip link set dev  veth1 up
+sudo ip netns exec server bash -c "echo 2 > /proc/sys/net/ipv4/tcp_fastope=
n"
+sudo ip netns exec client bash -c "echo 1 > /proc/sys/net/ipv4/tcp_fastope=
n"
diff --git a/tools/testing/selftests/net/mptcp/mptfo_initiator.c b/tools/te=
sting/selftests/net/mptcp/mptfo_initiator.c
new file mode 100644
index 000000000000..05e6a3d62bb8
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptfo_initiator.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <unistd.h>
+#include <netinet/tcp.h>
+#include <string.h>
+#include <signal.h>
+
+#define SERVER_PORT 7003
+
+int main(int argc, char *argv[])
+{
+=09unsigned char valsyn[3] =3D "abc";
+=09struct sockaddr_in daddr;
+=09char *valend =3D "fff";
+=09char *val1 =3D "zz1";
+=09char *val2 =3D "zz2";
+=09char *val3 =3D "zz3";
+=09int sock_fd =3D -1;
+=09int ret;
+
+=09memset(&daddr, 0, sizeof(daddr));
+=09inet_pton(AF_INET, "10.10.0.2", &daddr.sin_addr);
+=09daddr.sin_family =3D AF_INET;
+=09daddr.sin_port =3D htons(SERVER_PORT);
+
+=09sock_fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
+
+=09ret =3D sendto(sock_fd, valsyn, 3, MSG_FASTOPEN, (struct sockaddr *) &d=
addr, sizeof(daddr));
+=09ret =3D write(sock_fd, val1, 3);
+=09ret =3D write(sock_fd, val2, 3);
+=09ret =3D write(sock_fd, val2, 3);
+=09ret =3D write(sock_fd, val2, 3);
+=09ret =3D write(sock_fd, val3, 3);
+=09ret =3D write(sock_fd, valend, 3);
+
+=09close(sock_fd);
+=09return EXIT_SUCCESS;
+}
diff --git a/tools/testing/selftests/net/mptcp/mptfo_listener.c b/tools/tes=
ting/selftests/net/mptcp/mptfo_listener.c
new file mode 100644
index 000000000000..6890349b14bb
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptfo_listener.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <arpa/inet.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#include <linux/in.h>
+#include <netinet/tcp.h>
+
+#define CLIENT_QUEUE_LEN 10
+#define SERVER_PORT 7003
+
+int main(void)
+{
+=09int listen_sock_fd =3D -1, client_sock_fd =3D -1;
+=09char str_addr[INET6_ADDRSTRLEN];
+=09struct sockaddr_in server_addr;
+=09int ret, flag;
+=09int qlen =3D 5;
+=09char ch;
+
+=09server_addr.sin_family =3D AF_INET;
+=09inet_pton(AF_INET, "10.10.0.2", &server_addr.sin_addr);
+=09server_addr.sin_port =3D htons(SERVER_PORT);
+
+=09/* Create socket for listening (client requests) */
+=09listen_sock_fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
+=09if (listen_sock_fd =3D=3D -1) {
+=09=09perror("socket()server");
+=09=09return EXIT_FAILURE;
+=09}
+
+=09/* Set socket to reuse address */
+=09flag =3D 1;
+=09ret =3D setsockopt(listen_sock_fd, SOL_SOCKET, SO_REUSEADDR, &flag, siz=
eof(flag));
+=09if (ret =3D=3D -1) {
+=09=09perror("setsockopt()");
+=09=09return EXIT_FAILURE;
+=09}
+
+=09ret =3D setsockopt(listen_sock_fd, SOL_TCP, TCP_FASTOPEN, &qlen, sizeof=
(qlen));
+=09if (ret =3D=3D -1) {
+=09=09perror("setsockopt()TCP_FASTOPEN");
+=09=09return EXIT_FAILURE;
+=09}
+
+=09/* Bind address and socket together */
+=09ret =3D bind(listen_sock_fd, (struct sockaddr *)&server_addr, sizeof(se=
rver_addr));
+=09if (ret =3D=3D -1) {
+=09=09perror("bind()");
+=09=09close(listen_sock_fd);
+=09=09return EXIT_FAILURE;
+=09}
+
+=09/* Create listening queue (client requests) */
+=09ret =3D listen(listen_sock_fd, CLIENT_QUEUE_LEN);
+=09if (ret =3D=3D -1) {
+=09=09perror("listen()");
+=09=09close(listen_sock_fd);
+=09=09return EXIT_FAILURE;
+=09}
+=09perror("Server listening");
+=09while (1) {
+=09=09/* Do TCP handshake with client */
+=09=09client_sock_fd =3D accept(listen_sock_fd,
+=09=09=09=09NULL,
+=09=09=09=090);
+=09=09if (client_sock_fd =3D=3D -1) {
+=09=09=09perror("accept()");
+=09=09=09close(listen_sock_fd);
+=09=09=09return EXIT_FAILURE;
+=09=09} else {
+=09=09=09perror("ACCEPT_SUCCESS");
+=09=09}
+
+=09=09char rb[1024];
+
+=09=09while (1) {
+=09=09=09ret =3D read(client_sock_fd, rb, 3);
+
+=09=09=09if (ret =3D=3D -1) {
+=09=09=09=09perror("SERVVERread()");
+=09=09=09=09close(client_sock_fd);
+=09=09=09=09break;
+=09=09=09} else {
+=09=09=09=09fprintf(stderr, "received %c%c%c from client", rb[0], rb[1], r=
b[2]);
+=09=09=09}
+=09=09=09if (rb[0] =3D=3D 'f' && rb[1] =3D=3D 'f' && rb[2] =3D=3D 'f') {
+=09=09=09=09close(client_sock_fd);
+=09=09=09=09break;
+=09=09=09}
+
+=09=09}
+=09}
+
+=09return EXIT_SUCCESS;
+}
--=20
2.34.1


