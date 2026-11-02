Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578675;
	b=37sVrMA6GFcCYHrEzgpFNoHzVhuSHTf9ZhPaeMTz6i7jfD73C+7AFJbaMOUi8zJqplpD
	 qcyx0Z8VB/gU6QfOUFRgiJI0jw0nxjtQcYjAA0I6pajlcXTFASEGR6yM2ZM8hy/9O2bol
	 SDRKwHQNQaTBn6k7tXBJsi4jE2ehMjHBrcVp0HLpRapCV9CxPZMWCbIAEryib6kG8XcRQ
	 ro8njo1+OYImYiXhyJIjsjNX+4dutaF9rSsuTexOC3Yy2cAtOt/X1kLQRDKUexCZezCJ6
	 lKZnoknnqWs+XZVepsJz1Azo0Gg2KYWlExgQfcbLlOq+jKLZJw2Hena4lgwSz9CRsSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OwpIzVCkDZcH3jbzH5HRsFx6n0SAUwWodTFAghsx2FQ=;
	b=vNjLxfZsChZnD4lzJDQyaT5B2D3SfU135gCDaoe8LVIrzbsPlSeRUJ+TqndsQEtEvvAH
	 qiMa0I3NGHg5+YcNZMmjN2TIfykbck/0cjjyB4vcJtZ/lCk4DDXswezTWSSWClDXKcrFP
	 s6C+XCae3aKi6uC37ZCgEiWRFb/pBskynLxaSEvb7LY1JAYBMUF0EmqVXUgad0O6VLDBL
	 HGL6i2upq3EdBqnBLplcj/YZnbYHVwt8YXVCzYNElXo66m7kKQ1HKdrULrTXB37KcVA93
	 1CLKPYu5HyFJLQFYAabTMbHRfjwoVA3oA0F/yGN3Ku+4gjIpbTf40TjyV5nqEzmOcbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucwq2g9W;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1C606A326
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 00:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF1C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucwq2g9W
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso14367745ad.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 16:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578674; x=1794183474; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwpIzVCkDZcH3jbzH5HRsFx6n0SAUwWodTFAghsx2FQ=;
        b=ucwq2g9WcNL5ojPMUjki7KUzpmldDu4CQ1HXcvSJNnzTjDvIrfNN51MQsAUhopDeyA
         DVl3lqTlSiTqFjiiHrI0zYl+l6m+OydZb8n9oLp9vLsRxSY0wxrybDvv+wW0e+c3Iq5+
         BkHnTaUSg/VcXbQzOMaiUtZsNPA8w8uA9pjA5lKdmU/4qE5/IdZeGnUQtivyO7AjZxUa
         jawtrzVwRsaYkifRBDwFa2eg0/P5+Yc+7eglwy1v1ZRj+4dh9YsOok9mveJZgnrHofXx
         z3yvs4f8ltKxVCuCGDZNS5yZwH2kjBadarlBMgCDt6u0CVQpYLA/TueUXweMyLWw8tbc
         5T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578674; x=1794183474;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OwpIzVCkDZcH3jbzH5HRsFx6n0SAUwWodTFAghsx2FQ=;
        b=0ecYmBc//FecycOElTV29EG6QkLtQbTwc4NS5kpLMkqJ3sSz3MdZd2Ruk6Z4PVPPgu
         gYrfv3YsH27FvJbBnEU4a1Aw6SZiRg1xFrh+THpjeZXncsgpe4v+5hEkZlkxfepQsyKH
         VLUPcLgckli6ulOjVjQhufk//cbGfoffsKzQ7Bkw2rqTdNiyWckgc6R5GQ6x2Xxirlhq
         3M4CtGvrCc4ZC+ICuopEfmB/d4UcjxEFw0Ioeq0r60zM8nlUPNurcpSN9iPpBSGp/zQC
         laGfR6WXEk3Iit8Erx28nnj9HOnf3B522qZdAjFwfE6ECL06dkZSL6A0elxON7d4jryf
         cvHQ==
X-Gm-Message-State: APuU4Z8bfMdvGX0S/ux1TF8z8oXTIE/0tHjvAoAa7s1ZXAGUxV4ABy0a
	msJjkWJVafdXG+fftfeLPWVNtFycCHShKXeczpUt314Hm+V6fhmL3CPJWegmgg==
