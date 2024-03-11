Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE020C132
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710140643; cv=none; b=O3rPettiJk+pz7HrgoK+67bq7F9EBvpl2tzUJsX56jZfOjnSNyyJz9FTiuJMcLX1SkXW3Hv3CziRm726/cqSEvYJDIAwNzf5PWXlB45fR947bsIg+omkskMluJ6/afvURyx+tLBPUw4rWsjdr+6mSVB/TzHODgqUTqAKfS8kUgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710140643; c=relaxed/simple;
	bh=stZeLhfFofFFcO/OysCCwACVqQxQclZqdY1g9N1lmrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tpb8hKyrVrbaIvy8IlZTVNgDP8iwhHScvAPjjUY3+BMx1BD6LZFn3xBZOrV3Kl31MfZf3h/8i0mLyRHPRPeh9OVYs7CmT1fW1Y0w329O/tiAiQxQN3LxTes5zU/Fg4RjBPxZlcScQGR2JG9yteWzBDx5yM3TRM3oYM0J1wNDaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHrLsz8U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHrLsz8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F042C433C7;
	Mon, 11 Mar 2024 07:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710140642;
	bh=stZeLhfFofFFcO/OysCCwACVqQxQclZqdY1g9N1lmrE=;
	h=From:To:Cc:Subject:Date:From;
	b=pHrLsz8UGd80ZVrcEl7CcWV6Pt1v23RUGGA+iUDJ/oVI9vVdWNHnNPkoPRxhcRVvv
	 oXfzzjj5tabQ6/UVYGmdQNfZ33e9v4ucGiaileBC8fEqA5cBOdY3G27Oj68rP7+J21
	 euYR7+Ajc2+9N3Hjc4/qohBSu3IVFM2res3j9Spv5N3BDC4jWwz1KVgZ3wwyjfYdtq
	 H+cojIEoWdg8yeO5fNgPNzowfq7JgQVl2GPQj2ndzYfemnT+uDKFDSVijJHDaxVPED
	 31bW2VgfNW/KiWsCk188w641Lz0d7J0BmrOsvJBw4cHkldeFTY1Qk9KE9nyJLxihVj
	 w93x0Bj0dmisg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iperf3 v3] add MPTCPv1 support
Date: Mon, 11 Mar 2024 15:03:33 +0800
Message-Id: <4a85ab6ab759ba852647b03af58faded31fbb8f6.1710140596.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in
the upstream Linux kernel since v5.6.

MPTCP is strongly tied to TCP, and the kernel APIs are almost the same.
The only required dependency is the 'IPPROTO_MPTCP' protocol number
definition, which should be provided by the netinet/in.h header if it
is recent enough.

This patch adds a new flag '-m' or '--multipath' to support MPTCPv1.
It can be used like this:

 > iperf3 -m -s
 > iperf3 -m -c 127.0.0.1

There is no need to check for IPPROTO_MPTCP support in configure.ac
at build time, it is at runtime we will see if the kernel being use
supports or not MPTCP.

If IPPROTO_MPTCP is not supported by the kernel being tested, it is
normal to fail because the feature is not available and the user
explicitly asked to use MPTCP.

Closes: https://github.com/esnet/iperf/pull/1659
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 src/iperf.h        |  3 +++
 src/iperf3.1       |  4 ++++
 src/iperf_api.c    | 15 ++++++++++++++-
 src/iperf_locale.c |  3 +++
 src/iperf_tcp.c    | 18 +++++++++++++++---
 src/net.c          | 10 +++++-----
 src/net.h          |  2 +-
 7 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/src/iperf.h b/src/iperf.h
index dc3c0d1..80dda24 100644
--- a/src/iperf.h
+++ b/src/iperf.h
@@ -339,6 +339,9 @@ struct iperf_test
     int	      udp_counters_64bit;		/* --use-64-bit-udp-counters */
     int       forceflush; /* --forceflush - flushing output at every interval */
     int	      multisend;
