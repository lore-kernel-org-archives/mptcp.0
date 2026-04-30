Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2441C31E
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555254; cv=none; b=AvVZ7l3lkNrFmq5j5cru3iLmyTWGH6hMC7WKXL1JfdWodP/xnUpoyMCNFwe6Lwcr0AN3ciaQjXa1WlzRxTEJYT9t4cloqeqGuVkvbtpM28WYGX3niVbFkpBCQVjpOshFJ4RRuJDq8rzLydMDsYEArN5sbuSVi9zuI37v+saBnQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555254; c=relaxed/simple;
	bh=NR/gFz6sKYq/xwa3h8Awmeo83NTxriGbVIgiIw0Ezrs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Bk9pyEEnFGNpkdCtGsGH/TfGxFeNn9j/8hZjmEmmyyZ8Vu1IsycpO9OQNY5QqBkJ8anun7VMk9GZ+KhWO2vvexq2YAFpBtSxjX2Ti9NUeT4kqq2Uj8Sfx5KVgGlDr3SIpH1c+PlmHLgKQo9at5kwjiodP6qU2ew9hacyB+hakkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0Nv7elH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0Nv7elH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B71C2BCB8;
	Thu, 30 Apr 2026 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777555254;
	bh=NR/gFz6sKYq/xwa3h8Awmeo83NTxriGbVIgiIw0Ezrs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=E0Nv7elHlnSbs9BsRmQrYQNRySDV+dIQXM5UzBgFsDJv6QYG6BlAnpy38aDqwop/I
	 SsiWYT+MWpjN+w2QA4i6bbLH2+pOtKz3Qx8cbLzSrBcyUiaAP0vk4qXY81l66Uoggi
	 fQSg21uF32Az5dNOQXd34RJOaGd1G+8a+VfGgE1XI9HF3F1iO9nE1U2/6eiHzYJHHL
	 2HFQ45WU3dzeHsQUZvuZ+jW8WHGb8iamnlkHe/vyQ3CVA0W0BhuDbLetJKlGgy6mja
	 hONkY4dcZByMu1xmwcv38KsPG1saqHXkJYkaSyDoZiK78baV235gXFOIfbh/Vh5sOF
	 tyo37x5ns5bKQ==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: cover
 ADD_ADDR tx drop and list progress
From: Matthieu Baerts <matttbe@kernel.org>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev, weiyongjun1@huawei.com, yuehaibing@huawei.com, 
 zhangchangzhong@huawei.com, xiasong.lee@gmail.com
In-Reply-To: <20260430112026.343691-3-lixiasong1@huawei.com>
References: <20260430112026.343691-1-lixiasong1@huawei.com>
 <20260430112026.343691-3-lixiasong1@huawei.com>
Date: Thu, 30 Apr 2026 15:20:42 +0200
Message-Id: <177755524217.1566930.4447011567120793753.b4-review@b4>
X-Mailer: b4 0.16-dev-76c3c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2429; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NR/gFz6sKYq/xwa3h8Awmeo83NTxriGbVIgiIw0Ezrs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI/hxtNDv2meLjq6hX7a2/N5qju2n/GfulkVrapabMNg
 qsOmsjqd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkTpyRYSdvLLfgMpUZj85P
 25W66UvjQUsRt18TGbz3h134wD/T25mR4fubZRxdJ97WNTHbnLiRl3ioTonfrPJ2bsfal2zrvAp
 PMAIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On Thu, 30 Apr 2026 19:20:26 +0800, Li Xiasong <lixiasong1@huawei.com> wrote:
> Extend add_addr_ports_tests with IPv6 signaling cases that exercise
> ADD_ADDR tx-space shortage when tcp_timestamps are enabled.
> 
> Add one case to verify ADD_ADDR tx drop accounting via
> MPTcpExtAddAddrTxDrop, and another case to verify PM still progresses
> to later signal endpoints after the first one is dropped.
> 
> This covers both failure accounting and the non-blocking behavior of
> the announce list after a tx-space drop on pure ACK.

Thank you for this new test!

>
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index beec41f6662a..59beddb487e3 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1828,6 +1828,22 @@ chk_add_tx_nr()
>  	fi
>  }
>  
> +chk_add_drop_tx_nr()
> +{
> +	local add_drop_tx_nr=$1
> +	local count
> +
> +	print_check "add addr tx drop"
> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTxDrop")
> +	if [ -z "$count" ]; then
> +		print_skip
> +	elif [ "$count" != "$add_drop_tx_nr" ]; then
> +		fail_test "got $count ADD_ADDR drop[s] TX, expected $add_drop_tx_nr"

Nit, just to avoid a checkpatch warning, maybe rename add_drop_tx_nr?
'expected'?

  -> WARNING: line length of 84 exceeds 80 columns

> @@ -3278,6 +3294,37 @@ add_addr_ports_tests()
> [ ... skip 22 lines ... ]
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
> +
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
> +		pm_nl_add_endpoint $ns1 dead:beef:3::1 flags signal
> +
> +		speed=slow \

Do you need 'speed=slow' here? Having a longer transfer is typically
needed when endpoints are manipulated during the transfer, or when a few
there are >= 3 signal endpoints. I don't think that's needed here. Or
did you experimented any issues? (if yes, makes sure you are on top of
our export/export-net or for-review/for-review-net branches)

> +			run_tests $ns1 $ns2 dead:beef:1::1
> +
> +		chk_add_drop_tx_nr 1
> +		chk_add_tx_nr 1 1
> +		chk_add_nr 1 1 0
> +	fi

It feels like the second test covers the case tested by the previous
one, no? I would only keep the second one, best to avoid redundant
tests, this selftest is already slow enough :)

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
