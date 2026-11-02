Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648198;
	b=QAaNHzOAOsaWzvP0v4wJH8+CkGa8grJsnFw5W6c83Z4aFxQ9RA3S/agGQciWk4PKOlb1
	 OBxTWvxugfO3X8NX0/dxNZjlXrUrQlnEHNmww83+Pl5nxdzgAIDtu9PHA5AS/8qrPCxEV
	 vB2FplcfJrux505u8bypXbDOpYb08tAcpAUEVMv+/b+nt9UXSz8QJ1vfmGkaKjBehLiQv
	 UNL7x2p1+bLKnGU1GOw4CPS7MB6ka2xjwA7BfaZuv9YLESJesN18/nJnKydmzjIrowGT+
	 Sv8MjZbaZhGvO9lIJq5jdHEOBenCp2COFhZ4zUMD4Y12ZkJ7SQBx5QoLlg1HTlrY/uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:User-Agent:References:In-Reply-To:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=z+7iqYy4OkIb8W2YjxUcaoM9qADwsgWhehmQGnSdoNY=;
	b=QaG8pVzcpdLco/UyKcG8E2PdKmhLdu7oCZjFH0ZEulzw+52m8UA9bwXfmmsds9aWu4mG
	 TI32qm0PP4bJxCLa5UdQDebmvSbpcVzHbsVWFWV1VKeBCeWpw1jlfbfzJrpoLdeUc5rL7
	 bUsaTuenCCvso7D2zwVtEy26qVWkjZPb6qpcHRQ0rOzVPteAMCBMe49aQnfL3p8v5VZCM
	 xdlhui7WC6n5FPJ2XwxHlEye+i6iKYaQbtggJ8w0XF6Ef1oGqeyw6jLZ6yOJZTtbjqv/y
	 +bRk+cVo7ujYO8hG0J3xnJ+cab4x3+G2RV32Wrxa4Ehe9Dy6yOPxk/1cXzP56uNGtMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k65se+Hf;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B5606A32D
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 19:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738B5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k65se+Hf
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e985106c0cso32104955ad.2
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648198; x=1794252998; darn=lists.linux.dev;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z+7iqYy4OkIb8W2YjxUcaoM9qADwsgWhehmQGnSdoNY=;
        b=k65se+HfcTxqWijElxGKrVvovHStL0g2rGZBhCqKKTs8Y3oHjkqmlbqIyOWCPbLUI2
         ifEdPLkdDVuEk8dSu2pX+c/I24O8NloNLJAJWh45iz5V3in6pDXZ8xqLRTWNUOuQdn+R
         MYpFLTWtwz/EIMzQl4agPDhSHGpLRkhCZ9/t7LUfVCMD0JqaWkNlwOsJIx7uN+jN8kZ2
         aZTDP9yKP+0XlEk0E2qgGaWgDb2EX10Tq5MlbsEY+eDMjFM092A+CDAN5xTyQWVLBUDg
         FD7/Bvbg8szYVvjmT9VR8AMWB7RFi/PVu/KiGzIAcx+X9bQ0tBSQrzX2mnNlXrMOdlyR
         xCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648198; x=1794252998;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+7iqYy4OkIb8W2YjxUcaoM9qADwsgWhehmQGnSdoNY=;
        b=1DbwugzKrmPgw7wXv2IZXehbq4M5K+Eka/tQv5kgIBHLZt9u6N+/hMn7L3ua5Jn/Ry
         VsZK117g6ii4sff8VjqFjN3tgCpuL4jRZvXzPFpX2LpCzxd09l/g4E5HjdfexAd13T3Z
         uUIFyUUMqlhwDojrk1YkYMLjy+FkOs0oRJ5/fy69IXhgVMzdZw4c02CeBWcgZTpaM5AU
         bEp/EMa3WTi7BQVQ0EiRGfXTbFy0coxQmtg10BJikX7RDl3MsjqJXDdHtGm5x3qA2kHC
         dJG1HcuPrHLvrwTbNxD3piIxxcdmtk8gKUUd9z/j8+4XW1XzuvBlgLAgqaWsc0B6/JzK
         RVsw==
