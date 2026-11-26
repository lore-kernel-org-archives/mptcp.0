Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725846;
	b=mQkwQ7CQooU8pXs0aJTkw3Z9PcrU6wOKNGHHKO0HNvahYxOFKaj5xBTFh/igsIBQ0tUc
	 6IBTieVlVPdC8sEhmtpcWGNMwYqV1QXRepO+x0JaxvxgElmK9Kqpau+FyRcdkegjTflxt
	 h26p1Oqm34zHf+P8IpVe9P7AoK53ENjKp0QmgIytCkVUyTbIs6wcECz7nGweLdLLWGeW3
	 a4mSxmgH6Pr0E2fLun3rRmSju6hasN4wSi1DJJ1fYz7orMKcUFSgGW/WCjWAsWwo5JsFj
	 RPVCRik/ETC+uD9Z9KMbmpJA8xDfCVAc/91R7DKI3pL7djQ4m6HJUuZsS9C4Eh2MacQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725846;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1Txji5q0QzYZ8FHxg38Imht8TJqtl9qYCE/ex9NYJFU=;
	b=rNhMYksDTBs90ROnafk5oVM5glQ1ZzRc81lkdjVlWc9tQP6H5zLSs7Juyl5K913B37hC
	 hzOgsh/u16vZ41+VF9rhzS67vD0t/kL3xdCK6aBceK6E1RYekX5cs83zP6zt3fDaNdcqA
	 POSY7iyYxPlC4NgM2nxzY08ZQHg7MaFavhrArimtN8vINXZs6F+l5IDg7hvWKaR3WIQcm
	 8rKAZUtt91Swy3jRjTxYLGYlBdZwPjtS6TpCqnoySyC4aeGYCbFmOmEx8OWdb7iKI3MXM
	 CAcqix/G3Jg6SuL32OX+93kJaZVinT9nv+werteJo0b/GGCLt42vpskS6oKW/hyjGMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBC3dag4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8E606A6AE
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBC3dag4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F051F000C1;
	Thu, 26 Nov 2026 20:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725846;
	bh=1Txji5q0QzYZ8FHxg38Imht8TJqtl9qYCE/ex9NYJFU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UBC3dag4Eha6nCVeQ4LJ407ozq/lgs5SGcdCRbP9QyF5EwD75df6MiLYDzvO1krA3
	 Zx6XDl3mLK903WB7cUwIl3FNZFIRhSSOGzZBBSnO42kcloaoYU17TfFGOXVNOGna23
	 Ti/xlnWoiN6ugLJ/HtlCyhl4IziRlX/reKA2P70Znd8YuI1a1Pbuk20lRbSsl/rvwf
	 epXfyqgNv12zHaoAgSamrJsoW99Sw0r/SbgL++GPwfpMgdmOiNqP0YuX76l9ZKBZxm
	 dulMDBT6ZRK8aaO7J0Bdf2chbEgdZ1LsrTMDPkOYk9xPFdguS1W8rLGFNeBPIWVMLG
	 AjwwSydsInpqA==
Subject:
 Re: [PATCH mptcp-next v9 7/7] selftests: mptcp: cover msg_zerocopy test
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 20:44:05 +0000
Message-ID: <179572584547.3133.6599684131621800072@kernel.org>
In-Reply-To: <3bd50e8f16d828fd027f3c0c8ce0df829401a362.1795591278.git.tanggeliang@kylinos.cn>
References: <3bd50e8f16d828fd027f3c0c8ce0df829401a362.1795591278.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds msg_zerocopy.sh to the MPTCP selftest target
  (tools/testing/selftests/net/mptcp/Makefile, TEST_PROGS, line 17), but…
- [Low] The same test and binary are now registered twice, and the MPTCP-
  target copy cannot be limited to MPTCP cases.
- [Low] The symlinked msg_zerocopy.sh breaks the MPTCP suite's feature-
  detection convention.
