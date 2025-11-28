Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58D24C06A
	for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764343659; cv=none; b=u7yvgtTzyEkn9pStV7gmuU0dFK1tbQLKetVIypA4HthmRl0N+VdMRdjDBS4Hg7zDfp4jAXjoRjOy6vz+iOzuAdHLuDCyHJj9IEpumsIzeRRvapzvPKYM34c/a54wp5GTOm7ARbTyYGGqRxF0XmUu2qvZDFc5zYPCVQpnvT77ceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764343659; c=relaxed/simple;
	bh=d0UU7120GMC1pIY5MTl7O8DhaCxjBCqdmMA7uhKFgoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMhbNPO00eELxd96wM/W1c46RHcpb6xp7XX2mWSZcbOoRn1kzmXD4kOAiwF01Cx9eN+JXTMAZY/2dwE4EzpgGxzHlsgilAGa/l+eCl+jiQLr9xWfz/5KQP77S2K01E3y+8lVRAZMe/wueJgfbBrZZ693cQ2P4bCyCeV5Pwldu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SAZn80rl; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SAZn80rl"
Date: Fri, 28 Nov 2025 23:27:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764343653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXu5n4/4VvQeBIc/KeE3YDcQqJx7qhaKkJlGMpgYWJM=;
	b=SAZn80rlXckWwFrtKQKU/Co3p8Dbkwr1YNZCeQhlu25G3NH44J46lhSfIEFb6u8D9JCg7b
	uPBhwACh6pUCuURkbHhoyQqOP3BgFlLrfCUd3J3DgT0cjk+k/nvCLWV9jWz5PqPDI8NMyi
	hzQaLuZZ4baLjJnOdU7I+dwQDkjynYY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: GangYan <gang.yan@linux.dev>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] mptcp: sync the msk->sndbuf at accept() time
Message-ID: <aSm_TunlCULWljoI@thinkbook16p>
References: <20251128094417.14463-1-gang.yan@linux.dev>
 <a6f9f6e8-8a41-4b5c-a72f-1351f53cb631@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6f9f6e8-8a41-4b5c-a72f-1351f53cb631@redhat.com>
X-Migadu-Flow: FLOW_OUT

> On Fri, Nov 28, 2025 at 03:53:54PM +0100, Paolo Abeni wrote:
> On 11/28/25 10:44 AM, Gang Yan wrote:
> > From: Gang Yan <yangang@kylinos.cn>
> >
Hi Paoto,
So glad to receive your messages.

> > After an MPTCP connection is established, the sk_sndbuf of client's msk
> > can be updated through 'subflow_finish_connect'. However, the newly
> > accepted msk on the server side has a small sk_sndbuf than
> > msk->first->sk_sndbuf:
> > 
> > '''
> > MPTCP: msk:00000000e55b09db, msk->sndbuf:20480, msk->first->sndbuf:2626560
> > '''
> 
> How do you observe the above exactly? subflow-level rcvbuf increases -
I observe this through an normal test, using server to send MSG DONTWAIT messages
to the client once the connection is established.
In fact, we can use the 'send_recv_data'’in mptcp's bpfselftest with
MSG DONTWAIT flag.

> in tcp_new_space() -  are propagated to the msk via:
> 
> ssk->sk_write_space -> subflow_write_space -> mptcp_propagate_sndbuf.
>
Yes, but the 'tcp_sndbuf_extend' also called in 'tcp_init_buffer_space'
immediately after connection enters established state. The client side is updated
via: "subflow_finish_connect' -> 'mptcp propagate_state'. But the server side 
seems need to update msk->sk_sndbuf too. 
> > This means that when the server immediately sends MSG_DONTWAIT data to
> > the client after the connection is established, it is more likely to
> > encounter EAGAIN.
> 
> It's unclear to me how the subflow rcvbuf can be greater than default
> before sending any data.
I raised an issue in multpath-tcp/mptcp-net-next, and post some information here,
maybe it is helpful;
https://github.com/multipath-tcp/mptcp_net-next/1ssues/602

Thanks
Gang
> 
> /P
> 
> 
