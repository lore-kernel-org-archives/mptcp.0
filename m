Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647911;
	b=AQOuZ2c6hEGLUOASpn8b0Qgc+EXeYSjbSSf+ud4ZmUPpCzMmP/XJzTOzf8nJbcbyMR/0
	 oPn6A80T4xnlCBzMdN9JCOXOKsoaP9mzxuUURijp8Sv5vNxxh8ngEfPvoS2Gf5Mgz1zRm
	 bIosNyJUni21lOB71vMNUbT3erQtYfpX8jICKbQnpDV39KbMlfjczLBzalSMpBH0Zg4AQ
	 0efGEQoKe/56cJfoSDxJhkUa1fsMxH4IGuw9ZXgIEciJo/YhtYHTqs6D4pBCYE5EHcblI
	 uowGEXXEiLxKA76uAKxvFli9l0B8kW4lJ+qmbQ0C532+MdSMfiCzQ7doGJVDPqZXYlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:User-Agent:References:In-Reply-To:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=17T5xkmwSXx3rxRgsFuuietPjSf4dCY3suvqmMRm7Q8=;
	b=5lSNdLhr0p8cV18Ouwh8F1eLb8ODBTHUTeqx1PSEeIO5m9s2ur+iZlGV6vkz1pJGDY72
	 mXZfTXlMk7o6isj0HuYvhP0Sv7ORec1L6GhL9vwiPEk0g8JAji/iTkpPhIPPzvBgOXM+r
	 cVINKVZkAeiiwwcG1Lr1AbCRZ4sT5dPSsnDTR6BO46nKLz0xBk7tId9WLC3RbIPmMD+Y+
	 9lo1emXuvZ8s/3m833nk9wSh+TCbiBZq3Mc2a0qsuLnVWN8FtdmpS4v8aVMBIbZjB+OM2
	 3PowKuwzrXxui80ygTGKJ/j/eZ9OXjg/+/JpZsvMWaSkLcfK5Qeb3kkOdzk0AzjmdHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGLf7mZj;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD7606A327
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 19:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33DD7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGLf7mZj
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so2657453a91.3
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647909; x=1794252709; darn=lists.linux.dev;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=17T5xkmwSXx3rxRgsFuuietPjSf4dCY3suvqmMRm7Q8=;
        b=nGLf7mZj21x3uOE8TOar0krrQb2tKohnpe71QXQTd02nWVypLnKhNjJuR5MtjgugWw
         nCgAJ8OR5saNSa81SrCTVHFSL0M/xvo476hOYwYa4oAYWcFYZi3mY6cjNaxsa8gkbK1K
         vyY0atWYzDnb+ERgVJbNIneTkMO1nVh4kVLW/5QnVTSmFNHe+xERTygFaQ9UnwSflYJF
         gQU2jiK59GGqCFwBHBsgDJ7oXKhT6I1isz3k6gWsSSwiqz0oGzUzJVEZDXToACL3jN62
         tIuNW++ScbxgDCd9hlpWy/lxv484V7dRczQ2GkQVRH6/5I6O2gvtzR5UUQVBlIh6u83z
         ISgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647909; x=1794252709;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=17T5xkmwSXx3rxRgsFuuietPjSf4dCY3suvqmMRm7Q8=;
        b=U2oeyBWTpYlTVAzRLMlgSSW3sPV8sHE/inASLZHsdPfjB/dzs7ge/QiFT0yzbyQd9s
         hscAPBAA2GCPgc8dgfMbcZWcVXjFZiUbwSm9nWaZnhAqC+zZZmKXvNPBK9e68oaLwNG8
         BF8JJmuLMiCowSa6NuVAw7gYUj0r0zOuHa0g9FB4vB+gstAPvkKVtyDgcWzpnok82Xl0
         Xb72OnEf/7Zb2rQmeRlbMgUr8qjlfYlBOrRD6aoYZPtjO97/RKLCPi8k5V8M76k3Fxak
         OrjTmFJwVX8gdz60zY3N/tJbaoe0l/Ua2xNaP1y3ePr98J44hLw7wkqjRYySF6nUWX3m
         qocg==
