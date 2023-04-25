Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17E7B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 00:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC6FC433EF;
	Tue, 25 Apr 2023 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682381601;
	bh=+oo3+eIs3Z9lLw4dI789l/xQxP9SvYTTof6z8ICSR6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=steQ19h1GFrwxkHc4i85TyqY0ThlhjHkk9EK7dS0vMi0W1k3Fro6BdXGeZK23csiI
	 dqxesdWMBc+xH7zUFFbimlN5sIWmNMYnER5UCulvqQZda8InF//a6ffjrM4pwt7TTf
	 8WaYyStO7rFyvEydlUeUEa7/iZuw4e+XPJlACS4Xvpj7Xqve/0hnGGVJxUruKf1rTT
	 SZdeiwkfrFtqP4/W9HHYWTwWD7l7SD8gOha06yLGm75nqBtWqJKIQ0JsbLHXgSaV5k
	 3qAIVdo0E+LMcsuyV7ofbCm+mDgxArLJaxc/x7thQXIrWfNC+I6QIU4iEfDiC5bQ78
	 Eir3YXLpBMmgg==
Date: Mon, 24 Apr 2023 17:13:20 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 11/13] selftests: mptcp: userspace pm: skip if
 not supported
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-11-246ac567724d@tessares.net>
Message-ID: <d7e35e19-6a22-4052-19d4-27b6e9e8ddb2@kernel.org>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net> <20230406-mptcp-issue-368-selftests-old-kernels-v1-11-246ac567724d@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 7 Apr 2023, Matthieu Baerts wrote:

> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
>
> One of them is the new MPTCP Userspace PM. We can skip these tests if
> the feature is not supported.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh   | 6 ++++++
> tools/testing/selftests/net/mptcp/userspace_pm.sh | 6 ++++++
> 2 files changed, 12 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 315ea136fe2c..4bc181485fef 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -135,6 +135,7 @@ cleanup_partial()
> check_tools()
> {
> 	mptcp_lib_check_mptcp
> +	mptcp_lib_check_kallsyms
>
> 	if ! ip -Version &> /dev/null; then
> 		echo "SKIP: Could not run test without ip tool"
> @@ -3045,6 +3046,11 @@ fail_tests()
>
> userspace_tests()
> {
> +	if ! mptcp_lib_kallsyms_has 'mptcp_userspace_pm_'; then
> +		echo "userspace pm tests are not supported by the kernel: SKIP"
> +		return
> +	fi

In this case, it seems simpler to see if /proc/sys/net/mptcp/pm_type 
exists.

I didn't find as simple of an answer for MPTCP TFO and pm listener events, 
but maybe there's some other hint from the kernel about this 
functionality. The kallsyms approach seems a bit "brute force", if we can 
find similar lightweight checks for these other features.

If I missed a discussion on this topic please let me know and I will 
do a better search of the list archives :)


- Mat

> +
> 	# userspace pm type prevents add_addr
> 	if reset "userspace pm type prevents add_addr"; then
> 		set_userspace_pm $ns1
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 192ab818f292..12556051a72a 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -4,6 +4,12 @@
> . "$(dirname "${0}")/mptcp_lib.sh"
>
> mptcp_lib_check_mptcp
> +mptcp_lib_check_kallsyms
> +
> +if ! mptcp_lib_kallsyms_has 'mptcp_userspace_pm_'; then
> +	echo "userspace pm tests are not supported by the kernel: SKIP"
> +	exit ${KSFT_SKIP}
> +fi
>
> ip -Version > /dev/null 2>&1
> if [ $? -ne 0 ];then
>
> -- 
> 2.39.2
>
>
>
