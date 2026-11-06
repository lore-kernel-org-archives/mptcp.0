Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994800;
	b=sKz1oyA64HbGqsWl6+KfR6T22BEY+z9pDGW1ROGm3TbzKG5gsADnC0RYzE6w56iF0+rf
	 NsdYHYaBOz/uo6F5c8F+7WF/EjCgT3RCEtCGnxqyndKf0nTdc60ArCt8M7Pw9xwR5DWON
	 4Dj62VNjjV2CRpPImzbdtyD5wVbLFhziOEeDQ9IlTqJrirSKiuUq2zOGs+8ick9GAILVr
	 nEqAhYX8jFmiKL73WB9VWpVenVjPgycL2totwmUUIzFCqU17TR8+e7yscdltcVZnxMp4B
	 XPSFlvDMDH+BFVFFWyjUTZa068pOTfN89iePeRGtkgRrzafioBCNSusOJqARBwb1NVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994800;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4ZUB8bf6LHrVl0VxZU+se3CmGfc5aMHtWbMby52ZA+Y=;
	b=mJw+yk4cOPnuqpj+yCYt7Dnhl/buoqQzivkL0C9DUE+cdVzCRzdmklcDjYs6wvqd2sor
	 +HtniqIQUfGwgwHnUMm9mL2keM9zI0KUq/ymxDOE0XhHnPa0fe5hDm+rjBmgEj3HH9Vzo
	 fR+SsRY1oVPTG9+rlTLozAfiXsGjQ1yFimvkkjgvi7UygFQXcKxhOqPLrktXg/GPkrEG7
	 rmp1o7Xq32rMtSA5ctNrh7YPTQ7321lgum2gst9joF90qu7SrWFmSt089BgdSTsv6hFDK
	 kHWi806QG7Zioq0awK5CSr39VGkGCR8tFNDtMsl0zalQ23OtUys/UCEhCPEU21c1lsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQlwlNgJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1792606A329
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQlwlNgJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347671F00900;
	Fri,  6 Nov 2026 19:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994799;
	bh=4ZUB8bf6LHrVl0VxZU+se3CmGfc5aMHtWbMby52ZA+Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HQlwlNgJqL9XpeMbYmLBiUef0f26EBTTXgYL0/hTGI1YwQEnfhwy9yxelCL1rg81z
	 sA1bBzl12HPxyGzxxgvagXQY28IHrFHcCli2nXL7KuI4psfJknKvuyzmWXgczGbFSU
	 uIMUSVDuE92cTRVpv7JCulSCBKgoS/WX/n9Mt1VIaCD50xGqAES0K4yaQDde9bvg5E
	 YsKJfXnCgb/e2+7Gwh2IOp/RkPNKDXz6ozax4GLqKFjWaKrNjg3wXgS+2Y1qMT8jnT
	 YHeFZYK2/MKJhtF+KiD5ncgiaI4gCXXWZuDQ36NdBsia9M+z1IkW0b60UtIEBPTzNZ
	 qxFjTki1Swl2w==
Subject: Re: [PATCH mptcp-next v6 3/7] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 06 Nov 2026 19:53:18 +0000
Message-ID: <179399479878.488855.5287583160072363228@kernel.org>
In-Reply-To: <da22fd79c625e4eed90e83cf91bdddcb165a4a78.1793860134.git.tanggeliang@kylinos.cn>
References: <da22fd79c625e4eed90e83cf91bdddcb165a4a78.1793860134.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message for "selftests: mptcp: connect: check TFO
  SIOCINQ overflow" describes code that the patch does not contain.
- [Medium] selftests: mptcp: SIOCINQ check in main_loop_s() races with
  TFO third ACK

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This adds a check to the server side of mptcp_connect. When the MPTFO
sockopt is set, it reads ioctl(SIOCINQ) on the accepted socket and fails
the test if the value is INT_MAX. The aim is to catch mptcp_inq_hint()
returning INT_MAX for passive TFO connections.

> selftests: mptcp: connect: check TFO SIOCINQ overflow
>
> Add a check in mptcp_connect's server mode to detect TFO SIOCINQ overflow.
> When a TFO connection is accepted, poll for data to arrive, then check if
> SIOCINQ returns INT_MAX. This detects the regression where mptcp_inq_hint()
> incorrectly returns INT_MAX for passive TFO connections.
>
> The check runs when the MPTFO sockopt is set. It polls the accepted socket
> for up to one second, then uses ioctl(SIOCINQ) to verify the available
> byte count. If SIOCINQ returns INT_MAX, the test fails.

[Severity: Medium]
Does this description match the code? The commit message says the test
polls the accepted socket for up to one second before reading SIOCINQ.
The hunk below has no poll(), no timeout and no other wait.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..83db495704fec 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1207,6 +1207,17 @@ int main_loop_s(int listensock)
>  		check_sockaddr(pf, &ss, salen);
>  		check_getpeername(remotesock, &ss, salen);
>
> +		if (cfg_sockopt_types.mptfo) {
> +			int avail;
> +
> +			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
> +			    avail == INT_MAX) {

[Severity: Medium]
Can this check miss the regression it is meant to catch? It reads
SIOCINQ once, right after accept(), and nothing guarantees that the
third ACK from the client has been processed at that point.

For a passive TFO connection, mptcp_sk_clone_init() creates the msk
from the SYN, where mp_opt->suboptions only has OPTION_MPTCP_MPC_SYN,
so msk->ack_seq stays 0. subflow_prep_synack() then calls
mptcp_fastopen_subflow_synack_set_params(), which queues the SYN
payload on sk_receive_queue with MPTCP_SKB_CB(skb)->map_seq set to
-skb->len. The child is put on the listener accept queue as soon as
the SYN-ACK goes out.

If accept() returns in that window, mptcp_inq_hint() on an unfixed
kernel computes 0 - (-skb->len), which is just skb->len, and the test
passes. The hint only reaches INT_MAX after the third ACK carrying
OPTION_MPTCP_MPC_ACK goes through check_fully_established() and
subflow_set_remote_key() sets msk->ack_seq to subflow->iasn. So
whether the test fails on a broken kernel depends on whether the
client ACK was processed before the server called accept().

The poll() described in the commit message would not close this
window either. The TFO data is already on sk_receive_queue before the
child is accepted, so POLLIN on remotesock is reported right away.

Would it work to wait for the msk to be fully established before
reading SIOCINQ, for example by polling getsockopt(MPTCP_INFO) until
MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED is set in mptcpi_flags? Or is
there a better way to make sure the third ACK has been seen before
the check runs?

In main_loop_s(), ioctl(remotesock, SIOCINQ, &avail) is called once,
right after accept(), check_sockaddr() and check_getpeername().

Later patches in the series do not touch mptcp_connect.c, so the
mismatch is still there at the end of the series.

As far as I can tell, the missing wait does not change the result. In
subflow_prep_synack(), mptcp_fastopen_subflow_synack_set_params() queues
the TFO skb on the msk before the child socket goes into the accept
queue. On an unfixed kernel, the old hint also comes out at INT_MAX or
more before the third ACK arrives. So only the description seems to be
off.

Could the commit message drop the poll description, or should the
described poll() be added to the check?

> +				fprintf(stderr, "TFO SIOCINQ overflow\n");
> +				close(remotesock);
> +				return 1;
> +			}
> +		}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793860134.git.tanggeliang%40kylinos.cn
