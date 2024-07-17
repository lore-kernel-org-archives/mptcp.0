Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3B4C8C
	for <mptcp@lists.linux.dev>; Wed, 17 Jul 2024 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721179532; cv=none; b=WwReZHq8DDI/LDckvzF8RSCXoZCtxnraMQOh3MTHfczjyZK8HWTEgsOomH/k5I6vv8cdr95Khys9ZjioBZ+1Gv/CCc61YeX19/T/xeWCN4WoC/cE9sRn+ODx1H8+8bNgKZhfL3carbHXSqxUpCAdcP4bS3IGCHkLzxA/j1qHOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721179532; c=relaxed/simple;
	bh=9CzCHfEfZzdqLxNrDUAXejhqV69pYZjepsZM60hXdS0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DW5xrTMViBicB2rZkngifEhXsU8XB3B1HU9wwuACJL7MmupEHjxWbZCJxbDsSzVZc/yLtf0gTZOC46DIlCKr4/2vFD684gxP58qQsJtH+CC2Q6pL+4lN84tV00r5qgrB61L4qFBgl8vjzv4bY4oiIyTCzWWpXRlJ0Z9c8XKjBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3HnCw6D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3HnCw6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A0FC116B1;
	Wed, 17 Jul 2024 01:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721179532;
	bh=9CzCHfEfZzdqLxNrDUAXejhqV69pYZjepsZM60hXdS0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=C3HnCw6DW6h2YngUkOFOLFvZDaK1PeCFQWT09aakdzyAVoDKjeeU7m+uF0RqgWV9C
	 mxEQLI4eJBFEvLgy6VQB3rnRXacmG9gjU1tCboX2TCde68kvuav35hDi2SpXFdgrPU
	 +Loj+8eo9aTk1Z5Ph1SRVGITfbcAd/w0txs1URRBjCs4hTEAFyT0rpDZS6KDwK7OP9
	 eQ2x+Hc+/liX5vwlufUI0SS4v/fyBePj/LJaXDhdvyaXzzeOlU5LIqwVkfy9ZLtJV0
	 pWj+Oj6/pSAdW3cKV7fQgkPk3v/zwiHagyr9tPVpqIl+T8JDJFlr2drJ1IuLxyZ1YC
	 E3BV09I6xe5nA==
Message-ID: <108fbeaf69fdbc390287704b7a4f4af94890d244.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 5/9] selftests: mptcp: join: validate
 backup in MPJ
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 17 Jul 2024 09:25:25 +0800
In-Reply-To: <20240716-mptcp-backup-mpj-v2-5-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
	 <20240716-mptcp-backup-mpj-v2-5-4d50247405fb@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for these patches.