X-Gm-Message-State: APuU4Z8FdPvvcHW4SYfjhbqMsuribZQ3eHPNkNs/8Z2Vb36k11E5/Iyq
	3y2s5NkwZldRAlAEj9YTtHUKLwmkqeBwBvJjGQY/ZpIUvvSwhrkp/Z0EYWEgvA==
X-Gm-Gg: AYBFou0XHGuqDHipCg3EtGx2gQZ2tz5o8AEXLNLKt7ggGSk3MDSEsTGA8c/pG5SHUQb
	dxp5l0DzTFzcuXADkPYIZEoLvqH75/oVu+Fv2/gXErfFbwAF59+TM18W6xMDbrezc5hjh7P7YQv
	BqzpBcT/gMUF5z8jE1mSfqkGcMyp8oY7ihybse4wpQmfUQIICBck5nym/CsiQ04/wy8X+wBOiyS
	Swxv0MYdkvMsOVdqFaHR8Mi2DwBSl9ISgTn5hxgAkNbHNP/PtmeIkcGSzH5Vw6p3HD0F8wY7nJ6
	wCxKzXsTaggYXI3IXo83ywxK21lEfYXMCLZD0dMmY5mhZabNBb0fQIqicHO/ZUzU8Rzg/JgE1sm
	R4my9wYXpjfjOHZP/ZoZFikZPzkWkS58XRj+8FBrVGmLfvQKnwySyCvgRSQUTYKA2B5PJI7uRCK
	325Tb5ENBPaR54v77o0pl/7YWODIrXlASJato43rwUNUQqxQVC57SQ2+3aWA+3yDTjD12V9mgR4
	6VmTL8fIbJlU3x334NHFYI0vlb/NfAJHCWOhq+/8DLvYKZ3e+qufPH2T7FlF4i9qILPyHBvhfuh
	1TYp+9jz6BM1FFCHJFjj3eAk0I7Z244ZCB9qdfFBUgmyjPSOcytQwoIGkfJ3kolk61Qy
X-Received: by 2002:a17:902:e5c1:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2eb36414ef0mr104248555ad.5.1793648197830;
        Mon, 02 Nov 2026 11:36:37 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392965fesm31536785ad.59.2026.11.02.11.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:36:36 -0800 (PST)
Date: Mon, 02 Nov 2026 12:36:01 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an egress redirect before each send
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
Message-ID: <tnw3t0.mxmnzrgt0n6o@gmail.com>
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
>tcp_sendmsg_locked() expects a caller that has the socket open. It uses
>sk->sk_socket and the wait queue sk->sk_wq. For an egress redirect of an
>sk_msg prog the sender calls it on the target without a reference to the
>target's file. Both pointers are NULL before accept() and after close().
>close() can occur while the sender sleeps. Then the kernel crashes.
>
>Fail the redirect when the target has no struct socket, or when the sender
>has to wait for the connection. The error is EINVAL. After close() it is
>EPIPE, as today. sk_stream_wait_connect() calls remove_wait_queue() without
>a test of SOCK_DEAD. sk_stream_wait_memory() has this test, but it can
>still use sk_wq after the sleep. This patch does not change that. The
>target can change while the sender sleeps there. Thus do both checks before
>each call of tcp_sendmsg_locked(). Clear MSG_FASTOPEN, so that the sender
>does not call the connect code of the target, which uses both pointers.
>
>Today the sender can send before accept() and waits in SYN_SENT. send()
>with MSG_FASTOPEN sends the data. Today it fails with EISCONN. When the
>redirect of a cork fails, send() returns success and the kernel drops the
>data, as today.
>
>The Fixes tags are for the two checks and for MSG_FASTOPEN, in this order.
>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
>Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
>Signed-off-by: Chris Mason <mason@kernel.org>
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---
