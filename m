Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F038DE0
	for <mptcp@lists.linux.dev>; Tue, 25 Feb 2025 04:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458932; cv=none; b=CZBpDQZaIYPunTqfIqkzmc3joult04D3bf8fh0jgzX+bvkRgvxTWhqkr75riB1sBIpSBptOM6AnPIXbgGbD/x/VE6cq0Vn0NNnVianJwNWk4VRrh7r4aqHxNFlwJ3UqaAglg3XoGAZ5xWZqYlufJQDupgv8gnlRnl+/KpcZIS5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458932; c=relaxed/simple;
	bh=yXMVYhuSYc/XeTK+g9pqmY7LH6T92IBEtPdR+YuMd0Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uETubFYHpmGvstkL77ETRV+w96bCHbrk/umeDztv5pA8nZNy8yGp28i/J/y7KP1a5NVX4tYOlsXTa78par4T6d6ZMRg1Ya01hzaXwgGEVPwDPnN+POipA3GcjiGng7AN47AB6lzDI75X/r2dYLZRBnIVzpug7IRtDZ3qB9YslKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=t1ctM7I6; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="t1ctM7I6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1740458617;
	bh=leFg0sxHQy1sQdyEOpGkTBwuuoZYtTJXpGT7hRkGuXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=t1ctM7I6Mfu5P7bp2gC2ajfYmeauyfsfVaFB4xfIM7aGpUPje7J+JFOBDqVYpnNh2
	 QFNmIexwEAJbVrkv0Jmh9mUlT4IMsjh11WypgN8q7fM9wRqJ++gwUn/edRUAWcZcC0
	 dwgqxbCbCDvyyI1UE73V5C4WN2H7jFeet4qGRcRw=
Received: from localhost ([223.70.160.239])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id AE335ABF; Tue, 25 Feb 2025 12:43:35 +0800
X-QQ-mid: xmsmtpt1740458615te83ngvrk
Message-ID: <tencent_859D9F20AC0E314A5E590923E9A45EE68F05@qq.com>
X-QQ-XMAILINFO: MGu0d518fybeonzQvCIStovanxemiUBxqc42RdOy4iorxHrwxBREwfFrDK5zkC
	 sKk2p4U4gMZ66+ju7qHoKsExOecnpQzcKMVKXKTeLEi4XK1Gz+pwGmFVPTHUiaAt2j+JP1Ozcztx
	 6VD/E0W1LQTFCTRL8j3RbmBAvpiKRpUJdt9WCXgIsVbwkiQEn3k4W8E8ZpyWdehKgbPy6MX1s+HB
	 D/K0pqbCRvLK4PlkrmBnk89VF6uKluH5jCZ9mlNtsfp88xctVY2CxH/Fz774S01HdIjoZWZnLIGP
	 aYNq3XycozrMmAS4+LwleaPVdXi6g7OVhi2tJjfTr/akD0qBH8lFwbwctpJ+BnotbTiQc20IdLC9
	 GAtaniOc5UQSWT7evT50MKEQfB5W1HirdZcvl64JiPYbCps+hjic35niM+JjKxojBmHmUj+Pp9Pr
	 1FJ1C/GcRPm2plTdI/6q1hCQ2kqXqk5UKvfmzfp78NbZD2mN+9uM7M6//alj4kMgQe4Jb/tTwdNf
	 E3te/A3BaUOkvpYoeXRWUsyW5Y5yby/52fmoHkH5NvAzueIFv6XREfHoMBc0ojy0rTk+ub6FUoGR
	 EJnUZm86QO5vYFx70QCgYN98K3o58r54gg7LlUdNZzvtO5Dypep3oJ4CHl56rUAIJ6ouaEczul4F
	 ftYC+9KVEn98TazBZbwz9Qit5O66TVvTj8Fex5tFqLp5WLTsuEQP9tEyDn2tyRO6wHer5Ra9Xm1/
	 KpPVQKMaFGQShGyFBiadFqZf8tSnJqpOr0YSUog2UJQ4qIzAMf02wz8RczFnLG2E0jgPZwzCSnzG
	 D9rOxgSOM2FZ7oh6BuVl78WAl1DyoHW80KDQTtk6489LkUNP06AvwDyEEG4DcBozFsUcSSlR7qTG
	 qQ1ZkLwtZoxYeUGwh7oAUHfOk9Z8VilunJhrQXC6Vt8cG4q6dQvHhzCVOdqMTrVZhpiYGCVWD5dq
	 NueJtL7V4=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Date: Tue, 25 Feb 2025 12:43:35 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add a test for
 mptcp_diag_dump_one"
