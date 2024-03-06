Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2A12E78
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695742; cv=none; b=pCj+d841xl/hAIHds2qy6taKlV4y9dS8vLcoRSD0rUVfEmhmOII9+7vfVlAIZGdbrPBQaqN9dLWd5P/rhxpnL5AU/3rqCw/87Vs4CD/kJzV1VaybhzQJxLgjEHRN38c/bP2c1dBDTR14P4UNM4Ro7YicvWoM6J2lcAwkmxnG7nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695742; c=relaxed/simple;
	bh=5uMoKIvWLdzJG07k6xJfwzKhCi+9SUOSvb21z3ChdFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aaL2793fm5YXPtv5+Rg81ECL+rkYqPMaF9IHlN19r6lTjXTqMiIr25P23QZXOq20ekQzk608esM0PYD2evJK7MQ+4mEZVkHzBxU0zT5bVvEFzvazxCGH/ghf9GMow99S64sEskklKtTO0sTZlDEgORjF6gXNmS6+009iweG1dBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyX8EbI3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyX8EbI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04750C433F1;
	Wed,  6 Mar 2024 03:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709695742;
	bh=5uMoKIvWLdzJG07k6xJfwzKhCi+9SUOSvb21z3ChdFI=;
	h=From:To:Cc:Subject:Date:From;
	b=WyX8EbI39KgiF1jNptypibISr0gNGw6Vl0Gh5IfKQgkZKOalltg6F2CgqEyJ6m4Se
	 ESlR+ArCkHCiBfAEO3NIrWwmo4cgidc30U/gyznyf7qcBkWnuqo82ZfzbpEZO/eNF/
	 KHUshVKouysMtwj6r3/I9lgrQf9xpeT0Ndf9ftQ6E9tua3TKYe0n2cbDyWBF/k5oUS
	 ZchxhvK+YckHmDBaBpQRygMpnFA/1vD680OO756q7ZlY3ZShxfQZ8GQJ3e9VyXFK2m
	 vX0vWH1QUJDkzjXMdfbPynRzB0mSR2DbLvjfEeywHWfD/XgH4pYR6CL7uJ4h0i4l6i
	 HlLDH6t69/vdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	"Bruce A . Mah" <bmah@es.net>
Cc: Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iperf3 v2] add MPTCPv1 support
Date: Wed,  6 Mar 2024 11:28:54 +0800
Message-Id: <487902825fa971916541b59e43ed25c7525b60e0.1709695652.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in the
upstream Linux kernel since v5.16.

MPTCP is strongly tied to TCP, and the kernel APIs are almost the same.
The only required dependency is the 'IPPROTO_MPTCP' protocol number
definition, which should be provided by the netinet/in.h header.

This patch adds a new flag --mptcp to support MPTCPv1. It can be used
like this:

 > iperf3 --mptcp -s
 > iperf3 --mptcp -c 127.0.0.1

There is no need to check for IPPROTO_MPTCP support in configure.ac at
build time, it is at runtime we will see if the kernel being use supports
or not MPTCP.

If IPPROTO_MPTCP is not supported by the kernel being tested, it is
normal to fail because the feature is not available.

Linked: https://github.com/esnet/iperf/pull/1166
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---

Notes:
    restrict this feature to Linux builds

 src/iperf.h            |  7 +++++++
 src/iperf_api.c        |  8 ++++++++
 src/iperf_api.h        |  1 +
 src/iperf_client_api.c |  2 +-
 src/iperf_locale.c     |  3 +++
 src/iperf_tcp.c        |  4 ++--
 src/iperf_udp.c        |  2 +-
 src/net.c              | 14 +++++++-------
 src/net.h              |  4 ++--
 9 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/src/iperf.h b/src/iperf.h
index dc3c0d1..bc9fdf6 100644
--- a/src/iperf.h
+++ b/src/iperf.h
@@ -50,6 +50,10 @@
 #include <sys/cpuset.h>
 #endif /* HAVE_CPUSET_SETAFFINITY */
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 #include "timer.h"
 #include "queue.h"
 #include "cjson.h"
@@ -175,6 +179,9 @@ struct iperf_settings
     int       idle_timeout;         /* server idle time timeout */
     unsigned int snd_timeout; /* Timeout for sending tcp messages in active mode, in us */
     struct iperf_time rcv_timeout;  /* Timeout for receiving messages in active mode, in us */
