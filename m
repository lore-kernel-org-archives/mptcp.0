Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123448;
	b=4YJGfa6bMw3lxGvYUk3uioMbt1zZVcNZJteqmOQb0uwAOn4rpfC9QXbj52OR+MpqIOBZ
	 zOSAdOUx/Z2EYk/xDS7UxrGROJLKOAY49mlyGLpEOHQDWa+Kfve1jWKhl3Zg4rSjzOw8w
	 vX5j9zyAfkvFl86iXagnhzZSzr7l0O2tIVS95mRslSeEZVEN1qSgmmTiuqqI0ajfJRUAP
	 iskaq4OHrYo0gImtZyVkA6HhgLewbfJuiTfNwMpby98NMD4DpIgz7C7318o85Uk89oVVx
	 cIW46/NEKuTYpGH9/KGHT4dLXaAcSgwrn9LBg1ucdCUtKc7kqX6OPNaOOz2/MzIUjBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123448;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0pYlguSOsSeqX2zIJ2YuxhuDCgzA761R7GnrZEP672k=;
	b=Ng5qO7zc4SkzxD6DFfpqeZoY4dWbKVzswnCu/z89ZCxhZ8eBlnp+kR1akZqDwEuebjd5
	 i2snx6CVq1hSebtaIdm7hPxqBtqtFa4hPvcXiy0D5q9jhd5MXE5cYsEQQ+tpMFfgjgH5A
	 GLcF9oD4llnJkXO7KPq6hGOqd4zJDg0iFtgf/smrFd0xH1wbatfUd+g5sZmNqMBbz2MRQ
	 sHQo/Py7a5pC/qe74Npq9XnGkSppSSm/sa7Se0dJlQGKYXRWbffGpRvDcs98/pudnSahe
	 Uw+4CvuZfhFDMnipDrRHpaXAPexT7G1SYmS1z+6SdyUVnRzln03ERCngGoI6F6GA+mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNX6jM0u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5C606A31C
	for <mptcp@lists.linux.dev>; Sun,  8 Nov 2026 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNX6jM0u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD41E1F0089F;
	Sun,  8 Nov 2026 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794123448;
	bh=0pYlguSOsSeqX2zIJ2YuxhuDCgzA761R7GnrZEP672k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LNX6jM0u3JRwBp3rLvwHP8qZI/UpYVfF/rTABiRE619+42L1TM+fUSfc/FK64m1DG
	 8LMmgkgxIiPM7VA1eAP8/bpj62gz/TPhQJCRGFq1hJLojf2gAQshWKM2bue9jfPRrp
	 11nyw2/i9aYz95YUvQvCQMkMA8NlSnWQxiLqkYoAb9ZeZ8M0XxNh0NUIRRgatmWSj3
	 2HIHY/LMf0ZoainNhpMT+BpmacUNvaCSyfT86bVVUwHENH+A4lIZ9IxJcFRcvasOnE
	 bbd8H8DHSOBV7//FXpbohEQ4kK/Hcegdpv3FuJdpaKNqji74gz+Vkxr31lNZVfDnP1
	 2YUhzTrMWz1jA==
Subject:
 Re: [PATCH mptcp-next v23 7/8] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 08 Nov 2026 07:37:27 +0000
Message-ID: <179412344748.488855.16186251375492820658@kernel.org>
In-Reply-To: <e1a5c5e94eb9436da539e2f4f4f67c70f0325df9.1793969127.git.tanggeliang@kylinos.cn>
References: <e1a5c5e94eb9436da539e2f4f4f67c70f0325df9.1793969127.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the new layout makes "fields with a
  corresponding TCP-level data use the same area inside the CB itself".

--

mptcp: sync mptcp skb cb layout with tcp one