On Tue, 2024-07-16 at 22:53 +0200, Matthieu Baerts (NGI0) wrote:
> A peer can notify the other one that a subflow has to be treated as
> "backup" by two different ways: either by sending a dedicated MP_PRIO
> notification, or by setting the backup flag in the MP_JOIN handshake.
> 
> The selftests were previously monitoring the former, but not the
> latter.
> This is what is now done here by looking at these new MIB counters
> when
> validating the 'backup' cases:
> 
>   MPTcpExtMPJoinSynBackupRx
>   MPTcpExtMPJoinSynAckBackupRx
> 
> The 'Fixes' tag here below is the same as the one from the previous
> commit: this patch here is not fixing anything wrong in the
> selftests,
> but it will help to validate a new fix for an issue introduced by
> this
> commit ID.
> 
> Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 42
> +++++++++++++++++++------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 55d84a1bde15..175127a9c00c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1634,6 +1634,8 @@ chk_prio_nr()
>  {
>  	local mp_prio_nr_tx=$1
>  	local mp_prio_nr_rx=$2
> +	local mpj_syn=$3
> +	local mpj_syn_ack=$4

How about setting default values for them:

        local mpj_syn=${3:-0}
        local mpj_syn_ack=${4:-0}

>  	local count
>  
>  	print_check "ptx"
> @@ -1655,6 +1657,26 @@ chk_prio_nr()
>  	else
>  		print_ok
>  	fi
> +
> +	print_check "syn backup"
> +	count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtMPJoinSynBackupRx")
> +	if [ -z "$count" ]; then
> +		print_skip
> +	elif [ "$count" != "$mpj_syn" ]; then
> +		fail_test "got $count MPJ SYN[s] with Backup
> expected $mpj_syn"

And make this log more like the one in chk_join_nr:

	fail_test "got $count JOIN[s] syn with Backup expected
$mpj_syn"

> +	else
> +		print_ok
> +	fi
> +
> +	print_check "synack backup"
> +	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynAckBackupRx")
> +	if [ -z "$count" ]; then
> +		print_skip
> +	elif [ "$count" != "$mpj_syn_ack" ]; then
> +		fail_test "got $count MPJ SYNACK[s] with Backup
> expected $mpj_syn_ack"

The same here.

> +	else
> +		print_ok
> +	fi
>  }
>  
>  chk_subflow_nr()
> @@ -2612,7 +2634,7 @@ backup_tests()
>  		sflags=nobackup speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 1 1 1
> -		chk_prio_nr 0 1
> +		chk_prio_nr 0 1 1 0

The last value is the default one, only "chk_prio_nr 0 1 1" is enough.

>  	fi
>  
>  	# single address, backup
> @@ -2625,7 +2647,7 @@ backup_tests()
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
> -		chk_prio_nr 1 1
> +		chk_prio_nr 1 1 0 0

With default values, no need to change this then.


WDYT?

Thanks,
-Geliang

>  	fi
>  
>  	# single address with port, backup
> @@ -2638,7 +2660,7 @@ backup_tests()
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
> -		chk_prio_nr 1 1
> +		chk_prio_nr 1 1 0 0
>  	fi
>  
>  	if reset "mpc backup" &&
> @@ -2647,7 +2669,7 @@ backup_tests()
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 0 0 0
> -		chk_prio_nr 0 1
> +		chk_prio_nr 0 1 0 0
>  	fi
>  
>  	if reset "mpc backup both sides" &&
> @@ -2657,7 +2679,7 @@ backup_tests()
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 0 0 0
> -		chk_prio_nr 1 1
> +		chk_prio_nr 1 1 0 0
>  	fi
>  
>  	if reset "mpc switch to backup" &&
> @@ -2666,7 +2688,7 @@ backup_tests()
>  		sflags=backup speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 0 0 0
> -		chk_prio_nr 0 1
> +		chk_prio_nr 0 1 0 0
>  	fi
>  
>  	if reset "mpc switch to backup both sides" &&
> @@ -2676,7 +2698,7 @@ backup_tests()
>  		sflags=backup speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 0 0 0
> -		chk_prio_nr 1 1
> +		chk_prio_nr 1 1 0 0
>  	fi
>  }
>  
> @@ -3053,7 +3075,7 @@ fullmesh_tests()
>  		addr_nr_ns2=1 sflags=backup,fullmesh speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 2 2 2
> -		chk_prio_nr 0 1
> +		chk_prio_nr 0 1 1 0
>  		chk_rm_nr 0 1
>  	fi
>  
> @@ -3066,7 +3088,7 @@ fullmesh_tests()
>  		sflags=nobackup,nofullmesh speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 2 2 2
> -		chk_prio_nr 0 1
> +		chk_prio_nr 0 1 1 0
>  		chk_rm_nr 0 1
>  	fi
>  }
> @@ -3318,7 +3340,7 @@ userspace_tests()
>  		sflags=backup speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 1 1 0
> -		chk_prio_nr 0 0
> +		chk_prio_nr 0 0 0 0
>  	fi
>  
>  	# userspace pm type prevents rm_addr
> 