+#if defined(linux)
+    int       multipath;
+#endif
     int	      repeating_payload;                /* --repeating-payload */
     int       timestamps;			/* --timestamps */
     char     *timestamp_format;
diff --git a/src/iperf3.1 b/src/iperf3.1
index 2efd53d..d847f37 100644
--- a/src/iperf3.1
+++ b/src/iperf3.1
@@ -193,6 +193,10 @@ parameter is specified in ms, and defaults to the system settings.
 This functionality depends on the TCP_USER_TIMEOUT socket option, and
 will not work on systems that do not support it.
 .TP
+.BR -m ", " --multipath " "
+use multipath variant for the current protocol. This only applies to
+TCP and enables MPTCP usage.
+.TP
 .BR -d ", " --debug " "
 emit debugging output.
 Primarily (perhaps exclusively) of use to developers.
diff --git a/src/iperf_api.c b/src/iperf_api.c
index 1dcfaab..a064c5c 100644
--- a/src/iperf_api.c
+++ b/src/iperf_api.c
@@ -1144,6 +1144,9 @@ iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
         {"idle-timeout", required_argument, NULL, OPT_IDLE_TIMEOUT},
         {"rcv-timeout", required_argument, NULL, OPT_RCV_TIMEOUT},
         {"snd-timeout", required_argument, NULL, OPT_SND_TIMEOUT},
+#if defined(linux)
+        {"multipath", no_argument, NULL, 'm'},
+#endif
         {"debug", optional_argument, NULL, 'd'},
         {"help", no_argument, NULL, 'h'},
         {NULL, 0, NULL, 0}
@@ -1169,7 +1172,7 @@ iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
     FILE *ptr_file;
 #endif /* HAVE_SSL */
 
