Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184D1E47DD;
	Tue,  1 Apr 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743495879; cv=none; b=eletZ/lG+xCU2sYrfDF5XdoTN3mlDblU7ByRCndimwrcWQfqvj61WWS1j110e8iU8iAV0PDe3iT0a2DHaKlRKcF4va/xCkHE/diqTreO57ZOLvMdKIsxukXU4x8jYJMMbyIvPgVMZAi//kMM2aeTd5xMxLUBDf4nEXbswhVP9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743495879; c=relaxed/simple;
	bh=SB2q6xQ56/3mpPcfMH9fyJWiPwvHFAbAR+tuJWgebls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5dsu9gZGvbT7xxUCfD0dzly/H+B9xz3dRc4r+UHplC47gijYX3CBDaqRKNmrS5dEIUbIr0YWnDN1rgXjTUfMIsfvxE178NLUj6HtppT1N+rNht2ABwrjHtefTKDEg+AMFJ4SJatFaNZKF+rKAKD/rEaUbxtTFS6jtsr9UGCkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=3Fq/qU1j; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="3Fq/qU1j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=P2vCMgKs60kE2AEX7EBwSn8Ro/J/oeai91FyuRtK384=; b=3Fq/qU1j2+zydWavWoxfAcA+HK
	TKI4UvNHnhwFprYvUSDhd/3g172hIDos3qtk3cBwAqJau7Jhvq4tL41vm2l+ADVCkiocupdWJOVV9
	3ql30+yvvyae6VsUM3J7Ho+XZD0hOHcAcb3P3IaIR9Fau7GUsyxSJRscTfjSw1IIJ/+i8wF6Y7WJW
	vpnL7/YUDkat74R3AevuO9U2FwYyU0h5hqTzt9D7JnIfzoT6hCTiiqAHln7Nfpr5hkPfZwYhz9lRN
	fLYDUS+e8G5ZMVcKG8sSMA005efyjFsifeGCyB0zCn9XI47K+K3yIgCUMzDP2hA8J6QinWnPoiBrH
	AToIIUnvWg47OEFx9eir/cQlNMMu9gkPCUuvmtc0NA+8ULSsYhiEONjvU/M7aKAobjU56cv1KLDYy
	rD56flFnuBVlPW0d8J7D3M+Ja1yDDNunOFIiCoQAP8LG52u2txNMmM8CdZicF/Y+R05Hcl8XrdDW2
	XC695dYaZdJI//kShfqpRZux;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1tzWvB-007dPk-1c;
	Tue, 01 Apr 2025 08:24:33 +0000
Message-ID: <51bb66d4-eaf3-4247-ba11-d793b6f0d56c@samba.org>
Date: Tue, 1 Apr 2025 10:24:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] net: pass a kernel pointer via 'optlen_t' to
 proto[ops].getsockopt() hooks
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Karsten Keil <isdn@linux-pingi.de>,
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Neal Cardwell <ncardwell@google.com>,
 Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 James Chapman <jchapman@katalix.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Remi Denis-Courmont <courmisch@gmail.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-hams@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-can@vger.kernel.org, dccp@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-s390@vger.kernel.org, mptcp@lists.linux.dev,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net,
 virtualization@lists.linux.dev, linux-x25@vger.kernel.org,
 bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
 io-uring@vger.kernel.org
References: <cover.1743449872.git.metze@samba.org>
 <d482e207223f434f0d306d3158b2142dceac4631.1743449872.git.metze@samba.org>
 <20250331224946.13899fcf@pumpkin>
Content-Language: en-US, de-DE
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20250331224946.13899fcf@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 31.03.25 um 23:49 schrieb David Laight:
> On Mon, 31 Mar 2025 22:10:55 +0200
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>> The motivation for this is to remove the SOL_SOCKET limitation
>> from io_uring_cmd_getsockopt().
>>
>> The reason for this limitation is that io_uring_cmd_getsockopt()
>> passes a kernel pointer.
>>
>> The first idea would be to change the optval and optlen arguments
>> to the protocol specific hooks also to sockptr_t, as that
>> is already used for setsockopt() and also by do_sock_getsockopt()
>> sk_getsockopt() and BPF_CGROUP_RUN_PROG_GETSOCKOPT().
>>
>> But as Linus don't like 'sockptr_t' I used a different approach.
>>
>> Instead of passing the optlen as user or kernel pointer,
>> we only ever pass a kernel pointer and do the
>> translation from/to userspace in do_sock_getsockopt().
>>
>> The simple solution would be to just remove the
>> '__user' from the int *optlen argument, but it
>> seems the compiler doesn't complain about
>> '__user' vs. without it, so instead I used
>> a helper struct in order to make sure everything
>> compiles with a typesafe change.
>>
>> That together with get_optlen() and put_optlen() helper
>> macros make it relatively easy to review and check the
>> behaviour is most likely unchanged.
> 
> I've looked into this before (and fallen down the patch rabbit hole).

Yes, if you want to change the logic at the same time as
changing the kind of argument variable, then it get messy
quite fast.

> I think the best (final) solution is to pass a validated non-negative
> 'optlen' into all getsockopt() functions and to have them usually return
> either -errno or the modified length.
> This simplifies 99% of the functions.

Yes, maybe not 99%, but a lot.

> The problem case is functions that want to update the length and return
> an error.
> By best solution is to support return values of -errno << 20 | length
> (as well as -errno and length).
> 
> There end up being some slight behaviour changes.
> - Some code tries to 'undo' actions if the length can't be updated.
>    I'm sure this is unnecessary and the recovery path is untested and
>    could be buggy. Provided the kernel data is consistent there is
>    no point trying to get code to recover from EFAULT.
>    The 'length' has been read - so would also need to be readonly
>    or unmapped by a second thread!
> - A lot of getsockopt functions actually treat a negative length as 4.
>    I think this 'bug' needs to preserved to avoid breaking applications.
> 
> The changes are mechanical but very widespread.
> 
> They also give the option of not writing back the length if unchanged.

See my other mail regarding proto[_ops].getsockopt_iter(),
where implementation could be converted step by step.

But we may still need to keep the current  proto[ops].getsockopt()
as proto[ops].getsockopt_legacy() in order to keep the
insane uapi semantics alive.

metze


