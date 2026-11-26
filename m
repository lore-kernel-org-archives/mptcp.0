Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688462;
	b=0pXrhH8EX0DRUeXaTHcbWS1/5x2sZLafjC+e7h/SBHHxXf/0z2B3PW2Zz3A2iFpnUwUM
	 mJWpPCDUiJUKbsNwZVkJRfmQwegU6ex6G1seho8rxeqK/6G1caqpgKfHoBnB3h72Gnfjn
	 15R4P+XCqSHAD32xbNZANO0whEp3BlVE/jSm+S35hGMm6ApflaP+OkKqX+8xRJxbFCZF6
	 ijPsfkWAE/g+cHclC4mXDdfTTpH+QPlLueJ8/1MiQn6BjTRWYJn40wYg05fIV41Eh01oM
	 KhoNp2xmoaCUa+a6mQF1uT2ollcRg1Apl//j5ibpZ0VBn0RG551y63wvuuoGcdw/NCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Dz5Obh5lP0tOLHLiHWSWNzgVimL59XKVdrhzCbJPLAQ=;
	b=ii8SfX1TbvFUzmXlnJeCgMIdrKz66Elm6JzRQaZgWUUCtjZ3faWGeNlg9LXdJ/6+HZ8w
	 XFVzSa7ac+5dWgkS+CxT2ECJzuGwyLLl5Jlx+KpcY7F1X/gaJxw8dEDb8nVNRZa2BJUBq
	 USBhbqDBuqxONLtwXFv0ze8tS6MjU3x2xE2c4vylO1E7MaqKCb6MYNJ6nDUMvO6uPB038
	 ebO/AXiOA8qlPUe4RpeaQ3aacyTfQNph5DBOWK9pwBdKB715HTedNTTgxzM/ItYVJK9p0
	 mf77zjy9bmFjuKo5/bNp3lA2MTtaVoLDP9jbrP+u72MUQ9iunEY8SEK1XvvTA1SbzZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPqmfLMn;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D8606A327
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 10:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 444D8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPqmfLMn
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e46e449e8so4437564f8f.3
        for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 02:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688460; x=1796293260; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dz5Obh5lP0tOLHLiHWSWNzgVimL59XKVdrhzCbJPLAQ=;
        b=SPqmfLMnfsv0ebnmIedvGW26ZlomCjeSWJj9fL0s8Gb4b0WuCd+Apa+QlYjlCPC11i
         Jnh6Gtp29leRfu9Dsb6Ka0TL+oGx+fJrbYciUCW2HwUXHKeQj5+FQM248iobmHgeNXls
         1NdhnOWTevMCT52HLV5V8rG10ECatNK3vWw4LFUooFnxNzN0Zd9llKx8VXUFLZZpfUy7
         FgvR//1jt/6ThgNlcyeilPTLUTSaNyvywQB/2cew2y0foXRz0ArGBHSQuSgoxBBRMIL9
         XJyuR5qJgPqXUJ6rxfRVFgGLzLDRh8Ltamv7nXvy3wgVsR9ipDNV5rxSxf6g6OVf0U6K
         uikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688460; x=1796293260;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dz5Obh5lP0tOLHLiHWSWNzgVimL59XKVdrhzCbJPLAQ=;
        b=Cogd+h4Mzf1zpTQQXNcSU+rOKgorSgaiE4cp3zLU0DGFzuzU0hs+Rw54Kcv48vV9br
         zA6pi8COITVtXN/x5xXBqHHPWFvQmChvB2cEwo8yMXeEy4DIVvixMOm8SpISvFC5MaX0
         uviuVOwaJ8l0FmQ2Te4FYiinbmiyzS998v34zH62uVja50otFt1m5gDDZenqeIxh58y4
         k/yd93oEiYyZu4dOIVFRoRqztGJavHO0g5xJ9waOm+JC/WME1wZzKIJXXa77GHAROvIl
         3D8nN2QmtzhLoSdq6wbV9+SV9rmpwSfLL1WZXetrWNwYHZGzLGKNizacABEyFQPyYBUs
         HY8A==
