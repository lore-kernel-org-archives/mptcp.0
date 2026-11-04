Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752225;
	b=eUfqmw4nEDYgANPSJhCPOYGFr/uBfPPBnODnt5+iQmLHYs1cJErfQ1rFumEHAWlOJWaB
	 P7xDlaVVKqjr+6ifxZgsyxrPKW3OATplfgVcrPQVvD5ggeMICYQA86skOPLl0c6iRwO11
	 SAploEAXRL9mBeKpGKqKdrxseybC2vL/6g2z+++btvz0aQrlvQPz8Wfzf1Rsvgodn+pJh
	 875eh/oLsY9EqgAnUQgy9kzVgzKMxM2Y78mKN74ZtDEtkDfoA8NnxG1+JHoKrfoIeejNm
	 J9kBsJN5dDku5J/45puBPI+2jeHv8/67wQSMtUivRYlTLkYhQSriqrhu0IrofTfkd3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=eEi4Cxmtvez/mBUi4eznPoU/CcbHOpGSzjw4nibALaU=;
	b=eTo11uE7+fe23w+7gpd2DYzqdzzV8OnpfVXzVzYII8hBUFuA8ZXP9c2ZqvSkMnKGG41V
	 AR7/rz5XuTnnqglzAC9nCXP2sWv4PypUygBtFKCktoWxePnNAvOV/slz4WAWgYIyFbkjv
	 EEaOxbVBNWZAwlK0Qt7FLYxywvLucGyVYIcGZHC02/Hri14ww7vGJ/AgLBJLijO0plG1V
	 +swIwdW7Yai0E/uY2xjQRpLdIYFHnBf8EwNGNozzC+7KCTkQlbAGQXYs1GKWtnmdhWO4h
	 BDQmM59vElw7wOEG6CFe7iOVDnnNzIRz4+RUUWbSYiJ1mlMXayL0+T3P2Z4SXmkid4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJdf+Wdn;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954F606A32D
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 00:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7954F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJdf+Wdn
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so142881a91.0
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752225; x=1794357025; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEi4Cxmtvez/mBUi4eznPoU/CcbHOpGSzjw4nibALaU=;
        b=xJdf+WdnS3QkWuxxYKiGaImr8aju7YkK/H6nHecyDqzJfqISAvGKm6hQq49T4p5PEM
         a/ah0P7K5K1TCOxt3DchlMZXs1+8JsQxrpXcQyjbMXObAkTyRS53Ibjqg47UeI3K60iw
         F4pNYUeK7JAU0NJXjI81hQXZJ1vn4l3B4Da6mSafINK8BPUYIi8K0bw0UncRjhmK2gpk
         yuE8dZqTYJpGM2LY1I75Tow0ov8xcqrpNKAfqhlPlhFYwI4FYtknfnNqlAONVHsdb3Ul
         ngZA7mO+SvFw6aKzJVv/O9hiDNyxxiqKKf4SULvN3WCbHsOc3Bn3R0K2R3haDpJW7hk5
         QS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752225; x=1794357025;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEi4Cxmtvez/mBUi4eznPoU/CcbHOpGSzjw4nibALaU=;
        b=rMks0Yv7Bm18/fWw8pcerri/3CmXDBvYiwdnj0f423Xekuv0daXwTZEuS9Mbi/WjKs
         pSLCZVZ2Eab/sZbT5S15XepmpoiBAtWzHwoE4qaU9AMjhHwzSCaZcFn9/oG/FbSKRfWz
         y7Jsfh59JfZP4spqUXNP1xFf23XtGcHW/Q8HArK7hNzC7Hw6Z5lpP1CGJwGWWz9g1vfB
         /0P4amvhb1UuNrZuNfZAj6MgHHsPV0CuDTfMvCOsgJ8mzm38tZsKWjHReYNkQNBgzW98
         Zxd6Fbo6O1vbrh5qhoGqSQFlvULA+cDFG9dj/AucPvVCNlrO2rBOP7u8oV8jsAz5wI+e
         5WBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwA3FTKNswkTnZi621W8L2BaM5zarsJLyfpdlcMOzsjaQXAjDX+Cuf57StOrFgF7eRggrqNeQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9WvPpPDWlZEJcWSl4QQvHUYFdgf0uARILkQlU738TozNki3l1R
	3giE5S8XtSXmIhQcLYhmD5F+HF6LYP3coDqi6DK0v5tMgh31FlxJ1q0A
