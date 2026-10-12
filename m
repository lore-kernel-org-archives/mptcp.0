Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8683B6BFA;
	Mon, 12 Oct 2026 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805412; cv=none; b=IMv6ZqYYKdg7mI3KJvgGPIi2N2XKmm9VyT/mFI4jMdiSudLH7Proa3IOvcM0O2thpEtGaSOuC03m7T5jMOxQxcmxt3I/W/iMhmjfLvW8PbX7mE0yziOfsxxMpibK9VJJQj3u5E7khJXYYzz8U2n5rIDio4zg9F1rTGt7EEyWQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805412; c=relaxed/simple;
	bh=QywlOtHVCWjGzDGEYVoq8CHeQJUpWd2ryrHm5jfxzoo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jG0tCbPKB740w0E0nw5kkBuQsR8GuJhIH+29MlmLCHaNRmNsbn5kgRT9fWnT4tFE+FOyp/m+u70LfV4Ur4jDvu1Vk3ukiqKaOb7k1kJn3e0p7sP/E6B5RvlqenZG5GfFwazJkpJ5VqjRSdBgqX2ZoLovxmgGaKXS4XooL2WbbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD8fruwF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD8fruwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E911F0089D;
	Mon, 12 Oct 2026 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791805408;
	bh=5UxJrnWb6DUWlRK98/7z/XIw7Ci0cIBCbPmLnyjbiss=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XD8fruwFh0qa/PYAcaRWNY4ybAX/Xa59SwCqMrxJZWurpcbLbolbAJ4VrdISih0xY
	 81j5lHiFbzQAhtzYc2mLNjdtmsi6DWFYpow2gqnC8qzT5I5H4AAJGLv19RrF1CiNv7
	 SAPhp4LCJbJrSTE85fkrRBYrCpdShlI4StCjIAPeeiKBts4lEUeJjydmHDti7wdN4a
	 hRkDQugJ+4U+FAlcnGMtOsU01Hxn0KT6ptuqbw4Vqlc6T+j9PxeRDI7xBXkVPtFJNs
	 S0fO0+KmizjW3fxR3LYObD2cTT2QYAWZaEg3HnYFcF+/gtQZUAU+ig2scqm8o9J5JI
	 cA15IWBJHOiYA==
Subject: Re: [PATCH mptcp-next] selftests: mptcp: sockopt: test passive Fast
 Open early write push
From: netdev-bot+sashiko@kernel.org
To: rameshsv06@gmail.com
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 rameshkumar.t@phytecembedded.in, kuba@kernel.org
Date: Mon, 12 Oct 2026 11:43:27 +0000
Message-ID: <179180540754.434549.14278237692861809718@kernel.org>
In-Reply-To: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
References: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new test never runs the code path it was written to cover.
- [Medium] do_fastopen_tests() runs the TFO subtests without first
  checking that the kernel supports MPTCP Fast Open.
- [Medium] The TFO branches of client() and server() in mptcp_sockopt.c
  skip every MPTCP-level check.
- [Medium] Even if passive TFO were actually triggered (see the
  sysctl/cookie finding), the test has nothing that keeps the handshake…
- [Low] The commit author is 'T S Rameshkumar <rameshsv06@gmail.com>',
  but the only Signed-off-by is 'T S Rameshkumar…
- [Low] parse_opts() in mptcp_sockopt.c now accepts '-f' (the getopt
  string changed from "h6" to "h6f"), but die_usage(), which both -h and…
- [Low] Result checking in the TFO path is fragile and weaker than in the
  non-TFO path.

--

selftests: mptcp: sockopt: test passive Fast Open early write push

This adds a -f option to mptcp_sockopt. It enables TCP_FASTOPEN on the
MPTCP listener and TCP_FASTOPEN_CONNECT on the client, then exchanges a
short request and reply. mptcp_sockopt.sh gains do_fastopen_tests(),
which sets net.ipv4.tcp_fastopen=3 in ns_sbox and runs the helper over
IPv4 and IPv6.

> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>

[Severity: Low]
The author is T S Rameshkumar <rameshsv06@gmail.com>, but the only
Signed-off-by uses rameshkumar.t@phytecembedded.in. checkpatch reports
this as FROM_SIGN_OFF_MISMATCH.

Could the Signed-off-by, the author, or an explicit From: line be
updated so they match?

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index d68515b7903b8..861de909abbd8 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c

[ ... ]

