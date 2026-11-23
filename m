Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435051;
	b=sw0ijNyiV4uKl5MlnUWuwSPpCSIpS4mEA1opGiY1IQiMRG9n7zh2hzTUShrYjT30jmMT
	 fhSzUd6DL0wIF+tSslMFA9T3q3sLrPelaah3v7in0mC5DAXW4ZwKZ1vRclvUwvrYLQHsK
	 Wc0+cuI2RMIBFDeBrE/fPghcQT2t/zq2Bi7cIYoh2lBnFzCsQLkM7GIbZ5P6EElzomh/r
	 NBJeJZ92SogJH05bgRiU9HtS7U5GH5lrTWdlLxCRd3sIbArFp/gXYQU35qo14jfDqGcof
	 wi0zqC5rETe9koerxXcHXtIU0wKAM899ou5RvrcZkIJspflGVyssXxNXEBhEdq4PizQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435051;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Q1tetvOQWJVhjkDBLCLW7p3CxgMdfCNdeiOpu6TckxQ=;
	b=K0ssuTtY0+/Ec0UJC4xBRCt+nzPht/Jg5xNVaAEXuGKep+mCZh+OEscCT8JBW3UpP58v
	 /EIyrW5D/dUtQtGBwCRyGLW0fVC9YMjHoHekA7fW4vTg0r/6SCmbpIbt1I3+HoTLcSiRu
	 qr5te8oX3l7YAzLVe7s3FwBtq5Lz9xfCEcmv8fGtuXgIaH/gL4+n/oed7iqjVw+K03Isk
	 +N6zKYtX4fFoOtVhyEvZ1Os80xUh3ZjEfkBIC6/NPTves9soCWpVt3BEvPTEcFPUa+rE4
	 uKhDY7Cpb1pRnYqtruc05kxD9jXpViydcqAW2S6BLQsw9uMtQVNXyFmJIFRrdIvQ3Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbuJ57P5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39844606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbuJ57P5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23A81F000C4;
	Mon, 23 Nov 2026 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435050;
	bh=Q1tetvOQWJVhjkDBLCLW7p3CxgMdfCNdeiOpu6TckxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mbuJ57P5mirVq0FLim3fsn0KdfGcIns86untHasYAtnfj4k2yI4pP8+QTdZvHvILo
	 s9uoi7DGjg8dQtQ5hHCUw3yJ4xEMi1EGneMXeeAFsUsLwVL3II7CMHMYgSTvVZBl9B
	 dor55lovDreHnaGJlb5x90EaRVVcH4vebISK8XBKzSRdnI2AAo0RjG7dxmWi46lFQF
	 9kt6LuK4ORG2wqa6TurZ5ZN42Tb+J44K7Vb817IH3v5duZDZ8pKmxBrr6w6hAmzbAi
	 I3gZfePHeobxgoxt3+K0cL6S2HAP1V8lkiof33Q+AeJeq1S68IdwuqP6bnCULjHqDq
	 E1cueoIy+rxBA==
Message-ID: <34f1eb28-7702-41a9-9530-24f8e6ba1e07@kernel.org>
Date: Mon, 23 Nov 2026 12:57:27 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 00/62] mptcp: misc fixes
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Kyuwon Cho <kyuwoncho18@gmail.com>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 21/11/2026 10:40, Matthieu Baerts (NGI0) wrote:
> Here are various fixes, many from Chris Mason and Josef Bacik:

The series is huge, I suggest already applying some that have passed
Clashiko and my reviews. So I can send them to netdev soon after, not to
have to deal with so many pending patches for multiple revisions.

New patches for t/upstream-net and t/upstream:
- 52d9a98589c9: tcp: drain the queues of a listen() that fails
- 8a4e263203f4: mptcp: drain the queues of a listen() that fails
- 9d0ecb1b1f33: mptcp: clear inet_opt in the child of an IPv6 listener
- 761c32ace7c8: mptcp: pm: work on a copy of the received RM_ADDR list
- 475077050ec0: mptcp: pm: don't drop an RM_ADDR behind a pending one
- ead7833cdd65: mptcp: pm: don't drop an RM_ADDR because of an ADD_ADDR
- 7d1b430b2cb2: mptcp: pm: keep an RM_ADDR when computing the MSS
- 85fece8445cd: mptcp: arm the rtx timer if a push leaves data behind
- 4b4353255dff: mptcp: force the charge for the first skb of a subflow
- 6c52ddc4696e: mptcp: leave an orphan's DATA_FIN to the worker
- 9a03bc9a9a99: mptcp: don't leak an orphan when the PM closes its last
subflow
- beaa7aa14762: net: add __sk_net_refcnt_upgrade() with a GFP mask
- f0b87bad9a3f: mptcp: pm: don't let listeners pin their netns
- c8be86f52be2: mptcp: initialize drop_req in subflow_init_req()
- 3a3ef2da848e: tcp: do not pass a BPF reqsk to an MPTCP listener
- Results: 55ff7876edc2..4f33144c3abc (export-net)
- Results: b9620afcd7c2..35684d7aa7f8 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/b042b24f739ea310b47ec70a923ba27aa4a46cea/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/97149e277cb068294d3d49966decfd7f9a6f0b8e/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

