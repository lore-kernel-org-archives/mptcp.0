Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF1826288
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905899; cv=none; b=GQY9TvXFVbyz6tzCWKJgJH8AamS4xrVoiZseMNnJLEsg0p3UvulzuekPCukuINBOtDWdYTyJx00XTOTWp7Qyh2czcxg/ENZi7X3yGh1kbwlk9jpYs0NsZJGqoArKWnD9xjc2+xSd4MwGnlbmANZtQ9u6fec3nBaiYUa8B8ffHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905899; c=relaxed/simple;
	bh=/4fOMVhNAHVIZOPRNOSPUHQ6JG07IC4wHN+hVu2Bwl8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BMhXNjNpx+QrPlA8xMTJE1NpsHJcV05ebd9a4mpioOkZWH9bV1rI0CJwhu48lhG5SBZwT813JA0rPxRc3b/bPGSjTVrKDEkM0zvV0Df1lL5uq9jVMll6HJtJsU9Lc2YRXMGjyLL2//Tp8EIUBPEQopLL9JbplwcRunXOI5Qc5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeUz11O5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeUz11O5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6235BC116B1;
	Tue, 23 Apr 2024 20:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713905899;
	bh=/4fOMVhNAHVIZOPRNOSPUHQ6JG07IC4wHN+hVu2Bwl8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CeUz11O5j9/FTmUg++CozcesESQFWBqO2P6OBppaAmMYX2jplnXtZEnMpjVrmoJm5
	 1qGfbXDFgfbK3Mf7SoG/g0hYdhoMtOSVpdhUcFR/ROu+K24EpScUkQkiKHty8rNEez
	 9Z9Q7N7h0bzjL8selNCOm8S3VP9q6NPkJ6g6/v7r6X3l3bU+eeucfCWrui14h8il+G
	 bOhx8jVpQPu0+hUdXGZt8Ms5RXXaJWMdpAzIb2SEgOYTqtpY8+edzxjp56lxHPPuXE
	 iwSUo6KrjImu5j4cJILuJUZeOvl/XZoW61gxUOtRcqjtKeGwS1RtR+7WBfQDS1cgL+
	 uKWG+h8BSXAZQ==
Date: Tue, 23 Apr 2024 13:58:17 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 2/4] selftests/bpf: Add mptcp subflow
 subtest