This commit shrinks the MPTCP-level map_seq and end_seq CB fields to 32
bits. It also adds a map_seq64 field holding the full 64-bit DSN and a
flags field, and moves most receive path sequence comparisons to the
32-bit before()/after() helpers. Build-time checks are added so that some
MPTCP CB fields stay aligned with their tcp_skb_cb counterparts.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f75297c4d6b0d..2a99b5ced3b0c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4896,11 +4906,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
>  	return work_done;
>  }
>  
> +#define CHK_CB_FIELD(mptcp_field, tcp_field)	\
> +	({					\
> +		BUILD_BUG_ON(offsetof(struct mptcp_skb_cb, mptcp_field) !=    \
> +			     offsetof(struct tcp_skb_cb, tcp_field));	      \
> +		BUILD_BUG_ON(offsetofend(struct mptcp_skb_cb, mptcp_field) != \
> +			     offsetofend(struct tcp_skb_cb, tcp_field));      \
> +	})
> +
>  void __init mptcp_proto_init(void)
>  {
>  	struct mptcp_delegated_action *delegated;
>  	int cpu;
>  
> +	CHK_CB_FIELD(map_seq, seq);
> +	CHK_CB_FIELD(end_seq, end_seq);
> +	CHK_CB_FIELD(flags, tcp_flags);
> +

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7878e6ac6c0b6..fa54f70ab501d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -129,9 +129,12 @@
>  #define MPTCP_SYNC_SEQ		8
>  
>  struct mptcp_skb_cb {
> -	u64 map_seq;
> -	u64 end_seq;
> +	u32 map_seq;
> +	u32 end_seq;
> +	u32 unused;
> +	u16 flags;
>  	u8  has_rxtstamp;
> +	u64 map_seq64;
>  };

[Severity: Low]
The commit message says this change allows:

  "updating the MPTCP CB layout so that fields with a corresponding
  TCP-level data use the same area inside the CB itself."

Is that accurate for has_rxtstamp? map_seq, end_seq and flags line up
with seq, end_seq and tcp_flags in struct tcp_skb_cb. has_rxtstamp does
not, although TCP has a field with the same name and meaning.

In struct mptcp_skb_cb, the u8 has_rxtstamp sits at byte 14. In struct
tcp_skb_cb, byte 14 is the sacked byte:

include/net/tcp.h:struct tcp_skb_cb {
    ...
	__u16		tcp_flags;	/* TCP header flags (tcp[12-13])*/

	__u8		sacked;		/* State flags for SACK.	*/
	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
    ...
	__u8		txstamp_ack:2,	/* Record TX timestamp for ack? */
			eor:1,		/* Is skb MSG_EOR marked? */
			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
			unused:4;
	__u32		ack_seq;	/* Sequence number ACK'd	*/
    ...
}

TCP's has_rxtstamp bit is in byte 16. In the MPTCP struct, the new u64
map_seq64 covers bytes 16-23. It therefore overlaps both the
txstamp_ack/eor/has_rxtstamp byte and ack_seq.

The CHK_CB_FIELD() checks in mptcp_proto_init() only cover map_seq/seq,
end_seq/end_seq and flags/tcp_flags. offsetof() also can't be applied to
the has_rxtstamp bitfield, so nothing at build time would catch this.

As far as I can tell, no current path reads these bytes through
TCP_SKB_CB() on msk-level skbs:

  - mptcp_init_skb() and mptcp_fastopen_subflow_synack_set_params() copy
    TCP_SKB_CB(skb)->has_rxtstamp into a local before rewriting the CB.
  - __mptcp_recvmsg_mskq() reads it via MPTCP_SKB_CB().

Suppose a TCP helper is later run on skbs in the msk receive or OFO
queue and reads TCP_SKB_CB(skb)->has_rxtstamp, ->eor or ->sacked.
Wouldn't it silently get bits of map_seq64 or of the MPTCP has_rxtstamp
byte?

Would it make sense to do one of these?

  - Narrow the commit message, including the "shared fields" wording
    about the build time check, to seq, end_seq and flags.
  - Place has_rxtstamp and map_seq64 so they don't collide with the TCP
    fields, and document the overlap.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793969127.git.tanggeliang%40kylinos.cn
