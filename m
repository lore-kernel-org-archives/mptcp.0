Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C75385
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 17:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364A7C433C7;
	Fri,  7 Jul 2023 17:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688751950;
	bh=heL45rDniuCFq7tk5TK0CSLjr1QYLEqDTyCStvrSLtg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QhzHshju5K7VjbMfz6XfZRS/AqYI7p3TrsYQaK6gnp055RY3EO73jZUBMXe8h5ZUf
	 l0bnJITrpbtiTIKV1aNhaodVw49wZAJKKu3d5jSPftahmuMVAV4gApHZK//Cd5rhWM
	 aHPFxaSmx7l/eJPUEhXl3SIhJ3L2jqPDZkc7pmzJ9vUI6e7AOalYdLQX6ZoNClcY0D
	 EU0KazxVi7iWt5M6goCc+8VKBXJt18bz0qDKGS2oeBLFK+pb6G/g8i/mrsdQaBSul5
	 8nJUJUgX6xQ/ecaV8XghsYHk4x4fXMurWwBErgS98oKXHTJtAR03HCc4tmKy4TyLSE
	 hApQxl8WBAxjA==
Date: Fri, 7 Jul 2023 10:45:49 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 01/10] Squash to "selftests/bpf: Add bpf_first
 test"
In-Reply-To: <c9699387fc337c02b3135b199aaa8d90bd741eb1.1687829823.git.geliang.tang@suse.com>
Message-ID: <c759757d-1603-5a84-4ddb-36e7735e78e9@kernel.org>
References: <cover.1687829823.git.geliang.tang@suse.com> <c9699387fc337c02b3135b199aaa8d90bd741eb1.1687829823.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Tue, 27 Jun 2023, Geliang Tang wrote:

> '''
> selftests/bpf: Add bpf scheduler test
>
> This patch expends the MPTCP test base to support MPTCP packet scheduler

I think you mean "extends" rather than "expends" here, but other than that 
patches 1-5 are ok to merge:

Reviewed-by: Mat Martineau <martineau@kernel.org>



> tests. Add a new test to use the default in-kernel scheduler.
>
> In the new helper sched_init(), add two veth net devices to simulate the
> multiple addresses case. Use 'ip mptcp endpoint' command to add the new
> endpoint ADDR_2 to PM netlink. Use sysctl to set net.mptcp.scheduler to
> use the given sched.
>
> Invoke start_mptcp_server() to start the server on ADDR_1, and invoke
> connect_to_fd() to connect with the server from the client. Then invoke
> send_data() to send data.
>
> Some code in send_data() is from prog_tests/bpf_tcp_ca.c.
>
> Add time metrics for BPF tests to compare the performance of each
> schedulers. Run prog_tests with '-v' option can print out the running
> time of each test.
>
> Use the new helper has_bytes_sent() to check the bytes_sent filed of 'ss'
> output after send_data() to make sure no data has been sent on ADDR_2.
> All data has been sent on the first subflow.
>
> Invoke the new helper sched_cleanup() to set back net.mptcp.scheduler to
> default, flush all mptcp endpoints, and delete the veth net devices.
> '''
>
> Note: This commit should be inserted beteen "selftests/bpf: add two mptcp
> netns helpers" and "selftests/bpf: Add bpf_first scheduler":
>
> selftests/bpf: add two mptcp netns helpers
> selftests/bpf: Add bpf scheduler test
> selftests/bpf: Add bpf_first scheduler
> selftests/bpf: Add bpf_first test
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 43 +++++++++----------
> 1 file changed, 20 insertions(+), 23 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index a968641cc94a..39d95c6a18e3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -3,10 +3,10 @@
> /* Copyright (c) 2022, SUSE. */
>
> #include <test_progs.h>
> +#include <time.h>
> #include "cgroup_helpers.h"
> #include "network_helpers.h"
> #include "mptcp_sock.skel.h"
> -#include "mptcp_bpf_first.skel.h"
> #include "mptcp_bpf_bkup.skel.h"
> #include "mptcp_bpf_rr.skel.h"
> #include "mptcp_bpf_red.skel.h"
> @@ -247,15 +247,19 @@ static void *server(void *arg)
> 	return NULL;
> }
>
> -static void send_data(int lfd, int fd)
> +static void send_data(int lfd, int fd, char *msg)
> {
> 	ssize_t nr_recv = 0, bytes = 0;
> +	struct timespec start, end;
> +	unsigned int delta_ms;
> 	pthread_t srv_thread;
> 	void *thread_ret;
> 	char batch[1500];
> 	int err;
>
> 	WRITE_ONCE(stop, 0);
> +	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
> +		return;
>
> 	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
> 	if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
> @@ -272,9 +276,16 @@ static void send_data(int lfd, int fd)
> 		bytes += nr_recv;
> 	}
>
> +	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
> +		return;
> +
> +	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
> +
> 	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
> 	      bytes, total_bytes, nr_recv, errno);
>
> +	printf("%s: %u ms\n", msg, delta_ms);
> +
> 	WRITE_ONCE(stop, 1);
>
> 	pthread_join(srv_thread, &thread_ret);
> @@ -315,39 +326,25 @@ static int has_bytes_sent(char *addr)
> 	return system(cmd);
> }
>
> -static void test_first(void)
> +static void test_default(void)
> {
> -	struct mptcp_bpf_first *first_skel;
> 	int server_fd, client_fd;
> 	struct nstoken *nstoken;
> -	struct bpf_link *link;
> -
> -	first_skel = mptcp_bpf_first__open_and_load();
> -	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
> -		return;
>
> -	link = bpf_map__attach_struct_ops(first_skel->maps.first);
> -	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> -		mptcp_bpf_first__destroy(first_skel);
> -		return;
> -	}
> -
> -	nstoken = sched_init("subflow", "bpf_first");
> -	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
> +	nstoken = sched_init("subflow", "default");
> +	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
> 		goto fail;
> 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
> 	client_fd = connect_to_fd(server_fd, 0);
>
> -	send_data(server_fd, client_fd);
> +	send_data(server_fd, client_fd, "default");
> 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
> -	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
> +	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
>
> 	close(client_fd);
> 	close(server_fd);
> fail:
> 	cleanup_netns(nstoken);
> -	bpf_link__destroy(link);
> -	mptcp_bpf_first__destroy(first_skel);
> }
>
> static void test_bkup(void)
> @@ -459,8 +456,8 @@ void test_mptcp(void)
> {
> 	if (test__start_subtest("base"))
> 		test_base();
> -	if (test__start_subtest("first"))
> -		test_first();
> +	if (test__start_subtest("default"))
> +		test_default();
> 	if (test__start_subtest("bkup"))
> 		test_bkup();
> 	if (test__start_subtest("rr"))
> -- 
> 2.35.3
>
>
>
