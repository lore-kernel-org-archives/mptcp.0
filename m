Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7E7D07D
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736996902; cv=none; b=Mt5j7XZ4aW60wFJskqWhUtpYSiyD8+YfxW1P3kbZTkFB+/YwWaQKPzAdz9VfFCmlG/QQ/R4Le52EujDFUgjwqkCDH+mjzkwfNLO7D5nFvT8+fCrJ2dBJJifp3kqCiWnj6RjUNFavy8du3EJLTJ1D/arh6dFY/sUtsae5rh5Ruuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736996902; c=relaxed/simple;
	bh=JnGaYN6KWhxbxNN8NLUjFd3VUllZT60G5QvO7mV6au8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=liZGX1lBxjBxC566C3CA95mRNgroPH3W+18PD9ALuJaS2Yy3Vs65J8eqC2LXgW2aSpVoEumW+gZEQN0llUDU7WvoKAp04xgi2yEy3FyD5olrc9YYjs71rLaxEbwzSyysJFecrp9zydlDYjCD2LfEY2TxdPk4H4C+OhdxEM0WOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9uyiY9Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9uyiY9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E830C4CED1;
	Thu, 16 Jan 2025 03:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736996900;
	bh=JnGaYN6KWhxbxNN8NLUjFd3VUllZT60G5QvO7mV6au8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N9uyiY9Zt6eR3aPwho70rs9qla7mYGTbydMDqgR8hrIYtXsP7TqJHJwK0WV2kap48
	 tU1OmdLtqQ6Wi18TK7x2EnBurHfzUdUn1ZgL4xebp7xhh77Op79hYulO/n5zT0KIEj
	 nAju13t9oIMR/98p1XNhrpZTEyrdoSJXLS6/4X5VapUfirMxZ9q4xHzcWFQk9vWWoI
	 Ubfe3E7uHNPOX1f53uHd6j3WQjrwvyhlDqqiWUhc0rCYuSKskGdhxjfZucLwyUvxr5
	 PJlGdaVHS0GCBfJ2a46rZ2XOteHk9ZbWU+n2kSducECCTuVtTuI+hwpygFlUQ6lra8
	 S7tqNwwkp++3Q==
Message-ID: <a4ed529b3f189077946aa20734a4437c362f3915.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 5/5] selftests/bpf: Add
 mptcp_userspace_pm_addr bpf_iter subtest
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 16 Jan 2025 11:08:17 +0800
In-Reply-To: <37907405c495249ead2cb2f1a6c505d9062710f7.1736325184.git.tanggeliang@kylinos.cn>
References: <cover.1736325184.git.tanggeliang@kylinos.cn>
	 <37907405c495249ead2cb2f1a6c505d9062710f7.1736325184.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-01-08 at 16:38 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a test program for the newly added
> mptcp_userspace_pm_addr
> bpf_iter in SEC "cgroup/getsockopt". This test iterates over all
> address
> entries on the local address list of userspace PM and check whether
> each
> one is an IPv4mapped address.
> 
> Export mptcp_userspace_pm_addr helpers _new/_next/_destroy into
> bpf_experimental.h. Use bpf_mptcp_sock_acquire() to acquire the msk,
> then
> lock the msk pm lock and use bpf_for_each(mptcp_userspace_pm_addr) to
> walk
> the local address list of this msk. Invoke bpf_ipv4_is_private_10()
> in the
> loop to check whether the address is a "10.*" one. Then Add the
> address ID
> of each entry to local veriable local_ids.
> 
> Out of the loop, unlock the msk pm lock and use
> bpf_mptcp_sock_release() to
> release the msk. Finally, assign local_ids to global variable ids so
> that
> the application can obtain this value.
> 
> Also enable CONFIG_MPTCP_IPV6 in bpf config.

This line should be dropped.

Will update it in the next version.

Thanks,
-Geliang

