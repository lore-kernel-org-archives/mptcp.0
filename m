Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083874C84
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655503982; x=1687039982;
  h=date:from:to:subject:in-reply-to:message-id:references:
   mime-version;
  bh=9scInmh934c4JXyF5XBwecwI0o9Pmp2aQIQhLGC7+WE=;
  b=WGrRSxvOdWVewKuXhp/2iX/+TVQQfl0Wg8YB5ybH0+OXM2h7zFhYMequ
   dBOdTGOnOzp1hb5GgfMhNzEwNex0/jAB+8IDpH5t+47F9v4yfLzdfoDYm
   DzUP8O9i2ABuZaoTb7VWjGcWQQMMx3jM7k2DjAzs0qvTE7vES2idAL5Rs
   0Ychkb3julpnN8biilw1eIuH2bgxmKXZlmbsTni1pvdEIoYHnYeJ69wTe
   VB6CBDb3SGPHOS1sBCmr9A/1HtBtSwVNMDfZhMcvoKkQMfCM6LiXIT/sm
   vdLTZ9t2LjK0Qe/MsiW44MQQf5q2AMKd2e73kiOMWK1NBkxUWgN9FYbwu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341279872"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341279872"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:13:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675652730"
Received: from theiders-mobl.amr.corp.intel.com ([10.209.81.3])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:13:01 -0700
Date: Fri, 17 Jun 2022 15:13:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: several messages
In-Reply-To: <1d640fd1-9779-91a4-e86f-9fc7acee1709@gmail.com>
Message-ID: <45371c28-11c0-297d-b6ba-ba278f24ec56@linux.intel.com>
References: <d1745c1e08937164e34f0010369e8be5f4c2afb0.1655387728.git.pabeni@redhat.com> <1d640fd1-9779-91a4-e86f-9fc7acee1709@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-372314676-1655503981=:44421"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-372314676-1655503981=:44421
Content-Type: text/plain; format=flowed; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Jun 2022, Paolo Abeni wrote:

> The mentioned test measures the transfer run-time to verify
> that the user-space program is able to use the full aggregate B/W.
>
> Even on (virtual) link-speed-bound tests, debug kernel can slow
> down the transfer enough to cause sporadic test failures.
>
> Instead of unconditionally raising the maximum allowed run-time,
> tweak when the running kernel is a debug one, and use some simple/
> rough heuristic to guess such scenarios.
>
> Note: this intentionally avoids looking for /boot/config-<version> as
> the latter file is not always available in our reference CI
> environments.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Looks good, runs fine in my vm with debug kernel config:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> tools/testing/selftests/net/mptcp/simult_flows.sh | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index f441ff7904fc..141fcf0d40d1 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -12,6 +12,7 @@ timeout_test=$((timeout_poll * 2 + 1))
> test_cnt=1
> ret=0
> bail=0
> +slack=50
>
> usage() {
> 	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
> @@ -52,6 +53,7 @@ setup()
> 	cout=$(mktemp)
> 	capout=$(mktemp)
> 	size=$((2 * 2048 * 4096))
> +
> 	dd if=/dev/zero of=$small bs=4096 count=20 >/dev/null 2>&1
> 	dd if=/dev/zero of=$large bs=4096 count=$((size / 4096)) >/dev/null 2>&1
>
> @@ -104,6 +106,13 @@ setup()
> 	ip -net "$ns3" route add default via dead:beef:3::2
>
> 	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
> +
> +	# debug build can slow down measurably the test program
> +	# we use quite tight time limit on the run-time, to ensure
> +	# maximum B/W usage.
> +	# Use the kmemleak file presence as a rough estimate for this being
> +	# a debug kernel and increase the maximum run-time accordingly
> +	[ -f /sys/kernel/debug/kmemleak ] && slack=$((slack+200))
> }
>
> # $1: ns, $2: port
> @@ -241,7 +250,7 @@ run_test()
>
> 	# mptcp_connect will do some sleeps to allow the mp_join handshake
> 	# completion (see mptcp_connect): 200ms on each side, add some slack
> -	time=$((time + 450))
> +	time=$((time + 400 + $slack))
>
> 	printf "%-60s" "$msg"
> 	do_transfer $small $large $time
> -- 
> 2.35.3
>
>
>

On Thu, 16 Jun 2022, MPTCP CI wrote:

> Hi Paolo,
>
> Thank you for your modifications, that's great!
>
> Our CI did some validations and here is its report:
>
> - KVM Validation: normal:
>  - Success! ✅:
>  - Task: https://cirrus-ci.com/task/5708948505362432
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5708948505362432/summary/summary.txt
>
> - KVM Validation: debug:
>  - Unstable: 3 failed test(s): packetdrill_add_addr selftest_diag selftest_mptcp_join 🔴:
>  - Task: https://cirrus-ci.com/task/5145998551941120
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5145998551941120/summary/summary.txt
>
> Initiator: Patchew Applier
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/727243b29682
>
>
> If there are some issues, you can reproduce them using the same environment as
> the one used by the CI thanks to a docker image, e.g.:
>
>    $ cd [kernel source code]
>    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>        auto-debug
>
> For more details:
>
>    https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
>
>
> Please note that despite all the efforts that have been already done to have a
> stable tests suite when executed on a public CI like here, it is possible some
> reported issues are not due to your modifications. Still, do not hesitate to
> help us improve that ;-)
>
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (Tessares)
>
>

--
Mat Martineau
Intel
--0-372314676-1655503981=:44421--
