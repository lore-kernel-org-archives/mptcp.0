Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F26971
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 03:20:30 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:42688.1901079118
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-9dddec36bfe846c68c74ae94df3bc238 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id ED83E2800DB;
	Thu, 15 Apr 2021 11:20:30 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 2e622c0b18e9455f82878196efa52b0d for mptcp@lists.linux.dev;
	Thu Apr 15 11:20:28 2021
X-Transaction-ID: 2e622c0b18e9455f82878196efa52b0d
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev,
	mptcp@lists.01.org
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	fw@strlen.de,
	pabeni@redhat.com,
	wujianguo@chinatelecom.cn,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v2 2/2] selftests: mptcp: add a test case for MSG_PEEK
Date: Thu, 15 Apr 2021 11:19:12 +0800
Message-Id: <1618456752-139032-2-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1618456752-139032-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1618456752-139032-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Extend mptcp_connect tool with MSG_PEEK support and add a test case in
mptcp_connect.sh that checks the data recvived from/after recv() with
MSG_PEEK.

eg: sh mptcp_connect.sh -4 -m poll -P

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 45 +++++++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 49 +++++++++++++++++++++-
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 2f207cf..668a041 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -45,7 +45,14 @@ enum cfg_mode {
 	CFG_MODE_SENDFILE,
 };
 
+enum cfg_peek {
+	CFG_NONE_PEEK,
+	CFG_WITH_PEEK,
+	CFG_AFTER_PEEK,
+};
+
 static enum cfg_mode cfg_mode = CFG_MODE_POLL;
+static enum cfg_peek cfg_peek = CFG_NONE_PEEK;
 static const char *cfg_host;
 static const char *cfg_port	= "12000";
 static int cfg_sock_proto	= IPPROTO_MPTCP;
@@ -73,6 +80,7 @@ static void die_usage(void)
 	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
 	fprintf(stderr, "\t-u -- check mptcp ulp\n");
 	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
+	fprintf(stderr, "\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket \n");
 	exit(1);
 }
 
@@ -331,6 +339,8 @@ static size_t do_write(const int fd, char *buf, const size_t len)
 
 static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
 {
+	int ret = 0;
+	char tmp[16384];
 	size_t cap = rand();
 
 	cap &= 0xffff;
@@ -340,7 +350,17 @@ static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
 	else if (cap > len)
 		cap = len;
 
-	return read(fd, buf, cap);
+	if (cfg_peek == CFG_WITH_PEEK) {
+		ret = recv(fd, buf, cap, MSG_PEEK);
+		ret = (ret < 0) ? ret : read(fd, tmp, ret);
+	} else if (cfg_peek == CFG_AFTER_PEEK) {
+		ret = recv(fd, buf, cap, MSG_PEEK);
+		ret = (ret < 0) ? ret : read(fd, buf, cap);
+	} else {
+		ret = read(fd, buf, cap);
+	}
+
+	return ret;
 }
 
 static void set_nonblock(int fd)
@@ -819,6 +839,24 @@ int parse_mode(const char *mode)
 	return 0;
 }
 
+int parse_peek(const char *mode)
+{
+	if (!strcasecmp(mode, "saveWithPeek"))
+		return CFG_WITH_PEEK;
+	if (!strcasecmp(mode, "saveAfterPeek"))
+		return CFG_AFTER_PEEK;
+
+	fprintf(stderr, "Unknown: %s\n", mode);
+	fprintf(stderr, "Supported MSG_PEEK mode are:\n");
+	fprintf(stderr, "\t\t\"saveWithPeek\" - recv data with flags 'MSG_PEEK' and save the peek data into file \n");
+	fprintf(stderr, "\t\t\"saveAfterPeek\" - read data form socket and save it into file after recv with flags 'MSG_PEEK' \n");
+
+	die_usage();
+
+	/* silence compiler warning */
+	return 0;
+}
+
 static int parse_int(const char *size)
 {
 	unsigned long s;
@@ -846,7 +884,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:")) != -1) {
+	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:P:")) != -1) {
 		switch (c) {
 		case 'j':
 			cfg_join = true;
@@ -899,6 +937,9 @@ static void parse_opts(int argc, char **argv)
 		case 'M':
 			cfg_mark = strtol(optarg, NULL, 0);
 			break;
+		case 'P':
+			cfg_peek = parse_peek(optarg);
+			break;
 		}
 	}
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 385cdc9..aa267f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -3,7 +3,7 @@
 
 time_start=$(date +%s)
 
-optstring="S:R:d:e:l:r:h4cm:f:t"
+optstring="S:R:d:e:l:r:h4cm:f:tP"
 ret=0
 sin=""
 sout=""
@@ -23,6 +23,8 @@ rcvbuf=0
 options_log=true
 do_tcp=0
 filesize=0
+testpeek=false
+peekmode=""
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -47,6 +49,7 @@ usage() {
 	echo -e "\t-R: set rcvbuf value (default: use kernel default)"
 	echo -e "\t-m: test mode (poll, sendfile; default: poll)"
 	echo -e "\t-t: also run tests with TCP (use twice to non-fallback tcp)"
+	echo -e "\t-P: test MSG_PEEK flags of recv() function"
 }
 
 while getopts "$optstring" option;do
@@ -104,6 +107,10 @@ while getopts "$optstring" option;do
 	"t")
 		do_tcp=$((do_tcp+1))
 		;;
+	"P")
+		testpeek=true
+		peekmode="saveWithPeek"
+		;;
 	"?")
 		usage $0
 		exit 1
@@ -393,6 +400,10 @@ do_transfer()
 		extra_args="$extra_args -m $testmode"
 	fi
 
+	if $testpeek; then
+		extra_args="$extra_args -P $peekmode"
+	fi
+
 	if [ -n "$extra_args" ] && $options_log; then
 		options_log=false
 		echo "INFO: extra options: $extra_args"
@@ -734,7 +745,41 @@ done
 
 time_end=$(date +%s)
 time_run=$((time_end-time_start))
-
 echo "Time: ${time_run} seconds"
 
+# if testpeek enable, set peekmode="saveAfterPeek" and test again
+if $testpeek; then
+	time_start=$(date +%s)
+	peekmode="saveAfterPeek"
+	options_log=true
+	for sender in $ns1 $ns2 $ns3 $ns4;do
+		run_tests_lo "$ns1" "$sender" 10.0.1.1 1
+		if [ $ret -ne 0 ] ;then
+			echo "FAIL: Could not even run loopback test" 1>&2
+			exit $ret
+		fi
+		run_tests_lo "$ns1" $sender dead:beef:1::1 1
+		if [ $ret -ne 0 ] ;then
+			echo "FAIL: Could not even run loopback v6 test" 2>&1
+			exit $ret
+		fi
+
+		run_tests "$ns2" $sender 10.0.1.2
+		run_tests "$ns2" $sender dead:beef:1::2
+		run_tests "$ns2" $sender 10.0.2.1
+		run_tests "$ns2" $sender dead:beef:2::1
+
+		run_tests "$ns3" $sender 10.0.2.2
+		run_tests "$ns3" $sender dead:beef:2::2
+		run_tests "$ns3" $sender 10.0.3.2
+		run_tests "$ns3" $sender dead:beef:3::2
+
+		run_tests "$ns4" $sender 10.0.3.1
+		run_tests "$ns4" $sender dead:beef:3::1
+	done
+	time_end=$(date +%s)
+	time_run=$((time_end-time_start))
+	echo "Time: ${time_run} seconds"
+fi
+
 exit $ret
-- 
1.8.3.1