-    while ((flag = getopt_long(argc, argv, "p:f:i:D1VJvsc:ub:t:n:k:l:P:Rw:B:M:N46S:L:ZO:F:A:T:C:dI:hX:", longopts, NULL)) != -1) {
+    while ((flag = getopt_long(argc, argv, "p:f:i:D1VJvsc:ub:t:n:k:l:P:Rw:B:mM:N46S:L:ZO:F:A:T:C:dI:hX:", longopts, NULL)) != -1) {
         switch (flag) {
             case 'p':
 		portno = atoi(optarg);
@@ -1639,6 +1642,12 @@ iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
 		test->settings->connect_timeout = unit_atoi(optarg);
 		client_flag = 1;
 		break;
+#if defined(linux)
+	    case 'm':
+		set_protocol(test, Ptcp);
+		test->multipath = 1;
+		break;
+#endif
 	    case 'h':
 		usage_long(stdout);
 		exit(0);
@@ -2216,6 +2225,8 @@ send_parameters(struct iperf_test *test)
 	    cJSON_AddTrueToObject(j, "reverse");
 	if (test->bidirectional)
 	            cJSON_AddTrueToObject(j, "bidirectional");
+	if (test->multipath)
+	    cJSON_AddTrueToObject(j, "multipath");
 	if (test->settings->socket_bufsize)
 	    cJSON_AddNumberToObject(j, "window", test->settings->socket_bufsize);
 	if (test->settings->blksize)
@@ -2332,6 +2343,8 @@ get_parameters(struct iperf_test *test)
 	    iperf_set_test_reverse(test, 1);
         if ((j_p = cJSON_GetObjectItem(j, "bidirectional")) != NULL)
             iperf_set_test_bidirectional(test, 1);
+	if ((j_p = cJSON_GetObjectItem(j, "multipath")) != NULL)
+	    test->multipath = 1;
 	if ((j_p = cJSON_GetObjectItem(j, "window")) != NULL)
 	    test->settings->socket_bufsize = j_p->valueint;
 	if ((j_p = cJSON_GetObjectItem(j, "len")) != NULL)
diff --git a/src/iperf_locale.c b/src/iperf_locale.c
index ae0f63a..4f680ff 100644
--- a/src/iperf_locale.c
+++ b/src/iperf_locale.c
@@ -128,6 +128,9 @@ const char usage_longstr[] = "Usage: iperf3 [-s|-c host] [options]\n"
                            "  --snd-timeout #           timeout for unacknowledged TCP data\n"
                            "                            (in ms, default is system settings)\n"
 #endif /* HAVE_TCP_USER_TIMEOUT */
+#if defined(linux)
+                           "  -m, --multipath           use MPTCP rather than plain TCP\n"
+#endif
                            "  -d, --debug[=#]           emit debugging output\n"
                            "                            (optional optional \"=\" and debug level: 1-4. Default is 4 - all messages)\n"
                            "  -v, --version             show version information and quit\n"
diff --git a/src/iperf_tcp.c b/src/iperf_tcp.c
index 184a195..84ff646 100644
--- a/src/iperf_tcp.c
+++ b/src/iperf_tcp.c
@@ -44,6 +44,10 @@
 #include "net.h"
 #include "cjson.h"
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 #if defined(HAVE_FLOWLABEL)
 #include "flowlabel.h"
 #endif /* HAVE_FLOWLABEL */
@@ -182,9 +186,10 @@ iperf_tcp_listen(struct iperf_test *test)
      *
      * It's not clear whether this is a requirement or a convenience.
      */
-    if (test->no_delay || test->settings->mss || test->settings->socket_bufsize) {
+    if (test->no_delay || test->multipath || test->settings->mss || test->settings->socket_bufsize) {
 	struct addrinfo hints, *res;
 	char portstr[6];
+	int proto = 0;
 
         FD_CLR(s, &test->read_set);
         close(s);
@@ -210,7 +215,10 @@ iperf_tcp_listen(struct iperf_test *test)
             return -1;
         }
 
-        if ((s = socket(res->ai_family, SOCK_STREAM, 0)) < 0) {
+	if (test->multipath)
+	    proto = IPPROTO_MPTCP;
+
+        if ((s = socket(res->ai_family, SOCK_STREAM, proto)) < 0) {
 	    freeaddrinfo(res);
             i_errno = IESTREAMLISTEN;
             return -1;
@@ -375,8 +383,12 @@ iperf_tcp_connect(struct iperf_test *test)
     socklen_t optlen;
     int saved_errno;
     int rcvbuf_actual, sndbuf_actual;
+    int proto = 0;
+
+    if (test->multipath)
+        proto = IPPROTO_MPTCP;
 
-    s = create_socket(test->settings->domain, SOCK_STREAM, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, &server_res);
+    s = create_socket(test->settings->domain, SOCK_STREAM, proto, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, &server_res);
     if (s < 0) {
 	i_errno = IESTREAMCONNECT;
 	return -1;
diff --git a/src/net.c b/src/net.c
index c82caff..849e919 100644
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
@@ -238,7 +238,7 @@ netdial(int domain, int proto, const char *local, const char *bind_dev, int loca
     struct addrinfo *server_res = NULL;
     int s, saved_errno;
 
-    s = create_socket(domain, proto, local, bind_dev, local_port, server, port, &server_res);
+    s = create_socket(domain, proto, 0, local, bind_dev, local_port, server, port, &server_res);
     if (s < 0) {
       return -1;
     }
diff --git a/src/net.h b/src/net.h
index f0e1b4f..1f5cc4d 100644
--- a/src/net.h
+++ b/src/net.h
@@ -28,7 +28,7 @@
 #define __NET_H
 
 int timeout_connect(int s, const struct sockaddr *name, socklen_t namelen, int timeout);
-int create_socket(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out);
+int create_socket(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out);
 int netdial(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout);
 int netannounce(int domain, int proto, const char *local, const char *bind_dev, int port);
 int Nread(int fd, char *buf, size_t count, int prot);
-- 
2.40.1

