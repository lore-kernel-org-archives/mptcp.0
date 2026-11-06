Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006428;
	b=rTk51iXg/NF1j3J+hnFsd9NVsT8ssQllIU13HG+ZvaqZPu2LTvssDlZW4H6KFG+0LJlZ
	 yUtfJ5C0dsfZsZVS91JcyM20G2xTXSLXrfyDd1CSsQIlkPYuiWl5+A13YcLkoVP4HmuvN
	 N45fH6zab4/ag/8X9dPEdeZx3iWJtznSS7hHDJ1UAFMPQRJ3Ibwl/waoziQNN8hkuvGUi
	 txf81jHGgiiKJmSvkr/zhhuzmJmdTp3idZ5tcXv6wg4uQuVovF2PDDUCz12tgoNjESn1d
	 /X8mtLlDYCdSsb7OjkfpfDCGIx3ZpGdmIEIBsIGbFLSdQoQHxWUwA9Mb/M7LENe9IuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006428;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3BBkQCLMsBMq0t0OgbNouylGl/vTr9lMRiQNd0li8S0=;
	b=Q0yDvfbBPbZSmexZm3tyJxjkDMJTu4Eus1oRNyy5HYw5Vq5rppyFvAbQdmUfZh8ANmDP
	 /ZzsIPFUsTmXUKy7ErdtFpa4rez8+DY2iw9tZi6o6Yqd9VCT3iPdvTxEoU5qhjcJ1gNOU
	 8Hj07jTLk1U63p7UEUmX+dz1/d4tT6SpywnX7lB4U1tYgO8iXpNVDi0Z68kQH7G429ri1
	 r2oFJrD04Mli41r2KXEa1sEo3Nl7Nsl65Q3ej1kqmFDc2Q6DgsJZ1xdq9XsaXU7Vr9B2C
	 nBop0vbyrznuhxlLju0ezd244jb7GZN/Mbz8jQb14IwXx4dph+UsK7sJ7swbzN0y3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjyPqpR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ECF606A326
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjyPqpR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159671F008A1;
	Fri,  6 Nov 2026 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006427;
	bh=3BBkQCLMsBMq0t0OgbNouylGl/vTr9lMRiQNd0li8S0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RjyPqpR3TyjkrCPQINfLKt3YPwIHvOXhuZfHIkDcyZzVU373IICDZQZt5zuTNga8r
	 m+YCjNBf54hREZti8Hio2GAsNeDTTis5HLbxmOkNCuau4l/10q5lQFt1RQYUcR3k4J
	 +n2oi1kVKlzKqpqHr05eaVOKxCmlrUIkG/06iLMqb/CyaqJyGcmPqZbmVcehg+9y5V
	 uLwNc7AYjrdToDjrQWjJlOrCcheIpLkxxHdGcxy8dTA7MrFGd/du5g7dIKH4DbtcH+
	 UFjTwu4Ah7rWC+gmNCoVWpVi5MwBDgHNPr8Jmd+umya3CKQRyamCF40iPjGy6MGiR6
	 DarAKBfmNXeuA==
Subject: Re: [PATCH mptcp-next v21 2/9] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 23:07:06 +0000
Message-ID: <179400642663.488855.14553445307814665064@kernel.org>
In-Reply-To: <922016b6ad6c68e0ead315b54c6849e4e76ce2c7.1793870710.git.tanggeliang@kylinos.cn>
References: <922016b6ad6c68e0ead315b54c6849e4e76ce2c7.1793870710.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new SIOCINQ regression check in main_loop_s()
  (tools/testing/selftests/net/mptcp/mptcp_connect.c) depends on timing,…

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This adds a SIOCINQ check to main_loop_s() in mptcp_connect for runs where
the MPTFO sockopt is set. After accept(), the server sleeps 10ms so the
third ACK can be processed. The test fails if ioctl(SIOCINQ) returns
INT_MAX.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..e30a6900d01f5 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1207,6 +1207,20 @@ int main_loop_s(int listensock)
>  		check_sockaddr(pf, &ss, salen);
>  		check_getpeername(remotesock, &ss, salen);
>  
> +		if (cfg_sockopt_types.mptfo) {
> +			int avail;
> +
> +			/* Wait for third ACK to be processed */
> +			usleep(10000);  /* 10ms */
> +
> +			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
> +			    avail == INT_MAX) {

[Severity: Medium]
Is a fixed 10ms sleep enough to make this check reliable?

With passive TFO, the child socket is put on the accept queue while the
SYN is being handled. That means accept() can return before the MPC third
ACK has been processed. msk->ack_seq only changes later, in softirq:

__mptcp_subflow_fully_established()
    subflow_set_remote_key()
        WRITE_ONCE(msk->ack_seq, subflow->iasn);
        WRITE_ONCE(msk->can_ack, true);

At this commit, mptcp_fastopen_subflow_synack_set_params() still does:

    MPTCP_SKB_CB(skb)->map_seq = -skb->len;

So the old mptcp_inq_hint() returns INT_MAX even before the third ACK, and
timing does not matter yet.

Later in the series, "mptcp: fix TFO map_seq sign extension in fastopen"
changes this to -(u64)skb->len. After that, the old ack_seq - map_seq
formula gives the correct value (skb->len) while ack_seq is still 0. A
reintroduced mptcp_inq_hint() regression would then only show up if the
third ACK has been processed before ioctl() runs. No later patch in the
series changes this test.

On a loaded CI host, or on a debug kernel with KASAN, lockdep or
kmemleak, can the third ACK arrive after the 10ms window? If so, the check
reads a correct value and passes on a broken kernel.

Would it be more deterministic to poll getsockopt(SOL_MPTCP, MPTCP_INFO)
until MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED is set, with a bounded timeout
that fails loudly on expiry? mptcp_diag_fill_info() sets that flag from
msk->can_ack, which is written right after ack_seq.

Two smaller points about the same check:

It only rejects avail == INT_MAX. It does not check that ioctl()
succeeded, or that avail matches the size of the SYN payload.

Nothing confirms that passive TFO with SYN data actually happened.
run_tests_mptfo() in mptcp_connect.sh runs each address family twice:

    run_tests_lo "$ns1" "$ns2" 10.0.1.1 0 "-o MPTFO"
    run_tests_lo "$ns1" "$ns2" 10.0.1.1 0 "-o MPTFO"

The first run only fetches the TFO cookie and sends no SYN data, so the
new check passes trivially on that run.

> +				fprintf(stderr, "TFO SIOCINQ overflow\n");
> +				close(remotesock);
> +				return 1;
> +			}
> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793870710.git.tanggeliang%40kylinos.cn