+#if defined(linux)
+    int       mptcp;
+#endif
 };
 
 struct iperf_test;
diff --git a/src/iperf_api.c b/src/iperf_api.c
index 1dcfaab..686b78b 100644
--- a/src/iperf_api.c
+++ b/src/iperf_api.c
@@ -1144,6 +1144,9 @@ iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
         {"idle-timeout", required_argument, NULL, OPT_IDLE_TIMEOUT},
         {"rcv-timeout", required_argument, NULL, OPT_RCV_TIMEOUT},
         {"snd-timeout", required_argument, NULL, OPT_SND_TIMEOUT},
+#if defined(linux)
+        {"mptcp", no_argument, NULL, OPT_MPTCP},
+#endif
         {"debug", optional_argument, NULL, 'd'},
         {"help", no_argument, NULL, 'h'},
         {NULL, 0, NULL, 0}
@@ -1639,6 +1642,11 @@ iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
 		test->settings->connect_timeout = unit_atoi(optarg);
 		client_flag = 1;
 		break;
+#if defined(linux)
+	    case OPT_MPTCP:
+		test->settings->mptcp = 1;
+		break;
+#endif
 	    case 'h':
 		usage_long(stdout);
 		exit(0);
diff --git a/src/iperf_api.h b/src/iperf_api.h
index d2bbdfe..2ee29d9 100644
--- a/src/iperf_api.h
+++ b/src/iperf_api.h
@@ -100,6 +100,7 @@ typedef atomic_uint_fast64_t atomic_iperf_size_t;
 #define OPT_RCV_TIMEOUT 27
 #define OPT_JSON_STREAM 28
 #define OPT_SND_TIMEOUT 29
+#define OPT_MPTCP 30
 
 /* states */
 #define TEST_START 1
diff --git a/src/iperf_client_api.c b/src/iperf_client_api.c
index 7ad4c93..01dceb6 100644
--- a/src/iperf_client_api.c
+++ b/src/iperf_client_api.c
@@ -399,7 +399,7 @@ iperf_connect(struct iperf_test *test)
     /* Create and connect the control channel */
     if (test->ctrl_sck < 0)
 	// Create the control channel using an ephemeral port
-	test->ctrl_sck = netdial(test->settings->domain, Ptcp, test->bind_address, test->bind_dev, 0, test->server_hostname, test->server_port, test->settings->connect_timeout);
+	test->ctrl_sck = netdial(test->settings->domain, Ptcp, test->settings->mptcp ? IPPROTO_MPTCP : 0, test->bind_address, test->bind_dev, 0, test->server_hostname, test->server_port, test->settings->connect_timeout);
     if (test->ctrl_sck < 0) {
         i_errno = IECONNECT;
         return -1;
diff --git a/src/iperf_locale.c b/src/iperf_locale.c
index ae0f63a..7e00fb6 100644
--- a/src/iperf_locale.c
+++ b/src/iperf_locale.c
@@ -128,6 +128,9 @@ const char usage_longstr[] = "Usage: iperf3 [-s|-c host] [options]\n"
                            "  --snd-timeout #           timeout for unacknowledged TCP data\n"
                            "                            (in ms, default is system settings)\n"
 #endif /* HAVE_TCP_USER_TIMEOUT */
+#if defined(linux)
+                           "  --mptcp                   Multipath TCP support\n"
+#endif
                            "  -d, --debug[=#]           emit debugging output\n"
                            "                            (optional optional \"=\" and debug level: 1-4. Default is 4 - all messages)\n"
                            "  -v, --version             show version information and quit\n"
diff --git a/src/iperf_tcp.c b/src/iperf_tcp.c
index 184a195..cb88317 100644
--- a/src/iperf_tcp.c
+++ b/src/iperf_tcp.c
@@ -210,7 +210,7 @@ iperf_tcp_listen(struct iperf_test *test)
             return -1;
         }
 