X-Forwarded-Encrypted: i=1; AL+hErE7sNaudJ0HzTpSR4id8q59WCTFRrWP5vwZh6WA9oLz/kvWfLsrzRTBJR18Q50ZwydRYXg5KA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+u7MsZeUFjOxOQ/Hhk1F+t/5KXuiM8VQjzMySSJMDdkbYvWk/Y
	mNqN6TuiTj3xtVjRga4aP/BYjL1B/jMUhObM2juf5l5QysHVEgQB7k6m
X-Gm-Gg: AZFdTZeT8ol3lcdaKTqFdiRiENfVhM8m09CKoViYRkm5RgR5GQE3peLTIYTd4Xyh0Gp
	W67I9IV4gFSv+8xhom2oMe0GnFO0qmjM3z5R8cHUzQEZ6BnotF/E2Tnrj34eCXoxOGmcRy6flP4
	HjkKMEZ3wTcpBo+zbnbj97VLAp9QrJPBdNlBXALrQPlJ0Jhyy5UrazGdgdRoNZ2MAr5xn5jGtf0
	9bratfxNe3bF9cXzWcgYVhcvgTxKMjI9zJyObIVzOpwjL9/Zdp6v3YhOKTMdCGIJ4fZufQpK27N
	ymWKwbHf7CYEtTQ1p+Sr41tu7atDb+5ZxowIZRi30MvnJ744q/V0TwnRWgwz35GGli9nvBQY7c1
	7AA8RQRsCqsMVvPFPsoJjZ5k7yuFfTNpqB/OvBonept0a0X9YJmdyILFvCuUZvGfTMRubj8eZ/C
	kTkuiB/80uanoyGHXUZudRlkdylyqTV5ACI85XolC/+rk+5o4YZUasNNlsmObdV9HHo/meHtYKM
	+wVtC2bc5YcUPcH5F8CiX+HF7+amSZ5oPOcegA9puTm0NxpgExFj+91sDwQh6jZNCwQ50BhmAas
	/BtcNV0Yli36dVYLyj4Dy/trzQ7CEy32/Qs/WPPBfBGwjWY+mxE9kyYlqH1qoh6Vig==
X-Received: by 2002:a05:600c:3ac9:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4bb887e068emr432378915e9.3.1795688460499;
        Thu, 26 Nov 2026 02:21:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm581334935e9.5.2026.11.26.02.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:21:00 -0800 (PST)
Date: Thu, 26 Nov 2026 10:20:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, David
 Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, Xuanqiang Luo
 <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net-next v1 0/6] net: avoid stack canaries in TCP/IPv4
 fast paths
Message-ID: <20261126102058.1fecf50f@pumpkin>
In-Reply-To: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
References: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Nov 2026 22:06:25 +0900
Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:

> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> With CONFIG_STACKPROTECTOR_STRONG=y, a function that has a local array or
> passes the address of one of its locals to another function needs a stack
> canary. The canary is set up and checked on every call, also when the
> local is only used on a path that almost never runs.
> 
> This series removes the canary from functions of the TCP/IPv4 fast paths,
> by returning results by value, by using storage that is not on the stack,
> or by not calling a function that has nothing to do.
> 
> Patch 1 returns the two mptcp_space() values in a structure, so that
> __tcp_select_window() no longer needs a canary.

While all (I think) architectures can return a big integer in two
registers (dx:ax on x86), not all ABI do the same for small structures.
For those architectures returning a struct by value is implemented by
passing the address of a hidden on stack structure.
So code generation may be worse than passing the values by reference.
I can't remember the list of architectures, mostly old ones - but not
32bit x86 because the compiler option was set when regparm=3 was added
for 2.6.
(Note that this is different from passing small structures by value.)

David
