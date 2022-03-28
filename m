Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4517E7
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648507743; x=1680043743;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=33/pwne8BHBGb1h0DXqJD/TUGTgKOtorOVcA0YDYJeE=;
  b=Cr2xf3VCk8SuC/S/q+JnKjqUQBGACyBgP0Gx83+QFQi4zVihsdbMhAEz
   gzOe/H3sajsEgID91nPyt3YXmfWUcdCzZXRFYBRqp6sQnJmFHoQC1nuSy
   t7e1IGycmCWXr/zqbnlkWV63alfER9+ufrWFkdkWZsQ4U7aD4HyVN0AyL
   ynR6WMqCRwKQ2FhEjqQBKzFZlYktJtBZTFjNA7CaFXTP4WOtGio4SLr8B
   vt2m1U4aNgbsibJ2Bk59wZoyRe6cTNljJnx1IUEO1keid27yeG6BwzPA2
   e5RoiBqvQqDVhHl0ZcisefbenDkeLsmL9sNRjAvbMRgWG8/tm9GoTJm3S
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="258831954"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="258831954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:49:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="564073499"
Received: from pchung1-mobl.amr.corp.intel.com ([10.209.44.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:49:03 -0700
Date: Mon, 28 Mar 2022 15:49:02 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 8/8] selftests: bpf: add mptcp_bpf_first
 test
In-Reply-To: <50798e945994585b9c9c5443ce991ceb3dbc662f.1648459866.git.geliang.tang@suse.com>
Message-ID: <7efd5bfc-26fd-7485-ea99-17211a95d717@linux.intel.com>
References: <cover.1648459865.git.geliang.tang@suse.com> <50798e945994585b9c9c5443ce991ceb3dbc662f.1648459866.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 28 Mar 2022, Geliang Tang wrote:

> This patch expends the MPTCP test base to support MPTCP packet
> scheduler tests. Add the mptcp_bpf_first scheduler test in it.
> Use sysctl to set net.mptcp.scheduler to use this sched.
>
> Some code in send_data() is from bpf_tcp_ca.c.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
> 1 file changed, 114 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 9b73ef62ee74..e5b6f2f4a52d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -4,6 +4,9 @@
> #include <test_progs.h>
> #include "cgroup_helpers.h"
> #include "network_helpers.h"
> +#include "bpf_first.skel.h"

This didn't build for me - above needs to be changed to

#include "mptcp_bpf_first.skel.h"

to account for the .c file rename. But after that change, I was able to 
build and run the mptcp bpf test.

- Mat

> +
> +#define min(a, b) ((a) < (b) ? (a) : (b))
>
> #ifndef TCP_CA_NAME_MAX
> #define TCP_CA_NAME_MAX	16
> @@ -19,6 +22,8 @@ struct mptcp_storage {
> };
>
> static char monitor_log_path[64];
> +static const unsigned int total_bytes = 10 * 1024 * 1024;
> +static int stop, duration;
>
> static int verify_tsk(int map_fd, int client_fd)
> {
> @@ -251,8 +256,117 @@ void test_base(void)
> 	close(cgroup_fd);
> }
>
> +static void *server(void *arg)
> +{
> +	int lfd = (int)(long)arg, err = 0, fd;
> +	ssize_t nr_sent = 0, bytes = 0;
> +	char batch[1500];
> +
> +	fd = accept(lfd, NULL, NULL);
> +	while (fd == -1) {
> +		if (errno == EINTR)
> +			continue;
> +		err = -errno;
> +		goto done;
> +	}
> +
> +	if (settimeo(fd, 0)) {
> +		err = -errno;
> +		goto done;
> +	}
> +
> +	while (bytes < total_bytes && !READ_ONCE(stop)) {
> +		nr_sent = send(fd, &batch,
> +			       min(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_sent == -1 && errno == EINTR)
> +			continue;
> +		if (nr_sent == -1) {
> +			err = -errno;
> +			break;
> +		}
> +		bytes += nr_sent;
> +	}
> +
> +	CHECK(bytes != total_bytes, "send", "%zd != %u nr_sent:%zd errno:%d\n",
> +	      bytes, total_bytes, nr_sent, errno);
> +
> +done:
> +	if (fd >= 0)
> +		close(fd);
> +	if (err) {
> +		WRITE_ONCE(stop, 1);
> +		return ERR_PTR(err);
> +	}
> +	return NULL;
> +}
> +
> +static void send_data(int lfd, int fd)
> +{
> +	ssize_t nr_recv = 0, bytes = 0;
> +	pthread_t srv_thread;
> +	void *thread_ret;
> +	char batch[1500];
> +	int err;
> +
> +	WRITE_ONCE(stop, 0);
> +
> +	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
> +	if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
> +		return;
> +
> +	/* recv total_bytes */
> +	while (bytes < total_bytes && !READ_ONCE(stop)) {
> +		nr_recv = recv(fd, &batch,
> +			       min(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_recv == -1 && errno == EINTR)
> +			continue;
> +		if (nr_recv == -1)
> +			break;
> +		bytes += nr_recv;
> +	}
> +
> +	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
> +	      bytes, total_bytes, nr_recv, errno);
> +
> +	WRITE_ONCE(stop, 1);
> +
> +	pthread_join(srv_thread, &thread_ret);
> +	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
> +	      PTR_ERR(thread_ret));
> +}
> +
> +static void test_first(void)
> +{
> +	struct bpf_first *first_skel;
> +	int server_fd, client_fd;
> +	struct bpf_link *link;
> +
> +	first_skel = bpf_first__open_and_load();
> +	if (CHECK(!first_skel, "bpf_first__open_and_load", "failed\n"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(first_skel->maps.first);
> +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +		bpf_first__destroy(first_skel);
> +		return;
> +	}
> +
> +	system("sysctl -q net.mptcp.scheduler=mptcp_bpf_first");
> +	server_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
> +	client_fd = connect_to_mptcp_fd(server_fd, 0);
> +
> +	send_data(server_fd, client_fd);
> +
> +	close(client_fd);
> +	close(server_fd);
> +	bpf_link__destroy(link);
> +	bpf_first__destroy(first_skel);
> +}
> +
> void test_mptcp(void)
> {
> 	if (test__start_subtest("base"))
> 		test_base();
> +	if (test__start_subtest("first"))
> +		test_first();
> }
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