-        if ((s = socket(res->ai_family, SOCK_STREAM, 0)) < 0) {
+        if ((s = socket(res->ai_family, SOCK_STREAM, res->ai_protocol)) < 0) {
 	    freeaddrinfo(res);
             i_errno = IESTREAMLISTEN;
             return -1;
@@ -376,7 +376,7 @@ iperf_tcp_connect(struct iperf_test *test)
     int saved_errno;
     int rcvbuf_actual, sndbuf_actual;
 
-    s = create_socket(test->settings->domain, SOCK_STREAM, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, &server_res);
+    s = create_socket(test->settings->domain, SOCK_STREAM, test->settings->mptcp ? IPPROTO_MPTCP : 0, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, &server_res);
     if (s < 0) {
 	i_errno = IESTREAMCONNECT;
 	return -1;
diff --git a/src/iperf_udp.c b/src/iperf_udp.c
index a603236..4e651fe 100644
--- a/src/iperf_udp.c
+++ b/src/iperf_udp.c
@@ -507,7 +507,7 @@ iperf_udp_connect(struct iperf_test *test)
     int i, max_len_wait_for_reply;
 
     /* Create and bind our local socket. */
-    if ((s = netdial(test->settings->domain, Pudp, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, -1)) < 0) {
+    if ((s = netdial(test->settings->domain, Pudp, 0, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, -1)) < 0) {
         i_errno = IESTREAMCONNECT;
         return -1;
     }
diff --git a/src/net.c b/src/net.c
index c82caff..b8d3da5 100644
--- a/src/net.c
+++ b/src/net.c
@@ -124,7 +124,7 @@ timeout_connect(int s, const struct sockaddr *name, socklen_t namelen,
 
 /* create a socket */
 int
-create_socket(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out)
+create_socket(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out)
 {
     struct addrinfo hints, *local_res = NULL, *server_res = NULL;
     int s, saved_errno;
@@ -133,14 +133,14 @@ create_socket(int domain, int proto, const char *local, const char *bind_dev, in
     if (local) {
         memset(&hints, 0, sizeof(hints));
         hints.ai_family = domain;
-        hints.ai_socktype = proto;
+        hints.ai_socktype = type;
         if ((gerror = getaddrinfo(local, NULL, &hints, &local_res)) != 0)
             return -1;
     }
 
     memset(&hints, 0, sizeof(hints));
     hints.ai_family = domain;
-    hints.ai_socktype = proto;
+    hints.ai_socktype = type;
     snprintf(portstr, sizeof(portstr), "%d", port);
     if ((gerror = getaddrinfo(server, portstr, &hints, &server_res)) != 0) {
 	if (local)
@@ -148,7 +148,7 @@ create_socket(int domain, int proto, const char *local, const char *bind_dev, in
         return -1;
     }
 
-    s = socket(server_res->ai_family, proto, 0);
+    s = socket(server_res->ai_family, type, proto);
     if (s < 0) {
 	if (local)
 	    freeaddrinfo(local_res);
@@ -233,12 +233,12 @@ create_socket(int domain, int proto, const char *local, const char *bind_dev, in
 
 /* make connection to server */
 int
-netdial(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout)
+netdial(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout)
 {
     struct addrinfo *server_res = NULL;
     int s, saved_errno;
 
-    s = create_socket(domain, proto, local, bind_dev, local_port, server, port, &server_res);
+    s = create_socket(domain, type, proto, local, bind_dev, local_port, server, port, &server_res);
     if (s < 0) {
       return -1;
     }
@@ -289,7 +289,7 @@ netannounce(int domain, int proto, const char *local, const char *bind_dev, int
     if ((gerror = getaddrinfo(local, portstr, &hints, &res)) != 0)
         return -1;
 
-    s = socket(res->ai_family, proto, 0);
+    s = socket(res->ai_family, proto, res->ai_protocol);
     if (s < 0) {
 	freeaddrinfo(res);
         return -1;
diff --git a/src/net.h b/src/net.h
index f0e1b4f..cd0afb7 100644
--- a/src/net.h
+++ b/src/net.h
@@ -28,8 +28,8 @@
 #define __NET_H
 
 int timeout_connect(int s, const struct sockaddr *name, socklen_t namelen, int timeout);
-int create_socket(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out);
-int netdial(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout);
+int create_socket(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out);
+int netdial(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout);
 int netannounce(int domain, int proto, const char *local, const char *bind_dev, int port);
 int Nread(int fd, char *buf, size_t count, int prot);
 int Nwrite(int fd, const char *buf, size_t count, int prot) /* __attribute__((hot)) */;
-- 
2.40.1