> @@ -271,7 +280,7 @@ static void parse_opts(int argc, char **argv)
>  {
>  	int c;
>  
> -	while ((c = getopt(argc, argv, "h6")) != -1) {
> +	while ((c = getopt(argc, argv, "h6f")) != -1) {

[Severity: Low]
This isn't a bug, but die_usage() still prints:

	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");

Should the usage string also list the new -f option?

[ ... ]

> @@ -726,13 +738,36 @@ static int server(int pipefd)

[ ... ]

>  	alarm(15);
>  	r = xaccept(fd);
>  
> -	process_one_client(r, pipefd);
> +	if (do_tfo) {
> +		char buf[64] = {0};
> +		ssize_t n;
> +
> +		n = read(r, buf, sizeof(buf) - 1);
> +		if (n <= 0)
> +			die_perror("read tfo syn data");
> +
> +		n = write(r, "PONG_REPLY", 10);
> +		if (n != 10)
> +			die_perror("write tfo reply");

[Severity: Medium]
Even if passive TFO were triggered, what keeps the handshake incomplete
while this write runs? server() does xaccept() -> read() ->
write("PONG_REPLY").

On loopback, the server stack is likely to process the client's final
ACK in softirq before the process returns from accept(), or between the
read() and the write().

Nothing in the test holds that ACK back (for example, a netfilter rule
that drops the final ACK). Nothing checks that the socket is still in
SYN_RECV when the write happens either.

Wouldn't a normal write on an established socket still be reported as a
"Fast Open early write" pass?

> +
> +		n = read(r, buf, 1);
> +		close(r);
> +	} else {
> +		process_one_client(r, pipefd);
> +	}

[Severity: Medium]
This TFO branch, and the one added to client(), skip every MPTCP-level
check. In the non-TFO path, process_one_client() and
connect_one_server() call do_getsockopts() (MPTCP_INFO, MPTCP_TCPINFO,
...). They also check mptcpi_rcv_delta and the bytes_sent, received and
acked counters.

The new branches only do a plain write/read exchange and never call
getsockopt(SOL_MPTCP, ...).

If MPTCP with TFO silently fell back to plain TCP, wouldn't this still
pass?

> @@ -844,6 +879,26 @@ static int client(int pipefd)
>  
>  	alarm(15);
>  
> +	if (do_tfo) {

[ ... ]

> +		setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
> +		n = read(fd, buf, sizeof(buf) - 1);
> +		if (n <= 0 || strcmp(buf, "PONG_REPLY") != 0)
> +			xerror("Fastopen early write failed: received %zd bytes '%s'", n, buf);

[Severity: Low]
On a stream socket, read() can return fewer than the 10 bytes the
server wrote. Could a short read here cause a spurious failure, since
the result is compared exactly against "PONG_REPLY" with strcmp()?

On the server side, the return value of the final read in server() is
stored but never checked:

		n = read(r, buf, 1);
		close(r);

process_one_client() checks for EOF instead:

	ret3 = read(fd, buf, 1);
	if (ret3 != 0)
		xerror("expected EOF, got %lu", ret3);

Should the TFO path do the same, so that read errors or unexpected extra
data are not silently ignored?

[ ... ]

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index b4e3eddc9cf21..e88a8bbeb6e36 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -359,6 +359,39 @@ do_tcpinq_tests()
>  	return $?
>  }
>  
> +do_fastopen_tests()
> +{
> +	local lret=0
> +

[Severity: Medium]
Should this function check for MPTCP Fast Open support before it runs?

On a kernel without that support, one of two setsockopt() calls fails:
TCP_FASTOPEN in server() or TCP_FASTOPEN_CONNECT in
sock_connect_mptcp(). die_perror() then exits with 1. The script
records "Fast Open early write v4" as a failure and sets ret, where a
skip would be expected.

do_tcpinq_tests() in this script already handles this case:

	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
		mptcp_lib_pr_skip "TCP_INQ not supported"
		mptcp_lib_result_skip "TCP_INQ"
		return
	fi

run_tests_mptfo() in mptcp_connect.sh does the same with
mptcp_lib_kallsyms_has "mptcp_fastopen_".

> +	ip netns exec "$ns_sbox" sysctl -q net.ipv4.tcp_fastopen=3

[Severity: High]
Does this test ever reach the passive Fast Open path it is meant to
cover?

The value 3 is TFO_CLIENT_ENABLE | TFO_SERVER_ENABLE. It does not set
TFO_CLIENT_NO_COOKIE (0x4) or TFO_SERVER_COOKIE_NOT_REQD (0x200). Also,
sock_connect_mptcp() does not set TCP_FASTOPEN_NO_COOKIE.

Each mptcp_sockopt -f run makes a single connection, first to 127.0.0.1
and then to ::1. So no cookie is cached for either destination in
ns_sbox. On the client, tcp_fastopen_defer_connect() then gets false
from here:

net/ipv4/tcp_fastopen.c:tcp_fastopen_cookie_check() {
    ...
	if (cookie->len > 0)
		return true;
	tcp_sk(sk)->fastopen_client_fail = TFO_COOKIE_UNAVAILABLE;
	return false;
}

As a result, connect() does a normal handshake and sends a cookie-request
SYN with no data.

On the server, tcp_try_fastopen() only generates a cookie:

	if (foc->len == 0) {
		/* Client requests a cookie. */
		tcp_fastopen_cookie_gen(sk, req, skb, &valid_foc);

No TFO child socket is created. accept() returns an ESTABLISHED socket,
PING_DATA arrives after the handshake, and PONG_REPLY is an ordinary
write.

Neither side checks that TFO actually happened. There is no
TCPI_OPT_SYN_DATA check on tcpi_options and no TcpExtTCPFastOpenPassive
check, and the server doesn't compare the payload it reads.

Wouldn't this pass whether or not the MPTCP passive TFO early write path
works?

This also seems to contradict the commit message, which says the server:

  "accepts an incoming connection with SYN payload data, and immediately
  writes reply bytes before the 3-way handshake fully completes"

For comparison, run_tests_mptfo() in mptcp_connect.sh connects to each
address twice, so the second connection has a cookie:

	run_tests_lo "$ns1" "$ns2" 10.0.1.1 0 "-o MPTFO"
	run_tests_lo "$ns1" "$ns2" 10.0.1.1 0 "-o MPTFO"

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008111003.136143-1-rameshkumar.t%40phytecembedded.in