> 
> Add a subtest named test_iters_address to load and verify the newly
> added
> mptcp_userspace_pm_addr type bpf_iter example in test_mptcp.
> 
> Since mptcp_userspace_pm_addr bpf_iter iterates over all address
> entries
> on the local address list of userspace PM. A set of userspace PM
> helpers
> are added.
> 
> Set pm_type and start "pm_nl_ctl events" command to save pm events
> into
> the log file /tmp/bpf_userspace_pm_events in userspace_pm_init().
> Kill
> "pm_nl_ctl" command and remove the log file in
> userspace_pm_cleanup().
> Parse the log file in userspace_pm_add_subflow() to get the token,
> sport
> and dport values, then use "pm_nl_ctl csf" command to create a
> subflow.
> 
> Use the helper userspace_pm_add_subflow() to add 3 new subflow
> endpoints.
> Send a byte of message to start the mptcp connection, and receive the
> message.
> 
> getsockopt() is invoked to trigger the "cgroup/getsockopt" test
> program.
> Check if skel->bss->ids equals 60 to verify whether the program loops
> three times as expected.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  |   8 +
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 214
> ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/mptcp_bpf.h |   5 +
>  .../selftests/bpf/progs/mptcp_bpf_iters.c     |  38 ++++
>  4 files changed, 265 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
> b/tools/testing/selftests/bpf/bpf_experimental.h
> index 2ab3f0063c0f..01201917a446 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -583,6 +583,14 @@ bpf_iter_mptcp_subflow_next(struct
> bpf_iter_mptcp_subflow *it) __weak __ksym;
>  extern void
>  bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
> __weak __ksym;
>  
> +struct bpf_iter_mptcp_userspace_pm_addr;
> +extern int bpf_iter_mptcp_userspace_pm_addr_new(struct
> bpf_iter_mptcp_userspace_pm_addr *it,
> +						struct mptcp_sock
> *msk) __weak __ksym;
> +extern struct mptcp_pm_addr_entry *
> +bpf_iter_mptcp_userspace_pm_addr_next(struct
> bpf_iter_mptcp_userspace_pm_addr *it) __weak __ksym;
> +extern void
> +bpf_iter_mptcp_userspace_pm_addr_destroy(struct
> bpf_iter_mptcp_userspace_pm_addr *it) __weak __ksym;
> +
>  extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int
> flags) __weak __ksym;
>  extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
> __weak __ksym;
>  extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 5cab0aa8fb27..d50dc332f545 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -29,6 +29,7 @@
>  #define ADDR6_4	"dead:beef:4::1"
>  #define PORT_1	10001
>  #define PM_CTL		"./mptcp_pm_nl_ctl"
> +#define PM_EVENTS	"/tmp/bpf_userspace_pm_events"
>  #define WITH_DATA	true
>  #define WITHOUT_DATA	false
>  
> @@ -57,6 +58,14 @@
>  #endif
>  #define MPTCP_SCHED_NAME_MAX	16
>  
> +enum mptcp_pm_type {
> +	MPTCP_PM_TYPE_KERNEL = 0,
> +	MPTCP_PM_TYPE_USERSPACE,
> +
> +	__MPTCP_PM_TYPE_NR,
> +	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
> +};
> +
>  static const unsigned int total_bytes = 10 * 1024 * 1024;
>  static int duration;
>  
> @@ -252,6 +261,19 @@ static void send_byte(int fd)
>  	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
>  }
>  
> +static int recv_byte(int fd)
> +{
> +	char buf[1];
> +	ssize_t n;
> +
> +	n = recv(fd, buf, sizeof(buf), 0);
> +	if (CHECK(n <= 0, "recv_byte", "recv")) {
> +		log_err("failed/partial recv");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  static int verify_mptcpify(int server_fd, int client_fd)
>  {
>  	struct __mptcp_info info;
> @@ -567,6 +589,196 @@ static void test_iters_subflow(void)
>  	close(cgroup_fd);
>  }
>  
> +static int userspace_pm_init(enum mptcp_pm_type pm_type)
> +{
> +	if (address_init())
> +		goto fail;
> +
> +	SYS(fail, "ip netns exec %s sysctl -qw
> net.mptcp.pm_type=%u",
> +	    NS_TEST, pm_type);
> +	SYS(fail, "ip netns exec %s %s limits 4 4",
> +	    NS_TEST, PM_CTL);
> +	SYS(fail, "ip netns exec %s %s events >> %s 2>&1 &",
> +	    NS_TEST, PM_CTL, PM_EVENTS);
> +
> +	return 0;
> +fail:
> +	return -1;
> +}
> +
> +static void userspace_pm_cleanup(void)
> +{
> +	SYS_NOFAIL("ip netns exec %s killall %s > /dev/null 2>&1",
> +		   NS_TEST, PM_CTL);
> +	SYS_NOFAIL("ip netns exec %s rm -rf %s", NS_TEST,
> PM_EVENTS);
> +}
> +
> +static int userspace_pm_get_events_line(char *type, char *line)
> +{
> +	char buf[BUFSIZ], *str;
> +	size_t len;
> +	int fd;
> +
> +	fd = open(PM_EVENTS, O_RDONLY);
> +	if (fd < 0) {
> +		log_err("failed to open pm events\n");
> +		return -1;
> +	}
> +
> +	len = read(fd, buf, sizeof(buf));
> +	close(fd);
> +	if (len <= 0) {
> +		log_err("failed to read pm events\n");
> +		return -1;
> +	}
> +
> +	str = strstr(buf, type);
> +	if (!str) {
> +		log_err("failed to get type %s pm event\n", type);
> +		return -1;
> +	}
> +
> +	strcpy(line, str);
> +	return 0;
> +}
> +
> +static int userspace_pm_get_token(int fd)
> +{
> +	char line[1024], *str;
> +	__u32 token;
> +	int i;
> +
> +	/* Wait max 2 sec for the connection to be established */
> +	for (i = 0; i < 10; i++) {
> +		usleep(200000); /* 0.2s */
> +		send_byte(fd);
> +
> +		sync();
> +		if (userspace_pm_get_events_line("type:2", line))
> +			continue;
> +		str = strstr(line, "token");
> +		if (!str)
> +			continue;
> +		if (sscanf(str, "token:%u,", &token) != 1)
> +			continue;
> +		return token;
> +	}
> +
> +	return 0;
> +}
> +
> +static int userspace_pm_add_subflow(__u32 token, char *addr, __u8
> id)
> +{
> +	bool ipv6 = strstr(addr, ":");
> +	char line[1024], *str;
> +	__u32 sport, dport;
> +
> +	if (userspace_pm_get_events_line("type:2", line))
> +		return -1;
> +
> +	str = strstr(line, "sport");
> +	if (!str || sscanf(str, "sport:%u,dport:%u,", &sport,
> &dport) != 2) {
> +		log_err("add_subflow error, str=%s\n", str);
> +		return -1;
> +	}
> +
> +	str = ipv6 ? (strstr(addr, ".") ? "::ffff:"ADDR_1 : ADDR6_1)
> : ADDR_1;
> +	SYS_NOFAIL("ip netns exec %s %s csf lip %s lid %u rip %s
> rport %u token %u",
> +		   NS_TEST, PM_CTL, addr, id, str, dport, token);
> +
> +	return 0;
> +}
> +
> +static void run_iters_address(void)
> +{
> +	int server_fd, client_fd, accept_fd;
> +	int is_mptcp, err;
> +	socklen_t len;
> +	__u32 token;
> +
> +	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> +	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
> +		return;
> +
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
> +		goto close_server;
> +
> +	accept_fd = accept(server_fd, NULL, NULL);
> +	if (!ASSERT_OK_FD(accept_fd, "accept"))
> +		goto close_client;
> +
> +	token = userspace_pm_get_token(client_fd);
> +	if (!token)
> +		goto close_client;
> +	recv_byte(accept_fd);
> +	usleep(200000); /* 0.2s */
> +
> +	err = userspace_pm_add_subflow(token, ADDR_2, 10);
> +	err = err ?: userspace_pm_add_subflow(token, ADDR_3, 20);
> +	err = err ?: userspace_pm_add_subflow(token, ADDR_4, 30);
> +	if (!ASSERT_OK(err, "userspace_pm_add_subflow"))
> +		goto close_accept;
> +
> +	send_byte(accept_fd);
> +	recv_byte(client_fd);
> +
> +	len = sizeof(is_mptcp);
> +	/* mainly to trigger the BPF program */
> +	err = getsockopt(client_fd, SOL_TCP, TCP_IS_MPTCP,
> &is_mptcp, &len);
> +	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_IS_MPTCP)"))
> +		ASSERT_EQ(is_mptcp, 1, "is_mptcp");
> +
> +close_accept:
> +	close(accept_fd);
> +close_client:
> +	close(client_fd);
> +close_server:
> +	close(server_fd);
> +}
> +
> +static void test_iters_address(void)
> +{
> +	struct mptcp_bpf_iters *skel;
> +	struct netns_obj *netns;
> +	int cgroup_fd;
> +	int err;
> +
> +	cgroup_fd = test__join_cgroup("/iters_address");
> +	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: iters_address"))
> +		return;
> +
> +	skel = mptcp_bpf_iters__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load: iters_address"))
> +		goto close_cgroup;
> +
> +	skel->links.iters_address = bpf_program__attach_cgroup(skel-
> >progs.iters_address,
> +							      
> cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.iters_address, "attach
> getsockopt"))
> +		goto skel_destroy;
> +
> +	netns = netns_new(NS_TEST, true);
> +	if (!ASSERT_OK_PTR(netns, "netns_new"))
> +		goto skel_destroy;
> +
> +	err = userspace_pm_init(MPTCP_PM_TYPE_USERSPACE);
> +	if (!ASSERT_OK(err, "userspace_pm_init: iters_address"))
> +		goto close_netns;
> +
> +	run_iters_address();
> +
> +	/* 10 + 20 + 30 = 60 */
> +	ASSERT_EQ(skel->bss->ids, 60, "address ids");
> +
> +	userspace_pm_cleanup();
> +close_netns:
> +	netns_free(netns);
> +skel_destroy:
> +	mptcp_bpf_iters__destroy(skel);
> +close_cgroup:
> +	close(cgroup_fd);
> +}
> +
>  static struct netns_obj *sched_init(char *flags, char *sched)
>  {
>  	struct netns_obj *netns;
> @@ -750,6 +962,8 @@ void test_mptcp(void)
>  		test_subflow();
>  	if (test__start_subtest("iters_subflow"))
>  		test_iters_subflow();
> +	if (test__start_subtest("iters_address"))
> +		test_iters_address();
>  	if (test__start_subtest("default"))
>  		test_default();
>  	if (test__start_subtest("first"))
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> index b1f6e1fb467e..5e29ac93d823 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -51,6 +51,11 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
> __ksym;
>  extern struct sock *
>  bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context
> *subflow) __ksym;
>  
> +extern void bpf_spin_lock_bh(spinlock_t *lock) __ksym;
> +extern void bpf_spin_unlock_bh(spinlock_t *lock) __ksym;
> +
> +extern bool bpf_ipv4_is_private_10(__be32 addr) __ksym;
> +
>  extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context
> *subflow,
>  					bool scheduled) __ksym;
>  
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> index fd5691a4073b..e11339641e8d 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
> @@ -61,3 +61,41 @@ int iters_subflow(struct bpf_sockopt *ctx)
>  	bpf_mptcp_sock_release(msk);
>  	return 1;
>  }
> +
> +SEC("cgroup/getsockopt")
> +int iters_address(struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +	struct bpf_sock *sk = ctx->sk;
> +	struct mptcp_sock *msk;
> +	int local_ids = 0;
> +
> +	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
> +		return 1;
> +
> +	msk = bpf_skc_to_mptcp_sock(sk);
> +	if (!msk || msk->pm.server_side)
> +		return 1;
> +
> +	msk = bpf_mptcp_sock_acquire(msk);
> +	if (!msk)
> +		return 1;
> +	bpf_spin_lock_bh(&msk->pm.lock);
> +	bpf_for_each(mptcp_userspace_pm_addr, entry, msk) {
> +		/* Here MPTCP-specific path manager kfunc can be
> called:
> +		 * this test is not doing anything really useful,
> only to
> +		 * verify the iteration works.
> +		 */
> +
> +		if (!bpf_ipv4_is_private_10(entry-
> >addr.addr.s_addr))
> +			break;
> +
> +		local_ids += entry->addr.id;
> +	}
> +	bpf_spin_unlock_bh(&msk->pm.lock);
> +	bpf_mptcp_sock_release(msk);
> +
> +	ids = local_ids;
> +
> +	return 1;
> +}

