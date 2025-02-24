Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F142571AC
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399229; cv=none; b=lLy7V2Wbub7tPfKxdiYtrwLh4FgKgSzk0ukkVCzcJ1igP9gzhC8wT7uz48SWOzqrmDHf8fA5pDANICzNosh+yXFiQI2pnPF8e4H31wCZBJunTQnIwqxEAkIX5e7FWOJXdwHAv3Z2Pb3ELB8hhSSvWPvNG2LYnQmT+ES7gI4AaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399229; c=relaxed/simple;
	bh=jPyAZ9jkSRvInaoMR+wBjTF8SETAJSWbml/h0ljaxeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C7fX/RAM9FrNgu6zH7CzEMHconC47cISv6xPGBXzCE1vKiEZ3AZUCcXpCNHvElUFVCVSW5wt9TbeJMQKLKwCrAI8AP/TTJ5C5im5zFFY5KA4hXOGhEIlHx8QmMiYWS339vtWVDUrhaYsmQDNd+legClIWIGRzlMJ3Sk6bjQlNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhuRzRYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhuRzRYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EBDC4CEE8;
	Mon, 24 Feb 2025 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740399229;
	bh=jPyAZ9jkSRvInaoMR+wBjTF8SETAJSWbml/h0ljaxeo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=IhuRzRYSaZAowTHuKb+U238cpJuX1BaM45NJTt5JREaZATzOBP0c4KZfdeq2DPcW8
	 FSPMvZiEPe4m5+rysnYC04wyBRW9kdqxhYVv74rmoazcbE1cnaW5V042KIrrbRy2TD
	 Giy+bf6ixM0PjjsmK6IhQVDHxunc2zHYo+0rE9MqP5t+5b7xjzJ2i8LS3XSLrZ6o0G
	 m+6S0H5U6PiH026oPrfLMXZQMJE40R/bEVCIqz7GRyQMAQGf/7hAtSyoZu7R2LdDuz
	 8MNoJmsxPdPkRPZ6dnR7icbUK2uNVplWF8nIsWw85GWC7AOjanudtCkSDFo0T1Ae5S
	 UFpcB6ZafaXQQ==
Message-ID: <3aab4781-d63a-4ee2-a099-db023f6886b7@kernel.org>
Date: Mon, 24 Feb 2025 13:13:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next v4 1/2] selftests: mptcp: Add a tool to get specific
 msk_info
Content-Language: en-GB
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1740385876.git.yangang@kylinos.cn>
 <4b060bd673858f11981e91956a34d1a42478b869.1740385876.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4b060bd673858f11981e91956a34d1a42478b869.1740385876.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang Yan,

On 24/02/2025 10:02, Gang Yan wrote:
> This patch enables the retrieval of the mptcp_info structure corresponding
> to a specified MPTCP socket (msk). When multiple MPTCP connections are
> present, specific information can be obtained for a given connection
> through the 'mptcp_diag_dump_one' by using the 'token' associated with
> the msk.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> new file mode 100644
> index 000000000000..6dc53ab867c5
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025, Kylin Software */
> +
> +#include <linux/sock_diag.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/inet_diag.h>
> +#include <linux/netlink.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <linux/tcp.h>
> +
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <stdio.h>
> +
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +
> +struct mptcp_info {
> +	__u8    mptcpi_subflows;
> +	__u8    mptcpi_add_addr_signal;
> +	__u8    mptcpi_add_addr_accepted;
> +	__u8    mptcpi_subflows_max;
> +	__u8    mptcpi_add_addr_signal_max;
> +	__u8    mptcpi_add_addr_accepted_max;
> +	__u32   mptcpi_flags;
> +	__u32   mptcpi_token;
> +	__u64   mptcpi_write_seq;
> +	__u64   mptcpi_snd_una;
> +	__u64   mptcpi_rcv_nxt;
> +	__u8    mptcpi_local_addr_used;
> +	__u8    mptcpi_local_addr_max;
> +	__u8    mptcpi_csum_enabled;
> +	__u32   mptcpi_retransmits;
> +	__u64   mptcpi_bytes_retrans;
> +	__u64   mptcpi_bytes_sent;
> +	__u64   mptcpi_bytes_received;
> +	__u64   mptcpi_bytes_acked;
> +	__u8	mptcpi_subflows_total;
> +	__u8	reserved[3];
> +	__u32	mptcpi_last_data_sent;
> +	__u32	mptcpi_last_data_recv;
> +	__u32	mptcpi_last_ack_recv;

Small detail: some fields are aligned with spaces, others with tabs. Can
you pick only one please? tabs?

(...)

> +static void print_info_msg(struct mptcp_info *info)
> +{
> +	printf("Token & Flags\n");
> +	printf("token:	       %x\n", info->mptcpi_token);
> +	printf("flags:	       %x\n", info->mptcpi_flags);
> +	printf("csum_enabled:  %u\n", info->mptcpi_csum_enabled);
> +
> +	printf("\nBasic Info\n");
> +	printf("subflows:		%u\n", info->mptcpi_subflows);
> +	printf("subflows_max:		%u\n", info->mptcpi_subflows_max);
> +	printf("subflows_total:		%u\n", info->mptcpi_subflows_total);
> +	printf("local_addr_used:	%u\n", info->mptcpi_local_addr_used);
> +	printf("local_addr_max:		%u\n", info->mptcpi_local_addr_max);
> +	printf("add_addr_signal:	%u\n", info->mptcpi_add_addr_signal);
> +	printf("add_addr_accepted:	%u\n", info->mptcpi_add_addr_accepted);
> +	printf("add_addr_signal_max:	%u\n", info->mptcpi_add_addr_signal_max);
> +	printf("add_addr_accepted_max:	%u\n", info->mptcpi_add_addr_accepted_max);
> +
> +	printf("\nTransmission Info\n");
> +	printf("write_seq:	  %llx\n", info->mptcpi_write_seq);
> +	printf("snd_una:	  %llx\n", info->mptcpi_snd_una);
> +	printf("rcv_nxt:	  %llx\n", info->mptcpi_rcv_nxt);
> +	printf("last_data_sent:	  %x\n", info->mptcpi_last_data_sent);
> +	printf("last_data_recv:	  %x\n", info->mptcpi_last_data_recv);
> +	printf("last_ack_recv:	  %x\n", info->mptcpi_last_ack_recv);
> +	printf("retransmits:	  %u\n", info->mptcpi_retransmits);
> +	printf("retransmit bytes: %llu\n", info->mptcpi_bytes_retrans);
> +	printf("bytes_sent:	  %llu\n", info->mptcpi_bytes_sent);
> +	printf("bytes_received:   %llu\n", info->mptcpi_bytes_received);
> +	printf("bytes_acked:	  %llu\n", info->mptcpi_bytes_acked);

Small detail: probably best to do the alignment only with spaces and not
a mix of both because I don't think it would look nice depending on how
the tabs are being printed.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