In-Reply-To: <c479600e938723857db1bba00c98c100c3852aca.1713612119.git.tanggeliang@kylinos.cn>
Message-ID: <fe31493a-c21a-9535-36a8-8d49981f3d19@kernel.org>
References: <cover.1713612119.git.tanggeliang@kylinos.cn> <c479600e938723857db1bba00c98c100c3852aca.1713612119.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 20 Apr 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds a subtest named test_subflow to load and verify the newly
> added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
> to add a new subflow endpoint. Add another helper ss_search() to verify the
> fwmark and congestion values set by mptcp_subflow prog using setsockopts.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 +++++++++++++++++-
> 1 file changed, 108 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index d3cc3541dd4f..0b0da4556d91 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -9,6 +9,7 @@
> #include "network_helpers.h"
> #include "mptcp_sock.skel.h"
> #include "mptcpify.skel.h"
> +#include "mptcp_subflow.skel.h"
> #include "mptcp_bpf_first.skel.h"
> #include "mptcp_bpf_bkup.skel.h"
> #include "mptcp_bpf_rr.skel.h"
> @@ -16,6 +17,9 @@
> #include "mptcp_bpf_burst.skel.h"
>
> #define NS_TEST "mptcp_ns"
> +#define ADDR_1	"10.0.1.1"
> +#define ADDR_2	"10.0.1.2"
> +#define PORT_1	10001
> #define WITH_DATA	true
> #define WITHOUT_DATA	false
>
> @@ -41,6 +45,9 @@
> #endif
> #define MPTCP_SCHED_NAME_MAX	16
>
> +static const unsigned int total_bytes = 10 * 1024 * 1024;
> +static int duration;
> +
> struct __mptcp_info {
> 	__u8	mptcpi_subflows;
> 	__u8	mptcpi_add_addr_signal;
> @@ -332,8 +339,106 @@ static void test_mptcpify(void)
> 	close(cgroup_fd);
> }
>
> -static const unsigned int total_bytes = 10 * 1024 * 1024;
> -static int stop, duration;
> +static int endpoint_init(char *flags)
> +{
> +	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
> +	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
> +	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> +	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
> +	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> +	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
> +
> +	return 0;
> +fail:
> +	return -1;
> +}
> +
> +static int _ss_search(char *src, char *dst, char *port, char *keyword)
> +{
> +	char cmd[128];
> +
> +	snprintf(cmd, sizeof(cmd),
> +		 "ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
> +		 NS_TEST, src, dst, port, PORT_1, keyword);

Hi Geliang -

Sorry I missed this before, can you validate the return value of 
snprintf() before executing the command? I see that wasn't included in the 
old has_bytes_sent() code that this is similar to, but it would be good to 
fix it now.

Thanks,
Mat

> +	return system(cmd);
> +}
> +
> +static int ss_search(char *src, char *keyword)
> +{
> +	return _ss_search(src, ADDR_1, "dport", keyword);
> +}
> +
> +static void run_subflow(char *new)
> +{
> +	int server_fd, client_fd, err;
> +	char cc[TCP_CA_NAME_MAX];
> +	socklen_t len = sizeof(cc);
> +
> +	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> +		return;
> +
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
> +		goto fail;
> +
> +	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> +	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
> +		goto fail;
> +
> +	send_byte(client_fd);
> +
> +	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
> +	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
> +	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
> +	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
> +
> +	close(client_fd);
> +fail:
> +	close(server_fd);
> +}
> +
> +static void test_subflow(void)
> +{
> +	int cgroup_fd, prog_fd, err;
> +	struct mptcp_subflow *skel;
> +	struct nstoken *nstoken;
> +
> +	cgroup_fd = test__join_cgroup("/mptcp_subflow");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
> +		return;
> +
> +	skel = mptcp_subflow__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_subflow"))
> +		goto close_cgroup;
> +
> +	err = mptcp_subflow__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach: mptcp_subflow"))
> +		goto skel_destroy;
> +
> +	prog_fd = bpf_program__fd(skel->progs.mptcp_subflow);
> +	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
> +	if (!ASSERT_OK(err, "prog_attach"))
> +		goto skel_destroy;
> +
> +	nstoken = create_netns();
> +	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
> +		goto skel_destroy;
> +
> +	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
> +		goto close_netns;
> +
> +	run_subflow(skel->data->cc);
> +
> +close_netns:
> +	cleanup_netns(nstoken);
> +skel_destroy:
> +	mptcp_subflow__destroy(skel);
> +close_cgroup:
> +	close(cgroup_fd);
> +}
> +
> +static int stop;
>
> static void *server(void *arg)
> {
> @@ -414,10 +519,6 @@ static void send_data(int lfd, int fd, char *msg)
> 	      PTR_ERR(thread_ret));
> }
>
> -#define ADDR_1	"10.0.1.1"
> -#define ADDR_2	"10.0.1.2"
> -#define PORT_1	10001
> -
> static struct nstoken *sched_init(char *flags, char *sched)
> {
> 	struct nstoken *nstoken;
> @@ -558,6 +659,7 @@ void test_mptcp(void)
> {
> 	RUN_MPTCP_TEST(base);
> 	RUN_MPTCP_TEST(mptcpify);
> +	RUN_MPTCP_TEST(subflow);
> 	RUN_MPTCP_TEST(default);
> 	RUN_MPTCP_TEST(first);
> 	RUN_MPTCP_TEST(bkup);
> -- 
> 2.40.1
>
>
>
