Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CE1A5BBC
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275408; cv=none; b=AFkt+V1lKFIElhW2VSu8rrdNnqz44cSlbYEYz4hDhs8/zp/PlxudkUPpOPhAtEWQzh+sV0ymiKliDaQVRkX4axiCTMHU0kmyh4bgitw1C+VROt64UdV6IapEuMbxMkn7d7KtjwtWNn8POCS4Dv79SwbaVMNoHcSMSdxbCmINzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275408; c=relaxed/simple;
	bh=k8nljP57XoaDBVIpFcWqc8lBdBBDLLLy+4uYABWjFcE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CDx189Kc/ixkFTtE0pFOT45ms+jcQWjiDgmCiG28GCjcKlggjSB0iJxiELMrKhd34lMDrdtVTcYEonrkc53lnFdXgfs1sEozHI/OK97dfLyQ1lE3PMEOBAxXcbARW05TUlMVd2jW9e+bv9xRNxpAarCO6B68ehZfnyiBUGn1OrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+bIlnEs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+bIlnEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F74C4CEF0;
	Fri, 19 Sep 2025 09:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758275408;
	bh=k8nljP57XoaDBVIpFcWqc8lBdBBDLLLy+4uYABWjFcE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=t+bIlnEsxCz9Dxd0KFDozTEsTClX/XMqWT3U+v2nk/Ikon87fdRHCN6jAOzBckWdu
	 JZEIstku01Us4fzAHo5gK5UeVHrJK4/n5nYh667io7KWrvcJc5EZpv2g6fRJLFbZ1T
	 QOif17jP2Dv+Ainwu35qCibZCUdu2tHwH148w57L21EkH0tE6MpXUTR8m92Urdudfe
	 FOriz8O4imOJQrEd+VSp2N24CCKPp0OaN64H5ESiunLyKsVqH3OH6+vq3DXcwNmm5X
	 7f2PJzipETfGOunO4CAqkIqTZfJZyQk1j9WD0uXCFXFammHkgg3mE7D/QtDFPd53BO
	 IobDlA+Qfh1yg==
Message-ID: <ceb0c39637fec1cb0d10520db53acbedf8fc7f08.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 02/12] tcp: make tcp_rcvbuf_grow()
 accessible to mptcp code
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Fri, 19 Sep 2025 17:50:04 +0800
In-Reply-To: <d5fe01b8d262752dea8db8653e12aa9e9685b7e7.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
	 <d5fe01b8d262752dea8db8653e12aa9e9685b7e7.1758214563.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-09-18 at 19:14 +0200, Paolo Abeni wrote:
> To leverage the auto-tuning improvements brought by commit
> 2da35e4b4df9
> ("Merge branch 'tcp-receive-side-improvements'"), the MPTCP stack
> need
> to access the mentioned helper.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  include/net/tcp.h    | 1 +
>  net/ipv4/tcp_input.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e25340459ce4a..db2a4e05147fa 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -356,6 +356,7 @@ void tcp_delack_timer_handler(struct sock *sk);
>  int tcp_ioctl(struct sock *sk, int cmd, int *karg);
>  enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct
> sk_buff *skb);
>  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
> +void tcp_rcvbuf_grow(struct sock *sk);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
>  void tcp_twsk_destructor(struct sock *sk);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index b2793e749cfd9..ad09995a1aaec 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -701,7 +701,7 @@ static inline void tcp_rcv_rtt_measure_ts(struct
> sock *sk,
>  	}
>  }
>  
> -static void tcp_rcvbuf_grow(struct sock *sk)
> +void tcp_rcvbuf_grow(struct sock *sk)
>  {
>  	const struct net *net = sock_net(sk);
>  	struct tcp_sock *tp = tcp_sk(sk);