- [Low] The custom recipe added for $(OUTPUT)/msg_zerocopy in
  tools/testing/selftests/net/mptcp/Makefile (lines 43-44) is `$(CC) $<…

--

selftests: mptcp: cover msg_zerocopy test

This commit adds the msg_zerocopy test to the MPTCP selftest suite
through a symlink to the existing net/msg_zerocopy.sh script. It also
adds the msg_zerocopy binary to TEST_GEN_FILES, with a custom rule that
builds it from ../msg_zerocopy.c, and updates .gitignore.

> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index 22ba0da2adb85..17d0d1051165c 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -14,6 +14,7 @@ TEST_PROGS := \
>  	mptcp_connect_splice.sh \
>  	mptcp_join.sh \
>  	mptcp_sockopt.sh \
> +	msg_zerocopy.sh \

[Severity: Medium]
The shared script runs under set -e. For every mode, including tcp and
mptcp, it creates a dummy device before it reaches do_test():

tools/testing/selftests/net/msg_zerocopy.sh:
    set -e
    ...
    ip link add "${DUMMY_DEV}" mtu "${DEV_MTU}" netns "${NS2}" type dummy

tools/testing/selftests/net/mptcp/config only has CONFIG_VETH=y, and
CONFIG_DUMMY has no default. Take a kernel built from defconfig plus the
mptcp fragment. There this ip link add fails and set -e aborts each of
the six child runs. The test then reports FAIL without exercising MPTCP
zerocopy.

The net/ target only works because tools/testing/selftests/net/config
has CONFIG_DUMMY=y.

Does net/mptcp/config need CONFIG_DUMMY=m as part of this change?

[Severity: Low]
Is this registration redundant with the existing one in
tools/testing/selftests/net/Makefile?

net/Makefile already lists msg_zerocopy.sh in TEST_PROGS and msg_zerocopy
in TEST_GEN_FILES, and net/config has CONFIG_MPTCP=y. Since the previous
patch in this series ("selftests: net: msg_zerocopy: add MPTCP support"),
the no-argument path already covers mptcp:

tools/testing/selftests/net/msg_zerocopy.sh:
    if [[ "$#" -eq "0" ]]; then
    	ret=0

    	$0 4 tcp -t 1 || ret=1
    	$0 6 tcp -t 1 || ret=1
    	$0 4 udp -t 1 || ret=1
    	$0 6 udp -t 1 || ret=1
    	$0 4 mptcp -t 1 || ret=1
    	$0 6 mptcp -t 1 || ret=1

kselftest runs TEST_PROGS with no arguments, so the mptcp target runs the
full tcp/udp/mptcp matrix. That has two effects:

- A TCP or UDP zerocopy regression shows up as an MPTCP suite failure.
- With TARGETS="net net/mptcp", the script runs twice and the binary is
  built twice.

Would it be better to keep the test in net/ only? Another option is a
small mptcp wrapper that calls the script with just "4 mptcp" and
"6 mptcp".

[ ... ]

> @@ -37,3 +39,6 @@ TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
>  EXTRA_CLEAN := *.pcap
>  
>  include ../../lib.mk
> +
> +$(OUTPUT)/msg_zerocopy: ../msg_zerocopy.c
> +	$(CC) $< $(CFLAGS) $(CPPFLAGS) -o $@

[Severity: Low]
This recipe leaves out $(LDFLAGS), $(TARGET_ARCH) and $(LDLIBS). lib.mk
uses all three for the other binaries in this directory:

tools/testing/selftests/lib.mk:
    LINK.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
    ...
    $(OUTPUT)/%:%.c $(LOCAL_HDRS)
    	$(call msg,CC,,$@)
    	$(Q)$(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@

With make TARGETS=net/mptcp LDFLAGS=-static, mptcp_connect and the other
binaries would be linked statically. Would msg_zerocopy still end up
dynamically linked?

Would $(LINK.c) $^ $(LDLIBS) -o $@, with $(Q) and the msg helper, be a
closer match to lib.mk?

> diff --git a/tools/testing/selftests/net/mptcp/msg_zerocopy.sh b/tools/testing/selftests/net/mptcp/msg_zerocopy.sh
> new file mode 120000
> index 0000000000000..b2f82b8fa5f2b
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/msg_zerocopy.sh
> @@ -0,0 +1 @@
> +../msg_zerocopy.sh
> \ No newline at end of file

[Severity: Low]
Every other script in the mptcp TEST_PROGS sources mptcp_lib.sh and calls
mptcp_lib_check_mptcp(). That helper skips the test when MPTCP is not
available:

tools/testing/selftests/net/mptcp/mptcp_lib.sh:
    mptcp_lib_check_mptcp() {
    	if ! mptcp_lib_has_file "/proc/sys/net/mptcp/enabled"; then
    		mptcp_lib_pr_skip "MPTCP support is not available"
    		exit ${KSFT_SKIP}
    	fi
    }

The symlinked script has no such check. On a kernel without
CONFIG_MPTCP, socket(..., IPPROTO_MPTCP) fails in do_setup_tx() and
do_setup_rx(), and msg_zerocopy calls error(1, errno, "socket t").

Some kernels have MPTCP but not the "mptcp: handle SO_ZEROCOPY in
setsockopt" change. On those, do_setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY,
1) fails and also calls error(1, ...).

The rest of the MPTCP suite reports SKIP for missing features when run
against older or stable kernels. Should these cases report SKIP too,
instead of FAIL?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795591278.git.tanggeliang%40kylinos.cn