X-Gm-Gg: AYBFou3F0bDyEQqiOzwN/I4uOzrZ58uiIU99H8ZF5z6jhYM1EuA9A+ltWXvzlrMRQQn
	XRvOHh7W8hvaPztHOkCZs7576gPOXNjyqsQjCQ5+YfcWWQwADcp1kBNkFOZ8QlnClZjg0/URKHX
	As13m2EtCiU9nrKyCFcbqUonRcjNwqfRtRfzyP1QVEoZwRtpjcX3qNEjg66XAHzcv9SRmCeNK4W
	1P6gP/L2/2f/+teZ+55yWDVhxlsOfRmKzY0IwNm3ZY1ToOoiTxp4So4lqRzCm1BQJZbLyOvcrpL
	c6yvI4QX7PdeM67kw6BCQ4D8q/ohMhINKO7hsIaG4Qr4PszKt+7BGFJBYltENKvvQ6LDtrZRXP1
	uHMGe9Mq6mwDzVuxJ+YkQZ4cEKZbVkKPtbSpxdXA8aQGrcO1J9T9WU95A4eIk4FEPYGVpTM1PG9
	sfXbwpWWLT676OabdeYC0PADsZvFOeeB44NfSiZA8pSrrFTZ4H2tX62b9CfE5jtcaqBvXFrY7ES
	iMnDTFwPTwnxIirDnsu61J45PQY3FMD+y6vmYH0SOJAT7cii1hZvIp/qFPtteAXQIGute4ttZHn
	nJJ6lZCjZ+TUyFN6zLCxLZSoMcExjvgdQkik7VIpHNspBg+thztXbcO+6dDOqr8l82hBBVVBl1b
	oOy5xuY5TvTPQPUoC91Gr89DItj7LVOd+Xg==
X-Received: by 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3ae897aa7aemr12306124a91.49.1793752224515;
        Tue, 03 Nov 2026 16:30:24 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm636905a91.0.2026.11.03.16.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:30:23 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:30:22 +0000
Message-Id: <DMM03F7F8IDM.VMOKC4RWW2LV@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 14/15] bpf, sockmap: Keep the rest of the cork
 after a redirect
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <179374188416.488855.8465787275984951547@kernel.org>
References: <20261102072112.4160195-15-alexei.starovoitov@gmail.com> <179374188416.488855.8465787275984951547@kernel.org>
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

On Tue, Nov 03, 2026 at 01:38 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
>>  			if (!cork)
>>  				*copied -= free;
>>  		}
>
> Should the cork case also subtract the freed bytes from *copied and keep
> the error?

No. That's deliberate, and the commit log says that it stays. See
commit fec51d40ea65 ("bpf: sockmap, zero sg_size on error when buffer is
released"). A cork has data of earlier sendmsg() calls. An error for
that data doesn't go to the current caller.

>> +		if (cork && msg->sg.size && !psock->cork) {
>
> Is this case meant to stay out of scope, or should *copied at least be
> reduced by the freed tail?

Out of scope. It's already explained in the commit log.
A smaller *copied alone is wrong. ret is 0 and tcp_bpf_sendmsg()
continues with the next bytes of the user buffer. Then the return value
doesn't tell which bytes are lost.

> This isn't a bug introduced by this patch, but putting the tail back here
> adds a new way into a race that already exists in the SK_PASS branch. Can
> a restored cork be freed while tcp_bpf_push() is still using it?

yeah. It's an old bug, not from this patch.
Each SK_PASS on a cork has this window, with or without a redirect
before it.

> Would it fix this to detach psock->cork in the SK_PASS branch before any
> push that can drop the lock, and attach it again under the lock afterwards,
> as the SK_REDIRECT branch does?

For this case, yes. Jiayuan proposed to serialize the senders in the
reply to patch 13. That covers this case and the new cork above.

> Non-cork messages already have the same accounting problem. Should
> sk_msg_apply_bytes() be charged with the bytes actually sent rather than
> tosend?

No. The verdict has to end before release_sock(). See
commit cd9733f5d75c ("tcp_bpf: Fix one concurrency problem in the
tcp_bpf_send_verdict function"). A refund after lock_sock() can land on
the verdict of another sender.
The prog runs again on the rest. Without this patch the kernel frees it.

> Could a test be added that checks how many bytes the peer receives?

Right. test_sockmap doesn't catch it. It can be a follow up.