X-Gm-Gg: AYBFou1FudvVqeblBNTbriWXEEb/JYQPpTtzlKn/hKjr0+0238G52oq4DExcLUTssEE
	fGvQ9EkqAfeZv+QSk2r1zp/zYI4I5QT0616t3iEuhDKV/n8lCH0YRY+wdkp0e8HorWRCWnfqVHg
	kNQAz8A+6cNWxehCOfUZnAlIr+JSy3Fp8+skykm6YsmOnIea/+jHI6ShWdHu5dbuUYrAZAFlB8W
	CXh7v9NVvnS0Qt/AwJGavppGHNkt5EL5afEKFLymguIpJ8ucKTNPLgRmKync5tm3/nWLc2QZT4x
	BUTeTGpiOYj7nC0ibtfhVmFbAdGHuTjd4OkBaaNqp9CTW6fuQfuWQrrDp7fdgF9PG4pFUO5T97H
	kq4ny3S5lsOUMNbAwMM00J7jxO3grlbxy7UYcVt5sKVATfKfm9qfPv6fjehaDKco14IPaGdv/8Y
	A8I+PbnecJjm0YmucGR4pCou/CBUIRZn9KE6G9IPFKwtt1zQdXQ7XBemLSlyWomjUmGDQK2GnAh
	hLVNWw8OrFrYLIZ4AZky7RCzpFN+mxM/HX72djqjpuwwGeYNN2sc2JQ+K6TlFwrm6S0xJ1ZhSjj
	/erWoqJWryBZo0+HljEODfylcxnsfhK05jwTGzAayo9u0HFG6fA72lC/YILXByV+HM96W1k1YnL
	qfom9aeoG2MIzzbFMrv5XQ4bQPzCBYY9laP9I+wk6JL3pYdamOOG98do=
X-Received: by 2002:a17:90b:52cd:b0:3ab:b764:826c with SMTP id 98e67ed59e1d1-3ae897ccacemr6470813a91.12.1793578674003;
        Sun, 01 Nov 2026 16:17:54 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e949077sm15965674a91.9.2026.11.01.16.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:17:53 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 00:17:53 +0000
Message-Id: <DMKAKRM51QKN.34OI7DN57OAV7@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Cc: <mptcp@lists.linux.dev>
Subject: Re: [PATCH bpf 06/15] bpf, sockmap: Give no progs to a TCP listener
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <sashiko-outbox-192637@kernel.org>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com> <20261101192057.2296489-7-alexei.starovoitov@gmail.com> <sashiko-outbox-192637@kernel.org>
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

On Sun, Nov 01, 2026 at 11:51 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
>> +		goto no_progs;
>
> Because sock_map_del_link() checks the unlinked map's progs rather than
> whether that map actually installed programs on psock, won't removing the
> socket from Map B stop Map A's active verdict or parser callbacks (and
> potentially call sk_psock_stop_strp() on an uninitialized strparser if
> Map B had a stream_parser while Map A only had a verdict program)?

Not from this patch. sock_map_del_link() looks at the progs that the map
has at the time of the delete. Add a socket to map B, attach a prog to
map B, delete the socket. That stops the progs of map A today.
strp_stop() only sets a flag, and sk_psock_done_strp() checks
SK_PSOCK_RX_STRP_ENABLED.

> Wouldn't sock_map_link() then see TCP_CLOSE instead of TCP_LISTEN, skip
> the goto no_progs branch, and attach the map's programs and callbacks to a
> socket that can subsequently re-enter TCP_LISTEN?

It doesn't matter. connect(), connect(AF_UNSPEC), listen() gets to the
same state without a race. The tcp_bpf_clone() hunk is for such sockets.

>> +	if (!is_insidevar(prot, tcp_bpf_prots))
>> +		return;
>
> If sock_copy() copies the already-restored sk_prot alongside the
> not-yet-restored sk_data_ready or sk_write_space, won't
> is_insidevar(prot, tcp_bpf_prots) evaluate to false in tcp_bpf_clone(),
> leaving the child socket with the psock callbacks and allowing the same
> unbounded self-recursion if the child is later added to a sockmap?

The window is there, but it's tiny and it's not from this patch.

> How does a socket that transitions from TCP_ESTABLISHED to TCP_LISTEN while
> remaining in a sockmap wake up accept() when new connections arrive?

It doesn't. It's an old bug, not from this patch.