X-OQ-MSGID: <20250225044335.GA15721@yangang-pc>
References: <20250224-mptcp-sft-diag-squash-v1-1-81eb3843fa53@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224-mptcp-sft-diag-squash-v1-1-81eb3843fa53@kernel.org>

On Tus, Feb 25, 2025 at 09:51:93AM +0800, Gang Yan wrote:
> On Mon, Feb 24, 2025 at 08:03:05PM +0100, Matthieu Baerts (NGI0) wrote:
> - sdiag_protocol: avoid compilation warning:
> 
>   mptcp_diag.c: In function 'send_query':
>   mptcp_diag.c:77:43: warning: unsigned conversion from 'int' to 'unsigned char' changes value from '262' to '6' [-Woverflow]
>      77 |                         .sdiag_protocol = IPPROTO_MPTCP,
>         |                                           ^~~~~~~~~~~~~
> 
>   => the real protocol is passed via INET_DIAG_REQ_PROTOCOL.
Thank you for making the modification here. I'm sorry I overlooked this
point when submitting the patch.
> 
> - printf: follow the same format as ss: hexa only for the token + flags.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Tested-by: Gang Yan <yangang@kylinos.cn>
> ---
> Cc: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_diag.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> index 7915ef1fc0611654e0aba36c4121bef2e0f26697..284286c524cfeff5f49b0af1a4da5a376c9e3140 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -74,7 +74,8 @@ static void send_query(int fd, __u32 token)
>  		},
>  		.r = {
>  			.sdiag_family = AF_INET,
> -			.sdiag_protocol = IPPROTO_MPTCP,
> +			/* Real proto is set via INET_DIAG_REQ_PROTOCOL */
> +			.sdiag_protocol = IPPROTO_TCP,
>  			.id.idiag_cookie[0] = token,
>  		}
>  	};
> @@ -146,12 +147,12 @@ static void print_info_msg(struct mptcp_info *info)
>  	printf("add_addr_accepted_max: %u\n", info->mptcpi_add_addr_accepted_max);
>  
>  	printf("\nTransmission Info\n");
> -	printf("write_seq:        %llx\n", info->mptcpi_write_seq);
> -	printf("snd_una:          %llx\n", info->mptcpi_snd_una);
> -	printf("rcv_nxt:          %llx\n", info->mptcpi_rcv_nxt);
> -	printf("last_data_sent:   %x\n", info->mptcpi_last_data_sent);
> -	printf("last_data_recv:   %x\n", info->mptcpi_last_data_recv);
> -	printf("last_ack_recv:    %x\n", info->mptcpi_last_ack_recv);
> +	printf("write_seq:        %llu\n", info->mptcpi_write_seq);
> +	printf("snd_una:          %llu\n", info->mptcpi_snd_una);
> +	printf("rcv_nxt:          %llu\n", info->mptcpi_rcv_nxt);
Judging from the output of the ss command, the three fields 'write_seq',
'snd_una', and 'rcv_nxt' are displayed in hexadecimal format.

But after checking, my 'ss' version is too old (6.1.0). So LGTM.

Thanks for this patch again.
> +	printf("last_data_sent:   %u\n", info->mptcpi_last_data_sent);
> +	printf("last_data_recv:   %u\n", info->mptcpi_last_data_recv);
> +	printf("last_ack_recv:    %u\n", info->mptcpi_last_ack_recv);
>  	printf("retransmits:      %u\n", info->mptcpi_retransmits);
>  	printf("retransmit bytes: %llu\n", info->mptcpi_bytes_retrans);
>  	printf("bytes_sent:       %llu\n", info->mptcpi_bytes_sent);
> 
> ---
> base-commit: 3716d837622ee1baf6fbe7e6a6a7a3df116e75fe
> change-id: 20250224-mptcp-sft-diag-squash-859ea35654a0
> 
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> 
Best regards,
Gang Yan <yangang@kylinos.cn>