X-Gm-Message-State: APuU4Z/kkJY5LX2RgbCY3KJsDoZWnYqlLeEItfk41XoSHYh8Br1HK+/l
	U29b69i6Ocdq5RpVe2u/zVq6O0kuURN6qfiu9TM9cp6DaNTCgXEReOMnVIUMmQ==
X-Gm-Gg: AYBFou2bKFBR6LvtE1SIJqvAu2EKn+M5DYUQn6Jj9SW6k00PJeennyHiAW4DfFyf0ip
	v7PAIoRTrtCbjCA0lV5CUsnAdAuBN+oaDOQFyiS56m7wV48Ua0HGVRLmxTenU8guVzBJNydmT9j
	DkWMmMQ1IVTihUpOevghnx18b3AyKTnSzky3agP5AnOlmwvqy0pvBN7iBz4tTUD4enyr7193hUA
	WjzVF5iReadXjUDxABrqKcfb7pMK1NxcDkruzSOzosaVZo08SxCpQB0/Vfj4nKNWna9OooIQhTD
	nDg82j/P/pf+bJWxmo9ymoZxDPTLX80RVi2AimvzObVjdFkJUpwtypjNNkXQTjbpNZvRJoARwKW
	o8B+FB6atPLlrx0yP+Qxc2fLxJCp7muw1ANdu6h2zWc9G+aWPSnBN7fbK2bCqoWuMc3/OzWqXkk
	fpFpupYwBm+w2hYbQzTHm6Fc9a2vaMwpVBu8zHmqpi7PmCvYAjd82LQjssczQXk1bzmlHATXfx0
	IPf1kR7DoYNQlapa6XpZgQCbpJEFVqziV7aU/1NbJKTLD9ZRGu9QLnQwblBK6rwPuPD/Qz/rFPi
	0gy/fyHZE/h5XxvUMr/9JchCefDqECNdejWaznxVh+yEOD0AXljKlw8c/k63a0xqcUzQ
X-Received: by 2002:a17:90b:3c08:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3ae89812f18mr9476854a91.37.1793647909469;
        Mon, 02 Nov 2026 11:31:49 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9928d1sm510981a91.14.2026.11.02.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:31:49 -0800 (PST)
Date: Mon, 02 Nov 2026 12:31:17 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP listener
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
Message-ID: <tnw3l0.2z8ao1ckh4em1@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:21, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Chris Mason <mason@kernel.org>
>
>A psock with a verdict prog replaces sk_data_ready and sk_write_space of
>its socket. It saves the old callbacks, and the new callbacks call them.
>sock_map_link() does this to a TCP listener too. Its new sk_data_ready
>cannot read and does not call the old one. Thus it does not wake accept().
>
>sk_clone() copies the new callbacks to each child, but not the psock.
>tcp_bpf_clone() restores only sk_prot. Without a psock the child loses data
>or does not wake its reader. If it gets a psock, the psock saves the copies
>as the old callbacks. Then sk_psock_verdict_data_ready() calls itself until
>the stack overflows. sk_psock_write_space() calls itself too, without end.
>
>Give no progs to a TCP listener, as before the first commit below. A
>listener receives and sends no data. It stays in the map and keeps its own
>callbacks. Add this exception to map_sockmap.rst. A listener no longer gets
>-EBUSY from a second map with progs of the same kind.
>
>Since the second commit below, a socket keeps its psock when TCP unhashes
>it. sock_map_link() does not see the state that the socket gets later. Do
>not depend on TCP to keep such a socket out of TCP_LISTEN. Set both
>callbacks in tcp_bpf_clone() to the TCP defaults.
>
>Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
>Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
>Signed-off-by: Chris Mason <mason@kernel.org>
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
