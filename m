Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBD3483
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 11:50:07 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1m94Y4-0005Zx-Ac
	for mptcp@lists.linux.dev; Thu, 29 Jul 2021 13:50:00 +0200
Date: Thu, 29 Jul 2021 13:50:00 +0200
From: Florian Westphal <fw@strlen.de>
To: mptcp@lists.linux.dev
Subject: Revised mptcp_info sockopt and selftests
Message-ID: <YQKV6GJe/RfkZh09@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have reworked the MPTCP_INFO getsockopt.

I think that for now its better to focus on the UAPI rather than the
implementation.

Here is a minimal usage example to illustrate the feature:

UAPI structures:
struct mptcp_info_opt_ptr {
	__aligned_u64	address;			/* userspace address */
	__u32		nmemb_user;			/* number of elements in address[] */
	__u32		size_user;			/* size of one element in address[] */
	__u32		nmemb_kernel;			/* nmemb count kernel wanted to store */
	__u32		size_kernel;			/* structure size in kernel */
};

struct mptcp_info_opt {
	struct mptcp_info_opt_ptr mptcp_info;		/* struct mptcp_info */
	struct mptcp_info_opt_ptr tcp_info;		/* struct tcp_info[] of each subflow */
	struct mptcp_info_opt_ptr socknames;		/* struct sockaddr_storage[] */
	struct mptcp_info_opt_ptr peernames;		/* struct sockaddr_storage[] */
};

/* Sample call, error checks removed */
void test_info_getsockopt(int fd)
{
	struct sockaddr_storage remotes[16], locals[16];
	struct mptcp_info mptcp_info;
	struct tcp_info tcpinfo[16];
	struct mptcp_info_opt m;
	socklen_t optlen = sizeof(m);
	uint32_t i;
	int err;

	memset(&m, 0, sizeof(m));
	m.mptcp_info.size_user = sizeof(mptcp_info);
	m.mptcp_info.address = (uint64_t)&mptcp_info;

	m.tcp_info.address = (uint64_t)tcpinfo;
	m.tcp_info.size_user = sizeof(tcpinfo[0]);
	m.tcp_info.nmemb_user = 16;

	m.socknames.size_user = sizeof(locals[0]);
	m.socknames.nmemb_user = 16;
	m.peernames.size_user = sizeof(remotes[0]);
	m.peernames.nmemb_user = 16;
	m.socknames.address = (uint64_t)locals;
	m.peernames.address = (uint64_t)remotes;

	err = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &m, &optlen);

	printf("have %u subflows, token is %x\n", mptcp_info.mptcpi_subflows, mptcp_info.mptcpi_token);

	for (i = 0; i < m.socknames.nmemb_user; i++) {
		printf("subflow %02d: ", i);
		fprintf_mptcp_info(stdout, (void *)&locals[i], (void *)&remotes[i]);
		printf("\n");
	}

	printf("... dumped %u of %u addresses.\n",
			m.socknames.nmemb_user, m.socknames.nmemb_kernel);

	for (i = 0; i < m.tcp_info.nmemb_user; i++)
		dump_tcp_info(&tcpinfo[i]);
}

As you can see, I removed 'byte' based sizes, i found this to be
unecessarily tedious as the kernel then has to subtract from a
'remaining buffer size', while making sure that this can't underflow.

With number-of-elements, its enough to 'remaining--' and "ptr += size_user".

Userspace passes the address of the structure(s), the size of a single
structure that it expects to get and the number of structures it has
allocated (16 in above example).

The kernel will:
1. not change, or shrink the number of structures.
   This means that, in above example, nmemb_user will be anywhere
   between 0 and 16 inclusive.

   0 would happen in the 'no subflows' case, when nothing was filled in.
2. Not change, or shrink, size_user.  This happens for instance
   if userspace has a larger 'struct tcp_info' than the kernel,
   in this case size_user is updated to reflect the real element size.

3. update nmemb_kernel to reflect the structure size it *WOULD* have
   filled. For example, if userspace tcp_info struct is smaller than the
   kernel, then size_user < size_kernel.

4. update size_kernel with the number of elements it WOULD have filled
   if there would have been more space.

So, in above example, if there are 17 subflows then
socknames.nmemb_user == 16 and socknames.nmemb_kernel == 17.

Or, in short:
The _kernel members are only filled by kernel, the value provided by
userspace are ignored.

The _user members are input/output: userspace tells kernel how much
space it provides, kernel updates it to reflect how much it ended up
using.

Is that sane?  Any suggestions?

On a related note, how should the test infra look like?
kunit isn't useable as i would prefer to test the UAPI, so that means
kselftest.

I would prefer not to extend mptcp_connect again.
Would you be ok with a new test program?

Any preferences?  If not, i would go with mptcp_getsockopt.c +
mptcp_getsockopt.sh.

The latter would then call the former with various possible
combinations, such as 'ipv4', 'ipv6', 'only ask for tcp_info', etc.

Cheers,
Florian





